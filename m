Return-Path: <netdev+bounces-296423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a0MhFq2DJmpqXwIAu9opvQ
	(envelope-from <netdev+bounces-296423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:56:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1C3654444
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:56:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=M80ryKOh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296423-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296423-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1AF43060C95
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D50B3BB9E0;
	Mon,  8 Jun 2026 08:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F53B19AF
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:42:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908140; cv=none; b=QzrNf5+qtbbYpPxWY92wJ20wyq0aSqR/ucsC805g26ExoqWFM95nb3P/xEymr+KmhuBtzXV+KUF0tObFJmHk4mB5kzQJSQFk1zMssSSCP3ebxRSNfVIxjupIHcej7OSlS83n+DA+xwFsQTvb9+kxFRhvCBRcHvnKMoPEw1SLuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908140; c=relaxed/simple;
	bh=IL5yCWDuQfoOijddF8IVyMHuiN+OBO5pbGD2FcEi+jw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=S6pialNE8KgaPstfjRw/ymgJYBXtUbPWQfU82OD+aG0V6320B6gtpdQWV5u4toWWA8u2QIScA4THWh16D9CvF3NhOWEHMkvEVqSjdPhgOcDt/b4V5HXc+g/ua2TSOUfuryjqFCIpCDa5To8WxmxBODoxZY354ORvoftJiYNqjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M80ryKOh; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260608084216euoutp0171bd427c19304873ef9072a9b77e5123~3DoOg6Cku1787517875euoutp01F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:42:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260608084216euoutp0171bd427c19304873ef9072a9b77e5123~3DoOg6Cku1787517875euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780908136;
	bh=qkWkk5ZCuQXKFlsyWEDbI0/1Ag13t/eSgQqfEVSLCb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M80ryKOhtzdXs7bXpb5LQ7UMkbAykeVzOrUjwUwhrkwc/uaFiJEEFVqFHLCpjF3VF
	 UQ05M/5UBadqE1hZ0zjJWlqPGyHb1qoUF+YyzKkZVYy8wAGO4GkTyewbyfE1ijtReA
	 oST5mCnIj4v2GYCs+NENAnLnUETxZZJW0l3RafWw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260608084215eucas1p120c1b6b6c39c336905bc144586cad692~3DoOJ4S6h0247402474eucas1p1O;
	Mon,  8 Jun 2026 08:42:15 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260608084215eusmtip2ca35be8c5f945603a879de58f5590eb7~3DoNkBlxy2049020490eusmtip2d;
	Mon,  8 Jun 2026 08:42:15 +0000 (GMT)
Date: Mon, 8 Jun 2026 10:42:14 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com
Subject: Re: [PATCH net-next v2 3/3] include/stmmac: Increase max DMA/MTL
 channel count from 8 to 16
Message-ID: <aiaAZjIHEx09UMDD@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260604131606.185700-1-pabeni@redhat.com>
X-CMS-MailID: 20260608084215eucas1p120c1b6b6c39c336905bc144586cad692
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----ri_B_5NHaOs85FNcStlWAa-YkdjA1OEu4E44JRLWFc1KTRWK=_112c9_"
X-RootMTR: 20260604131625eucas1p10bd49e06fef41bb185578da137b7411d
X-EPHeader: CA
X-CMS-RootMailID: 20260604131625eucas1p10bd49e06fef41bb185578da137b7411d
References: <20260601162537.553512-4-j.raczynski@samsung.com>
	<CGME20260604131625eucas1p10bd49e06fef41bb185578da137b7411d@eucas1p1.samsung.com>
	<20260604131606.185700-1-pabeni@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,samsung.com];
	TAGGED_FROM(0.00)[bounces-296423-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-kernel@vger.kernel.org,m:k.domagalski@samsung.com,m:k.tegowski@samsung.com,m:cs0617.lee@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[samsung.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,AMDC4622.eu.corp.samsungelectronics.net:mid,samsung.com:from_mime,samsung.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE1C3654444

------ri_B_5NHaOs85FNcStlWAa-YkdjA1OEu4E44JRLWFc1KTRWK=_112c9_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

I will be rewriting this patch as discussed in other thread,
but will mention that IMO this AI review is generally invalid.
Below why.

On Thu, Jun 04, 2026 at 03:16:06PM +0200, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
> 
> 
> [Severity: High]
> Does increasing these limits to 16 cause undefined behavior and silent register
> truncation in the hardware configuration functions when queue >= 8?
> 
> In dwxgmac2_core.c:dwxgmac2_tx_queue_prio(), when queue >= 8, the logic
> only subtracts 4:
> 
>     if (queue >= 4)
>         queue -= 4;

This ignores previous check of queue > numtc, which is hardware returning
maximum value of 8 (0-7). This is not direct 'queue > 7 ' for AI so I get it,
but this is not possible, unless hardware would return wrong value.

> 
> Finally, dwmac4_core.c:dwmac4_map_mtl_dma() only maps queues up to 7 (using
> MAP0 and MAP1):
> 
>     if (queue < 4) {
>     ...
>     } else {
>         value = readl(ioaddr + MTL_RXQ_DMA_MAP1);
>         value &= ~MTL_RXQ_DMA_QXMDMACH_MASK(queue - 4);

Correct, would probably be good to not forget about dwmac, although
GMAC does not return number of available TC's so check would be artificial.
Although no function checks that currently, will be fixed by last comment and
probably checking this stuff in upper layer.

> 
> [Severity: Critical]
> This is a pre-existing issue, but does missing bounds checking on the device
> tree properties expose an out-of-bounds array access during device probe?
> 
> In stmmac_platform.c:stmmac_mtl_setup(), the device tree property
> snps,tx-queues-to-use is parsed and clamped only to 255 (U8_MAX):
> 
>     if (!of_property_read_u32(tx_node, "snps,tx-queues-to-use", &value)) {
>         if (value > U8_MAX)
>             value = U8_MAX;
>         plat->tx_queues_to_use = value;
>     }

'Net' material, not for this patch (net-next), will probably send it later,
as this is valid

> 
> Later in stmmac_main.c:stmmac_hw_setup(), it attempts to dynamically clamp
> this value to the hardware capabilities:
> 
>     if (priv->dma_cap.number_tx_queues &&
>         priv->plat->tx_queues_to_use > priv->dma_cap.number_tx_queues) {
>         priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
>     }

Well, XGMAC will correct incorrect value, so why not do the same for GMAC
even though it would be artificial > MTL_MAX_TX_QUEUES.
Same for RX. Although same as for above, probably 'net' material

BR
Jakub Raczynski

------ri_B_5NHaOs85FNcStlWAa-YkdjA1OEu4E44JRLWFc1KTRWK=_112c9_
Content-Type: text/plain; charset="utf-8"


------ri_B_5NHaOs85FNcStlWAa-YkdjA1OEu4E44JRLWFc1KTRWK=_112c9_--

