Return-Path: <netdev+bounces-244577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8604CCBA1D0
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 01:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C8AE300831A
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 00:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB325199EAD;
	Sat, 13 Dec 2025 00:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="BRa/h1z7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE7819F464
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765585366; cv=none; b=QmUzNIyvrF9hyMEPEX0QuzT2xLabz/wtQMBIlt3QucuZoBydOgTkYigdDt6FzOzXmQXmYLGsr+w+Olsr07p+6WYcUlLqRxoocMLc3AG2iR51DNz4kNh6SfycjCkj+YXvqoSnIUwPnGccXnnYCTjQoMy8DLBC9tlVTWf2suDtqsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765585366; c=relaxed/simple;
	bh=/pTf0x+Ra8DRnB0RIFGXQT9AVFTsoWIWHtTxnxlJvPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCHEgTd3xRhccurhTqcVPiOn1Wh7Um3wsUvRaZwQLPOpHHyYPVkel66Tq4u6KL3dsXLZUgNeIR5eX7ocF4If8+P+oLAgVn5v0iJL4ZlWLdu7qop1pYBib2MBY8enKQH0IdGYl3EZVwP9yRnvzX/x0MLhdbPFOMTNTsPgFLnShJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=BRa/h1z7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a081c163b0so6772375ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 16:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1765585364; x=1766190164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg/KKfVLep3toZPAk5g9jgleUjnOCrRXUedzC2uEBgQ=;
        b=BRa/h1z7c28LjlMUPpiFsc46obR4Sx87nHW8FGzNQVMOZtkcvAwTfnVNoylkzewdB6
         REafsJGxm4S074Bh6u/QrKnG3gTqUtkbhNgHs1PZGnIGt9Mk3hqKl3nUupmRa28McODz
         JUdIXA1SXmERdJaqrRh5tXDmDVO56duqnmG68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765585364; x=1766190164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cg/KKfVLep3toZPAk5g9jgleUjnOCrRXUedzC2uEBgQ=;
        b=tiyrJBG6xWDBY7d0UXAjq1OZUN+FDKrEh6wAiJNiOZakYyjWp2AcZjxt0LFkLMrhld
         9l6cr8iy5m9mw7nLeFmAS8TalbGRf3dTSrTTdFkS6XklA/hFX80i/eUxd6iyZJmpFcNS
         nmnZp5xi4lA7lymc95ZNTOvtObXCa5TcLNJRQGCfTZD670ghqgvPWPu44gvjT490pPco
         bVOG8QiXwokdDFFZlU6hIiM+Mc7qu5ZaTur42LBWzvK2x5piLOdg/PHpW5Sl/yw+oTeO
         ac9Lx+GQ164HjetmY0nxOuUMCK6jXdsTstLshXBV/Dn1y+KmNDjZ5jAkvpRHAj7AtYBM
         Wwqg==
X-Forwarded-Encrypted: i=1; AJvYcCXQnXId7nu5xzUqHEHJ/HRb0XJLxKEYQaAyqG5ipX4+/53/R+7XR440pQwhUA+b1LC9rju+W8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxurNPIrGx3Q6Ht/hGChNla80Y5NWytupzpSaciflUYVaM82wK/
	EmjqAwJo8P1kfkXW10MtTfRgKvv1qIPLTHzvn4e/8DCjlP1bYseOmPwAoKMtHHb5/qA=
X-Gm-Gg: AY/fxX7mrB2QwNEHpR96r0BYc2zYnEYBrlj53Y/dJSgZCysbbXsEhOwLnloKi3ogfFG
	YzfjNEEPXbchIpgtyqZTonj3DUUS7V09w5FLgitFdij/QSujPOfudzwrs8it2hpWmiY/K8bsZNS
	gal9AZHytFx5UTrr/rToKcCzWyYDTmB6551mkJSDz6vTQvHmZfTxy7TXb3hgIOCFib0TcWkTOgM
	eHYNGTghc/3MgFnmTHwRvUxrg1KrpbvOonOeifHlz3QJYdUik/d/djnqXEOp5TTqIEHG7lZRdpr
	9wGm+EUqedKyfT6xVjrghRJxJpr9IMnLtNtTchWU1zWOvK6q97df321i3t/9y0cqEi1/aQ2ezJ8
	3O5MGABg1vfpoiGz+2+hmIkya9VMG/LRWs2QSgB5WjxaKoff8obj0H/n+k4rDfHfB1FFA51DQZu
	vMMPkQM36BNMnq/bpLhnRCY1L8Z1Wwv+u91sXCsgMk3Uc=
X-Google-Smtp-Source: AGHT+IEpdS6if48OizR1QeBtFs0aUr2J7HLnwvIpHnHe0VcYJJw/Q6u6ahntlfaZ21nluQi+tCBqCg==
X-Received: by 2002:a17:903:32d2:b0:297:c058:b69d with SMTP id d9443c01a7336-29f2404b7bcmr35622115ad.34.1765585364408;
        Fri, 12 Dec 2025 16:22:44 -0800 (PST)
Received: from fedora-linux-42 ([104.160.131.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe1ffdf0sm2904719a91.4.2025.12.12.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 16:22:42 -0800 (PST)
From: Cody Haas <chaas@riotgames.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Cody Haas <chaas@riotgames.com>
Subject: [PATCH iwl-net v2 0/1] ice: Fix persistent failure in ice_get_rxfh
Date: Fri, 12 Dec 2025 16:22:26 -0800
Message-ID: <20251213002226.556611-2-chaas@riotgames.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251213002226.556611-1-chaas@riotgames.com>
References: <20251213002226.556611-1-chaas@riotgames.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several ioctl functions have the ability to call ice_get_rxfh, however
all of these ioctl functions do not provide all of the expected
information in ethtool_rxfh_param. For example, ethtool_get_rxfh_indir does
not provide an rss_key. This previously caused ethtool_get_rxfh_indir to
always fail with -EINVAL.

This change draws inspiration from i40e_get_rss to handle this
situation, by only calling the appropriate rss helpers when the
necessary information has been provided via ethtool_rxfh_param.

Fixes: b66a972abb6b ("ice: Refactor ice_set/get_rss into LUT and key specific functions")
Signed-off-by: Cody Haas <chaas@riotgames.com>
Closes: https://lore.kernel.org/intel-wired-lan/CAH7f-UKkJV8MLY7zCdgCrGE55whRhbGAXvgkDnwgiZ9gUZT7_w@mail.gmail.com/
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 +----
 drivers/net/ethernet/intel/ice/ice_main.c    | 28 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index c9104b13e1d2..87f4098324ed 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -953,6 +953,7 @@ void ice_map_xdp_rings(struct ice_vsi *vsi);
 int
 ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	     u32 flags);
+int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
 int ice_set_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size);
 int ice_get_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size);
 int ice_set_rss_key(struct ice_vsi *vsi, u8 *seed);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b0805704834d..a5c139cc536d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3649,11 +3649,7 @@ ice_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
 	if (!lut)
 		return -ENOMEM;
 
-	err = ice_get_rss_key(vsi, rxfh->key);
-	if (err)
-		goto out;
-
-	err = ice_get_rss_lut(vsi, lut, vsi->rss_table_size);
+	err = ice_get_rss(vsi, rxfh->key, lut, vsi->rss_table_size);
 	if (err)
 		goto out;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b084839eb811..c653029f07c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8072,6 +8072,34 @@ int ice_get_rss_key(struct ice_vsi *vsi, u8 *seed)
 	return status;
 }
 
+/**
+ * ice_get_rss - Get RSS LUT and/or key
+ * @vsi: Pointer to VSI structure
+ * @seed: Buffer to store the key in
+ * @lut: Buffer to store the lookup table entries
+ * @lut_size: Size of buffer to store the lookup table entries
+ *
+ * Returns 0 on success, negative on failure
+ */
+int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
+{
+	int err;
+
+	if (seed) {
+		err = ice_get_rss_key(vsi, seed);
+		if (err)
+			return err;
+	}
+
+	if (lut) {
+		err = ice_get_rss_lut(vsi, lut, lut_size);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * ice_set_rss_hfunc - Set RSS HASH function
  * @vsi: Pointer to VSI structure
-- 
2.51.1


