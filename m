Return-Path: <netdev+bounces-156158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27058A052AC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B261661D6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 05:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9191A0BED;
	Wed,  8 Jan 2025 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiN0zzd0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DED15853B;
	Wed,  8 Jan 2025 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314581; cv=none; b=Qrozy80bkNlD+ClkuTwpz8Z/KE9OuDgZRx1l5j83TBH6gktOdR5EoxPWRezXiN1kD/dM/udIk/YFBJhV+FEM5fLyT3PV9a5aKGxWKdILNU4wiEDXQMDDzvDsR6RC2TS6gLKi8Cd/urTEW97mU82AElaW7SPCpB5wKqnl2mSOncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314581; c=relaxed/simple;
	bh=JkvafJrvOtEgqdOlmc6PJP7xFwLx8/+pR/FrSkSHxOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ejRl6T33nfha8e69VrVbWuh8QedF1tXxsLayfDLd+MLW5HrwiwBBdXENNZzz9ng7mbSTSSV1wIPvrt5kUBgOrMl76KXTemuzjU9ps0Lj+FaEa+U0JsFsHvkQA7CQIrq5E3IRr5zGDwEfbadu53derSRoQ+4fKTmTNflGUux3uZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiN0zzd0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so766675a91.0;
        Tue, 07 Jan 2025 21:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736314578; x=1736919378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QwB6PKWL4fpLwQMxIbGdx/81PcCRgJBA26Iv4G5hiqo=;
        b=YiN0zzd0Puc0s1UCE1nVzx4tABazpv972EzlBAtT5plbx8/wQfHJnep5qeEtaqssnD
         3BMSsixn8IZCaZXaeh3mZj6F5XLjjZ+QbPtk1gXlvlYoxcT9Fbd5q9U/iO9Oujjnd2iX
         lAgpmRysdLvJxTEHVlykq1I5kbOfFg00VWa4jNAGgB9OzW8PFBzTtH5Wie7ytJEq5Ff/
         QeCJ3GksXt62z5lSLF9jwnGGCuz1opM/JqNFZO8O/YaEtfMLkyDQqHUBNaSZnOheQPF+
         lyIw3UWuwEVO467J0Wi3tq6sGRfiSs38MK3KROERuycivRNKyh1R+Ki/tJNRl8fILPfB
         F7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736314578; x=1736919378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwB6PKWL4fpLwQMxIbGdx/81PcCRgJBA26Iv4G5hiqo=;
        b=Otk9ShXtOkodx4UwkaQErjzCBemwdzRq9tm1140x+Hz8miwwRN3T7XYK3eDCtSZg/G
         zmxhvfY/Ee3Vc7dKwV4dZANHKFDIXZEs9wiFzEy29+OZSc2AvAGG2lxM5O//hHcYT8sc
         cD9i+YgaqUotihAavEYdop1Z1bNMfrZd+61H4R3v4Q1SKJ/I9a8VDN3+/2R7QZMf6+1V
         eIXo4dmVWPP6lKQF2n2wrFO+ya8jHrmMHVwqmL69HAtJ/80OR+QeVGujn29yzAA/xp/J
         6Ee5WLQG5hS7bC2It2r3WO3r1+kMewxbpBmf69y9oCUkxvIeEkflOHwU+eFxlalUkuXx
         +3HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgu7lVayK1drc4HLT6o34EdzzdiKAWvg9TgLQgLnp/Nz7ld6nyoq6VlhXgwp3Az6ff8gE2jwdP@vger.kernel.org, AJvYcCX5OFEm8Kf+fvaUkU3J3NYzClbRc7gybAX3iEo/uLPNzjzbXabhRIYF+BODsSnxisVOoOUBRJkchPkjsOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPLmo0PIlrZCU2k9x1juF3yw0Qo7UFvoK2JQ5YpYjtA8R9DmKl
	rEWT/3IbIAfhZAbme27KXK9PRMro1+wnh0Fj+782FvyVTpiIAp4E
X-Gm-Gg: ASbGncuNEMSMwOr8zUHhBdX0cm4mOjJp2kQk+tYWTXgWjYNyJ//qmb5E73Yysq8Vfi9
	jlQvK2uhfnKcvGFhpvw5tWTT1x1lXgavzsaEmZJdUa/ot0lyO66jcUeXwE5tYMikkkzEb0d/Uu8
	1nBxmi+Wn6Cs3yc1Fnyqd3hcIOFzws0g/W3JbXGHh5GKvAL4iAZF9YD6+wYnq+2bSV8ywvirl7J
	u6r44zVFI1mUgSV1MeXWLvb/UaJ2ZFffNM1heiLzyzfayNx23Yr/Mq07J+j
X-Google-Smtp-Source: AGHT+IFQNLflTaSaTva4SqpeHAD8GetNltm43gjW14adKs7m5QAStWdcGn40w/j/MPJdp38ED9KrRQ==
X-Received: by 2002:a17:90b:1f85:b0:2ee:cbd0:4910 with SMTP id 98e67ed59e1d1-2f548594570mr2814359a91.1.1736314578470;
        Tue, 07 Jan 2025 21:36:18 -0800 (PST)
Received: from HOME-PC ([223.185.133.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2e514asm510668a91.43.2025.01.07.21.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 21:36:18 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH net-next] ixgbe: Remove redundant self-assignments in ACI command execution
Date: Wed,  8 Jan 2025 11:06:14 +0530
Message-Id: <20250108053614.53924-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant statements in ixgbe_aci_send_cmd_execute() where
raw_desc[i] is assigned to itself. These self-assignments have no
effect and can be safely removed.

Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602757
Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 683c668672d6..408c0874cdc2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -145,7 +145,6 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if ((hicr & IXGBE_PF_HICR_SV)) {
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
-			raw_desc[i] = raw_desc[i];
 		}
 	}
 
@@ -153,7 +152,6 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
-			raw_desc[i] = raw_desc[i];
 		}
 	}
 
-- 
2.34.1


