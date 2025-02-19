Return-Path: <netdev+bounces-167912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679FBA3CCA9
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52E4178BF0
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E8525D526;
	Wed, 19 Feb 2025 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bGQH4t6n"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4E25B66C;
	Wed, 19 Feb 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005492; cv=none; b=Nl0T4Qy7zWCZoBoNQTCjXA6ucZN2su+o4nsdSkGcWodYn5NL3odhIa34Kot8jjI1n8zCupZO4Vkrg9FlHO5ZQ8CtKIS7OAl7C0fIHJB7KI92VvdrdW5a3fW1LOJ06XB5u5CqrsjZfd8vyM5JFiU4t82+b43bm35PORjzBUlT7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005492; c=relaxed/simple;
	bh=gqldzETYE4eIO8/SI33h66mI1sao45EOkmCTt5tg4Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2akJbDruHe96d6cfW3NaL8jGBaAwC+8w8EFobkCnKG40Eb//JFHhR04pUbtURzgIkEqr1ZZu9roAAUtSkUiT+ucEA7SJhOuJxgiBcjwWDq57Cn2eSJUZ3yjvmQkjVCz+aDflLAdW/plyJx9taPmUT4n0Ad9O26VPLen+A3PLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bGQH4t6n; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id DA1E62043DEE;
	Wed, 19 Feb 2025 14:51:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA1E62043DEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740005490;
	bh=qcydmwtspRWmmaxoob7kiYVpr30AJTytieT4IA+PbUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bGQH4t6nq1nawFw7HolgqjDsdt3hs5UgzxjsimQSto9W8VSoj+cM7j8uedPnp36Pj
	 u8VWOXQCZS30XuLH23X/1ZYjXHPq2Y+VpQNMyBXYAABgXnMLSG+SSo+Wz3meK588yk
	 TcdNkKfmColoYJvGRPhZKmYv+1kuQMRGM1v+Fasw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 19 Feb 2025 22:51:30 +0000
Subject: [PATCH 2/4] Bluetooth: MGMT: convert timeouts to secs_to_jiffies()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-bluetooth-converge-secs-to-jiffies-v1-2-6ab896f5fdd4@linux.microsoft.com>
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
 net/bluetooth/hci_sync.c | 2 +-
 net/bluetooth/mgmt.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index dd770ef5ec36840add2fa0549aa1689135a21e4c..a43749aebf76e83f3541deb346015c5e5a620eda 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1910,7 +1910,7 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 		hdev->adv_instance_timeout = timeout;
 		queue_delayed_work(hdev->req_workqueue,
 				   &hdev->adv_instance_expire,
-				   msecs_to_jiffies(timeout * 1000));
+				   secs_to_jiffies(timeout));
 	}
 
 	/* If we're just re-scheduling the same instance again then do not
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e8533167aa88377e6ecd8702277730db0fd21b36..a31b46db50dd546c665e18786c2e1efc1391ee61 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1533,7 +1533,7 @@ static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
 
 	if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE) &&
 	    hdev->discov_timeout > 0) {
-		int to = msecs_to_jiffies(hdev->discov_timeout * 1000);
+		int to = secs_to_jiffies(hdev->discov_timeout);
 		queue_delayed_work(hdev->req_workqueue, &hdev->discov_off, to);
 	}
 
@@ -1641,7 +1641,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		hdev->discov_timeout = timeout;
 
 		if (cp->val && hdev->discov_timeout > 0) {
-			int to = msecs_to_jiffies(hdev->discov_timeout * 1000);
+			int to = secs_to_jiffies(hdev->discov_timeout);
 			queue_delayed_work(hdev->req_workqueue,
 					   &hdev->discov_off, to);
 		}
@@ -2534,7 +2534,7 @@ static int send_hci_cmd_sync(struct hci_dev *hdev, void *data)
 	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cp->opcode),
 				le16_to_cpu(cp->params_len), cp->params,
 				cp->event, cp->timeout ?
-				msecs_to_jiffies(cp->timeout * 1000) :
+				secs_to_jiffies(cp->timeout) :
 				HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_HCI_CMD_SYNC,

-- 
2.43.0


