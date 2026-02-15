Return-Path: <netdev+bounces-258792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC6QJTQwkmk8rwEAu9opvQ
	(envelope-from <netdev+bounces-258792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:44:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF05313FACB
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E03230421D8
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 20:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5AD274FE3;
	Sun, 15 Feb 2026 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLGCj3oU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD53043DC
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188239; cv=none; b=CAMCH+81QvRtlizehlsSCBdHjPnQKNrqLtIZtravZfwkaPGbqfg5hXtPWuh4AWdrvWNitk7PBEljEHl5kUvozLl9UA8AD5APT+CuiProZcfq3t8lHC2zz4GVpUhX4mphTa0MwVRr5iIYLbdWpfZKcsUc9kkUk+brlqMz+J1SRek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188239; c=relaxed/simple;
	bh=o+yVCiY78QhoLCqpwKO3FNueFAZmzLearb9gcg4AbIE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b5fIrJQUpXu5e0FlMhd0SdOXvVW/mpLnlH5xkVLI1tV7a1mvywr5H0jrEeX6lMnZvuAi3gjUM97db9U1SeJ2oTFJiGTDMd3TFUaLd6VaknZwlfN/nX89vx7zZEwiQ1PQD0EQR7Faj1Q1Q5f9dS3UlkjMviG/JwNCu1cNkxUjZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLGCj3oU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354bee18a62so1891010a91.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 12:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771188236; x=1771793036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JDzLkkwQ2zndYGmIa0T9VkXy0vnxohQ08L3DQyRoTBk=;
        b=mLGCj3oUOkA8KWyszuP2lPRDxZg1TRuOwmSXQYwOHakRMe0q5KzBsBs5d9xqLLzm/a
         BPjlXXltnr6EVDurivo6rNvetO+ttukVmfAHG1lhwhgM1AfAu9jPnrHjFnSSy+oJaEQk
         Bjl6YvC7IZ2ajA95Qz/akdFJeHzsblPkCom9ncxufRzkp5tsUdFAeeu+qbNft19lzDHK
         9vWTyg4kNPDu8asG49imJbJxLLlFpiA1KjmWhmdnhpTA6zCJqlRIpuucVZ7K2tj7ETKn
         FYf7sIWXQ2SYquiTsguu6stVqx88kSqfP/J8xvqY7lETdaM2oV3IvH9qyNC0Lgto2vVW
         sJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771188236; x=1771793036;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDzLkkwQ2zndYGmIa0T9VkXy0vnxohQ08L3DQyRoTBk=;
        b=WVriYXh+0SHR5nXsUqWxa4tbGDbOWb7wPSjNuLjSsxb4lYZPqHSyTh9bo/JW0Ksaw6
         PizRt2hcT8V/okokYiu0/v7nl7fejaRB9Itm2U5O5FUl1xMe9Wq+I/IC+Zu4PB6cx2kJ
         mITUrIM32zlacNulbvNc7TSMqWXd4mssDLSfmGKq5seTkkd4C662mNfjgT9r5oRjnNA5
         stCIFXlaZa3gDvfhARmCQW546wykqwqO3RqZidlHBEtmKIyrUpvFHEI2kTv4kYudpB65
         E2BHelg6mYbCV1uipmDvhmGdaPjyDYIftGj+QCwfoXvSc85Wh8IDUalUegojctmluMoX
         lE0w==
X-Forwarded-Encrypted: i=1; AJvYcCVv+oLWfd260NwJ/CTqThmsjtSE0un9Qym5aphy19rlaFgzbrCiFqMqL8qw2rBl6JeY51DaNJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywggyw+e5fe9qlVmppFhTON++HypSFCMnMuXroD8vxS38njO1QG
	Ud5RM69SoUC101BeNsRO7Z+gh2KBCVCpSBEVFLC6Iw35chOYyZhwB59V9KuYKzi15snWIyK1i9I
	/wvF00A==
X-Received: from pjbkk11.prod.google.com ([2002:a17:90b:4a0b:b0:354:e865:5165])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:586f:b0:34c:a29d:992a
 with SMTP id 98e67ed59e1d1-356aada821dmr8183369a91.34.1771188236118; Sun, 15
 Feb 2026 12:43:56 -0800 (PST)
Date: Sun, 15 Feb 2026 20:41:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215204353.3645744-1-kuniyu@google.com>
Subject: [PATCH v1 bpf/net 0/6] sockmap: Fix UAF and broken memory accounting
 for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258792-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,bytedance.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EF05313FACB
X-Rspamd-Action: no action

syzbot reported 3 issues in SOCKMAP for UDP.

Patch 1 - 2 fix lockless accesses to sk->sk_data_ready()
and sk->sk_write_space().

Patch 3 fixes UAF in sk_msg_recvmsg().

Patch 4 - 5 consolidate sk_psock_skb_ingress_self() into
sk_psock_skb_ingress() as prep for patch 6.

Patch 6 fixes broken memory accounting.


Kuniyuki Iwashima (6):
  sockmap: Annotate sk->sk_data_ready() for UDP.
  sockmap: Annotate sk->sk_write_space() for UDP.
  sockmap: Fix use-after-free in udp_bpf_recvmsg().
  sockmap: Pass gfp_t flag to sk_psock_skb_ingress().
  sockmap: Consolidate sk_psock_skb_ingress_self().
  sockmap: Fix broken memory accounting for UDP.

 include/net/udp.h  |  2 ++
 net/core/skmsg.c   | 90 ++++++++++++++++++----------------------------
 net/core/sock.c    |  2 +-
 net/ipv4/udp.c     | 11 +++++-
 net/ipv4/udp_bpf.c |  9 +++++
 5 files changed, 57 insertions(+), 57 deletions(-)

-- 
2.53.0.310.g728cabbaf7-goog


