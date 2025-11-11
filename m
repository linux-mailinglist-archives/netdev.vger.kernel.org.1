Return-Path: <netdev+bounces-237749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD65C4FEA8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68EE64E1029
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8433D6E9;
	Tue, 11 Nov 2025 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="D6bjl0ec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F1A2E62A6
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897741; cv=none; b=k6W7laXWPBwo6e0SMZWH5QT/D7s63G3KIaVGOIeI9O2CGBVLovg+V8FDS0iA8NoQwX63PoqQSRsZ9Mqnn/g0HVog47ikNB36Ni4+BuFVHGTP1XPzSbGo8Ya5+/Dm4jqBvZathLJOy45LIIISHgMkfZklfhVxHpG7vjAnPR4lMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897741; c=relaxed/simple;
	bh=l8k7jlJe84hTtqp/6Y8DKyHldyOENZJqRei7U7gKglc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpK8k+Cz5gD7GhNudqgJxq0Op0+AGwQ9iaVjQpY/9Q1SRBwEu1KI5LE9qkhzs3Dy0FGztUB5S4OgzqQMXjc1FeWyF3KRzGJwr8sHRT48V2GLJftedPcTnF8JsKuO3Kl3HXJ57lOD9f8Luj5TUiL6JyqMvX0icpcRLZybqaq4Clw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=D6bjl0ec; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so53679f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1762897737; x=1763502537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0foWyTsUII4+1rBJlCv9h6cj4JGtGa838L/yp3dnqw=;
        b=D6bjl0ec0ExGWyW+W1vmqs43BOBgKqkK2GWTjQXx0lSFmFwL5T2iDXMcQpDiywgMRr
         TnqPmbWPz3CqcyNmKhOcD3O4X/9Hz6t/0D5WCQhT1M6vwbd6pm0niW6x7VhfM0nBGRfq
         7MPHMo5nKR6N1n5SEekF4KC0MOVnAwmcCGJ3+z2X4jaM+UB4x2nb/odVBqAV9hfGev/K
         7m57CkqhbHVJnWa4t6PdUQSdFDzxbn5rJiRg4T2JDisUWAWFEXREtwvJr+aSLxBq//F2
         jcbW6qaehlff1bDUBoxvyx8cjQEHja7e6qZZhMSfXuaUvYp8yncaI+NC2bcIQfUv13Hi
         Yb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897737; x=1763502537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0foWyTsUII4+1rBJlCv9h6cj4JGtGa838L/yp3dnqw=;
        b=OEA0jHTuiAffhJHnBU82p3q27+7s/1bOVWEVfSjEht3b78v0YQQ0m7H+0ZHMC+9oxw
         8fTailjaPuv8y70vAkFB0Nj01rE5BO30KewBMBPUaINfolGLju8KVDP/u4Mvmefrv97X
         eXz/08cAGf1lQyo4qC9fvBzRQineOQk5OsVETUvJLAq8HAx1A0Cb3rpg/i3Pk+6EJOMx
         BvDpC2IMO88Rt71x6m+CjmCMG0j+WeasxL/b3morth0tpptYcLBakefDJaNRWpibGpIx
         0rTsnRYhV7/HPv7cALVmiL/WB6LmME/j6ycwjiirldqjn1VDpMTfUIHj0Z42hinveDCP
         hW2Q==
X-Gm-Message-State: AOJu0Yw71kCKTDULEt5lJGQd4jXGNFN33MbC/nXVu6IV2gCoYVigo2nS
	U9rxTqn11ncjMZhoZ8Y67gYvjEhJclOT9FsPKfhBM3i1HGmfUVfk6QAgJ1P9erwnjAwu8ZsERAi
	q7p89EsiHQ7ZaeFdbnNDUSU/XFRjIAEastLtL0KKs4cdIrwJs19CWdJlicx5Uty1Pke4=
X-Gm-Gg: ASbGncsQa/yIrfVrp0YlEbhpM8aqKAbkVA/+OQhDcuGDKev8sEMGM9rhNT62ibiYkln
	aKFZayCu5NgHh1qotVB14A2I+PogSr7X1ilNe2KIzNs72J1bLRxOsOZ1+Stcd3RvnnmRAJmUnne
	iz4zU/raD2oIzAcSnCsYRH4DQgg9k4oxhUUmwNa/B3rP7xTbfDDumTYKaBN7WD6NjEhMI0kx9rw
	dWh7pyAGYZSNBhIo6gixVarJJ7TDuVo1ImjwetpUbFK6+hgj9VG1sg6885eUkmmkkr18o17fQ9m
	oJw/22AfQoiwsSk4Qu+DUa7RmQtqWIQO1jj9xOFhXu6iTIH0rYXlNO4n2ErjVctcR4vyPse8qyh
	pX6wD9FOoacJWXtSMwsdFUcgbIkeGdm3SIIsVW/JAvfNlBbvjvU9fxvfTgUadjKTho+AX0yLbDr
	cnVFecvp4dbkbFdho+qdLCcg+Z
X-Google-Smtp-Source: AGHT+IGJ6M3wtu5iu3R/0nW3iNvSyGM8B3VD0xTWIFzhBfdFZkCbZ2jSzfIDx1Vz30J8mqTbZTVn4Q==
X-Received: by 2002:a05:6000:2389:b0:411:3c14:3ad9 with SMTP id ffacd0b85a97d-42b4ba7ce40mr677121f8f.21.1762897737336;
        Tue, 11 Nov 2025 13:48:57 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:125b:1047:4c6f:63b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm19478495f8f.0.2025.11.11.13.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:48:56 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 3/8] ovpn: notify userspace on client float event
Date: Tue, 11 Nov 2025 22:47:36 +0100
Message-ID: <20251111214744.12479-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111214744.12479-1-antonio@openvpn.net>
References: <20251111214744.12479-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Send a netlink notification when a client updates its remote UDP
endpoint. The notification includes the new IP address, port, and scope
ID (for IPv6).

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/ovpn.yaml       |  6 ++
 drivers/net/ovpn/netlink.c                  | 81 +++++++++++++++++++++
 drivers/net/ovpn/netlink.h                  |  2 +
 drivers/net/ovpn/peer.c                     |  2 +
 include/uapi/linux/ovpn.h                   |  1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c |  3 +
 6 files changed, 95 insertions(+)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index 1b91045cee2e..0d0c028bf96f 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -502,6 +502,12 @@ operations:
             - ifindex
             - keyconf
 
+    -
+      name: peer-float-ntf
+      doc: Notification about a peer floating (changing its remote UDP endpoint)
+      notify: peer-get
+      mcgrp: peers
+
 mcast-groups:
   list:
     -
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index fed0e46b32a3..c68f09a8c385 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1203,6 +1203,87 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 	return ret;
 }
 
+/**
+ * ovpn_nl_float_peer_notify - notify userspace about peer floating
+ * @peer: the floated peer
+ * @ss: sockaddr representing the new remote endpoint
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
+			      const struct sockaddr_storage *ss)
+{
+	struct ovpn_socket *sock;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa;
+	struct sk_buff *msg;
+	struct nlattr *attr;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0,
+			  OVPN_CMD_PEER_FLOAT_NTF);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex))
+		goto err_cancel_msg;
+
+	attr = nla_nest_start(msg, OVPN_A_PEER);
+	if (!attr)
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	if (ss->ss_family == AF_INET) {
+		sa = (struct sockaddr_in *)ss;
+		if (nla_put_in_addr(msg, OVPN_A_PEER_REMOTE_IPV4,
+				    sa->sin_addr.s_addr) ||
+		    nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT, sa->sin_port))
+			goto err_cancel_msg;
+	} else if (ss->ss_family == AF_INET6) {
+		sa6 = (struct sockaddr_in6 *)ss;
+		if (nla_put_in6_addr(msg, OVPN_A_PEER_REMOTE_IPV6,
+				     &sa6->sin6_addr) ||
+		    nla_put_u32(msg, OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
+				sa6->sin6_scope_id) ||
+		    nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT, sa6->sin6_port))
+			goto err_cancel_msg;
+	} else {
+		goto err_cancel_msg;
+	}
+
+	nla_nest_end(msg, attr);
+	genlmsg_end(msg, hdr);
+
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (!sock) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sk), msg,
+				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return 0;
+
+err_unlock:
+	rcu_read_unlock();
+err_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * ovpn_nl_key_swap_notify - notify userspace peer's key must be renewed
  * @peer: the peer whose key needs to be renewed
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 8615dfc3c472..11ee7c681885 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -13,6 +13,8 @@ int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
 int ovpn_nl_peer_del_notify(struct ovpn_peer *peer);
+int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
+			      const struct sockaddr_storage *ss);
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
 
 #endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 4bfcab0c8652..9ad50f1ac2c3 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -287,6 +287,8 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 
 	spin_unlock_bh(&peer->lock);
 
+	ovpn_nl_peer_float_notify(peer, &ss);
+
 	/* rehashing is required only in MP mode as P2P has one peer
 	 * only and thus there is no hashtable
 	 */
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
index 680d1522dc87..b3c9ff0a6849 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -99,6 +99,7 @@ enum {
 	OVPN_CMD_KEY_SWAP,
 	OVPN_CMD_KEY_SWAP_NTF,
 	OVPN_CMD_KEY_DEL,
+	OVPN_CMD_PEER_FLOAT_NTF,
 
 	__OVPN_CMD_MAX,
 	OVPN_CMD_MAX = (__OVPN_CMD_MAX - 1)
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 0a5226196a2e..064453d16fdd 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1516,6 +1516,9 @@ static int ovpn_handle_msg(struct nl_msg *msg, void *arg)
 	case OVPN_CMD_PEER_DEL_NTF:
 		fprintf(stdout, "received CMD_PEER_DEL_NTF\n");
 		break;
+	case OVPN_CMD_PEER_FLOAT_NTF:
+		fprintf(stdout, "received CMD_PEER_FLOAT_NTF\n");
+		break;
 	case OVPN_CMD_KEY_SWAP_NTF:
 		fprintf(stdout, "received CMD_KEY_SWAP_NTF\n");
 		break;
-- 
2.51.0


