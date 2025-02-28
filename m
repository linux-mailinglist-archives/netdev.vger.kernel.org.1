Return-Path: <netdev+bounces-170710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA9A49A70
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710EA174119
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8ED26D5C5;
	Fri, 28 Feb 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3xrpw/F7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43B2580D7
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748976; cv=none; b=IRanstECHKKXLIy927YY0gtB+T1Rlf6PJeOI08enRiwxudif1IcfqygJkc4yeHXCqdqN8vERz7h5CuvMFt+rJSaMBQhX96w73e1hrIosGC25qOOeMV12iHn+jf1qXmyT6pr5JEEJidPzhY4FxTOzXtslh2dX2FNMzyDvdNotp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748976; c=relaxed/simple;
	bh=ixzTek62XgE2gpVkuTJc+AloXLa/ol4WoFaREpLK5qE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jw9IWw757mNsHZBX6I3qVYSxYyJZ6SSIynY/Tvjyydq+zERdLWGib8m4miYNniMbCH2qTrjLfH4tHNIPIeEg0s30QqTKHtPZrhUv6j844QHnM1Gkxyqt+fmsKFHJG6Pp7gQz/5mWhRYyoSWwkP/yIDIuWPFPALENIiQ+WhSUtrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3xrpw/F7; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-47217c14be9so70867771cf.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 05:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740748974; x=1741353774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNe/TItsMxBxnsI97c/FspSojTXGXLiTZRjtKnaJRMc=;
        b=3xrpw/F7CpXZFokEmOIwrYgFt0MGD7GcHjWJ/oIYBAtht2J6KziVdGOUmgBZ+PdCIh
         U9REiB6zWb1xmHk7Agpl+p4AwSwIQkhBdGuh2g+9Xihkjv/V9z9EN3pp0Cmapf5i6Zcn
         9J5wwZNJPmQYlLn3OIMuTwd/J2Xz28no1hNyLmhyvoHigbgmTWHVImbxv+kb4zgAu0ny
         UKRt1mRObiqDD2Gw6RRlQt3Kwecv542N0mpxxGIvtVwq5KlO60cpz5TRIkoTvNL1fvWM
         CnBd8WUrhYETxoJSQVrMXGl1mPX9onwQrko8lMAJxfu0eewa5wInaRDREZk8F/RDDuAt
         jEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748974; x=1741353774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNe/TItsMxBxnsI97c/FspSojTXGXLiTZRjtKnaJRMc=;
        b=FC84hc3VzYOhkI132sjo3WxuH0n7CeNC5udqE0T42jQYT7SfntwgPIgQ9aLpiizZKx
         qNNPsgsJcRGdM7kHX6K5TvV0Ry9y+1XhEqIB2a2RlzFcqdHmJ8o0gQgRhH3HpBSiPptk
         osDAT9n1R6w1n5YW2sqK5nRbHaROR0uYFeNCjvq/NfD2hhXZs0vzCIhLR2ZLZ1yNvNW+
         skpl/CrbOi+HYmKLS8Bj0W6Y7Q8sWyiGPLHS7rvxeWJj3CpInNfHKsV//FgsoVnwSydI
         Z5mZKJfABjVa/FkWM4uEXvIetKE6Oy1/dGm+srrXi7HPZVKLzvJN2ufPrF8wJN7HX11p
         wlvw==
X-Forwarded-Encrypted: i=1; AJvYcCXxBOlfh00cE38daGxeR09osQfdTYab56vh3xRF2ciaMVD03Ev6/j5H3Op3k4uLgBJ4Ul0yA/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKi07cbzfS2Wo6sDKe7W7qkaLwkt4y8j/bZV58REk3lJbN5oo7
	aTfYakZn5ImU7big8+pcgE+r1ImstGgjAp0n/8eMGSD0Z7Vi7f6c1CwJta3mBCw+lnHlkN6Q6CJ
	zR01/rnjKKw==
X-Google-Smtp-Source: AGHT+IHJY+Eekn5wtEKkbfekufxn5+yrisrXo0mMwSddL/+mn086YiHT6uH5DRKBc4KbBsa9j4nspUhTku1OuQ==
X-Received: from qtbfv8.prod.google.com ([2002:a05:622a:4a08:b0:46f:d531:ee9d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:764a:0:b0:474:bd24:dcf5 with SMTP id d75a77b69052e-474bd24de0fmr31816871cf.18.1740748973929;
 Fri, 28 Feb 2025 05:22:53 -0800 (PST)
Date: Fri, 28 Feb 2025 13:22:44 +0000
In-Reply-To: <20250228132248.25899-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228132248.25899-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228132248.25899-3-edumazet@google.com>
Subject: [PATCH net-next 2/6] tcp: add four drop reasons to tcp_check_req()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use two existing drop reasons in tcp_check_req():

- TCP_RFC7323_PAWS

- TCP_OVERWINDOW

Add two new ones:

- TCP_RFC7323_TSECR (corresponds to LINUX_MIB_TSECRREJECTED)

- TCP_LISTEN_OVERFLOW (when a listener accept queue is full)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dropreason-core.h |  9 +++++++++
 net/ipv4/tcp_minisocks.c      | 10 ++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 32a34dfe8cc58fb1afda8922a52249080f1183b5..da806c2c620f774155fb1d6d2d5fbfcf483c4c0e 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -40,6 +40,8 @@
 	FN(TCP_OFOMERGE)		\
 	FN(TCP_RFC7323_PAWS)		\
 	FN(TCP_RFC7323_PAWS_ACK)	\
+	FN(TCP_RFC7323_TSECR)		\
+	FN(TCP_LISTEN_OVERFLOW)		\
 	FN(TCP_OLD_SEQUENCE)		\
 	FN(TCP_INVALID_SEQUENCE)	\
 	FN(TCP_INVALID_ACK_SEQUENCE)	\
@@ -281,6 +283,13 @@ enum skb_drop_reason {
 	 * Corresponds to LINUX_MIB_PAWS_OLD_ACK.
 	 */
 	SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK,
+	/**
+	 * @SKB_DROP_REASON_TCP_RFC7323_TSECR: PAWS check, invalid TSEcr.
+	 * Corresponds to LINUX_MIB_TSECRREJECTED.
+	 */
+	SKB_DROP_REASON_TCP_RFC7323_TSECR,
+	/** @SKB_DROP_TCP_REASON_LISTEN_OVERFLOW: listener queue full. */
+	SKB_DROP_REASON_TCP_LISTEN_OVERFLOW,
 	/** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate packet) */
 	SKB_DROP_REASON_TCP_OLD_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field */
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 46c86c4f80e9f450834c72f28e3d16b0cffbbd1d..ba4a5d7f251d8ed093b38155d9b1a9f50bfcfe32 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -809,10 +809,15 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
 					  &tcp_rsk(req)->last_oow_ack_time))
 			req->rsk_ops->send_ack(sk, skb, req);
-		if (paws_reject)
+		if (paws_reject) {
+			SKB_DR_SET(*drop_reason, TCP_RFC7323_PAWS);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
-		else if (tsecr_reject)
+		} else if (tsecr_reject) {
+			SKB_DR_SET(*drop_reason, TCP_RFC7323_TSECR);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TSECRREJECTED);
+		} else {
+			SKB_DR_SET(*drop_reason, TCP_OVERWINDOW);
+		}
 		return NULL;
 	}
 
@@ -882,6 +887,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	return inet_csk_complete_hashdance(sk, child, req, own_req);
 
 listen_overflow:
+	SKB_DR_SET(*drop_reason, TCP_LISTEN_OVERFLOW);
 	if (sk != req->rsk_listener)
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);
 
-- 
2.48.1.711.g2feabab25a-goog


