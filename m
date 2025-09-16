Return-Path: <netdev+bounces-223357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B382B58D77
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 06:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DC3E4E2953
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 04:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70612EFDB3;
	Tue, 16 Sep 2025 04:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRPVEEEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726827BF7C
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 04:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998182; cv=none; b=fJ0j5Gah6lLAcyNuWzG6FfZHpmOZi+xxbYQKX3BYaePYoKQMhh/US+DVkqGyH3lig/R8GrALkxkDouMjNJfekTY2l8ipRCw/YtgRqoAbWZp1QycaOkKBJJWzifptwoXDPmx14pg+0gwAFN4tBdatMFNCjhoA81ZvJETrmarVpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998182; c=relaxed/simple;
	bh=xZie7XPvdT38eYIBnvXACDOKlp4uDfFQ6p8xkwCAypA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YSYGK0nUB5cW/0ErqRtg6+cPplwjj7OEFb2Cyaeu10YOC5mVE5mJoY5yH7Jef+bIwz/m0wIzxtEvVuwNO+elLa/eI8OHzkGHO8yO5pLJ2MosoG9zp5ySwRtW+6sWWLpNY65onRJW+J4VTOAko2pxSW853R3CysTHbq4tGoS9yBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRPVEEEM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-244580523a0so50867285ad.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998181; x=1758602981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=VRPVEEEMyPFp1/apdgsdGcdVZa8RyIEDb4oi+MRkYBM99QFUqx8qesncXE5xPiXr4k
         5EmQzzVM6ROAy9MD5JQWOsyeqzNpcJOOfhDFpvyiLSBzgAVmSV4PpvkG7J3oLLXh3T2t
         aSGMxXUkZ/sTwLMVvwCxtrd/98Mzai0cB56bcT2QDXO9wehrl8U9zH9CWY9ycecU5qrW
         lgZghkMXBNPhiPB0dDJ7sUurWKQUnVaHBn61VqMU8sFvJRgf6DYXbUA1UPvggaPVkZ2/
         wEyAhf8NXX+w9nILAVNf9HZ/dItwjE6ImKe5EZYWjDrUvt9j68hAE0JwgxYdvG9auYLy
         KGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998181; x=1758602981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=K2cXfeyZDZDnKzFWT4loxQbSMaJzePax6Q1CP8IvPPKkzksDUETg5bqzy1NnHLOQtw
         FWRtpem3gAdb6SMuVCfYel+QfSBks6kMWR5OVH5ec1sYwP89qJckwcXZNKuSTMu+YJYw
         +zgTtAEdXLrHU4kt9OqoUIjv6eQLXoxNdlYqd4CaXaMaTtceiUxAgWeYFqjEjt99hB2Z
         cWdaxvEGoIhkAzIKU5ZI1Q43OsicgUxWsKhgI0XflczzrDzfGKGNBHfJPRMXph9NRbrj
         5Z6mDg59qaOv6oDTiplyzPdLpwn0qghzQ0Z94dqyXVefkdUgXhN3FouIrTsLPm2VlaTp
         SobQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnviNs3CA9diFSgeBxDOcknDB+SC2DALhdeBsGLFyjKY+suP9Dro2CvGcmP2nGmIACZspUh0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsWrLu16dd3tkiCrPaKBR3CmKQNKruZJIBzWvORXHJaT2H+xE4
	XGEdixjTEV8S7Mq1FiHBmci/KOdCtRas4jxGGRHK6VtIi/T/qSYUJj6e
X-Gm-Gg: ASbGncsmc//FpY8jfCv1gN6DG+np9snSBFsSK4tqn/ofEpK8/9smo2ya/dk28NHXrXI
	qn/QJfSaQzWJZQsUBoc8SLTv7VMM/Ikk3B6+8gCEs8Cze2qgduI+F9DWulvNZE5G2BfPlL7UOSl
	13XGJC0Zim1IxE+z1tZ+poKQ7U0SkoOEUsbKM4c2o7GlowQ/5g5po8H8wTwxVXR6Mgzxltvd5tI
	8DoigJBs0JQzxacFdqYpOephf8MEauitxv49+oCwra9b9USIr7djcvdC7SPOvGW+H21fVaH0GuW
	vFT3vBnHngA3PjQtP0xV0UxezWGWeu+tw0uFBrPZvfB/6nn7hrj3pspPPMh8j2fzsidwEZ/4BaI
	1vA+b4NLvypL/H29w9C3rTwID7phCQqR6zw4+8Sk=
X-Google-Smtp-Source: AGHT+IEk/DXYOCMhugqpymqTGh+KMlTQeAIuikssxOXlHLYZS5SBPJrXDrKkOxyomJ+DECodEM8EoQ==
X-Received: by 2002:a17:902:c40d:b0:251:a3b3:1580 with SMTP id d9443c01a7336-25d24cac4eemr191581215ad.6.1757998180587;
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 13/14] net: bonding: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:34 +0800
Message-Id: <20250916044735.2316171-14-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 4edc8e6b6b64..c53ea73f103a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2485,7 +2485,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 	 * concurrently due to incoming LACPDU as well.
 	 */
 	spin_lock_bh(&bond->mode_lock);
-	rcu_read_lock();
 
 	/* check if there are any slaves */
 	if (!bond_has_slaves(bond))
@@ -2537,7 +2536,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 			break;
 		}
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&bond->mode_lock);
 
 	if (update_slave_arr)
-- 
2.34.1


