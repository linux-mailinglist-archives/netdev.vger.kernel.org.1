Return-Path: <netdev+bounces-176540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2CAA6AB77
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7D017F66F
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48064214A98;
	Thu, 20 Mar 2025 16:51:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D61321D3E2;
	Thu, 20 Mar 2025 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489467; cv=none; b=eVPIFHd6gF6PIUD0c41RD2Yune3hi7OKu6nvT9e5IV29F1HQVXLY+slnGvbvBRPRpQ2Wcw/KQLU8gpjiSkQw/to9CHxZ88xQ9bZFnM5cYmnVTxm0iLrAnG+rrYnK23QA2NwE9mkpow1o+kZMUF8/TpKjejxbkOEveNB/JGdLlrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489467; c=relaxed/simple;
	bh=96XACga2vRXvHJIb8ALHCPTfpdziK3WvQkZ4PbiQkhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQb+eMGpwQBFgmfxzsRKAaRudITv9bdQYpTv214RPtYPLPsNFrQajn9WRld3ymHc309ZI73yZPwbjlL1+OfyWpxE4BvtQpyvBKnMfXc8acdnUj/+jHrMO+eEvt7Ao8pOc/mxkF39MJmO3t2NXpED8FMJmpjqC0foNJd0IWITf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224019ad9edso25885085ad.1;
        Thu, 20 Mar 2025 09:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742489464; x=1743094264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePOhuEBOuQw7EEF85BsUnrOhaZqLyrnFAXA4BOdYNfM=;
        b=LIg77Nb7pgHJ9fnGduXiDoY8RoBQcrjBfmWJgLpIlZRFKlx6B0Ia8j1jNDOq2LvC35
         FItJy4DP7CZ+ULT/LFmcJNNN8tzwaP5uO/vc7BIr+S17Ivl13rZt4SVIANimN36/EGsk
         QNL5bsORGyns1UM32fJ6gwMdfcmzTPuBymd9pdYnljFJwKKG8dDE8rtFTy4/hBG6Tsug
         o5hlq1UP//fCXT1RbMpdfw+myZ1jtaTifGqdmxAXxNHsIY+5f4eIUooum4fqLSwoOz9F
         Ir9i5A3e1AIOHjFelGt5gbvHiM3xRoYjZdoxhxdVjzzCfFzhF0DVOApsXhElwvHqHULt
         32Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWd0eN6NIkCo1uouMrhtF0SvIu9f2K1EOdkHJqhuvlY+nnfps/CK1N83xvE7S/1O9B/lGFS3bezAEEAkDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OtYceG77qPXlthHL+rdxoqylCHHffDOK6O6tfMEg0AFgRL94
	hfwIXNUcfbcZspLnMiWGgXcg/q9HjCyH3f1LiMU2iqMMs5Fy3wsAZiol
X-Gm-Gg: ASbGncsZdIKlf8gT90NYmKohSHPqCdlpX35z314to1a6r9w0jdCZLJzg6DRcHcIMKrU
	R0V5Ib2Jug+t59hu5I4o+lxjCgxKC+VykLFTri+b7FpqF2lFpmoGXzWMeLq4FPqgs0x6tGxO+Ud
	jqeJMtCXZgQzJEgBhyaTdtxy8gnkvEoiUnk0+cnouT+QWa5h+ab2MksUuapg5RPsy8vORRfwI+X
	tdDZeocWp+n5DfBX6iS0gNWdQudP58qnzZSPxqxKwTG63saQ9OFsGXJcn6hfb/In3C14+t9F1+n
	ZS1fLn6TMcjF7YK+wSOAdchEdj2OVNF6nsihGitWQ5TH
X-Google-Smtp-Source: AGHT+IFym2XBNm7BhSm1aJW6/nPpOwI8L8IRO0TBiReykeX9o8xWnc5WrTdklEthGTQ+1cbQkL/a3Q==
X-Received: by 2002:a05:6a00:179b:b0:736:52d7:daca with SMTP id d2e1a72fcca58-73905a2a062mr276066b3a.18.1742489464166;
        Thu, 20 Mar 2025 09:51:04 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73905fab82esm9448b3a.14.2025.03.20.09.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:51:03 -0700 (PDT)
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
Subject: [PATCH net-next v2] net: hold netdev reference during qdisc_create request_module
Date: Thu, 20 Mar 2025 09:51:03 -0700
Message-ID: <20250320165103.3926946-1-sdf@fomichev.me>
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
Add extra dev_hold/dev_put to make sure the device pointer
is still valid after rtnl_unlock.

Fixes: a0527ee2df3f ("net: hold netdev instance lock during qdisc ndo_setup_tc")
Reported-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/20250305163732.2766420-1-sdf@fomichev.me/T/#me8dfd778ea4c4463acab55644e3f9836bc608771
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/sched/sch_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index aef39f6dc6a8..85ddb811780c 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1280,11 +1280,13 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 			 * We replay the request because the device may
 			 * go away in the mean time.
 			 */
+			dev_hold(dev);
 			netdev_unlock_ops(dev);
 			rtnl_unlock();
 			request_module(NET_SCH_ALIAS_PREFIX "%s", name);
 			rtnl_lock();
 			netdev_lock_ops(dev);
+			dev_put(dev);
 			ops = qdisc_lookup_ops(kind);
 			if (ops != NULL) {
 				/* We will try again qdisc_lookup_ops,
-- 
2.48.1


