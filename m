Return-Path: <netdev+bounces-271748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNhnMOpSxGljyAQAu9opvQ
	(envelope-from <netdev+bounces-271748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:26:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2603F32C664
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04BD1305E340
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D92C0270;
	Wed, 25 Mar 2026 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCBcwE5K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633EE38E13F
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473886; cv=none; b=Txzm6PWh1NyOrtC9wLZCnGQ05sxo1vOeIVA72seaZHeSQEixI4C/cXD7/VbHBXsKVlY1R+ebmTcpdgTUHXD+XfYjt7/LaF5rT8ccMzZY/ahlc4CivOyTmCSF+uIYhlR/lmORMS4cT8gdZS//lDByXRmLchkjwEG2sWzsb+iCHeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473886; c=relaxed/simple;
	bh=ohq5LI+tvC3WN6rzfGFvW+5Wk0NRLxkKVo5xChInWBw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Fvbd1v3v4DVoH/81Mr/FqCat/Wx1veW8c3eHhLsdawNm21P57d2mK/thMeTE4TkVY+GKgE8QuFS911p1oLiRiQA+mCFTbUXqkaXgMY5VxcFsv6Spxq3+q6Lb1qlz75IiirGJzCc51IABJ7+xVosEcX8mOSrtvGU8oBfi2d6QuqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HCBcwE5K; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b44f7b7bbso11582561cf.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774473882; x=1775078682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0moPH9lNF8lhFs5nw1BWpXVMdkjYFNcHZVV82K+iuRc=;
        b=HCBcwE5KAUwXpsw/HCDizgLpdYQ44LSwl7uuh1M4kl3Q0/eJIm/Wr6eF+loTXI41G7
         db3CTQOF0mpxr08NnlIr1hkB1lZz194ieIJgbHYnnC/hyS9OIN7bGCfUqz4zera2z3+U
         IhJ1meWNpNnWzjuX/bAs3HDeDFJx8mOcYwl6fulDcESGHS/K0lfmObbQDxqObanJtfDI
         hhdiCh/XzWileii1xET9zHx7HpO6/qm09MTCaI60EwdDqy+cFRPwKNixuLsEtAFlUJkN
         RmQGJpPVvyzQrQD/hOEccttaCQM9UVaFvuFDBozpfQQVQXaG5kXT+I9quai+Mc3fwYfV
         UWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473882; x=1775078682;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0moPH9lNF8lhFs5nw1BWpXVMdkjYFNcHZVV82K+iuRc=;
        b=YrnFT7xrC8SU3gVLgb5VhsNV/D5FzELWofL6i/irfl1U91jvMOEYEk8SdMmvF9kZpb
         ehGne/18VZCJ+SKzW6pMFVVUT0XXMOfVDN/ihiP/zTVpjU4tqIIfsOk5dwk8iEypLlVN
         6P7iue7OSvWkHoAhX0/ThKk3X8N6I1DJetzmGmfLcGUJT5Tts3qzta/JmE1mhvmCmhMQ
         ntvoR5McrNUU4mjd72G6wg1B4A6HYTGIN2D9LjQfE/soLlSg/MLC6xHFvAbP96dMuuCX
         CbH0imd7/p2f4llu4iF9s9OYojtq69hI8e7/7Vzu3uxn9kPX82GdyMz94/yuwJIjQy5m
         xfkA==
X-Forwarded-Encrypted: i=1; AJvYcCVu6hUixSXHw/h8rjDR6eM8n8g6izNxoODpgb/ILskfxlee5dJRU4DfwVGJmYLA6oD9xpk5iG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyysIiUTPVEiCDz+kQ5fXTZyIbMg6mHZ8mq329+gePeawhc6pLk
	SPt/Ax4P6YlUW6PoJSThLmHplmafqPTnzajRJEsDfc1SzM5KEW8ja5RMSA+0svI53mYUn/qcwR/
	+fXKQX4RX0IM1Hg==
X-Received: from qtbbb27.prod.google.com ([2002:a05:622a:1b1b:b0:509:217e:82c9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:831b:b0:50b:31ad:32a2 with SMTP id d75a77b69052e-50b80f2ba09mr66085651cf.65.1774473881951;
 Wed, 25 Mar 2026 14:24:41 -0700 (PDT)
Date: Wed, 25 Mar 2026 21:24:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325212440.4146579-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: tcp_vegas: use tcp_vegas_cwnd_event_tx_start()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271748-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2603F32C664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While net/ipv4/tcp_yeah.c is correctly setting .cwnd_event_tx_start
to tcp_vegas_cwnd_event_tx_start(), I forgot to do the same in tcp_vegas.c

Fixes: d1e59a469737 ("tcp: add cwnd_event_tx_start to tcp_congestion_ops")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_vegas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_vegas.c b/net/ipv4/tcp_vegas.c
index cf12fb6be079d8ccd65f297a3a90a9a5e90036e8..950a66966059e89fc108a31c106805a0f76fc6f0 100644
--- a/net/ipv4/tcp_vegas.c
+++ b/net/ipv4/tcp_vegas.c
@@ -319,6 +319,7 @@ static struct tcp_congestion_ops tcp_vegas __read_mostly = {
 	.pkts_acked	= tcp_vegas_pkts_acked,
 	.set_state	= tcp_vegas_state,
 	.cwnd_event	= tcp_vegas_cwnd_event,
+	.cwnd_event_tx_start = tcp_vegas_cwnd_event_tx_start,
 	.get_info	= tcp_vegas_get_info,
 
 	.owner		= THIS_MODULE,
-- 
2.53.0.1018.g2bb0e51243-goog


