Return-Path: <netdev+bounces-127283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E24974DA9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C5D1C20CD3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFDF13F454;
	Wed, 11 Sep 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVjq8hLS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37113C683
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044999; cv=none; b=qnhPaLOJdEWCrKcAPstcypKLfIBcn41SWahToTpvjggmd+bwobey0oCsIblmoATHfzU9rRLY/B8j3dZoaXcI+TXSTZB+6/ZeBq2N5+ZH+a2mSP3FiCPG5GchD3FZ7rijmMwZhM5AKQpV0ryck/0FQfMVJYY+qpZ3ig6JFsDcW5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044999; c=relaxed/simple;
	bh=chBVuUNmFu3hT1KerEsb/MWqtSINBAH+ePlwCsZbgkE=;
	h=From:Date:Subject:Cc:To:Message-ID:MIME-Version; b=B1wF9TuwgfsZBYZOz+Nwd2g1c/4DIfHURcrIbNxEyH8niRlbfxmRtwHVLCOf/pA2T6caVAsU3GjWoMujcPHNSwVq3XOCadYTjxM9xtBpAYW0GHLYRH0VAvnV2RN4BcOTzc2+YH9zQQ0uPJe9Rhtf86KwYrKqUIQaE4+E1gc5NAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVjq8hLS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so40975965e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044996; x=1726649796; darn=vger.kernel.org;
        h=user-agent:mime-version:message-id:to:cc:subject:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1hmqhoafjEnsQYqkDQK3nIMfxkqrGE1CR8SYq5VDeTk=;
        b=WVjq8hLS5ph0bqoZu2QEC+TtELjCzc4vMe0DvWO95aVccX3iCNsEVNhLQaY0FE8aRY
         R1O0jR4zOphJGntbAMo4UNMmjLG39FTBkY7UxdwzfvQKy/8fMWnk5dcMnyByApBILWlW
         RU7AF81D9J/H4+ykqvShimngqKyhZg2pqvDXyL4FfofRG0ffPdRWUd8r1tow54nSSd7d
         lMOxVakoex0BFeBWkcDUFh0o0EU1BQY7UkllZxSMyERlPcbuNfGKCJQlUHyJcuo87fgM
         zE38PK8fCygTKtwGYeJfLzNwlpBvROpfVaPKF5Ljml+MEEOI60v0Iyxp5Mh1S0HgeQME
         jegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044996; x=1726649796;
        h=user-agent:mime-version:message-id:to:cc:subject:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hmqhoafjEnsQYqkDQK3nIMfxkqrGE1CR8SYq5VDeTk=;
        b=C7E7sIy55Rlhd3fj1i3hNDatjmddfn7YhwmCsdJ2Dh1rNkb8vAVLk9v+eqqJXoJxD6
         ucL9gWl/hHoYoEbBhCnYorp36LV+4U8VbVX4diIamajRxDBN/lkBhRjdHuShBcYhQp8w
         SQZxaKrlT0XXxxYcPlj1AJyJEMN7YeSFjL8xp6PyrduYY9x9JB7UVx1plK/a8IjB613a
         R7ElVt93TGfiHV7z0M2cBibwXN3V7IPfcBv2xNTLTacJiAZHhwCr6rQ42y3nAyvrxLgc
         zSVyPQQOPMMD1EbJndj2jWEpy3jUCzmJccPBmuzo7qW5Pfny5bVeqhi8ke00sA/SBvAc
         jUNA==
X-Gm-Message-State: AOJu0YwAurlNF5Pw1XCIbRqrZIhz5nL83hdJhmgSzhJvcA/GjpIr2cAz
	DsOwOhWmJbzrhM7pilKhqVCNmG4fBKuty830pfIWuXL3keI6K8ibpH8J+g==
X-Google-Smtp-Source: AGHT+IGvSrkMM/0t6QkqgseuwqjPbAjGZf0QpNgXwfjrpwIHB71xc0ucW+lsFE+yia9upIluONB5GA==
X-Received: by 2002:a05:600c:3c8d:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-42c9f9d385emr125915765e9.30.1726044995274;
        Wed, 11 Sep 2024 01:56:35 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb5ba4532sm109265975e9.38.2024.09.11.01.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:56:34 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Google-Original-From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Date: Wed, 4 Sep 2024 11:07:42 +0200
Subject: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Cc: Andrew Lunn <andrew@lunn.ch>
To: netdev@vger.kernel.org
Message-ID: <cecf48f4ae26a642125bb06765abda0a952cdf6e.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.52.4 

dsa_switch_shutdown() doesn't bring down any ports, but only disconnects
slaves from master. Packets still come afterwards into master port and the
ports are being polled for link status. This leads to crashes:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
CPU: 0 PID: 442 Comm: kworker/0:3 Tainted: G O 6.1.99+ #1
Workqueue: events_power_efficient phy_state_machine
pc : lan9303_mdio_phy_read
lr : lan9303_phy_read
Call trace:
 lan9303_mdio_phy_read
 lan9303_phy_read
 dsa_slave_phy_read
 __mdiobus_read
 mdiobus_read
 genphy_update_link
 genphy_read_status
 phy_check_link_status
 phy_state_machine
 process_one_work
 worker_thread

Call lan9303_remove() instead to really unregister all ports before zeroing
drvdata and dsa_ptr.

Fixes: 0650bf52b31f ("net: dsa: be compatible with masters which unregister on shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/dsa/lan9303-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 268949939636..ecd507355f51 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1477,7 +1477,7 @@ EXPORT_SYMBOL(lan9303_remove);
 
 void lan9303_shutdown(struct lan9303 *chip)
 {
-	dsa_switch_shutdown(chip->ds);
+	lan9303_remove(chip);
 }
 EXPORT_SYMBOL(lan9303_shutdown);
 
-- 
2.46.0

