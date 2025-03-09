Return-Path: <netdev+bounces-173380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C09BA588B5
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 22:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EDB188D0AD
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BDA221554;
	Sun,  9 Mar 2025 21:58:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C69220697;
	Sun,  9 Mar 2025 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557538; cv=none; b=ZF3TU1YWGvosl6clA6v823WeOB38pmWrOTdzM7i5dIxONOVvTupDatJaTDZj059dMLL5DIy1Ii8BYzUL8awSHGPMd4m9mYrsaZTqQffeKE27KlLEBk+FZKjPmevpvt63noquRnDDTfCjah54aTN9kPqeMjKSpUNrs2rsMdypMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557538; c=relaxed/simple;
	bh=KPORZ4ECtNt7LTt+vOl/VNIIvF2i/cF7T8OrZMT/Egw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyV1cCbDxmlJ20GoYgEeD5T/0UP47YY8//ORHDg1bgxVSAzUv7y9PwiKebXAAeaz98UJmI9Hs6cjd2+jDjT6y1vxUaN8vn8yiloA9MvQ299psdLwCNcni37sYyyMwtlIwZ38GkoSPnY68AEaMwyFB0zLSm1nltd6e2s+ToSEOMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22423adf751so47350985ad.2;
        Sun, 09 Mar 2025 14:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557536; x=1742162336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AT1yjzZG3JBVK21tLLJDqiuhVXZszRPbs9jpjNhIZ/k=;
        b=AZhq8HOfkF7Td9W6BXO0elSQI+ilwFu/p2qdobFhoND9AoF6DzZKoHDytWRgS9lmk2
         g2W1+RQMwP4E7qbXqDW/LGCfGM0sH+F8cRmjUgYiiwwfkv1HXBNg7sjLCELFc9x3pY8I
         Hkrrg6YW4OTgOVsA8daYz3iL7Q0xoL0xgFuueMlM2xZJzf+Z7vpVu7uRQp4EvESE4V3B
         MkiUrfA2RfwmWKBZuVw3eQPk0luQAIlzzyJeYe9PYTl8+rLnw+OENYQlCTuqfb1K8TUR
         YGDsrpVRiljFgTXyeyFJm4U0VcJM1XRPcoPI6SEWIgz3IF8vNAtGwEFZEtBacF9qE0GF
         VJZw==
X-Forwarded-Encrypted: i=1; AJvYcCXXorpwqoLxkmH+A+KphWtRPOIjb8/1L2OVNrMLDCHH1D0jxZ4EpI4zUcP6GHQiAGFS0IBhMCxsTs1rOc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeioaOTuHmcs6SgID5SI2FxIHy+FzEmpJW6kEHNWvBiZTOqAKs
	tU1sJggJV8KUolsy2YRSOyA8v+iPzWpOiPaxG+GxwDpWQDoYsNk8b1v4Ogw1kg==
X-Gm-Gg: ASbGncscCKJ7Ojc5/x51EtE17EnWD3JUE5wAG9o5aTs6hrqMfhtnePzBSwDsMeJ2+0U
	71Wn8pttb7xMj9u+cy3uIFgPEiGxVYQbJiR9brNL+Gf3F2bxbxh7aVkvENUUayY7w0bCML3GDRJ
	de5T4ZlECr9yDmh4ay9XnaXtPb5Vii8VMTm+K5TLNkC4KgEK0ZqFkwJQIfp/bWl1p7Hk4WY3uUw
	b0lvlWLOXzQ+3ZwmMPD3KVTEEeeiV5GaWNa7W/0QYnjoCevcWHKv8yzEEjxHRtYpu8sTqco05rk
	mX5eopY2piwuIUCAOjEie5kMh6kux6YQgdCsAh3etLkJ
X-Google-Smtp-Source: AGHT+IFYPtt6AoQlpV4TtjEtnkgkhhxlvLCZ+1m3op8XpKGl/s4d4/iqc+otKl2UGr/Ap8wo8qwSkQ==
X-Received: by 2002:a17:903:2405:b0:221:7eae:163b with SMTP id d9443c01a7336-22428bf5cdcmr208426905ad.46.1741557536566;
        Sun, 09 Mar 2025 14:58:56 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109ddc89sm64384425ad.36.2025.03.09.14.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 14:58:55 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me
Subject: [PATCH net-next v2 3/3] eth: bnxt: add missing netdev lock management to bnxt_dl_reload_up
Date: Sun,  9 Mar 2025 14:58:51 -0700
Message-ID: <20250309215851.2003708-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309215851.2003708-1-sdf@fomichev.me>
References: <20250309215851.2003708-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_dl_reload_up is completely missing instance lock management
which can result in `devlink dev reload` leaving with instance
lock held. Add the missing calls.

Also add netdev_assert_locked to make it clear that the up() method
is running with the instance lock grabbed.

v2:
- add net/netdev_lock.h include to bnxt_devlink.c for netdev_assert_locked

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index b6d6fcd105d7..f8fcc8e0e8de 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/vmalloc.h>
 #include <net/devlink.h>
+#include <net/netdev_lock.h>
 #include "bnxt_hsi.h"
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
@@ -518,6 +519,8 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
 	int rc = 0;
 
+	netdev_assert_locked(bp->dev);
+
 	*actions_performed = 0;
 	switch (action) {
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT: {
@@ -542,6 +545,7 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 		if (!netif_running(bp->dev))
 			NL_SET_ERR_MSG_MOD(extack,
 					   "Device is closed, not waiting for reset notice that will never come");
+		netdev_unlock(bp->dev);
 		rtnl_unlock();
 		while (test_bit(BNXT_STATE_FW_ACTIVATE, &bp->state)) {
 			if (time_after(jiffies, timeout)) {
@@ -557,6 +561,7 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 			msleep(50);
 		}
 		rtnl_lock();
+		netdev_lock(bp->dev);
 		if (!rc)
 			*actions_performed |= BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
 		clear_bit(BNXT_STATE_FW_ACTIVATE, &bp->state);
@@ -575,10 +580,9 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 		}
 		*actions_performed |= BIT(action);
 	} else if (netif_running(bp->dev)) {
-		netdev_lock(bp->dev);
 		netif_close(bp->dev);
-		netdev_unlock(bp->dev);
 	}
+	netdev_unlock(bp->dev);
 	rtnl_unlock();
 	if (action == DEVLINK_RELOAD_ACTION_DRIVER_REINIT)
 		bnxt_ulp_start(bp, rc);
-- 
2.48.1


