Return-Path: <netdev+bounces-282071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDDyBKAe8WmRdgEAu9opvQ
	(envelope-from <netdev+bounces-282071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:54:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6388548C195
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13E5E30ADA2E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464537DE9C;
	Tue, 28 Apr 2026 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMjOCamP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF69137CD45
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409638; cv=none; b=hcFrnwiDxiTF7h75n+TgJpE+NqhqJctkOMxufsg5ASsOLJRe1WeCxnAE1T9shXEM3q3gp9eO6S3h+lKMWsIR0aG/srP2sgt9TZEN2DuXv7n2MeiFqUs0uiyTCOmnVU7zYhkudDm5wmZunFq8UWGccvYWYhYtMFduHNRU1Enm6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409638; c=relaxed/simple;
	bh=4oTH/xrcufxBq/Rnkb7ZiwjmAVVhUjri5mktdyDyRLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNCE+tvV0OAqPGPGvGb8yHIra2qGu68KHhwEe38fH9cmR8a40iimlMZu/Yknok5gg64ZAGljEvRb+/SRHO0eo/PYxfJDwCyvY2lQI9nM9LCdzZsSlBfUamF4uAhpBRm/jzAEJaONTphGMyru/rJ1SIbS8oH6CZ6Eop41aWKURI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMjOCamP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBB4C2BCAF;
	Tue, 28 Apr 2026 20:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777409638;
	bh=4oTH/xrcufxBq/Rnkb7ZiwjmAVVhUjri5mktdyDyRLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMjOCamPFnpW0vSwcjTB7BSKGr3VYx8qSObVjX74vZEZV3cGGvXhfAg3tbF7eKm08
	 RRQMhaDc5Ax77u+1kg+3Q0B+klCwrmWwgQPy6GQfdzPQ3w7BeK89EFKxFdmcrHTTgn
	 3Ls6qxOAX3Xk2CZLmWLyRBMuB6ZOR8y55yeZX5HPTfMO3hS7iP3w58bcGQz/xDFZkb
	 O7kZnnKoGADnlFx7uMoqlY4cAjZZNmcQo/hhyN0a+LzTklqYIPwZahcfXJnD4/b2Td
	 gVn/DSUIjH/Tw0/Z74mVyYa8hshpTvNg0/eCqaCbJAJOiF17EqSTn1OJhAw9i5zHTk
	 j9Q/WTI72BzMA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	daniel.zahka@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] psp: validate IPv4 header fields in psp_dev_rcv()
Date: Tue, 28 Apr 2026 13:53:52 -0700
Message-ID: <20260428205352.1247325-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428205352.1247325-1-kuba@kernel.org>
References: <20260428205352.1247325-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6388548C195
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282071-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

psp_dev_rcv() is called from the NIC driver's RX completion path
before the frame reaches ip_rcv_core(), so the IP header has not
been validated in SW, yet. We expect that the device has done
all this validation, but let's also add the SW checks, to avoid
surprises.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/psp/psp_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index f069117c867a..524978dfb8fd 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -300,6 +300,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 	if (proto == htons(ETH_P_IP)) {
 		struct iphdr *iph = (struct iphdr *)(skb->data + l2_hlen);
 
+		if (unlikely(iph->ihl < 5))
+			return -EINVAL;
+
 		is_udp = iph->protocol == IPPROTO_UDP;
 		l3_hlen = iph->ihl * 4;
 		if (l3_hlen != sizeof(struct iphdr) &&
@@ -335,6 +338,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 	if (proto == htons(ETH_P_IP)) {
 		struct iphdr *iph = (struct iphdr *)(skb->data + l2_hlen);
 
+		if (unlikely(ntohs(iph->tot_len) < l3_hlen + encap))
+			return -EINVAL;
+
 		iph->protocol = psph->nexthdr;
 		iph->tot_len = htons(ntohs(iph->tot_len) - encap);
 		iph->check = 0;
@@ -342,6 +348,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 	} else {
 		struct ipv6hdr *ipv6h = (struct ipv6hdr *)(skb->data + l2_hlen);
 
+		if (unlikely(ntohs(ipv6h->payload_len) < encap))
+			return -EINVAL;
+
 		ipv6h->nexthdr = psph->nexthdr;
 		ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap);
 	}
-- 
2.54.0


