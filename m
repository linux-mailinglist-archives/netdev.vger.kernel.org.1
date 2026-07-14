Return-Path: <netdev+bounces-307586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ztCGEpOeVmrF/AAAu9opvQ
	(envelope-from <netdev+bounces-307586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:39:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9299F758C34
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:39:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oY2XZupy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307586-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307586-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC64030C92CA
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6E7427F99;
	Tue, 14 Jul 2026 20:39:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA33C8717
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 20:39:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061582; cv=none; b=Qoczg5GXfzsp8h7HRtdfIsvgwFeJmL02P7dv2zxwDXUkQ+GKYahN24fMzHBPcRhJ5u4O3+ZmtEb5WL5uOhm0YLtD/Fb7gUhALQeZAqKv3XkAbLVBON4dNHyFH/uj+fY6T19AbJFXhCuDua0Ik4O3o75rzhcIfgY5LvEgRb5rxOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061582; c=relaxed/simple;
	bh=p3ty0i+wWfdktVq9nRg6b13I6JNyf7ok7A0AV4/xQ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROV3XBJMcWwujajIyCL/0KSThzuRpg7fe6qKVapVRjWnx9aMfu/tBdBLiJJBPgXH2S1Wde1jGbT+l8Gmwx1AU5vVsdHOTgDwm7+nQNzVNqUQxNolJ2FzlZL0YF2R/kZjzX1JLINAVXkOWkdZboG1bw0yn9iO+Jt5DKpDWgEkA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oY2XZupy; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b7612475so36632565e9.3
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784061579; x=1784666379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5D2M+8JC0T4UT29HnUPeI2z7I2/miIRrXwPjpYCuscY=;
        b=oY2XZupy2BbDi+jM8PdfvhXqKK7jgIKpkvPsb4J9K4w1EDU3e/aVcG52qey12iP0Cr
         nplNFknaPWpGSA6bXx8eA2rMZ0zSWp9trh8l3FTF454xhWhYgEudGsm1fbS6HaYQFyrY
         qs5M0F6a3WaxEPy+v5I9w4CPoEHaYeEZi5kfbuKJxn6mGZrB1wpQJRzMvADZG51tNDeF
         z38Q4e3dME/vzxrJtf9/hEHsHdJlVjDVhC9EaQ/gN2RHyK1pzpIBS+VQ4xGvzeCfSge+
         qfvp96Y/yHbXXBVN74EJg1kKqPCwwzMlseNNwGFW8cHZ2bMVMMowjPDogTBvuJUeH1Vn
         vxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061579; x=1784666379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5D2M+8JC0T4UT29HnUPeI2z7I2/miIRrXwPjpYCuscY=;
        b=dk5kpETJCbL+wd6LwLT+pAvnioXcubEMxJ9GitFvMr5uAWKJ5s8bI9Oi2paHRTzC4C
         w5A71WVEXeVxXVd2mzJ3hCKMBmfQ3quOP7A97UGCKMQG/v3QbrMD48eHilSkxaHYIHEg
         /8JqH3KuxLQWpNRMZkehpItf5Y/uMBSuPk8gXWxQgrxwoR/IWnq9J3cjmjpKDpQ5UP7+
         PGHh0WkROt9qXIuhrUGUkDe4N6T36fv6+Vs38ZsDMVDtNpgAJ4zFnWowFFNO6EBESxCw
         soIDIT2CyDW9Z/eXShNPeVE+fznYcoXfnzXqV+juJg+I+BBu9JIEU69Oo7GBJXQZtpr3
         OJbg==
X-Forwarded-Encrypted: i=1; AHgh+RpQwCTWyESR4Sgycnb69DM7aLz2OywaR4Yp1fNzSqUwed5MCtR3xSgENE07XhGw3x6Yb6xQckI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+ICtCBygRAfn01NUw/TqpSMJu2dmEL9e49qGmfBaomYtUBgk
	w7w3GTr6IHghybd3cSMSswlWVsOoPFcG3GuFIaelMbtglQH8pOuPcgkB
X-Gm-Gg: AfdE7clOmcppV4JKg3WrZwm2GB4QVThX3ygqIQ5FQ2v7D0tRkWCUYnhF9ZbHb3wIlEV
	6P/lW/udMRaoRvY9+HVkStyMnoBnuiSX4Gg3KYifu90mJGTjGgIznb9SNU3MghirjNbtVFNwQZW
	NvTeTkqQ12b26tSYBbWZAvH7FkyyThiz1xayuWvATEnFe938Ht8KJnLmYS/+UUWSZV338+8cUmf
	MrFF16RodGjx2Tsf4E2QRJxHNaSsVRUFmvQ2xI9mZ/+X9DnedwRO/Qe59Cp4K1PqsGhGQXgP7gj
	C/wXXaFVx7W8xRv1aRM+b+3tHKMX57Gs7oyub0zwnL73LVR+XGY4OlVrNlujKZlvc7T12dIwSLm
	jJApEUX8CSviI8nEUYDRkBmzvzFXEd3C1lur7jQmdRrhSXBug/nTL6HlZmPsdfGBvcevYg26EBS
	aPkDdG0KjYOcKmRYZSb9axlFj2J2tzo/ZQ1TtcXhl1T2HyrfDobkwznaiLd5P9BDpmprZNgJVq2
	oVWfc2wOM8A3Cs=
X-Received: by 2002:a05:600c:283:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-49518306db9mr41584185e9.27.1784061579422;
        Tue, 14 Jul 2026 13:39:39 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32c65asm98894115e9.14.2026.07.14.13.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:39:38 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: jiayuan.chen@linux.dev
Cc: nnamdio@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: [PATCH v3 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Tue, 14 Jul 2026 21:39:25 +0100
Message-ID: <20260714203927.32289-1-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307586-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:nnamdio@gmail.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:sashiko-reviews@lists.linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nnamdio@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nnamdio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9299F758C34

Spurious wakeups in tcp_msg_wait_data() isn't being handled by
tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser(), leading to unexpected
EAGAIN errors returned by recvfrom()/recv().  Adding handling for the
wakeup and a selftest.

Changes in v2:
- In tcp_bpf_recvmsg, handle signals and the socket closing in the loop.
- Fix spurious wakeups when SO_RCVTIMEO has been set on the socket.
- Link to v1: https://patch.msgid.link/ak_rR-Skd8Mvn4mH@localhost.localdomain

Changes in v3:
- Added the sockmap_recvfrom selftest.
- Link to v2: https://patch.msgid.link/alFRK66z45eDNZA7@localhost.localdomain

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
Nnamdi Onyeyiri (2):
  bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
  bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

 net/ipv4/tcp_bpf.c                            |  55 +++-
 tools/testing/selftests/net/.gitignore        |   2 +
 tools/testing/selftests/net/Makefile          |   6 +
 .../selftests/net/sockmap_recvfrom.bpf.c      |  31 ++
 .../testing/selftests/net/sockmap_recvfrom.c  | 288 ++++++++++++++++++
 5 files changed, 373 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/net/sockmap_recvfrom.bpf.c
 create mode 100644 tools/testing/selftests/net/sockmap_recvfrom.c

-- 
2.52.0


