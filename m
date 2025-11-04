Return-Path: <netdev+bounces-235318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960FC2EA9F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 01:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7CA94E31B9
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 00:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310AD212542;
	Tue,  4 Nov 2025 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VUKEeSLR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8555D1FE45D
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762217881; cv=none; b=m4hwqWp+F9LgwppC674WmqQsVP8b3nGbVC5w16oPyOuSG2yLmOh5QSWBfkfPRzEvLB3krdi+cIp0g2iYfSbvYpLltv9r99PSmRgg79RW+DyrSWErHRNl9XMKBhzakB8S/I9C28qz99So/idZaE7TxBbW1jY6+R4pm2Gya8QlcoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762217881; c=relaxed/simple;
	bh=R1xYcvg/3llc1kBkc4CRZ6s5Q7xZepna8XACbWOpdWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WW6j6Zj2DtpFtRIJPXs3QqD4giOVvxHk//wx6ft67m+3IxDuYGeGtqvQEXhYalYvDF83jKTnmo8yC+seiop+T14qBukYtjL6biFwQ9gv0CRJjsjTmJZy9+VYj5KpN7iR36HLWMrLF1XwoAq7c0x+Aekrw4E+jv2Km/oTaIY3qRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VUKEeSLR; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-94359aa7f60so444937539f.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762217878; x=1762822678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kc+FcZJMoAbCnMi7CUmmGSGnd2VoGepgQij5fJuEJdw=;
        b=f+/017cAwmEtHIvMjYmgBt+w2pSGx9dA8Nxv/p9YfWV2bUGjkLQUfhks2uTKN3GSxB
         fIl/uN/dm2/+DLAwY2MlIEOX7lMWC82+5PbfMydIX/wLdBRr1QCPylNzl594/BBl3soX
         O2ufxG5hADakqHnVOdLyj6nUdqcfB6S4MR4lu4ediGyCNy6mURRqoeIGQhpJOLzOoO0S
         yb+h8HvlvxW9MYPUtmeCFdzHM9DNRGM7pdsg8o0EtO22vOMi5oaOAsikcHA8fD9RsXTh
         RT02k3RAxh9F6an1ZsH+FI5882p9bFScDN9rwc/lFvZUvU4x2TYifGdeZcM6cNGLjIfr
         JEzg==
X-Gm-Message-State: AOJu0YwwjMpTIvQ9Q7dANOn63AaCqo5Ikx85wXso/IXLsZN8mZ7SobjO
	tUOGV7OznPEr+3DyXES75ECgF+gRibyQNP/GTNm+e2iqaqvdJp1AT60EQyLf8YcaPszZJriFF57
	nqEtiCvwtnuvJXzSrPl2dcIqnX9w/8DmszQaQftVdkwRq7osp3lfUIocL3oYExSQ5qXrn/iFLfW
	tceGL38KLz3c1JdsiJqXcNQhGdVhxBc6zdfF/nsp3JBM3uaKPu7rgFEV/Z1qvclOfqk8LzTQ5NA
	z2KL7uo9M8=
X-Gm-Gg: ASbGncsMyqmYKS2v5weSySAVzKTLq31z6RIf+7bqWhJYeHCueXJJ/LA9fCDRrAr3eyo
	8rxcYS+l6u6t8p+SBd6899TP5hKQdpfX0dNgv2VkUffbfw6RNoS7dXXUXVOvi4efOU7hpG91bGD
	e5MLK2cx1WG78APXr1EEyBl8qaArmwIItaPmWcLnYGUg39IIDsQeaNbmM4wVo0XEyYffoRKKl90
	iTrTZaR4ah6Co9po2wspbzWAkdegWBqBZ2trMcMaeWEmhht9eeiz+2EUAxEFYrdGp9lK8FBqC64
	XG5T3TKZ2nCKwpg8h/6vtbIhVQH7j5tdmIp3mpMi7EKkgy1T+0oZpxt4E/y1rQGGlQa6JI/d882
	0zA63+t1oXGBPQ7dVTFTLv9kRSuNLL7KZQ7ZxOXRnHvpWc9HaV7IpxBgo6nsvj8M7zFl3iaBoid
	ZWnanZeHjJyOAOnSccJgcMRGXP9sAmTMo=
X-Google-Smtp-Source: AGHT+IHujFORrOEafbTWU5kr5lOTa6jwCG8CvgE923+N2zkSVtBSgN93YZW64j0En5vn2tjDbpYUxhPaOpUk
X-Received: by 2002:a05:6e02:440d:10b0:433:209d:feee with SMTP id e9e14a558f8ab-433209e21a2mr147123965ab.13.1762217878515;
        Mon, 03 Nov 2025 16:57:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-43335a9019fsm1562945ab.1.2025.11.03.16.57.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 16:57:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-781171fe1c5so4905697b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762217876; x=1762822676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kc+FcZJMoAbCnMi7CUmmGSGnd2VoGepgQij5fJuEJdw=;
        b=VUKEeSLRyZdOSPastmYtr7c4OqUn73g58RLmIsZ62rE+90o47x7yjrqIsp5s1swzfA
         dhnPLiTBMbBVvF9bOOV1asEOiZMKH01MDv3+/evw7V7jM7eTXLq0OJ74BzlRzxZ/i7/M
         EE7sx5piSx2tNfphe72GIYW3bQHWGMLIptNrw=
X-Received: by 2002:a05:6a21:99a1:b0:340:a205:681a with SMTP id adf61e73a8af0-348ca75c051mr17675324637.4.1762217876333;
        Mon, 03 Nov 2025 16:57:56 -0800 (PST)
X-Received: by 2002:a05:6a21:99a1:b0:340:a205:681a with SMTP id adf61e73a8af0-348ca75c051mr17675304637.4.1762217875938;
        Mon, 03 Nov 2025 16:57:55 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14bbsm2474553a91.13.2025.11.03.16.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:57:55 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>,
	Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 5/5] bnxt_en: Fix warning in bnxt_dl_reload_down()
Date: Mon,  3 Nov 2025 16:56:59 -0800
Message-ID: <20251104005700.542174-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20251104005700.542174-1-michael.chan@broadcom.com>
References: <20251104005700.542174-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>

The existing code calls bnxt_cancel_reservations() after
bnxt_hwrm_func_drv_unrgtr() in bnxt_dl_reload_down().
bnxt_cancel_reservations() calls the FW and it will always fail since
the driver has already unregistered, triggering this warning:

bnxt_en 0000:0a:00.0 ens2np0: resc_qcaps failed

Fix it by calling bnxt_clear_reservations() which will skip the
unnecessary FW call since we have unregistered.

Fixes: 228ea8c187d8 ("bnxt_en: implement devlink dev reload driver_reinit")
Reviewed-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c0e9caa1df73..a625e7c311dd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12439,7 +12439,7 @@ static int bnxt_try_recover_fw(struct bnxt *bp)
 	return -ENODEV;
 }
 
-static void bnxt_clear_reservations(struct bnxt *bp, bool fw_reset)
+void bnxt_clear_reservations(struct bnxt *bp, bool fw_reset)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 7df46a21dd18..3613a172483a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2941,6 +2941,7 @@ void bnxt_report_link(struct bnxt *bp);
 int bnxt_update_link(struct bnxt *bp, bool chng_link_state);
 int bnxt_hwrm_set_pause(struct bnxt *);
 int bnxt_hwrm_set_link_setting(struct bnxt *, bool, bool);
+void bnxt_clear_reservations(struct bnxt *bp, bool fw_reset);
 int bnxt_cancel_reservations(struct bnxt *bp, bool fw_reset);
 int bnxt_hwrm_alloc_wol_fltr(struct bnxt *bp);
 int bnxt_hwrm_free_wol_fltr(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 02961d93ed35..67ca02d84c97 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -461,7 +461,7 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 			rtnl_unlock();
 			break;
 		}
-		bnxt_cancel_reservations(bp, false);
+		bnxt_clear_reservations(bp, false);
 		bnxt_free_ctx_mem(bp, false);
 		break;
 	}
-- 
2.51.0


