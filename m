Return-Path: <netdev+bounces-178878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFEEA79522
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642813AC1BB
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B61D7E2F;
	Wed,  2 Apr 2025 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XjJT2Uqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B821A3173
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618715; cv=none; b=s6dwR9ys7L9bWGKjdoYjpwkOs/DuRACIjzxJaqLExpfVWEiNjUzJmkfKoe1QpKcPl1jz/LFxnu1QaQrWOji3zKjU+RlMhL1B84qZnxHf+ZqFpzAlwT+p4qac2tW/JES/z4Sm6KHBuMIdRTdvJ76aYDSkcboSGRhc46zM8RsLD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618715; c=relaxed/simple;
	bh=ejtJgqgiW4yRqj478rhg5NO7Ij0T7wZA9qmvgMkBM4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AO+icMUgOAsCIEqyPGzHg8OS73Xb+yoQgNk7gp0eRUFLtOiSHf86/cqZsB7AHWgV7mRlSvyDB2ovwItzjZhafgpsdiEv1nJ6aYLLewXGazPeXyZdvlAhhCwwxcRP42+LTOvxUR2wwwRUpR7wrpcYKQUNJb0XISCI6srKH8wmhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XjJT2Uqz; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2b8e2606a58so25790fac.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743618712; x=1744223512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpOPhY3pXWa2a3oRCwpjjmk1VE9xvBrlEZBOx62p0qY=;
        b=XjJT2UqzLvfzjM/ewXKF7f9buL+aVkK3gHdZkp/7tT2TPH22JStEKZQ4kIBebbnIDo
         XBq61sIFdcs7Q4H21yox3NRDEupYUnkX2GcT/CNw7ZGpZA5kYPOFl+3Q2ZY5DG5Ij4fC
         1q2aAW8rGd9aHP6ZNwvjrBOXaRYsuQvq8I7PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743618712; x=1744223512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpOPhY3pXWa2a3oRCwpjjmk1VE9xvBrlEZBOx62p0qY=;
        b=nfpe/bUEWvbGTvMQxYQSFb4Luaps0dKId6NFJvc42a3QseBakab9mejXY3a1XmUWRJ
         cLtpGxrQ7aHKi7dNu6dvMsh132uO9Lu4LATLdSuSxdHLVHEc2ZxF3GQ0RuvNlYCOaikJ
         ciDq4Sjad00yq7WRHGL87VzcFSVF7Uw7ktoYfyj4x4uncc1YhIKfDAl5SVCpcgjzhvTk
         yjYYyPvR0TEd9Rs2JQ7+wJkUV21srqA7v1YWKud/2t7lqlh2IrIuVi+lOkLG6cUgy7W6
         cYZcFdTvdmhePUJylDAxYzL5MYnYiUQNOceTdAf9MtP+X8mC6HqBsuYcvb+jGgFpGKnB
         F3Vg==
X-Gm-Message-State: AOJu0YweteaVBh57PnKVh3FJ6uNyzfN96FdQ4Jy1eyIm91FrjMN//iNs
	pznTVr5b/r4KTUuMZiE+sotuUqhrD2eV4JyckN/K4P84g6RtByPrI5z1xjRbcg==
X-Gm-Gg: ASbGncvvZFE7kUWjDpZ740fG7+P2xag9DSOjaW6OX1aqI6X1HzCQQA9HTu8JuPONuI4
	xc46VhUsmL1rWkavpNZ1RrvrZ77s4IE4kiF2pRwSfF7QQx5nDVDVtGXtPfraejIcI4OsnaXH+Jt
	X6efWI9b8OSqOCvEwMBSgZ8bYRkdCRKhm4eaIQ3EYjxcjsVv5WOnqTsaOcbmYzqljuKiekbF0qy
	L7QGUHbBEGLrdLLkjiRbMOwnbGGehGv8EL8KTzro891knqdDmi6DTHCwewV7NoR+phhlsHUhUIL
	lOJrY7aizORbgrc04Af5V7bsPbWKJmSxF/8jmr3s+fNgJ304CWoXH6tIdOaCjA0iU481sbyKaB3
	c8Bkv+fpzVTAQKizPHtrU
X-Google-Smtp-Source: AGHT+IE3tmntW6ugOk+L37562RiQgvnHk73rQ1tWXvIB6YNUWHXdBbGZBPKBxXB9C0DLLBKFV1khmQ==
X-Received: by 2002:a05:6870:7182:b0:29e:290f:7af4 with SMTP id 586e51a60fabf-2cc382d2af9mr4855357fac.34.1743618712259;
        Wed, 02 Apr 2025 11:31:52 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a856de7sm2917135fac.39.2025.04.02.11.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:31:51 -0700 (PDT)
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
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 1/2] ethtool: cmis_cdb: use correct rpl size in ethtool_cmis_module_poll()
Date: Wed,  2 Apr 2025 11:31:22 -0700
Message-ID: <20250402183123.321036-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250402183123.321036-1-michael.chan@broadcom.com>
References: <20250402183123.321036-1-michael.chan@broadcom.com>
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

Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands)
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
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


