Return-Path: <netdev+bounces-267597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFu8Fvl4tGmOogAAu9opvQ
	(envelope-from <netdev+bounces-267597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:52:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D66E289E81
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8B5E3065729
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B837F8DB;
	Fri, 13 Mar 2026 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="O7krN0Xf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB937F8B7
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435116; cv=none; b=ISh7GgjmVDrc41lUBVsA95tO/5LpYBkVcfcQltfPb7q2JGNkrItNEBaG+PYAPdkdN0zlkJnyWAS4xVH1AwfCioRmOUKU04qyGTaVWA/2VvFWTUlgov/KjCi+muV3cfYLXenJniD6wg+eq1iT/9OsFB5JKNFvcXGwY3tdqYoEZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435116; c=relaxed/simple;
	bh=JSJGJMK6KyufJ/PXMyD+v1i6aM7TmhBZWN5SubcrK5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSwZyehgGOvQCQnkSK9HIx+9aFKXjjnWT1WnW2xoALO2CzFWHD2dPYIzWxQMFcShypg4KqCBiIg4z7ksdzABa9eu7q1L4Y9JqzgS0WbGmZYzewoRi+nhAy8rcEuxWq3LS/LGWotncyEQ0usDjgwfHuK44mSkiMvMI+wtbpFAKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=O7krN0Xf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so2167840f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773435113; x=1774039913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqDo5H8oLMcH1+Hu7RTzP1KSiSjs6M89cDFS4JLvEmU=;
        b=O7krN0XfO9I9oI9RIKVFHpCgE/lhX5Wyr4Jl0kR5cPwJIt5zSTOQERZQc4bV4eaKpW
         T78du3acAL0Mw1fM53lRtHmkIOjjbtW+ts/coaq8rrmY8K/Akb3Q+PI/s9AhsA/p7d+z
         AbAqwKtouqxEECYDD2f06EcjZ8REjpzpE0ZwaoRx1y9++to5wxD+PprIYpyB43FdoyG1
         GH0PNYzAXNDLL5SBHYhEwB4hl1Ix0CyzQGB8om9EhquIK67oGvB3GmJbSM/hfNUkMcS1
         cjvjlZBhkM974WvwywjmSUhKaRWhbwbGCfIxjq4wOo1eVoTjCUD0rQ5yn4bhQEM4x7wV
         1qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435113; x=1774039913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qqDo5H8oLMcH1+Hu7RTzP1KSiSjs6M89cDFS4JLvEmU=;
        b=rlAcgUeD/onD4/nWKkdumZ2FtLgeu5SClmDekhhNgQaewRedYRGGT0IOOpkNJn+FJo
         7jqx3lUTz+xjW7nJd0BDUr5FiDBBp97gIKJab3ayJZB+ezrAV3LUk5BH3OgkeClPUWHQ
         JP3NjZOcUFWnLk73DmxqFy/ta6CW6jdajd/tMZpucZiYn7zCECu+QKgTB1FIqF9/Ieqz
         4T3ner/BAPQGuH3EFXXB/88No0XoMED754bK9WRDWiM7AabMaLNBYh/uP2WVDA1OlFmj
         PdaBsMaiDJK+Z7tZb450pWUk0HD6uBHnz9NyUIO2YXcKwxN6eTc5D1JSjuxoqedy9t1p
         Eq7w==
X-Gm-Message-State: AOJu0YzHZZCivaDoo3GJ1uD9vSM/Gt97U8OrSSqcRe6lws8XDPSLbxlm
	VX4zjkYc5ipy0hlzzI5Nup6KDKoRWqc2vsIcxJps9S0xntbckCM4wUMr7st7EZiNZ66htYn6RA3
	sKLMHJDKBJlX5e3eOBh04IN+RUPRXcsDFEInSPHlqAnXUtRC1SsBC+39TNjA9hNBm
X-Gm-Gg: ATEYQzwF53sT91lmJeBuhJcFgo8yezhguu2zZYRj/hCu1DgX3rd/OkwOdSmm59WdzU3
	PPNoPVCswc/KnmgZkXGtYMDpuIPKYdTqBNDUHN72BQ+yNQPfuY2BNIj7Nh+wdRL3BkmkZh12RVq
	FXKGv8dVbSjnMRZVv5yeQyGd7od0fWRucaASOpJdEE30TZHPP7Vwt11EQXYxf90dOvKqNaFXSjF
	uUFqAS0qG3uUVn2HKkfPmd4tboLD2EhBysm5IOWFOFWLK2EiwzeAC6xNrBvEIkIy1z6dMfuQOjc
	e74I01iYCBigp1SzSxN/dDoTbHl3Dfpsl+WglnpZgibZOQW9qCa3jOGuolQJE0lzSp1Fqrn6Kge
	UTRzr6HNwE5V0pzcXRIwPa6T2ggux4eqUYgn6lsKh+0ZFbLqVXtu8rOExOjl/8r7fGEd4g1InBS
	7RIx6o4ycWMxXNFr+++pQk9zgDlxUNDddVdUzH
X-Received: by 2002:a05:600c:4f8b:b0:485:3e6c:aa84 with SMTP id 5b1f17b1804b1-4855670f7d3mr72917395e9.33.1773435112935;
        Fri, 13 Mar 2026 13:51:52 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:9684:4355:e76d:6ae9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273d9sm23120468f8f.34.2026.03.13.13.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:51:52 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
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
Date: Fri, 13 Mar 2026 21:51:34 +0100
Message-ID: <20260313205139.2950-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313205139.2950-1-antonio@openvpn.net>
References: <20260313205139.2950-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mandelbit.com,queasysnail.net,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,vger.kernel.org,gmail.com,openvpn.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267597-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D66E289E81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


