Return-Path: <netdev+bounces-56054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BCC80DABB
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 20:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACF31F215E5
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045AE52F60;
	Mon, 11 Dec 2023 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbELKwRc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A751C37
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 19:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728ADC433C7;
	Mon, 11 Dec 2023 19:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702322259;
	bh=77eGaT7+e4B8NXiu1rre0Dw3j+0iIpvKbJ/Usic4BIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QbELKwRcLa7z9vOtLW3b6O9sGsOGgA65ml199PSPNaUxSMSP20f3rtQemR3Fc2MWD
	 p8vzMg2HZB11s44ZqwXKl3a6WYhjeDdYwZrOVWnVjnNenY3iFAYwJxWWPhe2Y09yDN
	 kMKNfUt0SLwQPkkWz6a43g9TqYfbcGTC9Q/sPCr4rhrxff3PlWdHieaeJifVWvSMmY
	 8sXvuyLzLUEQoqt9Oa3pH05QZw+WXZzZiix0JE52eSXWcGJbTlxoKLQ1WN7NUxJ5Aj
	 amwMECT5Y7zEGP28H1Lrsf1/Yc5pvdPakYGc7n6r50xRNNLBH7G1BXpXMCOOk2aiEO
	 RYQ7oerYikAhA==
Date: Mon, 11 Dec 2023 19:17:34 +0000
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com,
	Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: Re: [PATCH net-next 7/7] sfc: add debugfs node for filter table
 contents
Message-ID: <20231211191734.GQ5817@kernel.org>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <0cf27cb7a42cc81c8d360b5812690e636a100244.1702314695.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cf27cb7a42cc81c8d360b5812690e636a100244.1702314695.git.ecree.xilinx@gmail.com>

On Mon, Dec 11, 2023 at 05:18:32PM +0000, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Expose the filter table entries.
> 
> Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

...

> diff --git a/drivers/net/ethernet/sfc/debugfs.h b/drivers/net/ethernet/sfc/debugfs.h

...

> @@ -63,6 +67,45 @@ void efx_fini_debugfs_nic(struct efx_nic *efx);
>  int efx_init_debugfs(void);
>  void efx_fini_debugfs(void);
>  
> +void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec);
> +
> +/* Generate operations for a debugfs node with a custom reader function.
> + * The reader should have signature int (*)(struct seq_file *s, void *data)
> + * where data is the pointer passed to EFX_DEBUGFS_CREATE_RAW.
> + */
> +#define EFX_DEBUGFS_RAW_PARAMETER(_reader)				       \
> +									       \
> +static int efx_debugfs_##_reader##_read(struct seq_file *s, void *d)	       \
> +{									       \
> +	return _reader(s, s->private);					       \
> +}									       \
> +									       \
> +static int efx_debugfs_##_reader##_open(struct inode *inode, struct file *f)   \
> +{									       \
> +	return single_open(f, efx_debugfs_##_reader##_read, inode->i_private); \
> +}									       \

Hi Edward,

I think that probably the above should be static inline.

...

