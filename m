Return-Path: <netdev+bounces-246585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD328CEEB12
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 14:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32F2D3011EC8
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D62E2D2490;
	Fri,  2 Jan 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pace-systems.de header.i=@pace-systems.de header.b="XVOtwCq0"
X-Original-To: netdev@vger.kernel.org
Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC31DE4DC;
	Fri,  2 Jan 2026 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767361547; cv=none; b=WDdy2dYi2FyVfzbaoHforfiNUqPathANkQAR9iA0LHDubFNUaC5PfV0tZFu8UWN1lhHWy29pVjTUY2dqzCSgIN6PdPozb/RG8lmote36kxHQIp38jvTIDfERVYRm1Fm8vfzksI8e2lImoeOTmPVfud1vfU0XcmjQoM1ShwzlCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767361547; c=relaxed/simple;
	bh=odpTuxH9kYZ3GnKkdybEyntftVSqh6ui7FmUigsWUfo=;
	h=From:To:Cc:Subject:References:In-Reply-To:Message-ID:Date:
	 Content-Type:MIME-Version; b=slXlp61M2W4CdgN9ZplsPFcVoZiIqeLN9KityXytqngnQmEmjqFvdj8e5Pasb0unvjaNkfu3He6mqBif+7iKOYjBIWLuwMj+CJfED2hHax1hfYQ8rsZMAFg9IakN1OL6QWdstJ9aMUAjcIF2BVcCtLyHJMkgijjPz7JryIkABe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pace-systems.de; spf=pass smtp.mailfrom=pace-systems.de; dkim=pass (2048-bit key) header.d=pace-systems.de header.i=@pace-systems.de header.b=XVOtwCq0; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pace-systems.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pace-systems.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=pace-systems.de; s=blu0479712; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Date:Message-ID:In-Reply-To:References:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=odpTuxH9kYZ3GnKkdybEyntftVSqh6ui7FmUigsWUfo=; b=XVOtwCq0iU57pqACQQxvCNHc3F
	vfIZmPvCu3a4sbVOl7hBfqnj69w1JV7vyztxFCmB5JKDchGhH5MS30WKHPkv1ZuaCYHG9J0YB12lt
	fULne1bjakxyZMRPzvB3dbqHk7QWROCxBIKPy0DywJXBsdqjfJkzmykC2+msMOgHM4LtVsfM9MQxl
	84ryxhshWLanjoTA3WO0H0Dp/uW/SwT0YIuAvmHtbR8tAFvBiGJDY2b+OVZHXm0o76oEJLIq0CoAs
	/+he+Ilp2Ec791/J+FplcKyVD5aZA2sNlFwty/H/Lihaw8PaE+Zxu40Kl5zkwoRKyRi3uyVWrAWNI
	Ik3jbSRw==;
Received: from [178.254.3.181] (helo=nc.pace-systems.de)
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Sebastian.Wolf@pace-systems.de>)
	id 1vbfSz-005D98-NS;
	Fri, 02 Jan 2026 14:45:21 +0100
From: Sebastian Wolf <Sebastian.Wolf@pace-systems.de>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Sebastian Roland Wolf
 <srw@root533.premium-rootserver.net>
Subject: Re: [PATCH] net: mediatek: add null pointer check for hardware
 offloading
References: <6856f6aa-c6b8-4966-9dd2-9bf0315395c2@linux.dev>
In-Reply-To: <6856f6aa-c6b8-4966-9dd2-9bf0315395c2@linux.dev>
Message-ID: <20260102134521.Horde.OJhG83vhDBgeJWzIiPESJP-@nc.pace-systems.de>
User-Agent: Horde Application Framework 5
Date: Fri, 02 Jan 2026 13:45:21 +0000
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Con-Id: 282146
X-Con-U: 0-sebastianwolf

Hi Vadim,
"Vadim Fedorenko" vadim.fedorenko@linux.dev – 2. Januar 2026 12:20
> On 31/12/2025 22:52, Sebastian Roland Wolf wrote:
> > From: Sebastian Roland Wolf <srw@root533.premium-rootserver.net>
> > 
> > Add a null pointer check to prevent kernel crashes when hardware
> > offloading is active on MediaTek devices.
> > 
> > In some edge cases, the ethernet pointer or its associated netdev
> > element can be NULL. Checking these pointers before access is
> > mandatory to avoid segmentation faults and kernel oops.
> > 
> > This improves the robustness of the validation check for mtk_eth
> > ingress devices introduced in commit 73cfd947dbdb ("net: mediatek:
> > add support for ingress traffic offloading").
> > 
> > Fixes: 73cfd947dbdb ("net: mediatek: add support for ingress traffic offloading")
> > net: mediatek: Add null pointer check to prevent crashes with active hardware offloading.
> > 
> > Signed-off-by: Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>
> > ---
> > drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> > index e9bd32741983..6900ac87e1e9 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> > @@ -270,7 +270,8 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
> > flow_rule_match_meta(rule, &match);
> > if (mtk_is_netsys_v2_or_greater(eth)) {
> 
> The code dereferences eth here ...
> 
> > idev = __dev_get_by_index(&init_net, match.key->ingress_ifindex);
> > - if (idev && idev->netdev_ops == eth->netdev[0]->netdev_ops) {
> > + if (idev && eth && eth->netdev[0] &&
> 
> ... but it is checked a couple of lines after.
> 
You are right that 'eth' is already dereferenced above, so checking it here is redundant. I will remove the 'eth' check in a V2 of this patch. (As this is first patch ever I hope I do it right)
> Even more, the function starts with providing rhahstable to lookup
> cookie. I'm really doubt eth can be NULL.
> At the same time lack of eth->netdev[0] looks like a design problem,
> because according to the code there might be up to 3 netdev devices
> registered for ppe.
While it might point to a deeper design issue, the check for 'eth->netdev[0]' is necessary to prevent the immediate kernel oops I am seeing. Forcing this check prevents the crash, which is the lesser evil compared to a complete system failure, even if hardware offloading might not function correctly in that specific state.
> 
> I'm not familiar with the code, but it would be better to have a splat
> of crash to check what was exactly missing, and drgn can help you find
> if there were other netdevs available at the moment of crash.
Unfortunately, I am not a regular kernel developer and have no experience with drgn. Furthermore, I am testing this on a production device which limits my ability to perform deep interactive debugging or long-term crash analysis.
> 
> > + idev->netdev_ops == eth->netdev[0]->netdev_ops) {
> > struct mtk_mac *mac = netdev_priv(idev);
> > 
> > if (WARN_ON(mac->ppe_idx >= eth->soc->ppe_num))
> 
>
I will send a V2 shortly, focusing on the 'eth->netdev[0]' check while removing the redundant 'eth' check.
Best regards,
Sebastian

