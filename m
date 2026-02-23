Return-Path: <netdev+bounces-260109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOkiIeN9nGm6IQQAu9opvQ
	(envelope-from <netdev+bounces-260109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:18:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C1317995A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E4E3303718C
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95064307AD5;
	Mon, 23 Feb 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVW9Q4Wu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2512FE04E
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863467; cv=none; b=IueH1a5IuPUuT+Y/+7YasXdccGZFFKnY29olQSj+V+M2pet0ancOfdNTKyMRYrtDnonHNaGavYlYhWnSwgW0GHOcc6Dy6gCSEHw6T2Zww9b3D8rsKKZOeInFvyhku7r8zB7ZxcKoBrnNFLo7fCVdTQAsmu3J5YJS3HUoFfUnMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863467; c=relaxed/simple;
	bh=EZ2tpIfD6ioYo95ZkG52Y3tTDaG+ylivPYv8p7j9T3M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sVoDDIUINX2rWy91OQSGLo+sURCO+zMOhAU8hABVf9lIqVMefkpoesEtjKqM+MG37bx4XWsMSIQdDTf9bkUAYy+GXujwhRge9P60Gi+2YJN7iW2E87D/DxEv4T8iTHWYlQvLveeJVpHhgOX1iCZtwG4YGMlf1q18PUlymu1DZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EVW9Q4Wu; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-896f8dde688so480252246d6.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771863464; x=1772468264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gpLg73Nr/wXEVqYRN7b1Zexc7uJFPbJMza/u/EU95jU=;
        b=EVW9Q4Wu7rm5lDEkCRjYJz9XCKeBTZA2Yw4xizYBZhgq779SsnoQHVMj5D1eTb93Zy
         52MtwH1/rWjaMGHbvbcxWykwq9KXlJVaX0TMJTpDwrVIHoknzdxQ/BkFuvQjhTkRf8aX
         XLmrto274DTo375aH615dL1wYl8vWYV4YstmATN0iMeOdpdoFAcXgr+0nrC6MhLvXT/K
         2a9Dxa8j1a3dxmsmJGjmJrcNC2S15S1pgg1glLZcW56NTYBzauy1LwyphmJu60OXDo2l
         5T6DEYCMT8+JF0GjCWYuCjm/YqG657a0wp1vvRmaWa3IRGbGac1TG4b/4AWebAi7oOJS
         eu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771863464; x=1772468264;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpLg73Nr/wXEVqYRN7b1Zexc7uJFPbJMza/u/EU95jU=;
        b=PS6R0XrY5dHD6rhAo3dzuceUl2ZFFL9HZ+BcFmBTPIKZikPa30x/i4/jVNbiSYmJRb
         Bv8gzmMtl+YvWq4GRpDg3J8i85IM8lUWXce+Q6XqGWV8EBe41z3vDA6fjny5g2Qz2WwF
         rHBNQeno8Y6jOSAKyGt8qpHYwSAdmy+V9+WFATLiZmloSZF6iZ33ehB4/Hnx3jmaexpY
         Kp67I/UPGkO9LUqDcu9Ic6phK2faDZkqv7fd922sobYj05DeplKROpuSSEzGrdeO7S/N
         4BlVax/1aJV5VFZfoN7uhW3RYqM4hmCIIH3U6LJar/uOExxlQukiJCYXtFuPAj4FjCka
         Bz2A==
X-Forwarded-Encrypted: i=1; AJvYcCVK8K1EDtCxh/NskMDC+JqkZEYVKXi0WMMS6X3YwZ91hh0YsMMnyFzd6R+K/5Bn4I87KQbqZ3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvidlxRIE/qpPG5ggLryM322GX7rUJfuYpfSWw5ft48dfg34wu
	hezM4F38EMWz58aJP3VQHnl/HtVYJKPJuSvMXDvuQ0dpXARn0cETRhWp9ccqLP2vL90J93A4VL3
	WHxlTpvJeckTrig==
X-Received: from qtss3-n2.prod.google.com ([2002:a05:622a:a9c3:20b0:506:d20d:b893])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:3c8:b0:4f4:de04:2434 with SMTP id d75a77b69052e-5070bba6bb6mr139422101cf.11.1771863463720;
 Mon, 23 Feb 2026 08:17:43 -0800 (PST)
Date: Mon, 23 Feb 2026 16:17:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260223161742.929830-1-edumazet@google.com>
Subject: [PATCH net-next] icmp: increase net.ipv4.icmp_msgs_{per_sec,burst}
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260109-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27C1317995A
X-Rspamd-Action: no action

These sysctls were added in 4cdf507d5452 ("icmp: add a global rate
limitation") and their default values might be too small.

Some network tools send probes to closed UDP ports from many hosts
to estimate proportion of packet drops on a particular target.

This patch sets both sysctls to 10000.

Note the per-peer rate-limit (as described in RFC 4443 2.4 (f))
intent is still enforced.

This also increases security, see b38e7819cae9
("icmp: randomize the global rate limiter") for reference.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/ip-sysctl.rst | 6 +++---
 net/ipv4/icmp.c                        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 6921d8594b8493a25d62ffd586d0b9f6527409cb..9434c417085bd2c452ee86945349903761c623bd 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1747,14 +1747,14 @@ icmp_msgs_per_sec - INTEGER
 	controlled by this limit. For security reasons, the precise count
 	of messages per second is randomized.
 
-	Default: 1000
+	Default: 10000
 
 icmp_msgs_burst - INTEGER
 	icmp_msgs_per_sec controls number of ICMP packets sent per second,
-	while icmp_msgs_burst controls the burst size of these packets.
+	while icmp_msgs_burst controls the token bucket size.
 	For security reasons, the precise burst size is randomized.
 
-	Default: 50
+	Default: 10000
 
 icmp_ratemask - INTEGER
 	Mask made of ICMP types for which rates are being limited.
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index a62b4c4033ccbaa5f6de1345ab33f89b4096b691..1cf9e391aa0cc18e5d3ef4b6569207ae1ec0e43e 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1727,8 +1727,8 @@ static int __net_init icmp_sk_init(struct net *net)
 	net->ipv4.sysctl_icmp_ratemask = 0x1818;
 	net->ipv4.sysctl_icmp_errors_use_inbound_ifaddr = 0;
 	net->ipv4.sysctl_icmp_errors_extension_mask = 0;
-	net->ipv4.sysctl_icmp_msgs_per_sec = 1000;
-	net->ipv4.sysctl_icmp_msgs_burst = 50;
+	net->ipv4.sysctl_icmp_msgs_per_sec = 10000;
+	net->ipv4.sysctl_icmp_msgs_burst = 10000;
 
 	return 0;
 }
-- 
2.53.0.345.g96ddfc5eaa-goog


