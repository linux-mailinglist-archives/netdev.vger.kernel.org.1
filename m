Return-Path: <netdev+bounces-152114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FCF9F2B83
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53798163D35
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66A1FF7A0;
	Mon, 16 Dec 2024 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ycsasqec"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF01CEAD5;
	Mon, 16 Dec 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336509; cv=none; b=e/qwihzqLvvNU/WKkFODUBdQ40CSmJBXIR1bhkmGRB7knGfc8mQFIuPeOl/xTshcu4RGEWTbtzcbgDeJqTrhP0PwJHaCaC0B3dgkoUCn8WNnh4bG++GNN8S1UKoV0lSc5KcqfZfYD0XeYX69kU0xhY/gBzq39i+yUGe25/GtgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336509; c=relaxed/simple;
	bh=vKRg9IvjfK+czGohhlnN+R6sJwilUcCYTWCQQeDkfgY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A3xl7Sj9bg4/GTNKx0mL9pvIJELhZd7tV+qw8Ao4qE+P0Vjcco16sQcvpiRx7L4kkmcyKog6+FpNe619aGCjF0+0emEa8IVD1b1OfFx7mgzS6tm5pw2HcPBAbGvBekS4AtK8WZ/vM0nHtefrGixOlEwzDItd702d6XRosbpNpV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ycsasqec; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG70dj2009305;
	Mon, 16 Dec 2024 08:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZXXxk4rz1MSk4Nse1rMuOF
	VjQQ+tODMhIlyfIHY/zUk=; b=YcsasqecQmGOw7t/saWssRQq62BWhW1VJ5lBEc
	F49tHvzjKr//LEKIQF3fgn6EPQ4py+2Dxy5XnRZ2oMe+YRuXU6zPuis1ZdJ/yEzj
	nWtVMgmdkYelIff5PgOyfRvI/GD13sgSM1SiWIobTtMAY9ZKM/Q7XfNOZsOTKapA
	6Es4MEUaXtferPOOGLwGxqMDFGv6ajg9mq+mrJ4uhWIZVAMR2coJKicjTekj1efI
	SosDDjLfAtyjzemNXArvbcwd+UuomEpguBkRLP90SgjjvYpAG93L2Y3cwYRCUSGa
	nFRxJM8DO7H69Y35Zqig+tDSjaJfhHUvYh/mSlQYWMeRwI6w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jfemg5ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 08:08:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BG88HVs019279
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 08:08:17 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 16 Dec 2024 00:08:13 -0800
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_chejiang@quicinc.com>, <quic_jiaymao@quicinc.com>,
        <quic_shuaz@quicinc.com>, <quic_zijuhu@quicinc.com>,
        <quic_mohamull@quicinc.com>
Subject: [PATCH v1] Bluetooth: hci_sync: Fix disconnect complete event timeout issue
Date: Mon, 16 Dec 2024 16:07:58 +0800
Message-ID: <20241216080758.3450976-1-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3GikgXpARt62adh3mqDkazdpc5kVy8Oz
X-Proofpoint-ORIG-GUID: 3GikgXpARt62adh3mqDkazdpc5kVy8Oz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160066

Sometimes, the remote device doesn't acknowledge the LL_TERMINATE_IND
in time, requiring the controller to wait for the supervision timeout,
which may exceed 2 seconds. In the current implementation, the
HCI_EV_DISCONN_COMPLETE event is ignored if it arrives late, since
the hci_abort_conn_sync has cleaned up the connection after 2 seconds.
This causes the mgmt to get stuck, resulting in bluetoothd waiting
indefinitely for the mgmt response to the disconnect. To recover,
restarting bluetoothd is necessary.

bluetoothctl log like this:
[Designer Mouse]# disconnect D9:B5:6C:F2:51:91
Attempting to disconnect from D9:B5:6C:F2:51:91
[Designer Mouse]#
[Designer Mouse]# power off
[Designer Mouse]#
Failed to set power off: org.freedesktop.DBus.Error.NoReply.

Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         |  9 +++++++++
 net/bluetooth/hci_event.c        |  9 +++++++++
 net/bluetooth/hci_sync.c         | 18 ++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 734cd50cd..2ab079dcf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -753,6 +753,8 @@ struct hci_conn {
 
 	struct bt_codec codec;
 
+	struct completion disc_ev_comp;
+
 	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d097e308a..e0244e191 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1028,6 +1028,15 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
 
 	hci_conn_init_sysfs(conn);
 
+	/* This disc_ev_comp is inited when we send a disconnect request to
+	 * the remote device but fail to receive the disconnect complete
+	 * event within the expected time (2 seconds). This occurs because
+	 * the remote device doesn't ack the terminate indication, forcing
+	 * the controller to wait for the supervision timeout.
+	 */
+	init_completion(&conn->disc_ev_comp);
+	complete(&conn->disc_ev_comp);
+
 	return conn;
 }
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2cc7a9306..60ecb2b18 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3366,6 +3366,15 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* Wake up disc_ev_comp here is ok. Since we hold the hdev lock
+	 * hci_abort_conn_sync will wait hdev lock release to continue.
+	 */
+	if (!completion_done(&conn->disc_ev_comp)) {
+		complete(&conn->disc_ev_comp);
+		/* Add some delay for hci_abort_conn_sync to handle the complete */
+		usleep_range(100, 1000);
+	}
+
 	if (ev->status) {
 		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 				       conn->dst_type, ev->status);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0badec712..783d04b57 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5590,6 +5590,24 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		break;
 	}
 
+	/* Check whether the connection is successfully disconnected.
+	 * Sometimes the remote device doesn't acknowledge the
+	 * LL_TERMINATE_IND in time, requiring the controller to wait
+	 * for the supervision timeout, which may exceed 2 seconds. In
+	 * this case, we need to wait for the HCI_EV_DISCONN_COMPLETE
+	 * event before cleaning up the connection.
+	 */
+	if (err == -ETIMEDOUT) {
+		u32 idle_delay = msecs_to_jiffies(10 * conn->le_supv_timeout);
+
+		reinit_completion(&conn->disc_ev_comp);
+		if (!wait_for_completion_timeout(&conn->disc_ev_comp, idle_delay)) {
+			bt_dev_warn(hdev, "Failed to get complete");
+			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
+					       conn->dst_type, conn->abort_reason);
+		}
+	}
+
 	hci_dev_lock(hdev);
 
 	/* Check if the connection has been cleaned up concurrently */

base-commit: e25c8d66f6786300b680866c0e0139981273feba
-- 
2.34.1


