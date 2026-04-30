Return-Path: <netdev+bounces-282749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPkTIDIr82mwxgEAu9opvQ
	(envelope-from <netdev+bounces-282749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:13:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B24A0941
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E9EE3009812
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A795B3A3802;
	Thu, 30 Apr 2026 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJVj6L0v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AC33A1A4C
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543225; cv=none; b=ll852WA8oKV3uMBEUoqcL3RSSz5MuyQcbFiQY+52ySH4C3W4C0RkGi7V0TJQsHnWLcF0AXKnsWAL0Y2EXUBUFPw95g4nUa7eHtHE13XTNGxHc/e7oz02dS+F43kMP9dzKPCkZtkh75R3jARoRx2ppVQf67wYPUTwQBYRav7A2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543225; c=relaxed/simple;
	bh=fvuhMcFsMun8vd0lubEMr3LOKMtsIAm8d7vussF8IzA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b0wjxQ58R+i2qpsVTYGdJYCEHFxO9axHXqDYXhJHSGETnNgqpf2xXd9jKHy+0nNqEZyIDEgZ/uW0M8IEgEmGkQVLmYmQzb4pji9qpmkdFqz2UBuTl0miXS2az766JqIk383wvKNaAgjhmzSbviWT+pMGPJc2t+8X9u1zr+pxY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJVj6L0v; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-79a670a5fe9so13732807b3.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777543223; x=1778148023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dTuGXf4G9hFP2OE6G2RtU9T9dFc18m6MNM4t5StKCzg=;
        b=pJVj6L0v3rME6jLwNtI/anf3WcCOJZb8ailH0ewIcWS+IzMuWFXP6/OU4GtYKcHsU0
         eWTKdb0kHmNQrPmPJvgr2INECXeyil+YNpIEr3xI31BO5LmAbEPnZYbK0eVL4pVpRI/v
         ISPxR1PvQPDGAS6e2xdGU9ktkYfRmnltqzk96JF9YHJnt1F7qv4cN/HJMmYtoCp/KEcA
         k7CFkRNJF/hqUQTi3PB7VJvKaZMegPRXRgKVMA0xf/kyeapcOFbxN29tX45GBFu6D8OE
         vQ14FxVO9CurA4IF7iYI34f8DFs4B58UZUE5rAXv9BgyVa67ghymH3ck29y29blGxYEx
         9jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777543223; x=1778148023;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTuGXf4G9hFP2OE6G2RtU9T9dFc18m6MNM4t5StKCzg=;
        b=ZtIAJQ3p/b4c25w3iMaqtUCIG8KdhHcRI1nbXjvjX1w/O99+Afaw08H4XsBwmxXV1/
         6UsTyF2GEh/a1qUTYS4P52ZPk82bwqqBBZp51yVUOGcbHVifGIQYZWyO6bsFpnJtM2Bx
         9yl9RZam2tFtI4bxVE28uxUvpRG/sj9PDzfeVDZgfvspxPB9N5fUXOmKBsBG9uIHDa0P
         MEthnAoixDf1Cvepo2RSbh4rQJpQHhsJjdm4VAcFTqkT1ZvBMSuXo3TIaoelrAwQwuPU
         lkhMyAk7W6hge7n5YZ5c4UH4/butFarOZ13gO9hemZ5hNDn/9qmSgR0zX/DkI+q7U0nA
         YRQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VVA+vy7clms/7ctjjd+SsArXG2i4lOuKfYdztuoJY4CTic3wRZOi2NV/WofLYA64TVqCZscM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwh2gB9RwPW5S7XrJOLucifHU8iwyjwkZMwkIVafIROsXL2z7a
	m7fAdZ8gJg06c/d4O+KwzFvg3M0USZ9bupgD7QfV50N/Er+P5H87bLYtHeilkbHMPoChQ3Bubox
	qEBHP6+loxs2rPQ==
X-Received: from ywbgz14.prod.google.com ([2002:a05:690c:470e:b0:7b4:bb2c:ad16])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:c509:b0:79a:c40d:b701 with SMTP id 00721157ae682-7bd547c23afmr16211247b3.13.1777543222856;
 Thu, 30 Apr 2026 03:00:22 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:00:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430100021.211139-1-edumazet@google.com>
Subject: [PATCH net-next 0/5] tcp: move some fastpath fields to appropriate groups
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7A2B24A0941
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282749-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Move following fields to better groups to increase data locality.

- delivered
- delivered_ce
- segs_in
- segs_out
- first_tx_mstamp
- delivered_mstamp
- max_packets_out
- cwnd_usage_seq
- rate_delivered
- rate_interval_us

No change in overall tcp_sock size.

Eric Dumazet (5):
  tcp: move tp->delivered and tp->delivered_ce to tcp_sock_write_tx
    group
  tcp: move tp->segs_in and tp->segs_out to tcp_sock_write_txrx group
  tcp: move tp->first_tx_mstamp and tp->delivered_mstamp to
    tcp_sock_write_tx
  tcp: move tp->bytes_acked to tcp_sock_write_tx group
  tcp: move max_packets_out, cwnd_usage_seq, rate_delivered and
    rate_interval_us to tcp_sock_write_tx group

 .../networking/net_cachelines/tcp_sock.rst    | 10 ++---
 include/linux/tcp.h                           | 40 +++++++++----------
 net/ipv4/tcp.c                                | 22 +++++-----
 3 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog


