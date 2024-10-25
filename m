Return-Path: <netdev+bounces-139050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4319AFE07
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACD628626B
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A1206E6E;
	Fri, 25 Oct 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SXF1oW7H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C7206949
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847731; cv=none; b=Mx8JmkM1rFn41OOFTO171Y2n35/m07Y/t7SaYldrjm5oB9drC3Dy3YB5HDdqPUdcNLk7IHp1YbWU2XeUXwweBDTFUHgz9uxv3Fr+lNYzwqA0ZaJPsAR3E05BYlEh7yHraA2pIFD+C11NxlesF6OKNbOJx32gQacgOz0UWtnjPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847731; c=relaxed/simple;
	bh=AzIDOSUkaDPNX63bsZvcEQktPafnVpTeTaD2rfmd2so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFSE2Op4Bb1S69eGxap2GsP3wxulv8bCylKiJoR/rt73cUFzk4b70c6t+nTWjHoLKIFmcizUU4WQK55E0kPun1x91JGBV4bGD0XFL8kTrPFxS7bz8d5DhUghWNQhKiJC3NSnynUaY4cZ1e+V1jz4tKH0sFbfVwWQ76uYQk/hf5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SXF1oW7H; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so18885535e9.1
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847725; x=1730452525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HE7a3/0ck94n809ggeYYpm0YGkDJyT0BmHOqLaQj8no=;
        b=SXF1oW7H2OkH9DbAtki7vxptp9gLQngEEeg4Vub/2bRtyGs0V4mSXyzqtTkG3Obxmb
         U2zhRj7o787DgDACzEPX20KXpCQxZ3NkrbmhvulGweq8hkbbR2itg5v7Lw+AO2zoEnMA
         W+Fy/dx7g3c9030WK/eRWamUUONvHBCUsXoLTS+ZCyR8BvVU1fugCRapFpL/1pYAgd6M
         X0WLU9f+u+83NAVGN6Ocz1bB5CgKdIaLVYauivyyEq2gpXiuD999y84EBck+j7tWLAfR
         wbMSGym56021wWEYEPsHobbhc9GLdPxA+jRkMXlO6Ht+BVcIhZF1L62CAhrB+qWkLb2s
         kwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847725; x=1730452525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE7a3/0ck94n809ggeYYpm0YGkDJyT0BmHOqLaQj8no=;
        b=QwVDQ+i6xInCgVYKFqfiPi8W6Pilnhkx9NzstDBFz0THj8Rz4IUOEgDqlzRCSUaZrW
         DUEwm0izsCBjkAKN/5b+iAiFEavb06UbAaz7KLJnSeYJn3eLvxt+vbgUfQf/5ypvFIpi
         Nscsi+AMPXW8rWQWM0UznJe94RJXlQnK1RiSmfGpUmDZj/Mk599mSvWOc2evmbek/981
         hTnu8pn6zMNumEGFKftx+iLiDwVn03YdJ7M2iOAQtOoHmXWrErRFslLc83T+3gdYWjdK
         MVcoVmBRqjjjw+KlZ+7fZ9Cxhl91nrrfXyRvM36Xe6pFlIKS7MH+aYSFMhAd8wnyRwAJ
         Hsaw==
X-Gm-Message-State: AOJu0YyxLrduvtBWre9rwozjrfNrqCtXEralF9qBfXztNFBO1cd2ARW7
	9UuiJkboCQCtWFdCZWWOOz9mhEWBJijZXGVKHl2sCBJFsHqpxxVsbDf2c7mf2Bs=
X-Google-Smtp-Source: AGHT+IGS6M4QtU/1eozXYwUGRg6O3N98SCRuKllxDYeV4sbQJYRPJpqnjdjdAj9p9Wu3SwXZzeKe4Q==
X-Received: by 2002:a05:600c:1d11:b0:431:46fe:4cc1 with SMTP id 5b1f17b1804b1-4318c6f14ecmr44875065e9.10.1729847724920;
        Fri, 25 Oct 2024 02:15:24 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:15:23 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:20 +0200
Subject: [PATCH net-next v10 21/23] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-21-b87530777be7@openvpn.net>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
In-Reply-To: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3254; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=AzIDOSUkaDPNX63bsZvcEQktPafnVpTeTaD2rfmd2so=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2GbQfIzywdx73kts68lqL5vFZscLj7whP+7R
 alMtMUDxjCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthmwAKCRALcOU6oDjV
 h5DEB/4qyhwjliiZFNve3TSusPqHaS17r7Fi7JfsHQzdy9zIhzKsV4DOu+tNEr5Q21tRNahvIaj
 UEnE8m0hxHLAykTNqlJ9Xrrio6wjH3q0eMwM8mLeTbuMDItXGsZ/hexVrIfeZm25RF6lD9bmn4d
 EWBVKW4Hn/4sSh1HJSilW593mx0WYXGjUAhwhMSwUDpBUIRm+EVx6GXuT5hrZYlyOAe0ZFmbbID
 ta4V0kzQ/bIUGGD6jJexxp3oAXQY0+koQjuT++MrWBbK9TTXI2KilXHMc7idNqgf+BdBxLAgOKs
 KlcOFZZuZft0NWCQJbo7c2xtrAQtk0ERdgkcYRZC40LFqF30
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Whenever a peer is deleted, send a notification to userspace so that it
can react accordingly.

This is most important when a peer is deleted due to ping timeout,
because it all happens in kernelspace and thus userspace has no direct
way to learn about it.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  1 +
 drivers/net/ovpn/peer.c    |  1 +
 3 files changed, 57 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 2b2ba1a810a0e87fb9ffb43b988fa52725a9589b..4d7d835cb47fd1f03d7cdafa2eda9f03065b8024 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -999,6 +999,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+/**
+ * ovpn_nl_peer_del_notify - notify userspace about peer being deleted
+ * @peer: the peer being deleted
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
+{
+	struct sk_buff *msg;
+	struct nlattr *attr;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	netdev_info(peer->ovpn->dev, "deleting peer with id %u, reason %d\n",
+		    peer->id, peer->delete_reason);
+
+	msg = nlmsg_new(100, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0, OVPN_CMD_PEER_DEL_NTF);
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
+	if (nla_put_u8(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	nla_nest_end(msg, attr);
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
  * ovpn_nl_key_swap_notify - notify userspace peer's key must be renewed
  * @peer: the peer whose key needs to be renewed
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 33390b13c8904d40b629662005a9eb92ff617c3b..4ab3abcf23dba11f6b92e3d69e700693adbc671b 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,6 +12,7 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer);
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
 
 #endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 8cfe1997ec116ae4fe74cd7105d228569e2a66a9..91c608f1ffa1d9dd1535ba308b6adc933dbbf1f1 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -242,6 +242,7 @@ void ovpn_peer_release_kref(struct kref *kref)
 {
 	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
 
+	ovpn_nl_peer_del_notify(peer);
 	ovpn_peer_release(peer);
 }
 

-- 
2.45.2


