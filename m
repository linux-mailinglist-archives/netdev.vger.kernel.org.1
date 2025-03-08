Return-Path: <netdev+bounces-173123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5DA57712
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 02:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20733B6683
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 01:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47C1DDD1;
	Sat,  8 Mar 2025 01:08:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97E3C38;
	Sat,  8 Mar 2025 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741396125; cv=none; b=t9ScDnXutYrGEPQdcly/uYMUlewZf70ICLqbRuggAAWYf4zgsPCfphSsnftSctsTm5PScLq0Kg6MZ9nT3XemM2Ah4sOtCuCyq52ahlYLUYevd35XDlT7uLHm0TfXHMzw1CpPeDeoUxr+x9MR8O834sTWFJg37z1C7pUiDv/wMgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741396125; c=relaxed/simple;
	bh=han6XIBLQLzR4StkcQHRyFfL8Og3xS7ZdUkP6nRmRcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s40ZcZxejzIzXim5Wu2U+AOBSkLt92M1bs+gy7M3pKGnlhUXwuGt/BPPpocMgMleIGB37F3/rw/dRJ17b0sHHND6LRuwWAVhIutOh2Ku4V6m1a7kZrYMDu/V5qqgYtNjf2Ub5ZZ06KRVkXiJDh9ienbzfVb4EKd5TNMUH68YywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f42992f608so4417136a91.0;
        Fri, 07 Mar 2025 17:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741396121; x=1742000921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZceUGzZQI+8M1i/0MdDKtz8ApRiyWMZXylPBeplVtk=;
        b=JwVXwDpzLQQazTkROqC3Wn7KPfE3q1z+RepmcnP0Iaebn7HprXHtq0IvsF1NlHIxMs
         exQxqZkqxR0NZ8RGGBDXyZhmTaascV8Lrv4BeTyhO9cuqvsefvzP0V6sdpPhanVVNqEQ
         Z/AzZxQdCXZuIcnm28egARZ1sOGygbdltgVrzZCFRyiQEpQJbITfBiDOC9fAMORKcQIs
         /AlBCt9/kSpBVOK27isqWx6BQFj8uTobcfNZm4C9LUl/M+FyQY/trLiGHboI+H51Va/F
         +U+0wWwwytSfj+bk858l3tKaTkzSc+rCLcHxzYE7lR2AZeJF6D0EwbcIyLMjsgRSn6sb
         jn2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVj/IXunEFzOUNuY9G4pOXE1pkibGyFeMNjPkdYCxsvo5Xm+gwBq/cRyxK3clzcC4lyzJpP5kHN4HAiiWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx5mLC7b96eaUALNvcwAJZQUDA3J65/bfb70NbasNYZu8BoxXP
	USNAliB+HUVEu2rBL2qzFgfKm1KDZdt8pZyTG9dwdSgGD9xbAQvIprzU
X-Gm-Gg: ASbGncu9l7gdiJ07CAd9q0Kca46OxLS8JlDFQOT0/ZWFJZH/BYwok2cqUbeqMfRgk4D
	K9BrOmY4ENPNi1zOcxhyT1KIlCgV1mqEyqwb2cdPyD1Bn8u2TwLUi+mNCBNE9VYc/yKQy/CQbQW
	BvnILiedUFR3XHZjzslqEXVygWZIdD0XbuqB5UkhNzFvt8cnxAhbTa7lx5iZFy+z1OBkk1fkTWo
	y+s94F5gPCjczKXafiLCFocRu5dZV2IyBelP3KDF7Dd/ojvcnhk6aTOuTQhBamxZPMQmqzUiDSx
	mLkU4vgfpUrNlGaMp6QUNytutYnGLI/p99ej70s/9PkF
X-Google-Smtp-Source: AGHT+IH0xN13AElE92Eegmk3L+r+oO5h6CaskheJmANUrI0dN4CrC7FaJlKLvvzlA/CgRP8k3Pd2+g==
X-Received: by 2002:a17:90b:52c3:b0:2fe:9581:fbea with SMTP id 98e67ed59e1d1-2ff7cf22de4mr8548082a91.29.1741396121322;
        Fri, 07 Mar 2025 17:08:41 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff4e789356sm5578812a91.24.2025.03.07.17.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 17:08:40 -0800 (PST)
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
	sdf@fomichev.me
Subject: [PATCH net-next 1/3] eth: bnxt: switch to netif_close
Date: Fri,  7 Mar 2025 17:08:38 -0800
Message-ID: <20250308010840.910382-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All (error) paths that call dev_close are already holding instance lock,
so switch to netif_close to avoid the deadlock.

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 12 ++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1a1e6da77777..e874530f1db2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12801,7 +12801,7 @@ int bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		rc = __bnxt_open_nic(bp, irq_re_init, link_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "nic open fail (rc: %x)\n", rc);
-		dev_close(bp->dev);
+		netif_close(bp->dev);
 	}
 	return rc;
 }
@@ -12839,7 +12839,7 @@ int bnxt_half_open_nic(struct bnxt *bp)
 half_open_err:
 	bnxt_free_skbs(bp);
 	bnxt_free_mem(bp, true);
-	dev_close(bp->dev);
+	netif_close(bp->dev);
 	return rc;
 }
 
@@ -14194,7 +14194,7 @@ void bnxt_fw_reset(struct bnxt *bp)
 			netdev_err(bp->dev, "Firmware reset aborted, rc = %d\n",
 				   n);
 			clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-			dev_close(bp->dev);
+			netif_close(bp->dev);
 			goto fw_reset_exit;
 		} else if (n > 0) {
 			u16 vf_tmo_dsecs = n * 10;
@@ -14809,7 +14809,7 @@ static void bnxt_fw_reset_abort(struct bnxt *bp, int rc)
 	if (bp->fw_reset_state != BNXT_FW_RESET_STATE_POLL_VF)
 		bnxt_dl_health_fw_status_update(bp, false);
 	bp->fw_reset_state = 0;
-	dev_close(bp->dev);
+	netif_close(bp->dev);
 }
 
 static void bnxt_fw_reset_task(struct work_struct *work)
@@ -16275,7 +16275,7 @@ int bnxt_restore_pf_fw_resources(struct bnxt *bp)
 
 	if (netif_running(bp->dev)) {
 		if (rc)
-			dev_close(bp->dev);
+			netif_close(bp->dev);
 		else
 			rc = bnxt_open_nic(bp, true, false);
 	}
@@ -16668,7 +16668,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 		goto shutdown_exit;
 
 	if (netif_running(dev))
-		dev_close(dev);
+		netif_close(dev);
 
 	bnxt_ptp_clear(bp);
 	bnxt_clear_int_mode(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index b06fcddfc81c..b6d6fcd105d7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -461,7 +461,7 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 		if (rc) {
 			NL_SET_ERR_MSG_MOD(extack, "Failed to deregister");
 			if (netif_running(bp->dev))
-				dev_close(bp->dev);
+				netif_close(bp->dev);
 			netdev_unlock(bp->dev);
 			rtnl_unlock();
 			break;
@@ -576,7 +576,7 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 		*actions_performed |= BIT(action);
 	} else if (netif_running(bp->dev)) {
 		netdev_lock(bp->dev);
-		dev_close(bp->dev);
+		netif_close(bp->dev);
 		netdev_unlock(bp->dev);
 	}
 	rtnl_unlock();
-- 
2.48.1


