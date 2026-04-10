Return-Path: <netdev+bounces-277618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFdLENiN2WnSqggAu9opvQ
	(envelope-from <netdev+bounces-277618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:55:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 969593DD958
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1685300DE02
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B7F38B13E;
	Fri, 10 Apr 2026 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3TxYomg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C737FF65
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 23:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865212; cv=none; b=QneO8EzlTUx46Qgn6KFyxyCmIWvYWyb1cuUQqIzTVhfcCQBaNOBq43GRNVpLhSB8LvXito2WkvfUMh/4YlmtsZP419EUSqQ79MOi088Hkl3lL1KOgPm13Z3Rh/ka+4zI6Iej/X7tPBLlQF1Yd1r+7ZTyi9Ode27xcJ2wi6IgY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865212; c=relaxed/simple;
	bh=mrxyZ1+eCVyF7rvafNu6lasPaZuGp06j3PNNa2491SU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W+0qgyPAXTy1IZnvbiKHJcqeq0s/kttBHAjLfrwR+N5MAi23HYSPr+reKEL24CQtr8X6gBf34t0zbCBQMLRZWQ0qlfLt9BRVJy8I2qYO4DjYX3QmGqiGc0birHB/HCklvCz9dGxpQf4+TyW6K/teXwW+QAOXDx/tcT+OtP2RmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3TxYomg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0f4e632caso36595965ad.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 16:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865211; x=1776470011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nr1g2FHUeGn3VK0c3AFEuLVs4Ynz9EITyADBY3TVcYU=;
        b=h3TxYomgtI9uIurjctUS9iyY6q8Ekon0cLiT98+O4QzRrraWsErofLYgQRzkJVBtME
         vAV1huTqAaX9HPjepUhgtZwuNMdE7HP48i3WFX/Sxxdi9NPxQ8XWPntJlH1fZ96wXKy1
         FWWKEMy7IhGCthGiG4Wgn3HzMw3y/I3YAkL2KiLGCsAGUGHXsvdWLdDrB9IeFOQeRYMF
         jPOHCs0nSet+lFrsUrdyRLYg0PYiGEvUudHj2eOCfai1BsIRi1AOC0BZFbgyikDHB9+B
         I88k40pMclvFUfVCc+9Ccet2fP7vhzVK9WPisyQSizTEfXiqhh66V9oFhAzfs2I5ItOl
         UK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865211; x=1776470011;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nr1g2FHUeGn3VK0c3AFEuLVs4Ynz9EITyADBY3TVcYU=;
        b=HD/cni2y2vMEhTXlglNZcV8ausCF3vicrGMMMPTc9/yM4i3aJL/wIXuTDozY1uXfgs
         8nJ07Xs7TIv3UpW30CDMAvgJa+oI0JQk2QRBfcXB8MqaVGdH8UM1U+1/AMUIvbyvXhiF
         SW+CCq1477bzHUX4VFXxIsZvqVeLDwlmQHHaOvESfs762wZnj311166Jp818RABdBGic
         hmKdv0B2BdoPQrOZ8DpHiEJOkKgXjH3JuMtWWUxFQdP4RU3SwMT0ojuc6vJMQwXOmbxk
         g2opERKUE7YS3nPVmLgNAvNBvBE11HwUg7tS0MW/cEwW6pN/ks1H1zut3mvu/yaRrtoz
         kTAw==
X-Forwarded-Encrypted: i=1; AJvYcCWTRzPVfL+qEtaOlKZka8R8Oz0EOUKwloWuynbiXPBwEFtOPY4zGNAK3ja3gKF34+01EUzNwUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwtbLFWF6VZyeEPaLmCjNrXzE4KL11wUPJUXsoUnYlJODq8bI
	FDGjVUs2CVPkyP5nNjAMux+s318qmLFbRbLuiWhTpBhA9tLAixC7BzqU7KNN60fQswHJt0Z5zey
	z4sAhLw==
X-Received: from plsr17.prod.google.com ([2002:a17:902:be11:b0:2b0:ae6f:27e0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2cb:b0:2b0:bed1:46f7
 with SMTP id d9443c01a7336-2b2d5a74a4amr50685925ad.37.1775865210800; Fri, 10
 Apr 2026 16:53:30 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:53:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235328.1773449-1-kuniyu@google.com>
Subject: [PATCH v1 net] tcp: Don't set treq->req_usec_ts in cookie_tcp_reqsk_init().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277618-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 969593DD958
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit de5626b95e13 ("tcp: Factorise cookie-independent fields
initialisation in cookie_v[46]_check().") miscategorised
tcp_rsk(req)->req_usec_ts init to cookie_tcp_reqsk_init(),
which is used by both BPF/non-BPF SYN cookie reqsk.

Rather, it should have been moved to cookie_tcp_reqsk_alloc() by
commit 8e7bab6b9652 ("tcp: Factorise cookie-dependent fields
initialisation in cookie_v[46]_check()") so that only non-BPF SYN
cookie sets tcp_rsk(req)->req_usec_ts to false.

Let's move the initialisation to cookie_tcp_reqsk_alloc() to
respect bpf_tcp_req_attrs.usec_ts_ok.

Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/syncookies.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index fc3affd9c801..b5f0a65c6786 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -286,7 +286,6 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = ntohl(th->ack_seq) - 1;
 	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
-	treq->req_usec_ts = false;
 
 #if IS_ENABLED(CONFIG_MPTCP)
 	treq->is_mptcp = sk_is_mptcp(sk);
@@ -349,6 +348,7 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 	ireq->wscale_ok = tcp_opt->wscale_ok;
 	ireq->ecn_ok = !!(tcp_opt->rcv_tsecr & TS_OPT_ECN);
 
+	treq->req_usec_ts = false;
 	treq->ts_off = tsoff;
 
 	return req;
-- 
2.53.0.1213.gd9a14994de-goog


