Return-Path: <netdev+bounces-227209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB94BAA46B
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 20:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20BD57A3FA2
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD9D22D9ED;
	Mon, 29 Sep 2025 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQCmtr+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F3222565
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170082; cv=none; b=ci0vDW9885/45pkgzgWvQL+tiSLCKCgp5+VlTKedtMbpFHMyukPyE5Y/DyzD+6BEvHtc5ZnuEjStRqVxBnktBT8Ut4Uj7UhcbIhwcKDNat9P42X3tlscjfCUkd0hTrp1+EL8UXCln4qJLzWBcz3a31w/tq7VMaHIPmpuxNJl7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170082; c=relaxed/simple;
	bh=JLmkp+5ccC7VoHjlaAScfSZbR6nBm5jIlPeRWJWn8QI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PKio+7HchPyTE2CKuuNTKGhcJxj4agO4nn2qshlG7ph3ghU72ME+6gCpMAlW6D1klCbt3X7gOwL4en9G8nn7zHYYu8xbjqMlTQZMzfMPt6aP54s7EAG3TX8nYt1VnWTlRXWUqj+aTcB9hXAWvEJ/G9Eel+mAXdeJxmXoq/PA+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQCmtr+s; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-85a0492b5feso1547065085a.0
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759170079; x=1759774879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sIsGsfhtiSI8+1biYLTkLRdvJlbHmgWfmp96/kaWSEM=;
        b=hQCmtr+skE0kRmGGJT0NS+JgZNZCm62p31NqvxkFtg3f1xitReRqe2d+5HOpGJiJxO
         y8qvmrg9AIFGzykFb3HUXhq3oMD/bc0wIR7l23HWmaC99QDCToInQ5mwBpY+6+uzQpSg
         UTM9uYcu9KAmuoJ8sJysXU+Gf/+6Rc5tAo9ds76ovdfxAdgShTLWkB27+lcz0+ijnNsf
         z58XzsamTRntpfQaNDhy0TxK38XAsM6n7Rh1zmkzglj8ZVxe+Wvt7H+mzr5BiebTP2BH
         pbT9mCUvho6VZ4df4ZlgTedU8OnpyHR9Oj8iogPAaYxATBwK4NBpxlqPYcAgXuJNR0II
         CfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759170079; x=1759774879;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIsGsfhtiSI8+1biYLTkLRdvJlbHmgWfmp96/kaWSEM=;
        b=wVOEYfmDQhYAb/jjn0gD0zJm8BndpyMCaWatfVlxoYdSFytCiHwhEwlutXU96S9bIH
         UocnN2iTShGMkhyENwEot9dtJrp8MzJJflDg1o4+c9qf8+oV2U9MnQA2BWRoblGrFFP+
         uRJU2tildsb6LhM5vng89Ko9b0L4z1sC9KyHpEvWVyvKfJdcbIYrJ3jzPx0zid3uqWNQ
         HJEXjKzJWdZwc+1vJjLrXOWjdnGxK33q51thRb0GvpRwS9I7qvt6x1d8dM4c2dxI39yl
         YFCJHWUpSkDVWBxaZiyr4k/wLwpvnzav1C3IwKSSjyiHlcPGXD39y3k29dkTA8xcDofs
         nEqw==
X-Forwarded-Encrypted: i=1; AJvYcCXdAvSCqRJbO7/ntjz21tKP9R1++6q8sV+ew2jTQN1SFFm3voPvY3UOpmPakUYvjPA2iAhX2IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRj0+P9/ldwM+STqvYoEmLEu6JIMT5nefWb3LNBDd34KI0ZjfZ
	v3VCgVG6iFzoLiVLBk0iAkacu2Cyh8gr8FV/gfq9YaYz2bZeM7Qinj5iK3EfcIFIKFkUC2hrVxD
	qoMmmojLQ3S7Sbg==
X-Google-Smtp-Source: AGHT+IH9HWTI2j/BBfu8jgyTPlIPs0hLPX0eFZP2pZnJ3llRuUIyO5sOHl/Vs7hLjgCEis4vVHCXu9oQeeq6hQ==
X-Received: from qva22.prod.google.com ([2002:a05:6214:8016:b0:7d2:6408:64d7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:413:b0:820:a83:ead3 with SMTP id 6a1803df08f44-8200a934251mr182233176d6.23.1759170079586;
 Mon, 29 Sep 2025 11:21:19 -0700 (PDT)
Date: Mon, 29 Sep 2025 18:21:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929182112.824154-1-edumazet@google.com>
Subject: [PATCH v2 net-next] Revert "net: group sk_backlog and sk_receive_queue"
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, kernel test robot <oliver.sang@intel.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

This reverts commit 4effb335b5dab08cb6e2c38d038910f8b527cfc9.

This was a benefit for UDP flood case, which was later greatly improved
with commits 6471658dc66c ("udp: use skb_attempt_defer_free()")
and b650bf0977d3 ("udp: remove busylock and add per NUMA queues").

Apparently blamed commit added a regression for RAW sockets, possibly
because they do not use the dual RX queue strategy that UDP has.

sock_queue_rcv_skb_reason() and RAW recvmsg() compete for sk_receive_buf
and sk_rmem_alloc changes, and them being in the same
cache line reduce performance.

Fixes: 4effb335b5da ("net: group sk_backlog and sk_receive_queue")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202509281326.f605b4eb-lkp@intel.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: added missing SOB (Simon feedback)

 include/net/sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8c5b64f41ab72d2a28c066c2a5698eaff7973918..60bcb13f045c3144609908a36960528b33e4f71c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -395,6 +395,7 @@ struct sock {
 
 	atomic_t		sk_drops;
 	__s32			sk_peek_off;
+	struct sk_buff_head	sk_error_queue;
 	struct sk_buff_head	sk_receive_queue;
 	/*
 	 * The backlog queue is special, it is always used with
@@ -412,7 +413,6 @@ struct sock {
 	} sk_backlog;
 #define sk_rmem_alloc sk_backlog.rmem_alloc
 
-	struct sk_buff_head	sk_error_queue;
 	__cacheline_group_end(sock_write_rx);
 
 	__cacheline_group_begin(sock_read_rx);
-- 
2.51.0.570.gb178f27e6d-goog


