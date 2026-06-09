Return-Path: <netdev+bounces-296994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1EUaAuzaJ2rX3QIAu9opvQ
	(envelope-from <netdev+bounces-296994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:20:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5415165E440
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:20:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=u7LKDy3S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296994-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296994-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A312304A8FC
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42E43C8196;
	Tue,  9 Jun 2026 09:13:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FED38332A
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 09:13:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996421; cv=none; b=clJzrN+CfwPt/IR/H630PTdbH64x6wzU9R3kiBOCUmiCH6unacSsNzBWvxcL7w9UIQu1N/pX2cZwbA6B+PuvzQHwR7avqUWQ6Z5xq4sb5TvMOIkGhdRC947Uu4pd8LeqRrsHvhninF3tVGrBYlAwTr4Q48sNcdtk3j8e+zlaJNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996421; c=relaxed/simple;
	bh=JBliuMMBBb835k2RTsRIXglL3AXPaSzhQ3dz/EuTtAA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CzEkDzIeaUB3G0ox7qNjaZlalZXu/4zDErqwhuLbYShCBGmeT0V4jvarcoPEzvrN8AVQoFavW7miaSy/XLnBUIM39whwA/1WvG1r7h0yO+xiLpeQobfYdxrK2qzBAE/Ytfsyby7pPC/KG7vd8RuvU3NVC0UtjnivO+QfHlG+I1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7LKDy3S; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-915767b341eso613602285a.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780996419; x=1781601219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PI2wLMpJY+rqjtRmr0TC4yuW+obsBoJePrE49LptRDA=;
        b=u7LKDy3S+dJsMuFvm6HJxMKtJvBG1Msuykq5fM+h86+VKWOOP1uGQhJehonCO3gbjM
         KNb5D4sMENr38+S/hmGhvizVmq64SNN74NSTgSArN5/rEETMz9j7BHJURV/BUmTb1Ude
         /ujO8TfJdD/Sjz3ODqS3kIIRpNlqy8UFrZyyIaBTk1GU+LLFQA15HkcynkP1W0S2LYbh
         Hpx1FHdxdYO4IsqNSHHx6/lV2aK47OgMymnkca72Vnpk9rbfIz5HG9vZPdgnHqheAncP
         jmNSXp4OvPxePplWKGPIEr8ZDKJUy9Px+fJ11/H1HTLJj04cy8d49OOS+R1thE8tKwlH
         g7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780996419; x=1781601219;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PI2wLMpJY+rqjtRmr0TC4yuW+obsBoJePrE49LptRDA=;
        b=UP3128F7XeD1pdyqq1fyreziOMgnv0QB+QlIXPk8oM2lLaSZCCCHGK9mtjwsGRtL5d
         62mR+r0wio7MkKkpOXl9iQCXVsqctIJiDiPQCO1f03XYyzr5j9FMBOHVb2vah2bXA6Qo
         IFIqNRfJb714/rR4jph8YYlVtzzkt2zgWO4TaAfFhLqMb9iJXBCszJY4t2S6AWKSCAZc
         6pfdyyb1UcpWBX06vRyehmui4HBGTbmhZXH8rGQ65AUnEp1tMhLfp1/nNTsvHsIze8eu
         wjza+ak2+wP8kpcqQIKzBXNzlJ4Q9WC8v1Lohr7Qtbyv0Gt+mI2QRmJJ5YOLdSGiU6jx
         L4rA==
X-Forwarded-Encrypted: i=1; AFNElJ+1wd8oplgbxPSIG29YyTAyOu2O80wzXeNi0ZrtlKLS+gGOQ28EO+UlEIF3L9uy4ibOTab/Usk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2JotA+D7k00Rv4r8WgDnwfZa0zSiSNQjaC2ysZI0Gd4Q5R5H1
	H9QNjx5kHUeGtSdlqYPM2x1oxHgpbIsyNuB15eEavyrLcZpXi7Q9u/5bgwttQvxBHJi8sp89854
	pL2hOge+fZSt6ZQ==
X-Received: from qkf18.prod.google.com ([2002:a05:620a:a212:b0:915:786a:4300])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2a05:b0:915:8f08:5fa7 with SMTP id af79cd13be357-915a9db4f9amr3078237885a.52.1780996418725;
 Tue, 09 Jun 2026 02:13:38 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:13:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609091337.2672441-1-edumazet@google.com>
Subject: [PATCH net] ip6_tunnel: do not use dst6_mtu() in ip4ip6_err() and ip6erspan_tunnel_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296994-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5415165E440

This is a minor performance / conceptual fix.

1) ip6erspan_tunnel_xmit()

  ERSPAN tunnel can mirror both IPv4 and IPv6 traffic, skb
  (the packet being mirrored) can be an IPv4 packet,
  and thus dst can be an IPv4 destination entry

  Use dst_mtu() which contains generic logic for both families.

2) ip4ip6_err()

  skb2 has been prepared as an IPv4 packet, and its destination
  is an IPv4 route.

  dst6_mtu() is optimized for IPv6 destinations and uses INDIRECT_CALL_1
  to call ip6_mtu() directly if the ops match.

  We should use dst4_mtu() instead.

Fixes: b40f0130a23b ("ipv6: use dst6_mtu() instead of dst_mtu()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_gre.c    | 2 +-
 net/ipv6/ip6_tunnel.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20354c256c491a16db0e606e0a9790..48039f00b4bc4321c1502714a98dbf209a7ea398 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1058,7 +1058,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	/* TooBig packet may have updated dst->dev's mtu */
 	if (!t->parms.collect_md && dst) {
 		mtu = READ_ONCE(dst_dev(dst)->mtu);
-		if (dst6_mtu(dst) > mtu)
+		if (dst_mtu(dst) > mtu)
 			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 	}
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9d1037ac082f6aad36c152ffdbe0f30237b65fc3..bf5cd5d4adcdfa86eb7a3c0a27db3cadb69499ae 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -650,7 +650,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 	/* change mtu on this route */
 	if (rel_type == ICMP_DEST_UNREACH && rel_code == ICMP_FRAG_NEEDED) {
-		if (rel_info > dst6_mtu(skb_dst(skb2)))
+		if (rel_info > dst4_mtu(skb_dst(skb2)))
 			goto out;
 
 		skb_dst_update_pmtu_no_confirm(skb2, rel_info);
-- 
2.54.0.1064.gd145956f57-goog


