Return-Path: <netdev+bounces-250076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B9CD23B7D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FAA431542D0
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8002335EDA1;
	Thu, 15 Jan 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyWSsZ4x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319B335E52A
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470113; cv=none; b=qlkLZxa9W/cXcIfuNchhc3IOUxRob3Hcm/xmKg0hDewfQSYGZS52w6B6Um+R0kfE+pZQzhjdtcyviPTbp4gzFwXxTHVzKY35ut8pGP1c+jJ0Wsp31i/F688QFq4JKDhSh2tw8dKbe/rBPwCzNdp99Z6Qkj5/Mz3RMPhCyog5mF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470113; c=relaxed/simple;
	bh=OsA9jT4ysrLxrAh4gHXsSOfyJI4uNuhjEsA4ZF0KFfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jh0NC9/snPecdXY9iXaF/Jw+pqesLEweckm0SqeiQTmXLu+xETSsFfFVmZQbtkArSqOEBdrbnFpvEAwWHiukBriMYanVl3Nz7TvmG/m4Se1K92BEBdE+2on4bgFkivVTTpF0EQhlC31/04fMNgnZd2YQ/zf0BsSD8WC2i6C9P/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CyWSsZ4x; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c52c921886so91204585a.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768470111; x=1769074911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3AldudAo4ht5GhLDeLzpETYFbiLseR0lg+oGIvSo2Ns=;
        b=CyWSsZ4xbk3ztCdguKxKw6VN4pGRoMSH7j//XZFg1dZ/q6to+Maq5XJU+YWGKUNx46
         KdSV6Tg+Fq9OMQkf2boZ170DxCr/D8WT5vsgirkPN3AcFwMLLFkvIOw5GOW82t0C2Na0
         zvs5161UfwNn24WQwqXG7M+GAG7am5NPEayJkw3xIPUu56jls7CWCtB1nyUTx6v0jmh0
         O8AXLi/ZEQmlBqZm17Ib17yPsu3kySC5LvLxA24O8RXNr6yzrJLQOgPnaEgdA8WzSU+e
         SGkIBd7ej/xUehkOqFCdm2Af8llgf5lOXRN2ofLv05RTgBHzCafr9bXzmRHKaG9W4iga
         ZcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470111; x=1769074911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3AldudAo4ht5GhLDeLzpETYFbiLseR0lg+oGIvSo2Ns=;
        b=XtNH13hn8j1uy1gtEenBZ3ZqqEqaiw3/4NcZcNJmo2wGJbJUeF3vQDpf4RrfrPykCg
         ve9f0bJbSmBkOYfPfjehexF4v0z+wRK1jVqVsJ0cc5g3C/2/jdnUNeH1uScEyjy3QMne
         ozomuQ1BnE4CL8YLl+olj0GzlajMyyHOHJrMIj+ZYzZcrREPQzUNdTbaKC4YRqgEUi3X
         vKXxYfNmrnsdzZB9HHDVRChCkPfeylzGwTU+SJEaUUCfC2kQr1YMZYgFPFLw/loNSwUn
         /fszv3hqXfQQTTskMxjiWS090VNnyMhh+VkB49U5HVE6fLGHea25Qmq+KiX6lRxzxR0L
         aF6A==
X-Forwarded-Encrypted: i=1; AJvYcCUVKrOwxJhjMoo2cny02j09iQYcQauGevQLU9V0LvalUgn7Dtf9v25obokhYIGMBYeAAxT0BA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0r5f8ctxP56jet4eJAVMP7Ii6SJxjyMHUdmMS6ZBpCv0Mz1Vx
	bNQTItF9O86NNwembv5be53PHA8J7eAU6N18sC9ykmKXiQsfDEj+S4OWc8pQLLE0xQbeSxDARGA
	9ITzy4pnfvaHtSw==
X-Received: from qkbs23.prod.google.com ([2002:a05:620a:43f7:b0:8b2:fd9f:ec89])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:46a6:b0:8c5:2ce6:dc9 with SMTP id af79cd13be357-8c52fb4f058mr740419985a.23.1768470111203;
 Thu, 15 Jan 2026 01:41:51 -0800 (PST)
Date: Thu, 15 Jan 2026 09:41:37 +0000
In-Reply-To: <20260115094141.3124990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115094141.3124990-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115094141.3124990-5-edumazet@google.com>
Subject: [PATCH net-next 4/8] ipv6: annotate data-races in ip6_multipath_hash_{policy,fields}()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add missing READ_ONCE() when reading sysctl values.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ipv6.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index f39cd85e89123a06f7660868ef42c8050d693fbf..c7f597da01cd92293b9ffbd9e692dea75fd581b8 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1014,11 +1014,11 @@ static inline int ip6_default_np_autolabel(const struct net *net)
 #if IS_ENABLED(CONFIG_IPV6)
 static inline int ip6_multipath_hash_policy(const struct net *net)
 {
-	return net->ipv6.sysctl.multipath_hash_policy;
+	return READ_ONCE(net->ipv6.sysctl.multipath_hash_policy);
 }
 static inline u32 ip6_multipath_hash_fields(const struct net *net)
 {
-	return net->ipv6.sysctl.multipath_hash_fields;
+	return READ_ONCE(net->ipv6.sysctl.multipath_hash_fields);
 }
 #else
 static inline int ip6_multipath_hash_policy(const struct net *net)
-- 
2.52.0.457.g6b5491de43-goog


