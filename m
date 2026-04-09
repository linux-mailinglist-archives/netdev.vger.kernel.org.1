Return-Path: <netdev+bounces-277077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDy7Hdve12klTwgAu9opvQ
	(envelope-from <netdev+bounces-277077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:16:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8083CDFEC
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 278963044A6D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14C23E121A;
	Thu,  9 Apr 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKHQOleb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F83E1D12
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754749; cv=none; b=YRvqHmN7ksw2oSps2OAC5xbG2pVzM1zcmnuJnGA6bSSVX+66ULZLyjWz4KleqzO5v9fO8bvDxi78jk7Slr7Piy48cp/ATDuUSlnfW3O4PyMWqPf43zpH2ICwvcRlU3lPUmPAt3N7hyeYNUwT6snW8Fpo15dwLML4ZjhCmac6tVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754749; c=relaxed/simple;
	bh=33BKGtv99YCHlFC84RXU206UHS5feYZDByPIWJfGB4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArCS0+w+PuGD5GbsXuXa8l9Pp5inzhs7PIKMo41nl5fFR8bEmr1vH2jnBRTeKlf/BHDZv55ZGwO8nSTI5Vq2n3tWWgY99QVIiGGxba8lWgafvjlSB/ZPJqrqdOHP5hR4LQ/caOPDW1MTupJU6xceJgTL5ad0WYzTwJDmzK1P4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKHQOleb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so825482a91.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775754747; x=1776359547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVudMn5DOWAnraSt8EcXAJqKne+FmaKhjEXBR4n3BFY=;
        b=GKHQOlebfTo+VdOJklityRTH9GeKdWjFK9ezvecWNtZIZY7byl8wPePWkntk9ocLpt
         o0vW4Hx4n3yFLvyKDTRHF08i9FpHn3iiJoXKTxsZXsWk08AsbAmBTkTyUgA0K+DVHwBh
         2chkQhGhy6zeIzYvmN1hOvRGrEnPd4im9tyy4HchOtIScb1jRdOxb48KdBzmitn5J0eu
         zMqzH/69853Ybmjs9KJ/X1glojVB1k1yBziU/0FVnDPwjdY9zwt25XGJM1qKJWretUXS
         4PmbFX0jEtgDSoVeyYU3yFOmoKedtPGYoo8iuFYoKaRKML2ESABTi6+HEtJtlVmthIe0
         PiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775754747; x=1776359547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVudMn5DOWAnraSt8EcXAJqKne+FmaKhjEXBR4n3BFY=;
        b=fjw3XNqp9OK5JdNTGwidtE8Z+5DPT1i2VfWZ8e8UqH2p1FP27TySTvQfjDYXe80OJa
         VqhWQatjmTc8Sdl5cNwwabwjSFYuz+jThaNsZdNJ9KWr3DP9qLontwqVpKCGYUQHGpVN
         YkW1/dgHcfSSwjsIvSGvTfy/rCGXv/dsZCRh3GRiWQa6Kg1IoPHQWjG0ZFJHzMg2r5J4
         OCGms9Rf784NndQCVFe1/a/na9rTjv0edpkg0L6fcG+qmZIrw/VhsWY/fOg8dy0hB/VV
         w25UEKw2TgyJ4AFzW6v0PnYCdJQqiGJvvYD9vkA28fbEkJBI3wpq5jx/hIbQ1/Qb1gIN
         Dp6g==
X-Gm-Message-State: AOJu0YxCWpKw7Y/cFyDPM/IaV/JDadYR6T10WSg0UzJdaRcguimv6eTd
	uG29yoRJutst0jds2JtziOh8y1gUiCtQmkmEQgsMpYdOTtjOMmojsTnkZh4UVsXo
X-Gm-Gg: AeBDievPJpJ83sYsqcG+L7AjskM5Ao3WAdoN63MOQBj5Xb+6e2ctCC2jIto5E7hvZQP
	CpaNjSOMIKeMo0+9KVfeWUofdh58E7pXO8UGucZokR55JFnNhRzeUeU7j13SmTEX5+kioWjogwB
	sJM8xs9Q1wXm9PzZO1kV9fpmvGh8SdVDCdsH/coPewZo9HdalFJyKU/Fj/K2V6Pwewqt9A1DflF
	wSbpZnPWhSG9zkvACKlGQNSyRdzM5UH2j1F2fXcwZm0kZKmoDvFXnblEZeC4TniBQvzzI1gg4FZ
	gzKDWSAHbAPK1KRCpdWm0Ppf9zx09yXimGaHbGfv1o5cfDCy2KtC/tAm1P6EOiviV74EuHLilpn
	bE6cZskheo2pSsuVlNWNidYMwo1nhzrsdjQvjLLbtvX+fhVP1MWziB+gSorlfZ7ldvA5Sp8+tDu
	mghtHQ9QO21kXLR6Ecpxna9z//nUKhg8nN+x7wft8/3CfyP7Kq
X-Received: by 2002:a17:90b:4a49:b0:35c:d37:6024 with SMTP id 98e67ed59e1d1-35e35791f8fmr4551963a91.11.1775754747184;
        Thu, 09 Apr 2026 10:12:27 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08d1bsm752395ad.54.2026.04.09.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:12:26 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/4] net: dsa: yt921x: Refactor long register helpers
Date: Fri, 10 Apr 2026 01:12:02 +0800
Message-ID: <20260409171209.2575583-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409171209.2575583-1-mmyangfl@gmail.com>
References: <20260409171209.2575583-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277077-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BF8083CDFEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dealing long registers with u64 is good, until you realize there are
longer 96-bit registers.

Refactor reg64 helpers to use u32 arrays instead of u64 values, in
preparation for 96-bit registers. We do not keep the separate u64
version for reg64 to avoid duplicated wrappers, although it looks better
when dealing with reg64 *only*.

Helpers for reg96 should be added when they are actually used to avoid
function unused warnings.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 162 +++++++++++++++++++++++++++------------
 drivers/net/dsa/yt921x.h |  36 ++++-----
 2 files changed, 129 insertions(+), 69 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 87139448bec3..0c07b903fd68 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -255,63 +255,122 @@ yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
 	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
 }
 
-/* Some registers, like VLANn_CTRL, should always be written in 64-bit, even if
- * you are to write only the lower / upper 32 bits.
+/* Some multi-word registers, like VLANn_CTRL, should be treated as a single
+ * long register. More specifically, writes to parts of its words won't become
+ * visible, until the last word is written.
  *
- * There is no such restriction for reading, but we still provide 64-bit read
- * wrappers so that we always handle u64 values.
+ * Here we require full read and write operations over these registers to
+ * eliminate potential issues, although partial reads/writes are also possible.
  */
 
-static int yt921x_reg64_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
+static int
+yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
+		 unsigned int num_regs)
 {
-	u32 lo;
-	u32 hi;
 	int res;
 
-	res = yt921x_reg_read(priv, reg, &lo);
-	if (res)
-		return res;
-	res = yt921x_reg_read(priv, reg + 4, &hi);
-	if (res)
-		return res;
+	for (unsigned int i = 0; i < num_regs; i++) {
+		res = yt921x_reg_read(priv, reg + 4 * i, &vals[i]);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_regs_write(struct yt921x_priv *priv, u32 reg, const u32 *vals,
+		  unsigned int num_regs)
+{
+	int res;
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		res = yt921x_reg_write(priv, reg + 4 * i, vals[i]);
+		if (res)
+			return res;
+	}
 
-	*valp = ((u64)hi << 32) | lo;
 	return 0;
 }
 
-static int yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, u64 val)
+static int
+yt921x_regs_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			const u32 *vals, unsigned int num_regs)
 {
+	bool changed = false;
+	u32 vs[4];
 	int res;
 
-	res = yt921x_reg_write(priv, reg, (u32)val);
+	BUILD_BUG_ON(num_regs > ARRAY_SIZE(vs));
+
+	res = yt921x_regs_read(priv, reg, vs, num_regs);
 	if (res)
 		return res;
-	return yt921x_reg_write(priv, reg + 4, (u32)(val >> 32));
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		u32 u = vs[i];
+
+		u &= ~masks[i];
+		u |= vals[i];
+		if (u != vs[i])
+			changed = true;
+
+		vs[i] = u;
+	}
+
+	if (!changed)
+		return 0;
+
+	return yt921x_regs_write(priv, reg, vs, num_regs);
 }
 
 static int
-yt921x_reg64_update_bits(struct yt921x_priv *priv, u32 reg, u64 mask, u64 val)
+yt921x_regs_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+		       unsigned int num_regs)
 {
+	bool changed = false;
+	u32 vs[4];
 	int res;
-	u64 v;
-	u64 u;
 
-	res = yt921x_reg64_read(priv, reg, &v);
+	BUILD_BUG_ON(num_regs > ARRAY_SIZE(vs));
+
+	res = yt921x_regs_read(priv, reg, vs, num_regs);
 	if (res)
 		return res;
 
-	u = v;
-	u &= ~mask;
-	u |= val;
-	if (u == v)
+	for (unsigned int i = 0; i < num_regs; i++) {
+		u32 u = vs[i];
+
+		u &= ~masks[i];
+		if (u != vs[i])
+			changed = true;
+
+		vs[i] = u;
+	}
+
+	if (!changed)
 		return 0;
 
-	return yt921x_reg64_write(priv, reg, u);
+	return yt921x_regs_write(priv, reg, vs, num_regs);
+}
+
+static int
+yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
+{
+	return yt921x_regs_write(priv, reg, vals, 2);
 }
 
-static int yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, u64 mask)
+static int
+yt921x_reg64_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			 const u32 *vals)
 {
-	return yt921x_reg64_update_bits(priv, reg, mask, 0);
+	return yt921x_regs_update_bits(priv, reg, masks, vals, 2);
+}
+
+static int
+yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks)
+{
+	return yt921x_regs_clear_bits(priv, reg, masks, 2);
 }
 
 static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
@@ -1844,33 +1903,31 @@ yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
 	return 0;
 }
 
-static int
-yt921x_vlan_del(struct yt921x_priv *priv, int port, u16 vid)
+static int yt921x_vlan_del(struct yt921x_priv *priv, int port, u16 vid)
 {
-	u64 mask64;
+	u32 masks[2];
 
-	mask64 = YT921X_VLAN_CTRL_PORTS(port) |
-		 YT921X_VLAN_CTRL_UNTAG_PORTn(port);
+	masks[0] = YT921X_VLAN_CTRLa_PORTn(port);
+	masks[1] = YT921X_VLAN_CTRLb_UNTAG_PORTn(port);
 
-	return yt921x_reg64_clear_bits(priv, YT921X_VLANn_CTRL(vid), mask64);
+	return yt921x_reg64_clear_bits(priv, YT921X_VLANn_CTRL(vid), masks);
 }
 
 static int
 yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagged)
 {
-	u64 mask64;
-	u64 ctrl64;
+	u32 masks[2];
+	u32 ctrls[2];
 
-	mask64 = YT921X_VLAN_CTRL_PORTn(port) |
-		 YT921X_VLAN_CTRL_PORTS(priv->cpu_ports_mask);
-	ctrl64 = mask64;
+	masks[0] = YT921X_VLAN_CTRLa_PORTn(port) |
+		   YT921X_VLAN_CTRLa_PORTS(priv->cpu_ports_mask);
+	ctrls[0] = masks[0];
 
-	mask64 |= YT921X_VLAN_CTRL_UNTAG_PORTn(port);
-	if (untagged)
-		ctrl64 |= YT921X_VLAN_CTRL_UNTAG_PORTn(port);
+	masks[1] = YT921X_VLAN_CTRLb_UNTAG_PORTn(port);
+	ctrls[1] = untagged ? masks[1] : 0;
 
 	return yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(vid),
-					mask64, ctrl64);
+					masks, ctrls);
 }
 
 static int
@@ -2318,8 +2375,8 @@ yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
 			 const struct switchdev_vlan_msti *msti)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	u64 mask64;
-	u64 ctrl64;
+	u32 masks[2];
+	u32 ctrls[2];
 	int res;
 
 	if (!msti->vid)
@@ -2327,12 +2384,14 @@ yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
 	if (!msti->msti || msti->msti >= YT921X_MSTI_NUM)
 		return -EINVAL;
 
-	mask64 = YT921X_VLAN_CTRL_STP_ID_M;
-	ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
+	masks[0] = 0;
+	ctrls[0] = 0;
+	masks[1] = YT921X_VLAN_CTRLb_STP_ID_M;
+	ctrls[1] = YT921X_VLAN_CTRLb_STP_ID(msti->msti);
 
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(msti->vid),
-				       mask64, ctrl64);
+				       masks, ctrls);
 	mutex_unlock(&priv->reg_lock);
 
 	return res;
@@ -3084,7 +3143,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
 	unsigned long cpu_ports_mask;
-	u64 ctrl64;
+	u32 ctrls[2];
 	u32 ctrl;
 	int port;
 	int res;
@@ -3145,8 +3204,9 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	/* Tagged VID 0 should be treated as untagged, which confuses the
 	 * hardware a lot
 	 */
-	ctrl64 = YT921X_VLAN_CTRL_LEARN_DIS | YT921X_VLAN_CTRL_PORTS_M;
-	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrl64);
+	ctrls[0] = YT921X_VLAN_CTRLa_LEARN_DIS | YT921X_VLAN_CTRLa_PORTS_M;
+	ctrls[1] = 0;
+	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrls);
 	if (res)
 		return res;
 
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 3f129b8d403f..4989d87c2492 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -429,24 +429,24 @@ enum yt921x_app_selector {
 #define  YT921X_FDB_HW_FLUSH_ON_LINKDOWN	BIT(0)
 
 #define YT921X_VLANn_CTRL(vlan)		(0x188000 + 8 * (vlan))
-#define  YT921X_VLAN_CTRL_UNTAG_PORTS_M		GENMASK_ULL(50, 40)
-#define   YT921X_VLAN_CTRL_UNTAG_PORTS(x)		FIELD_PREP(YT921X_VLAN_CTRL_UNTAG_PORTS_M, (x))
-#define  YT921X_VLAN_CTRL_UNTAG_PORTn(port)	BIT_ULL((port) + 40)
-#define  YT921X_VLAN_CTRL_STP_ID_M		GENMASK_ULL(39, 36)
-#define   YT921X_VLAN_CTRL_STP_ID(x)			FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
-#define  YT921X_VLAN_CTRL_SVLAN_EN		BIT_ULL(35)
-#define  YT921X_VLAN_CTRL_FID_M			GENMASK_ULL(34, 23)
-#define   YT921X_VLAN_CTRL_FID(x)			FIELD_PREP(YT921X_VLAN_CTRL_FID_M, (x))
-#define  YT921X_VLAN_CTRL_LEARN_DIS		BIT_ULL(22)
-#define  YT921X_VLAN_CTRL_PRIO_EN		BIT_ULL(21)
-#define  YT921X_VLAN_CTRL_PRIO_M		GENMASK_ULL(20, 18)
-#define   YT921X_VLAN_CTRL_PRIO(x)			FIELD_PREP(YT921X_VLAN_CTRL_PRIO_M, (x))
-#define  YT921X_VLAN_CTRL_PORTS_M		GENMASK_ULL(17, 7)
-#define   YT921X_VLAN_CTRL_PORTS(x)			FIELD_PREP(YT921X_VLAN_CTRL_PORTS_M, (x))
-#define  YT921X_VLAN_CTRL_PORTn(port)		BIT_ULL((port) + 7)
-#define  YT921X_VLAN_CTRL_BYPASS_1X_AC		BIT_ULL(6)
-#define  YT921X_VLAN_CTRL_METER_EN		BIT_ULL(5)
-#define  YT921X_VLAN_CTRL_METER_ID_M		GENMASK_ULL(4, 0)
+#define  YT921X_VLAN_CTRLb_UNTAG_PORTS_M	GENMASK(18, 8)
+#define   YT921X_VLAN_CTRLb_UNTAG_PORTS(x)		FIELD_PREP(YT921X_VLAN_CTRLb_UNTAG_PORTS_M, (x))
+#define  YT921X_VLAN_CTRLb_UNTAG_PORTn(port)	BIT((port) + 8)
+#define  YT921X_VLAN_CTRLb_STP_ID_M		GENMASK(7, 4)
+#define   YT921X_VLAN_CTRLb_STP_ID(x)			FIELD_PREP(YT921X_VLAN_CTRLb_STP_ID_M, (x))
+#define  YT921X_VLAN_CTRLb_SVLAN_EN		BIT(3)
+#define  YT921X_VLAN_CTRLab_FID_M		GENMASK_ULL(34, 23)
+#define   YT921X_VLAN_CTRLab_FID(x)			FIELD_PREP(YT921X_VLAN_CTRLab_FID_M, (x))
+#define  YT921X_VLAN_CTRLa_LEARN_DIS		BIT(22)
+#define  YT921X_VLAN_CTRLa_PRIO_EN		BIT(21)
+#define  YT921X_VLAN_CTRLa_PRIO_M		GENMASK(20, 18)
+#define   YT921X_VLAN_CTRLa_PRIO(x)			FIELD_PREP(YT921X_VLAN_CTRLa_PRIO_M, (x))
+#define  YT921X_VLAN_CTRLa_PORTS_M		GENMASK(17, 7)
+#define   YT921X_VLAN_CTRLa_PORTS(x)			FIELD_PREP(YT921X_VLAN_CTRLa_PORTS_M, (x))
+#define  YT921X_VLAN_CTRLa_PORTn(port)		BIT((port) + 7)
+#define  YT921X_VLAN_CTRLa_BYPASS_1X_AC		BIT(6)
+#define  YT921X_VLAN_CTRLa_METER_EN		BIT(5)
+#define  YT921X_VLAN_CTRLa_METER_ID_M		GENMASK(4, 0)
 
 #define YT921X_TPID_IGRn(x)		(0x210000 + 4 * (x))	/* [0, 3] */
 #define  YT921X_TPID_IGR_TPID_M			GENMASK(15, 0)
-- 
2.53.0


