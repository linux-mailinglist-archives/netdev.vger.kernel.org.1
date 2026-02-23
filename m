Return-Path: <netdev+bounces-259976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF92J3wonGl1AAQAu9opvQ
	(envelope-from <netdev+bounces-259976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:14:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C99174A5C
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1744830F0F82
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B10C35B12B;
	Mon, 23 Feb 2026 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hj+5Zb1/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE8F35B621
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841253; cv=none; b=glPbygdWR0PQpNnddlbHK3yn4cr5HUuHeCJ1Z+ObI3kXZuym1IBlifMR8Auj/KPeOVVMGA6pshska24NPKDQqfWqzVzL1K8+v2J7jYC2Wq2N2qH06sb6FSOjNKeAz51xJUS2WY8s/6mfYiwvEXHuP9MvCGwbFa4SuMrncsSDxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841253; c=relaxed/simple;
	bh=jwKW6cpV+ZyjPX/kkkxunfYIo6KP0rwMPTEhPfRlorQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CdGTuMrwRLiq3nC1QI3rg/Bblehlwj5e6PVTkGejYDxzrpCNbxKDN7Y1vkiv+i+554yr8DZV/gMhSXlRP/ZPFuY968Sx6piPgKNpAwmzGOvLBwDgvQ6DMoE6zET180Y9XLRvN0tB4xD25YUCbxlOUVAeazR0/CeY4Lu6iyiFaUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hj+5Zb1/; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c882774f0dso3962307885a.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 02:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771841251; x=1772446051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RmqC5c86SylRIJcAfVHLpoJ8mbTU9gLKG22Bip9Olxk=;
        b=Hj+5Zb1/uu7j2r5bn3LQpsmW5p7+lGmDUuaqkYyZoco68canwhDeXJz5zHU/z7dVBK
         TEWFtzEnatXpX5Z8vyVCvxHROo0uYOuVgEC91GayrMn02Hi2VtUMvVsZJ0EmNcmQSotL
         ocwWtMMmvDwgnP/DvOQtszMjbU8qIye/5cy1c1e1NlpsH/EiK4+3TmVGMSNANwYeWasN
         LlnuHHNLXYTA1/SeeCAFsYoVZlkm8vwT2mm4GiXkb85j6lioO3qQ7xaBbQJPXPLzTgzb
         G5Rcp//DRLh5kILBiqliYIbk6Yhf1iX9FFYENpkrvRNv2xG5HbixeikaR07bjWHQu+c6
         IsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841251; x=1772446051;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RmqC5c86SylRIJcAfVHLpoJ8mbTU9gLKG22Bip9Olxk=;
        b=uiXYxvGN/ZQ4kXHPdm83pIs8uxCvAf67z9sCDO1qDDBAr3Socgxga2UoHalfQSxZtZ
         UZ8OPR1QWm5LmgMN7UZiLTS7CQJHjkF6YLiTQOamVicdALCV89vDGA46VPQDp8C1t65G
         352htTWx114Uywp2SqasMuX4Pqxzp7FT5CBPBrv7CIoAwh0ouYctMYKilwOrMCE5YRAm
         dtbvFA0VPWVarrLco7dLJVZe/I/rrcLCRb0JfPP+jQ6Oi4am5muSsk/g+LsImLKZEuop
         fU+cEIyjiRgw8pxKirxuGnf/p+K6eYIekHLrUbbD389o68EpIKhUZlJjC5tiWRLK8hlb
         vCgw==
X-Forwarded-Encrypted: i=1; AJvYcCU2yIzWo7NGI72i5i4c7mKNgBpUeIxg8cCsONkhrfvlFn5X/S472mfsPNOJSYCNqjzovrCtTyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvioZY5bg8mpmM2pSV/LerW5yGHCW2ydW75kjgNMJ9Efrnzlv
	a858cNQs6AVV0QgpOP5t+5Aj1bnMX8OTV2TAoo4jDzVQQ698w5iOXaSRDp9oEVReRH+sc0RvXok
	zvAUEToa7bok0jw==
X-Received: from qknpi2.prod.google.com ([2002:a05:620a:3782:b0:8cb:48d2:657b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:40c1:b0:8ca:d5cb:6835 with SMTP id af79cd13be357-8cb8ca71ce2mr940267985a.48.1771841250737;
 Mon, 23 Feb 2026 02:07:30 -0800 (PST)
Date: Mon, 23 Feb 2026 10:07:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260223100729.3761597-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/3] tcp: rework tcp_v{4,6}_send_check()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259976-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14C99174A5C
X-Rspamd-Action: no action

tcp_v{4,6}_send_check() are only called from __tcp_transmit_skb()

They currently are in different files (tcp_ipv4.c and tcp_ipv6.c)
thus out of line.

This series move them close to their caller so that compiler
can inline them.

For all patches in the series:

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.3
add/remove: 0/2 grow/shrink: 1/3 up/down: 102/-178 (-76)
Function                                     old     new   delta
__tcp_transmit_skb                          3321    3423    +102
tcp_v4_send_check                            136     132      -4
__tcp_v4_send_check                          130     121      -9
mptcp_subflow_init                           777     763     -14
__pfx_tcp_v6_send_check                       16       -     -16
tcp_v6_send_check                            135       -    -135
Total: Before=25143100, After=25143024, chg -0.00%

Eric Dumazet (3):
  tcp: inline __tcp_v4_send_check()
  tcp: move tcp_v6_send_check() to tcp_output.c
  tcp: make tcp_v{4,6}_send_check() static

 include/net/inet_connection_sock.h |  3 +--
 include/net/tcp.h                  | 12 +++++++++---
 net/ipv4/tcp_ipv4.c                | 19 -------------------
 net/ipv4/tcp_output.c              | 27 +++++++++++++++++++++++----
 net/ipv6/tcp_ipv6.c                |  7 -------
 net/mptcp/subflow.c                |  1 -
 net/tls/tls_device_fallback.c      |  3 ---
 7 files changed, 33 insertions(+), 39 deletions(-)

-- 
2.53.0.345.g96ddfc5eaa-goog


