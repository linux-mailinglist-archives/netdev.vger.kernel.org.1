Return-Path: <netdev+bounces-186311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D9A9E2B2
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 13:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515C33B2CCF
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 11:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1541FAC4E;
	Sun, 27 Apr 2025 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dhoKF9xP"
X-Original-To: netdev@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E91ABEC5;
	Sun, 27 Apr 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745753264; cv=pass; b=LeHlj0s0wAB55j6qjBpsUMpkK0AyaGpBGscx75ryIP5sK0b93kcLcEoqjNuAtndL55O0XP9FmzJkf6zwluvG4fJLErx3MygSd09nNH1qnY3vmhmwlh28X7x1p9tLwriWwyEe3UnNeXKgydeSKkeTnGvqu9OudqgjF7KVu+FNn9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745753264; c=relaxed/simple;
	bh=fUKt/We2zVZjSJfEQjeZ+KVbE/071SlD+D3Ahcy6w5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZAKtMahh6tkjcJE8g5IRy4Aeju9h+TghrvUXKKpwPGj2cGmGXr5O9RC+dA28/nPZQ0hKNOIqOuYEiehf6X7iOoAkjklkakCx4RS7skv/0wthBCq4Jt5u3RpEvrWC0LhsobHVL5eCMK8p+ftrSOWAjCqcETLGaCkGGw0nVCo+H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dhoKF9xP; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zlknt094nzyQD;
	Sun, 27 Apr 2025 14:27:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1745753251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ESJ98B5Xbm36wHQBKf3qWmAPeJxbmwPHcvqZfxcxP8=;
	b=dhoKF9xPbxpqcvUcux9oM0nIAFC+HaVsp9ipUXa0vW93oFsBGo0x2dgbs/PgOH+co6Pap3
	C0Z7I4X1Na6dwXA4B1ylgqRA0immE8dLRgL00MA+Cooe/MxJYDBVNC9MCZnAkc9GRrjhyy
	N1mWxyBwIS6ZvMfHWXFxMrRSNGHSog0=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1745753251; a=rsa-sha256; cv=none;
	b=a4xZUa1dsE783aDkT7aBbBCze2Rby1GH4lzLt0OVF3F5hVDfKuWyTrvAINiGQoGBeBdq18
	8dXdpZmGdhdAfa3/4qrUbk/ab2rkjNpOGLyyrJwEqquawX/AOk/Mnk1NaMhwQi1iFhsRp7
	qUflCZpD9QND4V01sXVH9LDL41TS+g4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1745753251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ESJ98B5Xbm36wHQBKf3qWmAPeJxbmwPHcvqZfxcxP8=;
	b=X0EyRaji1UW16lFegXcskLXB1ve+4eGJkeFURqzyqSXuBtKwVqE9IwEs8RkerRPLq8XS5l
	IPFdRtN9J0Nvr6GPXCi3bMl26ad5M6kI2BpelMgwR9F1DSJpC8Uqd3R13oRDhTI+RcF93o
	DzbWsfJufUaxfmPKhHRP38umw3KL4BY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	kerneljasonxing@gmail.com,
	andrew@lunn.ch,
	luiz.dentz@gmail.com,
	kuba@kernel.org
Subject: [PATCH v2] Bluetooth: add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
Date: Sun, 27 Apr 2025 14:27:25 +0300
Message-ID: <20867a4e60802de191bfb1010f55021569f4fb01.1745751821.git.pav@iki.fi>
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
slightly from netdev in that the result depends also on socket type.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Another option could be a new socket option, not sure what would be best
    here. Using SIOCETHTOOL may not be that great since the 'ethtool'
    program can't query these as the net_device doesn't actually exist.

    Tests: https://lore.kernel.org/linux-bluetooth/fb7b09305a729369d1755569d4e7bdda48d94327.1745751513.git.pav@iki.fi/
    
    v2:
    - don't advertise *_OPT_* which are supposed always available
    - advertise RX_SOFTWARE for all
      (L2CAP missing RX tstamps was a bug in l2cap_core.c, fixed in another
      patch)

 include/net/bluetooth/bluetooth.h |  4 ++
 net/bluetooth/af_bluetooth.c      | 87 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_conn.c          | 33 ++++++++++++
 3 files changed, 124 insertions(+)

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
index 08e060669c2b..d8f6aaf14703 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3025,3 +3025,36 @@ void hci_conn_tx_dequeue(struct hci_conn *conn)
 
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
+		SOF_TIMESTAMPING_RX_SOFTWARE |
+		SOF_TIMESTAMPING_SOFTWARE;
+	info->phc_index = -1;
+	info->tx_types = BIT(HWTSTAMP_TX_OFF);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE);
+
+	switch (sk_proto) {
+	case BTPROTO_ISO:
+	case BTPROTO_L2CAP:
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_COMPLETION;
+		break;
+	case BTPROTO_SCO:
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
+		if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
+			info->so_timestamping |= SOF_TIMESTAMPING_TX_COMPLETION;
+		break;
+	}
+
+	hci_dev_put(hdev);
+	return 0;
+}
-- 
2.49.0


