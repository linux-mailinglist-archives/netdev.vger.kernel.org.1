Return-Path: <netdev+bounces-163648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A1A2B25B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525F93A33E4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FDA1AA1DA;
	Thu,  6 Feb 2025 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipj0e3Hq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368819B5B1
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870532; cv=none; b=KhKgBrGcuEFU4KDzi/VMlI7qg5j043nnfca6o3i7CvK0Pb9WRBvFhCQvHWt2YyS9W1sfLRm3aWBcw9sXlh35QHFYO3yaZQthyTBIa/EUpg7+f/4DtYS7lGjedCogKM6BlrHbsUWlP+j6iqAnACTNualaN3X+RrC6X7v370tVKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870532; c=relaxed/simple;
	bh=SUQ36dT7NCquYR/J3wrYi9DAuLdQ7lLdOj3bIwQ95TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyN8HFDDg8soN5bKS6kc0tHh7cbdEmcs6WDcWqYMGuYH0tf/Ku7vk358lUYsa1nZ1+nypGVwObqtLom4jjgHI6Ty3TpG9gi3g3HfM8VrNZSSkSystzbnXmPvrngf2kOWBEWMzkNDzfw7k/6SawlQ1cV3Win6WZCk1q4G3yjLUbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ipj0e3Hq; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46fa764aac2so9673721cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 11:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738870530; x=1739475330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR573iXHDE6qn0yhJ5BDmPlNhijejbGjKbJBvKgVCss=;
        b=Ipj0e3HqbfF1QOcZW7Xd5pqfmfiCxLD35kJD8eB8EgqQLbVk3489zaqqthAe/ZVrPl
         Qy+ZxEk0nD/1cp4Q7qHgIE8UfMReq/0rIT6ZfqnLAMh5XHu6QBmu2VNKiz0N4tdqflv8
         eh9kXJxWHMH1eUDoLzSsK1kwB/Y3z/+GSpzd0WDC2qgWKg4EPTWUoeXViVHHJzAPaCeB
         NJ4yebFbmKfCjDObNgc3GZDltgD0Ka56iEDRVbalGZ2hMm8P/jHOScBDHStcVP84ix4k
         JwFR+sKMwjhKTJQ8SNcb+D+3RO6M3Ts6X4CCqmLWvtPLNGpyiLBMmg/iScLitQxPshCD
         5SUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738870530; x=1739475330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR573iXHDE6qn0yhJ5BDmPlNhijejbGjKbJBvKgVCss=;
        b=kQhMiXmq0JpF0Hzy/YKW7rQN20iZg38fEHragNWE8lE3iIevJ6cUk/iphYhX8v7I5Q
         oqB5y2kWO+yYV39WVv4NKmZA1dlMKOKCE6kcWHM8I6QHzQLLilDUVj2Fl6y/5BYbzGWz
         +Z9kCCCindoTQZm5Mn9745SrVTDp7TJYsAW2jERfigo/PAPGlDgZKfizZeAte6P9elbx
         qvoUaf/2z9aTl0wS9yU+FOaai69yeQ9a9lKV2gXMUBrepEmapC9CNFuQi4bbgG7ZO4Bw
         8xL6VbNXX1OeZA9OassouHfW5xu7Na1aAZh/Zm2sbQTqlxcH59rkiWqMtgHc6uRzzTlF
         +WbQ==
X-Gm-Message-State: AOJu0Ywmxjv9I+CJoaGvOHcXlKhf8CNtRyBEwidx3PnE2xtaO9P2DiO8
	W+WBXECE6bKxsBrjQPklmdl0UuSqQDNdzXfisOpHfQqNzXqAd8G4m8kmBQ==
X-Gm-Gg: ASbGnctGMvXMYw25mtCoaOXW0ESXR+h+6YI2KyGTNlMa9MgET2AkfkCRshSmiRkDlQv
	zdjk2K/r9fLLYprcCbxupmG1c3OHEWQylhbikEdADy4zUZKPAun+RpX8NhDbpUwCCJdOIXMJrM8
	jbT3j6xTLqNepiJnrMtHeTe1EIT2cYLJIIx7jrERHxos4OsTtd87MD8om8vAX7KObTibZxv3GWP
	wLoOoGvNl+G0ilmZ1DS7NkrhNMse1ndI9Ad/lYTJXCo3srraNiFMtcxo8Tmr1t4clWcWYnH39qT
	2IlGlpOxNxfkLDeTQ/0vKnDYhaj5XVPuTFliIQf0f6hZ9JS2WgBlvx0JKsT9TkDSmV7N9AGu8uE
	Y/1sTWeCceA==
X-Google-Smtp-Source: AGHT+IFzMHfOlQvpuiy9f8FFfejDimvFL/7ofGRtfKe3FAZnB4apssz67fctDmtV6CVO28k+aTesWw==
X-Received: by 2002:a05:622a:489a:b0:467:5910:255f with SMTP id d75a77b69052e-47167a2c642mr8628451cf.30.1738870528394;
        Thu, 06 Feb 2025 11:35:28 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492accc2sm8349301cf.30.2025.02.06.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:35:27 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/7] net: initialize mark in sockcm_init
Date: Thu,  6 Feb 2025 14:34:49 -0500
Message-ID: <20250206193521.2285488-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
References: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Avoid open coding initialization of sockcm fields.
Avoid reading the sk_priority field twice.

This ensures all callers, existing and future, will correctly try a
cmsg passed mark before sk_mark.

This patch extends support for cmsg mark to:
packet_spkt and packet_tpacket and net/can/raw.c.

This patch extends support for cmsg priority to:
packet_spkt and packet_tpacket.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/sock.h     | 1 +
 net/can/raw.c          | 2 +-
 net/packet/af_packet.c | 9 ++++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8..767a60e80086 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1828,6 +1828,7 @@ static inline void sockcm_init(struct sockcm_cookie *sockc,
 			       const struct sock *sk)
 {
 	*sockc = (struct sockcm_cookie) {
+		.mark = READ_ONCE(sk->sk_mark),
 		.tsflags = READ_ONCE(sk->sk_tsflags),
 		.priority = READ_ONCE(sk->sk_priority),
 	};
diff --git a/net/can/raw.c b/net/can/raw.c
index 46e8ed9d64da..9b1d5f036f57 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -963,7 +963,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	skb->dev = dev;
 	skb->priority = sockc.priority;
-	skb->mark = READ_ONCE(sk->sk_mark);
+	skb->mark = sockc.mark;
 	skb->tstamp = sockc.transmit_time;
 
 	skb_setup_tx_timestamp(skb, &sockc);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index c131e5ceea37..3e9ddf72cd03 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2102,8 +2102,8 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 
 	skb->protocol = proto;
 	skb->dev = dev;
-	skb->priority = READ_ONCE(sk->sk_priority);
-	skb->mark = READ_ONCE(sk->sk_mark);
+	skb->priority = sockc.priority;
+	skb->mark = sockc.mark;
 	skb_set_delivery_type_by_clockid(skb, sockc.transmit_time, sk->sk_clockid);
 	skb_setup_tx_timestamp(skb, &sockc);
 
@@ -2634,8 +2634,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 
 	skb->protocol = proto;
 	skb->dev = dev;
-	skb->priority = READ_ONCE(po->sk.sk_priority);
-	skb->mark = READ_ONCE(po->sk.sk_mark);
+	skb->priority = sockc->priority;
+	skb->mark = sockc->mark;
 	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, po->sk.sk_clockid);
 	skb_setup_tx_timestamp(skb, sockc);
 	skb_zcopy_set_nouarg(skb, ph.raw);
@@ -3039,7 +3039,6 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	sockcm_init(&sockc, sk);
-	sockc.mark = READ_ONCE(sk->sk_mark);
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err))
-- 
2.48.1.502.g6dc24dfdaf-goog


