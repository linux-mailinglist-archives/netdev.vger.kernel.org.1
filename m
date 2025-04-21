Return-Path: <netdev+bounces-184387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D001A952B0
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 16:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2587E3B5066
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1BA19C54F;
	Mon, 21 Apr 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRzmWdwI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDAB19992E;
	Mon, 21 Apr 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745245514; cv=none; b=GCJew/MkrKbBBP+EhuXMKVfoW36h2meUJTjYFHVB7ETTUmlw3sdtSznIME4EKFVUB/s/hm95G3KnirVWtMrHM9Y97eJzeRWvW+gsgCtQz5g6mD5xBbjH9UWwNnYyC/jHfDYS2s7hD5wht/mz3YGJaGVFSn53L9VPMOnoNBNdOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745245514; c=relaxed/simple;
	bh=FdYxttsgHP90vBH9XqpB/T/Z5nUrxOeI5C8DCpAL5Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkrAYv1wae1Tr+m0Hi1s8Y8O0zu+pwlYXLT9K+/YW2+tUmRKcnq7DfT0WZeoJBtC8U69jaGDtU9z1x+AKAepNX/E7GdZqEjTw+9PlCRc2w/CrefJzoXTdRzxBWLLhXh3XZXjcRfbwvr8lgNdWGur24B957eSQLwPaP1zbH5jQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRzmWdwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAA3C4CEE4;
	Mon, 21 Apr 2025 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745245513;
	bh=FdYxttsgHP90vBH9XqpB/T/Z5nUrxOeI5C8DCpAL5Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRzmWdwIH8tEjTP8WI6UVJZx8ATwrBZU+0OmWQjvIgfFBVgUeoE8JFD6DXvru4ZdR
	 eiz8RRhtXIGUCIlKQhI3fXZZbflZO6aPncJWcsM/XT+dzzDWdBVDu9YEPILXzl1JxL
	 Vv21nRhJg70H9sfDT2sUxBb5QKurq8jzofOYJp1sJHpgJTGbP9VveQHCK9kNXKKXTc
	 HXhRro33364j/tDRUGTlLlUIuAUWkGFJOiaX6HbyJarA1ejRJErt0XU7MZZZTBONlW
	 f+36NBJcVjq3iTl0cSlh6xjLRis4Y5ThaOabKH6W01ZyNXvA+3trDmFm5luSrPvdXd
	 9GBtgtYD0m3qA==
Date: Mon, 21 Apr 2025 15:25:05 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wenjun Wu <wenjun1.wu@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-next 08/14] idpf: refactor idpf to use libeth
 controlq and Xn APIs
Message-ID: <20250421142505.GJ2789685@horms.kernel.org>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
 <20250408124816.11584-9-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408124816.11584-9-larysa.zaremba@intel.com>

On Tue, Apr 08, 2025 at 02:47:54PM +0200, Larysa Zaremba wrote:
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> 
> Support to initialize and configure controlq, Xn manager,
> MMIO and reset APIs was introduced in libeth. As part of it,
> most of the existing controlq structures are renamed and
> modified. Use those APIs in idpf and make all the necessary changes.
> 
> Previously for the send and receive virtchnl messages, there
> used to be a memcpy involved in controlq code to copy the buffer
> info passed by the send function into the controlq specific
> buffers. There was no restriction to use automatic memory
> in that case. The new implementation in libeth removed copying
> of the send buffer info and introduced DMA mapping of the
> send buffer itself. To accommodate it, use dynamic memory for
> the send buffers. In case of receive, idpf receives a page pool
> buffer allocated by the libeth and care should be taken to
> release it after use in the idpf.
> 
> The changes are fairly trivial and localized, with a notable exception
> being the consolidation of idpf_vc_xn_shutdown and idpf_deinit_dflt_mbx
> under the latter name. This has some additional consequences that are
> addressed in the following patches.
> 
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h

...

> @@ -488,7 +486,10 @@ struct idpf_vc_xn_manager;
>   * @state: Init state machine
>   * @flags: See enum idpf_flags
>   * @reset_reg: See struct idpf_reset_reg
> - * @hw: Device access data
> + * @ctlq_ctx: controlq context
> + * @asq: Send control queue info
> + * @arq: Receive control queue info
> + * @xn_init_params: Xn transaction manager parameters
>   * @num_req_msix: Requested number of MSIX vectors
>   * @num_avail_msix: Available number of MSIX vectors
>   * @num_msix_entries: Number of entries in MSIX table
> @@ -540,7 +541,10 @@ struct idpf_adapter {
>  	enum idpf_state state;
>  	DECLARE_BITMAP(flags, IDPF_FLAGS_NBITS);
>  	struct idpf_reset_reg reset_reg;
> -	struct idpf_hw hw;
> +	struct libeth_ctlq_ctx ctlq_ctx;
> +	struct libeth_ctlq_info *asq;
> +	struct libeth_ctlq_info *arq;
> +	struct libeth_ctlq_xn_init_params xn_init_params;
>  	u16 num_req_msix;
>  	u16 num_avail_msix;
>  	u16 num_msix_entries;
> @@ -573,7 +577,6 @@ struct idpf_adapter {
>  	struct delayed_work stats_task;
>  	struct workqueue_struct *stats_wq;
>  	struct virtchnl2_get_capabilities caps;
> -	struct idpf_vc_xn_manager *vcxn_mngr;

nit: Please also drop the vcxn_mngr from the Kernel doc for struct idpf_adapter.

>  
>  	struct idpf_dev_ops dev_ops;
>  	int num_vfs;

