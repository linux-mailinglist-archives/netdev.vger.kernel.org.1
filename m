Return-Path: <netdev+bounces-207759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5F5B0875F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE8E1AA4EC7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67422676C2;
	Thu, 17 Jul 2025 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvHA5Zk4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487CC21B1BC
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739030; cv=none; b=mr2HLRkG+8Azs+IVn8vRytCo2hpeZQVW4bk6LKa1h/KlKqc2jMaGTkqf7l5vBDi3apOsqWYVWp4/6aIqzrJrSxxeyR3zNAxwTgk98YeAel4pOpreLAxhBwU2uInCU+umQIa4v5BezGe0H1nALBcs5jPl29BYmsWfIj/MBJr075g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739030; c=relaxed/simple;
	bh=lWOn16S5K+JL2aOA+3Vb/eh9UmaQ1QwZwyxOOM975qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRUZu/gGKVg/JdvQQWm+XlZ+y0FLGH5iqOu9Z1GZ7hDJkZiknNhllKH+iWyhCe8sUsCrlfwhHIt2P5krDS69MWfExhu5uRjjIhNrNcKamAZcJi6c+rJuQXuKxqG2hR0aj6RIP4VbMphnOSezzNk35X92GYvY7MlYzIIK2DGqUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvHA5Zk4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235f9e87f78so5888525ad.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 00:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752739028; x=1753343828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X8aIWTs3119y70F91xFMzdQTMba+5CavefOUWs2SAo=;
        b=hvHA5Zk4deggihH1spgJitS/9K3GUTN/PU9dxEOCj2FMrt1Far81GsavTJPHkA2HcK
         4BAaaEcDHTYurKjF2efTWJ0OkFs9U9FF/Wlqcfcdhc9wybVeYAQwCbRqZ85sE5dIO7ff
         rsz8NFplwTphoU40ave4rV9jK28NyUa1AHeM5E/4XVylIANIqVumazcfJaXTa4MZhnEG
         N24Osl+46M/AumQPs6eb1hQg8GNoZDF0jG9NvynGu/5KOw5QabBvgocYrYGU1ELiRh8t
         bTBrxDEMeHIDOprlBpU0MqE93Zi2jTLpcvEpjzO7Qfbs8seLa5ZuaXNo0LyO8+zyTjpJ
         rPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739028; x=1753343828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6X8aIWTs3119y70F91xFMzdQTMba+5CavefOUWs2SAo=;
        b=qkl+8mXqia0pJlRIuxdIPlmxiN9nHWJSqgKu1UPTSj+qYgriVp8QNdQLaOCS3thU0J
         ki7HoWgvUWrxtJ7JePBMDmtTlj10q/qNpPs6cQpRc46znlWk4tLUryk7PNQhBUl2anAi
         iEhij8pAFp/vQ3k/O8ZFZIvNOhN03I//H4D8AYuJiriLix023DkIR2D02wQGsueZHu4L
         4ezsLlR5e538pybj/ybZjKsNDFp7t6N2tkQJrAnRoRy16oQD9rpDmxb5V1PSt36G53jK
         FVp4HQIiCT6aAXcxfb5jPJVkMrzQ6G2uY0DJJBB9244Ezl2pARcyMaE7rbh9xzyWy+QS
         NUlQ==
X-Gm-Message-State: AOJu0YznrL4RYZCoyHLtxvpS4iQ8qInAjv1fyyPydRL/1atm1YulvrVC
	WLYnf6I39f1mtCGO+rlvFtwcEg+8RAU5Wq575HUHwPhYJPlKqKsHI74x+XFkJhzw
X-Gm-Gg: ASbGncuvxMCL/5DhOCSPFtPd69t1mSc+dxVwudl2Q2WZdoq9htvDpfBO54a506VJEn1
	+9yz5v0Pk/eIscEXxnqTEH4rdNYEFMIVFZadx2XJKcg07Ma7B9gw91irnUFByNwZmEgZzFhGBc0
	+BEFU8CnNPf7iZPj1RVIRgJZaFG6950FEWOuirhEkkgdyGT/+Xe41UX2pEXyCCh/TUJoBk3Fn0U
	up9Suezgz4DHAmRL277BY4fydQLDL9yx/EjVUS5/lifIEmdjiME912vrIewGY7pMLA3jayt0RRg
	+WcBtdGrnCcJ8j7w9cLAj7995kGQrg8tslg87TLa6nChpsif5PHJUSuSSdu/uZUyuW1Xo5SX//5
	I295Lnr/89F6FUiTlB76fZ3keEKLwNnJT0Xo=
X-Google-Smtp-Source: AGHT+IGsGh7YY8/CoSZJTq6uZzKjYXxjII40LARRlo0kXaABbi22FZjbx1jvxbMMXu/k7LxQuSQtrQ==
X-Received: by 2002:a17:902:d4cd:b0:234:ef42:5d5b with SMTP id d9443c01a7336-23e2569b40amr78318895ad.16.1752739028148;
        Thu, 17 Jul 2025 00:57:08 -0700 (PDT)
Received: from krishna-laptop.localdomain ([134.238.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322e92sm143118425ad.128.2025.07.17.00.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:57:07 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	tom@herbertland.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	atenart@kernel.org,
	jdamato@fastly.com,
	krishna.ku@flipkart.com,
	krikku@gmail.com
Subject: [PATCH v3 net-next 0/2] net: RPS table overwrite prevention and flow_id caching
Date: Thu, 17 Jul 2025 13:26:56 +0530
Message-ID: <20250717075659.2725245-1-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715112431.2178100-1-krikku@gmail.com>
References: <20250715112431.2178100-1-krikku@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series splits the previous RPS patch [1] into two patches for
net-next following reviewer feedback. It also addresses a kernel test
robot warning by ensuring rps_flow_is_active() is defined only when
aRFS is enabled. I tested v3 with four builds and reboots: two for
[PATCH 1/2] with aRFS enabled/disabled, and two for [PATCH 2/2].

The first patch prevents RPS table overwrite for active flows thereby
improving aRFS stability.

The second patch caches hash & flow_id in get_rps_cpu() to avoid
recalculating it in set_rps_cpu() (this patch depends on the first).

[1] https://lore.kernel.org/netdev/20250708081516.53048-1-krikku@gmail.com/

Signed-off-by: Krishna Kumar <krikku@gmail.com>
---
Changes v2->v3:
  - Wrapped rps_flow_is_active() in #ifdef CONFIG_RFS_ACCEL to fix
    unused function warning reported by kernel test robot.
Changes v1->v2:
  - Split original patch into two: RPS table overwrite prevention and hash/
    flow_id caching.
  - Targeted net-next as per reviewer feedback.

Krishna Kumar (2):
  net: Prevent RPS table overwrite for active flows
  net: Cache hash and flow_id to avoid recalculation

 include/net/rps.h    |  5 ++-
 net/core/dev.c       | 91 ++++++++++++++++++++++++++++++++++++++------
 net/core/net-sysfs.c |  4 +-
 3 files changed, 86 insertions(+), 14 deletions(-)

-- 
2.43.0


