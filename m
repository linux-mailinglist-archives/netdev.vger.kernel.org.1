Return-Path: <netdev+bounces-174500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00751A5F02F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D7A1887A94
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2C2641DE;
	Thu, 13 Mar 2025 10:04:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4E13B5A0;
	Thu, 13 Mar 2025 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860251; cv=none; b=ezJq4GVqy/ICSdQn2NEqQOhH6Ri/IbsSiB91UtxlvL2Ek1t/NFK/opKhl4wiGkwbyxNqNGnNBTC3KrYOrpqZ9y6L3xffqPD4kYu7iyGYxUOz/jo4EF5mxG5hEC5yRAWgFUrPcmwGtVvyZKqvJBPmQPIacQMBZMxaWLhi+SXqzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860251; c=relaxed/simple;
	bh=1d9rwvR5saCp0EdhYztcjIdDfwg5pjT3HmajtsxKKTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7Qy3CrjMjspzipFpJ2j4OOCzowzaza24ucmCqSBU6x1KiQWMCDdBmU/usEMZAKAIZG8xXXWtaoIMRKUJXE0jtiVx+4jnDWsAOEJN8uV1p0aQ5aOqaM7cR2cLbzRxBeUGksYJqypEbyLezxi9glrRDojDd1sgdc+PguXUNTWUbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223959039f4so13765045ad.3;
        Thu, 13 Mar 2025 03:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741860248; x=1742465048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTpDb7E7Kgg1mQRDqCTRFcTgplYc3DjbNW4+KhK/wVU=;
        b=QLLQJyvwr2VRQJ/gcLojzFICuB0zuaawowtTEaD6cza03dF5X4z1ZvpoCts4OxaAtv
         qKg1JPwnLCGQyPL2Sgxpm5tmCqoOafdAchqHbogzyzrslgkwKJnU9rYgXQQzHaMoypdP
         GCSr694lST5WOrN7CxyCEn2BSBIi6lIy299dKCvsNJ0dMnt59ATsC0IPHMtfkglrFzDO
         UWTw7ErScVlddP2pNioKlgYJ2SAGhUVyt+GmD18i9HNSsAKHdMu6qwHZezcDw/bPCKZc
         AtacE+vr/MNbqWIzpcmejJ9wh1DVA6EfiRNNOELVmeAmtXcqU37zAJwUwXXSacKwvXA5
         9jyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEZudVDA+gr/BHrnynkdczaN5kQE2PvONfvmNPChsgU/givzY/QlQd8BDssxnJscJgJ4nq276qlbFYo44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzK4sJopXzE/GcbdeEDOUycIw2krR5mjP4+uZoCeT2wIDi3WS9
	pbiwwRmAnbVYZYzPeaZ+cBAQOclVvGeqYXdHjXbPNXVXbK6lGZzfD151duFrXQ==
X-Gm-Gg: ASbGncvzBay2D7hSqeIAeAR6vnLxiuqFTQjlaJ2TrKz4FrSC3a2T2aXcq4FvIgjzhk4
	Q2VxdpwiX2/C6aKOme9KOzYhojg43MmRi9IhCnJ29DSfuo+pY9NNtFDRckRybaNdRp9yOtkhBFR
	Y0PDwrwD8yzCsK1r/m43YSlCNkTKAZWMU8l1BJylAbAqdxF8W5ar8MAm4hFQaLXHRuNBZ5ROPxR
	IXqrRzfDWVxJ9Sz6uj8XisYvc2ebMSvXAd90SAWJsVKvFAijDhrd/g7lbll56tE4qTKCOcJzvDn
	6XK1dxJTvAJkqKpFZxfhrTeN8rjIGKEaX7wVIMsaV0Tt
X-Google-Smtp-Source: AGHT+IFX6/pa4VhGBivbCC3CtJNwH1YfTlzwX4CCD5m8Y0Zl+Ld8fkpWuWGDaqr+P+mpvgxyketlVQ==
X-Received: by 2002:a05:6a00:3981:b0:736:a7e3:d4ab with SMTP id d2e1a72fcca58-736aa9d32bemr30744617b3a.5.1741860248431;
        Thu, 13 Mar 2025 03:04:08 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73711694b72sm983524b3a.133.2025.03.13.03.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 03:04:07 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	horms@kernel.org,
	sdf@fomichev.me
Subject: [PATCH net-next] net: don't relock netdev when on qdisc_create replay
Date: Thu, 13 Mar 2025 03:04:07 -0700
Message-ID: <20250313100407.2285897-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eric reports that by the time we call netdev_lock_ops after
rtnl_unlock/rtnl_lock, the dev might point to an invalid device.
Don't relock the device after request_module and don't try
to unlock it in the caller (tc_modify_qdisc) in case of replay.

Fixes: a0527ee2df3f ("net: hold netdev instance lock during qdisc ndo_setup_tc")
Reported-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/20250305163732.2766420-1-sdf@fomichev.me/T/#me8dfd778ea4c4463acab55644e3f9836bc608771
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/sched/sch_api.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index abace7665cfe..f1ec6ec0cf05 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1278,13 +1278,14 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 			 * tell the caller to replay the request.  We
 			 * indicate this using -EAGAIN.
 			 * We replay the request because the device may
-			 * go away in the mean time.
+			 * go away in the mean time. Note that we also
+			 * don't relock the device because it might
+			 * be gone at this point.
 			 */
 			netdev_unlock_ops(dev);
 			rtnl_unlock();
 			request_module(NET_SCH_ALIAS_PREFIX "%s", name);
 			rtnl_lock();
-			netdev_lock_ops(dev);
 			ops = qdisc_lookup_ops(kind);
 			if (ops != NULL) {
 				/* We will try again qdisc_lookup_ops,
@@ -1837,9 +1838,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	replay = false;
 	netdev_lock_ops(dev);
 	err = __tc_modify_qdisc(skb, n, extack, dev, tca, tcm, &replay);
-	netdev_unlock_ops(dev);
+	/* __tc_modify_qdisc returns with unlocked dev in case of replay */
 	if (replay)
 		goto replay;
+	netdev_unlock_ops(dev);
 
 	return err;
 }
-- 
2.48.1


