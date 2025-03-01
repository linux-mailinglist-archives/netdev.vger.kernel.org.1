Return-Path: <netdev+bounces-170963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC2BA4ADC3
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 21:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D628D170415
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD11E885C;
	Sat,  1 Mar 2025 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nboJ73E+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373D1E8339
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740860071; cv=none; b=g9hUlv553t9Ntbe9Ycp1i2G7io4Ey3ed44naFhfazwiPFz/6duT9C5wbIZ0p/SGV3kkZs/t8n7rXDGqsNic6K0jSiNkshVJOpwEP09LiM70CsISCfNdeAfwtfI7jlj4aQa5EhBelI7Xz+4pwW2Xb34rTupIJVvRA1c910Epli/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740860071; c=relaxed/simple;
	bh=2DBmuZPxm89N49KoZNLlsJjBc5JAdlLsTJTH8L+5GAA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JQggmxV+wKUjXgFZvANyUCzAI81E/4QmDeJ+sjemgljxjJkBxioreiHiSeHyI3uEu0xBEkcw/dLNUOAFi8uiMpzLI8WCFETnl3NirULfmCVVtdlf4Gc1X2An/YXFSUJIkoDME2V/X/GWWkZ2PN0HPEdn8XjDlZg0N0qqts8VZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nboJ73E+; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-472051849acso59399771cf.0
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 12:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740860069; x=1741464869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4nJSXPCHCYyFPg2zigqXBKrcmYgDBLIpc2vQxNNA29o=;
        b=nboJ73E+//g0KB1viQ62fk99SFTBJfAz66CNgWzj2PWsabofLLZJpOTyN5G1P/8n0g
         0miTT+sNcNyf5mhqUQJnOybhsfkUitCtDkXzBPO+WUtzDOFWqjhMPL9kfnpuZoMBeifU
         U0dFz4/9EK2Q74IbQlITOVoOK5gPmmtMI1azrPiL7Xpj57VYu43zH2NjrXZBXdWpSqh3
         eqLlZg3xQqUo8S2U4AnABEGqSNuDF6z5lwZlmWeXVUkdMXSf9NJ3hQj9truI/VmardDl
         D/5Kbie4zf6fmIg5BLlzsmvXUFDUWsKbPoVo0QVOz95wMiH5mF+F1Ac4f6/CgCx+qRql
         ueeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740860069; x=1741464869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nJSXPCHCYyFPg2zigqXBKrcmYgDBLIpc2vQxNNA29o=;
        b=hFwV+/YSoDnFQAuJZa0LjX0jkkjWY/QIRjBt/Tr6gMNmFaUh3kxtBaYFtpGJbGGMvO
         cDUBvOtryKN25nkByfnfxytpINIL0NwRKPovzBIwhM88abFtBJ7LsU4AC9xmfNRlhzRY
         ZmTlZpqTSGhvfsHq+0gpGDnqsb+Go6vNln4NhTQkPXbxFGbiBBNM4S+aNMcsqWgfoKfq
         WRO7mU3ThYZMSGVCC5pEqneskxtwwEEFOBdpPQ+lBswjcV56yHPiWtt1x2PxuVHQ7Ale
         AvxN7qtMsIwQwchm7thbMdXZQDntLzxtceRkrZYYkkfe/KbbjW3WUq+evwdmTaZOnJYt
         zILA==
X-Forwarded-Encrypted: i=1; AJvYcCWHw+u0aTVKutVRjSLknBwfyjtMtoj418f02Fw9hxgY0AyvbRgEG4Z6lrBa/+MbNp/lHzSSuJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6rvPBLPyEi3X5Yuhm9BPGNamXXEf1OIm0IfQmLEBoMBzW6G+J
	W2NYXxzO81r66AdYnkEKXNhK/5O8OnaVUqoGk/2ZQeRGc7BAm6qvLYM2vwdwv4xR9pX39xQNBKr
	7QOAE+g2xpg==
X-Google-Smtp-Source: AGHT+IGx7dXq9WyxMETPGyQYQEnmMhgllGymNfXegzbvlLdT+Ss6MR0miF4UQnPW77FkhKp33e5RG1OZaX8/Kg==
X-Received: from qtbhg22.prod.google.com ([2002:a05:622a:6116:b0:471:f7c8:bc02])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:294:b0:471:bd5e:d5e4 with SMTP id d75a77b69052e-474bc0e88f3mr106944771cf.42.1740860069383;
 Sat, 01 Mar 2025 12:14:29 -0800 (PST)
Date: Sat,  1 Mar 2025 20:14:20 +0000
In-Reply-To: <20250301201424.2046477-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250301201424.2046477-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250301201424.2046477-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/6] tcp: add four drop reasons to tcp_check_req()
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
index 32a34dfe8cc58fb1afda8922a52249080f1183b5..e4fdc6b54ceffe9b225e613f739c089f3077d3ab 100644
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
+	/** @SKB_DROP_REASON_TCP_LISTEN_OVERFLOW: listener queue full. */
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


