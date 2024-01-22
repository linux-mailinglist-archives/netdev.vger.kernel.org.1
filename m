Return-Path: <netdev+bounces-64638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24F18361E2
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E921C26DBF
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22BD3EA95;
	Mon, 22 Jan 2024 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbYMaBIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454213EA89
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922772; cv=none; b=t3QD19eemEy56niUyCH3V0ZPouQVCAOjdzFpPOvKgWs8CMPREIR4wcSmP21oe3Lkwxdt7aEeo0RNXoJfGsd4Lo/pzxGalIWcYce75onEAVK1RKj7j2kdRV6QmY+/stplBRAFf7CwK4Buqy6x/eXAZgNoafs97vd1PGKCcEGrWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922772; c=relaxed/simple;
	bh=4kUcKGkfjZX/LnVNI9Iy+TT9WRf2Su8lCIGnHEtFn/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hnKd7Y+muaye6DIY5Osj1mETWjgjbTqR7poLmkKXR36gSfMFnja1K+vdc2pe+y8hqadsNPCyAGFvixPndw9+0sYKEZTsffcPYcB86ykKQJqnX4Uz1Xq6UAgHbEAPDgOSrwdGY7xw2fkZxnpubKJ6h1aiKoSg5jr2xaFxM8svWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbYMaBIQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc251408f56so3581513276.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705922770; x=1706527570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+6t2Nm4CsYXxTEdm5fx54M51ZfMmGJv2+E32zXR6IY=;
        b=bbYMaBIQlFdjgMAblZOsisnnPGJmuTO6rlzW4ln6x+Ec/bZV7QXrsaRxB2n3U78VIn
         p6deN7e/Dc3uXb5oew8vFe+o2Nb4+xnENvOVUH+KxhNamWjUCecxBOFLgowemHGADiW6
         xUtj+ZXER10AJJwncKHhcHmeJzl/aaxHhTnHFpIhnQuGoIWvknLtZnrztRobF/GLNxpL
         TQCZZJgW7jDMBFOM2e6atqEhtLYZJq0oeWrmQexrr8vYfG+7vsGquE7Jjfw9ljXPEhmC
         zx64ICWqeoNaibFxXCbZmhgwa61EucJBtGXQO9Fq3SMmugAO6Bog1nnugxpFAVRCfz0n
         kyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922770; x=1706527570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+6t2Nm4CsYXxTEdm5fx54M51ZfMmGJv2+E32zXR6IY=;
        b=nzO+e5CSzaxmhWtMQEZkHSYxLmzVftqz514konzESaP8tJuQUV5Y+hCKT6ua3KCoGP
         tJYDZUHay1guw5QSdzXLGbGXfe7XACYh17saZrv1vz49e/tM7uZknt3qIuxMNwINhB1m
         mhvnqynHcDgQVwr0SiDUoiavAjxIAubLL9sjEH3eQ1iM7yANyaCdEGPQZeBoq+xv/Zza
         uqic8xGkREwoQQmgig1M/5jTX1+/8WoBFgcgJHF7XfvrXBmK5hcxQ/QfiZsDZUdbtd/K
         k4AYidz0LBcW8Vpfa+ddbzDlTm44FIHMtbIUTU7wCvL7t679pm17j15yywAUwvMgiFEH
         gBPA==
X-Gm-Message-State: AOJu0YwrCTF38fvI9TuDeHRRginqKwe8feRCH/dfkn6PqWJVK/neeR46
	voqID10kGhPiabXSkDsnM7NexfYERGA5QMT55mZVXI6JIL3HDXseEmHftvjlpkTbptMVTYETOa/
	CBkwIpegRAg==
X-Google-Smtp-Source: AGHT+IEJz6P7jMRVBO5EgBiBUCHJtQ5dnunIBbz/Mhn0bm5anNeQGZd8RUAQk+3Uzo0d0D/hUMSu7lEnC0yNrA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:aca2:0:b0:dc2:3268:e9e7 with SMTP id
 x34-20020a25aca2000000b00dc23268e9e7mr240534ybi.10.1705922770259; Mon, 22 Jan
 2024 03:26:10 -0800 (PST)
Date: Mon, 22 Jan 2024 11:25:57 +0000
In-Reply-To: <20240122112603.3270097-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122112603.3270097-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122112603.3270097-4-edumazet@google.com>
Subject: [PATCH net-next 3/9] inet_diag: add module pointer to "struct inet_diag_handler"
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>, Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following patch is going to use RCU instead of
inet_diag_table_mutex acquisition.

This patch is a preparation, no change of behavior yet.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/inet_diag.h | 1 +
 net/dccp/diag.c           | 1 +
 net/ipv4/raw_diag.c       | 1 +
 net/ipv4/tcp_diag.c       | 1 +
 net/ipv4/udp_diag.c       | 2 ++
 net/mptcp/mptcp_diag.c    | 1 +
 net/sctp/diag.c           | 1 +
 7 files changed, 8 insertions(+)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index 84abb30a3fbb13a61ed786bf32e0f72c0bbfbdd2..a9033696b0aad36ab9abd47e4b68e272053019d7 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -8,6 +8,7 @@
 struct inet_hashinfo;
 
 struct inet_diag_handler {
+	struct module	*owner;
 	void		(*dump)(struct sk_buff *skb,
 				struct netlink_callback *cb,
 				const struct inet_diag_req_v2 *r);
diff --git a/net/dccp/diag.c b/net/dccp/diag.c
index 8a82c5a2c5a8c9ed8885b53744ff13c2bee657d8..f5019d95c3ae535555cc2b4d4885c718227fec67 100644
--- a/net/dccp/diag.c
+++ b/net/dccp/diag.c
@@ -58,6 +58,7 @@ static int dccp_diag_dump_one(struct netlink_callback *cb,
 }
 
 static const struct inet_diag_handler dccp_diag_handler = {
+	.owner		 = THIS_MODULE,
 	.dump		 = dccp_diag_dump,
 	.dump_one	 = dccp_diag_dump_one,
 	.idiag_get_info	 = dccp_diag_get_info,
diff --git a/net/ipv4/raw_diag.c b/net/ipv4/raw_diag.c
index fe2140c8375c8ebcc69880142c42655233007900..cc793bd8de258c3a12f11e95cec81c5ae4b9a7f6 100644
--- a/net/ipv4/raw_diag.c
+++ b/net/ipv4/raw_diag.c
@@ -213,6 +213,7 @@ static int raw_diag_destroy(struct sk_buff *in_skb,
 #endif
 
 static const struct inet_diag_handler raw_diag_handler = {
+	.owner			= THIS_MODULE,
 	.dump			= raw_diag_dump,
 	.dump_one		= raw_diag_dump_one,
 	.idiag_get_info		= raw_diag_get_info,
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index 4cbe4b44425a6a5daf55abe348c167932ca07222..f428ecf9120f2f596e1d67db2b2a0d0d0e211905 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -222,6 +222,7 @@ static int tcp_diag_destroy(struct sk_buff *in_skb,
 #endif
 
 static const struct inet_diag_handler tcp_diag_handler = {
+	.owner			= THIS_MODULE,
 	.dump			= tcp_diag_dump,
 	.dump_one		= tcp_diag_dump_one,
 	.idiag_get_info		= tcp_diag_get_info,
diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index dc41a22ee80e829582349e8e644f204eff07df0e..38cb3a28e4ed6d54f7078afa2700e71db9ce4b85 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -237,6 +237,7 @@ static int udplite_diag_destroy(struct sk_buff *in_skb,
 #endif
 
 static const struct inet_diag_handler udp_diag_handler = {
+	.owner		 = THIS_MODULE,
 	.dump		 = udp_diag_dump,
 	.dump_one	 = udp_diag_dump_one,
 	.idiag_get_info  = udp_diag_get_info,
@@ -260,6 +261,7 @@ static int udplite_diag_dump_one(struct netlink_callback *cb,
 }
 
 static const struct inet_diag_handler udplite_diag_handler = {
+	.owner		 = THIS_MODULE,
 	.dump		 = udplite_diag_dump,
 	.dump_one	 = udplite_diag_dump_one,
 	.idiag_get_info  = udp_diag_get_info,
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 5409c2ea3f5728a05999db17b7af1b1fb56f757e..bd8ff5950c8d33766a0da971dc127f106feb8481 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -225,6 +225,7 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 }
 
 static const struct inet_diag_handler mptcp_diag_handler = {
+	.owner		 = THIS_MODULE,
 	.dump		 = mptcp_diag_dump,
 	.dump_one	 = mptcp_diag_dump_one,
 	.idiag_get_info  = mptcp_diag_get_info,
diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index eb05131ff1dd671e734457e28b2d7b64eab07f85..23359e522273f0377080007c75eb2c276945f781 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -507,6 +507,7 @@ static void sctp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 }
 
 static const struct inet_diag_handler sctp_diag_handler = {
+	.owner		 = THIS_MODULE,
 	.dump		 = sctp_diag_dump,
 	.dump_one	 = sctp_diag_dump_one,
 	.idiag_get_info  = sctp_diag_get_info,
-- 
2.43.0.429.g432eaa2c6b-goog


