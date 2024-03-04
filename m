Return-Path: <netdev+bounces-77137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334468704E4
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577CD1C2220F
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8017647A53;
	Mon,  4 Mar 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OwfvddCj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E55F487BE
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564956; cv=none; b=IGWrYhhP6TuGHtq0UuiMFLdSREBf6YifQ0hYgNdl9mZjdkJMyCadkGQal9bdG6yzTrziWsl895QFtkKqMyZ0TBDq1W5RrK6nyyyFFKLolxGY+YbA8+aYryDn0GvlzRekgtBfGVrg4RT6VZ3b0uYhv1nlKpbUH3BZodMHqNNFC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564956; c=relaxed/simple;
	bh=5eWNKr9EMS02T7YgcRUKmsHEtuANTH0IdWYZznxm58M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/FWsG3iySMyiQ/YuZQE56CUFGQi53GUj7wRlREILqu3hJrdbV8lA3z575hOResEZ4UPK0Oaz3/tAp/MOXoLr8c+fjt0bqU1xeWMzqQtYmMxA2ss1SSk88r1ArKWs16pwzwhkOycj0coOTalBTZfKOfwv696fvUsg1vuzO0dRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OwfvddCj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4467d570cdso459994666b.3
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564951; x=1710169751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL2uUIn0019qgZVfY5BpBkOb55FGNBygB9beKwEkZ6g=;
        b=OwfvddCj2VSXW0yMXFgAbHCQcc38+8k449Qu0XWVXRTm835h7EmJ25+wklb8aMMmZc
         x6HUBJpwiYlOtMacJvMzYJ06md/CMOWqLxE01Vc58YUHn4wZJSwWzUm9FrU3eT4jw7ln
         IHN29vk4YpT8U2CiJKYp8VDSKfD6IU9s5fTKFSHIEudc6+YB6salKMuWKe3YuMPFMbz9
         tb8FE9+1Mr8BeK4GFZ2Gut8JkDyaSBxN962nxij5tevUDJ2gg7w6gqMvB2fOh4yov3aZ
         k7koFOd+hex3FDYd+25Y7fOmOkQ4wSxkgJQm2cJLixvgoVR3e9/mIOXPnPMN24yb4D5a
         mnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564951; x=1710169751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lL2uUIn0019qgZVfY5BpBkOb55FGNBygB9beKwEkZ6g=;
        b=WZmZJ2lEe1T89vwH9UaCJBqzJFy6/ORXhpzl2AiV2P8ZrYA8jU9X0U9rXN7VGT7k/x
         qD/rQP06Cpf6YprfumKqhq5d5eSAVT0Kt6wZk/oHlfRRx/WBQT/1NK0JtRLyDaHJnrRL
         VbETfXVBO0//GL58XQncIp+KgQ3+7UDhz4oqs1AIBO9/79ufpNJAjbhk5quh0F0DtZpR
         rG0tB9wOI7F7MVCVx6rrHtfIEe8U01yV8v4aXbYrNCpWSws+hpqP916WjW7eZXj58Ncd
         eNrXa6/W0tRwFczk8PEiYAa23AjG7a3ZwzneVOXjLmVTd/P8w75dKUYu+BoIUoi9V6rC
         3ztg==
X-Gm-Message-State: AOJu0Yz9EbuL0xTLZ/YsWufvzWjQGutBstQRG4c4hA3whTbgMEqChRpH
	ZiIrVCH7kRLOMGk8CBZie1DdfsRgLLP35UHh21CzOOyrbqcrI8O9qG0XvReQlLpd+mWU/kAJZTT
	rfJA=
X-Google-Smtp-Source: AGHT+IGOfw+46f1wYGVF4Io0Ixjfr4/Zw1TbPTFxC2vR8RkLZsk5yC9Fb45+Mv3FiFMDFVDfr1yZLQ==
X-Received: by 2002:a17:906:e250:b0:a45:7495:884d with SMTP id gq16-20020a170906e25000b00a457495884dmr1047392ejb.71.1709564950913;
        Mon, 04 Mar 2024 07:09:10 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:10 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 10/22] ovpn: implement packet processing
Date: Mon,  4 Mar 2024 16:09:01 +0100
Message-ID: <20240304150914.11444-11-antonio@openvpn.net>
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

This change implements encryption/decryption and
encapsulation/decapsulation of OpenVPN packets.

Support for generic crypto state is added along with
a wrapper for the AEAD crypto kernel API.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile      |   3 +
 drivers/net/ovpn/crypto.c      | 154 ++++++++++++++
 drivers/net/ovpn/crypto.h      | 144 +++++++++++++
 drivers/net/ovpn/crypto_aead.c | 366 +++++++++++++++++++++++++++++++++
 drivers/net/ovpn/crypto_aead.h |  27 +++
 drivers/net/ovpn/io.c          | 141 +++++++++++--
 drivers/net/ovpn/packet.h      |   2 +
 drivers/net/ovpn/peer.c        |  21 ++
 drivers/net/ovpn/peer.h        |   3 +
 drivers/net/ovpn/pktid.c       | 126 ++++++++++++
 drivers/net/ovpn/pktid.h       |  90 ++++++++
 11 files changed, 1056 insertions(+), 21 deletions(-)
 create mode 100644 drivers/net/ovpn/crypto.c
 create mode 100644 drivers/net/ovpn/crypto.h
 create mode 100644 drivers/net/ovpn/crypto_aead.c
 create mode 100644 drivers/net/ovpn/crypto_aead.h
 create mode 100644 drivers/net/ovpn/pktid.c
 create mode 100644 drivers/net/ovpn/pktid.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index f768cd95b777..eaa16c24573c 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -8,9 +8,12 @@
 
 obj-$(CONFIG_OVPN) += ovpn.o
 ovpn-y += bind.o
+ovpn-y += crypto.o
+ovpn-y += crypto_aead.o
 ovpn-y += main.o
 ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += peer.o
+ovpn-y += pktid.o
 ovpn-y += socket.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
new file mode 100644
index 000000000000..1684ed2acf6f
--- /dev/null
+++ b/drivers/net/ovpn/crypto.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include "main.h"
+#include "crypto_aead.h"
+#include "crypto.h"
+
+#include <uapi/linux/ovpn.h>
+
+static void ovpn_ks_destroy_rcu(struct rcu_head *head)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = container_of(head, struct ovpn_crypto_key_slot, rcu);
+	ovpn_aead_crypto_key_slot_destroy(ks);
+}
+
+void ovpn_crypto_key_slot_release(struct kref *kref)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = container_of(kref, struct ovpn_crypto_key_slot, refcount);
+	call_rcu(&ks->rcu, ovpn_ks_destroy_rcu);
+}
+
+/* can only be invoked when all peer references have been dropped (i.e. RCU
+ * release routine)
+ */
+void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = rcu_access_pointer(cs->primary);
+	if (ks) {
+		RCU_INIT_POINTER(cs->primary, NULL);
+		ovpn_crypto_key_slot_put(ks);
+	}
+
+	ks = rcu_access_pointer(cs->secondary);
+	if (ks) {
+		RCU_INIT_POINTER(cs->secondary, NULL);
+		ovpn_crypto_key_slot_put(ks);
+	}
+
+	mutex_destroy(&cs->mutex);
+}
+
+/* removes the primary key from the crypto context */
+void ovpn_crypto_kill_primary(struct ovpn_crypto_state *cs)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	mutex_lock(&cs->mutex);
+	ks = rcu_replace_pointer(cs->primary, NULL, lockdep_is_held(&cs->mutex));
+	ovpn_crypto_key_slot_put(ks);
+	mutex_unlock(&cs->mutex);
+}
+
+/* Reset the ovpn_crypto_state object in a way that is atomic
+ * to RCU readers.
+ */
+int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
+			    const struct ovpn_peer_key_reset *pkr)
+	__must_hold(cs->mutex)
+{
+	struct ovpn_crypto_key_slot *old = NULL;
+	struct ovpn_crypto_key_slot *new;
+
+	lockdep_assert_held(&cs->mutex);
+
+	new = ovpn_aead_crypto_key_slot_new(&pkr->key);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	switch (pkr->slot) {
+	case OVPN_KEY_SLOT_PRIMARY:
+		old = rcu_replace_pointer(cs->primary, new,
+					  lockdep_is_held(&cs->mutex));
+		break;
+	case OVPN_KEY_SLOT_SECONDARY:
+		old = rcu_replace_pointer(cs->secondary, new,
+					  lockdep_is_held(&cs->mutex));
+		break;
+	default:
+		goto free_key;
+	}
+
+	if (old)
+		ovpn_crypto_key_slot_put(old);
+
+	return 0;
+free_key:
+	ovpn_crypto_key_slot_put(new);
+	return -EINVAL;
+}
+
+void ovpn_crypto_key_slot_delete(struct ovpn_crypto_state *cs,
+				 enum ovpn_key_slot slot)
+{
+	struct ovpn_crypto_key_slot *ks = NULL;
+
+	mutex_lock(&cs->mutex);
+	switch (slot) {
+	case OVPN_KEY_SLOT_PRIMARY:
+		ks = rcu_replace_pointer(cs->primary, NULL,
+					 lockdep_is_held(&cs->mutex));
+		break;
+	case OVPN_KEY_SLOT_SECONDARY:
+		ks = rcu_replace_pointer(cs->secondary, NULL,
+					 lockdep_is_held(&cs->mutex));
+		break;
+	default:
+		pr_warn("Invalid slot to release: %u\n", slot);
+		break;
+	}
+	mutex_unlock(&cs->mutex);
+
+	if (!ks) {
+		pr_debug("Key slot already released: %u\n", slot);
+		return;
+	}
+	pr_debug("deleting key slot %u, key_id=%u\n", slot, ks->key_id);
+
+	ovpn_crypto_key_slot_put(ks);
+}
+
+/* this swap is not atomic, but there will be a very short time frame where the
+ * old_secondary key won't be available. This should not be a big deal as most
+ * likely both peers are already using the new primary at this point.
+ */
+void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs)
+{
+	const struct ovpn_crypto_key_slot *old_primary, *old_secondary;
+
+	mutex_lock(&cs->mutex);
+
+	old_secondary = rcu_dereference_protected(cs->secondary,
+						  lockdep_is_held(&cs->mutex));
+	old_primary = rcu_replace_pointer(cs->primary, old_secondary,
+					  lockdep_is_held(&cs->mutex));
+	rcu_assign_pointer(cs->secondary, old_primary);
+
+	pr_debug("key swapped: %u <-> %u\n",
+		 old_primary ? old_primary->key_id : 0,
+		 old_secondary ? old_secondary->key_id : 0);
+
+	mutex_unlock(&cs->mutex);
+}
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
new file mode 100644
index 000000000000..a4d076e0e3df
--- /dev/null
+++ b/drivers/net/ovpn/crypto.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNCRYPTO_H_
+#define _NET_OVPN_OVPNCRYPTO_H_
+
+#include "main.h"
+#include "pktid.h"
+
+#include <uapi/linux/ovpn.h>
+#include <linux/skbuff.h>
+
+struct ovpn_peer;
+struct ovpn_crypto_key_slot;
+
+/* info needed for both encrypt and decrypt directions */
+struct ovpn_key_direction {
+	const u8 *cipher_key;
+	size_t cipher_key_size;
+	const u8 *nonce_tail; /* only needed for GCM modes */
+	size_t nonce_tail_size; /* only needed for GCM modes */
+};
+
+/* all info for a particular symmetric key (primary or secondary) */
+struct ovpn_key_config {
+	enum ovpn_cipher_alg cipher_alg;
+	u8 key_id;
+	struct ovpn_key_direction encrypt;
+	struct ovpn_key_direction decrypt;
+};
+
+/* used to pass settings from netlink to the crypto engine */
+struct ovpn_peer_key_reset {
+	enum ovpn_key_slot slot;
+	struct ovpn_key_config key;
+};
+
+struct ovpn_crypto_key_slot {
+	u8 key_id;
+
+	struct crypto_aead *encrypt;
+	struct crypto_aead *decrypt;
+	struct ovpn_nonce_tail nonce_tail_xmit;
+	struct ovpn_nonce_tail nonce_tail_recv;
+
+	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
+	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
+	struct kref refcount;
+	struct rcu_head rcu;
+};
+
+struct ovpn_crypto_state {
+	struct ovpn_crypto_key_slot __rcu *primary;
+	struct ovpn_crypto_key_slot __rcu *secondary;
+
+	/* protects primary and secondary slots */
+	struct mutex mutex;
+};
+
+static inline bool ovpn_crypto_key_slot_hold(struct ovpn_crypto_key_slot *ks)
+{
+	return kref_get_unless_zero(&ks->refcount);
+}
+
+static inline void ovpn_crypto_state_init(struct ovpn_crypto_state *cs)
+{
+	RCU_INIT_POINTER(cs->primary, NULL);
+	RCU_INIT_POINTER(cs->secondary, NULL);
+	mutex_init(&cs->mutex);
+}
+
+static inline struct ovpn_crypto_key_slot *
+ovpn_crypto_key_id_to_slot(const struct ovpn_crypto_state *cs, u8 key_id)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	if (unlikely(!cs))
+		return NULL;
+
+	rcu_read_lock();
+	ks = rcu_dereference(cs->primary);
+	if (ks && ks->key_id == key_id) {
+		if (unlikely(!ovpn_crypto_key_slot_hold(ks)))
+			ks = NULL;
+		goto out;
+	}
+
+	ks = rcu_dereference(cs->secondary);
+	if (ks && ks->key_id == key_id) {
+		if (unlikely(!ovpn_crypto_key_slot_hold(ks)))
+			ks = NULL;
+		goto out;
+	}
+
+	/* when both key slots are occupied but no matching key ID is found, ks has to be reset to
+	 * NULL to avoid carrying a stale pointer
+	 */
+	ks = NULL;
+out:
+	rcu_read_unlock();
+
+	return ks;
+}
+
+static inline struct ovpn_crypto_key_slot *
+ovpn_crypto_key_slot_primary(const struct ovpn_crypto_state *cs)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	rcu_read_lock();
+	ks = rcu_dereference(cs->primary);
+	if (unlikely(ks && !ovpn_crypto_key_slot_hold(ks)))
+		ks = NULL;
+	rcu_read_unlock();
+
+	return ks;
+}
+
+void ovpn_crypto_key_slot_release(struct kref *kref);
+
+static inline void ovpn_crypto_key_slot_put(struct ovpn_crypto_key_slot *ks)
+{
+	kref_put(&ks->refcount, ovpn_crypto_key_slot_release);
+}
+
+int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
+			    const struct ovpn_peer_key_reset *pkr);
+
+void ovpn_crypto_key_slot_delete(struct ovpn_crypto_state *cs,
+				 enum ovpn_key_slot slot);
+
+void ovpn_crypto_state_release(struct ovpn_crypto_state *cs);
+
+void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs);
+
+void ovpn_crypto_kill_primary(struct ovpn_crypto_state *cs);
+
+#endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
new file mode 100644
index 000000000000..6d045cadcde4
--- /dev/null
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include "crypto_aead.h"
+#include "crypto.h"
+#include "pktid.h"
+#include "proto.h"
+
+#include <crypto/aead.h>
+#include <linux/skbuff.h>
+#include <linux/printk.h>
+
+#define AUTH_TAG_SIZE	16
+
+static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
+{
+	return  OVPN_OP_SIZE_V2 +			/* OP header size */
+		4 +					/* Packet ID */
+		crypto_aead_authsize(ks->encrypt);	/* Auth Tag */
+}
+
+int ovpn_aead_encrypt(struct ovpn_crypto_key_slot *ks, struct sk_buff *skb, u32 peer_id)
+{
+	const unsigned int tag_size = crypto_aead_authsize(ks->encrypt);
+	const unsigned int head_size = ovpn_aead_encap_overhead(ks);
+	struct scatterlist sg[MAX_SKB_FRAGS + 2];
+	DECLARE_CRYPTO_WAIT(wait);
+	struct aead_request *req;
+	struct sk_buff *trailer;
+	u8 iv[NONCE_SIZE];
+	int nfrags, ret;
+	u32 pktid, op;
+
+	/* Sample AEAD header format:
+	 * 48000001 00000005 7e7046bd 444a7e28 cc6387b1 64a4d6c1 380275a...
+	 * [ OP32 ] [seq # ] [             auth tag            ] [ payload ... ]
+	 *          [4-byte
+	 *          IV head]
+	 */
+
+	/* check that there's enough headroom in the skb for packet
+	 * encapsulation, after adding network header and encryption overhead
+	 */
+	if (unlikely(skb_cow_head(skb, OVPN_HEAD_ROOM + head_size)))
+		return -ENOBUFS;
+
+	/* get number of skb frags and ensure that packet data is writable */
+	nfrags = skb_cow_data(skb, 0, &trailer);
+	if (unlikely(nfrags < 0))
+		return nfrags;
+
+	if (unlikely(nfrags + 2 > ARRAY_SIZE(sg)))
+		return -ENOSPC;
+
+	req = aead_request_alloc(ks->encrypt, GFP_KERNEL);
+	if (unlikely(!req))
+		return -ENOMEM;
+
+	/* sg table:
+	 * 0: op, wire nonce (AD, len=OVPN_OP_SIZE_V2+NONCE_WIRE_SIZE),
+	 * 1, 2, 3, ..., n: payload,
+	 * n+1: auth_tag (len=tag_size)
+	 */
+	sg_init_table(sg, nfrags + 2);
+
+	/* build scatterlist to encrypt packet payload */
+	ret = skb_to_sgvec_nomark(skb, sg + 1, 0, skb->len);
+	if (unlikely(nfrags != ret)) {
+		ret = -EINVAL;
+		goto free_req;
+	}
+
+	/* append auth_tag onto scatterlist */
+	__skb_push(skb, tag_size);
+	sg_set_buf(sg + nfrags + 1, skb->data, tag_size);
+
+	/* obtain packet ID, which is used both as a first
+	 * 4 bytes of nonce and last 4 bytes of associated data.
+	 */
+	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
+	if (unlikely(ret < 0))
+		goto free_req;
+
+	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes nonce */
+	ovpn_pktid_aead_write(pktid, &ks->nonce_tail_xmit, iv);
+
+	/* make space for packet id and push it to the front */
+	__skb_push(skb, NONCE_WIRE_SIZE);
+	memcpy(skb->data, iv, NONCE_WIRE_SIZE);
+
+	/* add packet op as head of additional data */
+	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer_id);
+	__skb_push(skb, OVPN_OP_SIZE_V2);
+	BUILD_BUG_ON(sizeof(op) != OVPN_OP_SIZE_V2);
+	*((__force __be32 *)skb->data) = htonl(op);
+
+	/* AEAD Additional data */
+	sg_set_buf(sg, skb->data, OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE);
+
+	/* setup async crypto operation */
+	aead_request_set_tfm(req, ks->encrypt);
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				       CRYPTO_TFM_REQ_MAY_SLEEP,
+				  crypto_req_done, &wait);
+	aead_request_set_crypt(req, sg, sg, skb->len - head_size, iv);
+	aead_request_set_ad(req, OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE);
+
+	/* encrypt it */
+	ret = crypto_wait_req(crypto_aead_encrypt(req), &wait);
+	if (ret < 0)
+		net_err_ratelimited("%s: encrypt failed: %d\n", __func__, ret);
+
+free_req:
+	aead_request_free(req);
+	return ret;
+}
+
+int ovpn_aead_decrypt(struct ovpn_crypto_key_slot *ks, struct sk_buff *skb)
+{
+	const unsigned int tag_size = crypto_aead_authsize(ks->decrypt);
+	struct scatterlist sg[MAX_SKB_FRAGS + 2];
+	int ret, payload_len, nfrags;
+	u8 *sg_data, iv[NONCE_SIZE];
+	unsigned int payload_offset;
+	DECLARE_CRYPTO_WAIT(wait);
+	struct aead_request *req;
+	struct sk_buff *trailer;
+	unsigned int sg_len;
+	__be32 *pid;
+
+	payload_offset = OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE + tag_size;
+	payload_len = skb->len - payload_offset;
+
+	/* sanity check on packet size, payload size must be >= 0 */
+	if (unlikely(payload_len < 0))
+		return -EINVAL;
+
+	/* Prepare the skb data buffer to be accessed up until the auth tag.
+	 * This is required because this area is directly mapped into the sg list.
+	 */
+	if (unlikely(!pskb_may_pull(skb, payload_offset)))
+		return -ENODATA;
+
+	/* get number of skb frags and ensure that packet data is writable */
+	nfrags = skb_cow_data(skb, 0, &trailer);
+	if (unlikely(nfrags < 0))
+		return nfrags;
+
+	if (unlikely(nfrags + 2 > ARRAY_SIZE(sg)))
+		return -ENOSPC;
+
+	req = aead_request_alloc(ks->decrypt, GFP_KERNEL);
+	if (unlikely(!req))
+		return -ENOMEM;
+
+	/* sg table:
+	 * 0: op, wire nonce (AD, len=OVPN_OP_SIZE_V2+NONCE_WIRE_SIZE),
+	 * 1, 2, 3, ..., n: payload,
+	 * n+1: auth_tag (len=tag_size)
+	 */
+	sg_init_table(sg, nfrags + 2);
+
+	/* packet op is head of additional data */
+	sg_data = skb->data;
+	sg_len = OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE;
+	sg_set_buf(sg, sg_data, sg_len);
+
+	/* build scatterlist to decrypt packet payload */
+	ret = skb_to_sgvec_nomark(skb, sg + 1, payload_offset, payload_len);
+	if (unlikely(nfrags != ret)) {
+		ret = -EINVAL;
+		goto free_req;
+	}
+
+	/* append auth_tag onto scatterlist */
+	sg_set_buf(sg + nfrags + 1, skb->data + sg_len, tag_size);
+
+	/* copy nonce into IV buffer */
+	memcpy(iv, skb->data + OVPN_OP_SIZE_V2, NONCE_WIRE_SIZE);
+	memcpy(iv + NONCE_WIRE_SIZE, ks->nonce_tail_recv.u8,
+	       sizeof(struct ovpn_nonce_tail));
+
+	/* setup async crypto operation */
+	aead_request_set_tfm(req, ks->decrypt);
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				       CRYPTO_TFM_REQ_MAY_SLEEP,
+				  crypto_req_done, &wait);
+	aead_request_set_crypt(req, sg, sg, payload_len + tag_size, iv);
+
+	aead_request_set_ad(req, NONCE_WIRE_SIZE + OVPN_OP_SIZE_V2);
+
+	/* decrypt it */
+	ret = crypto_wait_req(crypto_aead_decrypt(req), &wait);
+	if (ret < 0) {
+		net_err_ratelimited("%s: decrypt failed: %d\n", __func__, ret);
+		goto free_req;
+	}
+
+	/* PID sits after the op */
+	pid = (__force __be32 *)(skb->data + OVPN_OP_SIZE_V2);
+	ret = ovpn_pktid_recv(&ks->pid_recv, ntohl(*pid), 0);
+	if (unlikely(ret < 0))
+		goto free_req;
+
+	/* point to encapsulated IP packet */
+	__skb_pull(skb, payload_offset);
+
+free_req:
+	aead_request_free(req);
+	return ret;
+}
+
+/* Initialize a struct crypto_aead object */
+struct crypto_aead *ovpn_aead_init(const char *title, const char *alg_name,
+				   const unsigned char *key, unsigned int keylen)
+{
+	struct crypto_aead *aead;
+	int ret;
+
+	aead = crypto_alloc_aead(alg_name, 0, 0);
+	if (IS_ERR(aead)) {
+		ret = PTR_ERR(aead);
+		pr_err("%s crypto_alloc_aead failed, err=%d\n", title, ret);
+		aead = NULL;
+		goto error;
+	}
+
+	ret = crypto_aead_setkey(aead, key, keylen);
+	if (ret) {
+		pr_err("%s crypto_aead_setkey size=%u failed, err=%d\n", title, keylen, ret);
+		goto error;
+	}
+
+	ret = crypto_aead_setauthsize(aead, AUTH_TAG_SIZE);
+	if (ret) {
+		pr_err("%s crypto_aead_setauthsize failed, err=%d\n", title, ret);
+		goto error;
+	}
+
+	/* basic AEAD assumption */
+	if (crypto_aead_ivsize(aead) != NONCE_SIZE) {
+		pr_err("%s IV size must be %d\n", title, NONCE_SIZE);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	pr_debug("********* Cipher %s (%s)\n", alg_name, title);
+	pr_debug("*** IV size=%u\n", crypto_aead_ivsize(aead));
+	pr_debug("*** req size=%u\n", crypto_aead_reqsize(aead));
+	pr_debug("*** block size=%u\n", crypto_aead_blocksize(aead));
+	pr_debug("*** auth size=%u\n", crypto_aead_authsize(aead));
+	pr_debug("*** alignmask=0x%x\n", crypto_aead_alignmask(aead));
+
+	return aead;
+
+error:
+	crypto_free_aead(aead);
+	return ERR_PTR(ret);
+}
+
+void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
+{
+	if (!ks)
+		return;
+
+	crypto_free_aead(ks->encrypt);
+	crypto_free_aead(ks->decrypt);
+	kfree(ks);
+}
+
+static struct ovpn_crypto_key_slot *
+ovpn_aead_crypto_key_slot_init(enum ovpn_cipher_alg alg,
+			       const unsigned char *encrypt_key,
+			       unsigned int encrypt_keylen,
+			       const unsigned char *decrypt_key,
+			       unsigned int decrypt_keylen,
+			       const unsigned char *encrypt_nonce_tail,
+			       unsigned int encrypt_nonce_tail_len,
+			       const unsigned char *decrypt_nonce_tail,
+			       unsigned int decrypt_nonce_tail_len,
+			       u16 key_id)
+{
+	struct ovpn_crypto_key_slot *ks = NULL;
+	const char *alg_name;
+	int ret;
+
+	/* validate crypto alg */
+	switch (alg) {
+	case OVPN_CIPHER_ALG_AES_GCM:
+		alg_name = "gcm(aes)";
+		break;
+	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+		alg_name = "rfc7539(chacha20,poly1305)";
+		break;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	/* build the key slot */
+	ks = kmalloc(sizeof(*ks), GFP_KERNEL);
+	if (!ks)
+		return ERR_PTR(-ENOMEM);
+
+	ks->encrypt = NULL;
+	ks->decrypt = NULL;
+	kref_init(&ks->refcount);
+	ks->key_id = key_id;
+
+	ks->encrypt = ovpn_aead_init("encrypt", alg_name, encrypt_key,
+				     encrypt_keylen);
+	if (IS_ERR(ks->encrypt)) {
+		ret = PTR_ERR(ks->encrypt);
+		ks->encrypt = NULL;
+		goto destroy_ks;
+	}
+
+	ks->decrypt = ovpn_aead_init("decrypt", alg_name, decrypt_key,
+				     decrypt_keylen);
+	if (IS_ERR(ks->decrypt)) {
+		ret = PTR_ERR(ks->decrypt);
+		ks->decrypt = NULL;
+		goto destroy_ks;
+	}
+
+	if (sizeof(struct ovpn_nonce_tail) != encrypt_nonce_tail_len ||
+	    sizeof(struct ovpn_nonce_tail) != decrypt_nonce_tail_len) {
+		ret = -EINVAL;
+		goto destroy_ks;
+	}
+
+	memcpy(ks->nonce_tail_xmit.u8, encrypt_nonce_tail,
+	       sizeof(struct ovpn_nonce_tail));
+	memcpy(ks->nonce_tail_recv.u8, decrypt_nonce_tail,
+	       sizeof(struct ovpn_nonce_tail));
+
+	/* init packet ID generation/validation */
+	ovpn_pktid_xmit_init(&ks->pid_xmit);
+	ovpn_pktid_recv_init(&ks->pid_recv);
+
+	return ks;
+
+destroy_ks:
+	ovpn_aead_crypto_key_slot_destroy(ks);
+	return ERR_PTR(ret);
+}
+
+struct ovpn_crypto_key_slot *
+ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
+{
+	return ovpn_aead_crypto_key_slot_init(kc->cipher_alg,
+					      kc->encrypt.cipher_key,
+					      kc->encrypt.cipher_key_size,
+					      kc->decrypt.cipher_key,
+					      kc->decrypt.cipher_key_size,
+					      kc->encrypt.nonce_tail,
+					      kc->encrypt.nonce_tail_size,
+					      kc->decrypt.nonce_tail,
+					      kc->decrypt.nonce_tail_size,
+					      kc->key_id);
+}
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
new file mode 100644
index 000000000000..ba5e3f86df83
--- /dev/null
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNAEAD_H_
+#define _NET_OVPN_OVPNAEAD_H_
+
+#include "crypto.h"
+
+#include <asm/types.h>
+#include <linux/skbuff.h>
+
+struct crypto_aead *ovpn_aead_init(const char *title, const char *alg_name,
+				   const unsigned char *key, unsigned int keylen);
+
+int ovpn_aead_encrypt(struct ovpn_crypto_key_slot *ks, struct sk_buff *skb, u32 peer_id);
+int ovpn_aead_decrypt(struct ovpn_crypto_key_slot *ks, struct sk_buff *skb);
+
+struct ovpn_crypto_key_slot *ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
+void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
+
+#endif /* _NET_OVPN_OVPNAEAD_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 59a6e532bb8b..6c469fedb89a 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -7,10 +7,13 @@
  *		Antonio Quartulli <antonio@openvpn.net>
  */
 
+#include "crypto.h"
+#include "crypto_aead.h"
 #include "io.h"
 #include "ovpnstruct.h"
 #include "netlink.h"
 #include "peer.h"
+#include "proto.h"
 #include "udp.h"
 
 #include <linux/netdevice.h>
@@ -113,6 +116,25 @@ int ovpn_napi_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+/* Return IP protocol version from skb header.
+ * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
+ */
+static __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
+{
+	__be16 proto = 0;
+
+	/* skb could be non-linear, make sure IP header is in non-fragmented part */
+	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+		return 0;
+
+	if (ip_hdr(skb)->version == 4)
+		proto = htons(ETH_P_IP);
+	else if (ip_hdr(skb)->version == 6)
+		proto = htons(ETH_P_IPV6);
+
+	return proto;
+}
+
 /* Entry point for processing an incoming packet (in skb form)
  *
  * Enqueue the packet and schedule RX consumer.
@@ -134,7 +156,72 @@ int ovpn_recv(struct ovpn_struct *ovpn, struct ovpn_peer *peer, struct sk_buff *
 
 static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	return true;
+	struct ovpn_peer *allowed_peer = NULL;
+	struct ovpn_crypto_key_slot *ks;
+	__be16 proto;
+	int ret = -1;
+	u8 key_id;
+
+	/* get the key slot matching the key Id in the received packet */
+	key_id = ovpn_key_id_from_skb(skb);
+	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
+	if (unlikely(!ks)) {
+		net_info_ratelimited("%s: no available key for peer %u, key-id: %u\n",
+				     peer->ovpn->dev->name, peer->id, key_id);
+		goto drop;
+	}
+
+	/* decrypt */
+	ret = ovpn_aead_decrypt(ks, skb);
+
+	ovpn_crypto_key_slot_put(ks);
+
+	if (unlikely(ret < 0)) {
+		net_err_ratelimited("%s: error during decryption for peer %u, key-id %u: %d\n",
+				    peer->ovpn->dev->name, peer->id, key_id, ret);
+		goto drop;
+	}
+
+	/* check if this is a valid datapacket that has to be delivered to the
+	 * tun interface
+	 */
+	skb_reset_network_header(skb);
+	proto = ovpn_ip_check_protocol(skb);
+	if (unlikely(!proto)) {
+		/* check if null packet */
+		if (unlikely(!pskb_may_pull(skb, 1))) {
+			netdev_dbg(peer->ovpn->dev, "NULL packet received from peer %u\n",
+				   peer->id);
+			ret = -EINVAL;
+			goto drop;
+		}
+
+		netdev_dbg(peer->ovpn->dev, "unsupported protocol received from peer %u\n",
+			   peer->id);
+
+		ret = -EPROTONOSUPPORT;
+		goto drop;
+	}
+	skb->protocol = proto;
+
+	/* perform Reverse Path Filtering (RPF) */
+	allowed_peer = ovpn_peer_lookup_by_src(peer->ovpn, skb);
+	if (unlikely(allowed_peer != peer)) {
+		net_dbg_ratelimited("%s: RPF dropped packet from peer %u\n",
+				    peer->ovpn->dev->name, peer->id);
+		ret = -EPERM;
+		goto drop;
+	}
+
+	ret = ptr_ring_produce_bh(&peer->netif_rx_ring, skb);
+drop:
+	if (likely(allowed_peer))
+		ovpn_peer_put(allowed_peer);
+
+	if (unlikely(ret < 0))
+		kfree_skb(skb);
+
+	return ret;
 }
 
 /* pick packet from RX queue, decrypt and forward it to the tun device */
@@ -162,7 +249,38 @@ void ovpn_decrypt_work(struct work_struct *work)
 
 static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	return true;
+	struct ovpn_crypto_key_slot *ks;
+	bool success = false;
+	int ret;
+
+	/* get primary key to be used for encrypting data */
+	ks = ovpn_crypto_key_slot_primary(&peer->crypto);
+	if (unlikely(!ks)) {
+		net_warn_ratelimited("%s: error while retrieving primary key slot for peer %u\n",
+				     peer->ovpn->dev->name, peer->id);
+		return false;
+	}
+
+	if (unlikely(skb->ip_summed == CHECKSUM_PARTIAL &&
+		     skb_checksum_help(skb))) {
+		net_err_ratelimited("%s: cannot compute checksum for outgoing packet\n",
+				    peer->ovpn->dev->name);
+		goto err;
+	}
+
+	/* encrypt */
+	ret = ovpn_aead_encrypt(ks, skb, peer->id);
+	if (unlikely(ret < 0)) {
+		net_err_ratelimited("%s: error during encryption for peer %u, key-id %u: %d\n",
+				    peer->ovpn->dev->name, peer->id, ks->key_id, ret);
+		goto err;
+	}
+
+	success = true;
+
+err:
+	ovpn_crypto_key_slot_put(ks);
+	return success;
 }
 
 /* Process packets in TX queue in a transport-specific way.
@@ -243,25 +361,6 @@ static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff *skb, struct
 	kfree_skb_list(skb);
 }
 
-/* Return IP protocol version from skb header.
- * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
- */
-static __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
-{
-	__be16 proto = 0;
-
-	/* skb could be non-linear, make sure IP header is in non-fragmented part */
-	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
-		return 0;
-
-	if (ip_hdr(skb)->version == 4)
-		proto = htons(ETH_P_IP);
-	else if (ip_hdr(skb)->version == 6)
-		proto = htons(ETH_P_IPV6);
-
-	return proto;
-}
-
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
diff --git a/drivers/net/ovpn/packet.h b/drivers/net/ovpn/packet.h
index 0c6c6165c63c..344a4f24c493 100644
--- a/drivers/net/ovpn/packet.h
+++ b/drivers/net/ovpn/packet.h
@@ -10,6 +10,8 @@
 #ifndef _NET_OVPN_PACKET_H_
 #define _NET_OVPN_PACKET_H_
 
+#include <linux/types.h>
+
 /* When the OpenVPN protocol is run in AEAD mode, use
  * the OpenVPN packet ID as the AEAD nonce:
  *
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 1ca59746ec69..01b994801393 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -8,6 +8,7 @@
  */
 
 #include "bind.h"
+#include "crypto.h"
 #include "io.h"
 #include "main.h"
 #include "netlink.h"
@@ -41,6 +42,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	peer->vpn_addrs.ipv6 = in6addr_any;
 
 	RCU_INIT_POINTER(peer->bind, NULL);
+	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
 
@@ -115,6 +117,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 {
 	struct ovpn_peer *peer = container_of(head, struct ovpn_peer, rcu);
 
+	ovpn_crypto_state_release(&peer->crypto);
 	ovpn_peer_free(peer);
 }
 
@@ -180,6 +183,24 @@ struct ovpn_peer *ovpn_peer_lookup_by_dst(struct ovpn_struct *ovpn, struct sk_bu
 	return peer;
 }
 
+struct ovpn_peer *ovpn_peer_lookup_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb)
+{
+	struct ovpn_peer *tmp, *peer = NULL;
+
+	/* in P2P mode, no matter the destination, packets are always sent to the single peer
+	 * listening on the other side
+	 */
+	if (ovpn->mode == OVPN_MODE_P2P) {
+		rcu_read_lock();
+		tmp = rcu_dereference(ovpn->peer);
+		if (likely(tmp && ovpn_peer_hold(tmp)))
+			peer = tmp;
+		rcu_read_unlock();
+	}
+
+	return peer;
+}
+
 static bool ovpn_peer_skb_to_sockaddr(struct sk_buff *skb, struct sockaddr_storage *ss)
 {
 	struct sockaddr_in6 *sa6;
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 8279af12dd09..03793f68a62b 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -11,6 +11,7 @@
 #define _NET_OVPN_OVPNPEER_H_
 
 #include "bind.h"
+#include "crypto.h"
 #include "socket.h"
 
 #include <linux/ptr_ring.h>
@@ -42,6 +43,8 @@ struct ovpn_peer {
 
 	struct ovpn_socket *sock;
 
+	struct ovpn_crypto_state crypto;
+
 	struct dst_cache dst_cache;
 
 	/* our binding to peer, protected by spinlock */
diff --git a/drivers/net/ovpn/pktid.c b/drivers/net/ovpn/pktid.c
new file mode 100644
index 000000000000..5392b28c79a7
--- /dev/null
+++ b/drivers/net/ovpn/pktid.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#include "pktid.h"
+
+#include <linux/atomic.h>
+#include <linux/jiffies.h>
+
+void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid)
+{
+	atomic64_set(&pid->seq_num, 1);
+}
+
+void ovpn_pktid_recv_init(struct ovpn_pktid_recv *pr)
+{
+	memset(pr, 0, sizeof(*pr));
+	spin_lock_init(&pr->lock);
+}
+
+/* Packet replay detection.
+ * Allows ID backtrack of up to REPLAY_WINDOW_SIZE - 1.
+ */
+int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
+{
+	const unsigned long now = jiffies;
+	int ret;
+
+	spin_lock(&pr->lock);
+
+	/* expire backtracks at or below pr->id after PKTID_RECV_EXPIRE time */
+	if (unlikely(time_after_eq(now, pr->expire)))
+		pr->id_floor = pr->id;
+
+	/* ID must not be zero */
+	if (unlikely(pkt_id == 0)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* time changed? */
+	if (unlikely(pkt_time != pr->time)) {
+		if (pkt_time > pr->time) {
+			/* time moved forward, accept */
+			pr->base = 0;
+			pr->extent = 0;
+			pr->id = 0;
+			pr->time = pkt_time;
+			pr->id_floor = 0;
+		} else {
+			/* time moved backward, reject */
+			ret = -ETIME;
+			goto out;
+		}
+	}
+
+	if (likely(pkt_id == pr->id + 1)) {
+		/* well-formed ID sequence (incremented by 1) */
+		pr->base = REPLAY_INDEX(pr->base, -1);
+		pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+		if (pr->extent < REPLAY_WINDOW_SIZE)
+			++pr->extent;
+		pr->id = pkt_id;
+	} else if (pkt_id > pr->id) {
+		/* ID jumped forward by more than one */
+		const unsigned int delta = pkt_id - pr->id;
+
+		if (delta < REPLAY_WINDOW_SIZE) {
+			unsigned int i;
+
+			pr->base = REPLAY_INDEX(pr->base, -delta);
+			pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+			pr->extent += delta;
+			if (pr->extent > REPLAY_WINDOW_SIZE)
+				pr->extent = REPLAY_WINDOW_SIZE;
+			for (i = 1; i < delta; ++i) {
+				unsigned int newb = REPLAY_INDEX(pr->base, i);
+
+				pr->history[newb / 8] &= ~BIT(newb % 8);
+			}
+		} else {
+			pr->base = 0;
+			pr->extent = REPLAY_WINDOW_SIZE;
+			memset(pr->history, 0, sizeof(pr->history));
+			pr->history[0] = 1;
+		}
+		pr->id = pkt_id;
+	} else {
+		/* ID backtrack */
+		const unsigned int delta = pr->id - pkt_id;
+
+		if (delta > pr->max_backtrack)
+			pr->max_backtrack = delta;
+		if (delta < pr->extent) {
+			if (pkt_id > pr->id_floor) {
+				const unsigned int ri = REPLAY_INDEX(pr->base,
+								     delta);
+				u8 *p = &pr->history[ri / 8];
+				const u8 mask = (1 << (ri % 8));
+
+				if (*p & mask) {
+					ret = -EINVAL;
+					goto out;
+				}
+				*p |= mask;
+			} else {
+				ret = -EINVAL;
+				goto out;
+			}
+		} else {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	pr->expire = now + PKTID_RECV_EXPIRE;
+	ret = 0;
+out:
+	spin_unlock(&pr->lock);
+	return ret;
+}
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
new file mode 100644
index 000000000000..965a7e492ebc
--- /dev/null
+++ b/drivers/net/ovpn/pktid.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNPKTID_H_
+#define _NET_OVPN_OVPNPKTID_H_
+
+#include "packet.h"
+
+#include <linux/atomic.h>
+#include <linux/bits.h>
+#include <linux/spinlock.h>
+
+/* If no packets received for this length of time, set a backtrack floor
+ * at highest received packet ID thus far.
+ */
+#define PKTID_RECV_EXPIRE (30 * HZ)
+
+/* Packet-ID state for transmitter */
+struct ovpn_pktid_xmit {
+	atomic64_t seq_num;
+};
+
+/* replay window sizing in bytes = 2^REPLAY_WINDOW_ORDER */
+#define REPLAY_WINDOW_ORDER 8
+
+#define REPLAY_WINDOW_BYTES BIT(REPLAY_WINDOW_ORDER)
+#define REPLAY_WINDOW_SIZE  (REPLAY_WINDOW_BYTES * 8)
+#define REPLAY_INDEX(base, i) (((base) + (i)) & (REPLAY_WINDOW_SIZE - 1))
+
+/* Packet-ID state for receiver.
+ * Other than lock member, can be zeroed to initialize.
+ */
+struct ovpn_pktid_recv {
+	/* "sliding window" bitmask of recent packet IDs received */
+	u8 history[REPLAY_WINDOW_BYTES];
+	/* bit position of deque base in history */
+	unsigned int base;
+	/* extent (in bits) of deque in history */
+	unsigned int extent;
+	/* expiration of history in jiffies */
+	unsigned long expire;
+	/* highest sequence number received */
+	u32 id;
+	/* highest time stamp received */
+	u32 time;
+	/* we will only accept backtrack IDs > id_floor */
+	u32 id_floor;
+	unsigned int max_backtrack;
+	/* protects entire pktd ID state */
+	spinlock_t lock;
+};
+
+/* Get the next packet ID for xmit */
+static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u32 *pktid)
+{
+	const s64 seq_num = atomic64_fetch_add_unless(&pid->seq_num, 1,
+						      0x100000000LL);
+	/* when the 32bit space is over, we return an error because the packet ID is used to create
+	 * the cipher IV and we do not want to re-use the same value more than once
+	 */
+	if (unlikely(seq_num == 0x100000000LL))
+		return -ERANGE;
+
+	*pktid = (u32)seq_num;
+
+	return 0;
+}
+
+/* Write 12-byte AEAD IV to dest */
+static inline void ovpn_pktid_aead_write(const u32 pktid,
+					 const struct ovpn_nonce_tail *nt,
+					 unsigned char *dest)
+{
+	*(__force __be32 *)(dest) = htonl(pktid);
+	BUILD_BUG_ON(4 + sizeof(struct ovpn_nonce_tail) != NONCE_SIZE);
+	memcpy(dest + 4, nt->u8, sizeof(struct ovpn_nonce_tail));
+}
+
+void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid);
+void ovpn_pktid_recv_init(struct ovpn_pktid_recv *pr);
+
+int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time);
+
+#endif /* _NET_OVPN_OVPNPKTID_H_ */
-- 
2.43.0


