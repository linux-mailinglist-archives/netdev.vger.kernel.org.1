Return-Path: <netdev+bounces-116587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB6A94B183
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 22:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A462B248FE
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 20:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14BA145B38;
	Wed,  7 Aug 2024 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="CEx/5bhW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H3H9+oWz"
X-Original-To: netdev@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933F13DDC0;
	Wed,  7 Aug 2024 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063214; cv=none; b=GsdWM0mvs8riHhcM05RcQ9dLu8FC5ZUtneZtmV9UZg8sFuT2c6ync0iKjI0Ydqdi1fUQbL6t6pB5UGaryVi5Aa4Oceq/YTBDiK0U7FY6t0XjlW9/fWu06onaJm3M4VcEhV+hyXHdLuCPKlXHNveUp/EY8tdFDRnn4UoYimeLWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063214; c=relaxed/simple;
	bh=blkBUwuYNV1jdiG9n3ec84ATSv7sX+2uYwyxvMbrnlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kl/AfW0WQrk+CKdkyiGLLRZGyyRkoL4wsjwihFeV0gWRIYoUpqzVMs5pCr6Mz9pCnzVs1sbkRJtVaqQMtItc14gu50NcAeHLhnpwNJV8Axu9/ZH6HqnwsAENdC3PdP2KDVBcGSqfoQdiVeP0U1ykYztryVCdk5jkQXEgsKAlNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=CEx/5bhW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H3H9+oWz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id EA886138DD80;
	Wed,  7 Aug 2024 16:40:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 16:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723063210;
	 x=1723149610; bh=gcQqS4Nvw3oVR6X1QO70/HzE1Wr/SNsmwf90YobtWTs=; b=
	CEx/5bhW09PdllSKPc+RQvB5sAQJMIjAModMHZtf4adcZIN8reAKRDrVEze8nw25
	4MQaxdsW3+nB2G/MnTTrXmrkSxUFGoAoPI8SsiB+vyfmYyiavhWpHYkWaSA/o+Pt
	QLMEV54ZFxTABaNEIR3Uj9qN1AHK5owOMQ1bPeTZGYlsbcdjChtrtWTynfsoZyB3
	jBnoeq49u213jL1aIkhfPtyeVBwMwf6I913s+NeQfMWlb45gqR9ZPwDzi55lzvZl
	aMQavA6w1jbbrIie/fKVguBH7PXoMD/pYTa41hHHQga8ZqC6r5v5r+sf3yvYCJxC
	o2WZaNZKyN/s8GJr+k1VNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723063210; x=
	1723149610; bh=gcQqS4Nvw3oVR6X1QO70/HzE1Wr/SNsmwf90YobtWTs=; b=H
	3H9+oWzmCH7q+Ht+i284uG0J0DLScMPq8j3wo05s2VPr9hCz5ekfk3M9abJy/6T6
	gYfyOgL3ClHTGKm6yYuuk/XoluWUEd5VYVRj2m1NF5Livx/tNhySzaKFRA8a93DI
	6gyzsqB9gGUhVJXZziIUBNpM9x31n7f6pzJyfESW1HTJTIsGwaxDNkYcpMrY+S4v
	XnrG91BxWxOfpFlooTyxg03IY+Jie5Wy7TiZFptqVjtfH3sQZbQP5yQcKcm0hotn
	ldSUIH5cu5iJYqqXaNA5PA7/GSGAnEpYb1BoDvzs5xDFccTx7svffXRqGUspwPqy
	fIchm5WXpXQPOKicbPqUw==
X-ME-Sender: <xms:qtuzZjFxgfhhUOupIBdlvye-FdoN4-RZy68WKu30K6XIcnIURiZpgw>
    <xme:qtuzZgVU8TnmjI28CmY8MMMb3LhV3XlatXn69r2iOYFYnrpdqu-S3Kb2-xvwDmb8V
    bf--woQ3lAjpxiEvFQ>
X-ME-Received: <xmr:qtuzZlKcOT-pYdn4gO3k-5o3FhIvMrID9a8XLwng6iNqNC7eXhENzs7whupchc6MDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeftrghf
    rggvlhcuuegvihhmshcuoehrrghfrggvlhessggvihhmshdrmhgvqeenucggtffrrghtth
    gvrhhnpeejieejvdelgeduveejgeeltdevieefteejleeiieejgeeihfelleehtdegudei
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrg
    hfrggvlhessggvihhmshdrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:qtuzZhGndCpJc4kIoZyNZ_3CzsB9hxJ3vmFRpVJQKINWz7yZYf5-mg>
    <xmx:qtuzZpUstN_arVCzhotyH2QspzMCki5qg_QDHYcE3JEsuIegV1R8kg>
    <xmx:qtuzZsN1B_CjUqx0l31gl5PFWCHaRzD-232qDIghDfQRIwlNNR_TJA>
    <xmx:qtuzZo3nWwPreQ_Vk0OzFcT1NwFGl3I0WHxkDXJH5WBOQ3Oeh1Etsw>
    <xmx:qtuzZuWw737ZV9JHTniMVYgh5NPYY0TFgxQy0RdnNxflmjnYac4Zudlj>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 16:40:07 -0400 (EDT)
Message-ID: <48d37621-13d4-42e0-8cd2-c4b031149b1e@beims.me>
Date: Wed, 7 Aug 2024 17:40:06 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] net: fec: make PPS channel configurable
Content-Language: pt-BR
To: Francesco Dolcini <francesco@dolcini.it>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240807144349.297342-1-francesco@dolcini.it>
 <20240807144349.297342-4-francesco@dolcini.it>
From: Rafael Beims <rafael@beims.me>
In-Reply-To: <20240807144349.297342-4-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2024 11:43, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Depending on the SoC where the FEC is integrated into the PPS channel
> might be routed to different timer instances. Make this configurable
> from the devicetree.
>
> When the related DT property is not present fallback to the previous
> default and use channel 0.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>   drivers/net/ethernet/freescale/fec_ptp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index 6f0f8bf61752..8e17fd0c8e6d 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -529,8 +529,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
>   	unsigned long flags;
>   	int ret = 0;
>   
> -	fep->pps_channel = DEFAULT_PPS_CHANNEL;
> -
>   	if (rq->type == PTP_CLK_REQ_PPS) {
>   		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
>   
> @@ -712,12 +710,16 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
>   {
>   	struct net_device *ndev = platform_get_drvdata(pdev);
>   	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct device_node *np = fep->pdev->dev.of_node;
>   	int irq;
>   	int ret;
>   
>   	fep->ptp_caps.owner = THIS_MODULE;
>   	strscpy(fep->ptp_caps.name, "fec ptp", sizeof(fep->ptp_caps.name));
>   
> +	fep->pps_channel = DEFAULT_PPS_CHANNEL;
> +	of_property_read_u32(np, "fsl,pps-channel", &fep->pps_channel);
> +
>   	fep->ptp_caps.max_adj = 250000000;
>   	fep->ptp_caps.n_alarm = 0;
>   	fep->ptp_caps.n_ext_ts = 0;
Tested-by: rafael.beims@toradex.com

