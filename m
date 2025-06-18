Return-Path: <netdev+bounces-199259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5DBADF932
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812641BC2DD1
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38B27E7E2;
	Wed, 18 Jun 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8VbVbRE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B727E7D1
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284472; cv=none; b=WlgVsk+/t8K21zCvYh/FH0UfAvnJto7zTxPN4u9r5zeNSl9ObCVstRfHubhKeu84rekg8wpXYy4t/ERDeUwUmdDekllU1+YFadqCvgncdFRDLsBC/y7d3g5y8+6X+dVe53+5LzPiv9oQxDipPeeIaRw8TwtBSfS4BOLT+FWggEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284472; c=relaxed/simple;
	bh=BZM52I5RCK1HLjJiZ2AZP8ki0HrF6TbzIYdh2Whd9BY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRFenoa5873Ot2jtNiVFZMo23ng72WDVcDT1IdTTL4lEZ51JQkcGjxqykI75B8BmyhM/nWBUvl1bxtlcoMNvd54aBKIif/goJLjk0XjDXN7ZtbpU01mPxegZQQqrqZarc834VC6eDh+K+0cry2vJ6PIsAzP+FfGLjNP+9yWZn+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8VbVbRE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748f54dfa5fso77500b3a.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 15:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284470; x=1750889270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LqoGg0+wkqGmdi49/TZNK79fy7/N+PE7GID7gjlK3Cw=;
        b=m8VbVbREKxu9oo11NCSRksvvCK+4+cQczQgTD6A9wuIsQ3arr5VdP3GHm7uTeNO+9V
         vZpmCm7Ca+jmtmbjzYBb2xgx+1Ojo3wXwmVxsp+MkUcCSvUAu4qt4ccP3QOGcCmssgCb
         2ZUCfz3oq13UZtM+GY028ddqatSVI/MqLGgSKiYFlq94BN3gOGXHcZ/srlnAmllLHXBw
         ZL5FVc+5EdyGFZV4SfxFdC7QSJs5FiS3jL5axxVw9rxgnrc8luxYMf3RibczmDZb1A8p
         YO9QEuNRCElB3Vs7jN5VQqybLhPNBShhJe5iDghS4MhP3UVK8pwOa5jSMMWeVc2jAr/m
         YNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284470; x=1750889270;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqoGg0+wkqGmdi49/TZNK79fy7/N+PE7GID7gjlK3Cw=;
        b=r1/yDGn42xkNZX36+BgnsaVh7Miopc+2Dlsppb1FYo867e4XEdUTNyAwH0Exq/lZSL
         S63Ho/kv3XK3lDKcCXtIPK6EI/OITM7670OXSCbA7PG3L9hMJL6R5p9+8HGUmo89LX/P
         wOUzmni2yqSQ6O3yZHkmPYOFMVl4C8l2/cybNMzG/fDHDF1+nSDt9e/GS2Og53DIFyuy
         I3ZjoHWFVNsNxuJ2s8rX2aVRpx7oQyjkc8RSXSv7rjNKoyzxyp1dcWlujw+RT8us6+Ql
         T6BM5SYQ5vf6V4NOlkfCXXCdcAyjpEWMzNqyyexZw5tY3lOuEQVC7jtrH9V9cMgH8euO
         +HHw==
X-Gm-Message-State: AOJu0YwSSgqj9oWrVjhUbpemCT+/PklS+KuxuGXTz2Ro7Ak5fw1enZUF
	t74gyKRyBrhgjShQEP4parvCFGxXFww27u42s0p/5Pi0oY0MSDRfugoC
X-Gm-Gg: ASbGncuPS3EgTaodk1RXKLxpk2jg1JUZtuDh4AxJLIyszCij8blfEZOwkYfnXdQagcG
	+IrPM+Yn8baL4jYjFTZZDeCtTsPUCOxCvkS+knD4WuMj4RaNHnuVFIr0iYDHh+toMtflM2+Jbpt
	BLCCYRjuhWrnMdE1FiDxxc/9qQjGUeVRkCkOc1EfmkE8DCAk9RvHu6l3qdJS/KKIlTZMEMfpdw3
	IpJaPdJNUgKAVUQozQ1s8NnHAnrH2VdetsX98xggSzgy3e7WnfVuNKQELFsPW5dEebXqDcZlYAk
	IQ/y7rc5Zlm+o+yI9FgGEigTLcfXVEO6w8mDpXsBBwx1viTPbBpRi+ytNlVsaRQIB+4YQPNUbQ1
	E5LtIIY4YKf8+RK26nO3oVsDB
X-Google-Smtp-Source: AGHT+IFkzijGAG3iT6AON9q/EcDuof9aPIK8frgD2F5jxK8vBqF3QFE39vlM6+NoeGESdWPI22vdnQ==
X-Received: by 2002:a05:6a20:a109:b0:1f5:6b36:f574 with SMTP id adf61e73a8af0-21fbd691282mr29805891637.38.1750284470534;
        Wed, 18 Jun 2025 15:07:50 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.35.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748e82ec1cfsm2281302b3a.91.2025.06.18.15.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:07:50 -0700 (PDT)
Subject: [net-next PATCH v3 5/8] fbnic: Update FW link mode values to
 represent actual link modes
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Wed, 18 Jun 2025 15:07:48 -0700
Message-ID: 
 <175028446893.625704.10103673858068429312.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Make it so that the enum we use for the FW values represents actual link
modes that will be normally advertised by a link partner.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |    8 ++++----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 08bc4b918de7..08bf87c5ddf6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -155,10 +155,10 @@ enum {
 };
 
 enum {
-	FBNIC_FW_LINK_SPEED_25R1		= 1,
-	FBNIC_FW_LINK_SPEED_50R2		= 2,
-	FBNIC_FW_LINK_SPEED_50R1		= 3,
-	FBNIC_FW_LINK_SPEED_100R2		= 4,
+	FBNIC_FW_LINK_MODE_25CR			= 1,
+	FBNIC_FW_LINK_MODE_50CR2		= 2,
+	FBNIC_FW_LINK_MODE_50CR			= 3,
+	FBNIC_FW_LINK_MODE_100CR2		= 4,
 };
 
 enum {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 0528724011c1..284fcfbedb74 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -544,17 +544,17 @@ static void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec)
 {
 	/* Retrieve default speed from FW */
 	switch (fbd->fw_cap.link_speed) {
-	case FBNIC_FW_LINK_SPEED_25R1:
+	case FBNIC_FW_LINK_MODE_25CR:
 		*aui = FBNIC_AUI_25GAUI;
 		break;
-	case FBNIC_FW_LINK_SPEED_50R2:
+	case FBNIC_FW_LINK_MODE_50CR2:
 		*aui = FBNIC_AUI_LAUI2;
 		break;
-	case FBNIC_FW_LINK_SPEED_50R1:
+	case FBNIC_FW_LINK_MODE_50CR:
 		*aui = FBNIC_AUI_50GAUI1;
 		*fec = FBNIC_FEC_RS;
 		return;
-	case FBNIC_FW_LINK_SPEED_100R2:
+	case FBNIC_FW_LINK_MODE_100CR2:
 		*aui = FBNIC_AUI_100GAUI2;
 		*fec = FBNIC_FEC_RS;
 		return;



