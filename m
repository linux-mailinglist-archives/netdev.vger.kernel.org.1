Return-Path: <netdev+bounces-163277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018A3A29C53
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4624B3A2ECC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4D21505F;
	Wed,  5 Feb 2025 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ZjI2/d29"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C301FFC4B
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738793455; cv=none; b=oAZYPFyTPYMVeVy0qEvIoa2SpSkXZlba/9QHyWmYJGHkbTTF/Q1Zwfm3AHkcabHaRqooghm0ATP+oXxjbmUPnuwdn269uE/x5YqhezBZ0Xrf7Jc/H0D1A84WQ7B22qLZFPPG+GXyFG/rilWM2b670lTcCIDKIK72WIqa+3acOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738793455; c=relaxed/simple;
	bh=tevJpiW23QX5vNawBC3V5mVwwjc+cyWAooyXhBIKf1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMUIxquBqXh2xhzt7l+4feHAh/ybxhWHYjt27VpMCvZPoeo6O8NRBrtC49g+VJep6Nb0RWzSdczK3peiiRaZ0ZBkbdLGYUXZqmecjBHGdGTK1O8kmYAZZw5933MMkUk1FD9Xe2cxCXNRRF0rGkW2m9jAackl32IzS7zfps7Zkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ZjI2/d29; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-543f33ff283so33177e87.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 14:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1738793451; x=1739398251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1kUn0CXtkEyI0HmOYkgChrezfUURGEbEEqQNfXB1bI=;
        b=ZjI2/d29TlAdhIbF3Ua8iyk0W8HWxsmcOMOjv2fDniTNR63JtmUsnwlSVues1a2+Br
         W8OihfQeyRyTrjVIOfrMWJ2f5xuSS+ORaHDqVmzeG5K/+e+Xpnp1AFCz3plnFGscWLMX
         2UC3OcyXWbXClU5alLoXkIhbZnfcXGPUsubPO1UxSYoRZC1KNyRO2JcuuZa/x/FdIXAt
         HUyZ2FZmRUtm/s67oF07h5cM+xZQM2gB88u5KYVZlQ4ptU5XasTbfgWwJiB+5P9EfKy0
         kZ4IuYzan6tXwU0Ro29DBpObE/afQvjQCUE2tP/KMh5u80yKyQfjjWOQJq2hOy2V6Wag
         e9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738793451; x=1739398251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1kUn0CXtkEyI0HmOYkgChrezfUURGEbEEqQNfXB1bI=;
        b=OfsXJTSg6+F/I7A9PEzTzqSmfCPsTJd2Z2HKGDvxXqF07HBQ1iKS4M9yygKuvEUvSL
         nPjh0FrfxgvTRwD4nIpWVycHE7+GUSvZ63XGGLby0VVCq8qqbgQpGfScByMlIzKe5zuz
         jytTiIGKWlNalnE6JBf6dC9eNV7E3EBlfVZ6rZQaLF6tXaeVBcafXjHyruMmHLForRAU
         tJmh1NlofEbUAcQtBBlCKZmv8p6ZA29RD34qYDEE2LI7iOUGeTQHu/blmKJ5McQ8gM/C
         HuoMon4TKdItJPn8FTj2y/uepODXNLeNu2br8s7L7cAxBUeTEhkSG4N20+BqT8+ILaXS
         aYSw==
X-Forwarded-Encrypted: i=1; AJvYcCVdp2Clwi0yZgyxEn3Fbo6IqiyLlT0rVs/JhZfO1u7jeCX+L5+6tzSRYzSMIZdszHBrvC6W+RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjH16zxioJzjMjMvfQKdzZe61y5wSHofOWa2Gn+ORCQR7AJ5Xn
	Fckmozclwq9c3xDZnDMBtKp1yZNKkK5gw88pPmFemvLioWX8QlWZZAD2/569NQchChNszZaKPe1
	jEv4Jtnvc5PAkP7uW5ntTG7RqRKEH7k86
X-Gm-Gg: ASbGncv++QlT1yGjSAQMG8+Qg/wFxNbep453M4iW2/M0VEfr/HKaxQZ1dW3objTpVtC
	D2Ohe4ZzYY4xKrtVypqLABce+wm8wqvAanIFryE38Z894jl6tBVB1WlP+B92MpTZs6vAnS1I0Jk
	E9Mog3lEpdJdAZ9Ozmmd/eVjI8RH6V7kFRXrXWMpXER80sMjiPHNur8SyOBcl3BUlPPpR+Z9cl4
	yUWYD2PAPa1/8m44qWCT3ohDsSbhGrfP3Lb2R+ybFWE8fJDDQYKlU3scrD50ZZhbGKjXVtMZD83
	DC4mWVbeqr9ZqHx/OR9uTXpD1jby84Bf4ZBJi1fC6Z64BRtf73UBVLXIr1va
X-Google-Smtp-Source: AGHT+IG0nuS0C/f8nx0E9P6dDMS0951lyYJUO3COjUsbinUq5Tt+K35UzFhNOFOrJL4Z7Fn3p5m3+3tWtWI9
X-Received: by 2002:a05:6512:1598:b0:540:1c9f:ff0c with SMTP id 2adb3069b0e04-54405a6baacmr536916e87.13.1738793450501;
        Wed, 05 Feb 2025 14:10:50 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-543ebdf095bsm598328e87.15.2025.02.05.14.10.50;
        Wed, 05 Feb 2025 14:10:50 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 1A8C11C431;
	Wed,  5 Feb 2025 23:10:50 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tfnbd-00ANiL-Re; Wed, 05 Feb 2025 23:10:49 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net] rtnetlink: fix netns leak with rtnl_setlink()
Date: Wed,  5 Feb 2025 23:10:37 +0100
Message-ID: <20250205221037.2474426-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A call to rtnl_nets_destroy() is needed to release references taken on
netns put in rtnl_nets.

CC: stable@vger.kernel.org
Fixes: 636af13f213b ("rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/core/rtnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1f4d4b5570ab..d1e559fce918 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3432,6 +3432,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = -ENODEV;
 
 	rtnl_nets_unlock(&rtnl_nets);
+	rtnl_nets_destroy(&rtnl_nets);
 errout:
 	return err;
 }
-- 
2.47.1


