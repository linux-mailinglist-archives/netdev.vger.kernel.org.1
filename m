Return-Path: <netdev+bounces-296548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id saOkOR2/Jmr0cAIAu9opvQ
	(envelope-from <netdev+bounces-296548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:09:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F36065675F
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:09:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AKHaQ1+r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296548-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296548-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 030BB30039A8
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FAE2D97B5;
	Mon,  8 Jun 2026 13:09:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C42F5A13
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:09:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924151; cv=none; b=j7BMvH6AIgOw1hPS8RgnOduSVt/OKmU7uI1LejvBnjJf+02kUzAsMNzMeudcXBto78gDmWUwRNYJfA4AD1wxkyNwfpXEWe5A+vPhmIy5XsddqEQ/G3mlHPHT0RKWKlO8XbIidBmF0X1INsZipGP0gZfiGoj9GsvZU5X9vOAVFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924151; c=relaxed/simple;
	bh=Pfl5pgFXyTWNxV9D6mos3jprlfIE0c7mA4pv1W/XI3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQxLjdXOBO6ho07beioz/jH+Feoaz5ksLzQcp8dyk4MvcfpG1OanX+1BgwqGUiWVJuWwaTj67CjWgtzB13cmCA4sJIaoEKnkOVyxSlxQM44TKuVl4brtAxElg+8ARm2DYsmu6ttWotzQiAWP5mrsSixuRFLa9u408SDZPYQtO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKHaQ1+r; arc=none smtp.client-ip=209.85.221.68
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-45ef7720385so263607f8f.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924148; x=1781528948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iX5IdwSQV/8QGq8LwjqPjgnC2d4KD0Dln7G9M6LKgo=;
        b=AKHaQ1+rEBE0yBZilRj52Knp22Y2M9M9r9DmoQdT7uogBov/58plWDymrzYFPvRv1i
         iv+chenvsgDrr7rUtCASqfa7OMY00zyT1yFCYE+yT6sYLSsgH9t7nbASh/c24c3GmhSh
         N6fCBKwhE22NaM6ZcTvliTRhgoHuasBqex7MdVyF3gw4KBhbIkxC/34GWWQq8mqXi5Ow
         03G3ghwKaqeYsWakdnZuj/WZ3NCPYFByLsibSf7K0R9RdOf64u2W2mhShIf6cuof4mx+
         syDaXm8bS59tKNRacoWn0qyRfmPbsumVJ3x+xlLMvfwzB+vRIV0Tw12HZ/GCMX5rzjFf
         dcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924148; x=1781528948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6iX5IdwSQV/8QGq8LwjqPjgnC2d4KD0Dln7G9M6LKgo=;
        b=d7VcORpfx/Ovag8R66q981ZfHFRuc+e6z4YDBZUY2frZSDHKWoDOuDvzGfFNvAyIHM
         XywhtkYoU+643LFKkHQSaXyVnshKGLLIh+Agc98t6E3pteF1vObFZ8f3HV1Mok63XKHR
         JF/4ggmejLs3kpb8y/0V7uGLpGrQwQd9cSW34DjPmJJBZECPfCchgPoB+xEwr1na5Pp2
         e6RfK0RZ3KjugDVRzq+mrzNx+xu/SS3zVvJOZur8W96nZbXxhltXa021tL9Q9i59lIhV
         X6DLhGz6mG97aqc27/FnfNvkDYzY/b1+zbb0kZrwidPaMITuehIc9+lW58TYkYRwz/Ci
         QT8A==
X-Gm-Message-State: AOJu0YxZWXlVpDxU0VfAetoCUenbVtZHDUY7Mr44pJsqRIw/6xYst9aN
	Rgg5+sJp0pMguf3kZWOe1TDE+895fxYX4n9pujLe53LNEVz7xfQiwC+yC0iTEHpJ
X-Gm-Gg: Acq92OHLkwDIDFTbvhevg4Dv12bpqE0En8hVipQ7WtF92/auE2kpgzBMEL2UcgoL4ft
	QQ4iAKS4IcD5cF2/iQjYQCVrPtmJBkdw/z7b63rqKvvKnacosV5r8lK/EVmGnHS/BSWGMs55z2r
	mEGjX8uhTIRtr8FRb4ZMOxvfHX3XuxkYmkxX8NLcsB8y1MqwZVcAsTey4MTqW2MwnFce17VhcHb
	I6MF2jjoE0DxLg6CLikSh0/qGZEf4hxBaMxjniMTjERKgf4dtKrSeQ18fB2WqPkd55b3p/Q8Ll0
	CemAKr2sx/bqX5XkafQia01QIq2DHB66lTijwRtL88qtNf4Cns9gequzCmlme+o1bWM5ULt12r4
	gKztSQ2zO3AwpOsBfr9U4KxzV7T/jwAPzIQp+0IkP8nFmoJTm2TsTMOFf2Wudk5rc1D3roCs8Bg
	/Q6Xvw32GXF3UhbtjHRylVHnZQInTBmy0=
X-Received: by 2002:a05:600c:8183:b0:490:846d:4edf with SMTP id 5b1f17b1804b1-490c259782emr103395645e9.1.1780924148023;
        Mon, 08 Jun 2026 06:09:08 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm300135675e9.2.2026.06.08.06.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:09:07 -0700 (PDT)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	shuah@kernel.org,
	kuniyu@google.com,
	alice@isovalent.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 03/10] ipv6: add jumbo payload option to non-gso jumbograms
Date: Mon,  8 Jun 2026 15:07:48 +0200
Message-ID: <20260608130755.5626-4-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608130755.5626-1-maklimek97@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:maklimek97@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,isovalent.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F36065675F

This path reintroduces code recently removed by Alice in commit
741d069aa488 ("net/ipv6: Drop HBH for BIG TCP on TX side") and commit
35f66ce90037 ("net/ipv6: Remove HBH helpers") that adds a hop-by-hop header
containing a jumbo-payload option to packets larger than 65535 bytes. The
hop-by-hop header is only added to jumbograms that aren't BIG TCP packets
since BIG TCP packets no longer need to contain such hop-by-hop headers.

This fixes sending jumbograms to a loopback device with MTU > 65535.

Fixes: 741d069aa488 ("net/ipv6: Drop HBH for BIG TCP on TX side")
Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 include/net/ipv6.h    | 11 +++++++++++
 net/ipv6/ip6_output.c | 22 ++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 1dec81faff28..d9e1fdca6934 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -152,6 +152,17 @@ struct frag_hdr {
 	__be32	identification;
 };
 
+/*
+ * Jumbo payload option, as described in RFC 2675 2.
+ */
+struct hop_jumbo_hdr {
+	u8	nexthdr;
+	u8	hdrlen;
+	u8	tlv_type;	/* IPV6_TLV_JUMBO, 0xC2 */
+	u8	tlv_len;	/* 4 */
+	__be32	jumbo_payload_len;
+};
+
 #define	IP6_MF		0x0001
 #define	IP6_OFFSET	0xFFF8
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 67c34fb281c6..405a9a0e65a4 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -293,6 +293,8 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
+	struct hop_jumbo_hdr *hop_jumbo;
+	int hoplen = sizeof(*hop_jumbo);
 	struct net *net = sock_net(sk);
 	unsigned int head_room;
 	struct net_device *dev;
@@ -305,7 +307,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	rcu_read_lock();
 
 	dev = dst_dev_rcu(dst);
-	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dev);
+	head_room = sizeof(struct ipv6hdr) + hoplen + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
@@ -331,8 +333,24 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 						     &fl6->saddr);
 	}
 
-	if (unlikely(seg_len > IPV6_MAXPLEN))
+	if (unlikely(seg_len > IPV6_MAXPLEN)) {
+		/* Only "real" jumbograms require a jumbo-payload option.
+		 * BIG TCP packets just rely on skb->len.
+		 */
+		if (!skb_is_gso(skb)) {
+			hop_jumbo = __skb_push(skb, hoplen);
+
+			hop_jumbo->nexthdr = proto;
+			hop_jumbo->hdrlen = 0;
+			hop_jumbo->tlv_type = IPV6_TLV_JUMBO;
+			hop_jumbo->tlv_len = 4;
+			hop_jumbo->jumbo_payload_len = htonl(seg_len + hoplen);
+
+			proto = IPPROTO_HOPOPTS;
+		}
+
 		seg_len = 0;
+	}
 
 	__skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
-- 
2.47.3


