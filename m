Return-Path: <netdev+bounces-121363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B25995CE8E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6691C21562
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33F21865F3;
	Fri, 23 Aug 2024 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSAR5ClH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4B1E517
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421625; cv=none; b=iTJMH/JeRnXoRnzBVssj612ZhqyLz/8BdMo58E4sKSxB8JkqQeBT47w44piV9I/j45BUOoaXOYmhc4lirZJDngxSZovILjb80Qo9csCZ+D1Q334ZoFrkD0dVKiLYafVfgZDXT0wXqEcRcmonpzW6eoI4KKuOMfKOuNhnJOMWgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421625; c=relaxed/simple;
	bh=KoTo7tkDVCGK4Lb5h4r+KBhDY4OEBLVB8Xe/013JH+I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W1+67N8Els6nOmTlramJYGy1bR3PbvG6BpVX/WTj5EjVJq+/obWXdtC1nQx5J6ipxbEdgYcnqK6xtz9CdysNgk7znCs67licio9N1UDOsxfLElV6IizZoSbVL+A3OUfqhlFcoRYaN7jshIkS8O9EafcD/MSLUoOlfZQRfKQ7ORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OSAR5ClH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1653c8a32eso3256328276.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724421623; x=1725026423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k7/Qg5edfLxz2T+fJDvO1cG2rX0jtJRneQUPIq7Lxd8=;
        b=OSAR5ClHJ06ct8Y/bjRVfDmgcwRtBuvws0lgoj5MSzdCHzH7CDea+UD1DUU+r3K7BG
         rHDMHOCFJBrOhXHWqmnkC9+j7aMau44Pnj4zibhR8m1qZBmM3qJlgy7gNXl6p+UJAaU6
         PMD5aB62yBk/tjWiNpNberrRSIlPdNgIv8VSrcXds4EuxRJgw5SWamKIKG6Zoic4t1KW
         y94EkBD9uOhg1ZwXQxf2154GGtUEBV2AcZx55Au8vUCdccyEOD06VzlbtqN2cnbKyIMr
         Tfng0OuKSnXclY7PqO1eUM3zxSnrfkg+5juF4xLg+011f2yVemMazAxpO6Sc+UiXmthZ
         uKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724421623; x=1725026423;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7/Qg5edfLxz2T+fJDvO1cG2rX0jtJRneQUPIq7Lxd8=;
        b=PBllWD76PgHbgMjxFoSkLJMjEx0NTJ/qy6pFm/7zJ8wvvGN9PO6iX06S6prQrPfWxL
         F4Rd6HtrO9j8OUuxPbhzpIU0UU4o+rBBNYeB31+OAm1rIJ/1pP+ka4fGlC1/VPRNbbW8
         aIqDpbPE6PGhm+8TB5+o70WzcW2+qW2hw5pDvulo/7H6O84JDJc35JXnhPrV+K0i/h4E
         4C5tactCBmHLYWXJdzZwlflSt7TN//OyhJ1VqdWla3cO1DPH42OcBxuHuxFDwKAX0sCw
         a7fn2Tt8JysZAjeAN+Oxxk2PVYuu35JqSMwNLM4P6xq3cT64cckLGFOWkb55+/SxcsQ4
         fywA==
X-Forwarded-Encrypted: i=1; AJvYcCWWMcxJdqyZRRHMceAiOk6albPfGDllndZu2Nc9gir/ECLYwij/tImTKjLVXjl1Pe7cwk1XaJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QUYpWqapkZf4xHe/OLpcHg4wJ0Fb7fv9t62NxsZ07PXqd54V
	lqO5mKlk/py1Jcbva7qYPiwUElBSkkiI/ERPxSi4iueHbpGYX5OhNL5+fzk6yiOhzQuHjGYdTCq
	2f+AGpZ9xcg==
X-Google-Smtp-Source: AGHT+IGiVFrf/80vOTqKwNHGIXhunqTT8nXPu6IKs+3zmI8XZ4xK0S+Nuqc97yBZrXBXmy4sfSNmPdLPlT3OcQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:86cd:0:b0:e0b:ab63:b9c8 with SMTP id
 3f1490d57ef6-e17a865a104mr3929276.11.1724421623047; Fri, 23 Aug 2024 07:00:23
 -0700 (PDT)
Date: Fri, 23 Aug 2024 14:00:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240823140019.3727643-1-edumazet@google.com>
Subject: [PATCH net] ipv6: avoid indirect calls for SOL_IP socket options
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipv6_setsockopt() can directly call ip_setsockopt()
instead of going through udp_prot.setsockopt()

ipv6_getsockopt() can directly call ip_getsockopt()
instead of going through udp_prot.getsockopt()

These indirections predate git history, not sure why they
were there.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ipv6_sockglue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index cd342d5015c6fb36bd03d4f3fcae4a3995ff6097..1e225e6489ea150c641ed0757083591def08dfc1 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -985,7 +985,7 @@ int ipv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 	int err;
 
 	if (level == SOL_IP && sk->sk_type != SOCK_RAW)
-		return udp_prot.setsockopt(sk, level, optname, optval, optlen);
+		return ip_setsockopt(sk, level, optname, optval, optlen);
 
 	if (level != SOL_IPV6)
 		return -ENOPROTOOPT;
@@ -1475,7 +1475,7 @@ int ipv6_getsockopt(struct sock *sk, int level, int optname,
 	int err;
 
 	if (level == SOL_IP && sk->sk_type != SOCK_RAW)
-		return udp_prot.getsockopt(sk, level, optname, optval, optlen);
+		return ip_getsockopt(sk, level, optname, optval, optlen);
 
 	if (level != SOL_IPV6)
 		return -ENOPROTOOPT;
-- 
2.46.0.295.g3b9ea8a38a-goog


