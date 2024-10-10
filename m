Return-Path: <netdev+bounces-134048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30909997B93
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2021C21CBB
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3A41991DF;
	Thu, 10 Oct 2024 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB/2mmGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5A186E52;
	Thu, 10 Oct 2024 04:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532854; cv=none; b=uPwRcxbNiS1ykErtQgICtIujqFdsbfBH1+BnrvCcHQjRGFpIrUrA8eCfDRKI2VYQKlOmySSavFKBqfoHgiE8nwVUOzYYA3vwtRDwlq1xHQoWU+04DJ3HgpmBrBsMVKtQgXXz+f8sJZkY4q9xwcBGnEffs/kSn/05PjhpZA40dE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532854; c=relaxed/simple;
	bh=1lPC7Oy+mVMGOi7EYINru7hjhZdzKV45s6abe9EUfdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHRwHSUE0izhbBqzKOUDDUVhBVNtjRa1sME0RpR+y50T20O08YSLeK5R39cnRfNT/0AjCwto3BF+ci5RZKtqGuMSKsak3Cm4Ng4/3pk0s+wxXNrk66gg1R2BpF5dFqw0+Z4FkDHpggZ/r5arnaXVpN3gnNA0cWqSWzDtIOEFS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KB/2mmGr; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e9fdad5af8so293219a12.3;
        Wed, 09 Oct 2024 21:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728532852; x=1729137652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLS8ExhuyPf8yV1va/VDdqkqBHkw9CH2tEXMgiitFuw=;
        b=KB/2mmGr382nAQs5K+upf8JUt9bD4775c1UZEeJrbNlIoniCkHx4oNI12tB059lUjk
         xR26OeqVoAsGria1wtA9OcpJ2aWVDE+eTLzyagvR+JQwU/Zw+E4I1zKmlbD2LjnE7/j0
         I/QgPnRN4dfQ2nsXRozpsJNKmVFFZxPwjcYtCgRSJ2hsDdZ9UgqJNDrEtqcQICjoSVcA
         XhPJFbeuhkZ9H/V5CamSEuA78ZjsTsP+bZW9fliQlWBwXPzA4I/beY5AcW5+aYR4Zhpk
         8k2vJjoRn26a71PNZFNGNFt1I5ZL7WZ0gyZlNZou1z2xKLDte3lhjSYUL+w6jqFaZoMW
         EblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728532852; x=1729137652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLS8ExhuyPf8yV1va/VDdqkqBHkw9CH2tEXMgiitFuw=;
        b=g8WkjSOjJHLHqcsEWL4lqfQlEo6LaZ85oIMxBHJtrKZ9u8yQXYlXmIV8apX7y44uxi
         6f2RHa+bF9+fTiTWpLq30glUWgu6R3AB/ltJvOviOVu/Nz34hBEdGSmpeo0DFa0WC0m3
         BVtepLmwW5dUSslfcHerRMZ2Ox2zpv/OGxr1hwD72bOZlg7M6r0jjYvRFo+fs60AK1cL
         J5D2Fpr5hrlfaZjgQnetabFWOQ1sUiihVlvI07DA3H/D3lBDF4eFeQpXex9NcaQJujt8
         acrSwDcCL26sLNugPLYA9qtp0WsFPepbr2AumBJ2iS0bnvTXiQLZ2H5Qim+56+uPtm4e
         N2hw==
X-Forwarded-Encrypted: i=1; AJvYcCVTlUsbt0noaS6Tq1FavI2iitzh1/YmI9g6uuO21memMYQlUP03je36yzPMb4BYoXu/TioskKuQrpA/Xd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeOnIJmGlFV7yLar6tcHizoeSTQsWQL1Rgi10iMjXzLL59kWmO
	2DlJZLLgsTBgVlg2pIiUobm3iw8d/3i7ywXsELg6/AVrKwZJdP3+EOY1V1pq9LU=
X-Google-Smtp-Source: AGHT+IEWGpMo/RiqGJL0+7YuiegTc9JHzPiVgIt84IJoLYTMjXmOA9y6KXItL9EnqYgo6DShOlQwLQ==
X-Received: by 2002:a05:6a21:1643:b0:1d8:aca7:912 with SMTP id adf61e73a8af0-1d8aca7102emr4459880637.28.1728532851741;
        Wed, 09 Oct 2024 21:00:51 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5dfsm187638b3a.199.2024.10.09.21.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 21:00:51 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 2/3] netdevsim: copy addresses for both in and out paths
Date: Thu, 10 Oct 2024 04:00:26 +0000
Message-ID: <20241010040027.21440-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241010040027.21440-1-liuhangbin@gmail.com>
References: <20241010040027.21440-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code only copies the address for the in path, leaving the out
path address set to 0. This patch corrects the issue by copying the addresses
for both the in and out paths. Before this patch:

  # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
  SA count=2 tx=20
  sa[0] tx ipaddr=0.0.0.0
  sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
  sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
  sa[1] rx ipaddr=192.168.0.1
  sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
  sa[1]    key=0x3167608a ca4f1397 43565909 941fa627

After this patch:

  = cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
  SA count=2 tx=20
  sa[0] tx ipaddr=192.168.0.2
  sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
  sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
  sa[1] rx ipaddr=192.168.0.1
  sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
  sa[1]    key=0x3167608a ca4f1397 43565909 941fa627

Fixes: 7699353da875 ("netdevsim: add ipsec offload testing")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/netdevsim/ipsec.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index 102b0955eb04..88187dd4eb2d 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -180,14 +180,13 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
 		return ret;
 	}
 
-	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
+	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN)
 		sa.rx = true;
 
-		if (xs->props.family == AF_INET6)
-			memcpy(sa.ipaddr, &xs->id.daddr.a6, 16);
-		else
-			memcpy(&sa.ipaddr[3], &xs->id.daddr.a4, 4);
-	}
+	if (xs->props.family == AF_INET6)
+		memcpy(sa.ipaddr, &xs->id.daddr.a6, 16);
+	else
+		memcpy(&sa.ipaddr[3], &xs->id.daddr.a4, 4);
 
 	/* the preparations worked, so save the info */
 	memcpy(&ipsec->sa[sa_idx], &sa, sizeof(sa));
-- 
2.39.5 (Apple Git-154)


