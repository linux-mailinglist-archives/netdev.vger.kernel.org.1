Return-Path: <netdev+bounces-259531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPheDntKl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:38:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE41614A9
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51E0730166FF
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DF134FF5D;
	Thu, 19 Feb 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4pRTxQd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562634F481
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522680; cv=none; b=DymAU0tUTlYVbNvhgXc3dgzhMAjS2Jw3SJ9IiDiJhJzNoeMzC2Jh2mZQqqcpwyId5lXbOd6Ithb27AEFXJJJDpxKewIr+aZ3OfgHKVG+MFWKFnq2Guaa4HcWk2KPW1fRk+cp0f+kJ6ZPsrAOCvPrA3qg7TdWmjq0GyeKhKbPpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522680; c=relaxed/simple;
	bh=KV2rSveKLlsEUiPOhobYTSa074sCG5JYWi41NMS/Z8s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BrUqnn1luYBi8OxflU/5S7zHTyNDHMdY4GfzSfjhTgCKsYHTnQnDnFv7LwJ8xOHs7rdCANhOy2WxwYaw8YNq/cVOk86UGmG/BsgMozCGyaHcTyMblo+pULSsOepIPhzc3mnSnUeWpEE8afxnUDjHpUeG6ciGaB5LmP6LvaUZ2tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4pRTxQd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354be486779so4657944a91.0
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771522679; x=1772127479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U+Iw0b6KfBvQUyazI4ICr9dPs40QzN0uJ3fvkFSRfOo=;
        b=e4pRTxQdjZwMcglSFWcD7oB2G+8XGVU7mcSFO6/pyMNSaBTES3pQRNrKgNa1rtbRBi
         lNX9T8KC2DVojLZE03Y1aZZuf/Nj/tLlKMw+bzycGF0cJEiEFFfcm8HSaCYNdyeNoxN5
         ev9z2PIk7uue8xHLnQV1DCv9rt5Qc+6HS8Khdwa7xoxGvYULmYgUNEy42g6nr5OSNvWH
         396SYPfpSz65bVLA6azAFwRX6tp1LCtTZCbD7ID8/DoIeB8EzgZtNwmB4ulDZaHv5iuX
         oM/pHKhpOYR7EHDrMhItbu35NgUbu4Dg962JSjTQpqE9GmFFIiUGOz17Nc7yV1eRHxnJ
         mXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522679; x=1772127479;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+Iw0b6KfBvQUyazI4ICr9dPs40QzN0uJ3fvkFSRfOo=;
        b=q0HTYNP8WfU5fnCDII1AwHvd7I4KInyCzZ0DRN/1lLYtEREh8caVNyvyQAEokA1d1w
         huzPSHs6ZHb/+Iv3qHQXxGsiDAX/lT4W3eK0ZzZkQjLQTc7V2E4GZIH7+LTxfoOa2EAg
         v5By3Xmk6pXqXsX6r9rujPvWO7eeaEhHqgbkoges3+gUGAXHJIrkYlvz+guqbxQlje7Y
         T5Cv07Ils28G8SXlkP2z5OdcmgGb7zbrsodHSPSUPPTAYlCCzBNiZ2E8ktzAo39WykDd
         6yBrLiEtOrmpvR/vgRuY4fyMXP1gOdON8yLoyAj7t9fHwu801O69G5/LbtCYC3Pi5lOk
         Pnrw==
X-Forwarded-Encrypted: i=1; AJvYcCU6pVnOHkWUDLT/Ox9LshbbalqiIC7Fbn5E0rGSsabWaRLRrHAV03nDExwGceVVJuJ1F1C6PAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBeJ0OH/AlmybpYD8jnwAQ6gcOXgs0A2h6TYYiRi4ToMiLVG7
	pdzm8DmiBi0W8ZVFTd7uQkjbMsPkRi2qwjojYIUtHYnoqDl46oTYePPsgTsic8m4vHGI9Vu+nMU
	LXotxPg==
X-Received: from pjbnh24.prod.google.com ([2002:a17:90b:3658:b0:356:a274:747f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d808:b0:34c:99d6:175d
 with SMTP id 98e67ed59e1d1-358890a05b0mr3454675a91.2.1771522679020; Thu, 19
 Feb 2026 09:37:59 -0800 (PST)
Date: Thu, 19 Feb 2026 17:37:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260219173756.315077-1-kuniyu@google.com>
Subject: [PATCH v3 bpf/net 0/6] sockmap: Fix UAF and broken memory accounting
 for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259531-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97DE41614A9
X-Rspamd-Action: no action

syzbot reported 3 issues in SOCKMAP for UDP.

Patch 1 - 2 fix lockless accesses to sk->sk_data_ready()
and sk->sk_write_space().

Patch 3 fixes UAF in sk_msg_recvmsg().

Patch 4 - 5 consolidate sk_psock_skb_ingress_self() into
sk_psock_skb_ingress() as prep.

Patch 6 fixes broken memory accounting.


Changes:
  v3:
    Patch 2: Use WRITE_ONCE() in udp_bpf_update_proto()

  v2: https://lore.kernel.org/netdev/20260217000701.791189-1-kuniyu@google.com/
    Patch 2: Cache sk->sk_write_space in sock_wfree()
    Patch 5: Keep msg->sk assignment
    Patch 6: Fix build failure when CONFIG_INET=n

  v1: https://lore.kernel.org/netdev/20260215204353.3645744-1-kuniyu@google.com/


Kuniyuki Iwashima (6):
  sockmap: Annotate sk->sk_data_ready() for UDP.
  sockmap: Annotate sk->sk_write_space() for UDP.
  sockmap: Fix use-after-free in udp_bpf_recvmsg().
  sockmap: Pass gfp_t flag to sk_psock_skb_ingress().
  sockmap: Consolidate sk_psock_skb_ingress_self().
  sockmap: Fix broken memory accounting for UDP.

 include/net/udp.h  |  9 +++++
 net/core/skmsg.c   | 97 ++++++++++++++++++++--------------------------
 net/core/sock.c    |  8 +++-
 net/ipv4/udp.c     | 11 +++++-
 net/ipv4/udp_bpf.c | 11 +++++-
 5 files changed, 77 insertions(+), 59 deletions(-)

-- 
2.53.0.345.g96ddfc5eaa-goog


