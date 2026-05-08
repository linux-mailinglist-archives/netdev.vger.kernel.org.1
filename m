Return-Path: <netdev+bounces-285875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ALQFvH5/WnYlQAAu9opvQ
	(envelope-from <netdev+bounces-285875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:57:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1794F832F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AA513095542
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C253FBEAA;
	Fri,  8 May 2026 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX7Gf+7m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBFD3FB7D5
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252045; cv=none; b=d+ArBeV2MKNzMPGqWQN/v82UWD0Dr9JmzHd9XAKTwC4X8Oxhx1Nx66e1ALlSgOGSFbxlAwL9S+1GemaYbXu8w2NzieL/vnZKBIPwUf2M9OKvvKAIOzHh3hUpx8D7SR7CMm2QpJ3acBmil3aBHytORK9/07R0WQMuOt8VucVVvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252045; c=relaxed/simple;
	bh=EicQdT3c6J+Vumm9/+ppdAXyUo5a0VPkbIng1VxcDLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xgh/mfrY1nCllgPYO6J3OWPdia4Q/mVp2+X8znT+A1L8yVslEZZlNTOlSwwoi5qvDCYKMiUeW0I8vvVlxamHtEqkBFJgOnSiAQaQMSoSq5SHg1bJJC/MisSSao9C8OZJmBwCnB5R0TdXgWlq/pIFnn87Sa6JikbhOHKwouLKpMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX7Gf+7m; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4756e74f8edso1466242b6e.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252043; x=1778856843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbANzqSWAbJg10BPC4Wd4ggqpW76AexGUgGB0zbc/mU=;
        b=JX7Gf+7mxJ4nfAMcA9qOJ0vyg7Rgwbc91jnfBavfyh9embFSvvoa2DnvdywlAMmElh
         TlDlSdTDdKTssmaR0pN13I+7Pf4fph6kXWcKdVDRF3R8XBfCE5Wx93ObUeLi3Bh77Xpd
         If5tA3zpKiBDfck1mNkf+Byps5PEf2iCpJZAr9PR27a6shxdTRqunY3uVQ0fHe1DsdCx
         ukb5miRUAwwPKuBzZxcUUdeBS5xs7uG/ihslrR/HEfBxqIYCEf1nvqGx3IhfmwqEfJWW
         GQoDYWOFP8cL6Q6BDDj1FyEFXQN5hZ6lLNQTe7YOR0qQAfvcCr6/8LR3ZfNWWkOEh7E7
         mVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252043; x=1778856843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dbANzqSWAbJg10BPC4Wd4ggqpW76AexGUgGB0zbc/mU=;
        b=dpYckDpCF8v1aN3JRaYhhns+pP/3EHn25mzax2Yf6Vps9GCS28fk987nLGPfX5ldO8
         x0q+FimvIFMQskuFQBSDxNDXZ0cV+DP4XmlP2YDigDyzU5d0Rd3wSeaIHCfOsgEB/ZV/
         CjJ+cUj8lLHeCiqvALRAe8gPMZ1HwygxxyB/DoUY4i6zvfT4P6Vw0Q4wyzO65GyLm3ZT
         M2Lo6zdm1GoYvFQAAJmtUB/tIfmWj8xBr0MvwGiLn/HcqcFHLRZNv10aauJGXqEAiLjc
         1G1f+nfHV91kWo6DHhULRLiGJJI0/0c0OTXs3pSHRak1jW4uBRLJfpMgft+vZC4sI21o
         dpAg==
X-Gm-Message-State: AOJu0YwQNXp+SNKEGLkAY11MNqk/uS+9VlNpvI83XbjAv5NsessXbn35
	h2dCq7j8yFyh6stQkd8REy7FdQWevICDGicLWv8IoWF3HmxCiqmH/8B52+5SUw==
X-Gm-Gg: AeBDievhrgZgz1vCfoMxzBe7W34MLS0ujGG16Y2tShvs8nkEAmypRkVNzaodpW884nc
	WQaabnksYk8MNaZxZ1z1TtVe8998sK69Sehjdz00E3lCoIKyeQH0A1trnm5t3p5EudLEj9KJqKZ
	98vBaG7TzbCnSAWlCZxwrmVxRljKMCLbTkWMrgtKkfir3e+2PAv+5QcHpZEr/tUcuQdSkHd0ci8
	R1op8wK6Yi405YMSzy5Ky23ODA2igcMHhTqU+MRrqFuHhuY90O3YoLXKq7Yr21rq+e2zfh+zudx
	3hM3ENejUOODoWdmO7HImb/GyvdbFcSaZi3y7YgOKlK3dRlAMMsc04kZBNGffQ9TV3SDl5n/2iC
	5nI0/TONEw4XCP7Dn3E6R71tmLSq5IzYbihljYsyz2oXQ5chLQJ/cO3K18odrrF6SlQTUfTY8kj
	22v27QFuX6ofUDh1D7NqdIPimAP40EYc4QkvOWjNFaFWtcxSXx6w8=
X-Received: by 2002:a05:6808:6606:b0:479:dc28:b71d with SMTP id 5614622812f47-48042503b43mr8326241b6e.38.1778252042809;
        Fri, 08 May 2026 07:54:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986404sm14617049b6e.15.2026.05.08.07.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:54:02 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 08 May 2026 07:53:47 -0700
Subject: [PATCH net-next 4/6] netdevsim: psp: implement kdf from psp spec
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-nsim-psp-crypto-v1-4-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: CA1794F832F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285875-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Implement the PSP key derivation function (KDF) per the PSP
Architecture Spec.

The kdf is used to generate spi + session key pairs, and will also be
used in the rx path to re-derive the tx key used by the peer.

Also, remove support for psd->generation, as it is not needed for
netdevsim after removing the fake authentication hack.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/Kconfig               |  1 +
 drivers/net/netdevsim/netdevsim.h |  3 +++
 drivers/net/netdevsim/psp.c       | 55 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ff79c466712d..44a220c05536 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -610,6 +610,7 @@ config NETDEVSIM
 	select NET_DEVLINK
 	select PAGE_POOL
 	select NET_SHAPER
+	select CRYPTO_LIB_AES_CBC_MACS if INET_PSP
 	help
 	  This driver is a developer testing tool and software model that can
 	  be used to test various control path networking APIs, especially
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index dcea76429bac..112fe1ee10bc 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -38,6 +38,7 @@
 #define NSIM_IPSEC_VALID		BIT(31)
 #define NSIM_UDP_TUNNEL_N_PORTS		4
 
+#define NSIM_PSP_DEV_KEY_SIZE		32
 #define NSIM_HDS_THRESHOLD_MAX		1024
 
 struct nsim_sa {
@@ -123,6 +124,8 @@ struct netdevsim {
 		struct psp_dev __rcu *dev;
 		struct dentry *rereg;
 		struct mutex rereg_lock;
+		spinlock_t dev_keys_lock;
+		u8 dev_keys[2][NSIM_PSP_DEV_KEY_SIZE];
 		u32 spi;
 		u32 assoc_cnt;
 	} psp;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index e8831d4bf394..8cdb88b1e232 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -1,11 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <crypto/aes-cbc-macs.h>
+#include <linux/random.h>
 #include <linux/skbuff.h>
+#include <linux/unaligned.h>
 #include <net/psp.h>
 #include <net/sock.h>
 
 #include "netdevsim.h"
 
+/* Session key derivation from device key per PSP Architecture Spec */
+static void nsim_psp_derive_key(const u8 *dev_key, __be32 spi, u32 version,
+				u8 *derived_key)
+{
+	unsigned int key_size = psp_key_size(version);
+	struct aes_cmac_key key;
+	u8 block[16];
+
+	aes_cmac_preparekey(&key, dev_key, NSIM_PSP_DEV_KEY_SIZE);
+
+	block[0]  = 0x00;
+	block[1]  = 0x00;
+	block[2]  = 0x00;
+	block[3]  = 0x01;		/* counter */
+	block[4]  = 0x50;		/* 'P' */
+	block[5]  = 0x76;		/* 'v' */
+	block[6]  = 0x30 | version;	/* '0' + version */
+	block[7]  = 0x00;
+	memcpy(&block[8], &spi, sizeof(spi));
+	put_unaligned_be32(key_size * 8, &block[12]);
+
+	aes_cmac(&key, block, sizeof(block), derived_key);
+
+	if (key_size > 16) {
+		block[3] = 0x02;
+		aes_cmac(&key, block, sizeof(block), derived_key + 16);
+	}
+
+	memzero_explicit(&key, sizeof(key));
+}
+
 enum skb_drop_reason
 nsim_psp_handle_tx(struct sk_buff *skb, struct netdevsim *ns)
 {
@@ -155,7 +189,7 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
 		  struct netlink_ext_ack *extack)
 {
 	struct netdevsim *ns = psd->drv_priv;
-	int i;
+	unsigned int phase;
 
 	if ((ns->psp.spi ^ (ns->psp.spi + 1)) & PSP_SPI_KEY_PHASE) {
 		NL_SET_ERR_MSG(extack, "SPI space exhausted");
@@ -163,9 +197,11 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
 	}
 
 	assoc->spi = cpu_to_be32(++ns->psp.spi);
-	assoc->key[0] = psd->generation;
-	for (i = 1; i < PSP_MAX_KEY; i++)
-		assoc->key[i] = ns->psp.spi + i;
+	phase = !!(ns->psp.spi & PSP_SPI_KEY_PHASE);
+
+	/* dev_keys_lock not needed because of psd->lock */
+	nsim_psp_derive_key(ns->psp.dev_keys[phase], assoc->spi, version,
+			    assoc->key);
 
 	return 0;
 }
@@ -186,8 +222,15 @@ static int nsim_assoc_add(struct psp_dev *psd, struct psp_assoc *pas,
 static int nsim_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *extack)
 {
 	struct netdevsim *ns = psd->drv_priv;
+	unsigned int next_phase;
 
+	psd->generation = 0;
 	ns->psp.spi = (ns->psp.spi & PSP_SPI_KEY_PHASE) ^ PSP_SPI_KEY_PHASE;
+	next_phase = !!(ns->psp.spi & PSP_SPI_KEY_PHASE);
+
+	spin_lock_bh(&ns->psp.dev_keys_lock);
+	get_random_bytes(ns->psp.dev_keys[next_phase], NSIM_PSP_DEV_KEY_SIZE);
+	spin_unlock_bh(&ns->psp.dev_keys_lock);
 
 	return 0;
 }
@@ -295,6 +338,10 @@ int nsim_psp_init(struct netdevsim *ns)
 	struct dentry *ddir = ns->nsim_dev_port->ddir;
 	struct psp_dev *psd;
 
+	spin_lock_init(&ns->psp.dev_keys_lock);
+	get_random_bytes(ns->psp.dev_keys[0], NSIM_PSP_DEV_KEY_SIZE);
+	get_random_bytes(ns->psp.dev_keys[1], NSIM_PSP_DEV_KEY_SIZE);
+
 	psd = psp_dev_create(ns->netdev, &nsim_psp_ops, &nsim_psp_caps, ns);
 	if (IS_ERR(psd))
 		return PTR_ERR(psd);

-- 
2.52.0


