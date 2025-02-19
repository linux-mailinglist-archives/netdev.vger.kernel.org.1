Return-Path: <netdev+bounces-167910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E33ECA3CCA7
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0901896E11
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02E125C6F8;
	Wed, 19 Feb 2025 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AcRUDzne"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364B325A33B;
	Wed, 19 Feb 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005492; cv=none; b=OQKwo+BEbcfhgAkLeDiG5YgN62Lj00G1KImVvyXMs85S/uwDNUVUGgaRD9NebySv8rn3C+287GWtKFnW2TM5peQc7AhrKtS8BCdPSDoALbkaP2Zfwz/7xOZaPHtdQubGrmyhVGXnEkWBJDsPQkRc4FgD3j5rP+sBgiRxXCI4LsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005492; c=relaxed/simple;
	bh=jSLTuiGnjXNGbqSNycQNLaYuo5WV5biDIqUuYkjOoLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jh8QK+FFusdfUHPRs90mWRnLPt5k6bS3+cmjEGnhkbMn3DdTWZ5aUVTRKrLWBfsbDO1yZ+9Xs+z6pOgI2UpHheslVbRi5aYcFBJdpeOMN70YWpIikBzIpv1rtQrdcnJE3O7EIkBNBpgdcrbNek52VBrNAo90chliFgw++YA1Pa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AcRUDzne; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id C10222043DED;
	Wed, 19 Feb 2025 14:51:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C10222043DED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740005490;
	bh=DfRuFuSD7f49dIFrnKJPwzeL+ytShRTpfdnnMHINqkU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AcRUDznef5RRSHYXZGqwJuRtkGKkG3SYE2tTsp2v+evULQySn4r2Et1tQVRbGtcBI
	 Mp6Cizl46JBTmcQ2offIT3JgwhlfR4tM0fZOFUdO5w89ojyMOck/R6uioRSSa4xYZY
	 U7QBACx0oDiEHH8iURkqFG/d4LzGgCTBLAhCF6xY=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 19 Feb 2025 22:51:29 +0000
Subject: [PATCH 1/4] Bluetooth: hci_vhci: convert timeouts to
 secs_to_jiffies()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-bluetooth-converge-secs-to-jiffies-v1-1-6ab896f5fdd4@linux.microsoft.com>
References: <20250219-bluetooth-converge-secs-to-jiffies-v1-0-6ab896f5fdd4@linux.microsoft.com>
In-Reply-To: <20250219-bluetooth-converge-secs-to-jiffies-v1-0-6ab896f5fdd4@linux.microsoft.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies(E * 1000)
+secs_to_jiffies(E)

-msecs_to_jiffies(E * MSEC_PER_SEC)
+secs_to_jiffies(E)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/bluetooth/hci_vhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 7651321d351ccd5a96503bb555b5d9eb2c35b4ff..963741490106ae686b88babff560dc0ad03ec37d 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -316,7 +316,7 @@ static inline void force_devcd_timeout(struct hci_dev *hdev,
 				       unsigned int timeout)
 {
 #ifdef CONFIG_DEV_COREDUMP
-	hdev->dump.timeout = msecs_to_jiffies(timeout * 1000);
+	hdev->dump.timeout = secs_to_jiffies(timeout);
 #endif
 }
 
@@ -645,7 +645,7 @@ static int vhci_open(struct inode *inode, struct file *file)
 	file->private_data = data;
 	nonseekable_open(inode, file);
 
-	schedule_delayed_work(&data->open_timeout, msecs_to_jiffies(1000));
+	schedule_delayed_work(&data->open_timeout, secs_to_jiffies(1));
 
 	return 0;
 }

-- 
2.43.0


