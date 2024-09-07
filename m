Return-Path: <netdev+bounces-126249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 001539703AB
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0CB1F2241E
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CFF16B75F;
	Sat,  7 Sep 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2fov453"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3816191B;
	Sat,  7 Sep 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734743; cv=none; b=EOXlkx0G8z8I7Wq+LiCokJ8JJ0vFpPQ/nCm4epaxwLRMZazti0tC1dazcN/DXtYCIe0jpBkWrfpOq+YZP3Xbzce51X+iP9CLyyKexriCulLp+pP8ppCQ6OszzWtLNcG/o4H5O0LWyqTn2rMqeivN8g2uoqw4Z4IzX13C8beZUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734743; c=relaxed/simple;
	bh=yE5gCqTODUdT41orFw3/yqcS5Lpn1qY6ldEzgDsuXzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+vVph0KDzYFHeWR8HBGDUCp67jojsGBY3ncj1nzZJiY+eMVAE0qcIbkHHAiT5hzOBj0i7bWZaIEbpMrjSB1TjvQFA8VQYIhj13ymMVQQgpR5/AKGwIoC9uxA3hH07a3W7AZwGUzAwpB1Dgg4pmMneb8ZSr7YYmfFr8vrILlmOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2fov453; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8818337a5so2985855a91.1;
        Sat, 07 Sep 2024 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725734742; x=1726339542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6QiWgh/SMR9a3w1u3p0Z64P+ZQ5YDOynV720/su9jY=;
        b=Y2fov453mJ5JXKUgf5CWkOOB6iRHXPY9oUPOOaOKALr7+QtlhM0RshgxFzEbAJorXw
         lXsETtNo1nchHxibzo7ARYL3nj5q9VKkmLciT72O0XDsI3fz8wdvZfxzgjDvtA/rtsg2
         aHJ2TDNpT4MeK4kF0zpwsLadJmZo2N+P8EZy0yMhm2frkjoVtJgGcpgRXU4yXV0nzFlH
         gtiGdvgRUOoRSs3GtbbpeZlL3D98uiHCh7gPJGWnNNM6+mRuP1ua99+WzPJVsZjat5Pw
         OLCbyE1uICBn1eo84Bk1q8RV7q0Y1V/lbEMuI7xgqWsnhaeyhgy2UVBdvZWHrMmK9d6R
         1ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734742; x=1726339542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6QiWgh/SMR9a3w1u3p0Z64P+ZQ5YDOynV720/su9jY=;
        b=vzMKMZQ7fxv7ugEgzvId0VnmkMnLkI1L4MfzCDst9Sqa73QTa9S8TRw9ILdVOdm9a+
         SHAq6CxTmEoMm1xCpaKDGTX6gH1wGRoDQNu+QOcKYRVBKboN8VZxE8AkU73P/NfmGqnY
         RkiUNYiTTXxv2Jbi/lnXDAin3SZSgp5XqhN3rp9jh+REbmv5GwX034jdVHOX6qhYce2V
         VLUmIZSAFRePLFjhWH3HJCslc+AVcFPcqYh/mheoBj638ExcYUBjZmHNzd5AkT/zlcCZ
         xO8QWiLUxjx2x1ofusMpd5GLk3O4heMIg4x1EUD7oBwzAICD9hJocyu6iREdlWpnIkDh
         tM7g==
X-Forwarded-Encrypted: i=1; AJvYcCUyQCV7yOzI4EOlxwlWO+7/a1ufaqKf0zp1a2JDwdaxxn5IY6ZvfXU95Gi+Pe9tfbTDIZeQWp4MnlE2pUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EYeneXTNmmj61DPHEOOsgd8V7AuJ1Gusics48f6NHOBcXQEM
	sBLvsy+aUtHFrvMbmDuXSnTm+TDgp6INwuDFsWJLU9+wLtgisNJpI6nTd/MK
X-Google-Smtp-Source: AGHT+IFd2iuM7fynExvDtSvwnQLWGlu5LUdxy+EIt3Wz6+YZLcG6Ai57hZIDt3LPQGGCe7ghV2wE8w==
X-Received: by 2002:a17:90b:1083:b0:2d8:89c3:1b57 with SMTP id 98e67ed59e1d1-2da8f2f3f81mr20773019a91.15.1725734741523;
        Sat, 07 Sep 2024 11:45:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab18bfsm1111239a12.88.2024.09.07.11.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:45:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv4 net-next 6/8] net: ibm: emac: replace of_get_property
Date: Sat,  7 Sep 2024 11:45:26 -0700
Message-ID: <20240907184528.8399-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907184528.8399-1-rosenp@gmail.com>
References: <20240907184528.8399-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_property_read_u32 can be used.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 3096e4e6b5e5..7270d7d07350 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2444,15 +2444,14 @@ static int emac_wait_deps(struct emac_instance *dev)
 static int emac_read_uint_prop(struct device_node *np, const char *name,
 			       u32 *val, int fatal)
 {
-	int len;
-	const u32 *prop = of_get_property(np, name, &len);
-	if (prop == NULL || len < sizeof(u32)) {
+	int err;
+
+	err = of_property_read_u32(np, name, val);
+	if (err) {
 		if (fatal)
-			printk(KERN_ERR "%pOF: missing %s property\n",
-			       np, name);
-		return -ENODEV;
+			pr_err("%pOF: missing %s property", np, name);
+		return err;
 	}
-	*val = *prop;
 	return 0;
 }
 
@@ -3301,16 +3300,15 @@ static void __init emac_make_bootlist(void)
 
 	/* Collect EMACs */
 	while((np = of_find_all_nodes(np)) != NULL) {
-		const u32 *idx;
+		u32 idx;
 
 		if (of_match_node(emac_match, np) == NULL)
 			continue;
 		if (of_property_read_bool(np, "unused"))
 			continue;
-		idx = of_get_property(np, "cell-index", NULL);
-		if (idx == NULL)
+		if (of_property_read_u32(np, "cell-index", &idx))
 			continue;
-		cell_indices[i] = *idx;
+		cell_indices[i] = idx;
 		emac_boot_list[i++] = of_node_get(np);
 		if (i >= EMAC_BOOT_LIST_SIZE) {
 			of_node_put(np);
-- 
2.46.0


