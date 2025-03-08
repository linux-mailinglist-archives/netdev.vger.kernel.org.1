Return-Path: <netdev+bounces-173124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8519AA57716
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 02:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7632F3B6C21
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 01:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780E980BEC;
	Sat,  8 Mar 2025 01:08:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031CABE4F;
	Sat,  8 Mar 2025 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741396126; cv=none; b=LGEHisd+sI3IrHJNMERKNCjxnxCd/aL+LXidt0OnTNELZhPEscFM0sru8EjjCg+leSHvSmAUSDDVcBt6Tsf8D7mK6NxtgSJDGxHsvuXF2+cF6fB7BtUH305AbOhPn7c5ffAhuuNM+gz1rccNjevHkZRTH+4XsNlYO69XEBUlWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741396126; c=relaxed/simple;
	bh=wwil/2v41H0XAHT4WhGN3oUbvCK5TX1lOhPw1rpP4vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KM+pzzL1eJDHxDcUiPnLZVdZ5I5C/nvk9uaNZlRnlBXBT1g7CQMOteNXAFkxagoFKwCYszpIf8XJQfsjDxM5zXRbo++7h9SpJd8/fVMsp1kUSnokyWsWbt5kJ7x4xbOxKl5F6VKvH84APGUN1fBaX8SVmC9kiCIitAE1QT1tt18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239f8646f6so47136245ad.2;
        Fri, 07 Mar 2025 17:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741396124; x=1742000924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZzG6RJCUE4w9vBi92LziU0iLdE8HumGGZ3TnO1HuEk=;
        b=aaVC623Ez4+gTatItGjvSZyumQFNEdo5ZhpNwhf2TmMWR6darINkVPQCoqNJMbwvU5
         DUSMENzSFPk7BZmDTM+mV+S5JKSIx9NfgbfOQkaZoXezdt1j4XouA4wI+vajp/XwGV9m
         h6sxR1bybuHIJlK7uFvLWo6JyIxOTOoIOPoEksMpDP7DbFWstXUKyfEKyR5sECDuUUTK
         Ah2AQPsAxvfdPlejiDbuqIfc1x2dDxNRDCjHz1PWIU6yD4ZNYzoZNX/sVTUcwLe5FYT7
         OQnE3jSVh+6m2RfQkZ8wosb5Uq8sUrjo/joqMGRIA6gTzCQYgvWysg1eSNFM5dmfCPax
         iW5w==
X-Forwarded-Encrypted: i=1; AJvYcCV5wJuWH9kGcjT+OyyiQFIbL5Rndqw42RWyZgO0E5b3ycOaUx8xBAW2dSJE7z5zL5Rt1rk7ZG1RJ7Pj++o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYeDYNtzKqS8wma7FQEsbcbZy+I82ZcvETpIUetlTMl/ZIbfha
	2Qgv5KX6tL3LLOIHeas4SdPzN+M7Xay4DE5Go1+gXS6+k75fbRXf3Ie6
X-Gm-Gg: ASbGncvV4E7Wiw9yyE5OMdzKC0M2ZqCKbonho8gVOVn3TehqqLp3DuCrbbFpK3lo5BW
	TGdgWPr44dMGU/eXFANNdN8mtyaa3UEhhcQwiPDPFxX3O2/lCXAr11kE8991X5fe8/+OAdyiV6x
	9hoTpVO75Ivf8CCoaq1ciFDkBWF/LdKOUr7M/S1rMpcgJaDQqC7AKY/IIZlGcY5fnE5ea+k1F88
	mlR1ERLP+bGla/YmPldFTZzJo/SA8Ee8cmDu+YzK9BWse5czIPk09SkG7D9Y963DjFMAcqx4Y5U
	KDj/U552ZsGzHZ7cFemXCff3YZrJW43qvIxPEDpNi110
X-Google-Smtp-Source: AGHT+IFLicPF9DYHopLUsyxSlIIaJHPsUCyq/CCGJkidujAVcbCjmBBrELmykKF33i3geS5NWWBBWw==
X-Received: by 2002:a17:903:1a05:b0:224:1294:1d26 with SMTP id d9443c01a7336-2242888bf0fmr79353515ad.13.1741396123952;
        Fri, 07 Mar 2025 17:08:43 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a91993sm36754865ad.175.2025.03.07.17.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 17:08:43 -0800 (PST)
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
Subject: [PATCH net-next 3/3] eth: bnxt: add missing netdev lock management to bnxt_dl_reload_up
Date: Fri,  7 Mar 2025 17:08:40 -0800
Message-ID: <20250308010840.910382-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308010840.910382-1-sdf@fomichev.me>
References: <20250308010840.910382-1-sdf@fomichev.me>
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

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index b6d6fcd105d7..ea7f789be760 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -518,6 +518,8 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
 	int rc = 0;
 
+	netdev_assert_locked(bp->dev);
+
 	*actions_performed = 0;
 	switch (action) {
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT: {
@@ -542,6 +544,7 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 		if (!netif_running(bp->dev))
 			NL_SET_ERR_MSG_MOD(extack,
 					   "Device is closed, not waiting for reset notice that will never come");
+		netdev_unlock(bp->dev);
 		rtnl_unlock();
 		while (test_bit(BNXT_STATE_FW_ACTIVATE, &bp->state)) {
 			if (time_after(jiffies, timeout)) {
@@ -557,6 +560,7 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 			msleep(50);
 		}
 		rtnl_lock();
+		netdev_lock(bp->dev);
 		if (!rc)
 			*actions_performed |= BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
 		clear_bit(BNXT_STATE_FW_ACTIVATE, &bp->state);
@@ -575,10 +579,9 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
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


