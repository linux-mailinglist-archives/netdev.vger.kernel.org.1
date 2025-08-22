Return-Path: <netdev+bounces-216129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CB5B3229A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 21:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F181CC8106
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DCF2D12F5;
	Fri, 22 Aug 2025 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hz9LJCDg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C92C326F
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889708; cv=none; b=TdMyyp08zw0OjNMyOYdWn+ma4ZW5oA5hTvaJvineXx+O7GhCzAez0l5vv1bwVXq5pFug81PJHcvOob7+dD4IUENGQW/m0Q8eUlelwkSc5jC8fSVcbrM7tZqaU3n9C4BRcGgidyexvW9V/iyXBu7GM+B6iN165KzAENgTLrzNyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889708; c=relaxed/simple;
	bh=rGUk0XCsQGOr4TpEsfR4KzYo0y8WTjEE2VH/et740Rc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UmTExQlbrjfJN8Th5dYsfisYY2BCRX03CVtvePuTJa0dyw5iUOdPMRoaqOdT/Thks+vbUS9BzNqeBJDP1nZpT6M4ObTQw0MSHZ7sjFGkXAUVYj7mBrs5TPmyE6TIoxZzBiJAYzxwj0dT6g2ZDY2uBPzl7fJxKB3kiOzOnkB36FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hz9LJCDg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-324f81677d7so1956743a91.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755889706; x=1756494506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXcGJ/a/4Z0nHUZzIh38eFGcGHPGDcm/2xeasPFH544=;
        b=hz9LJCDgcwvEQRhTlrkzWZSIQ/LePk5yyZdzM9P6s0f+N73HtoMKaO39unJwnwnZj6
         aZU96PuxxR/mtRWNf8dKO3O3VCPcH66k1LUokenayNL0MwJC0BdswMYCMLzYeclxFR5o
         TVPR5g0ubi/WcLDa6v+V8DPljGzqD8DXTUtkJ7KN5K5wwnrF97GtFkk2VbWgH7ON5rf9
         zhD5alGc6XRUwVLu6jwPNOuTrsvHmso+i9ftLD+ouSJrJjmZa3KIK8NQgtQHhUcxQ+IQ
         TAQGXzsQb/59pctoJcbBj4aA6VHbRD792r6fx8zhZBjzkXo6Xuvk4lFGF/TM0VFCE04s
         pP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889706; x=1756494506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXcGJ/a/4Z0nHUZzIh38eFGcGHPGDcm/2xeasPFH544=;
        b=AqfcGv90uUUBIVcL86q5sC2Xr/gQ43hRk5vlX3ivnT4D/zcxq7J7hQpTZ5gk5i4Vlm
         84TkPGr4GSTfuVYRaKsGNL0mmkeGR24CfRtD4ke8mm/NmqBQ0IsvHffghaTbaP5rNap9
         a0qAOe3dpO8K8L2gd9FTkEyTNDuRCWSuHCugg+SSrrF7MWusfdikJIf3jeuMZ00fT2nT
         OiacbcbnuSMU725RpdC70EhAcaXbGlWGIBs9ncgW4IfVlVZ+Hpw03X0rj9X1XrJBhriU
         na+bBKh/3GuHHQf6iwepsu+UkF4ACGkye13u7PR/Fb0NnQl2Ia7FJo9+qBFyyszYpZbZ
         o/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE+//A5v+56wqcoeogQXxyvPWqiyO7vL+RGvyc4ZtTYsEA1Go6ATrKPJXdFGbT68/7iqGRE6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98EZ8oaU4tXKMv/EmVbXZcFofILwX+FU28b5ekqyNIEov4iQA
	FbB6DtgUfnbdIdQI4YW+FdWDw7dKHwJWk+XVTgGtiIShT8m3pX9KL77VY1ZrYuwiCVsyIj13wB3
	DTBpbYg==
X-Google-Smtp-Source: AGHT+IHerkGzbAhcKtf3mVf+iCBR04HiQwngqBrcLZbjUZugnArePJ7AT+fT/VaT5EsRdmQW8asqeFxmQyM=
X-Received: from pjzz12.prod.google.com ([2002:a17:90b:58ec:b0:324:eb0d:70e8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fcd:b0:311:ef19:824d
 with SMTP id 98e67ed59e1d1-32515e1324bmr5334647a91.2.1755889706243; Fri, 22
 Aug 2025 12:08:26 -0700 (PDT)
Date: Fri, 22 Aug 2025 19:06:58 +0000
In-Reply-To: <20250822190803.540788-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822190803.540788-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822190803.540788-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 3/6] tcp: Remove hashinfo test for inet6?_lookup_run_sk_lookup().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 6c886db2e78c ("net: remove duplicate sk_lookup helpers")
started to check if hashinfo == net->ipv4.tcp_death_row.hashinfo
in __inet_lookup_listener() and inet6_lookup_listener() and
stopped invoking BPF sk_lookup prog for DCCP.

DCCP has gone and the condition is always true.

Let's remove the hashinfo test.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_hashtables.c  | 3 +--
 net/ipv6/inet6_hashtables.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index fef71dd72521..374adb8a2640 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -436,8 +436,7 @@ struct sock *__inet_lookup_listener(const struct net *net,
 	unsigned int hash2;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
-	    hashinfo == net->ipv4.tcp_death_row.hashinfo) {
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
 		result = inet_lookup_run_sk_lookup(net, IPPROTO_TCP, skb, doff,
 						   saddr, sport, daddr, hnum, dif,
 						   inet_ehashfn);
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index dbb10774764a..d6c3db31dcab 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -211,8 +211,7 @@ struct sock *inet6_lookup_listener(const struct net *net,
 	unsigned int hash2;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
-	    hashinfo == net->ipv4.tcp_death_row.hashinfo) {
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
 		result = inet6_lookup_run_sk_lookup(net, IPPROTO_TCP, skb, doff,
 						    saddr, sport, daddr, hnum, dif,
 						    inet6_ehashfn);
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


