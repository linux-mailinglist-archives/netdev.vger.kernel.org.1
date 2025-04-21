Return-Path: <netdev+bounces-184445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76239A958E0
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3763B318C
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7418322128E;
	Mon, 21 Apr 2025 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="nQJC0Fc4"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99BE221289;
	Mon, 21 Apr 2025 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272976; cv=pass; b=anA/GpSs78hGhjPFem/Uzfxvl8QjaujyXTMJa7YHTR+VeyXaMfyH7j2bybGkA8bmCwFVlJIf+ItjYJDtZZjZe1M9zA1GH7fDXtb5BvwyUlThBuOtHoGq975fv1HkDpLXuG+21xUaZd8bBrR9SEHm+a0EMF6/DI7M2KiATobNa1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272976; c=relaxed/simple;
	bh=TDuUmjERxzpZupEEIWrAYX9CP7zrQEa4WT8BuKPzMms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OwPgnCZIfidZynQ08gSE4VK1Dfk007eTLoVBWXchj7lm3Pjfane4w8YxLweyRZiDhlugDBYIPEa+9py0mdl47Mg4aN8EQjv9cmTcyLqVYUBhVlwh9CILbdDEHbbWqKyAwcWVaHMJRgDjQxARUUmqycFrvIdVUOSeWMx+w4ZLMXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=nQJC0Fc4; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZhK9X3wD6z49Pwm;
	Tue, 22 Apr 2025 01:02:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745272961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nn7shMwnID3Cbv85If5AHt3xSsWKkrff5w2tj8O7Hco=;
	b=nQJC0Fc4n44QBI3x22Un5+usQfsSt3V8qe/IVEyXCcLl21XU3FKkUVdNFhPRZZSZxzuUW3
	aAb0LckRxsmqQJl6N++dXcOUP7CWxgrP87qSafzokOGUJB5LqtNKvPrM0aazV1b9iHXyq8
	4iscCaDdmJOQMSvhG8Fw06v9tNsQtTWYe4Ca0+gRVU0uZ7Eg70hbjqCtoUZ6FA53+BABgh
	2Yop2Bn/oliTIkrXGqAYtSA4s85mdaCbmEbz3vN7U1qswveWADPOncAC1a6rqPWun1ytPw
	C+S9jqXeY6ugey0OX89XZDbR4iiek8i0FI7cc2CLWCKnhcR4L903sb79aHwrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745272961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nn7shMwnID3Cbv85If5AHt3xSsWKkrff5w2tj8O7Hco=;
	b=jP26Hq+gxt8Pbt2P8liSeG2s4pQv1Ho57MsIay49YUqOwGAlc704nMRaZI72gT9vFKjEGr
	0bIXJzIt8N7tuNGybwPox0QRm7TcWlsuEt0DD2eqWseWRmhW54l+j+E678jGvWHWW7jYI3
	UovI91fpEFM/iApHFYFM2aARHHeI1j4lzrnWBdrvSm+7/h+/3Mv/4PRKVX+mjINk1pW0CN
	VsIeqxjVSM2zW4FLYBNBTCRoWX95GICIc3GqlH1m8ncVOriaBa/EaL974ZLFAU9/5GdvGY
	9zAyVnFhdCSuMDbvUioPMhEaBQDVKpnCZtX6zaNeb8D2+vClmpgvxrGIZlAiBg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745272961; a=rsa-sha256;
	cv=none;
	b=dcNYe4cpxZqtI3/gVTzxGO60DVfV0tBgbI0OA149gITIOu4GanLtaikeytgfDOkzMq/zI1
	ZYnwFRjlrpV4yCXlTUmw5OiTeqghGUK3Xgq04hZy5qd5AryOfEjZUaNruVFoZnuHwSpIZ0
	NX0B4uFE4SZb8rtF/q+kfKDJ9YG10S7kdW7ph2/hCFWOo/tsLhdP2/7x82aca++cQvgvwv
	gHdTVYjGYhASAw+0/ebVF3H40dMKf60sd9WeblRLjdSTj6UI+mQYuS5eidyhrv2WYgm+Pf
	vIjwPkYNKdQ7Npp591cJgigOgPP/ohflpPLnCB33TL7ZlXCvWbOVuNy8b0mcsA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	luiz.dentz@gmail.com,
	netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	kernelxing@tencent.com
Subject: [PATCH] Bluetooth: add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
Date: Tue, 22 Apr 2025 01:02:08 +0300
Message-ID: <0ff3e783e36ac2a18f04cf3bc6c0d639873dd39d.1745272179.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bluetooth needs some way for user to get supported so_timestamping flags
for the different socket types.

Use SIOCETHTOOL API for this purpose. As hci_dev is not associated with
struct net_device, the existing implementation can't be reused, so we
add a small one here.

Add support (only) for ETHTOOL_GET_TS_INFO command. The API differs
slightly from netdev in that the result depends also on socket proto,
not just hardware.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Another option could be a new socket option, not sure what would be best
    here. Using SIOCETHTOOL may not be that great since the 'ethtool' program
    can't query these as the net_device doesn't actually exist.

 include/net/bluetooth/bluetooth.h |  4 ++
 net/bluetooth/af_bluetooth.c      | 87 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_conn.c          | 40 ++++++++++++++
 3 files changed, 131 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bbefde319f95..114299bd8b98 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -29,6 +29,7 @@
 #include <linux/poll.h>
 #include <net/sock.h>
 #include <linux/seq_file.h>
+#include <linux/ethtool.h>
 
 #define BT_SUBSYS_VERSION	2
 #define BT_SUBSYS_REVISION	22
@@ -448,6 +449,9 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 			  hci_req_complete_t *req_complete,
 			  hci_req_complete_skb_t *req_complete_skb);
 
+int hci_ethtool_ts_info(unsigned int index, int sk_proto,
+			struct kernel_ethtool_ts_info *ts_info);
+
 #define HCI_REQ_START	BIT(0)
 #define HCI_REQ_SKB	BIT(1)
 
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 0b4d0a8bd361..6ad2f72f53f4 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -34,6 +34,9 @@
 #include <net/bluetooth/bluetooth.h>
 #include <linux/proc_fs.h>
 
+#include <linux/ethtool.h>
+#include <linux/sockios.h>
+
 #include "leds.h"
 #include "selftest.h"
 
@@ -563,6 +566,86 @@ __poll_t bt_sock_poll(struct file *file, struct socket *sock,
 }
 EXPORT_SYMBOL(bt_sock_poll);
 
+static int bt_ethtool_get_ts_info(struct sock *sk, unsigned int index,
+				  void __user *useraddr)
+{
+	struct ethtool_ts_info info;
+	struct kernel_ethtool_ts_info ts_info = {};
+	int ret;
+
+	ret = hci_ethtool_ts_info(index, sk->sk_protocol, &ts_info);
+	if (ret == -ENODEV)
+		return ret;
+	else if (ret < 0)
+		return -EIO;
+
+	memset(&info, 0, sizeof(info));
+
+	info.cmd = ETHTOOL_GET_TS_INFO;
+	info.so_timestamping = ts_info.so_timestamping;
+	info.phc_index = ts_info.phc_index;
+	info.tx_types = ts_info.tx_types;
+	info.rx_filters = ts_info.rx_filters;
+
+	if (copy_to_user(useraddr, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int bt_ethtool(struct sock *sk, const struct ifreq *ifr,
+		      void __user *useraddr)
+{
+	unsigned int index;
+	u32 ethcmd;
+	int n;
+
+	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
+		return -EFAULT;
+
+	if (sscanf(ifr->ifr_name, "hci%u%n", &index, &n) != 1 ||
+	    n != strlen(ifr->ifr_name))
+		return -ENODEV;
+
+	switch (ethcmd) {
+	case ETHTOOL_GET_TS_INFO:
+		return bt_ethtool_get_ts_info(sk, index, useraddr);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int bt_dev_ioctl(struct socket *sock, unsigned int cmd, void __user *arg)
+{
+	struct sock *sk = sock->sk;
+	struct ifreq ifr = {};
+	void __user *data;
+	char *colon;
+	int ret = -ENOIOCTLCMD;
+
+	if (get_user_ifreq(&ifr, &data, arg))
+		return -EFAULT;
+
+	ifr.ifr_name[IFNAMSIZ - 1] = 0;
+	colon = strchr(ifr.ifr_name, ':');
+	if (colon)
+		*colon = 0;
+
+	switch (cmd) {
+	case SIOCETHTOOL:
+		ret = bt_ethtool(sk, &ifr, data);
+		break;
+	}
+
+	if (colon)
+		*colon = ':';
+
+	if (put_user_ifreq(&ifr, arg))
+		return -EFAULT;
+
+	return ret;
+}
+
 int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct sock *sk = sock->sk;
@@ -595,6 +678,10 @@ int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		err = put_user(amount, (int __user *)arg);
 		break;
 
+	case SIOCETHTOOL:
+		err = bt_dev_ioctl(sock, cmd, (void __user *)arg);
+		break;
+
 	default:
 		err = -ENOIOCTLCMD;
 		break;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 95972fd4c784..55f703076e25 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3186,3 +3186,43 @@ void hci_conn_tx_dequeue(struct hci_conn *conn)
 
 	kfree_skb(skb);
 }
+
+int hci_ethtool_ts_info(unsigned int index, int sk_proto,
+			struct kernel_ethtool_ts_info *info)
+{
+	struct hci_dev *hdev;
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return -ENODEV;
+
+	info->so_timestamping =
+		SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_SOFTWARE |
+		SOF_TIMESTAMPING_OPT_ID |
+		SOF_TIMESTAMPING_OPT_CMSG |
+		SOF_TIMESTAMPING_OPT_TSONLY;
+	info->phc_index = -1;
+	info->tx_types = BIT(HWTSTAMP_TX_OFF);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE);
+
+	switch (sk_proto) {
+	case BTPROTO_ISO:
+		info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE;
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_COMPLETION;
+		break;
+	case BTPROTO_L2CAP:
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_COMPLETION;
+		break;
+	case BTPROTO_SCO:
+		info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE;
+		if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
+			info->so_timestamping |= SOF_TIMESTAMPING_TX_COMPLETION;
+		break;
+	default:
+		info->so_timestamping = 0;
+	}
+
+	hci_dev_put(hdev);
+	return 0;
+}
-- 
2.49.0


