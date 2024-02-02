Return-Path: <netdev+bounces-68408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC90846D02
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2C81C26F64
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595477629;
	Fri,  2 Feb 2024 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vvbJ2sY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7F7428C
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867648; cv=none; b=ZCuTLp9zsYMZ+U7iLyxGR7V+GqUTGzdPqh5YO2yPQxOBzexWaY96cakbLff4ey0beVb3lqLHifP1NwJepTr4cyrrGtSz0ZeMRRqsSKLcUcGH6FVc1qe8Emo+P1YwNwUHquECCvpClggJSBZQ/cWZPKqSjuQKxYSDXdcaDjey0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867648; c=relaxed/simple;
	bh=r3WwOvjGlBMqDTcMwT0LLAgAW+AI8vEp3SoKLpsNvFE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TvpdSIHNgx6tyNBK+/YsesGSOZ7Onb06/wL02eFg5J0D7YgGtvgTLCcYY89Llknn/5C6qXqSNKZdJoM5G6Kdf5/Semj4JTRxXFq6EXWLJwXN3BN/9cw4hr72BLAssx/iq8a2gUBxS3/byPZBZ1sFHRlqaMJIpVdc+ikzmBgDNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0vvbJ2sY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so3099931276.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 01:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706867645; x=1707472445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wzXXY83peJgyg/e7Xd0T8fiva+wsNVqSftFdJq9pDHY=;
        b=0vvbJ2sYuq4QH7wEvSLx7yR0HBQcWCwRIYTJGoJ9Z6F0iQL5yGrZZLvbRfUFQILKZc
         ZX7uN4U5yNrF6l4oyRuKWXMUBlL4gZOIdCGUF7EVn6On0jfiu738Y8rpogFLbXwzUbz/
         kQFCGrbWktYgGM9DutQXhIplQVQRkgXU+JfILtuAav3l0Fj6mTec+iW4iVlvwjVLcXst
         cqQHJF4jGt+m0IADIdAEJU1i8UvQfWz+2oPHfhZRZuW1taYblp3cuIy0s/T/mWvh/RNk
         IVlCRxspKWU2XUYbAseaAZwWQPszcxgvmPYFXgTPRTcR/+bI7sW4jjIm0ZIfwnHDQQs+
         4bwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867645; x=1707472445;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzXXY83peJgyg/e7Xd0T8fiva+wsNVqSftFdJq9pDHY=;
        b=JZTCri4vD06/9j9JBy7ZrDXOng9ruJKCtXHuNAiIsJbH3yy3/5wm4VVM2lfPsv7cIH
         dUOfYDxu9UsdFQtlcSKkWi1cQiH2QqAzbDzT3eY6a36aDOJifv36/9JeUXLbNmI3TJxr
         G7mY8wOXCbFG1OtctfmAL/cUutqX3xeptYDzHQf5fc7yS6ZpH697XiZgqJW5tB3bnX2I
         k4cUXPYmClvaBPnJCFZox2a9iO/mMqQr1SnIB5tV8fCerMz4wBfQXLGS4AmpJQ4Jvfr6
         AwAchItjkI0kWxXVhEiwIfFDWJ6Af0yAX0fC7SxSm+6aqzWp0kVLPwjCi3VT+kl+xsV/
         wB8Q==
X-Gm-Message-State: AOJu0Yxf0f+YtjrVTdaqpJrUcoXUF46sJo4VqHlnHgROeEkp2kaHi23a
	pXy3Gxspf/z24Nb1G8mpgjkaUfaRgmhwXLpHbIcSb0WeAsG2fn+8rwdqdl+txgkcA+cV4l2IRN3
	iZwbGrndLEQ==
X-Google-Smtp-Source: AGHT+IEWxG6k3yU6dZJNk9EOZxZbtapGob6wY56R+xZtnXbbIWTTT7ntc09xgWNl1Ick6ez4EEAuXUor5/oj4A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1085:b0:dc6:e5e9:f3af with SMTP
 id v5-20020a056902108500b00dc6e5e9f3afmr715625ybu.9.1706867645656; Fri, 02
 Feb 2024 01:54:05 -0800 (PST)
Date: Fri,  2 Feb 2024 09:54:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202095404.183274-1-edumazet@google.com>
Subject: [PATCH net] inet: read sk->sk_family once in inet_recv_error()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_recv_error() is called without holding the socket lock.

IPv6 socket could mutate to IPv4 with IPV6_ADDRFORM
socket option and trigger a KCSAN warning.

Fixes: f4713a3dfad0 ("net-timestamp: make tcp_recvmsg call ipv6_recv_error for AF_INET6 socks")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/af_inet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 4e635dd3d3c8cca0aee00fa508368dc3d8965b93..a5a820ee2026691afdd5ca3255962b5116fca290 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1628,10 +1628,12 @@ EXPORT_SYMBOL(inet_current_timestamp);
 
 int inet_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 {
-	if (sk->sk_family == AF_INET)
+	unsigned int family = READ_ONCE(sk->sk_family);
+
+	if (family == AF_INET)
 		return ip_recv_error(sk, msg, len, addr_len);
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6)
+	if (family == AF_INET6)
 		return pingv6_ops.ipv6_recv_error(sk, msg, len, addr_len);
 #endif
 	return -EINVAL;
-- 
2.43.0.594.gd9cf4e227d-goog


