Return-Path: <netdev+bounces-148132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0767B9E0685
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC2128E0EF
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1020CCD8;
	Mon,  2 Dec 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IqaZdwL7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB020ADFA
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152135; cv=none; b=uCnH4WXBIMTrFHCLeZ5pNbk6E+mbA8NQjobvKZW4JFs2NejMTj7iUO/tQH5nreTcJCrWUhUF//nyQABlKeEz7JYn6Yu9+eiodW5VM/GUlp0e3eiw0odW1prslXbyVqO5LocooMO4fR6hkimQL+CK2qNLEJsCrEj1ATQ2e3BR6Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152135; c=relaxed/simple;
	bh=6EwhHNmzhUCcDPPPRYsQNdaz65V0rmrSbkEI81lY00A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdVQlX7QqCPtM0ZEkYxvQAX+OMMFR7jvYIAWQY+wlbidV45ZOjlnW+fZTt0vCE5zoM5zIuiGi2JiH5wTYYgaN0q6MAaLADcWzrSdDpp6rhyoM3TDyAB7tgirvcVrkB8dkIFLsNeTZHUEC4VcDJKBjy2KmMF4O0skKVIXlWLLcBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IqaZdwL7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385de9f789cso2271043f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152131; x=1733756931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8a458c3ows6aa2wJp9g+5AZFhIZm2GOmW3HXDJL7mw=;
        b=IqaZdwL7OdYRijJuaEHGNfiKziQezyXhVxdhk2auQgXHwXwUGHOjFyS5xZYn+62UiB
         vAeK3LbNuXKzuWIJsOztSpSEsCFdPTOtXK4iH12lLR6rh2pRWPqbWv7jDidbJkELstHk
         wAADV6oi6ad89E6uQcxbZhjNhbakphvXnDfFDiBsll39OxpnSMO1tbSotmio3YnqTxTU
         uKbgDusYOUHG38C8BdCjlBEYtrbDjJ5V+BxpL2GxcKps5TGp5etYynCc2CPPhvJTLR8o
         zzUIV46oGakSwJm8eTcbrCF7V/9KTEnh1mWTD/5Ou3wZEztWeubB66Bc6WWTQfR1i4Rk
         /bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152131; x=1733756931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8a458c3ows6aa2wJp9g+5AZFhIZm2GOmW3HXDJL7mw=;
        b=EtKtcwDbEwsGAEeimOLKpcm5j4xnEveduTlD5RyN9DOw59MlHBcSnGa/uS1cST/tl0
         y34Tr8yIeVzBx7zhxC1cDP44B8+8GEZVXct+w4TL8igOLVdg/INvS4Gp7l1+ilQkYZiA
         PXzzusz0BDLir3mzKwq/tngYLLJiZG9apqovhAZr8NGwiF8OBUsUGfO95nRnNunYjkhp
         hsKAUX27DaJzLVr4cEDpuQxkvsne5ZtdelISE5bISaJ23XL01rS8Ooi6kp4+Fi+s20zI
         ja4o0eMlgk0Ampwy4MWkf5bFaxD1wPj74sbnwcoN5NqxM+gmOlvh5uW4rssZ5iVz+8QO
         Ofmw==
X-Forwarded-Encrypted: i=1; AJvYcCV4r0cCSN35FhZ+2QYqautnn4LZBDMqX+M8jW9xWIR3CDNBfeoe4Rc9ehUAoZz3QQhcQmcmRPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+cqrFu9RvGPWs9xpy1UvWFgJWhuOHK4q0PbEoAjW3dFljiPme
	Z9S4cOIwSZo5+5V6G+nL13nW1iHhNXyL61hmvstErp6K8arJD0YPOTE9arzXNIc=
X-Gm-Gg: ASbGncsJ91zW/eXAGuEShNJqBUHNBMtgJGCCKyEK/UeDsKB7Z4S21FgmWezSpdpv+PS
	0uifnQ4gr0MMveMwkdA8w0gJ17Sm2+x5vjOrUlbuWMjbUJRGy6/VzJKFheda2B9A9NoZMt39trD
	epyRU8YmOlj2uYWGB4XIHj97WFBjYsH7Rhd5CRFWE9+Tl7DZbXiHvbXnk0qCGMqXJtMyqAHUpIN
	Kebsng2w956N/MoC1lNHcmV13tzhx7qvpWkaZ/vLX/weKx6xC2CWfYftSA0
X-Google-Smtp-Source: AGHT+IFwJP24YEokk99XCGojot8WEb8hnudjvpLF5jYaGzeEe0v+uaMrUsiAd212SQgNUnZWrkswUA==
X-Received: by 2002:a05:6000:4603:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-385f6de6404mr2659713f8f.24.1733152130613;
        Mon, 02 Dec 2024 07:08:50 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:08:50 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:37 +0100
Subject: [PATCH net-next v12 19/22] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-19-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5711; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=6EwhHNmzhUCcDPPPRYsQNdaz65V0rmrSbkEI81lY00A=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1ng1IRNQqSqUbbmlyetSiKehimRr+e0Whaw
 namvm2ax1KJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZwAKCRALcOU6oDjV
 h3WHB/0W7tMxH64BA+lADixlQW1EzU/jBSPtcidO+j2UtSAV2OITPvBixl8lM39EiryKrKbiFQC
 3Mc6WKeCPQ9KgjwK0Jh1nZh/QfD5bh7xmdmcpveU57TCGt4tI9/7N3pH1cPwrd8JT0yKzWXttZp
 I2HiLHK2vP6VHEMsVVG8gwSY47CuQjuKnHIw7JJ5X5sD/8H+5CpEsBSc5GMp7DSwsnOXXWdyPor
 +nGcjqS0d9MPEMuuBZ0lxhRpQCWxmgfaURa8IF8hHEN44QSRtmNvknoIl/KQR8fxZglyeV1/xvW
 lGFoThcU7lBaU8PP3SLd5jKsQGPYsaaTiEdHk4WUlr0XYUAZ
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

IV wrap-around is cryptographically dangerous for a number of ciphers,
therefore kill the key and inform userspace (via netlink) should the
IV space go exhausted.

Userspace has two ways of deciding when the key has to be renewed before
exhausting the IV space:
1) time based approach:
   after X seconds/minutes userspace generates a new key and sends it
   to the kernel. This is based on guestimate and normally default
   timer value works well.

2) packet count based approach:
   after X packets/bytes userspace generates a new key and sends it to
   the kernel. Userspace keeps track of the amount of traffic by
   periodically polling GET_PEER and fetching the VPN/LINK stats.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto.c  | 19 ++++++++++++++++
 drivers/net/ovpn/crypto.h  |  2 ++
 drivers/net/ovpn/io.c      | 13 +++++++++++
 drivers/net/ovpn/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  2 ++
 5 files changed, 91 insertions(+)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 6fccd73c6cf7d2566d1b819cb6d5d7b2ea98e81d..47a627822e95e3a1079a710c66037ec74173e653 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -54,6 +54,25 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
 	}
 }
 
+/* removes the key matching the specified id from the crypto context */
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
+{
+	struct ovpn_crypto_key_slot *ks = NULL;
+
+	spin_lock_bh(&cs->lock);
+	if (rcu_access_pointer(cs->slots[0])->key_id == key_id) {
+		ks = rcu_replace_pointer(cs->slots[0], NULL,
+					 lockdep_is_held(&cs->lock));
+	} else if (rcu_access_pointer(cs->slots[1])->key_id == key_id) {
+		ks = rcu_replace_pointer(cs->slots[1], NULL,
+					 lockdep_is_held(&cs->lock));
+	}
+	spin_unlock_bh(&cs->lock);
+
+	if (ks)
+		ovpn_crypto_key_slot_put(ks);
+}
+
 /* Reset the ovpn_crypto_state object in a way that is atomic
  * to RCU readers.
  */
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 05ca312765a4551b3493dc6a27228e8ad48e99f6..2e338ea3b9542a067c1c53cb18bd12648d832cd9 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -140,4 +140,6 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 			   enum ovpn_key_slot slot,
 			   struct ovpn_key_config *keyconf);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ee3bb650ed4700d8fa2c9a128b6d2318e1653f5c..39603a98973b05f5365d3d8d454aeb435b0ea598 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -244,6 +244,19 @@ void ovpn_encrypt_post(void *data, int ret)
 	if (likely(ovpn_skb_cb(skb)->req))
 		aead_request_free(ovpn_skb_cb(skb)->req);
 
+	if (unlikely(ret == -ERANGE)) {
+		/* we ran out of IVs and we must kill the key as it can't be
+		 * use anymore
+		 */
+		netdev_warn(peer->ovpn->dev,
+			    "killing key %u for peer %u\n", ks->key_id,
+			    peer->id);
+		ovpn_crypto_kill_key(&peer->crypto, ks->key_id);
+		/* let userspace know so that a new key must be negotiated */
+		ovpn_nl_key_swap_notify(peer, ks->key_id);
+		goto err;
+	}
+
 	if (unlikely(ret < 0))
 		goto err;
 
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 647ecb71794fc925f49b624d720a5169b72afae3..6a06ed02875156e87637c59339b53f11b7835815 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1042,6 +1042,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+/**
+ * ovpn_nl_key_swap_notify - notify userspace peer's key must be renewed
+ * @peer: the peer whose key needs to be renewed
+ * @key_id: the ID of the key that needs to be renewed
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
+{
+	struct nlattr *k_attr;
+	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	netdev_info(peer->ovpn->dev, "peer with id %u must rekey - primary key unusable.\n",
+		    peer->id);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0, OVPN_CMD_KEY_SWAP_NTF);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex))
+		goto err_cancel_msg;
+
+	k_attr = nla_nest_start(msg, OVPN_A_KEYCONF);
+	if (!k_attr)
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_KEYCONF_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	if (nla_put_u16(msg, OVPN_A_KEYCONF_KEY_ID, key_id))
+		goto err_cancel_msg;
+
+	nla_nest_end(msg, k_attr);
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(peer->sock->sock->sk),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_KERNEL);
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
index 9e87cf11d1e9813b7a75ddf3705ab7d5fabe899f..33390b13c8904d40b629662005a9eb92ff617c3b 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,4 +12,6 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
+
 #endif /* _NET_OVPN_NETLINK_H_ */

-- 
2.45.2


