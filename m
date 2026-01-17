Return-Path: <netdev+bounces-250708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B70D38F06
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 15:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73BA43011A85
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E30219A71;
	Sat, 17 Jan 2026 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1dWJuKX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240271DE4E0
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768660040; cv=none; b=sUTTBrX4HjU0NV4meIPWYVexLSijnEyQJ0qqKPr0F6Xhj4elBtXDX103ZJpCArw6bDcavklsWqwHofkGwF/fnNSphlc2GLjQo6IPtViLGa+lpeIqSmiEqJvWm5cl3qDq4NZv8dcXB+KCTFhkmfKfn6wGYUY0rthU/5LxQ7P4404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768660040; c=relaxed/simple;
	bh=S+XdwIvO+mBI/ZK3TBakpPxUyK9/MOzdesFbrmV8xws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HdY4e3PmIbjy12EUJIpxsFqs9h3rzBVsVSHyRGiVxqfTGHILDlyd6n1wojGxrfyfSLsKmvf3fYCigvZAqKL5oJNVZjLphLEWaIbfrH7jJ45FUP+ytU3eLC23sW4fqStT/rDRpEjZEQNj+Q6BGMrnTsXUGywYOk2leAa8SmdJ2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1dWJuKX; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81db1530173so1399705b3a.1
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 06:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768660038; x=1769264838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jesh1w+4PKrEjj1xZybWnRn57XwMf8k4mRrBd4/MsR8=;
        b=b1dWJuKXCaSRF+cIy1AAi/53WEsK76OZvf4/nimAb3dMLDmR6nCWxL6GQfSjyeNU5T
         zPrVOCJHNYjJ9jJ91TOz2yQcgQoIdELujy9oumKEZnyiIA7uptIifYabC+JyqbNJ2ylD
         nWP7G2RThdqBi9e3dfK9hbe8XWN3gxVOmAjblWjY/cFR5zjI53tNgGOm8WzJiqpSpbLl
         7VVbPpvSP6GW/sGwGbGYdyZDqpDia/qXOxGU/F99D32YM6JRHQKm93SQwRBkuxurqG9H
         0oyblwyYGAnNSkAv7ol/QwpZGPeR12T27bL4WP+ANI6HlP4xr6I1n3dA6lMUDrIZ/A+A
         lgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768660038; x=1769264838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jesh1w+4PKrEjj1xZybWnRn57XwMf8k4mRrBd4/MsR8=;
        b=iok1n4XmaxA6YgvgGAw/7o2ZMPR1N6lFYDgU/KYjcFntrZbA/P79siVKKbxAPUelix
         A11Zd1iTMZ03Nk2H4x76bJeMjB8at2pJ8+CZdIugSkdsMquV9HSqmHvi2knfgSXnM9mg
         CBBUcyzdJroxU9KKAdkbsK4Qhv97WF8m7zf16j9YI8kHR43ypJsw/euoRZIuUOm+ZPQv
         MgN+3l49dDHuKAPJSXtJ/kpzg462Lp3GzyI/eaTS7T7xrh8Tb1KSgN/a01spySTVz9qI
         pvmfjKF82Ni7KvtVI7BGqrfFcRfiKFcOiYmepc01zo0l4De6ORJXaNSqs6//h/8JjsZD
         zOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRbH8gi6u6l9ZMV1T5ZJ2v4pCMKqxZuCwDNapihcTGVcQip7SDqZ7FYNwuRyzefOqUMK9/IAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqpUgywfqePCzSnZMmtRWzzbbaZardyFzvf3/UBUPs7HnccGcV
	aQn3Opqs2CvgDZrUfqBmGySOyH+F5JxracvMFqJ+cGt3gMut6qz472/u
X-Gm-Gg: AY/fxX4HRgUU3qfHxOHFPGWJ+QSuG4BY5327DzH8EFOV02ehAXZsmluIsIP6bB2kG3C
	rruh5gGups3ts6dDeJhQuhVRnYCELpYn/0UeUN/2I6hCO22Bm5Cl7Gi44Aq1Fm+unLTE1N4bIPq
	u/IE8tkKbF4JXmV+EjI9uKjP56f2TDWr/+Is3O1/v0ztrxqWzDzi+RktZzmJqpYocCgEjY59Pwg
	ucwtgmpRBdnjxWlZ2JGWy0hi/IyfGK3gzEtlfpQ2Ub2QajJvVd5j4Id5ckVy2jfqOntsm2Uuw3Y
	gd2f7mkLmPjztTrvnfG9t3hGNBJq3b1FbZwDNfPrVGnaXh+ijuTrvX3sq1zkC7tspnnsizvaeEj
	ZABv2dmIt/PhVRHPen9xE9P60vqMDbxlNqNMq1QBIUm33/tWW5oNi/GRZzOlO6A5R67LiaXQB/I
	L2yqBFFPVSWsRWebARclOkQTUAzuac
X-Received: by 2002:a05:6a00:4009:b0:81f:477d:58da with SMTP id d2e1a72fcca58-81fa03382dfmr5799840b3a.60.1768660038227;
        Sat, 17 Jan 2026 06:27:18 -0800 (PST)
Received: from localhost.localdomain ([111.125.235.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bdebcsm4690399b3a.17.2026.01.17.06.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 06:27:17 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: syzbot+3f2d46b6e62b8dd546d3@syzkaller.appspotmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Prithvi Tambewagh <activprithvi@gmail.com>
Subject: Testing for netrom: fix memory leak in nr_add_node
Date: Sat, 17 Jan 2026 19:56:32 +0530
Message-Id: <20260117142632.180941-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69694849.050a0220.58bed.0025.GAE@google.com>
References: <69694849.050a0220.58bed.0025.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test upstream ea1013c1539270e372fc99854bc6e4d94eaeff66

Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 net/netrom/nr_route.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index b94cb2ffbaf8..20da41888151 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -176,6 +176,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		hlist_add_head(&nr_neigh->neigh_node, &nr_neigh_list);
 		nr_neigh_hold(nr_neigh);
 		spin_unlock_bh(&nr_neigh_list_lock);
+		nr_neigh_put(nr_neigh);
 	}
 
 	if (quality != 0 && ax25cmp(nr, ax25) == 0 && !nr_neigh->locked)

base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
-- 
2.34.1


