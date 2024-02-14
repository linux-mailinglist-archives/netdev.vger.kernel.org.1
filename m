Return-Path: <netdev+bounces-71635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7594F8544F0
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 10:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FF91C214ED
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B281173D;
	Wed, 14 Feb 2024 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyJUtvEQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037B12B6E
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902404; cv=none; b=DdGVmNWrg9j9qgryXe82DB5n3Yy6Us+ywN7x1ekOyCLCrxl2GvG+7nwUL9/669TNPQnmek+HOlweqEL+mPzRwGKKZdTnkpeShZucsn58kR6VQJT2/DIPF/T1S0wUXT9DwFUrsa3lDU6K+knGCO+YM5hRRaAGb7fy56jRxpzPbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902404; c=relaxed/simple;
	bh=eu/7H7FqKxSXcatQgWXl10FcinjKw5u6WiuQD1uJiY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YU8Rzk8sRNn1Ad0GchXGEuAaQSTq0zWzLPvJuc/73ipvO3lVfK8Gn0VZ/AN00CcY/vXwlab4fEdi1a3s+3qrDGVKScD22qwukHt8VtFgMM4vG65D5krd81Z9ZeHgWVdCws+9aW4q/xmz9HDlgpeAa8CJ1zKTp3pH/wxkllNH/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyJUtvEQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d73066880eso47854655ad.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 01:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707902402; x=1708507202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq5ror960DKyeBS40swjW6lVDDDmShEBMAQk/imeXRM=;
        b=IyJUtvEQuFuDgtKRaZHQ3yJLjYztOKd6o4ZpXgFSnTF0x0uQK2n5IUZ52WB4UZJ5YE
         6mPWJDmxpNa/kEuGFZNHQYl5F2suHao6fCrxKHVZt8cptC348HiaBHhx24jo95zpppDw
         Vkj2WkEc8THIp8444yWK0/niSl1UgWqDo3GMvczyDpjkpZbqtY1VPz56QuMYcqJ4vAag
         oRbW3fxFF/U/NStM/OwiomAPC+Pzza3e29qsRp5AcNj6h84ydEnLJwKBpixBakPW7Aw6
         DXGmLRfll47HojZOuQaL/2gHFkbw1M0QxlD7i9S/3vHWasSnQXO5+Hgpa9limp30aXmv
         9c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902402; x=1708507202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xq5ror960DKyeBS40swjW6lVDDDmShEBMAQk/imeXRM=;
        b=al6FVD49NdsEVGTfpkOzcV8id6iS2wffCP+nSAKwffOaKxi7nnWcQsy8m1tN7NXZpA
         irtK6Amox+wtEQanmiey7P42MbzGRE51aQliXAfCwioop7yZPBzJ6gzsCEzpato68gs7
         2RdrhfkMMdI5b7a2yPrskaGGuzRoWEx7Vlp9KKDx9gwqlyCIilCGI0UEsVaOHJ0OzdHR
         q7dxIWdG8uJNH52hdsCwbuMt47BHT0jz/3de4yFAoFT1KEmzIRbt38jcUycC8GS2IAOR
         28zMFRpHvrreknIlHeZc5WGvZrmBiZNzLfgt8l+o2GcCCaqjcIIjwT5qUusm+pg+0gQS
         fdwA==
X-Gm-Message-State: AOJu0YzrO7BMk/6ukLI/GjFBRRLSJnLMez5qNlNvXzGVDd61tqcxVLVL
	MqKP7RB/eUle+L5vWqt3gAhYIHSGUzBiXOu+kjHXSb7ZxgzNRB8Oy5YRwO2pNKdimg==
X-Google-Smtp-Source: AGHT+IG7GDQK/Dq4aOakf2ZmTeLfTyhDEJcUOFFUBIQwjCB4j1O5wFpySF5fhq00EgXxbQzvuodQ9Q==
X-Received: by 2002:a17:90a:de93:b0:290:69e2:de18 with SMTP id n19-20020a17090ade9300b0029069e2de18mr1806739pjv.41.1707902402003;
        Wed, 14 Feb 2024 01:20:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUk3WSeOJYyS3PdPETieDm7d4zxmcFRq9Mb/wBkHRvb35hzA0+3h/c9KIEUrIUGHwxZbhDlbUp0LKqoCCfMT5sf7EWbFlWsKUP1Hh+NOJwy277Hd37sP3OKfpMfoB772RipzTY11srf+dj8UfOWSF9anDVNspOgXj4GnCJTnvnREp28bGrgJ4VRPL7AwK88XIqxqpB3U/88hb1It+slF7fiZpBs1A==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ch7-20020a17090af40700b0029681231ae1sm914850pjb.28.2024.02.14.01.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:20:01 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: bonding: set active slave to primary eth1 specifically
Date: Wed, 14 Feb 2024 17:19:55 +0800
Message-ID: <20240214091955.3040930-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bond priority testing, we set the primary interface to eth1 and
add eth0,1,2 to bond in serial. This is OK in normal time. But when in
debug kernel, the bridge port that eth0,1,2 connected would start
slowly(enter blocking, forwarding state), which cause the primary
interface down for a while after ensalve and active slave changed.
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


