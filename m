Return-Path: <netdev+bounces-71915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168B8558F7
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7875E286A14
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89202391;
	Thu, 15 Feb 2024 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZQf6Zz7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEA38D
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707964416; cv=none; b=FbBxPp64COAyf4EeP6vezUI92Fqq1knYvBiu5izB9CaNJRD2FkEIrRXU0WYuiegB1FDZ5FXT0ZjZI8cBFexq0kXMYMUQ2hwGq+ctN5MheoN1gUpdQlabZWL6oiXGDV4INeR30fC2fd7/1Y9vxq65SRgCMItaIu9PCkHmyKcUJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707964416; c=relaxed/simple;
	bh=SF0/B1S6T8DosRBNfVw9T5R2hgnX0tedGMXMotAFZRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gm0wG5Bz/rceZLJMmVuCcp7+h9TpQNgiht1kmApY+nMFgowlaBDXMWI1NQiQri5crqgs8CSpnRil2fvrV9yJytD8HW9OCcC5UWlJRksmg8u784MWKzzE9FFrao1z3NhOV1XmXbDtZmhjc7NhLik0WDK/tYq4KvXh/1urVonN5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZQf6Zz7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1db562438e0so3188885ad.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 18:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707964414; x=1708569214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDf9hzPNGorE19o6MXV5/KNT1SpTHRDfnWIgP0NU9dQ=;
        b=mZQf6Zz7YhW98EXQUxf9fZtS2VZ8gp5SvUpjvUXSYekH6229+zkvwIM0WofM8W32fz
         4IjyfBeVXtsB+m/JYWnKLQgJLjLQaMNJ3Em2aK8CvZibMpH1r4bqq5oOBpcBMwZU8C34
         ebWIPogfOcG0Mf5AdOyv3Qx8gJBBCpQ0urz/s4riQizlKPUivKhZdn+7lRLY/7uXaZPp
         AzGM0Nl+lgP9aVtD1OSr79XMiOz7hmeK53pv6XF+mALBVeeXwcxJ/fuRhacrH1/4iO5Y
         ZrKCDollICb7H0kH2QY3mmTcHh6BKMgsPMNpiTmkBDsRyXHVz/yJg/LNsceM0NmF6pCP
         8uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707964414; x=1708569214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDf9hzPNGorE19o6MXV5/KNT1SpTHRDfnWIgP0NU9dQ=;
        b=t7c4qQR0LUdHw4PUhZjc5ogny2Tr2dwiam3RZPHme0fcB7q3k4MYRcYaT1FpAX3pKh
         fRMT+xxY1D4V1E/TXSOF+nn5Q6d6MpYLC8Y9Aur7sJu+xbayavMx+mvx8/gB5zE8Wbav
         EU+tV29DwE4WNh3A8x8KHaiMhlA4uR5iuQPPgs752k1f8/t+dazkLNk1SmPs1+ClQocC
         X5sT/C8f2cwCIHJ66Tt2rzbKn32gJ3PSf8lCFrbrYJsF4OnrFoGwJaDbhJ6y9xDEvTxu
         g0vb+pmUqCl9bNKlbBxTu1mK/P51ZV5geJqeocVTGe70dVHFz2atePQlQPlxpLdd+I3Z
         GloQ==
X-Gm-Message-State: AOJu0YwqS8Udw8PwP4xuXCKSNizop0jyxYGPT+18eLtoIe03dsUFtD2X
	5MQJkNyEk5lXuXcB5eJLiPbjnmAiVllqqkeTm3qSE7G1B0V8qxQxWh3xU/kDTqJY6A==
X-Google-Smtp-Source: AGHT+IGKohzevNCj38U6RAjHVyKPZrLcWNLkmFAIU1pzsiuxtJPvTmVi87GoMBuacSrHEVdpaja/Nw==
X-Received: by 2002:a17:902:d58c:b0:1da:2216:f21a with SMTP id k12-20020a170902d58c00b001da2216f21amr577190plh.1.1707964413855;
        Wed, 14 Feb 2024 18:33:33 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kd13-20020a17090313cd00b001d9a1d7a525sm126233plb.273.2024.02.14.18.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 18:33:33 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net] selftests: bonding: set active slave to primary eth1 specifically
Date: Thu, 15 Feb 2024 10:33:25 +0800
Message-ID: <20240215023325.3309817-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bond priority testing, we set the primary interface to eth1 and add
eth0,1,2 to bond in serial. This is OK in normal times. But when in
debug kernel, the bridge port that eth0,1,2 connected would start
slowly (enter blocking, forwarding state), which caused the primary
interface down for a while after enslaving and active slave changed.
Here is a test log from Jakub's debug test[1].

 [  400.399070][   T50] br0: port 1(s0) entered disabled state
 [  400.400168][   T50] br0: port 4(s2) entered disabled state
 [  400.941504][ T2791] bond0: (slave eth0): making interface the new active one
 [  400.942603][ T2791] bond0: (slave eth0): Enslaving as an active interface with an up link
 [  400.943633][ T2766] br0: port 1(s0) entered blocking state
 [  400.944119][ T2766] br0: port 1(s0) entered forwarding state
 [  401.128792][ T2792] bond0: (slave eth1): making interface the new active one
 [  401.130771][ T2792] bond0: (slave eth1): Enslaving as an active interface with an up link
 [  401.131643][   T69] br0: port 2(s1) entered blocking state
 [  401.132067][   T69] br0: port 2(s1) entered forwarding state
 [  401.346201][ T2793] bond0: (slave eth2): Enslaving as a backup interface with an up link
 [  401.348414][   T50] br0: port 4(s2) entered blocking state
 [  401.348857][   T50] br0: port 4(s2) entered forwarding state
 [  401.519669][  T250] bond0: (slave eth0): link status definitely down, disabling slave
 [  401.526522][  T250] bond0: (slave eth1): link status definitely down, disabling slave
 [  401.526986][  T250] bond0: (slave eth2): making interface the new active one
 [  401.629470][  T250] bond0: (slave eth0): link status definitely up
 [  401.630089][  T250] bond0: (slave eth1): link status definitely up
 [...]
 # TEST: prio (active-backup ns_ip6_target primary_reselect 1)         [FAIL]
 # Current active slave is eth2 but not eth1

Fix it by setting active slave to primary slave specifically before
testing.

[1] https://netdev-3.bots.linux.dev/vmksft-bonding-dbg/results/464301/1-bond-options-sh/stdout

Fixes: 481b56e0391e ("selftests: bonding: re-format bond option tests")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v2: fix some typos in the commit description.
---
 tools/testing/selftests/drivers/net/bonding/bond_options.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index d508486cc0bd..9a3d3c389dad 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -62,6 +62,8 @@ prio_test()
 
 	# create bond
 	bond_reset "${param}"
+	# set active_slave to primary eth1 specifically
+	ip -n ${s_ns} link set bond0 type bond active_slave eth1
 
 	# check bonding member prio value
 	ip -n ${s_ns} link set eth0 type bond_slave prio 0
-- 
2.43.0


