Return-Path: <netdev+bounces-178527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30641A77734
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654E63A80E8
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF751EBFE0;
	Tue,  1 Apr 2025 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVwlp5Q2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A51EB184;
	Tue,  1 Apr 2025 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498403; cv=none; b=IvC3EnsRgFprDabgUgP2MdgxLTNqBzs29/ARFvERYZgm6a9FU5THxEP0bTB5pk66Kj6IIaLZ6qDa79LO7VAvHEWDQXZoXFBb9sOJlMwVQIgu/Ffgsk14jlCSrm/TNXo/s6wJOAwenADSekhKXc8C4RJz/Kv02FWfj65rt7eWHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498403; c=relaxed/simple;
	bh=bBVMwoBL8LR8zOwYGi5TeDtaPBOUxSmU0D75RDFB+V4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MJImIZjaZM83/yyTizPZUuGClO3CUVP4YOO2BYbs6OV2S4tMl+Hxbj2m6mzUM3xa/1HH5KwpJ9h7RcxsqivwwJRqHaceLK4Q3rkjkEKO9AP7564ITdHWFRAx4cMpqWKV+fFq2s1I+dt7CYEz38OWeonnx1YwmJUCzNavI5Owq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVwlp5Q2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227cf12df27so74929875ad.0;
        Tue, 01 Apr 2025 02:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743498401; x=1744103201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lZeibnPf6F/j2ao9xre27sq9y+syyRAsUdBCPrAKj20=;
        b=NVwlp5Q22qhtVgAgEZAfoGpcYNEeReK0Xk/CTEORkV67rS1r61/Xh8pUrh3yDPPvNp
         JeTRLLe9lM7sBLzSPW+llZ1DJtLnAN9OvSFFXEd2q6HtKrOwLlBAsEV0ss90fmgfhCfG
         Q6Tp2H+mSFoiY1/h83lWLGM7RMdRwlJH+JtxglruSqCaqMG2DZF9/40CHhOKtAMtw4SA
         PjmimfdPj27V3iODODFcG4X28/lZEwuyt1m6W8QvQ/rXMe//v7kDuhIzhm0/uVMWjivg
         ou5R5cNFnJwy5FoBCbj/r5ft36hpNcLvHkHnwvpE789jhnS6gA4NTXJPs0nZ2rrFg7e6
         4waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743498401; x=1744103201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZeibnPf6F/j2ao9xre27sq9y+syyRAsUdBCPrAKj20=;
        b=AKmP61SnhwckoP5Z3C43NhTCH9GSZRABNaVqBOqrc/SkV1UVFA0tAr1l0s4ZHya0X2
         4W56qOCpQ+WkFelSPf0/CCPShk6nAslqWdWptcyZxPhhtLCFeWk5Shhcir58bCJNbcRL
         j7rrYSY8Qyjg5CpUiR7t+81MNJn6CDZ386WJdusZeaky6Vuk9iDET7Tnmz2tkpnEv5Y3
         53n5q6L4vMHlCDQe42BiK/a+DnvmF46gsCT39rCzDGAQQ+fx9LXuP8w2fDG7TDolGlM9
         er6RU13GRwoVbpgHmMcr8/YuGK2hBSBWagD7nFvIJ0OBNSkYvmPCAZBgO/9Ow0ou9V29
         J9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWUmMf3OKYc/MI+Cy5Fne6/MXUJ5mhy8qkaFwQYfSBPXEcyS6SYXB0y48qS4ZiF19QBrjixU50xQCiNM4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxluH4BftDIcy10yZ+mgmZoFA8Bf//BJqKlTaW75ymjFovN/VqE
	sC0G14fp5zmG1UnQV/2poKqiRNrzg8zp/+y7Q4sjC4QeVarmRq40hewq+KEI8is=
X-Gm-Gg: ASbGncvpHlYy/E5E3Ljd0jkygWubxdvavRVNgHHRi4UzQEMpfCEkNq4vRxzZR7LSIh1
	2QF49h3PBHu7SCTFilzGrUW9Q3YMs4TYc0RLw1HA8paOW61rhfwsYS/uqny4YP29rgEh8ujHcN5
	NPkcEhCNsyt1Gd/X2zV9rzKJeZZFXutaD7RJUnC8g7vE68npyq/yrvbo+b6j0sDanpGuPtADs/2
	ure/0kBRMEvtwFbi2H9Bdy7iHKwIrLAtcgSewOd66xxqjs8FOiJ71azhWZHJLDe13AYGx6GJ4xQ
	oEAt1etN6UO2redPitwsd1Wj99SSUur0MU6CuTWjhuTPtcsG1f3SkdMztnauNIoamh36x4zKDyQ
	=
X-Google-Smtp-Source: AGHT+IG0bnk3kuG045+To5X7Apkw1uxbIVmYAPpm8jfEhLoa/xUxQ6HYwKkOQY476h55fgBRW3mzWg==
X-Received: by 2002:a17:902:f545:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-2292ec073d0mr205536655ad.2.1743498401286;
        Tue, 01 Apr 2025 02:06:41 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f7cc2sm82791875ad.258.2025.04.01.02.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 02:06:40 -0700 (PDT)
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
	Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net] bonding: use permanent address for MAC swapping if device address is same
Date: Tue,  1 Apr 2025 09:06:31 +0000
Message-ID: <20250401090631.8103-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Similar with a951bc1e6ba5 ("bonding: correct the MAC address for "follow"
fail_over_mac policy"). The fail_over_mac follow mode requires the formerly
active slave to swap MAC addresses with the newly active slave during
failover. However, the slave's MAC address can be same under certain
conditions:

1) ip link set eth0 master bond0
   bond0 adopts eth0's MAC address (MAC0).

1) ip link set eth1 master bond0
   eth1 is added as a backup with its own MAC (MAC1).

3) ip link set eth0 nomaster
   eth0 is released and restores its MAC (MAC0).
   eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.

4) ip link set eth0 master bond0
   eth0 is re-added to bond0, but both eth0 and eth1 now have MAC0,
   breaking the follow policy.

To resolve this issue, we need to swap the new active slave’s permanent
MAC address with the old one. The new active slave then uses the old
dev_addr, ensuring that it matches the bond address. After the fix:

5) ip link set bond0 type bond active_slave eth0
   dev_addr is the same, swap old active eth1's MAC (MAC0) with eth0.
   Swap new active eth0's permanent MAC (MAC0) to eth1.
   MAC addresses remain unchanged.

6) ip link set bond0 type bond active_slave eth1
   dev_addr is the same, swap the old active eth0's MAC (MAC0) with eth1.
   Swap new active eth1's permanent MAC (MAC1) to eth0.
   The MAC addresses are now correctly differentiated.

Fixes: 3915c1e8634a ("bonding: Add "follow" option to fail_over_mac")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: use memcmp directly instead of adding a redundant helper (Jakub Kicinski)
---
 drivers/net/bonding/bond_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e45bba240cbc..1e343d8fafa0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1107,8 +1107,13 @@ static void bond_do_fail_over_mac(struct bonding *bond,
 			old_active = bond_get_old_active(bond, new_active);
 
 		if (old_active) {
-			bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
-					  new_active->dev->addr_len);
+			if (memcmp(old_active->dev->dev_addr, new_active->dev->dev_addr,
+				   new_active->dev->addr_len) == 0)
+				bond_hw_addr_copy(tmp_mac, new_active->perm_hwaddr,
+						  new_active->dev->addr_len);
+			else
+				bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
+						  new_active->dev->addr_len);
 			bond_hw_addr_copy(ss.__data,
 					  old_active->dev->dev_addr,
 					  old_active->dev->addr_len);
-- 
2.46.0


