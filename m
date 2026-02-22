Return-Path: <netdev+bounces-259904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOKdIFpgm2kmywMAu9opvQ
	(envelope-from <netdev+bounces-259904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 21:00:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3531703FB
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 21:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B85730209D4
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 19:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5992535C19C;
	Sun, 22 Feb 2026 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bjz2q4W3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99D16F288
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790345; cv=none; b=shJgRA0pRq4zBCcrNYq16SHfZO06I0AamSIKlmiy055RTviqOggR4grw1oRrVGbaZLvgFmOEH+TTeMlVluIJjxKjhSrx2sxcIscwxwpXEyKy/OmQKTI9SWFElgenC5HSe+lcN1Ivoud9xDYGRskZsBNDRd7V5fX4Lg9lUedFkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790345; c=relaxed/simple;
	bh=YUxeWiumDIevi3pfAqr7wG32llGuW6KcesoGqx9k/lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okUfaxF188HcUbIWrBLo6EE4SUEcxtMGMhWAyL7/iq+/r4nVBUZknterXoG9wckQjBhIv3J1EK9w46gknobuaJJQNWgu0h5TDtzb8/RlkSuo5McggqwWJsfnGRrklrFRJekL8AMVIuJN0MzLgAmUDMZrcfYbty70TqfM8H0+/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bjz2q4W3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8fa79b9fcdso614619366b.0
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771790342; x=1772395142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYuYJwbEOhynhWIFlwCSfc7cGmzyMZHQheg8tgUujHU=;
        b=Bjz2q4W3gsHOOFKzISBXThuyGAakODBeQmNZRMVEaJIaiUUdp+o5MLdOcDguLcG5b2
         TGxT3fOW72ff6f0fi09NAwtzPYm6wUYsGEwISohL7e5ZrHncP9iPiQUXKYaB0TX6bdMc
         3T6K7q565EXqA2Jt+CZW/8zseyZ8k6hw06se6ZNf1QsH8icABob0xj1W7/VfLE+FmsYs
         FrQXxC4ICOFYQElml3XwoFP9mr1k2iKAkCRmdUSQSGh1kmZv/XviSrk68ifgAE1qNMhK
         p3STw0FqxOy8B3adUfXGdKcQ8FogTLAPaOmdCYDScfQQroSoDvQFITeii4mhaKtriVN7
         xMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771790342; x=1772395142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYuYJwbEOhynhWIFlwCSfc7cGmzyMZHQheg8tgUujHU=;
        b=E3NC6b0dJdX4fID3RlE49HCqr4zyRRYeVvsS3jHsy54N5gVqw0zU/3L5phmv1u1JfG
         rOaXFfVjrQw2oPo4Z6DQjanFLx4JQGAcg99ukkPNf3msihwZPToJf0QHmvEDewN6n3lt
         ZK6C9PlIEhLzxE6AujxyVt/HalijhSNIBt1UROuxpqufzpv3Jb2kJwJuu5tIU99jwpVm
         e+WSsQFNt+gd5GhHHV5F7PX4a6BdTyFdKc89znrkcvPXSn9ufc0txCGhVjqAzdGn7yqi
         FHoLWciVuCRhGRU0IvLlUmoD3bzBTrVC6VJGo/QWDoBxAa4cTFO8mTVKbg5bZCfzvH/D
         DD8A==
X-Forwarded-Encrypted: i=1; AJvYcCV69LEnOFHbTpBZ+f9+qta4HDXmKuA/UiLKkIWTcNBw3j2nJ7ISbLdSyzztP8QRrLG8PU+OTDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrHidu5A6qw5j3393nZaO3HIvXEtKV99IAyCe4U+btpOdkj20h
	nwrbvBJPPgQoF/IKa0cTz8zr1YTvJbUKeP4lqCy6OboULVf4QPc+bp1O
X-Gm-Gg: AZuq6aJ2cyqF63mAFXiMCklRNm2tAn2En8wDtYqeSVaKDyEwfG1uRwe2D6GFbH23Yme
	80kISidlaZTHkKOOmobbv/rG28ui1A+AYxV1SlL4Ch3SJpNUrfCRCYNv76uqH5kCWFSXcsCmq0+
	yEGDIxX5Em6aGjaNwWjKW5uVcG0gayoG2WIC7FNW3n2sW5D8lZVjvsprutca7RdzuyVtOTsfg4w
	P3vvdIk/Jaaa5KjXguzV+Kl1rxm8OutdDma4o/dDl2XcemflY2g2Rr2CRJVZiYU5Qx9H0hNNmQE
	bHUD7HRpg6J+fBq36FydEd5HOWZc0KZfew+fQeisWz/tK9iej2jW6PhTF8sdk8Q64YP9CPhshKu
	RJfxfe25mKINt4/NILkgE2SGRIio/TxnbEX9Ls83Ef2SEM6Twen33WSd9jqDDqSniggpXFfjrGZ
	xjC+YQHCmvDOOSqffFzAm3m/wsKRcixARH/G8LE7MU+g35KTds7WIpn5qOwRw7si6mhE/3/3Uwv
	T+J0pjzIpNiqhFEA0mF7mFdaY8W2LcOV/EZjRWvgy5ULqabzsVWNEExL6iMIM8E7A==
X-Received: by 2002:a17:907:2d25:b0:b8f:c684:db3f with SMTP id a640c23a62f3a-b9054196076mr677551666b.12.1771790342007;
        Sun, 22 Feb 2026 11:59:02 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5c514sm246125466b.5.2026.02.22.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 11:59:01 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v18 nf-next 1/4] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
Date: Sun, 22 Feb 2026 20:58:40 +0100
Message-ID: <20260222195845.77880-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222195845.77880-1-ericwouds@gmail.com>
References: <20260222195845.77880-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.64 / 15.00];
	HFILTER_FROMHOST_NORES_A_OR_MX(1.50)[vger.kernel.org];
	HFILTER_HELO_IP_A(1.00)[sea.lore.kernel.org];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[sea.lore.kernel.org];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:query timed out];
	TAGGED_FROM(0.00)[bounces-259904-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	DMARC_DNSFAIL(0.00)[gmail.com : query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RBL_VIRUSFREE_UNKNOWN_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	MSBL_EBL_FAIL(0.00)[ericwouds@gmail.com:query timed out];
	DBL_FAIL(0.00)[sea.lore.kernel.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out,2001:1c00:20d:1300:1b1c:4449:176a:89ea:query timed out,100.90.174.1:query timed out,209.85.218.52:query timed out];
	RSPAMD_EMAILBL_FAIL(0.00)[ericwouds.gmail.com:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	SURBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:query timed out]
X-Rspamd-Queue-Id: 2F3531703FB
X-Rspamd-Action: no action

In the conntrack hook it may not always be the case that:
skb_network_header(skb) == skb->data, i.e. skb_network_offset(skb)
is zero.

This is problematic when L4 function nf_conntrack_handle_packet()
is accessing L3 data. This function uses thoff and ip_hdr()
to finds it's data. But it also calculates the checksum.
nf_checksum() and nf_checksum_partial() both use lower skb-checksum
functions that are based on using skb->data.

Adjust for skb_network_offset(skb), so that the checksum is calculated
correctly.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/utils.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/utils.c b/net/netfilter/utils.c
index 008419db815a..4f8b5442b650 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -124,16 +124,25 @@ __sum16 nf_checksum(struct sk_buff *skb, unsigned int hook,
 		    unsigned int dataoff, u8 protocol,
 		    unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* pull/push because the lower csum functions assume that
+	 * skb_network_offset(skb) is zero.
+	 */
+	__skb_pull(skb, nhpull);
 	switch (family) {
 	case AF_INET:
-		csum = nf_ip_checksum(skb, hook, dataoff, protocol);
+		csum = nf_ip_checksum(skb, hook, dataoff - nhpull, protocol);
 		break;
 	case AF_INET6:
-		csum = nf_ip6_checksum(skb, hook, dataoff, protocol);
+		csum = nf_ip6_checksum(skb, hook, dataoff - nhpull, protocol);
 		break;
 	}
+	__skb_push(skb, nhpull);
 
 	return csum;
 }
@@ -143,18 +152,25 @@ __sum16 nf_checksum_partial(struct sk_buff *skb, unsigned int hook,
 			    unsigned int dataoff, unsigned int len,
 			    u8 protocol, unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* See nf_checksum() */
+	__skb_pull(skb, nhpull);
 	switch (family) {
 	case AF_INET:
-		csum = nf_ip_checksum_partial(skb, hook, dataoff, len,
-					      protocol);
+		csum = nf_ip_checksum_partial(skb, hook, dataoff - nhpull,
+					      len, protocol);
 		break;
 	case AF_INET6:
-		csum = nf_ip6_checksum_partial(skb, hook, dataoff, len,
-					       protocol);
+		csum = nf_ip6_checksum_partial(skb, hook, dataoff - nhpull,
+					       len, protocol);
 		break;
 	}
+	__skb_push(skb, nhpull);
 
 	return csum;
 }
-- 
2.53.0


