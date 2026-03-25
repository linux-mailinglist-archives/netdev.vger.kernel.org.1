Return-Path: <netdev+bounces-271410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCAuOHuDw2kPrQQAu9opvQ
	(envelope-from <netdev+bounces-271410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:40:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DFD320428
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B7EB300462B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C366358360;
	Wed, 25 Mar 2026 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m1VTbo2q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6F3563C4
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420729; cv=none; b=McQ/Z0Z5Gacfb4Nt/B8sJnrFBfqMQe6uXRhFGTIKuNIBHWywYqhUeijnp4UnqTGEsZCgjUYAuc4I5XndUY1rTItQFDhWXk1ZoK8WytP3HrdmYDhfDgMgtXJD3P4TGXhos8fwRdpspWChyWjo0399VZpeISHGF6gKYPtyAwU/MA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420729; c=relaxed/simple;
	bh=G4aUuv5IRjPHJ6XkBrei8QQPcxcp4XaxNuNC+DQhCwM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GHP+KTQ48K5A5Nh3sK5ePRji2mltwIykbORwH1mAKc1ngiJIqNa/KVQxlc9CckAVAikK+KQAnYzxsj7dc4+vpc9JbgdoTxlY3hjpZmzzSlR1QncEcj++KRv+dZIckswKLqSTHj9vtw0J5H4wb+Kk+5I/WKoFJT5LMDcDJmC3IHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m1VTbo2q; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70dd30025fso20137143a12.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774420728; x=1775025528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ps9jyH80iSRUMtuSLZrvtXUJpNI4M5Ryo0aSIRfQLmU=;
        b=m1VTbo2qpdnd5ygOgTnjLXTzutkZvyEB38IqONUSlrrnF+2Le5zmJFUGLUVleznO08
         tirRrpOFbqqNmKoPGRb0CeOqBpCvLjIMYa1ced+Xcmy+qYUvJ2k7rBZ5okJTKtERKW8P
         GQUEFJxFAJ/Xe07unUS4Y7/JkpVGl96v0n8c1kK5boA+pzo4/iyKDb8bwkB1y4p263v4
         DTGfo6ilpTzNbRu7rLSEl9j8ktjPaIqrf76SfmzxEOQ8P5VA+dzbZajP+Q6QUMh0N8tI
         q+p71ssLLPZJLpY8dstKvdCuPpGo2dYtFaTrFwc5XOLAOaGqkQ5YxGCP7vMr62N6G+d2
         YXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420728; x=1775025528;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ps9jyH80iSRUMtuSLZrvtXUJpNI4M5Ryo0aSIRfQLmU=;
        b=sIIHRTX74BUAxOec0SnhjFfW7t8WOdoKFQYjdOFNxFL4wBrL3/GLZdd1e3/tAdhiOa
         mVKoAlLL0kJiSuwOfD2rIiFHEY4f8/hYho+xhoxTilKSGBpiLdlcfEp+3eG/sy/Q4MZQ
         H+j+TMqnZoOHC0DXvG/9cRHy9lryyIEmtO3YlQl3r4L3kVhStq9Y3jw7qoWYS2KZCroX
         +XATr1voCwaTBr94gH7/RBZ71Wjjsiwc+kj44wylcHVCN7EAZ07e55mXD/wnT21eWDxW
         bru4VuSP6IY0qxWsGP+/GdFhA97jcuJtBzpRJlGLD4zbfuD1nMm52Ofcqgrs7W8OqVsd
         v2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWDPNiCWHMbhzkqoWtUM8bs4gVekxlkZ1Hi+EWggqj/05+k67nrwl5ex5FjitW4ETCLYWsFcVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Wk4/BIdQIfN8XAAMJLC2xhnfrDHnLMLi9vpMwYYUenR4MHnz
	I8h7oFAjxsaqxIdGV10AfPiMLiRCEBB/IGHwLF7hS8ee4Wm13ZrkTW6UhtZSTyz5wrrZIDxP05W
	8gQRBEQ==
X-Received: from pfbdf8.prod.google.com ([2002:a05:6a00:4708:b0:829:94bc:6c15])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4489:b0:82a:899b:d804
 with SMTP id d2e1a72fcca58-82c6dfa883cmr2464688b3a.38.1774420727444; Tue, 24
 Mar 2026 23:38:47 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:38:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325063843.1790782-1-kuniyu@google.com>
Subject: [PATCH 0/5] nbd: Fix deadlock during fs reclaim under lock_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271410-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,other.debian.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49DFD320428
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Recently, syzbot has reported 100+ possible deadlock splats
involving NBD, typically following this pattern:

  lock_sock(sk)
  -> GFP_KERNEL memory allocation
     -> fs reclaim
        -> lock_sock(sk) at NBD

Instead of spreading memalloc_noio_{save,restore} over the
networking code, we want to fix it in the NBD layer.

This series introduces a try-lock version of lock_sock() and
use it in NBD to fix the deadlock.

The try-lock variant should not fail in practice because while
the socket remain exposed to userspace even after being handed
over to NBD, the socket should not be touched by userspace.

The series can be applied cleanly on block-7.0 and net.git.


Kuniyuki Iwashima (5):
  nbd: Remove redundant sock->ops->shutdown() check in nbd_get_socket().
  nbd: Reject unconnected sockets in nbd_get_socket().
  net: Introduce lock_sock_try().
  inet: Add inet_shutdown_locked().
  nbd: Use lock_sock_try() for TCP sendmsg() and shutdown().

 drivers/block/nbd.c       | 44 ++++++++++++++++++++++++++++++++++-----
 include/net/inet_common.h |  1 +
 include/net/sock.h        | 31 +++++++++++++++++++++++++++
 net/ipv4/af_inet.c        | 43 ++++++++++++++++++++++++++++----------
 4 files changed, 103 insertions(+), 16 deletions(-)

-- 
2.53.0.1018.g2bb0e51243-goog


