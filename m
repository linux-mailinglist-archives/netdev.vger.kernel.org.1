Return-Path: <netdev+bounces-305627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jSmlOV2bTWpJ2wEAu9opvQ
	(envelope-from <netdev+bounces-305627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 02:35:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C94B720A72
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 02:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=F9ivoAUG;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305627-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305627-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DB253021701
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 00:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C6E35CB6B;
	Wed,  8 Jul 2026 00:35:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0450357D00
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 00:35:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783470923; cv=none; b=LOK5/omJLsOKbTXIAPZ1reOHHyok6qD0EXckYGUk+Val/3UQH29y6sUhwn9Ei9qQ4s/ZOIyUv7PQB70abbAGlVYCI6BI8r/nLzSict4U+/Ttk3N9ers4tDGjA4XQh0hCwMm/hMS8o9b3TMtUxOE1WC+x7XNM7VqI5oDnFdGxPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783470923; c=relaxed/simple;
	bh=kpQ7K618WEDQIaw+8rgkuKiLsx6rUKb4VMi31896/HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9Y8PVbePu2vnOOsydJlAHjR3lwI8mWpQ7nWIyeQKEbQLCe7JXAzi+pMKpRCEQ8cPl47Y4jjDENAkQnjypQftV1LhgJFAbQeg1f+CEF7SY/WYDxqWXqVmfdLwmQ/8HcFRVntFXE/+muX2FuwL7IMC0LkVuIupv6kRw18gkOCKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9ivoAUG; arc=none smtp.client-ip=209.85.167.50
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeae771c49so122398e87.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 17:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783470918; x=1784075718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt8g1rhydfsnfi2/drmvhXiESWtFs9rzFECjecYmKDc=;
        b=F9ivoAUGbUlXnjJFjNDR3nPKDPwkFYAeo+x1O7FFpJK9iUlQ+MfrDsH9RX8/n6FyLd
         ahSadjFp9U//rHdqY8HSbSAjqv7BSLZyIjeKcxoUVkljvdwMBVhJpLJomONnFJohY1BF
         ESAaYVI8heMqJb6UHcAUkd6I00XhnvKBF4t/ZCbJl530Yf7S/WIbqShG0gfhZafqSK29
         gOq1Rgg81uXhs1BOqnvG73hfI1w6fMS+M607/8ObyIXujEferL8inLaW0XdSyz1Yj5x4
         TZGEJ2uzfBQeqLaghXy2K+rdaDqsKsLiy7yR4DUmd4B+j/9XP71ehnlGA8sjQsNRzreL
         53Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783470918; x=1784075718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gt8g1rhydfsnfi2/drmvhXiESWtFs9rzFECjecYmKDc=;
        b=Qxrvui0ulUfS8N76mQZmC1CEULQq7ccMoShy217H4IAaEOeDpU0qxal6GemioiKvGK
         7DW5q85A/B8x2pMtkVM6WqIcZ0tZtK/wfoxqSbpnFiODyUY3MY/bsvnv7qRDu/kO3bsC
         7vfdGGSGBDtjTWbm3d54TWEPCAe031cIvBrLW+whqkh6g1gJ9v9hL7px8ALgrMjCquY/
         N9kOM66Owha2S7Sps/itSXo6DtWhKKifdxwW+VqygdnNMLpfN39LQonqWIqC+1iN21x4
         kvDs3AC12oBvdo9tAZN34SQJbDpvhq/ZXRkE8b+w6Y05ogKH/NLqJjGInLZBfXU1Ty/3
         YgUw==
X-Gm-Message-State: AOJu0YwgVlO3nCrE4+7SgzulNCiKxylEDRgbNxJNrnxLr+1xiWfrgGmz
	nJfcp4gtvGOlfaQr3nLqVAWL5i27RKnLp14kY8AgHxxZ+QyfCW6aXf3zJkTrXIWHyNJuAA==
X-Gm-Gg: AfdE7clBRSXbH7jWZJ8X1lR/CZHNk1WvUrI4/gzkc4fqlRulbHQpOm1pKX9KkUCk5dQ
	TCNynTGQ6xwyL7YuySCHJDmWxtXHgzpqRo90rKdRWvIj5PJJqLTFSIhO4lll0A2Yo13zEj0+cBh
	g7GXiBX2Q70Ps3d/8O4mEsCIMQMe4Tgx4kSphVDOX+NoLyj56g4IBrCn/4EwyuQl07w0LwsHlo3
	cYYnxP5Ys9wvKJuGlwsb7EXsk1aASry9ib6Zz2NDLUCrtF9s49prTm3kujF6P70So1taz6P7Qdq
	GnZNSkv1DH6B3lXO40S3laSg17Mml86e4VfyvB/aqm4UaanSytQeZcOcI4ocKznDwyF9alOfQDN
	AjvO2DLfDL5Y7xIlyh4qm6rMYxObkFbyNAFkeJHutxMR9klmArsjfWqzn9zRxJEXZzPlvN1f/WM
	yTRcbNsm/T7oLqhfRAxBryU8axU3HSkkHzoqqglzfewCPW2WibzyoAKAXJjLJMH3hQQiulNDdTY
	SpF
X-Received: by 2002:a05:6512:4604:b0:5ae:b952:6c with SMTP id 2adb3069b0e04-5b01141c3a9mr78738e87.13.1783470917699;
        Tue, 07 Jul 2026 17:35:17 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.139.182.77])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed136f8dcsm4083867e87.11.2026.07.07.17.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:35:15 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v6 1/2] udp: fix encapsulation packet resubmit in multicast deliver
Date: Wed,  8 Jul 2026 03:35:03 +0300
Message-ID: <5372ccac062193147e02b991d5328a5c3fa3a85a.1783372173.git.littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1783372173.git.littlesmilingcloud@gmail.com>
References: <cover.1783372173.git.littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305627-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C94B720A72

When a UDP encapsulation socket (e.g., FOU) receives a multicast
packet, __udp4_lib_mcast_deliver() and __udp6_lib_mcast_deliver()
call consume_skb() when udp_queue_rcv_skb() returns a positive value.
A positive return value from udp_queue_rcv_skb() indicates that the
encap_rcv handler (e.g., fou_udp_recv) has consumed the UDP header
and wants the packet to be resubmitted to the IP protocol handler
for further processing (e.g., as a GRE packet).

The unicast paths handle this correctly by propagating the return
value up to ip_protocol_deliver_rcu() / ip6_protocol_deliver_rcu()
for resubmission. However, the multicast paths destroy the packet
via consume_skb() instead of resubmitting it, causing silent packet
loss.

This affects any UDP encapsulation (FOU, GUE) combined with multicast
destination addresses.

Fix this by returning the value from udp_queue_rcv_skb() when it is
positive, matching the behavior of the corresponding unicast paths.
Note the sign difference between IPv4 and IPv6:

  - IPv4: udp_unicast_rcv_skb() returns -ret, and
    ip_protocol_deliver_rcu() resubmits when ret < 0
    (using -ret as the protocol number).
  - IPv6: udp6_unicast_rcv_skb() returns ret, and
    ip6_protocol_deliver_rcu() resubmits when ret > 0
    (using ret as the nexthdr).

Both mcast paths now follow the same convention as their respective
unicast paths.

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp.c | 6 ++++--
 net/ipv6/udp.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 59248a59358c..d3ddcbfc8477 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2476,6 +2476,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
+	int ret;
 
 	hash2_any = 0;
 	hash2 = 0;
@@ -2520,8 +2521,9 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	}
 
 	if (first) {
-		if (udp_queue_rcv_skb(first, skb) > 0)
-			consume_skb(skb);
+		ret = udp_queue_rcv_skb(first, skb);
+		if (ret > 0)
+			return -ret;
 	} else {
 		kfree_skb(skb);
 		__UDP_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 392e18b97045..0910cc171776 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -949,6 +949,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
+	int ret;
 
 	hash2_any = 0;
 	hash2 = 0;
@@ -998,8 +999,9 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	}
 
 	if (first) {
-		if (udpv6_queue_rcv_skb(first, skb) > 0)
-			consume_skb(skb);
+		ret = udpv6_queue_rcv_skb(first, skb);
+		if (ret > 0)
+			return ret;
 	} else {
 		kfree_skb(skb);
 		__UDP6_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
-- 
2.47.3


