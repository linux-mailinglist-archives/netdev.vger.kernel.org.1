Return-Path: <netdev+bounces-129284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0532797EAB6
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 13:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2547C1C211BD
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE5374418;
	Mon, 23 Sep 2024 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwqFlHld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E445558B6;
	Mon, 23 Sep 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091104; cv=none; b=Ce108tBHZLjNJCFkPZic80ufjzhp9woyiuZrH5Rul8ORZMnaRzNKy+D0FrlN4p/WteqpZlrB6I/B2PLCMjZwSCfbo6XkteP+eTpMPIRB/M53QLgOCGCFHsjK3fhA/I7nim30GMo3afYPHLmgqHcFcWtFN6JPv1SiyvbifRYBySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091104; c=relaxed/simple;
	bh=wXZdumoEFvRfbEgW6BsNaryOSUO/Gi71dztFXx7hFBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrbDIsxIfydcFnDTHiehw9rb1qpfvbAmkHSD8/8dFiBijF8IHKfkH/DPgyQX24nPv9fteeBhsbGcBER7UhCxKegK4Zh8VwXuqHc8rMRoRbIwxWBIDXj6kpDCZ1UcvOfonXcd0zVDki8CRVSHC+Wd1y6pMttOYL+pqUGT2maaWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwqFlHld; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-206aee40676so33457495ad.0;
        Mon, 23 Sep 2024 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727091102; x=1727695902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8VkOVLUc6X2W9Mk+mkAUfIq+rEQDahm5iYJv/NiMRw=;
        b=YwqFlHld2cFt1OfsFiP0UFFzfhroQk0KIF5rBd11iD9ZzDrSkSx2BovU/J9gl1jsIY
         IVNWAcf5bR10yMjZtXQnLvqBA8dnGZH9+S29AwSd6H3vu/TOHZZqEzicot4VcrpMdReU
         lkowHduGmHsPE6cN8hdVWXD74KKBzD6Vppzn6Hymb52ElYEe01PG2WPP48MmamktZOdV
         ScsyXSr3Xo4iSRaqPPyBi6OcAdAU2i2UcHufMuL9xg+wtFZ61pXpH3UE3YLndK1PsGMt
         Jt9/HUKUFUFgHE1uCSJtZIsIoe/vWtUmjV8lreZPOGo/fmalzxyMffKovLHGRzP7gUNJ
         1UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727091102; x=1727695902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8VkOVLUc6X2W9Mk+mkAUfIq+rEQDahm5iYJv/NiMRw=;
        b=dLyIOpyfn/Vtjg5q0oZdUgk7dVLfY7/3Plf39lgiLEtC7dofQQowPmLQ8DJEeElwiG
         z6Q/aKXtJUsZieQFrLR55l+S/EsmAo3UXEFWV3uToyq6QuFkTMxChdkr63lcoMnP4ffU
         vuSBELLd/Oq9lpSfs0kpzsthhQ5mvXCUmWaPosfhf+4NlRRsK1+QJ8oKYQvFYKK6gu8T
         Vcr7YH6HSdTLuDAlRQI7t7MwoZ2ZrjkoXG1Lcn8y3cp29E9PusKQebNY+pFpD+OU+Svz
         TjOkVSYhU8qPMprolQgR8GKaib5VpQ1lG1vttqykTFtNKLnB37GZVmqJNP1DrcDGVwUL
         0SGA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Ng3vaiHUiHl9pC2yf/u13de1+nwWYeN0wnL5xzSUYcxqA7UHa0ewgPcJlmF0BcFRUWJ11yhSBsIZ1Wo=@vger.kernel.org, AJvYcCUS3tEpVdccDlgGTM0SwEM5oPn+L8BgIVp62YfK1c8/3hqpNDDDCJK4nqyth0E7S8dhiBwHOMdr@vger.kernel.org
X-Gm-Message-State: AOJu0YwVIPZLAmXna6J3dZpvSM2mdd5TFxUHpxIw8S6tbXgXaDw4/I8X
	l+NV0QjeLM2cHhOs4N8J7zp+XDthBPe0z+xDpj2vWAo7Ul0/1osI
X-Google-Smtp-Source: AGHT+IFnJ0Awf2LMJDx4WZhRHScp1nXcjNzHLKhfEHa/P7PVi2aBe5TquNmttIi+w0Kcfu84Z0or1g==
X-Received: by 2002:a17:902:d4c6:b0:206:ba20:dd40 with SMTP id d9443c01a7336-208d8399031mr119464545ad.27.1727091102406;
        Mon, 23 Sep 2024 04:31:42 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473c85fsm130925775ad.285.2024.09.23.04.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:31:41 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error pointer check in otx2_ethtool.c
Date: Mon, 23 Sep 2024 11:31:34 +0000
Message-ID: <20240923113135.4366-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error pointer check after calling otx2_mbox_get_rsp().

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 0db62eb0dab3..36a08303752f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -343,6 +343,12 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
 		rsp = (struct cgx_pause_frm_cfg *)
 		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+
+		if (IS_ERR(rsp)) {
+			mutex_unlock(&pfvf->mbox.lock);
+			return;
+		}
+
 		pause->rx_pause = rsp->rx_pause;
 		pause->tx_pause = rsp->tx_pause;
 	}
@@ -1074,6 +1080,12 @@ static int otx2_set_fecparam(struct net_device *netdev,
 
 	rsp = (struct fec_mode *)otx2_mbox_get_rsp(&pfvf->mbox.mbox,
 						   0, &req->hdr);
+
+	if (IS_ERR(rsp)) {
+		err = PTR_ERR(rsp);
+		goto end;
+	}
+
 	if (rsp->fec >= 0)
 		pfvf->linfo.fec = rsp->fec;
 	else
-- 
2.43.0


