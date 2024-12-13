Return-Path: <netdev+bounces-151838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9189F138D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73528168119
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3071E25F8;
	Fri, 13 Dec 2024 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHNN+kO9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74A57C9F
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110727; cv=none; b=eOlMgCkG+OcBi7vUOXJb5h3dXVAgQsLNKFaaISWqufQN+bedBlTzqHOsdUVihDexQbWkSPX7VtDhFd2zTVzfkzFD6DYG+Sf52tpH4lvUyghw8n2wu9PCeYqG3hzKVWRoyUHdpbTGfkWnsmpR3tQSpel8fLO7ccagw7Ff8tXqmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110727; c=relaxed/simple;
	bh=nEwWbQzW8E+TUrubWPv2sLWAdLTdOe1SImLcsbUwQCA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LBPLEI+zJsEqmfKwXvEJkmbzj+5Sky5kMu8eMDPoqS6D+f7laM/OD7UZYGQeYunVdE54YQrsShV06dP4sccif9TTpA1KhgOhWxSGfdUPEgLjfSeseSvaLJCz6RTJxrfwAAus8AmzHiIIjXlR5KKItZg3Z560VdJR+IN6UX3e6hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YHNN+kO9; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d889fd0fd6so40641856d6.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734110724; x=1734715524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FAugdGhALt0meIx0OYdm1MYujvvGo6RbTrcQT7k1I6s=;
        b=YHNN+kO9o/p0V7aVHVB0b9+U/tieD4eXjBzx0Y+qnHd2TSqJDbnp5RA+YpPoAN82JC
         NCq1oRgUxnmQNT8ZYMwoolZT4VZHwP+mI9L3gYXsD6Hlmzadzbpec00/2JTnqKgSCaDi
         UC6KJGniXGZbDKdFEzOQSodjAKnHMr4A1Wa+B7ng1UVHqZOo1K7b1aREYLu3Hix+Xb42
         V+9m0XCkhbVEQwod8CHIYFD8DLSH7QhuTLGgYkwHNC1mnqjChr0ZbMKBAT/fvhzDboiC
         e08Ax0ehpsyKb/0HYUAoSUqv1nNoBYqqltb9CZFm+q8CxgkSyD8RKOJXvP8rY0DyfMJX
         YGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734110724; x=1734715524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FAugdGhALt0meIx0OYdm1MYujvvGo6RbTrcQT7k1I6s=;
        b=Ub4WcsHWmtWw7xs0NGN52qXL2PfzmXtQBXWHSDhA90wOywSCFcLEgJ5d894SzjsQX4
         /sgX659htrOY4egqHiVsW70oKUAy0FmlyA7WDTvgSzoK4ex4tqJYPo9aBdO5f4X1ezuo
         LKWAxZQcrJ/1f3/7/n4Qv8Ddjt3Df9ydjGS/bQDOfrn8MQYdIeN3TWC/ksTkdmRnY6pd
         FfAUj47zYCaYxsx+A3A2Yco9YmyFeKoxIelkUsqoanUp2E+Jo7pWHkczmskJ4LzlMNNh
         vBzyvyGPk+g524se3ntiDpzAvo9UaxoSpuIkn1U4Wcus27duYSJMOzq97a2UFz2mT66v
         pzYA==
X-Gm-Message-State: AOJu0Yyv5UOyCEKFOdx3HgwlpToJcCZ9Z3XxthIQC+0KLA/kKk5v6q/4
	/LVLeEL2/DB/oiLbCp+wGRUw5Ax2dnd7Jx5e49Sv5HK1t97xL36VB9a7VIPvQQXM3QLaldhGPny
	sF8XjuP8Cqw==
X-Google-Smtp-Source: AGHT+IFFC7YxxQswCZ/bIxgsrrP+lGk5txi94B8fRYhb1RAHfFccRyK7uwm2NFTNI5RZnNHsYVusLDBcU95tgA==
X-Received: from qvpm12.prod.google.com ([2002:a0c:fbac:0:b0:6d9:f16:79f3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1d2b:b0:6d8:8283:4466 with SMTP id 6a1803df08f44-6db0f48612bmr98344136d6.18.1734110724710;
 Fri, 13 Dec 2024 09:25:24 -0800 (PST)
Date: Fri, 13 Dec 2024 17:25:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213172518.2415666-1-edumazet@google.com>
Subject: [PATCH net] netdevsim: prevent bad user input in nsim_dev_health_break_write()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+ea40e4294e58b0292f74@syzkaller.appspotmail.com, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

If either a zero count or a large one is provided, kernel can crash.

Fixes: 82c93a87bf8b ("netdevsim: implement couple of testing devlink health reporters")
Reported-by: syzbot+ea40e4294e58b0292f74@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/675c6862.050a0220.37aaf.00b1.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/netdevsim/health.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/health.c b/drivers/net/netdevsim/health.c
index 70e8bdf34be900f744e821fb237641a27bb71a7b..688f05316b5e109fc84222476023f3f1f078cf28 100644
--- a/drivers/net/netdevsim/health.c
+++ b/drivers/net/netdevsim/health.c
@@ -149,6 +149,8 @@ static ssize_t nsim_dev_health_break_write(struct file *file,
 	char *break_msg;
 	int err;
 
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
 	break_msg = memdup_user_nul(data, count);
 	if (IS_ERR(break_msg))
 		return PTR_ERR(break_msg);
-- 
2.47.1.613.gc27f4b7a9f-goog


