Return-Path: <netdev+bounces-282752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SArRIqwq82mwxgEAu9opvQ
	(envelope-from <netdev+bounces-282752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:10:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3BB4A08C2
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 728AB303FACA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C483FAE1C;
	Thu, 30 Apr 2026 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1eDn6ld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19127EFE9
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543235; cv=none; b=EPzOGn6tpYfqFdCvmz9oV+LusZrrM4WLfn4JhKyLElkiMGXIax4O2v8R8S1utLaX99GFQbwNRNHx0sPW7xciZP37bu3fq3CVbugL8agl65NBKhaE1EeJ9zSU620IJPpLMUYW5T1VVXdvANPAJHb2w5wLdEudy+nxlGwJts3hfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543235; c=relaxed/simple;
	bh=qdT9YwEie/9T8UyoPg+BQ4ocYv3D/xC3k7NJfx9UFw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sv1TFkn+AGYlZZBhCI4vzsTbOp2dGjb+1mw9RMFKHezEUwilnf7Cpz3XqtbeOibM9hUWIKiTQhIn4d1joK/RY+ZTUsjP9C5LqmKkl/IYP1GZMMvwJ+0uuxbXE/Twcgbs1tXuXO8f+J0tAaF1vV7H1Lfsy7fdhj1ecp3RsifuJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1eDn6ld; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8aca3b7b536so21275646d6.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777543229; x=1778148029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J4eOJh1op/uPGObl4DOQiu/FPWjkacquyPxjppNVQIA=;
        b=p1eDn6ld4b2KmFPNB3b5w1sYuPEeHlpYfIA6URRTsbvK2rhdw7A3cQl7l2DFaO1EmG
         8xU5AqY8hSEFtI6D7JYO5joKxmlWQ1Adq4+z9GvmwuaYcaJbs038RekDoDZF8emZlZZZ
         hkyO04E4iuwEhBH6mws3Yb9BxmxpQYsiJQfJ9l+Hu/JkFJaBzNy/c9ad97hpPLLCFAAK
         j+wjOvjVLZM5DkoyQ8stdpHXXmX+neRFMi1hO6xj6etpL7ksrp59G1HcweeO33PZ1WEc
         RoxKd2WhRGlMlUe4+bMtsNw7w1qjY+H1iEX3XV3ZN/GOCLh4mJwC79FJ7HLbeAZn/sDU
         zhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777543229; x=1778148029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4eOJh1op/uPGObl4DOQiu/FPWjkacquyPxjppNVQIA=;
        b=hdiJ94d++sUgGQVghw5Y/aHhh96EMiyA4fIseFlB7vwYPEJB6ACwZMSbFISpWnEVYm
         9PYXWKVJ7c8yOZxj2KjGRmQA6+iJ9O/evynByo5K4G4p7yGDGNuUILdbTfGCwPdq4Bp4
         38QBp/KyUjGP4E3S5yTNzaUZP0oWCreIolVWaEZZbOREESkbDhzOdBkoiJwAZht9SoYy
         /64ei1/Ccv1t+Y57065FXrrVPSlJqpVL+7F1twhwkT59DyR/8sWG9k1UxTWaciWJ1Wla
         NdSXN7sQkbNnlstdB062FQoELUIeEZfk3msnR50rqoEykCkvNoBR945Ne7p2rwpGPK13
         OuSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VUPhD8vf9/boS5k1CddmHnqJclU8kIkj9bkYTFw12rCAyvvro8JYG9WjY4lJpu+zXUfXsqYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNHsaMoDrycJ4zKQXduwt/q1EfhvgL0ScQxU4t9Ao3ZalJSQL
	BiRJboVGeM3UvEmL4aYlcuzZVpHDcBPbdksmOAenfJF87iT1lEcoyuwlSymCUAVx+nxdHCdH+YF
	jy5zgW6DjxDi/rg==
X-Received: from qvblh1.prod.google.com ([2002:a05:6214:54c1:b0:8a3:a172:4323])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3d12:b0:8ac:9fc3:b9fb with SMTP id 6a1803df08f44-8b3feef85edmr28811336d6.45.1777543228572;
 Thu, 30 Apr 2026 03:00:28 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:00:19 +0000
In-Reply-To: <20260430100021.211139-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430100021.211139-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430100021.211139-4-edumazet@google.com>
Subject: [PATCH net-next 3/5] tcp: move tp->first_tx_mstamp and
 tp->delivered_mstamp to tcp_sock_write_tx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EF3BB4A08C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282752-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

These fields are touched in when payload is sent.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h | 4 ++--
 net/ipv4/tcp.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 89013be1519abd1713d42f93e1864fb1d61d303a..e9adc88b73b43c39c734361da149ad29ef48e922 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -258,6 +258,8 @@ struct tcp_sock {
 	u64	bytes_sent;	/* RFC4898 tcpEStatsPerfHCDataOctetsOut
 				 * total number of data bytes sent.
 				 */
+	u64	first_tx_mstamp;  /* start of window send phase */
+	u64	delivered_mstamp; /* time we reached "delivered" */
 	u32	data_segs_out;	/* RFC4898 tcpEStatsPerfDataSegsOut
 				 * total number of data segments sent.
 				 */
@@ -347,8 +349,6 @@ struct tcp_sock {
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
 	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
-	u64	first_tx_mstamp;  /* start of window send phase */
-	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
 				 * sum(delta(snd_una)), or how many bytes
 				 * were acked.
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 135a5db6c3fcc1e33227403fd9376642c9826412..d25698a0e6819cb4d3563461bb1ae89d5104669f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5234,6 +5234,8 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, bytes_sent);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, first_tx_mstamp);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, snd_sml);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, chrono_start);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, chrono_stat);
@@ -5280,8 +5282,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-- 
2.54.0.545.g6539524ca2-goog


