Return-Path: <netdev+bounces-77147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C388704EE
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDD11F230B2
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62054D9FA;
	Mon,  4 Mar 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="P3WLFaX1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395D47F6F
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564968; cv=none; b=Cmi1iK4A1LsPb+bolkWmzFc8xclNzmJCk0N/ewgdkRxIepycV1sRHfJLJqsRb1VtesfR4Erdn7efIuVqW6FAnB++9a2RBn9UmH3ocQ/BGWxkDZl82CTVaLx1nKDFkyB0tUVQFc+c73SZknSZeKTthT9B8FQDrLIOk63KkYaVnJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564968; c=relaxed/simple;
	bh=euhBWbsjObI0BblzmW6Xcf2smtwX5mvf+z2vLCGn6cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHSoz9C1z5aIW3+heTIvVp1DjHuq/LlzvaMhP/lbijvYvmxQ1KXQDzzOaZEjgOI5teaGFRLX+y8xBCWML6guWZtTYl9TLIzCWLQNB8Dd0m6zgEoiq2+D/F+CXbFDcebthSCbhXzid+LvlAEb7zHPJ9tzeOTGZLeHYy2l15zNHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=P3WLFaX1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a458b6d9cfeso35349866b.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564964; x=1710169764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhTlsr72+iFa+SCbWYt2FNwm4myicZoWvENoue68lu4=;
        b=P3WLFaX1rFbIlmvj6HIPOscafHdW+dmtmdDLkbcwwlxaLAiO13qblnHTpfFFq4QWdo
         oAALINNbjLwffIFcQTTrLBoU/j0ULk7Kx+ouCbuvTHlXk7mps9EBBi+uM2+FQ6g5O/wB
         l8s+MVikhsqIeRjrOqLxNPR6U9cWav3sgDoBfN9M3+3cKjE+aiJUN6apoLJvh9pG2svN
         aioGeBMo7TLocO47za2X0plgfmVJVnGy8Pof6G/9jlgqQHOKPZFzKCmie/+Fx9PTRE6x
         9dusWptbf0ms/2zYQKwrEHjaDzbc5s1WdWWet0niJz4swE6MYHpaeAAHyKZNpxrxxEax
         9SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564964; x=1710169764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhTlsr72+iFa+SCbWYt2FNwm4myicZoWvENoue68lu4=;
        b=KLjgeFXj2IeE6uYDQve7J+0UL8zYDhLifSuTRNQqOIcCsQIN60hMr8b6FTT00oWTUD
         Fv3go+4XLfw9DHcqKrngP1JTIwBZJATOUsj7AvWdw03GNn6zpr9H2xQKJiqx1kM6/G6h
         XcLAQ1Ub9zXElBx4RKSPwQf19K6qBueu9rNNhKNf5sTyRJDpithxHzAzYhwZPCwwohLo
         MQLop6QG5/hX8acvptMD+y1VIqVYAyQQU1WTSBGydqFTrA0WkWo997WDPVXDZoJwaBKF
         5WYHxaJ7lOEdSQ4nFb//vgocu3dWYuRQcgzsq4DQiIKWrm4s4lIzkTj3aVAULrXWNO16
         pChw==
X-Gm-Message-State: AOJu0Yzvedx8MKzAKea7FErDB9bWwi7sIGg6EVQjNUqEhR/BKpeF7DVe
	EO1iWSN/cwvmBdyRlR42vhzz62bBSb70kU4O6oKVYEGI/K4JShO157r4vo/iXswqDGrc/Fv8qcn
	9
X-Google-Smtp-Source: AGHT+IG0ZH4ifTzW4Gs84icPNzocTKKOwq+AsFpmpIArMpnkTouNrolW+Js2/q9F+IeG/A0Jb35FCA==
X-Received: by 2002:a17:907:1043:b0:a45:6893:b773 with SMTP id oy3-20020a170907104300b00a456893b773mr1361452ejb.46.1709564964727;
        Mon, 04 Mar 2024 07:09:24 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:24 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 20/22] ovpn: kill key and notify userspace in case of IV exhaustion
Date: Mon,  4 Mar 2024 16:09:11 +0100
Message-ID: <20240304150914.11444-21-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
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
 drivers/net/ovpn/io.c      | 14 +++++++++++++
 drivers/net/ovpn/netlink.c | 42 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  3 +++
 3 files changed, 59 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index cb2a355f8766..ea8367c3da08 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -318,6 +318,20 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* encrypt */
 	ret = ovpn_aead_encrypt(ks, skb, peer->id);
 	if (unlikely(ret < 0)) {
+		/* if we ran out of IVs we must kill the key as it can't be used anymore */
+		if (ret == -ERANGE) {
+			netdev_warn(peer->ovpn->dev,
+				    "killing primary key as we ran out of IVs for peer %u\n",
+				    peer->id);
+			ovpn_crypto_kill_primary(&peer->crypto);
+			ret = ovpn_nl_notify_swap_keys(peer);
+			if (ret < 0)
+				netdev_warn(peer->ovpn->dev,
+					    "couldn't send key killing notification to userspace for peer %u\n",
+					    peer->id);
+			goto err;
+		}
+
 		net_err_ratelimited("%s: error during encryption for peer %u, key-id %u: %d\n",
 				    peer->ovpn->dev->name, peer->id, ks->key_id, ret);
 		goto err;
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index dbe1dfddba4c..e8b55c0a15e9 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -891,6 +891,48 @@ static struct genl_family ovpn_nl_family __ro_after_init = {
 	.n_mcgrps = ARRAY_SIZE(ovpn_nl_mcgrps),
 };
 
+int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer)
+{
+	struct sk_buff *msg;
+	void *hdr;
+	int ret;
+
+	netdev_info(peer->ovpn->dev, "peer with id %u must rekey - primary key unusable.\n",
+		    peer->id);
+
+	msg = nlmsg_new(100, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0,
+			  OVPN_CMD_SWAP_KEYS);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex)) {
+		ret = -EMSGSIZE;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id)) {
+		ret = -EMSGSIZE;
+		goto err_free_msg;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev),
+				msg, 0, OVPN_MCGRP_PEERS, GFP_KERNEL);
+
+	return 0;
+
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * ovpn_nl_notify() - react to openvpn userspace process exit
  */
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index eb7f234842ef..17ca69761440 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -9,10 +9,13 @@
 #ifndef _NET_OVPN_NETLINK_H_
 #define _NET_OVPN_NETLINK_H_
 
+struct ovpn_peer;
 struct ovpn_struct;
 
 int ovpn_nl_init(struct ovpn_struct *ovpn);
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer);
+
 #endif /* _NET_OVPN_NETLINK_H_ */
-- 
2.43.0


