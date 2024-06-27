Return-Path: <netdev+bounces-107282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E97491A760
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4D11F2457D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4255218E772;
	Thu, 27 Jun 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MWHnrJqH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8A18E746
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493703; cv=none; b=Nuv1X1zoVzTohabrzzcdnBiheLpC+pAWWcXOTro9XV+XbIecyusxFlL6PCJBX2nqncu+KMyAYE15badxKCoJ8sFS4+wb4EJY2RkoVfYh1q86oDJqTN0feKkpwZ5V4jneZC/MIpkHmpkgWFP5xwhn4zhLURLPmjVr+OjCPC60ztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493703; c=relaxed/simple;
	bh=7fIV2zEgKVN75zeEZo5LlizVD++tJXVH5invdwXCoWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAV/BOpfZZvEkJwqe6spfDiG8GEKDjTTuM8wQWxvpUtMBX6+ZYovAoxKAyGC70GCvlG4aNA/FivLx+flOyYJ4PYZ0fzj6br3q0oBNkSSTfd5yHXRF27nyyfGw0oVZEwYlP52mBgjBNgEr25ijvVKULG+qFqQn9kF9EjTYlbg6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MWHnrJqH; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec002caeb3so100771721fa.2
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493699; x=1720098499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpOb2gL00XN5DO7dss6m3Ytfli+Au0vl0wqM74pOk1A=;
        b=MWHnrJqHA3H4sltyOazBcBtVs3db2Fb1xArOKF1CkEyIKe7X05jD5KjKzsQ1YfZRO7
         XZWlXIZvpZBjsB6+lSLuxUL6eQ8eHN7363rApYHAiqUvPkjEY7EYBy8AHq5TVPty7DLy
         75G5owoNHvvgh7goe4y94Tt9m4v2C+ptZc7gRllgGfUF3j3043iDg7kPWC+4rBLMh74A
         8zM3jOxvXIhm9VRUyD1YGpvtoYtTBq0+hOpzBe//dyRHTA/b1A1DDuTqlrW66dbxE7M8
         EmGznH7XOdu3JAvni83zKRoTOUvZCx9eAq4I6yp4xc6LcrRQ4KgoUKrz0lnlMYriCjC5
         eZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493699; x=1720098499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpOb2gL00XN5DO7dss6m3Ytfli+Au0vl0wqM74pOk1A=;
        b=t88EY38YolPDFm1Z2jq6XyQEw/Z77YXu9nrHicXLh3HGqMjPgYGigaTGe+TfY01hBz
         ZOTkhq7cAQWCoAxJHwgsw3ivpORyxyxiofujphYs+qEjv5WAHj61mHYuJkti0dHCRahi
         8dj5RqBSTFnZnwLi2Hk3992NTVpfryo1bEsd0ONDJHiCW5YjehxC6uo0cvFALZOttDJJ
         sr1/MVVtEyKtbK4Z8uRqQvtNZ0a6H/gBRDy8+1lzEd4m1hkLHDTXGgzliXn5Qt2kBnkR
         u2O3lNJoboXOxAAyA0o3RNXvPFBRvmHBtbjuSj7KYPodyYW4xD8u3XgQ1hFrIMNFyJtD
         8mQA==
X-Gm-Message-State: AOJu0YyKsMNsKBFEj3xyqF9Tsp422mYbB/SBQSmgx7x0K50jxEYd7Y6o
	+YjWiEeDyPnxKEhHAI0/uXZ1blbHy8Ht1+/N+4jtqyv1dP+oW8N7fkPWzmOUORYzNiA9gztxG0W
	z
X-Google-Smtp-Source: AGHT+IFOgfnOGl50Ca8MirflvnCCpyFUtZ1ycHXge/3GfwkG+iWYlaxPiTF4eXzmAhHCsyDGvQM89w==
X-Received: by 2002:a2e:a378:0:b0:2ec:5c94:3d99 with SMTP id 38308e7fff4ca-2ec5c944160mr77467491fa.2.1719493699371;
        Thu, 27 Jun 2024 06:08:19 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:08:19 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v5 22/25] ovpn: kill key and notify userspace in case of IV exhaustion
Date: Thu, 27 Jun 2024 15:08:40 +0200
Message-ID: <20240627130843.21042-23-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627130843.21042-1-antonio@openvpn.net>
References: <20240627130843.21042-1-antonio@openvpn.net>
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
index 31c58cda6a3d..e43bbc9ad5d2 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -846,6 +846,45 @@ int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer)
+{
+	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
+	void *hdr;
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
  *
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


