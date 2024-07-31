Return-Path: <netdev+bounces-114597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 501FA942FE3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D5B1F2B958
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C896C1B14EE;
	Wed, 31 Jul 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="tva6NSVy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739461AD419
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431750; cv=none; b=Twl4iDVl7MZlu9RSgecCtSFlRfjqDzwxHxj7w+4fFdmx4TZAn8Sg/zbANmLtc7WEimcS7B7w6PKNXXXJOxkE1BKtBiZIeR0i6JpIJzvRUFxi/mdmYCVpD0KbfzBDzX/lh5KT52IChxtpobFALCSUEmJXQGFckWCI2W+i/oVp62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431750; c=relaxed/simple;
	bh=nV4ki4QhBStX81MtSCM80aOZNRBMYokwFEBdu4cHtMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gt5k9lawjUOE4sM29LmOhDR1YuqbhG8ipS/bdDd0NR4cvtJLM96+BOgO6C8PgqaHLN/RL9X57gLcNSJAZCPc7CM7cA9dd2+hJxp0X/PtrIwV+4FIKtxYAmqeBMJ+yucvCuUuVBsSFKerr+4UzLfXMMkfkNkodHmi0TXFQYsO/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=tva6NSVy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cf78366187so3655093a91.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722431748; x=1723036548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/oKIVixDcENB/ht6EYBvQyg9lE3Ljw+hngvqeYpDhc=;
        b=tva6NSVygn/Y3kGRGpEhgAoFBKw08x26gf/xL5YqPSRFUKZYUNtciqTgQv97Y9oamb
         F3FfUS8LeVOlzOVFGZfKF7EjQ7D2ZSJ/zGOgNAstzLGcsPzcA5Bdlg1q66uBNch99WI1
         Ee7Lo+GQ1AzJNLJEJie2U1CkVWWFiEumxlJfPzY3LAD2d77xZzAsxuASdVlc6PP6obwa
         BmTz7fk7atjCiskQNyP8yzd01TAaKspDhpykBS7kRFxZEMjdRI8GL2fQdPCoXTMjyTAx
         Nz9WHg064n/XGxfe/O1A1XcXBOJyj0v+kgA9oS9J4Hnf0fa2etCllxq17YsIR+Z4XUjs
         Sr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431748; x=1723036548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/oKIVixDcENB/ht6EYBvQyg9lE3Ljw+hngvqeYpDhc=;
        b=IxYduZYCHsrtsd4qPYXQ/XUU9GM/I4fWY/SM8HoTxWFtARB4uQWQXsuDvZveapSGR7
         P9q1e4hx7jMfB2TUaIDlFEwHNyQ1XwusWb/yRpJ4S2uemrqiEKbrG44fQRdZ4doFSFDV
         sTjYnzqJGvVdoi0fxTbTYo9Q5CVnQzuHWLLWKgFXz2qio0FBf4XrC6SrOSWbwf6YoS9w
         2Hu+vpos3EU0dpZ/gKk8V/IeYcoU6TgkOWNKrSeAJuWew6RaK/Zl/r+ac/c35H+PiBy8
         0A6j+bL+tckTol3vlzAAy0w9XEFfvnaKLSkBTiwnrs3FWyASV6dj1+mY9+N82GxA86Nq
         pjRg==
X-Gm-Message-State: AOJu0YxfWCWWQZZQHEodPCc3tSFR2lIq05N7D0RXRy94WH5q6VretkPX
	Y9e8xBIww5KKuRFsAYHG+LbXBsFH6VH5e6No6/Q+lwKe5DdXC+3XU0cM31RwgIAPaToI60jBw1f
	RxZY=
X-Google-Smtp-Source: AGHT+IFxfTTOBKfxnWbbHyuN+30WJE01HYq86IpscL4Dls32Mv4RRCg71kANjgBp1X+Y/nsc6D/zRA==
X-Received: by 2002:a17:90a:eb07:b0:2c2:f6a2:a5f7 with SMTP id 98e67ed59e1d1-2cf7e1df038mr18906014a91.13.1722431748498;
        Wed, 31 Jul 2024 06:15:48 -0700 (PDT)
Received: from localhost (fwdproxy-prn-009.fbsv.net. [2a03:2880:ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf655sm1272905a91.38.2024.07.31.06.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:15:48 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v2 2/4] bnxt_en: set vnic->mru in bnxt_hwrm_vnic_cfg()
Date: Wed, 31 Jul 2024 06:15:40 -0700
Message-ID: <20240731131542.3359733-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731131542.3359733-1-dw@davidwei.uk>
References: <20240731131542.3359733-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the newly added vnic->mru field in bnxt_hwrm_vnic_cfg().

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 52998065956e..8822d7a17fbf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6579,7 +6579,8 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	req->dflt_ring_grp = cpu_to_le16(bp->grp_info[grp_idx].fw_grp_id);
 	req->lb_rule = cpu_to_le16(0xffff);
 vnic_mru:
-	req->mru = cpu_to_le16(bp->dev->mtu + ETH_HLEN + VLAN_HLEN);
+	vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
+	req->mru = cpu_to_le16(vnic->mru);
 
 	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
 #ifdef CONFIG_BNXT_SRIOV
-- 
2.43.0


