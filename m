Return-Path: <netdev+bounces-64584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAE5835CBC
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 09:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3CB1C20996
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 08:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B630210F9;
	Mon, 22 Jan 2024 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="ed5v4r0X"
X-Original-To: netdev@vger.kernel.org
Received: from egress-ip12b.ess.de.barracuda.com (egress-ip12b.ess.de.barracuda.com [18.185.115.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65194364A0
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.185.115.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912520; cv=none; b=JOujxQcZu3OIUjdrYRWV7XU5pheHJz3wKnwL0bR0N1g6UxB6iPAaNzhXmdblBTN8Amv0xL+6L2514oDk9dISarofM2xdINeZazypnNnVd2OsBgPBIp2voNkh1nUKyUH7QrHiTOr0zRioUGCbqRYDO2Gxb2cocRVaGtP7Z1kKPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912520; c=relaxed/simple;
	bh=lGacBdisexfSrE+r5NS0I3w6U8FixtUsYI5Qb5UG0bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MQZLx15q0GTiVdMaLMupVrcWIjBJEZRp2jNysLeIeW3MgrtrGD7oQksuja8J0nO/+MXwLoFGMebHjJ68UcO65ucqONmMpSY2y2/SeWKZJmS8gORJiyRf3htc+DEpA9GHfkzDpiZRGwcTYoPNHwKJhMNcND29qiIJ8AflM5oMjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=ed5v4r0X; arc=none smtp.client-ip=18.185.115.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199]) by mx-outbound22-37.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 22 Jan 2024 08:34:30 +0000
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bd4b623e4aso6571732b6e.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 00:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1705912469; x=1706517269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Yf78X6NhNlvkenuax1KpRQIa4Bds6kUX+jC6ly706c=;
        b=ed5v4r0X4if3cbv2giYsGyeWZVIbeSNDP4sH6oCS8z6uVtaoVsDWyjRr8magLyQibO
         kUZyM9EPnk3gjtUpAjVVWPc+KcejU/ddrg8GbWSX0RqmwNaxz55AP0rZkD/7TZCwKNe9
         CWaj4x+hxQYvKDPnCimfvx6miLX04j/G6Ow0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912469; x=1706517269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Yf78X6NhNlvkenuax1KpRQIa4Bds6kUX+jC6ly706c=;
        b=KHW528GmC0Cy3+FqQJtJjSg+owxoStuOxMMa+2wUam9wZZimBBlqfxDaDw2nNRreF5
         a4T6osa423RxUBjr0IDWPG/eWM9Ww6kU8j0Flx3Yd8YhGUMSsdhZGpM+n/72xkmeMyJq
         +YV1a+PveOkhZV1xh1FKIujbCpkdIo8aTRv3tbu3fn6TxFVTvnLWb02GsdTj6lplHwAW
         pbpfFY2EffhrUj+jw96xdNcTSLeTH9LPvqJnEwUnob6n8MhKOLo3/PN5ESYpOFbTGwgG
         cTeiSZT4IQNfGHars8ySFCwbbV2Y1fvUwLgQutb0ztfO17AzncwNdBppVND0u/Vq36vK
         7hnA==
X-Gm-Message-State: AOJu0YwuMYmBPqttYV08FZlyyUDTedvePXAz03+BVtjEXC6Dg4mmmyJW
	aiaSZ+kXOZuprXT8lLl8lHti3SzH4eB1RpzVDKr71lAW4ExOAzUlXsQhosETWrjr1UZS2/Y1HQd
	b6BLrKgsYyJUXPT9/gauRwLAUquYM3LwRMy0/Ry9jruJP6kFkJzH95xtZMUWOA6qWjs3isrPbI8
	t0DcU7lf2huj7D
X-Received: by 2002:a05:6870:8304:b0:210:9d93:983 with SMTP id p4-20020a056870830400b002109d930983mr4641471oae.23.1705912469396;
        Mon, 22 Jan 2024 00:34:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAA3QDz3RS9Vh4eKdi3ce+9gKoRGw4TMA270vltqSaTUT2Mdt3C+JNU058g+sLA/b8ansIKA==
X-Received: by 2002:a05:6870:8304:b0:210:9d93:983 with SMTP id p4-20020a056870830400b002109d930983mr4641464oae.23.1705912469132;
        Mon, 22 Jan 2024 00:34:29 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id cm7-20020a056a020a0700b005b7dd356f75sm6895023pgb.32.2024.01.22.00.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:34:28 -0800 (PST)
From: Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3] net: ethernet: ti: cpsw_new: enable mac_managed_pm to fix mdio
Date: Mon, 22 Jan 2024 14:04:14 +0530
Message-Id: <20240122083414.6246-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1705912469-305669-12556-1111-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 209.85.167.199
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyMjKyALIygIIWRiaWluYmRi
	Ym5mYWBhYWyYlpRsmpqYlmSQYGSYmpyUq1sQBnvoa+QQAAAA==
X-BESS-BRTS-Status:1

From: Sinthu Raja <sinthu.raja@ti.com>

The below commit  introduced a WARN when phy state is not in the states:
PHY_HALTED, PHY_READY and PHY_UP.
commit 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")

When cpsw_new resumes, there have port in PHY_NOLINK state, so the below
warning comes out. Set mac_managed_pm be true to tell mdio that the phy
resume/suspend is managed by the mac, to fix the following warning:

WARNING: CPU: 0 PID: 965 at drivers/net/phy/phy_device.c:326 mdio_bus_phy_resume+0x140/0x144
CPU: 0 PID: 965 Comm: sh Tainted: G           O       6.1.46-g247b2535b2 #1
Hardware name: Generic AM33XX (Flattened Device Tree)
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x24/0x2c
 dump_stack_lvl from __warn+0x84/0x15c
 __warn from warn_slowpath_fmt+0x1a8/0x1c8
 warn_slowpath_fmt from mdio_bus_phy_resume+0x140/0x144
 mdio_bus_phy_resume from dpm_run_callback+0x3c/0x140
 dpm_run_callback from device_resume+0xb8/0x2b8
 device_resume from dpm_resume+0x144/0x314
 dpm_resume from dpm_resume_end+0x14/0x20
 dpm_resume_end from suspend_devices_and_enter+0xd0/0x924
 suspend_devices_and_enter from pm_suspend+0x2e0/0x33c
 pm_suspend from state_store+0x74/0xd0
 state_store from kernfs_fop_write_iter+0x104/0x1ec
 kernfs_fop_write_iter from vfs_write+0x1b8/0x358
 vfs_write from ksys_write+0x78/0xf8
 ksys_write from ret_fast_syscall+0x0/0x54
Exception stack(0xe094dfa8 to 0xe094dff0)
dfa0:                   00000004 005c3fb8 00000001 005c3fb8 00000004 00000001
dfc0: 00000004 005c3fb8 b6f6bba0 00000004 00000004 0059edb8 00000000 00000000
dfe0: 00000004 bed918f0 b6f09bd3 b6e89a66

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 drivers/net/ethernet/ti/cpsw_new.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 498c50c6d1a7..087dcb67505a 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -773,6 +773,9 @@ static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 			slave->slave_num);
 		return;
 	}
+
+	phy->mac_managed_pm = true;
+
 	slave->phy = phy;
 
 	phy_attached_info(slave->phy);
-- 
2.36.1


