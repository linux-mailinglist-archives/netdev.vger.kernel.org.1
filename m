Return-Path: <netdev+bounces-167639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F9FA3B2D8
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 08:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDD03AD060
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63F1C173F;
	Wed, 19 Feb 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLyRVCgm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3BB1A8F7F;
	Wed, 19 Feb 2025 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951729; cv=none; b=tgOBY1si+Ia59zWZjbVyeLhtgXt4qQEZXspTV3hCe4EcFx/pc8CADIeMmjSkMXqfe2vF3AOqiVM5hXj+DhHVe1sMe6YteNGiEKnFwf7wOTQs0NcZXpY3E8HRBrmIO3t74811mftcAg7FzXJutLfUblN2MMJRHWjpRT/gyCG+wnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951729; c=relaxed/simple;
	bh=0T91u26FuvHz9I5q8l105S0ZpkjMvtoe9M6NGv137uE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GjAZOfamGMexVQQSpUrwehwjKR1hFyrwGTm1VeIPMLknva9vwYGoaBET5LPiUkZURL/wASusSyQANM/NCV22hdgiJ4Fv6/0uJcPqRSwsAyOPOBnNevNQ7ziBtYXHmnMjSPWfcdsEg103SITbU8hz0gTBXN8DvVC0g2TfQHAI/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLyRVCgm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so9716937a91.3;
        Tue, 18 Feb 2025 23:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739951727; x=1740556527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWtcjl0x86FhVNmHfSGOr/xtEH1Fj+zWBHjBvIxj7Hg=;
        b=YLyRVCgmMAlUrX8Tnel7t19bWZa24c+IH0Clhrbh7hucSSzT9RhNpchFEV/jTBIMoI
         gCrwbvtwmjN3LO+sAxcZlBkA1/caC8hwPj6o0B6OUs746FbbQFACesmjPW8oFw/2XO3R
         CYeKjXp8b66inTEk4BdtWbMVQZA5PT5X6z1HYvVUSv3tdkqm/EGffdADh43yMYblFnTY
         AgNdQsKvGrL8anD+JjaPXd9aqMrIlqgqm3t32g8O4iKSznPhQE44CWL/k9qKOTwWSoZL
         VZcU0/MHWDqibQKj81Q0HQnvaCsPzgGC/xuo9aViJb+OazT7JsCBhd5+KUq4n0regqI2
         00aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739951727; x=1740556527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWtcjl0x86FhVNmHfSGOr/xtEH1Fj+zWBHjBvIxj7Hg=;
        b=JV4WFKYihrKRM6VVdfM7+5fSb3WA+I7XL9fIav2GvHOaWywiZLexqUaFZTJTtgU6cN
         dUdMt4EX5RVX64L22gdOgk+TsFlHje+Fr/K81vk+xEWqINYfDdSBiWwlyJFVRHRSf8ni
         zZMjlCXwGk+6t54+vR9SwCpYepWMDmfXgSyxNw4Lne8gRFjZ5Guk2tCR38y0KKYguXK6
         mf8k5yq+Z4iloYjB0mJkOPYn+Q7YPz95CshniN2tHR/zxcfJ12812uj3slaY/Z02nfg7
         2l9OG9+rM1psBEIuoJkYQXZ8lD+9kvfhgZyWcReHTy5N1EfAK32sHJeFw1ke9lB8tvdv
         XBIA==
X-Forwarded-Encrypted: i=1; AJvYcCUtuLe1MTr3B2Yhf+EFTbihbGz6KKIKCStG2ImmrxkjSM9VRo1tvi+UrhQcW0HNtMClsJAdoAdlsa3r5Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkqfgoGmEgGfNGuxjMueheP8FMJq37NF62XZeAfm97dsI0hOis
	L919UJ7+ZKkH+I7zMvIGQaSkVq5DoDe8c0qSE5JoXe3OvCMmc8bkdFaDJr6D7h7MiQ==
X-Gm-Gg: ASbGncszAylYW391s6xuR1mq6PbLHyw49Tm/qVykUJ0xDhUIkdxwlgOSINyMXDUZDBW
	mG+74l80TOJp8oE3CWqviK23QY1qaaTA2hoVRZe+jAPNXBTYdfYlFsdmAMebKi9KwCETVmJxjXB
	wFWlwmllhiNDCkM0yaXX0wJy+7AlCP6C0UmXXF3Zz0/IaAKia2vDZDy4pUuIJFcwQQBWSdwjEG4
	J+b7IDmDjW35rMR0b4viyEFL5+nnhj9+s1eSSTSzNI2fi0WDlDHVtmWnKDeSvHzEgta3chU0dWN
	xrh+uOp7E2/Kb+Yjp0QZa+wpK0AyB+eWSTk=
X-Google-Smtp-Source: AGHT+IEHDd0Hegcc3TcxsJEEA+nOXyQiiRkURBPST7ApOlpPE5UvOh63CmM6PJnhrps9MHJA7+WS8w==
X-Received: by 2002:a05:6a00:a15:b0:724:bf30:147d with SMTP id d2e1a72fcca58-732617c1105mr24832053b3a.11.1739951726662;
        Tue, 18 Feb 2025 23:55:26 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73287ed12e8sm4059355b3a.180.2025.02.18.23.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:55:26 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] bonding: report duplicate MAC address in all situations
Date: Wed, 19 Feb 2025 07:55:15 +0000
Message-ID: <20250219075515.1505887-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Normally, a bond uses the MAC address of the first added slave as the
bond’s MAC address. And the bond will set active slave’s MAC address to
bond’s address if fail_over_mac is set to none (0) or follow (2).

When the first slave is removed, the bond will still use the removed
slave’s MAC address, which can lead to a duplicate MAC address and
potentially cause issues with the switch. To avoid confusion, let's warn
the user in all situations, including when fail_over_mac is set to 2 or
in active-backup mode.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e45bba240cbc..ca66107776cc 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2551,13 +2551,11 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
 
-	if (!all && (!bond->params.fail_over_mac ||
-		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
-		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
-		    bond_has_slaves(bond))
-			slave_warn(bond_dev, slave_dev, "the permanent HWaddr of slave - %pM - is still in use by bond - set the HWaddr of slave to a different address to avoid conflicts\n",
-				   slave->perm_hwaddr);
-	}
+	if (!all &&
+	    ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
+	    bond_has_slaves(bond))
+		slave_warn(bond_dev, slave_dev, "the permanent HWaddr of slave - %pM - is still in use by bond - set the HWaddr of slave to a different address to avoid conflicts\n",
+			   slave->perm_hwaddr);
 
 	if (rtnl_dereference(bond->primary_slave) == slave)
 		RCU_INIT_POINTER(bond->primary_slave, NULL);
-- 
2.39.5 (Apple Git-154)


