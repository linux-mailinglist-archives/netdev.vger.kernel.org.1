Return-Path: <netdev+bounces-173122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C37BA57713
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 02:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA3D7A7B64
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 01:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507CE545;
	Sat,  8 Mar 2025 01:08:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79898C11;
	Sat,  8 Mar 2025 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741396125; cv=none; b=cVXBvB9ekCG1Uj0PP6g/0fg71ihYaCms81jw9AX6jp5spu+ZoFT869VQi588ORC2xIM3boElttMko6qt9Mz/wflR3KiLI03bBPopobXHg6v2vykliAUuBJI7DEersgfHbdgDJ0l1yvXqfXjZFMJXiSJBhtN32RWkxOplGpLcjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741396125; c=relaxed/simple;
	bh=Q6UANAkHsbT+S3c55tbICBTDomSC06el0+MjXvYATi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfEjOVuwKUa2e+JXjBMcqvGlkt/8RlT+C3RUG8cP84Hs8DNYBJBzT1c/OejSTOsz3ipGlN8E2FVyhatVF+5b2Xhp6alKcYs1ZwTDG5zmrQxtHRV2Ept3OymDk1XZ15vy6v6Qq+R0G4izmQAVEHeH744ZNBGgn6AH+ggrLiOr65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22438c356c8so15684955ad.1;
        Fri, 07 Mar 2025 17:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741396123; x=1742000923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0N9xtKzH+7HwP/Ov2uhiuWXfnYo6fKPPkQhcVJZEz0=;
        b=Uegb+47UAk156WsOclXL3bMrFmtkzDDZKQpMlkpDwlcUOtYNYLtZqxjaqTkD3P1UGw
         NBy4EwkzgrDLmWvND8YKo0MPEUs6rL9/Mt5i6bhc56SAowAYNklD6j4wlN7lfgdnA8oT
         JQ3IiO2jawgZiHdLKta7YFDlF3Y0SAkAlGjDToWUcc7ubFnOyTRpNDiQbK2bb4X1Fwob
         AYENqc7B+oA0dZvPLnszqRkhckLw8OXRkhUh1cSdXdL1crkI3Cwt0SWhoYouth6+rpg8
         NcJUCTQRKPMoG+U/ISg6tpPVrvW5o34fKo6nGYF9vvHZ/9rG6xh5arYUOL/YDLnGMRU4
         6JvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSUQzhPrPgDnUMm5eMRDia/seakuwCp1ejqzSJT7VpVO8M76dkHKkw3imLjmZGa4lxx4gsUPgW4A/W76A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBZOpkLmp1sIpsVpSClC6Ci6ljHV/Dyw/M/6upLFiN0VgXCo0
	7+pTKtoAldusdGxUDjajAT5BwGByoVkIDdMffEKMvl0llpgs12m31eBA
X-Gm-Gg: ASbGncsVTgvMdhooYZTcy/PoNWGVrKh07ObOsS7+mqYQMFtzbNxok+bs+oaV9tZ9yAw
	J/VrkiWa9UdpDZd1zt9mbCHtqFU3pkYGHyTT1w/99jge5hmkD59/eeGyVshkPviS1CeazvEO5jq
	Gp6mmpvp/QRyF5nINIhYH77lGq01WXrLddKi7IcH30OYi/uiUk6bn6rQhMwgWUa89b14KQI+gqJ
	Itgd9JjQ0Qlwlbw79Vv/za7kC//S47fctmoV1fksCFOWNPBKAH0WnOoPQWxcavC3h8cit7BJ3CP
	Tyht3kApfLnRKAnc1/GzEbvVSGrdVwz7N6UIx3hmdsHH
X-Google-Smtp-Source: AGHT+IEbzXbR2m8Dn93znHMkHmNwpA9xSMJ2jRH0osMrDmIEsgMo+fMzrYGo4w/VgX/ou4CdgjY4Kg==
X-Received: by 2002:a05:6a00:cc2:b0:736:6279:ca25 with SMTP id d2e1a72fcca58-736aaaed7admr10746780b3a.24.1741396122662;
        Fri, 07 Mar 2025 17:08:42 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73698206871sm3956527b3a.24.2025.03.07.17.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 17:08:42 -0800 (PST)
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
Subject: [PATCH net-next 2/3] eth: bnxt: request unconditional ops lock
Date: Fri,  7 Mar 2025 17:08:39 -0800
Message-ID: <20250308010840.910382-2-sdf@fomichev.me>
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

netdev_lock_ops conditionally grabs instance lock when queue_mgmt_ops
is defined. However queue_mgmt_ops support is signaled via FW
so we can sometimes boot without queue_mgmt_ops being set.
This will result in bnxt running without instance lock which
the driver now heavily depends on. Set request_ops_lock to true
unconditionally to always request netdev instance lock.

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e874530f1db2..225d3e2db541 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16612,6 +16612,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
+	dev->request_ops_lock = true;
 
 	rc = register_netdev(dev);
 	if (rc)
-- 
2.48.1


