Return-Path: <netdev+bounces-93568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DD08BC54F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B051AB209C8
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9644C7A;
	Mon,  6 May 2024 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JivxH7MA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9D43AD2
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958150; cv=none; b=SRbrfYDu9sF6EJwDM5JSQwLfhpg87waIezSAl6QleG2aSmS2bvsaGQsYJKB/mpWPqkHkbzym41MmPUHFl89cveRCr9mzqCogUIlAR1KjXDcxgmogMNVC0z5I2xXo054YbnlGoDu/c0zQmyTvawTkYmHsTlmuiZ0iO9Bu52i9wCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958150; c=relaxed/simple;
	bh=mgr87Yyt9aSxT3ifn1EcDDiI5VsRW5xqoyDS8uRK0SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6Wc6VSi4Y5NjlJW1juyq9thxcx0CccDXa5gT7JazHYJmgC7c6vpSC5PfbcdVP69ApO8ubaP1i06cx3ZULMF8V/3ewC9guOPRI86IfzhFXSvuZSWEoovy00fY+DtW2d/bDDPwBEEq1jEWPj7ZVN/wWAMtR90/bVZSXON9w2yJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JivxH7MA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34da04e44a2so786371f8f.1
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958145; x=1715562945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDB+lU6ubvsGa4lnbbhLZ0fg59wGMWoIiuK+YXhg7yg=;
        b=JivxH7MAIU4Q5sX8kkJegRQbt1jvpterdeCHI7XqlHmFJ6N+nDio70uf35KPRJHShn
         uhBzl+NWiIqFNHFSPorV+oaD4bqQuF+PlE049C1ektnKRz6EYLh525BBoG2trwMJFWrD
         PaHF7Yezk9VL3hMEkurXPi0phecYSSg2bKno1Fj54XJ2/GsDLGsnTP+G4lLUWv1TTpRz
         ir88erJkvqjEACob+o5Iarx3b9wWAOJQIj1iqUW4WmqaTX0cvJqEbUPnWX56yKu0nqg3
         ikhUH8pxfC/xftZQi0NtwKNfOHMrCL7JaqOn91gFO/XvL2sR9ZEejaCvGnyRPqwyAMqe
         PIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958145; x=1715562945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDB+lU6ubvsGa4lnbbhLZ0fg59wGMWoIiuK+YXhg7yg=;
        b=wDOHTIRXxt8lojgo+UH43Xd5yTb3tUfnVRYCoHyhNV2Brhm5ANCwMKofwZtg13cWw3
         9X4UX130V4iN0mE8KhUy3i3+Kzz79/ckLoYX0GmxUJs/DNZbaosQgbvTjSTYxHAbfawc
         +OF/LKNYqkqZSe1NEehvCZNuPOBIoxxotcEeh90JYjc+rLmLzTC/BRwqQ6p35hWbAKqJ
         T3qFK3kObjhEm2nTXUkdgwG/ic9WlABlwmeyU/Dl2ckiPSC40rQcfc+i12lTri7LQOzI
         XpMChH1hyoLatTfQXctZ/W5ps48Afbn+n1dQbW3t1VQn5C+JmNbrqzyNSoUrVq+5odjM
         zx2A==
X-Gm-Message-State: AOJu0YxVRPqicN56Uwt7oxY03ZO1hQ93lzlzXmkzrOPKbes4NYhaT21L
	ZgRTwW7PrbrGMuiBia3uyR5K3t5Rs9CzltM5fxkZAZVJbmU7V0JJA3xhiSUgJGD3uQ9u067iWzk
	X
X-Google-Smtp-Source: AGHT+IHN9vp8Ma03LY7PLCEbZE1XpaBBk1wf0H8FriAvOCYUnrQGX/YfUgJ701DyJ6M0bCRJhSPU0g==
X-Received: by 2002:a5d:66ca:0:b0:34d:99ad:a52f with SMTP id k10-20020a5d66ca000000b0034d99ada52fmr5657648wrw.1.1714958144809;
        Sun, 05 May 2024 18:15:44 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:44 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 11/24] ovpn: implement packet processing
Date: Mon,  6 May 2024 03:16:24 +0200
Message-ID: <20240506011637.27272-12-antonio@openvpn.net>
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

This change implements encryption/decryption and
encapsulation/decapsulation of OpenVPN packets.

Support for generic crypto state is added along with
a wrapper for the AEAD crypto kernel API.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile      |   3 +
 drivers/net/ovpn/bind.c        |   1 +
 drivers/net/ovpn/crypto.c      | 162 ++++++++++++++
 drivers/net/ovpn/crypto.h      | 138 ++++++++++++
 drivers/net/ovpn/crypto_aead.c | 378 +++++++++++++++++++++++++++++++++
 drivers/net/ovpn/crypto_aead.h |  30 +++
 drivers/net/ovpn/io.c          | 158 +++++++++++---
 drivers/net/ovpn/packet.h      |   2 +-
 drivers/net/ovpn/peer.c        |  24 +++
 drivers/net/ovpn/peer.h        |  14 ++
 drivers/net/ovpn/pktid.c       | 132 ++++++++++++
 drivers/net/ovpn/pktid.h       |  85 ++++++++
 drivers/net/ovpn/socket.c      |   1 +
 drivers/net/ovpn/udp.c         |   1 +
 14 files changed, 1104 insertions(+), 25 deletions(-)
 create mode 100644 drivers/net/ovpn/crypto.c
 create mode 100644 drivers/net/ovpn/crypto.h
 create mode 100644 drivers/net/ovpn/crypto_aead.c
 create mode 100644 drivers/net/ovpn/crypto_aead.h
 create mode 100644 drivers/net/ovpn/pktid.c
 create mode 100644 drivers/net/ovpn/pktid.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 56bddc9bef83..ccdaeced1982 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -8,10 +8,13 @@
 
 obj-$(CONFIG_OVPN) := ovpn.o
 ovpn-y += bind.o
+ovpn-y += crypto.o
+ovpn-y += crypto_aead.o
 ovpn-y += main.o
 ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += netlink-gen.o
 ovpn-y += peer.o
+ovpn-y += pktid.o
 ovpn-y += socket.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
index c1f842c06e32..7240d1036fb7 100644
--- a/drivers/net/ovpn/bind.c
+++ b/drivers/net/ovpn/bind.c
@@ -13,6 +13,7 @@
 #include "ovpnstruct.h"
 #include "io.h"
 #include "bind.h"
+#include "packet.h"
 #include "peer.h"
 
 struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
new file mode 100644
index 000000000000..98ef1ceb75e0
--- /dev/null
+++ b/drivers/net/ovpn/crypto.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/types.h>
+#include <linux/net.h>
+#include <linux/netdevice.h>
+//#include <linux/skbuff.h>
+#include <uapi/linux/ovpn.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "packet.h"
+#include "pktid.h"
+#include "crypto_aead.h"
+#include "crypto.h"
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
+	ks = rcu_replace_pointer(cs->primary, NULL,
+				 lockdep_is_held(&cs->mutex));
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
index 000000000000..0b6796850e60
--- /dev/null
+++ b/drivers/net/ovpn/crypto.h
@@ -0,0 +1,138 @@
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
+	/* when both key slots are occupied but no matching key ID is found, ks
+	 * has to be reset to NULL to avoid carrying a stale pointer
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
index 000000000000..bb6c2a17d5b1
--- /dev/null
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <crypto/aead.h>
+#include <linux/skbuff.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/udp.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "packet.h"
+#include "pktid.h"
+#include "crypto_aead.h"
+#include "crypto.h"
+#include "proto.h"
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
+int ovpn_aead_encrypt(struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
+		      u32 peer_id)
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
+	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
+	 * nonce
+	 */
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
+	 * This is required because this area is directly mapped into the sg
+	 * list.
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
+				   const unsigned char *key,
+				   unsigned int keylen)
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
+		pr_err("%s crypto_aead_setkey size=%u failed, err=%d\n", title,
+		       keylen, ret);
+		goto error;
+	}
+
+	ret = crypto_aead_setauthsize(aead, AUTH_TAG_SIZE);
+	if (ret) {
+		pr_err("%s crypto_aead_setauthsize failed, err=%d\n", title,
+		       ret);
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
index 000000000000..c876e6a711cd
--- /dev/null
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -0,0 +1,30 @@
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
+				   const unsigned char *key,
+				   unsigned int keylen);
+
+int ovpn_aead_encrypt(struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
+		      u32 peer_id);
+int ovpn_aead_decrypt(struct ovpn_crypto_key_slot *ks, struct sk_buff *skb);
+
+struct ovpn_crypto_key_slot *
+ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
+void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
+
+#endif /* _NET_OVPN_OVPNAEAD_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9935a863bffe..66a4c551c191 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -12,9 +12,13 @@
 #include <net/gso.h>
 
 #include "ovpnstruct.h"
-#include "peer.h"
 #include "io.h"
+#include "packet.h"
+#include "peer.h"
+#include "crypto.h"
+#include "crypto_aead.h"
 #include "netlink.h"
+#include "proto.h"
 #include "udp.h"
 
 int ovpn_struct_init(struct net_device *dev)
@@ -110,6 +114,27 @@ int ovpn_napi_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+/* Return IP protocol version from skb header.
+ * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
+ */
+static __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
+{
+	__be16 proto = 0;
+
+	/* skb could be non-linear, make sure IP header is in non-fragmented
+	 * part
+	 */
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
@@ -132,7 +157,81 @@ int ovpn_recv(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
 
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
+				    peer->ovpn->dev->name, peer->id, key_id,
+				    ret);
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
+			netdev_dbg(peer->ovpn->dev,
+				   "NULL packet received from peer %u\n",
+				   peer->id);
+			ret = -EINVAL;
+			goto drop;
+		}
+
+		netdev_dbg(peer->ovpn->dev,
+			   "unsupported protocol received from peer %u\n",
+			   peer->id);
+
+		ret = -EPROTONOSUPPORT;
+		goto drop;
+	}
+	skb->protocol = proto;
+
+	/* perform Reverse Path Filtering (RPF) */
+	allowed_peer = ovpn_peer_get_by_src(peer->ovpn, skb);
+	if (unlikely(allowed_peer != peer)) {
+		if (skb_protocol_to_family(skb) == AF_INET6)
+			net_warn_ratelimited("%s: RPF dropped packet from peer %u, src: %pI6c\n",
+					     peer->ovpn->dev->name, peer->id,
+					     &ipv6_hdr(skb)->saddr);
+		else
+			net_warn_ratelimited("%s: RPF dropped packet from peer %u, src: %pI4\n",
+					     peer->ovpn->dev->name, peer->id,
+					     &ip_hdr(skb)->saddr);
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
 
 /* pick next packet from RX queue, decrypt and forward it to the device */
@@ -160,7 +259,39 @@ void ovpn_decrypt_work(struct work_struct *work)
 
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
+				    peer->ovpn->dev->name, peer->id, ks->key_id,
+				    ret);
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
@@ -245,27 +376,6 @@ static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff *skb,
 	kfree_skb_list(skb);
 }
 
-/* Return IP protocol version from skb header.
- * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
- */
-static __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
-{
-	__be16 proto = 0;
-
-	/* skb could be non-linear, make sure IP header is in non-fragmented
-	 * part
-	 */
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
index 7ed146f5932a..e14c9bf464f7 100644
--- a/drivers/net/ovpn/packet.h
+++ b/drivers/net/ovpn/packet.h
@@ -10,7 +10,7 @@
 #ifndef _NET_OVPN_PACKET_H_
 #define _NET_OVPN_PACKET_H_
 
-/* When the OpenVPN protocol is ran in AEAD mode, use
+/* When the OpenVPN protocol is run in AEAD mode, use
  * the OpenVPN packet ID as the AEAD nonce:
  *
  *    00000005 521c3b01 4308c041
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 4e5bb659f169..1b941deeede0 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -13,6 +13,9 @@
 
 #include "ovpnstruct.h"
 #include "bind.h"
+#include "packet.h"
+#include "pktid.h"
+#include "crypto.h"
 #include "io.h"
 #include "main.h"
 #include "netlink.h"
@@ -36,6 +39,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	peer->vpn_addrs.ipv6 = in6addr_any;
 
 	RCU_INIT_POINTER(peer->bind, NULL);
+	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
 
@@ -122,6 +126,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 {
 	struct ovpn_peer *peer = container_of(head, struct ovpn_peer, rcu);
 
+	ovpn_crypto_state_release(&peer->crypto);
 	ovpn_peer_free(peer);
 }
 
@@ -334,6 +339,25 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 	return peer;
 }
 
+struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_struct *ovpn,
+				       struct sk_buff *skb)
+{
+	struct ovpn_peer *tmp, *peer = NULL;
+
+	/* in P2P mode, no matter the destination, packets are always sent to
+	 * the single peer listening on the other side
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
 /**
  * ovpn_peer_add_p2p - add per to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index f8b2157b416f..da41d711745c 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -11,6 +11,8 @@
 #define _NET_OVPN_OVPNPEER_H_
 
 #include "bind.h"
+#include "pktid.h"
+#include "crypto.h"
 #include "socket.h"
 
 #include <linux/ptr_ring.h>
@@ -30,6 +32,7 @@
  * @netif_rx_ring: queue of packets to be sent to the netdevice via NAPI
  * @napi: NAPI object
  * @sock: the socket being used to talk to this peer
+ * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @halt: true if ovpn_peer_mark_delete was called
@@ -53,6 +56,7 @@ struct ovpn_peer {
 	struct ptr_ring netif_rx_ring;
 	struct napi_struct napi;
 	struct ovpn_socket *sock;
+	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	bool halt;
@@ -160,4 +164,14 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id);
 struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 				       struct sk_buff *skb);
 
+/**
+ * ovpn_peer_get_by_src - retrieve peer by matching skb source address
+ * @ovpn: the openvpn instance to search
+ * @skb: the packet to use for matching
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_struct *ovpn,
+				       struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/pktid.c b/drivers/net/ovpn/pktid.c
new file mode 100644
index 000000000000..f1fc4ead3336
--- /dev/null
+++ b/drivers/net/ovpn/pktid.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#include <linux/atomic.h>
+#include <linux/jiffies.h>
+#include <linux/net.h>
+#include <linux/netdevice.h>
+#include <linux/types.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "packet.h"
+#include "pktid.h"
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
index 000000000000..c7356f5cb12b
--- /dev/null
+++ b/drivers/net/ovpn/pktid.h
@@ -0,0 +1,85 @@
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
+	/* when the 32bit space is over, we return an error because the packet
+	 * ID is used to create the cipher IV and we do not want to reuse the
+	 * same value more than once
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
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 2ae04e883e13..e099a61b03fa 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -13,6 +13,7 @@
 #include "ovpnstruct.h"
 #include "main.h"
 #include "io.h"
+#include "packet.h"
 #include "peer.h"
 #include "socket.h"
 #include "udp.h"
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 07182703e598..c2a88d26defd 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -19,6 +19,7 @@
 #include "main.h"
 #include "bind.h"
 #include "io.h"
+#include "packet.h"
 #include "peer.h"
 #include "proto.h"
 #include "socket.h"
-- 
2.43.2


