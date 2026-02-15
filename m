Return-Path: <netdev+bounces-258775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBLMM4XakWlpnQEAu9opvQ
	(envelope-from <netdev+bounces-258775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:39:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 142B713EE0B
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E800130182BA
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CB72D1F40;
	Sun, 15 Feb 2026 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjENw4Qw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9272DF13B
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771166309; cv=none; b=TMWc8yqReVQpujAr7KzbcteT/HLc70Pg4YnC1ya/JCTKIYynxTrkf1iHyvy7MevSLfa20b3pfFj4PkLh5mBOrAPxSnQOhepFY7ZQWnnU5MyDMnk9Yt/TjAHfoAstC7LKHegMqpyOuMazOrRSiJ+EujZEpnGElug1CdddWWwDwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771166309; c=relaxed/simple;
	bh=yxOr2kluMioQMt3tV/KkrXrdM5pHECCvwTACLD6tRjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hCt1td7qDgk+z6Ua4EkEurKGJh1Ys3cOZLhujwnBvsn5ItUjzTziPYuNckgaOfDxhfu4FXGqQp+Zz5x6w6BjpqsEcyr9ZYSvZu5pYtvtGoYVTNxUrtXfw1zQulbxXQf7WW7CLRtiuiuolZQANktmdTeDOUsgB74F2enPJnyUa+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jjENw4Qw; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c71304beb4so879675885a.3
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771166307; x=1771771107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Azswv4fbDw4O/n3cFN1cs2tHhhNKI1EhYGqKEm1PXuw=;
        b=jjENw4Qwm2OPQ+EW7REO6WliH5HKsy8n312lG+YBXdJNzdcJyIopq3F8Rx3uF6pbYC
         3R3N/hCfoZHCsyIzlqp6SFSoTdRK0P0iKdUeMB8ZANUtocFrjAYgg51eLgK5XcJSazJK
         JZuqGqBYMCkFz9YDgxObenjhpb6+kaS+hj3FCiTbrXRayB1YeIw/Opgx88O1s2MhfEt4
         GPiUwnO6lMeUD+jx5h8H9zelSpl+71i6ZvuDAnDPUGYZ0x6HNef5e2rccoP/p4MIRQxR
         kOsaV6aQsEKMgvHGBYi5uGlxRYXU1b3wywM6hWdRnanPNn0zY1Iwn81sQTwkYlVA/2C1
         I+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771166307; x=1771771107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Azswv4fbDw4O/n3cFN1cs2tHhhNKI1EhYGqKEm1PXuw=;
        b=mJ77aMPfqvCAOAV7S92QJCg77nxSuX6LtPPSP5KkrvUNogBiEKqbxGQXOrRxxLd2AW
         1z3l6I1eayLpzArIaBowpVnpR5o1ySrkSLDsnFQjYsN6yowSEhicLOebxh9Zrhk+INgC
         gppVKS+Av6CheqL5WksfYUS8RiGmZpfcLDzd706gUIQrsbzjwQ2X36JvqczpdwoNx497
         u+dF3FNzozAIbDpMEb5v+17P1CD/eikOmUQObA8ncmVtCTZc4YEEs/iFKAynuccuMM/y
         jnIkaxcuMFEBPXl/S02dSEsjK4brWyRx8HaWrLRBlQi8IPiKTuPWZrUzS/6L88ViUAAE
         DMrw==
X-Forwarded-Encrypted: i=1; AJvYcCU15l5crSVMlIYmy/hWTI/VsSJLzGAW4dz4v6C/bG4i8L46HsUHTffYuy9giE8unMkk3scblbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZ3PLuNPrYK/gz5J0/iRCUusxZ8qivqIRoMhTNJK3lCZalV+f
	Ead7aLztKSideidHbcbSv89/JOsjytsrAvaliVRgdJpWG0eysJkDpGmrSMWolY5vya7+jp/y2+A
	x+47YVnlfiP0L2Q==
X-Received: from qknvv4.prod.google.com ([2002:a05:620a:5624:b0:8c1:b06c:8a99])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4003:b0:8cb:38f2:6a5e with SMTP id af79cd13be357-8cb422823efmr916203785a.25.1771166306858;
 Sun, 15 Feb 2026 06:38:26 -0800 (PST)
Date: Sun, 15 Feb 2026 14:38:18 +0000
In-Reply-To: <20260215143821.2330791-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215143821.2330791-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215143821.2330791-3-edumazet@google.com>
Subject: [PATCH net 2/5] inet: move icmp_global_{credit,stamp} to a separate
 cache line
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258775-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 142B713EE0B
X-Rspamd-Action: no action

icmp_global_credit was meant to be changed ~1000 times per second,
but if an admin sets net.ipv4.icmp_msgs_per_sec to a very high value,
icmp_global_credit changes can inflict false sharing to surrounding
fields that are read mostly.

Move icmp_global_credit and icmp_global_stamp to a separate
cacheline aligned group.

Fixes: b056b4cd9178 ("icmp: move icmp_global.credit and icmp_global.stamp to per netns storage")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/netns/ipv4.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 2dbd46fc4734b78201818ecf6065237d475101ce..8e971c7bf164642344f40a07e021b0037f27ee7d 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -88,6 +88,12 @@ struct netns_ipv4 {
 	int sysctl_tcp_rcvbuf_low_rtt;
 	__cacheline_group_end(netns_ipv4_read_rx);
 
+	/* ICMP rate limiter hot cache line. */
+	__cacheline_group_begin_aligned(icmp);
+	atomic_t	icmp_global_credit;
+	u32		icmp_global_stamp;
+	__cacheline_group_end_aligned(icmp);
+
 	struct inet_timewait_death_row tcp_death_row;
 	struct udp_table *udp_table;
 
@@ -141,8 +147,7 @@ struct netns_ipv4 {
 	int sysctl_icmp_ratemask;
 	int sysctl_icmp_msgs_per_sec;
 	int sysctl_icmp_msgs_burst;
-	atomic_t icmp_global_credit;
-	u32 icmp_global_stamp;
+
 	u32 ip_rt_min_pmtu;
 	int ip_rt_mtu_expires;
 	int ip_rt_min_advmss;
-- 
2.53.0.310.g728cabbaf7-goog


