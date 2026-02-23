Return-Path: <netdev+bounces-260007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBSCAM47nGlCBgQAu9opvQ
	(envelope-from <netdev+bounces-260007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:36:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 598E5175993
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8583B300CE47
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3136404B;
	Mon, 23 Feb 2026 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VETXs1yH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE83624CE
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846507; cv=none; b=gHiLtyX5NffOyvwcBWtHepBN+Bcjx7OrNf6N+fLnUD1jDCeFG0Tly0wJWq/mVAx223lNE+PXFjfLReQM5+TZt96077SsoiWlZavoWh2UkcAETJDLIm6ogSnA+VCEu/ls74k0fqKatdTSVUh4TO5S9uBLOugqn1jpFfZYyhDOnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846507; c=relaxed/simple;
	bh=ChIG+CSqgG68WD7WDeEhDn/9P/dPdxnOOZW/4GW9ln4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rtGe6SLdPCmhuHjZB+daYoIKgyPxra9SfC961PBcGrmgm9rxpiFqTQJxVRGDYPXM6pk1DBqphsEQBZUHW0V17cjZt9QeVafyMhWC8ETc5RrLo4smznzItcNTQFpxP8HH+RU+POAVIh9arW5JATfo7/5pP3zFxfc/jzlXSYbP3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VETXs1yH; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb4d191ef1so606375685a.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 03:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771846504; x=1772451304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tmhz9JjBq7tnFMyTTi29d1kC4osIt5a6RvwDJlvCZgg=;
        b=VETXs1yHF8SNPUKKq2IV940TkeyogJ5UObfWMPz17mPegQ3IdiaqGKyqA6MRetvu2o
         ir8TzEBass+F+JZ+hWak8EejagNvse/klugJCQRsRDKiGLqQeUIm0Ntbrlrmk7h5+3ZI
         6OBMhjOMqf+kyymK4tsO9Ah1+c0xtZ4QjewvY40Zv1Hxh9y1pRVidR7wAuieXpEP9zcg
         kM1d8URitrcRK0dxEHRGVt4Zm/LlzYTFC9oyEyTBgZHgDisTXWK4Z29aSv42wyEed8bI
         FOczlLjj9pBKGAr2QzLUg+uAqY41Z/onu+dliVvJrUZs+QD0hlAAi+4WogcE+gbIYamH
         ai5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771846504; x=1772451304;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmhz9JjBq7tnFMyTTi29d1kC4osIt5a6RvwDJlvCZgg=;
        b=SV9Rwj1N1/A2g0mLGHjV8xra8SGwf3yJpMjFbP4FJLOZXTF3rSLoiK+yVLqUcMUiav
         7ciH++26IfCoM8kK2lcacwpwOYm3gtr1WnNmMfGPl1e++bK9ubUoxpbWSV9cfVCJXUtm
         oWxOXI9I37xmlE34F66r4k4EDDIibZ5O158L8w0RbOozP+S5+1/R5EyynZhhGcqaLdjs
         mZMZNtQcVPqGI5J9w6/RI9Bv3/Gd8HZNGmWfZu5e/4MGvj01SaY7DxFHuBBICeds5r5+
         ZTAiFZxlWS7v14XbdAaNFyf67wy7caKPbe14PZwNpXbweAYf6bEkc2i6n2FSliAyGTFg
         iisQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbMcj66+KVCdApnrKpcRSQwGgAxExFw+rzF2tK5FEzVDC6KJBaLdzIWJDN9g5/byEdXJZGrUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoV6Z4vM2Plx7kFHsceLD4O9xOdQPll+eAKJpj3rRhWDfXW2La
	YtSQkX9/7+tGvMHVvAKf1ls0YHPo2kx0FmDatC8N3wNYARmeuaTWyLfniYfypxbDFBHy9vc3ZUe
	ONRy7CoSd2/iDyg==
X-Received: from qknqv11.prod.google.com ([2002:a05:620a:8acb:b0:8c7:ed7:f44f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:45ac:b0:8c9:fc46:235c with SMTP id af79cd13be357-8cb8ca923fbmr886321685a.71.1771846503730;
 Mon, 23 Feb 2026 03:35:03 -0800 (PST)
Date: Mon, 23 Feb 2026 11:35:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260223113501.4070245-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: reduce calls to tcp_schedule_loss_probe()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260007-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 598E5175993
X-Rspamd-Action: no action

For RPC workloads, we alternate tcp_schedule_loss_probe() calls from
output path and from input path, with tp->packets_out value
oscillating between !zero and zero, leading to poor branch prediction.

Move tp->packets_out check from tcp_schedule_loss_probe() to
tcp_set_xmit_timer().

We avoid one call to tcp_schedule_loss_probe() from tcp_ack()
path for typical RPC workloads, while improving branch prediction.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c  | 2 +-
 net/ipv4/tcp_output.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e7b41abb82aad33d8cab4fcfa989cc4771149b41..6c3f1d0314446966d0ec4e8efb0b3d83463990d9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3552,7 +3552,7 @@ void tcp_rearm_rto(struct sock *sk)
 /* Try to schedule a loss probe; if that doesn't work, then schedule an RTO. */
 static void tcp_set_xmit_timer(struct sock *sk)
 {
-	if (!tcp_schedule_loss_probe(sk, true))
+	if (!tcp_sk(sk)->packets_out || !tcp_schedule_loss_probe(sk, true))
 		tcp_rearm_rto(sk);
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118d02fc396753d56f210f9d3007c7f..ada38dd9cef477e16ff77544bbdd057d695fa978 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3116,7 +3116,7 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 	 * not in loss recovery, that are either limited by cwnd or application.
 	 */
 	if ((early_retrans != 3 && early_retrans != 4) ||
-	    !tp->packets_out || !tcp_is_sack(tp) ||
+	    !tcp_is_sack(tp) ||
 	    (icsk->icsk_ca_state != TCP_CA_Open &&
 	     icsk->icsk_ca_state != TCP_CA_CWR))
 		return false;
-- 
2.53.0.345.g96ddfc5eaa-goog


