Return-Path: <netdev+bounces-132521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F3992005
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 19:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A06A1F216F1
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC90E189B84;
	Sun,  6 Oct 2024 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQtcqkIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106DB4D8CB;
	Sun,  6 Oct 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236283; cv=none; b=d5ggZebG2Prb6K4riTyimrGTJfaiu7XMD1xgQjtghSONhTBak/w0Fsm9gb6b++TSOmcM/o4FaO47hPodH6vbNvwpt3DUjzz1XX8qasybrLr9zJr0H+YRGJUHiANjdOjFlG1xshX82jMuA16Uahsfcozv9XPzftoAKoNRoHUIPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236283; c=relaxed/simple;
	bh=Ax8ED+XHDEDOee3jomxINuEh+tXeRTqsFET2gm9rSkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVfrxDYQh8iBEggoh3FCWHIov7+I9l3UtQC3PGB++RNBtPLzbZhj/zXrb015RiykRBpxn5lHsAgClTgkf/sRWjlO4OBvBtrmVq9AzECqF98/VYrr96vOL2qqP+DESmci7SnRmcCkGgbvTsHPwHnDd1E3LhQu/jM/cCttvkRuhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQtcqkIb; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fad0f66d49so54386341fa.3;
        Sun, 06 Oct 2024 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728236280; x=1728841080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8knR1jAqmQQMStE72cw1MCQF26YQ9iTIWSOF8H62+ng=;
        b=eQtcqkIb/DCsHk/PQHGK+/nASyRVTiDD/tqw7t44zsF/YQJe+XtwKtKXuRSuQO4rQf
         ITg+pB9P28EAZ0joHZl3mHzBvrUup5UViugJFHa7v0tNaHOmLv+ILCGTpponDSiCbVx7
         P1MvKTwwmf6XjowytjAP8pPmhtOrrCLDCy1nb8horNxN9Uo+olSgFAIbUfuDJUMKdnmR
         VahBOcfk2NVaoqM3tvnLQoDT4kaLIdsIsaWIGLGTAVm+ORKbvl5WtT0EM4x31Y/HYFD0
         ZjKwsmop4spqhCro8B3zfET/+uPUYYZqUmv0iRiPFGLIaWKVR/iPnUdEkcdIE0rC+Zo5
         cblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728236280; x=1728841080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8knR1jAqmQQMStE72cw1MCQF26YQ9iTIWSOF8H62+ng=;
        b=Q8j38sPcYg6d28/W4v5Dy38Cf8X2uaHG0ET10rT3JUhxBQC7RCE2EDAnoxxrBdLCTI
         If/YY+keuzfbWelQZXpSxbZvcJODrjr2jyMj1yzJgp6tyoARO/WBDU56aG/N+NPrBq+M
         zKuyVtKw8z3A99VPZRXpljb6Z7PY2GCvrr9PV2Qk4oDOmXBsxN7/O/wON2ZkhzTsVFH8
         H6ZJelSrZfJbu/N8BpbAAVHweDmz++WHcSm8vwJlFuGg4TALc9armGe4GI0DR4fdrQ2K
         WCt+PiwPPIKljEuNG0OfgcK+JxLEX5remShEcVJcYDkbUtkcy2M8f5gOgZ9laMoOxIgS
         KIzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+8QYfVa64E4W5DBj1Ojvc2M9YSyNfNdmf2307Dk0bHUnZZKdJHuD7uMoEZ403lhzGqxy+mVtd@vger.kernel.org, AJvYcCXW6W1yEkn/R/QARpDJp7m9F4W5F3P11V7991FFBse+MTMamlAtsykAnUqXcIvaEHRl1M8KXYhRWFDzKZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7rpVm7x1xJVJyCOu/CRtvTdl16fR2pXomsgo0/vgcrmXr86B
	xIcmIlq64hXKHDUY7gjAk5xjUSxpwEvpc3w98ypmJbe5DClcmCAiXhIYUw==
X-Google-Smtp-Source: AGHT+IGs3KcUMTSVIly5xm81fei8U8gVXQsFazAwjGqo5YFnsMg/tXEppj1wyjRdXzU58g2BgDwibw==
X-Received: by 2002:a05:6512:3b85:b0:536:54df:bffc with SMTP id 2adb3069b0e04-539ab9dc722mr3626806e87.42.1728236279947;
        Sun, 06 Oct 2024 10:37:59 -0700 (PDT)
Received: from alpha ([31.134.187.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec157asm581202e87.58.2024.10.06.10.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 10:37:59 -0700 (PDT)
Received: (nullmailer pid 15632 invoked by uid 1000);
	Sun, 06 Oct 2024 16:57:49 -0000
From: Ivan Safonov <insafonov@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] net: fix register_netdev description
Date: Sun,  6 Oct 2024 19:57:12 +0300
Message-ID: <20241006165712.15619-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_netdev() does not expands the device name.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 net/core/dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index cd479f5f22f6..06b13eef3628 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10611,10 +10611,10 @@ EXPORT_SYMBOL_GPL(init_dummy_netdev);
  *	chain. 0 is returned on success. A negative errno code is returned
  *	on a failure to set up the device, or if the name is a duplicate.
  *
- *	This is a wrapper around register_netdevice that takes the rtnl semaphore
- *	and expands the device name if you passed a format string to
- *	alloc_netdev.
+ *	This is a wrapper around register_netdevice that takes
+ *	the rtnl semaphore.
  */
+
 int register_netdev(struct net_device *dev)
 {
 	int err;
-- 
2.44.2


