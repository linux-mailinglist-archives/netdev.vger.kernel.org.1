Return-Path: <netdev+bounces-180897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B16A82DB4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF227A4D9A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CCD26B2C6;
	Wed,  9 Apr 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DArRUdfd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06B1A5BA4
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220034; cv=none; b=C/Vr6MM+CV3SQlUXxikBLDT8pOyu1S/7PMsSqNVZEgJ0/PTUjmZCEATIlvRhGUKUbn4A8ZDjUYH/2l99Kx3HdsNcRl1+hm6KRaYksB3d1c1Kd1jH1CXRO4TpDEz4euamyL07DlbhH5idI80YrVp6ZVeHfDRGKcbA+V1uzSbS1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220034; c=relaxed/simple;
	bh=z6VQUBBP1fSpFE7Lw9r+t6q3oreYiLb0Nx69Y6p2ESg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWjF9St0QGpyjp4Xvcxfrk3ovCq9tu293IpPGjDE7GEq14KB9nF6dkYtHQuYZvc19APquX2sU2qEzFBZGPPBBKVn3ft+Bt6alaI7vltC9Jw9n3fivvqA0TkjLEIFQi5y5kKe4pj8LFyfhUDcmp7rW1v/ricfZloJDERcAQ3QRLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DArRUdfd; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c16e658f4so3017920a34.1
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744220031; x=1744824831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uv69cxRGor2bDkLo3fYRasV5FyJDZDrf3LHa2aVLgpU=;
        b=DArRUdfdDC0BVgn0RxlNvv9veJsSbl69O4GOBDU+h+aAzHrLQz0UKHO39jNNU5FDfo
         9qg9FlyEcjgjBgtrLY3GvGOlvqOmlEuuwQvTI34AKG6vscQIknoCys1EjhsnwOzY0vb2
         kOd5QT4WScIQmaATgEtnjfIyJVCb00Acmktnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744220031; x=1744824831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uv69cxRGor2bDkLo3fYRasV5FyJDZDrf3LHa2aVLgpU=;
        b=DY3gm5Xs+H4jqX1f6REx1ap+cP7ZSWPSao9tBuhot9ZPp2T5NEnRzsB9xWOIiJNTPi
         3XBxrKcIicAbMMQ+EEJLI7iGjeP3uKqCjcTOJdH9N/PtI1/RsaODMYNgOZCqrWWjI/QK
         RNBaWOXFg0F64iHg3sZvq0ABCHWk+oPcfiu3Qw36kNPQ5iiK49bmmOwgbG8mOwaxIDdU
         /N2Cg2kpatOM8+J10irleJ4fJMYBt1FtNx49QJOSCTqHnb364ygNpS1PPTWNOjrPQspZ
         HZ2dtmyn967KyFTRbPsXCjYgAeBd4BtCdHpisDi1V5uYV4IK2dhdOTZ+Ch5M884C0dIO
         QifQ==
X-Gm-Message-State: AOJu0YyhiW34NzSPCZnq6J9PRmLhG3Dxp264laR4pOeCXTNluJTQWElH
	0vCQ7w/4mMO6EF5BQfD33e8ESkY9wGLUadBMOPs5AobMoGsO/6qMhPtUvtXLfA==
X-Gm-Gg: ASbGncux6IxKO46ABUsQ5I4kjYToyD/V036fhT6W0Xr88TDEBIr1Q5r6NmJ/uPA3cGo
	DmEF53tAKLD4QquNl1xPo8/KGkktz5zRqKCGQ14X7DvGqZu0zpU1TnuBuVO1EFi0+Xk5osnVK4Q
	ONHtYbneyZCHE0fJ2Q+IWrxSkneIhihmeuGofBkC8xMqHLkkIc0KbPPCgE1XbAsy3g19CTIJT7Q
	jC6vNrsojeZEsHSgQi/zGQUyNOJpkxSqsKj4q8h4lJy1B/+ENHBcuBQlMNaf+YL2icq6Wl4NcIE
	NmuuhiOnkHyxwZWTu9rc8AvmvydjO706NKbl19x174J6J/9nW00/3oAADkK0ub1hWyf6bD5pZqb
	d9r62Pz8M2+bQCo2jvN5Fl6DAL1A=
X-Google-Smtp-Source: AGHT+IEAdzVjGtVUA1yTexZrO5mtUrUd5lnWXpfV+9USVw8jZQJVLJHDtYV8IGcX2xXv4EBTU7pD/w==
X-Received: by 2002:a05:6808:10c5:b0:3fc:105c:430 with SMTP id 5614622812f47-40073743a5fmr2191803b6e.39.1744220030301;
        Wed, 09 Apr 2025 10:33:50 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4007639c9d5sm236707b6e.39.2025.04.09.10.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 10:33:49 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	horms@kernel.org,
	danieller@nvidia.com,
	damodharam.ammepalli@broadcom.com,
	andrew.gospodarek@broadcom.com,
	idosch@nvidia.com
Subject: [PATCH net v2] ethtool: cmis_cdb: use correct rpl size in ethtool_cmis_module_poll()
Date: Wed,  9 Apr 2025 10:33:12 -0700
Message-ID: <20250409173312.733012-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>

rpl is passed as a pointer to ethtool_cmis_module_poll(), so the correct
size of rpl is sizeof(*rpl) which should be just 1 byte.  Using the
pointer size instead can cause stack corruption:

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ethtool_cmis_wait_for_cond+0xf4/0x100
CPU: 72 UID: 0 PID: 4440 Comm: kworker/72:2 Kdump: loaded Tainted: G           OE      6.11.0 #24
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: Dell Inc. PowerEdge R760/04GWWM, BIOS 1.6.6 09/20/2023
Workqueue: events module_flash_fw_work
Call Trace:
 <TASK>
 panic+0x339/0x360
 ? ethtool_cmis_wait_for_cond+0xf4/0x100
 ? __pfx_status_success+0x10/0x10
 ? __pfx_status_fail+0x10/0x10
 __stack_chk_fail+0x10/0x10
 ethtool_cmis_wait_for_cond+0xf4/0x100
 ethtool_cmis_cdb_execute_cmd+0x1fc/0x330
 ? __pfx_status_fail+0x10/0x10
 cmis_cdb_module_features_get+0x6d/0xd0
 ethtool_cmis_cdb_init+0x8a/0xd0
 ethtool_cmis_fw_update+0x46/0x1d0
 module_flash_fw_work+0x17/0xa0
 process_one_work+0x179/0x390
 worker_thread+0x239/0x340
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xcc/0x100
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2d/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2:
Dropped patch #2
Fixed the Fixes tag

v1: https://lore.kernel.org/netdev/20250402183123.321036-1-michael.chan@broadcom.com/
---
 net/ethtool/cmis_cdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index d159dc121bde..dba3aa909a95 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -363,7 +363,7 @@ ethtool_cmis_module_poll(struct net_device *dev,
 	struct netlink_ext_ack extack = {};
 	int err;
 
-	ethtool_cmis_page_init(&page_data, 0, offset, sizeof(rpl));
+	ethtool_cmis_page_init(&page_data, 0, offset, sizeof(*rpl));
 	page_data.data = (u8 *)rpl;
 
 	err = ops->get_module_eeprom_by_page(dev, &page_data, &extack);
-- 
2.30.1


