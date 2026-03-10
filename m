Return-Path: <netdev+bounces-265905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEkXIODKr2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:40:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EDC246808
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18F19304F5C4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16C83E9592;
	Tue, 10 Mar 2026 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFv0CWa6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814E347FE1
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128339; cv=none; b=tjVBl+DtKi51Zxlq/Qop2pUEKKH0S5eYXNy69nYwG8QOZwmLExZjpkEcbosZLPVP1m5PXNzEAcm/sz3jl0RvjNaDv+P3w//aIJ3ujLpsWZPXvXMeB1ubExnOn9T/qu+vYiIwVkj/zV2PStg4Gv6tWmOoxqJ2M9ALY0Ye3WPLanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128339; c=relaxed/simple;
	bh=lbfzRkOE3N7zogoWf5GAlm2KrA97THFl2Mmcyt3ZKg0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kmc4/VoU4buAcwEi3mBuVxlwZecSC3gKGZc2UL7WWxX3xrIdCV3ojiZ4xUkIR8p7rvAwbtd8x9ltSgr4Ah5tc3BSjiJCPE5N5PJwGN5JyF6/fgupNkYD2+Jv6m3+xr1CBfOlFwumBmQKtF8ysQyOnllZQJvNT5n0jPKy26vRVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFv0CWa6; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-5fb6622ca5dso11541940137.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773128337; x=1773733137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fROB+o9OjU/y4jLUu61fRYQiZzi0FWP19k1YpYoXXGg=;
        b=OFv0CWa6trrVp/oXwiv3+ionb8snv8xcCGPwg7iRMnOPr8H3mQDHpzJk58yLft6uVZ
         F3aNOVM6Xje1CEDJ8yoxFJlI4vMa0iACfOkZl0BOebpeHuUUCA+y/eAMrN/sgWHkeWFG
         MvF0S51in+AYwLblRZ7vfbEIQymCJE3+NJuftJF+qp8P8ZPwwxL1nNLGN0Ixt7cgHzON
         2ozedI1XiqvNBBgTtClpk7cmqiQQxLl+mV4Gup82EkPjZ/ywInUzZ95mfSkinhBhpCtN
         mwCDRvDRW5vV/xaBtWEHU+3vccN9/0nlki5LWbdU4a1LrmvjmqlqqRDuNw4ZYA9BFWZR
         HxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128337; x=1773733137;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fROB+o9OjU/y4jLUu61fRYQiZzi0FWP19k1YpYoXXGg=;
        b=oj88MjuvZ+aI4tVgg7N7mwiKXVzYghwJpt1XyeP1XLZOQi3I8BK5W/3oJX+IdNfMbw
         fzo3r4RFhp6WclHWAUTbF8nrpXed098jckoeN7Ae7DsBXc5ZKjT7kvdRXoCdJHb3Cy15
         fWKiw3oWV1jthICPW6w+iD6QLggtsLul3qcISj76UPcjrd7n3fKy1eY0zjmcHm8FXMJU
         8LB8yyoxC7RFUKUEoHpLSnNZRmtE0wnvtkT3/ipvD5BQJWhpsbvmVnXKiDIfdioNF/1/
         EkNOrwRquP795riSFNSWty1i03ieP//fdn3ejRxCIlrHVMe4LgPhUqjZZgtXITzjg1yi
         YODQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKC2UCf/0EqAdno+ALWCa6bDl5UxzYH2Itx9ORYC8mXsMWbJNeuTDqRritVeWJWvSEHpZnP10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOiM/hgyeN8PSeqC5GJr+Vyf4/o+oBBlhzNGFFUszi8AyDTTh
	LxyIq6xGyvu9BkBTlAGfgYoM9Gr5S+jUdG3mVexrci/2aan7Si5w6udEfyDr43Ipb2gFVyft0if
	n/+n14Q89zCQG0w==
X-Received: from uabcg14.prod.google.com ([2002:a05:6130:c0e:b0:94a:bbb7:a8c5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3f08:b0:5ff:a16b:93f0 with SMTP id ada2fe7eead31-5ffe61138a9mr4346993137.22.1773128337261;
 Tue, 10 Mar 2026 00:38:57 -0700 (PDT)
Date: Tue, 10 Mar 2026 07:38:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310073855.564927-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: add sysctl_tcp_shrink_window to netns_ipv4_sysctl.rst
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 20EDC246808
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265905-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add missing entry for sysctl_tcp_shrink_window.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index beaf1880a19bf4cfa578e162c571e09f7a9dffbe..79b5ee81a07e49a09fce409b7a24e3d7346d06ae 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -104,6 +104,7 @@ u8                              sysctl_tcp_nometrics_save
 u8                              sysctl_tcp_no_ssthresh_metrics_save                                                  TCP_LAST_ACK/tcp_(update/init)_metrics
 u8                              sysctl_tcp_moderate_rcvbuf                                       read_mostly         tcp_rcvbuf_grow()
 u32                             sysctl_tcp_rcvbuf_low_rtt                                        read_mostly         tcp_rcvbuf_grow()
+u8                              sysctl_tcp_shrink_window                     read_mostly         read_mostly         __tcp_select_window()
 u8                              sysctl_tcp_tso_win_divisor                   read_mostly                             tcp_tso_should_defer(tcp_write_xmit)
 u8                              sysctl_tcp_workaround_signed_windows                                                 tcp_select_window
 int                             sysctl_tcp_limit_output_bytes                read_mostly                             tcp_small_queue_check(tcp_write_xmit)
-- 
2.53.0.473.g4a7958ca14-goog


