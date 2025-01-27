Return-Path: <netdev+bounces-161184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA040A1DCDC
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AECC165A22
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD83196C7C;
	Mon, 27 Jan 2025 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTtbWl+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D79195B1A;
	Mon, 27 Jan 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006836; cv=none; b=Oipk9cUm+dCHanS9FniqEJXWit514AX+B3ta+Z2KILsJQCDS1uPrOKSvtqWRVKGvZxpX5FjJ0Pin9L8dBPOkGpdkfmhylq1ABhDyLUUXC/thvwVrucVm5dDsmrY0ykFy57TUinaxcF0QA7ZGV0ro3B47EckNudfeQjzOlPvJFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006836; c=relaxed/simple;
	bh=vyU0q25YwbGuP6YoLMBApIPNmi2ksQsvkmQcCMi7qFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dF86njLI12QM8MwWqAXc4L+q8tp2gFNBywuyAOo6+lML6UqYAlw45OZyZWjFva1PXNaFB4cgpcJCS7G4/QheIvBxgCfYX2/RO3P2UvIBwV1TdARkwft6tyUd/EH5HAqYIekvevX7mXdh1w5IFbBtUz9isD3RnRftl+HCGI3BMPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTtbWl+3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436341f575fso53704885e9.1;
        Mon, 27 Jan 2025 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738006833; x=1738611633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y53vetYx/SIV6EUXv+t6f3OyImlw7WSSM0T6TfbQyGU=;
        b=LTtbWl+3GexRCl2JPI12e32MDEqq9TcvoaY/oKrumu0FbsN0Tbzq8ZrSbIqfnh+mjJ
         lyfvXOx5I16uGpefVNGnREOcaHTztADdLUW3EvgH8D4R/qwfLb6hY7FWf136cp0PH31E
         zUph+cJBup1JTngC/QWMAMx4Q+dLbUBUIuVHLeFhUnlYZSLIKkPTcA/35mjxhfTgLH/+
         FvDPEkuiYr62zBgeiFzfgTTvt6JVDS168Y3kAYHkVGyGXP/UoKMhZ0jHQUgthJaeYH2Y
         wQSXHx6AdyPOhp6OUSDqWt2XkYYnjpe4YyD1LzbjzJ9JX55dyT2Es4YXN4adSLs/B5lF
         vD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006833; x=1738611633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y53vetYx/SIV6EUXv+t6f3OyImlw7WSSM0T6TfbQyGU=;
        b=dI46lSMJGrq9leQ7n5xh+ajUv/GHyNr1t3r/12VO5uUqJIS90xHOAgVHaEeq/YqvQu
         BdhpW1ZbGk7WAYTiRqos3d4hV3Gb7uBFQHhP0B/48+9j55YVEq0Cgmg8XpzpT1bFebpP
         MoS4iE3viianxKUmhm8vnibAUoTn2t267t+UBeQ7t9rvzU8EikhFyMJSMHNV/tmwZoVE
         S0L8ORpTw2v9l2wHdQ5oknmv9IdyZV69n7GSGCNQNBm72jbpaMnk9A49qKQBUTwjDgaT
         0obpzm77eJwTuVQcav685Ejvr8ffpCGRclVTXX0OMMTfTlUPwgtaQvbN8f2P8Dms0qNx
         fH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAXjme9zAUJ6eeQWrORXH6XO2cu6SKQhf9tVVHDFypc6DfBrPgnhgCRADt4BdgM+ueA60o+d9j@vger.kernel.org, AJvYcCViRiVs0EOxD+c8R6Pruw1dkamwPCJOxaufHrUG6Rsye6udvF8xVhrN98p4lF/mzVPdedhxvFxVSjG3CWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/PVI/lxjdw/CEfcsyJ6uU1tjN8ITuUnlgyaC5d1eYRITgshS
	kqG3ig0DPkv1aYcmfV+cvXdwyKuDmlTmuLeDDhUeLx3Qo2Wg63aw
X-Gm-Gg: ASbGncs/nTusX9T4Gny07KRlHzI6bBDzasTuKnW3Cotr985isywgzRKei/3gu85ldXj
	OuIIaiRfKd6fc/54UnbATh9f3EurAh8nmH6vdikoRFw2hqI4LYyK0ZvWUSSNeLuCHtg+lkJOtLz
	1S2bbma0TfGrYwqw3RiLx1PjMEOjdpIAPmGpbr17FDKyezUd52D7uyt1pHOPYhQHzw33HQ/whAi
	5oT7CWaTgHJeYQG+nNXCP8IpYIxafo8v9uxUFQomycq8WJs1jO22ifzjUHZo7yhDQiH9Ft6QFkx
	KuclMES+LnDPIsCNQa14POUCm75ik9UWM9TDlV1xJKpvXAnDlrT4PhiPWNTs3Q==
X-Google-Smtp-Source: AGHT+IHo3fimbzul9FkMK+7x4XgiOMf0b9XR3yY8PUl7nY18G+pIqM84Wz0Cssmph6tuIhXn5gd4Sg==
X-Received: by 2002:a05:600c:b8e:b0:434:f817:4492 with SMTP id 5b1f17b1804b1-4389146ecfbmr434914975e9.31.1738006833045;
        Mon, 27 Jan 2025 11:40:33 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4c6fadsm141031705e9.32.2025.01.27.11.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:40:32 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tom Herbert <tom@herbertland.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Lorenz Bauer <lmb@isovalent.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net 1/2] udp4: Rescan udp hash chains if cross-linked.
Date: Mon, 27 Jan 2025 19:40:23 +0000
Message-Id: <20250127194024.3647-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250127194024.3647-1-david.laight.linux@gmail.com>
References: <20250127194024.3647-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_lib_rehash() can get called at any time and will move a
socket to a different hash2 chain.
This can cause udp4_lib_lookup2() (processing incoming UDP) to
fail to find a socket and an ICMP port unreachable be sent.

Prior to ca065d0cf80fa the lookup used 'hlist_nulls' and checked
that the 'end if list' marker was on the correct list.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 net/ipv4/udp.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 86d282618515..a8e2b431d348 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -425,16 +425,21 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
 				     __be32 saddr, __be16 sport,
 				     __be32 daddr, unsigned int hnum,
 				     int dif, int sdif,
+				     unsigned int hash2, unsigned int mask,
 				     struct udp_hslot *hslot2,
 				     struct sk_buff *skb)
 {
+	unsigned int hash2_rescan;
 	struct sock *sk, *result;
 	int score, badness;
 	bool need_rescore;
 
+rescan:
+	hash2_rescan = hash2;
 	result = NULL;
 	badness = 0;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
+		hash2_rescan = udp_sk(sk)->udp_portaddr_hash;
 		need_rescore = false;
 rescore:
 		score = compute_score(need_rescore ? result : sk, net, saddr,
@@ -475,6 +480,16 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
 			goto rescore;
 		}
 	}
+
+	/* udp sockets can get moved to a different hash chain.
+	 * If the chains have got crossed then rescan.
+	 */                       
+	if ((hash2_rescan ^ hash2) & mask) {
+		/* Ensure hslot2->head is reread */
+		barrier();
+		goto rescan;
+	}
+
 	return result;
 }
 
@@ -654,7 +669,7 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 	/* Lookup connected or non-wildcard socket */
 	result = udp4_lib_lookup2(net, saddr, sport,
 				  daddr, hnum, dif, sdif,
-				  hslot2, skb);
+				  hash2, udptable->mask, hslot2, skb);
 	if (!IS_ERR_OR_NULL(result) && result->sk_state == TCP_ESTABLISHED)
 		goto done;
 
@@ -680,7 +695,7 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 
 	result = udp4_lib_lookup2(net, saddr, sport,
 				  htonl(INADDR_ANY), hnum, dif, sdif,
-				  hslot2, skb);
+				  hash2, udptable->mask, hslot2, skb);
 done:
 	if (IS_ERR(result))
 		return NULL;
-- 
2.39.5


