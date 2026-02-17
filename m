Return-Path: <netdev+bounces-258958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xh8lBS6xk2kK7wEAu9opvQ
	(envelope-from <netdev+bounces-258958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 01:07:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB431482DA
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 01:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC6293011BC0
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 00:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF5B15E8B;
	Tue, 17 Feb 2026 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d91ndUML"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE21E505
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286826; cv=none; b=BrsjHUeP2+ZowYqvvUTlCnva3GrNJpVY4Mz1d4V6vMJoc4fPO38x+j7oPU1rsV5vpa9TcYYYbPfJSgCD830qqnZ9K266zrAFk45Gw1epcR/QM/rQbxHFkaZrG5wT08xPf16ViavPlgcULcOnz7r4chnPl9k/J+i6V9QsX3842bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286826; c=relaxed/simple;
	bh=8pCxpRyqM45J4HG13TljFBU1L/g23s6hvGeHJ/EXEmE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DBCSJn1dwUQi4+DG6rME0+cwGxdG3dBRZJZw6F24yWVJOq1/tkFnDdIJOw7qmVreTg0UdniVgIhcuhJO+hvO41fLcUftDsqnArDof50QZqSbVcDshRwauJrKmgmEPn+/SLGw99KT1CI8UOol0DHBnqyr3vTWsaSWYwPtC+zPhj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d91ndUML; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35621cea097so2324054a91.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771286824; x=1771891624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kHogz3X18n3wVg8pGsHsR4TK5Q9EDl5Af3JaeD24/1s=;
        b=d91ndUMLg5jN3VZ5OsOmeH5a+BVbZvuWxHAsb2smbPoXA0tDozCsKz7aKKGLtlr73d
         6rm8MhLVJ53m1D0ro0sWP/bPXphlxbTViwHlgm7e6rOz52LZ91w6flAEENBwyDYkg5ab
         5hsyhOuc+RVY0DOVFQE5t69VS9/iS4TInsH/Q2oBuXQTnUhPTlPV/Aw7T8c5WwFdLqup
         V+pgCGEemLDs6Ic44BuTzgxO4BMhJlW+OnaAsiir3I00RA9YxenvjJxCdy1ZaMk1+3st
         Mh2YCO1lX15EtCLIT5kAzrWeECQlGeiq/d4cN8g+BAc0kduNfr701SDPKKFvbaHEn7Zp
         fkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771286824; x=1771891624;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHogz3X18n3wVg8pGsHsR4TK5Q9EDl5Af3JaeD24/1s=;
        b=dgt9xI164GmOg1DVnqLlFN+GHF4rv8znSuDupf91IIjFPSknJ78aRX0T53810jB87n
         NSI4+2eUZcMB6ss4CsYAW2aGTpRkjjf8XndHa7NdVIH4d5gI1nhipxZIci3EvqouzVuf
         zkMkpDoNG1c35lI47gn4Quzp6Hja63XyTh2kMnHyxiawtxEDzRucWzJjJkGZ/J/BzXAH
         /akgcMeF7PxcCE/G53x6goBZbW+VvI/plGtW4wizSetInMhzmn2v0xQupFxywoQPcERA
         d6MFu7kkMSFkmT5LB8wTko4Nk4C+cTyDMMvC6xo9xIf0YjDyNOmhHz5efYTS0CnIdBG4
         cWPw==
X-Forwarded-Encrypted: i=1; AJvYcCVXqnZCwSoUQhJzP7YCblifzcriXnOXml9OJuWZSFqkbPLZjx8Efcx5YaP1QvySRoCzGECE/iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymvBEHOxKClTyVWbSL/cAEIK/djtLAk2XfPUKNOQqzCGVZ+lz2
	iEGhd6LLgn/jL1RvvzOasXi9XjC10NqdYayT2BzYCSbvGTWQwFP5NPe2FTndDCiGykraXoSk/Qb
	rFHIUhg==
X-Received: from pjbpc11.prod.google.com ([2002:a17:90b:3b8b:b0:352:ed03:9879])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b43:b0:340:b912:536
 with SMTP id 98e67ed59e1d1-35844fcc0ebmr7982530a91.31.1771286824245; Mon, 16
 Feb 2026 16:07:04 -0800 (PST)
Date: Tue, 17 Feb 2026 00:05:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217000701.791189-1-kuniyu@google.com>
Subject: [PATCH v2 bpf/net 0/6] sockmap: Fix UAF and broken memory accounting
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258958-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DB431482DA
X-Rspamd-Action: no action

syzbot reported 3 issues in SOCKMAP for UDP.

Patch 1 - 2 fix lockless accesses to sk->sk_data_ready()
and sk->sk_write_space().

Patch 3 fixes UAF in sk_msg_recvmsg().

Patch 4 - 5 consolidate sk_psock_skb_ingress_self() into
sk_psock_skb_ingress() as prep.

Patch 6 fixes broken memory accounting.


Changes:
  v2:
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
 net/ipv4/udp_bpf.c |  9 +++++
 5 files changed, 76 insertions(+), 58 deletions(-)

-- 
2.53.0.310.g728cabbaf7-goog


