Return-Path: <netdev+bounces-58173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC38815671
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 03:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D8C286ABE
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 02:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C05E1384;
	Sat, 16 Dec 2023 02:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSdL0LgM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628211846
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 02:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B4FC433C8;
	Sat, 16 Dec 2023 02:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702694307;
	bh=fiQgElBjGglhTyY5T6bFR1jveaxkcYaErenjoi+4TqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bSdL0LgMlnJ9DWoXXfy0KVPuU2PB/4OuqHX+3PPwgi4aeZ/sbWJTt05QGLSsNz1v9
	 SPibAMal7vaA/AsVnis6eR+AMpUb9BadUvqAIPJUzV9BJhAQROhtkkba2Y6B0qqKLM
	 U8tUNWrnMv39/tsw36NLFIXuHUctpOGPX2v3TRZ/CVs0DC45QeAHvqnRebxcy/O9SB
	 uGDVxvZydmVH0XC0fGtoKRFv/b4Ztog/DdxCPDyHMyptDwjaYbbghtvWZ4VLvwb+8b
	 eWwnX1FY4hjnLxKDo4+F2Dk36IWZ70EUYP3SYOQzsUwHrBgqTYRCKqZhuOc61zvkLQ
	 JR6BPFauQSjuA==
Date: Fri, 15 Dec 2023 18:38:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, andrew@lunn.ch, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v5 6/8] net: wangxun: add coalesce options
 support
Message-ID: <20231215183826.7bc82ef0@kernel.org>
In-Reply-To: <20231214025456.1387175-7-jiawenwu@trustnetic.com>
References: <20231214025456.1387175-1-jiawenwu@trustnetic.com>
	<20231214025456.1387175-7-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 10:54:54 +0800 Jiawen Wu wrote:
> +	ec->tx_max_coalesced_frames_irq = wx->tx_work_limit;
> +	/* only valid if in constant ITR mode */
> +	if (wx->rx_itr_setting <= 1)
> +		ec->rx_coalesce_usecs = wx->rx_itr_setting;
> +	else
> +		ec->rx_coalesce_usecs = wx->rx_itr_setting >> 2;
> +
> +	/* if in mixed tx/rx queues per vector mode, report only rx settings */

What if there's only a Tx queue? You'll report both rx and tx 
coalescing params?

> +	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
> +		return 0;
> +
> +	/* only valid if in constant ITR mode */
> +	if (wx->tx_itr_setting <= 1)
> +		ec->tx_coalesce_usecs = wx->tx_itr_setting;
> +	else
> +		ec->tx_coalesce_usecs = wx->tx_itr_setting >> 2;

