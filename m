Return-Path: <netdev+bounces-164586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC870A2E5C2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8391883D05
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A0A1B414A;
	Mon, 10 Feb 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRbyjq/4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572F1B0F00;
	Mon, 10 Feb 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173834; cv=none; b=D99JLB1pMMf0OX65un4rvezOX8YxBklaFwy4W/6IUKZ6D7R7v60FcXcwETpytiboL7+qd0Kkswk/lttxG9Htr5pZujmybPuo7k9v0PR8v9wNUrvN70Jn0Md3etq+0L2nJAOR7i+V+FPqgB7lYYMUYeikJidE5tt4UEpPooC/GSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173834; c=relaxed/simple;
	bh=KcLkOdKpnk1CJoSNTQMgCGG1hRd+E7Qg89aooupMW4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DcNKWa6xsuM3FpaSCiEbSKAOGPfYbF3WsgwoaIp7aI/0ab6Oxt5XmCKNDnDa8Jw88q5V9JgqN3Z2ibu0LkzkAQhRVFfjbH1fjT6vHD72iRvy3X0VdGvLBc91o+SBmUPww1CzDgzxB9QkTtj1SvfXKu/tuTIoMT7mhHf8ChG3u38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRbyjq/4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa1d9fb990so6029821a91.2;
        Sun, 09 Feb 2025 23:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739173831; x=1739778631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yH1eZR8Z4tfbwC4sdMJnrsadw3QkNTq9pA/sDaio2h4=;
        b=lRbyjq/4YBOvjOR0R1ucOna8+7wIoRhsfhRH2nwnpkNH/j2+9s5ENZ76MLJcTqBXUA
         TSovRS3zOVKGRz5C0Gu3ijpgj6FGO29WghoSmStHugp5w24JGlkosmMEDjvaBYMRFIqb
         VBvqpzqSKmn24EmuTAyqjgOcclYlCBSxmcNzE0cuuRSFQKBYA9Kpb3nF3gpIgpmc3/pX
         X3Z47BZB2qfIhJNpZ/4gnbJVWnzzRmVwjiHi4BPbGw3ReJ+1QwCBCneehZFAwQLXESIk
         TA+BFueVp5zQQofM1YYNk7Z5bBFebCNUvuSxHHect+KNJxcf8vPfICTUd+Gbf+is4IVl
         tnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173831; x=1739778631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yH1eZR8Z4tfbwC4sdMJnrsadw3QkNTq9pA/sDaio2h4=;
        b=j1fWDuHSWMcM7lPPN5Cynbgl3yH1b46wypUuUT952SAN53tJ+eJyAYSdrCi4S5tYcZ
         e7qn/pSWW+bFqYYyHX5+FRpqeGr+lQ8K9jtWtfOlAzRubNt9WMEO+FgbX+VK5en+gEIz
         pFZzzlQCwpFVl/XxkOKwIo5Pe5Tq2xOoOmEKq6Udc2mty0Ak+FhWNbcvLd9SClZvSNii
         yt9GMvhBgDU1LNs/00Q5wtCOUmEK7nshr4xJw8tu8APQO6XHiGcBzRr1IHg8U7IZcQfz
         xEe+AQuS7ihMOs/iUcL+14Aiqo7PnmtvpDTsfr0YiVoIrCpSvvO1qB38LQzH8x1lPR4W
         6Fow==
X-Forwarded-Encrypted: i=1; AJvYcCWb+wVTK1Ry6mtfHrAt3BeW5T9WbRWuM7ez0ptrcSciDEKJPkBW6BvvyFbLWWgCnWf6ydJ/+oc1@vger.kernel.org, AJvYcCXekWP1SJNDvhlvTkeEWRlzPs5Pd7uqPf65ufEc5YLncKdaagGvA/54krLxPUT+JEOB7UADCL8Sw856rXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+djdPC/oG4NksWuM6173U8B40eDIpgo85t/ypjAhjq2ZzLFjh
	ytFavnMjE7+6xzoUV+PV6Vm+IS1SxHhPT0YLxjqJSMYiLLahLaka
X-Gm-Gg: ASbGncvN7NiBe96j2UnGkTSmwM8cgR5z9JtW5chlBEXJFTOatUOIt2cE+IrfuDZaI1N
	NrytMkkKXk0xf45tC5rRD6QoAGDq8K9CMvKgtZLI0Yn454l5WW2y9vaxc0TITz4En6i2I5GTOne
	hfZBuqB+CQSUEaM42ykxgqsk+6cmu/GQupEzN2ClJhdGoZUZB0MXVZAOBBENuct2yoYJKODDrZi
	3vX7keOH/q8qRBYkbvbOFyujrRhYqgrErQyv85gq42CjrNU5eOmxCqQV7hY2ehb/BGXQ7yYV8ZJ
	u8nZXeGH0/P5n8VbajlMWcUYADKz0m3hDZ9m23J1Dcq3GRQOow==
X-Google-Smtp-Source: AGHT+IH9ZEbEouCLt6NuoakuYdcUnELKqrJuy+RTbWTtRy+8lev6j+fv/HSLVCV9hcgXMelfHzw/XA==
X-Received: by 2002:a17:90a:f94e:b0:2f6:d266:f45c with SMTP id 98e67ed59e1d1-2fa23f5abcemr21436969a91.2.1739173830745;
        Sun, 09 Feb 2025 23:50:30 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40c0:101c:99b7:34e3:b424:c392:121c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46a89sm7877027a91.23.2025.02.09.23.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:50:30 -0800 (PST)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: skhan@linuxfoundation.org,
	Simon Horman <horms@kernel.org>,
	Purva Yeshi <purvayeshi550@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] af_unix: Fix undefined 'other' error
Date: Mon, 10 Feb 2025 13:20:06 +0530
Message-Id: <20250210075006.9126-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issue detected by smatch tool:
An "undefined 'other'" error occur in __releases() annotation.

Fix an undefined 'other' error in unix_wait_for_peer() caused by  
__releases(&unix_sk(other)->lock) being placed before 'other' is in  
scope. Since AF_UNIX does not use Sparse annotations, remove it to fix  
the issue.  

Eliminate the error without affecting functionality.  

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
V1 - https://lore.kernel.org/lkml/20250209184355.16257-1-purvayeshi550@gmail.com/
V2 - Remove __releases() annotation as AF_UNIX does not use Sparse annotations.
 net/unix/af_unix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 34945de1f..319153850 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1508,7 +1508,6 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 }
 
 static long unix_wait_for_peer(struct sock *other, long timeo)
-	__releases(&unix_sk(other)->lock)
 {
 	struct unix_sock *u = unix_sk(other);
 	int sched;
-- 
2.34.1


