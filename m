Return-Path: <netdev+bounces-64965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3FF838868
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 08:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7DBB20E02
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B2E5646A;
	Tue, 23 Jan 2024 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP433jtX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05255C2B
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996767; cv=none; b=BIRv6D0n1LW1LJFV/Aa0CHio91BjZVN0yECur0oI5ZNOvBpVVHyvxy2VbQBUw9PTsY7K8Fl/I5wXrQxT0IMXfOyC1pTYscbv3uSen6cKKo+238B2FIfu5/pU51zCrNFy31d0G3whm/RAD0WcxPyKBcbUp5d0xEeSKpQA/pTl6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996767; c=relaxed/simple;
	bh=bleoSiQ4BR7vrLsbl4t2wu+UvvqvVLMyipfdF/khNMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPCuo5BGmcWPeVl0BCD/geey7rH5QNXH0+ujNa1ZV64wZwqSXhrKsMZ2il8g0nNB12K/p+R45Fux1lIw2K7IJgwjkq53qPDsxiZ6QeImAZ/oC8mzIKi0AoarBN+bMONUQ/qgJnnta9vgSqkSNOdyiuKLERpe5GJVWyg6xv+AX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP433jtX; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bd932a0cafso2593705b6e.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 23:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705996764; x=1706601564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3iSPcnATT2PbHUelo74Nd+NAicpTOT2YtFBYZ2iKPCs=;
        b=RP433jtXS/X32e4MrmyF8I5zWTYr9U3K+3IohQLIf6Pj6xYHzcfIgkIKrp//AE/7Ew
         HBrDAbWE7E7mDqYC0w4CD1LkLvCmwDja7OGVKKaZ7uIkGl2xreEYwX4OMkQXKrftzDXB
         Tmsgly2Rpug+FiE8jGan3aLokwyccblPTYzSB7NKlQhQnfXk8oZrsJ+gSYyMJZ5ftkOb
         zxh9vhcKRWzBAMJS4Zwwb1rwDdxKNMYOlmQzfIq5BV77M38IYcUP+6EjrLwm4J1GIUZI
         +Leo6ud2ETJk0KT3Twv76heVJGJwqSXfP/OeLD0cg5hUGsbyK8LnkbSNflWtFkgyLndp
         SwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705996764; x=1706601564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iSPcnATT2PbHUelo74Nd+NAicpTOT2YtFBYZ2iKPCs=;
        b=lvAszXDiFbtyNCYMre9O5DFX5kv8oQWA38oInPdzP92KKrCbvxeVWZxDD8wN3CTsbS
         7bS3G6+Uvs/0EOcukBxrlbq/SdAitJl7CZbGX4Nf/KiAW6FUBl5e9LHwMMZGC0VLMssP
         J96sTKfwB/4ehH7i+PSfq6d3i4PPdmLuDNozorPzRvU0NVNDzTxxwmuietBhKP5+3doz
         EJ/C6ItsQ4erdlNcTNha399G9/TT3MXO0HEc03Z+cbm5rIt3rBtdFv3xu7/cfat0Xl8Z
         8TbsmQ5twDd4w2ID7hu8ILxzpagAEEtQc2HqhGQT1yzxb74ImnTz98pppcUtuoQ+kNgk
         vclQ==
X-Gm-Message-State: AOJu0YyjRtrJvOXuUtDiiMHUkGaxMVZI1rJK9tYH7R+lA64V4aCJvrZ0
	PzNypOg7u8bF+s3USL0tp4rduRVbW+RkhFmB7zaM9JV3xRM8Jm8jcHx0JMq7gTvmLg==
X-Google-Smtp-Source: AGHT+IGzx2REsqTLNm9n5s4KJN6Namw1loUF1WmLabHZFLNhWBO+lsYhW19PURDbVNdvgkLfjXSs3w==
X-Received: by 2002:a05:6808:118b:b0:3bd:587c:5b6 with SMTP id j11-20020a056808118b00b003bd587c05b6mr4436783oil.61.1705996764061;
        Mon, 22 Jan 2024 23:59:24 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00008400b006dabe67bb85sm10880708pfj.216.2024.01.22.23.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 23:59:23 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jay Vosburgh <jay.vosburgh@canonical.com>
Subject: [PATCH net] selftests: bonding: do not test arp/ns target with mode balance-alb/tlb
Date: Tue, 23 Jan 2024 15:59:17 +0800
Message-ID: <20240123075917.1576360-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prio_arp/ns tests hard code the mode to active-backup. At the same
time, The balance-alb/tlb modes do not support arp/ns target. So remove
the prio_arp/ns tests from the loop and only test active-backup mode.

Fixes: 481b56e0391e ("selftests: bonding: re-format bond option tests")
Reported-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Closes: https://lore.kernel.org/netdev/17415.1705965957@famine/
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../testing/selftests/drivers/net/bonding/bond_options.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index c54d1697f439..d508486cc0bd 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -162,7 +162,7 @@ prio_arp()
 	local mode=$1
 
 	for primary_reselect in 0 1 2; do
-		prio_test "mode active-backup arp_interval 100 arp_ip_target ${g_ip4} primary eth1 primary_reselect $primary_reselect"
+		prio_test "mode $mode arp_interval 100 arp_ip_target ${g_ip4} primary eth1 primary_reselect $primary_reselect"
 		log_test "prio" "$mode arp_ip_target primary_reselect $primary_reselect"
 	done
 }
@@ -178,7 +178,7 @@ prio_ns()
 	fi
 
 	for primary_reselect in 0 1 2; do
-		prio_test "mode active-backup arp_interval 100 ns_ip6_target ${g_ip6} primary eth1 primary_reselect $primary_reselect"
+		prio_test "mode $mode arp_interval 100 ns_ip6_target ${g_ip6} primary eth1 primary_reselect $primary_reselect"
 		log_test "prio" "$mode ns_ip6_target primary_reselect $primary_reselect"
 	done
 }
@@ -194,9 +194,9 @@ prio()
 
 	for mode in $modes; do
 		prio_miimon $mode
-		prio_arp $mode
-		prio_ns $mode
 	done
+	prio_arp "active-backup"
+	prio_ns "active-backup"
 }
 
 arp_validate_test()
-- 
2.43.0


