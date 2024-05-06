Return-Path: <netdev+bounces-93576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975468BC55C
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E87B20B20
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7454C631;
	Mon,  6 May 2024 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dsvaNII7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246594AEE7
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958162; cv=none; b=Cwsuox73G+oU40xzTuOepgxjcVJxaoAG0kZVbgtEao4mZ9oZrK5fCzIfPfalHbxPALCIBJ/uUzyj6rjITposUS3JTfp6LmbyMikzjtIJwSZ4bxhsPPuVdplaQn5m7cz5q1D90N40IMikMRVmACYRIYv82uMEc0liX+vRnLUZ7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958162; c=relaxed/simple;
	bh=lZAm98/jd7ema4fN5nMay05yDdTn65ON2d8aD4WILXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osQdi48ebVUBl/233C40X4QJ6c4pYKzSGmIE6krkivvxxKwhUwxMM691tebP7uYheYVSkSMXSCghHL8ZQGslFX3V2ToKYoV1xoGLSMk0MKLqEgq/23j6FYrCyCNOw6qhfr/LLNDvALUPX4RmNkK7wSWkGp5+pKD+dnehkGp1TA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dsvaNII7; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34db6a29998so870939f8f.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958158; x=1715562958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA2KuRBXC/JmvOJ2cVx2D8AEDk3cKP9cp3mXLOHqqrc=;
        b=dsvaNII7gUFIE6a0KLqEBlF1FM45pH4qGhwjm7fbo+9UeIGVFQpdn2U/vNqWBhRNbc
         RVpW7gp0vkB8ENUl9D7bGABCqqR6kd0SRDtMzEvYQZqTZPNAWmYD0eSUWE5nl7o4KsOf
         Rzr10wLpZ4MC3Eag+OJxxhPvZYNJ/01NBhrVYgq5d2pdsxsiFSi3vyRFDackYa0CkcMj
         ArKYDme4JT1IIwf2h8eNBDzxxgd56i5bZWFNpZYO9r9TTf5ZylDEoPwAzxcddQ3+dUl9
         s3cz4jY6mZMaTI/UOfoTwm0uv17w7VjZ48HYkcXM3GqWoHs21V4rk/g47rTjeJN0/aR6
         gizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958158; x=1715562958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mA2KuRBXC/JmvOJ2cVx2D8AEDk3cKP9cp3mXLOHqqrc=;
        b=s/7miCSSDYcGyqB0SWuX4zdidSAaOKsctUvpIny4i+CL3lWhDwItECBsSRcOkFt+YP
         FJxEyhcMSx0MgrxPdMWxXepSlX4IrkmkN/wvBgE4w6nYo/SGLEN/Gz8oGW6dUXpccMZE
         MFDIAdRFg67H/ePf42ip1cdXyuwlLqxrCuA11xAgWS7ZGpFaQ1Jp5Nly/hGPElgYM2fv
         x5/gmIVk9qK9BjcJbW5Tu2nzT1gDBlzVR4gcI2ztiPwff3UiYsHTxuh3RxJBqUKxJMgN
         mJ0PlAyuG9QAVfrtT/3xtNs5xmyz0kn+3EXeMkTT0tu0PlXvhVzi478M5OGV3tNCwkEM
         va3g==
X-Gm-Message-State: AOJu0YzYDh/HPzep/+50XJOXTUMIiC2HMpVQH4kv6RemOwP6F7Ht5D6w
	2o8van6WIteYPBvHDj4Na5e9heQYXolS25oe/fEyvDtVS9ZGeskGq99H5GydpP4fcn2CMVsONMi
	K
X-Google-Smtp-Source: AGHT+IHxVzBdHt96d4uDOt/Yu8ZXALs6meV5MqCjm67Z4ojre2obdprEcEWmArhHHSTqYzgNsfm5UQ==
X-Received: by 2002:a5d:4288:0:b0:34f:2cea:c87f with SMTP id k8-20020a5d4288000000b0034f2ceac87fmr738946wrq.24.1714958158119;
        Sun, 05 May 2024 18:15:58 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:57 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 20/24] ovpn: implement key add/del/swap via netlink
Date: Mon,  6 May 2024 03:16:33 +0200
Message-ID: <20240506011637.27272-21-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change introduces the netlink commands needed to add, delete and
swap keys for a specific peer.

Userspace is expected to use these commands to create, destroy and
rotate session keys for a specific peer.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 193 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 914b04631ae8..df14988c1f43 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -660,19 +660,206 @@ int ovpn_nl_del_peer_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static int ovpn_nl_get_key_dir(struct genl_info *info, struct nlattr *key,
+			       enum ovpn_cipher_alg cipher,
+			       struct ovpn_key_direction *dir)
+{
+	struct nlattr *attr, *attrs[OVPN_A_KEYDIR_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYDIR_MAX, key,
+			       ovpn_keydir_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	switch (cipher) {
+	case OVPN_CIPHER_ALG_AES_GCM:
+	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+		attr = attrs[OVPN_A_KEYDIR_CIPHER_KEY];
+		if (!attr)
+			return -EINVAL;
+
+		dir->cipher_key = nla_data(attr);
+		dir->cipher_key_size = nla_len(attr);
+
+		attr = attrs[OVPN_A_KEYDIR_NONCE_TAIL];
+		/* These algorithms require a 96bit nonce,
+		 * Construct it by combining 4-bytes packet id and
+		 * 8-bytes nonce-tail from userspace
+		 */
+		if (!attr)
+			return -EINVAL;
+
+		dir->nonce_tail = nla_data(attr);
+		dir->nonce_tail_size = nla_len(attr);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int ovpn_nl_set_key_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -ENOTSUPP;
+	struct nlattr *p_attrs[OVPN_A_PEER_MAX + 1];
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer_key_reset pkr;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(p_attrs, OVPN_A_PEER_MAX,
+			       info->attrs[OVPN_A_PEER], ovpn_peer_nl_policy,
+			       info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], p_attrs,
+			      OVPN_A_PEER_ID) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], p_attrs,
+			      OVPN_A_PEER_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       p_attrs[OVPN_A_PEER_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_SLOT) ||
+	    NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_KEY_ID) ||
+	    NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_CIPHER_ALG) ||
+	    NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_ENCRYPT_DIR) ||
+	    NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_DECRYPT_DIR))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(p_attrs[OVPN_A_PEER_ID]);
+	pkr.slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
+	pkr.key.key_id = nla_get_u16(attrs[OVPN_A_KEYCONF_KEY_ID]);
+	pkr.key.cipher_alg = nla_get_u16(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
+
+	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_ENCRYPT_DIR],
+				  pkr.key.cipher_alg, &pkr.key.encrypt);
+	if (ret < 0)
+		return ret;
+
+	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_DECRYPT_DIR],
+				  pkr.key.cipher_alg, &pkr.key.decrypt);
+	if (ret < 0)
+		return ret;
+
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		netdev_dbg(ovpn->dev, "%s: no peer with id %u to set key for\n",
+			   __func__, peer_id);
+		return -ENOENT;
+	}
+
+	mutex_lock(&peer->crypto.mutex);
+	ret = ovpn_crypto_state_reset(&peer->crypto, &pkr);
+	if (ret < 0) {
+		netdev_dbg(ovpn->dev,
+			   "%s: cannot install new key for peer %u\n", __func__,
+			   peer_id);
+		goto unlock;
+	}
+
+	netdev_dbg(ovpn->dev, "%s: new key installed (id=%u) for peer %u\n",
+		   __func__, pkr.key.key_id, peer_id);
+unlock:
+	mutex_unlock(&peer->crypto.mutex);
+	ovpn_peer_put(peer);
+	return ret;
 }
 
 int ovpn_nl_swap_keys_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -ENOTSUPP;
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct nlattr *attrs[OVPN_A_PEER + 1];
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
+			       ovpn_peer_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
+			      OVPN_A_PEER_ID))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer)
+		return -ENOENT;
+
+	ovpn_crypto_key_slots_swap(&peer->crypto);
+	ovpn_peer_put(peer);
+
+	return 0;
 }
 
 int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -ENOTSUPP;
+	struct nlattr *p_attrs[OVPN_A_PEER_MAX + 1];
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	enum ovpn_key_slot slot;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(p_attrs, OVPN_A_PEER_MAX,
+			       info->attrs[OVPN_A_PEER], ovpn_peer_nl_policy,
+			       info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], p_attrs,
+			      OVPN_A_PEER_ID) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], p_attrs,
+			      OVPN_A_PEER_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       p_attrs[OVPN_A_PEER_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_SLOT))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(p_attrs[OVPN_A_PEER_ID]);
+	slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
+
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer)
+		return -ENOENT;
+
+	ovpn_crypto_key_slot_delete(&peer->crypto, slot);
+	ovpn_peer_put(peer);
+
+	return 0;
 }
 
 /**
-- 
2.43.2


