Return-Path: <netdev+bounces-71638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3368544FE
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 10:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FAC2819C8
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ADD7499;
	Wed, 14 Feb 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUI7jCzx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A3125C3
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902496; cv=none; b=I5kiqyZShTpl+8zMn+HZ0c+D/hSe+tver8zTYiO0Ay6dzDrub3aZnL+Pfyh98BVmGrnT4qYVYvx+fKtYHeAqhzkfyUhQAz8Ms3mUBirPK4dVT+INVz2NiUrDC7x/VJYQrGX8szOh+NwvuoTjiy0xi+c4ZtS88qzM9oBD8xD+WKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902496; c=relaxed/simple;
	bh=Us+gU2RdsSuJlzVfYELTSS5MwQiekcjSDYnrthhTD24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbueYKSe/rSE7M9g2MQJNkfQR7XUbmVu3n/MXAUeRAfNz8HA3PdxE4Qv/3Hcm6xkH2T9OKlGZSuIfM0i8REGo/hHbeRMtq+7rbM54yDhRI38LepPGmZ+4cWsh/d+78P+lFfRREwQmc/uPp9iQ+qRTIijMZRvAphWj6djIdgZ3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUI7jCzx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e11596b2e7so4256b3a.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 01:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707902494; x=1708507294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWjAw44NUAHjhZwj0P/plLcMvgNRDO6qzGUn18t+8Ss=;
        b=eUI7jCzxfUHtni6L7XK0xjgBOTFP3n+9mN2LD3s5Uj98zc57kWPZn823uOr0b4u9QR
         KXl6J+bLiNRosqSmzbRt8Uhu6NzaBuocqi7BBe9hhf39u/uo1zH/EnVk0B81WN461s8b
         my5o7TF54dAdaFzXoPLKHh0IedNdMqQfW8/XI9830sZkqcxCrvLmrqNbJs9Of9NWYTRf
         /XQvuM9Ql6mOArgNJx/AvaslVugO+gQ5bw3w6/iBhGg1Cky7zBvOv+uoRKRCz9Q4Mz9+
         FFjOyOHyArETvSGCwcnobUVFIsU7wxXPL4ueZwFMfDElXqsN79Z59Cugy6c/rt8FerLt
         GDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902494; x=1708507294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWjAw44NUAHjhZwj0P/plLcMvgNRDO6qzGUn18t+8Ss=;
        b=vnCickw5Xwf8xftvS2l8Xf0IeYP4Td51jYYxYHkmD/XSgBxgv48QDju0EfZvEIPm4O
         Z3iyYYFO9sPR125njfwfl4wke2aifxMjJ+WAWpj9G7/dGPup1meqZT1+zUzCT4oM0XS5
         VEgll0KCqfrNmmqj/xOWd1Dp4tYPv88PPV9xe6/ac/zFdhxI4nZDKwWIPdJzfr4O9bbn
         v2G4DEo1lyXglcObgSojT1LG6BmyBlnviu2AJMcb3UrW2kNjqvT/garGZPoZu4cn4x9y
         lglOaJRGuGDRNhZrqPmjUFZzXJrs3NKNiqbFd1I79XAPflRKEekInPwM2XZL1j69dECx
         63qg==
X-Gm-Message-State: AOJu0YzBjE9oitxIGe9Lg292MJz+DrAB5yHorWsb3fM1UkD8Ou52Ch9Q
	Lfj7sGDaVpNoNTvrMVVK9dc1b3e7dSvfjP80XW+MHnCbvw14YpJwPlUH45VShLAMVg==
X-Google-Smtp-Source: AGHT+IGZBH4a725MMUh2/pOnvZT9zn+Mdj3zgiEZyJFKOWIcNky/fokovIHcoxcp31m7vDBKLDbvzw==
X-Received: by 2002:a05:6a00:1803:b0:6e1:738:93cf with SMTP id y3-20020a056a00180300b006e1073893cfmr2163403pfa.30.1707902493678;
        Wed, 14 Feb 2024 01:21:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqtFUJ0cDbm7TKFo8uqNvUUuql7lvd+xr5XdQfhfpggcjX9QbY731KmOu2S7UjaIsYsrZ98YrVuGt4sAzYlW5opZpAQ+MDn198h5q4vSoLrlKJGeNCxadC4ocUkdpqxDga9CceqM/qdXsSV9VRyflvHlPjc9yTc6KWuqKY0v6R9gp9rPblU7KW1TsaQZYivzJsUiruISg/uWEB4z4Xzw3yLJ45EQ==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e27-20020a056a0000db00b006e04474ddc6sm8622994pfj.41.2024.02.14.01.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:21:33 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] selftests: bonding: make sure new active is not null
Date: Wed, 14 Feb 2024 17:21:28 +0800
Message-ID: <20240214092128.3041109-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of Jakub's tests[1] shows that there may be period all ports
are down and no active slave. This makes the new_active_slave null
and the test fails. Add a check to make sure the new active is not null.

 [  189.051966] br0: port 2(s1) entered disabled state
 [  189.317881] bond0: (slave eth1): link status definitely down, disabling slave
 [  189.318487] bond0: (slave eth2): making interface the new active one
 [  190.435430] br0: port 4(s2) entered disabled state
 [  190.773786] bond0: (slave eth0): link status definitely down, disabling slave
 [  190.774204] bond0: (slave eth2): link status definitely down, disabling slave
 [  190.774715] bond0: now running without any active interface!
 [  190.877760] bond0: (slave eth0): link status definitely up
 [  190.878098] bond0: (slave eth0): making interface the new active one
 [  190.878495] bond0: active interface up!
 [  191.802872] br0: port 4(s2) entered blocking state
 [  191.803157] br0: port 4(s2) entered forwarding state
 [  191.813756] bond0: (slave eth2): link status definitely up
 [  192.847095] br0: port 2(s1) entered blocking state
 [  192.847396] br0: port 2(s1) entered forwarding state
 [  192.853740] bond0: (slave eth1): link status definitely up
 # TEST: prio (active-backup ns_ip6_target primary_reselect 1)         [FAIL]
 # Current active slave is null but not eth0

[1] https://netdev-3.bots.linux.dev/vmksft-bonding/results/464481/1-bond-options-sh/stdout

Fixes: 45bf79bc56c4 ("selftests: bonding: reduce garp_test/arp_validate test time")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/drivers/net/bonding/bond_options.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index 6fd0cff3e1e9..644ea5769e81 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -50,13 +50,13 @@ active_slave_changed()
 	local old_active_slave=$1
 	local new_active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" \
 				".[].linkinfo.info_data.active_slave")
-	test "$old_active_slave" != "$new_active_slave"
+	[ "$new_active_slave" != "$old_active_slave" -a "$new_active_slave" != "null" ]
 }
 
 check_active_slave()
 {
 	local target_active_slave=$1
-	slowwait 2 active_slave_changed $active_slave
+	slowwait 5 active_slave_changed $active_slave
 	active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
 	test "$active_slave" = "$target_active_slave"
 	check_err $? "Current active slave is $active_slave but not $target_active_slave"
-- 
2.43.0


