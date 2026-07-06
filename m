Return-Path: <netdev+bounces-305148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GJxdJ6zZS2qfbQEAu9opvQ
	(envelope-from <netdev+bounces-305148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:37:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 342A77135B9
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:37:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V4X877jB;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305148-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305148-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20BD43001036
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D6F433BD0;
	Mon,  6 Jul 2026 16:36:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB017432BDA
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:36:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355815; cv=none; b=I23svI0acAQCzfabRIutqB5zKW1UyZ3+QDYuoqFVXgmMUZxLfQF56epXru6/enjbCR9SFSNYQ6KpS8bt8Sqyh3OWQgJh9DcvNAoQ3iGQ/gjB6ZuGC/oft+ewEh3GreLrIial4/t3fKncRMMQHFy4vEVI0Qz6qFABUxBdWIVrsXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355815; c=relaxed/simple;
	bh=Rq2wwkYTiUr3Hh85G7r77JXihYNgK7FBfHMZJMmDOgw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lihuySsYgYTW2L3vgfMskLWnPNq9ueUE4uauaOO8jTbVCtBWn+aElN0V7VRvg8U5uG+/547Wkx0soob0/OhY1Iads3/JBY5o8dkOjCG0r6xyK5Yjd/2j9IqtuN2Y4jnjJBpZdekYKX7osmDdPaUBSso8s/atthRGhjaqX/AusgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4X877jB; arc=none smtp.client-ip=209.85.128.181
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-806449d108aso47294737b3.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783355813; x=1783960613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0pJcWvIhqLuJxPO4aE4cyY/xCREGxJtBF+FRAD54hro=;
        b=V4X877jBA9oDVQfacZTHh6TmZK3jJb0jUWyEPTuOKLpq+ELFkbFePRD98+hhojR5kL
         s9XkPqndgB4AqsaztKYHkFrg7Q+rvIOYa6CBwYpqduAbYwauX9TB7dPjsNUYhwD2XrMz
         GIMijs/flIefi7urgK/1KKVqQ4SD6C7A2zpLZnOQrAXtYshud5kFACcGvd1/vwbMUN+Y
         xGlyY0ToXXN9EZamR1giZj5FLOzY/Ry/TYPjPf+6u5xMrMld432ZXpKcmT2crC6p8O2o
         PxOpQLtmDglTb83OtDo7XTC2ERQpBYiLjXEqpFkwzNV+uAe+xSKbV4WTpSdsBc9Sz14f
         /ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355813; x=1783960613;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0pJcWvIhqLuJxPO4aE4cyY/xCREGxJtBF+FRAD54hro=;
        b=ZXpJRxn6N4BfEG9bQBzg/t2tlzKC3Vag17nkJkv/1NOGFPK8+gIKYqcT0XvSVX3KgX
         eoTYNlxMrbLxkiLdTzaKFSbqZwsPKA10SX5hcrnReSlRfeg5YtWtYIKDvSVjf3E6opGW
         ZvjjuVF26qPe/MNuTwGKtTEdtmEaYWHStzOkFsRAJwbhSf9HRgjjyjQrIhLvW0MEKAev
         3abYt+mWKVTihwlsFTQPtvTewvRoRlwwY2JYtXyzrqV1IV8UPJJjvIc+ZblcxacippL7
         lOidyxpVRgjCpex+lAtU80mEBeqqaPSnfHBwtzgPVAYYTzPWfa4ssV1r7Nz+knEdxo+S
         E4aw==
X-Forwarded-Encrypted: i=1; AHgh+Rr81dbdgI07khdnJqIwT5R3cCbpMGysWlZIH5MtUciA5zWivU7PN2BR8j1OYi5X9khIkyJFLqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZoUImm9xUzvOXIuaaj1NzISxCP5ItTx9v9xV15XpKNRRg7+tU
	5WYkMQDOXIZYVIWvolrZ5OL29tyHYi4aGwPuyfyuO7D+XZHb/9RQIH/F
X-Gm-Gg: AfdE7cmzLlMBWM1d/LY8BT7xGAG2bBNJU6Wf38WeSxMUrcHqu5oKT4Ics7vT0fLl0ib
	+c3GBEuhHEswTL1t7DuDghvwkH/srizgHcHcZaz7RbqVp2dUdYNKiaTnGOiJgpRAl7/24GwPk/c
	omuwA7vRs01OEa7xyY7ZJjlizpWtFSSmm7B+BhPUNeDsb8zDiymWLr1Lg4DGlGryyok3WAEwKRv
	bfbYJyE6G9iCiZXfQ8YJ8FL9C2SLHkatIPRe5toLTpMG5dGBZLr+eyvtvb6i7ZrKQ8kk3CcNr53
	empUp0xWWPaL0ocZ99CREbfmC1MCzbllzeE5ga/0BRZImuhq4RAfOhN0T5vGvVrJInRiK+nHFZi
	PYLnzgxdF8+I1gmrCcTUn0Hs0HUSlvmbyi5ynChNhNYGN8j1tKTi0g3YBJ1KN2BUufCIKMhsO/P
	UvopIewFPMdlZcl+xFskIdv8jtKjBDyYtt2HORCXD6R2cwI8Wxu5pGNePGISQc9/YJXg==
X-Received: by 2002:a05:690c:ed6:b0:80c:85e5:8750 with SMTP id 00721157ae682-81be33a3727mr8097857b3.57.1783355812853;
        Mon, 06 Jul 2026 09:36:52 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144bd26ebfsm59805817b3.48.2026.07.06.09.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:36:52 -0700 (PDT)
Date: Mon, 06 Jul 2026 12:36:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 alice@isovalent.com, 
 sd@queasysnail.net, 
 eilaimemedsnaimel@gmail.com, 
 imv4bel@gmail.com, 
 nbd@nbd.name, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 steffen.klassert@secunet.com
Cc: stable@vger.kernel.org, 
 lena.wang@mediatek.com, 
 shiming.cheng@mediatek.com
Message-ID: <willemdebruijn.kernel.27b4940999026@gmail.com>
In-Reply-To: <20260706034611.360-1-shiming.cheng@mediatek.com>
References: <20260706034611.360-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH v5] net: gro: fix double aggregation of flush-marked skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305148-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mediatek.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,isovalent.com,queasysnail.net,nbd.name,vger.kernel.org,lists.infradead.org,secunet.com];
	FORGED_RECIPIENTS(0.00)[m:shiming.cheng@mediatek.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:willemb@google.com,m:daniel.zahka@gmail.com,m:alice@isovalent.com,m:sd@queasysnail.net,m:eilaimemedsnaimel@gmail.com,m:imv4bel@gmail.com,m:nbd@nbd.name,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:steffen.klassert@secunet.com,m:stable@vger.kernel.org,m:lena.wang@mediatek.com,m:matthiasbgg@gmail.com,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 342A77135B9

[PATCH net v5]

Shiming Cheng wrote:
> The skb_gro_receive_list() function is missing a critical safety check
> that exists in the skb_gro_receive() implementation. Specifically, it
> does not validate NAPI_GRO_CB(skb)->flush before allowing packet
> aggregation

In v3 I requested referring to the commit that fixed this in
skb_gro_receive: commit 0ab03f353d36 ("net-gro: Fix GRO flush when
receiving a GSO packet."). That explains the issue well.
> 
> This allows already-GRO'd packets with existing frag_list to be
> re-aggregated into a new GRO session, corrupting the frag_list chain
> structure. When skb_segment() attempts to unpack these malformed packets,
> it encounters invalid state and triggers a kernel panic.
> 
> Scenario (Tethering/Device forwarding):
>   1. Driver: Generated aggregated packet P1 via LRO with frag_list
>   2. Dev A: Receives aggregated fraglist packet and flush flag set
>   3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
>   4. Missing flush check allows re-aggregation despite flush flag
>   5. Frag_list chain becomes corrupted (loops or dangling refs)
>   6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list
> 
> Root cause in skb_segment():
>   The check at line ~4891:
>     if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
>         (skb_headlen(list_skb) == len || sg)) {
> 
>   When frag_list is corrupted by double aggregation, when list_skb is
>   a NULL pointer from skb->next, skb_headlen(list_skb) dereference
>   NULL/corrupted pointers occurs.
> 
> Call Trace:
>  skb_headlen(NULL skb)
>  skb_segment
>  tcp_gso_segment
>  tcp4_gso_segment
>  inet_gso_segment
>  skb_mac_gso_segment
>  __skb_gso_segment
>  skb_gso_segment
>  validate_xmit_skb
>  validate_xmit_skb_list
>  sch_direct_xmit
>  qdisc_restart
>  __qdisc_run
>  qdisc_run
>  net_tx_action
> 
> Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
> skb_gro_receive_list(), matching the defensive programming pattern of
> skb_gro_receive().
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> ---
>  net/core/gro.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 35f2f708f010..b1573d98f3a5 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -229,7 +229,14 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  
>  int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>  {
> -	if (unlikely(p->len + skb->len >= 65536))
> +	/*
> +	 * Packets marked with NAPI_GRO_CB(skb)->flush have already gone
> +	 * through GRO/LRO processing and must not be aggregated again.
> +	 * Re-entering frag_list GRO may corrupt the frag_list chain and
> +	 * later crash during GSO segmentaiont.
> +	 */

Such a verbose comment is not needed. Code would be overwhelmed by
comments if done everywhere.

> +	if (unlikely(p->len + skb->len >= 65536 ||
> +		     NAPI_GRO_CB(skb)->flush))
>  		return -E2BIG;
>  
>  	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
> -- 
> 2.45.2
> 



