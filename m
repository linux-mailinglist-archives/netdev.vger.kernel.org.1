Return-Path: <netdev+bounces-20388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CAC75F493
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E07A1C20AA6
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2FA5678;
	Mon, 24 Jul 2023 11:12:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C216F5254
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 11:12:14 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598D6FF
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 04:12:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57059f90cc5so55120897b3.0
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690197131; x=1690801931;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eFhXqPzQ2tthbPayltjw9RTOGjFgrZqk+zK3gjC9kM4=;
        b=ggmPGkyrWpVK5PTOJ3pk2b+/2dvKWx6SYUg1qa3HtHNQNKRK05jGRT+R8HchyqBDtC
         ot4QslRmPwsZ7WsUTn03dcT/oSDMCDJfz3g75Oxle7RG4q+eO+yGbpq4YoqiqpCfHj50
         DExXtwDUy3R298B62XsY67RzfRHtx5/bdYgM4ayvtp/kW9B6BTuSlSCES/8KF7ONLzZN
         90pzossXOjJX4GqfQVHA1yFG6FRgsjjKLr8uLwzH3cjas2Rpyq5TjyIwDRzZwEyAYhOe
         mLB0rOdzZ3RNGL5uwRyr1NVVzYSWdnZ0wMs6ukr3NDKmuSaAKZsz7EdH0EYRWI/Tc9N1
         CNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690197131; x=1690801931;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFhXqPzQ2tthbPayltjw9RTOGjFgrZqk+zK3gjC9kM4=;
        b=OgehaDk0gqXPlJZNv8cHKAH9euCPCKaw0Y40Dp4xHuA4oEtcU40fx1ptRI3C7hpL++
         EtktpYySCItxYM2kvmZFgDk6lX8F6Ed2OxsJd4oWco6FGdEEuEFvtm4lc/YqfQlShI4Y
         iGR6IVRKlHcLimsVbX66jGs/kAWeV3t036G+8esxAmVLr/orN3U470Nm5PXOZHK/q64a
         D5XVZTC4S/YVrJ6/sYTf5FGjXKrupn2K6VPQgSn3rysMjLLpH3Bkq73NTnCHBekxPduE
         qf9zSqzkPVKC3Sk29dC6Ti19tgVFMUw6pkw5Qwm0B+2hg7oLqeoGZRO8PopqbLR2IFUm
         Tqnw==
X-Gm-Message-State: ABy/qLaOyCRz2bBohrrm1OvxPBybvpS8xz/j8HPsehoSO/E9UbiTXkGh
	4U7vPNlbivjpurgykpQXHwagobc83m6NvwKCPQ==
X-Google-Smtp-Source: APBJJlEY2EaCw8gfh/yN9knR87JKhxx2QZqfY/XgAy8v+8VYYf0LtPMlTdKOLzsWSCMwHdK8OLzrg6XU+81MIddhgA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:e198:1dc1:794b:3807])
 (user=howardchung job=sendgmr) by 2002:a81:eb02:0:b0:56c:b037:88aa with SMTP
 id n2-20020a81eb02000000b0056cb03788aamr66188ywm.5.1690197131602; Mon, 24 Jul
 2023 04:12:11 -0700 (PDT)
Date: Mon, 24 Jul 2023 19:12:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724111206.3067352-1-howardchung@google.com>
Subject: [PATCH v1] Bluetooth: Add timeout in disconnect when power off
From: Howard Chung <howardchung@google.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc: Howard Chung <howardchung@google.com>, Archie Pusaka <apusaka@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For some controllers, it is known that when the HCI disconnect and HCI
Reset are too close to each other, the LMP disconnect command might not
been sent out yet and the command will be dropped by the controoler when
it is asked to reset itself. This could happen on powering off adapter.

One possible issue is that if a connection exists, and then powering off
and on adapter within a short time, then our host stack assumes the
conntection was disconnected but this might not be true, so if we issue
a connection to the peer, it will fail with ACL Already Connected error.

This CL makes the host stack to wait for |HCI_EV_DISCONN_COMPLETE| when
powering off with a configurable timeout unless the timeout is set to 0.

Reviewed-by: Archie Pusaka <apusaka@google.com>
Signed-off-by: Howard Chung <howardchung@google.com>
---
Hi upstream maintainers, this is tested with an AX211 device and Logi
K580 keyboard by the following procedures:
1. pair the peer and stay connected.
2. power off and on immediately
3. observe that the btsnoop log is consistent with the configured
   timeout.

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  2 +-
 net/bluetooth/hci_sync.c         | 38 +++++++++++++++++++++++---------
 net/bluetooth/mgmt_config.c      |  6 +++++
 4 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8200a6689b39..ce44f9c60059 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -432,6 +432,7 @@ struct hci_dev {
 	__u16		advmon_allowlist_duration;
 	__u16		advmon_no_filter_duration;
 	__u8		enable_advmon_interleave_scan;
+	__u16		discon_on_poweroff_timeout;
 
 	__u16		devid_source;
 	__u16		devid_vendor;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0fefa6788911..769865494f45 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2479,7 +2479,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	hdev->adv_instance_cnt = 0;
 	hdev->cur_adv_instance = 0x00;
 	hdev->adv_instance_timeout = 0;
-
+	hdev->discon_on_poweroff_timeout = 0;	/* Default to no timeout */
 	hdev->advmon_allowlist_duration = 300;
 	hdev->advmon_no_filter_duration = 500;
 	hdev->enable_advmon_interleave_scan = 0x00;	/* Default to disable */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3348a1b0e3f7..260e9f05359c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5250,6 +5250,8 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 			       u8 reason)
 {
 	struct hci_cp_disconnect cp;
+	unsigned long timeout;
+	int err;
 
 	if (conn->type == AMP_LINK)
 		return hci_disconnect_phy_link_sync(hdev, conn->handle, reason);
@@ -5258,19 +5260,33 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 	cp.handle = cpu_to_le16(conn->handle);
 	cp.reason = reason;
 
-	/* Wait for HCI_EV_DISCONN_COMPLETE, not HCI_EV_CMD_STATUS, when the
-	 * reason is anything but HCI_ERROR_REMOTE_POWER_OFF. This reason is
-	 * used when suspending or powering off, where we don't want to wait
-	 * for the peer's response.
+	/* The HCI_ERROR_REMOTE_POWER_OFF is used when suspending or powering off,
+	 * so we don't want to waste time waiting for the reply of the peer.
+	 * However, if the configuration specified, we'll wait some time to give the
+	 * controller chance to actually send the disconnect command.
 	 */
-	if (reason != HCI_ERROR_REMOTE_POWER_OFF)
-		return __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNECT,
-						sizeof(cp), &cp,
-						HCI_EV_DISCONN_COMPLETE,
-						HCI_CMD_TIMEOUT, NULL);
+	if (reason == HCI_ERROR_REMOTE_POWER_OFF && !hdev->discon_on_poweroff_timeout) {
+		return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT,
+					     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	}
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT, sizeof(cp), &cp,
-				     HCI_CMD_TIMEOUT);
+	if (reason == HCI_ERROR_REMOTE_POWER_OFF)
+		timeout = msecs_to_jiffies(hdev->discon_on_poweroff_timeout);
+	else
+		timeout = HCI_CMD_TIMEOUT;
+
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNECT,
+				       sizeof(cp), &cp,
+				       HCI_EV_DISCONN_COMPLETE,
+				       timeout, NULL);
+
+	/* Ignore the error in suspending or powering off case to avoid the procedure being
+	 * aborted.
+	 */
+	if (reason == HCI_ERROR_REMOTE_POWER_OFF)
+		return 0;
+
+	return err;
 }
 
 static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 6ef701c27da4..f3194e3642d9 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -78,6 +78,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		HDEV_PARAM_U16(advmon_allowlist_duration);
 		HDEV_PARAM_U16(advmon_no_filter_duration);
 		HDEV_PARAM_U8(enable_advmon_interleave_scan);
+		HDEV_PARAM_U16(discon_on_poweroff_timeout);
 	} __packed rp = {
 		TLV_SET_U16(0x0000, def_page_scan_type),
 		TLV_SET_U16(0x0001, def_page_scan_int),
@@ -111,6 +112,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		TLV_SET_U16(0x001d, advmon_allowlist_duration),
 		TLV_SET_U16(0x001e, advmon_no_filter_duration),
 		TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
+		TLV_SET_U16(0x0020, discon_on_poweroff_timeout),
 	};
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -186,6 +188,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x001b:
 		case 0x001d:
 		case 0x001e:
+		case 0x0020:
 			exp_type_len = sizeof(u16);
 			break;
 		case 0x001f:
@@ -314,6 +317,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0001f:
 			hdev->enable_advmon_interleave_scan = TLV_GET_U8(buffer);
 			break;
+		case 0x00020:
+			hdev->discon_on_poweroff_timeout = TLV_GET_LE16(buffer);
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
-- 
2.41.0.487.g6d72f3e995-goog


