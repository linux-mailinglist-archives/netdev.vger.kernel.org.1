Return-Path: <netdev+bounces-262009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG8FO8wwomke0wQAu9opvQ
	(envelope-from <netdev+bounces-262009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:03:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 688251BF4DE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F149F31804C9
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717A8287510;
	Sat, 28 Feb 2026 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fUKJOROg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732332F5487
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236821; cv=none; b=ttuthKRnJs7/qfCtK6d79RO/ftO91rXcMzdBN09CHbZnBNMwcIdLdSdk/GXjE9HHPjgqoOJyD1fXS7sqCBaJlAKIk7ylryJSbtKS+uQ8M8cadjCsVD0hag3ivT4nQ8wUHl106J0laABeS0a8ZrhhZ/bjWEmbX6MG+ZPAOQ1oqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236821; c=relaxed/simple;
	bh=nljfU8OP/5VpPx8YusG0pIsZ+91Lig1SAg84NEBbVgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gux3DOJtxjlITwb2mc5+FO1QNcRRKDGKNV7cxcYN5s4A26S016z8xs0dXAEA7AQZFpCUioCueRE2/UzXU9qg1BgbqCjUEb2cyZQPYodymDDf1XIGfgvnZ2u73Xc2vPOySuub3//UpUJEssIFRhjhDdkhlZovwI0OP0zS+YK0lyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fUKJOROg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4837634de51so11397985e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772236817; x=1772841617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y106sHw9m3Ij0wnY8RP7cA4/iAHk8CqLB3Cs/Cucy1w=;
        b=fUKJOROgL3q6xx050S/zuenlnMzpn7J74O1TLZ0oFM9vilSnVGR1z43PCIhrzdrZQ5
         mnvuVspHIIfuEarY2kg4/WCo26TZyiZ5mKKmTtEvuGV7Yn4ZVnSY79p6H4Fq69ntrA/D
         gLpzZBXDSP79ndMyLm7YcllDXs77WUluewdDjclbvJGkydTv8ojMLuCKPDi9Sm13oq1F
         oLTzQxagzmKZhru20+1crgOY+WqMx1Ki+9XwGaxVWPabsdu6bN4IuMI94KNj/VzBTrKT
         VqgjZSK46yME7MyafGrT9qrORt8V5x6suFGIsjSJXIKfLRxdSejGpx2TJmsXjYmcOPVh
         USNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236817; x=1772841617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y106sHw9m3Ij0wnY8RP7cA4/iAHk8CqLB3Cs/Cucy1w=;
        b=PbNhQtzVKECRiceKdi/qKbjWEVFxHQdpoADVwQP6ECmSpK7V6EJIsuoeptnzt5IKUP
         oVR7PD/wNNFsR8GWU4v5WwZe7Zy3y35+UOjMnUwp3GBusf4p8QkhAijsMbnv1MVex/Xy
         YS/P/1cplbZ1JWKDkhud92JfYr1ApIoiyzT38UY+R49L/XSMI8MhoFQdKvni0pkEs3Pg
         JR3kzljX/rEZ15tidyZKXIhDStNeYCa7oBn/AANyv/horLfIGygWEuD/csquwvAxaxT0
         ahph1GHnVID+NEUcsXQGV+Wm1pRrSuF0+kICkFTPq37j0kyklwUqhNjaUikFsEhuUoQG
         Luyg==
X-Gm-Message-State: AOJu0YwrVCKj546mMNld9eKzXh3oB4GnWcH5n/ES35kYmvngICoEjFr5
	S7xFNQdmv/XLGaomel1FdBrxvvBhBlGsoYFK+GfWiV3vjdPsj6N492S5+Pn7qU7TFawDvnXP5Ag
	H11IIJmkbCPL7L0AEUORpmBbX/szAA7PBhvgjRPf2AvmCmd4WcSoLpyxxGWFALrrH
X-Gm-Gg: ATEYQzyo/QNgfFp2FiPI1oz+MVZi0aIVsvjpaUYBQR2HLymalf3/15Uz8FeW8vxTXqk
	qjQjGFL+2zUYt7c2K3cw45KAZ+WTtUuDANZxRRT6Il3IdUn1W7MmElo/Z3/wuc6LcTF33aEhayO
	EeoHACzkQ7sK0e7dRRimbjh3xS/bBoNgQEVbJrKnVPqFNgt1EdLm4ZJklDdkIlHtPi4yj0Apk/i
	wI/6c4kSJplTzgarZgHnpI/7FZoeIlIpGzS2QU994N6CAjeijp4vkPODv+foAbMvsrLyXkyZ3ey
	0wCJ3buAMtFjQPdTwEm1qAZFuiHu2fDIol8HRNt7L2GbZeIil9Wk/9Th1m6gsunIo3RUMN4984q
	7FeM3kstJGaqXdV3xLv5VO89eG8O0cwtWJRTPWTDnGPF2c85rRba1MSVwjMNQLIbiPlp5Uxmoy7
	qjjvho67ZOXzdgIQFfMAh+K3D+qx0cRXUh2+Hi
X-Received: by 2002:a05:600c:1d0e:b0:480:3bba:1cac with SMTP id 5b1f17b1804b1-483c9bc55c0mr70065245e9.6.1772236817540;
        Fri, 27 Feb 2026 16:00:17 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:d378:d869:cb10:1603])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm94420695e9.5.2026.02.27.16.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:00:15 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 4/9] ovpn: notify userspace on client float event
Date: Sat, 28 Feb 2026 00:59:50 +0100
Message-ID: <20260227235955.660-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227235955.660-1-antonio@openvpn.net>
References: <20260227235955.660-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262009-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:mid,openvpn.net:dkim,openvpn.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Queue-Id: 688251BF4DE
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

Send a netlink notification when a client updates its remote UDP
endpoint. The notification includes the new IP address, port, and scope
ID (for IPv6).

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


