Return-Path: <netdev+bounces-264081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FRQMOC7qGlbwwAAu9opvQ
	(envelope-from <netdev+bounces-264081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:10:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3E9208E01
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C6F30F29CA
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E9388364;
	Wed,  4 Mar 2026 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YFj5O11n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40C3859C8
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665626; cv=none; b=JRg9DThR869U3Elew6LDcDZXUrkWg5FQBleYY2ufif5TPFpye3vMOFUDPdKvx/Ju2RnQpdjTsyaMTFvkaMaPAmsE/8uamsPHiXz1XkVjg7AwpHpeqkmCV1a+Z3jyplTs2nbnuVff59FjtJUALiWB4ebIg9BiaUv1evHYdaatWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665626; c=relaxed/simple;
	bh=JSJGJMK6KyufJ/PXMyD+v1i6aM7TmhBZWN5SubcrK5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjW6tpo1cbebpHYgIC9R0oQTIPyumFV0CzWLeC5S/D0+6pmiHalNzftOGfTLSV5q7iCrDNLdT59asMTfPaeZUlAexYy+AuqAj26Wu03xqxDRwFKFvCr1DB9XvUhSXq5I0bjXjP43zkd+Tbub5wBE8dEDHltZRbC1VtftKmQ39Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YFj5O11n; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4833115090dso75494125e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772665623; x=1773270423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqDo5H8oLMcH1+Hu7RTzP1KSiSjs6M89cDFS4JLvEmU=;
        b=YFj5O11nXRQdTcBfUeNN93PqM9B9nptsAz9IsfVP0xYOBskVKh0tchoS0LE8yQSXp8
         ar8ILnYT++F7SgLKxUNPu1iFz/4lE9aa6wHL96OtWDhaOT4XTyf5+F6b+SXrncUujxAM
         5XN3O2bq8o4elgfbdaIFn2ME/Vll4cWSS3iT6bmmOPDsJiyjY7fJtKJyTfNYyKxlIK8P
         HzN6mx1q6768IFddQP0PJZN55XUz3itvjOM+lKbjna4RaWsZyFP48v3gtOvzEyPY2iFY
         asEFsIvLLVzxogafP25yY/OPcI+lx8cfprU5mUfJAgfInwyBYD4q8veqEI5iyZaySQVX
         Ja1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772665623; x=1773270423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qqDo5H8oLMcH1+Hu7RTzP1KSiSjs6M89cDFS4JLvEmU=;
        b=EYql8GuHrNnOAVRzQZGysAxZzhN6Vm0msl++9ZdxQFlZvuTlY6DPU9wbvfJbwyvD4w
         Nlgpb5aZxnhyDAtoA1K1437/ubEB300ziWF+TR7fdYFfePniGoXPC5NAqTdy6cHyyU5p
         FAK0irQvU9qAoZyk2OkAJAQN0yfNa+de/oVDeYexdff4HrM30LUETV9ErlR9nf1/wrXA
         SAk9LhiXgAumltlVYADsh1rnSqnRfCTfAfUZupuOC0cp8JiNyJZT5JxMvrgSL16LS2ol
         i/fVrBQx8pTi5yDl6URNL1ApueOB10Ntw+UnQAXMBLWMi9JheHE5Y+fAE5VzUtHNKjcb
         cAtw==
X-Gm-Message-State: AOJu0YwwriY6Y6Rrju8ImUYzkhAUwQEkZorLVeQINMIOZtN7Ucqv8C/p
	YBIKqdzPiS02pgWPoH4mZ2waf2sbuZGePiaKL5W+n9piie47ReLGELTOBSsuCH0bTboLXXRHfRn
	RjGHCmDb34qxhKCp7vTZL11FnixQeOqGeJLfWvGIICb7rAY1RYXAaRXyd8PihAE0Y
X-Gm-Gg: ATEYQzwxWXbHDo07xTAJDbyVkNUyJRG3pOg7MBcsflB+5nI9JaetCeF3XYopQJmAvxO
	gWuWq+Y2QuKr1KAUk80d6gd2ihyER8YGVPTtepXxbRxB8wPlN1VD9QEMWWy8kiKPSfn7ENDt5Z4
	KH2tmlFM/55zds4jzYXDNoeS7XUoeEOLG34ym0RoRCLMR1q5Rx7F0cJy4biGlhBhEkA0l8MkKFx
	rI7XSTx7BoAnbwF6DFDSoxgxl3s4GBIw0jIEo80XBWmDHbraTrKCswEe0+0tpO/mX0m2g4PezVE
	8UJnlDvnT3cYrQafJoYB2/IK4O0iWpDA6xObYyKD7ymRHB6zdEgJKdbBbp6MpuUQJ5jIlbG+8XR
	+r9xxuv8/eYvfJge32fgI20NIOp1R/K0zCsaM87QBuKCQxJaO2P/uXr2G0rSPMu5nxgVKPYHjjH
	ORrytXy0RfyIGEvmuA4x6iB/SexOVWcqQmwWU=
X-Received: by 2002:a05:600c:4503:b0:483:7783:5363 with SMTP id 5b1f17b1804b1-48519897036mr60278875e9.26.1772665622819;
        Wed, 04 Mar 2026 15:07:02 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:880:4d86:fc53:5d46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187caf9fsm87713475e9.7.2026.03.04.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:07:01 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-kselftest@vger.kernel.org,
	horms@kernel.org,
	shuah@kernel.org,
	donald.hunter@gmail.com,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 4/9] ovpn: notify userspace on client float event
Date: Thu,  5 Mar 2026 00:06:22 +0100
Message-ID: <20260304230643.1014-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304230643.1014-1-antonio@openvpn.net>
References: <20260304230643.1014-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D3E9208E01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mandelbit.com,queasysnail.net,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,vger.kernel.org,gmail.com,openvpn.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264081-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,queasysnail.net:email]
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

Send a netlink notification when a client updates its remote UDP
endpoint. The notification includes the new IP address, port, and scope
ID (for IPv6).

Cc: linux-kselftest@vger.kernel.org
Cc: horms@kernel.org
Cc: shuah@kernel.org
Cc: donald.hunter@gmail.com
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 Documentation/netlink/specs/ovpn.yaml       |  6 ++
 drivers/net/ovpn/netlink.c                  | 82 +++++++++++++++++++++
 drivers/net/ovpn/netlink.h                  |  2 +
 drivers/net/ovpn/peer.c                     |  2 +
 include/uapi/linux/ovpn.h                   |  1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c |  3 +
 6 files changed, 96 insertions(+)

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
index fed0e46b32a3..e10d7f9a28f5 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1203,6 +1203,88 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 	return ret;
 }
 
+/**
+ * ovpn_nl_peer_float_notify - notify userspace about peer floating
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
+		ret = -EAFNOSUPPORT;
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
index 3716a1d82801..4e145b4497e6 100644
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
index 959b41def61f..0cce0d58b830 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -100,6 +100,7 @@ enum {
 	OVPN_CMD_KEY_SWAP,
 	OVPN_CMD_KEY_SWAP_NTF,
 	OVPN_CMD_KEY_DEL,
+	OVPN_CMD_PEER_FLOAT_NTF,
 
 	__OVPN_CMD_MAX,
 	OVPN_CMD_MAX = (__OVPN_CMD_MAX - 1)
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 0f3babf19fd0..7178abae1b2f 100644
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
2.52.0


