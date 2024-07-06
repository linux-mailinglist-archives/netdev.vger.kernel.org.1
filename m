Return-Path: <netdev+bounces-109601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939179290A5
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 06:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EA52823E7
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 04:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7575F10953;
	Sat,  6 Jul 2024 04:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrblvW7f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511CD2EE;
	Sat,  6 Jul 2024 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720239226; cv=none; b=uwePkda+7v10xHG1aYrQFP+5zSsHuc9+boTnYR5JnoEPM/RzqHqoh1z47P4MyypiZXPlq7fXfCd4tkaf6erjJ5qbi3mjJ1ow/yUUCRh/S+EHv11jgYHpoPu5asgjZTVkeCpg0Vukn8ekuohthkNlQ01+mcctKlW4S5Ua081HI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720239226; c=relaxed/simple;
	bh=e1COZmN0ACxDEpeBkzbOQ98FKCuHMtW6sMu7vJujK3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JkbYlRdTS/y7SGuiieU/+ZdWOrmfb1ewpmMTyYZScNum3M06pBMig/c3q88L63ZhBK+qIqJlzDFwVwE/FDPpTssXYX4hVd1b3XfBxrT/gOpbX8KcwJuZE8NSWSBQEGEHgAX5ATmnnxW9I/xs9T2+YDraPlclPN46A54MYOiT+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrblvW7f; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c2c6b27428so1442392a91.3;
        Fri, 05 Jul 2024 21:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720239224; x=1720844024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ls2hibznFQFFiyaBc2JC2K5T01cGRkJS+TyfbwgK9iQ=;
        b=MrblvW7fhKyKYbrpFIbFhqZaUMipk2BMOyqd0UxIyebLyo/nTcQ3V2uqRIqTmND+hu
         cYxjjH2hpdrPKdyRZZ9dwoe+3+r5iM5ZwJIbwPTLHFR3Rbg+j7Y+EAeo0dGyxs9lXrsb
         IKPW/oJM7K9LD2C1de+l2mDiKhIJ6kkxGApuld1uVTt1esjSMDNBjWMTAg3v8dUP+LT3
         7VABMdfh3YXSwiisoCcGf3yHBzVaYwX3MNVlbe6Ex7GWiRMcljQ6oO3Wvs/vk9fKznkb
         9ffPoy5PRqEhZHcUqEfeaFlz62ormWKeHbY8shuTezAaON6VHKFNCv4fL72HUoLa6arT
         JCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720239224; x=1720844024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ls2hibznFQFFiyaBc2JC2K5T01cGRkJS+TyfbwgK9iQ=;
        b=JKeIrNzzR4xQKnwREdb8LI3Tld/algBkD3rAUtwJX/X0f+nq2PNs1l9s2/xFjIwBa2
         tq6BJmoogZhwBPni9HQ4sKOgk2qOSsPtURROmLmmWDVdmMDyq2O+disNXEqjjyutC4sA
         U1KBrEUla7e4O6Jeq7f60amWlipe+7yQH/G+IYe+Ed2elNr4RUMa6CYKek6g3C13GGz8
         Cjp7Zdl3HbU4SfZWAzLichopIRGe1xiRobC/zy40nvBJbGmWbrpluJTN24N1GIhHO8vm
         yxSYPxX+aRHprzTX5akFogLGtQCPu7lXf+ub0AK2R7rqGV8RUQp36RCaYBoThN99nECC
         hcaA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Mv14+OKRJcGLmYEKbFfWkrNLR5FNAZqYyspDqpIL29aRh1rkIvUSMyYiVty85QnP1rgyxmzNPl5r6dq5pRcXafuHwvf8cvbIZmkfv0vNmGbPpNv8+DYWWnCH16kFbksgQfLS
X-Gm-Message-State: AOJu0YyVY+t3pbpPcESDxsAzh6lArswOsxcWrE6Dgyddt2CirmhAyZqC
	MtXw8T+w97qncgTu+Q3iRL3QcFWLRY+xuHJpEkG2TIHPJ7TAFBbN
X-Google-Smtp-Source: AGHT+IHCGqCb42Q2amsChP5zcfGymr0D3h04i0GUO67qjuHQA9EL9wMxFGJAuvlzKJFWMWh8BtbH8g==
X-Received: by 2002:a17:902:e80e:b0:1f8:6776:7ab7 with SMTP id d9443c01a7336-1fb33e4379amr51827745ad.24.1720239224169;
        Fri, 05 Jul 2024 21:13:44 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535d13sm148539355ad.165.2024.07.05.21.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:13:43 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: jiri@resnulli.us
Cc: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net,v2] team: Fix ABBA deadlock caused by race in team_del_slave
Date: Sat,  6 Jul 2024 13:13:29 +0900
Message-Id: <20240706041329.96637-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000ffc5d80616fea23d@google.com>
References: <000000000000ffc5d80616fea23d@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

       CPU0                    CPU1
       ----                    ----
  lock(&rdev->wiphy.mtx);
                               lock(team->team_lock_key#4);
                               lock(&rdev->wiphy.mtx);
  lock(team->team_lock_key#4);

Deadlock occurs due to the above scenario. Therefore, you can prevent
deadlock by briefly releasing the lock before calling dev_open() in
team_port_add() and locking it again after it returns.

Reported-and-tested-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/team/team_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..245566a1875d 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1213,7 +1213,9 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		goto err_port_enter;
 	}
 
+	mutex_unlock(&team->lock);
 	err = dev_open(port_dev, extack);
+	mutex_lock(&team->lock);
 	if (err) {
 		netdev_dbg(dev, "Device %s opening failed\n",
 			   portname);
--

