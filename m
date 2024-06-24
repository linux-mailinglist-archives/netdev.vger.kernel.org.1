Return-Path: <netdev+bounces-106091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E86A9148BE
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09CE1C23134
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A95113B582;
	Mon, 24 Jun 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UCVOr6XL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B513CF85
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228618; cv=none; b=VpOSjfKKHS28nYW4BPHvWfQmJAru+WSEH3URa6MP8QiVHLZB6m3ZWJ4eVrnuHRrApTV1sHKSplt3+UF2ZfSZS7iAjAlwsseOuRJIS94wH8ZUHZ/7+leZ2pmNBMSQ6udkCDISurouY4BlVOXjmUFme3YIpeZDpTICKjsnqOomjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228618; c=relaxed/simple;
	bh=j5XAusjRax1iuCwjdiKofEQby095R3D7ttNiemzWcJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/Lr63FLlNRzQFvcbB3I2WcPg6nsC1K+sIB8t8k5mlYEFJJsEjKu81flzthy3ksBiUpWc+ooMUU0M9fXM56D9qVUH/O+gj4rMriu6dpgD73x2zFNkARxItgXf0vx/WpGN/YdV0bP9QCMs4FBq2nYD9JcJQZiA1L6XAlfkxIrIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UCVOr6XL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so34864255e9.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228614; x=1719833414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3b++0o2zeo7j8XA/ACPyrgM0jt8ZvTJqquIvVRViuc=;
        b=UCVOr6XLsxp+fhIebBOhA/RxqrJVaPFwU9OqvyXl3aHMmQSQKm0FEHFH8vtl7W3VvM
         5dcv4iDE9O/f36QzBf4Y+Q/yoQL/HMV98895T8Mixq0kjBG5uO+pteIOYk30e8rSw8fT
         hqwT/yazePDgvJfn9oaqxIugKEW1HH4RyrZ9rDDpZnY5jJzSaiNbofig/+HqcV/K4MLM
         5RujOJUviZAVy/9Gbz28TMSr0rLyR3Dlgk0F5L42iwXaSougPqAiUg6S8EI+fJJt92P0
         oRycOyDCUOvflVF3+URFqLfK3hNskrJtkYbsbJIKc8urPfH80tu/TE53KCDErD/kVVyc
         myKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228614; x=1719833414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3b++0o2zeo7j8XA/ACPyrgM0jt8ZvTJqquIvVRViuc=;
        b=OKDDyXtbbuNqC3SC6j4nyGlVALQiBB06qB0+bfXgBCPXHP/texSGVM533g9FgqNld2
         /vv/I/EIF1uX0hpcHieb8dE4q5DySUBob6POsTnI6HPzC2q2aOZqfY0WVocZRcd5PKVs
         xl3Y87Xe0UvVq4mIl2/ULjMoFPgXjzrzHpT359euTmtSrPDsBiAFkhX+VnwmRn1WGFYr
         JZeJEMePfUqJPosY9GCRK5/FU/1+xhN+43HGNmvzKLfze3JI65KOF64bOiKFWX4xlHP9
         2rZKNOYtC6DIgzZpH4czM5s4DpU8hVamaItnMFflJ8XKMasS4j01NcvuDSSCVI06AYcq
         fdvg==
X-Gm-Message-State: AOJu0YyunKevO+uo1/pxAtUQPEy6ZLC3XwrdP8OWc41InUpfIFa9aXXF
	dw4aSEQkM3KV0Mxn2iBA953q+ycYJiXV2O0IyShmxvv0lLGg7Lf5E9ZnhvqMsAlX5o9MhBhBFda
	M
X-Google-Smtp-Source: AGHT+IErpM/dI8AqFQmrJ8EeElsc9j1hW9p2dlEMfD0dCKUBXRowg6m/fJNT5ysD+Dae9eS6mEHL/w==
X-Received: by 2002:a05:600c:4254:b0:41b:e0e5:a525 with SMTP id 5b1f17b1804b1-4248cc348bdmr30574195e9.17.1719228614361;
        Mon, 24 Jun 2024 04:30:14 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:14 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 22/25] ovpn: kill key and notify userspace in case of IV exhaustion
Date: Mon, 24 Jun 2024 13:31:19 +0200
Message-ID: <20240624113122.12732-23-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IV wrap-around is cryptographically dangerous for a number of ciphers,
therefore kill the key and inform userspace (via netlink) should the
IV space go exhausted.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 39 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 2e238197d7bc..0cee957e6558 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -846,6 +846,45 @@ int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer)
+{
+	struct sk_buff *msg;
+	void *hdr;
+	int ret;
+
+	netdev_info(peer->ovpn->dev, "peer with id %u must rekey - primary key unusable.\n",
+		    peer->id);
+
+	msg = nlmsg_new(100, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0, OVPN_CMD_SWAP_KEYS);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex))
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
+				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * ovpn_nl_register - perform any needed registration in the NL subsustem
  */
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 9e87cf11d1e9..c86cd102eeef 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,4 +12,12 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+/**
+ * ovpn_nl_notify_swap_keys - notify userspace peer's key must be renewed
+ * @peer: the peer whose key needs to be renewed
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer);
+
 #endif /* _NET_OVPN_NETLINK_H_ */
-- 
2.44.2


