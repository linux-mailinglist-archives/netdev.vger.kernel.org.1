Return-Path: <netdev+bounces-247622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AA8CFC63C
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3EA330019C6
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A9254B19;
	Wed,  7 Jan 2026 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCBsAC68"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30B27A92E
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771371; cv=none; b=LbnrCIC+X+jhzWmWiMJlLaeYGAmNUMal3NcoRSDcMC+oUAsgpISFrh5LyxthfuTJ5/LoD61TrwIRX0DWD50hOC5UJreVjLkXhdkQjUAi+IEAt63AU2NOWm7RxwHOYnwfWNjPLLnnsDRM4PCwHrBKevP6P2+Vh/nzEkl37XPToTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771371; c=relaxed/simple;
	bh=QHuW9TLM9JTvdYNKW6C++l+j/zGPJSHVm7qNW2Vt0EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWYklPb+5EhGcAHTDgDb+5WRDbTiLJ2Gt5e4SeqjqcWuoWZ70ooM/6XYdiglaoYj7V9j5BFY3Ln+3vyXkZp4FRXg5a1wcKpJMZY9vcytL3/x88yF7tkHdgpniNLgU78q8MC6cLycW6+fkcuTauC03V0vDuNRqXJDmx/QItGhzMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCBsAC68; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2abe15d8a4bso2303867eec.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767771368; x=1768376168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gg85tmSVBtoNhmhNk5MLKN1suGRMIEdQwJkzhQdPQE=;
        b=MCBsAC68FzqCOmUcjK2dE1yqivkOEeb4Uk70pUI8QgMKVArdcd/Q4cZJZdW5oXCWrl
         fk3WuNscRBXzUUNnFvFMOvVCyDm/vRQti9vN6bDmSZsUcrcYrOutbKAb9hayOraPH2yh
         d75SWKBFXd/RhsO6hjjZ6TBSXj6p0FVzCOg9Si+12w6vWcOVbBSUzNp+btxhczftHdMv
         jy7Ze/cVo7NtVP2UjM3nDS2niGDFp7Ge4drYc/TsuYeSwgeUasb6RVTDkKB9/g1FXVRF
         X4FgU/93zUbASPXCekmY1tZDSZIUB9vuJnF43pte4FHsAHx211e1bJSxyVZEgqBX/6Un
         ERfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767771368; x=1768376168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gg85tmSVBtoNhmhNk5MLKN1suGRMIEdQwJkzhQdPQE=;
        b=jS60daNh6HMY3940R81a8InBDt5P2gDS0cIhcpNuQ5nWT0jiOBOY41py+l8zhilIaE
         4Q7ok8TIsDgy5QIdQAa3ZpnbOzS0IWhLwVEn8s33aNArNN833vWKi/E5XFL+X2in+EYn
         tdkiNXZPCbsc7NTjwZGeVy1oAdou8eD1+sDw0IDQiWue1UnRTc6bsZhsND97lYhNULcg
         x9br77T5jgBmZcp54aYBBh5M41T+52LirxlJrxyz5L5asEHvff1CnTqq6DU0GHUdG0j3
         SIAVD9qaA1McBDDxzzFxcySCRNLE6kzTBirV7ASDvjj6EQw5Fd5DmhCceUwWvFK0Jz9N
         xrSQ==
X-Gm-Message-State: AOJu0YwcvRURpCicsHk1XKot7lKEoLl/+WHzWnh6VVH1auirffVUOtqx
	vcrFbH1ehIiiMbklt7ShUOBbiSyyNNNrPJtVqQ0vpQF5etM3o0m8F0zZHR56eXzU
X-Gm-Gg: AY/fxX61w4U3/JfJW+bDOStvH0EH2wNO5dgA+x+ZKN/lh7iJTZwQ04GLV4697/BtFBE
	/djXkNawt21zhJGnIEt8ehihhKD4blcwNlwoAGDJP6W+KAst90uB79kg+t5YnR9zRuG71KiE/KB
	smpRL+Rlfd02ohwgw0hXrEK+jYUkkSwZRQMXuBA1SkH8G2IF524UocM5nYyG1QpBvD1Pt3FktFA
	id0DbldzK62o8SqQBPCMsSeWyzahocBC5lstQoRs5nxwnGLo146cuvo0LzkTDbpLD5Y46n/dV+0
	eLj4CoveoIkaTETrQNdj4dHg7zH2lRNIXxw+yxrB2mbqK1ehAhvzVRnOkj0o+EFpdlcGYTKNduW
	HZYGzdbi1WLXksMk1n1CgRIhmzvWJs1i6WzW6HPvEw65y8ChMpqL+OMoeNfHvaQlafAKiUn6Y/8
	s05IRnG6pJ+9QOzbQmciZlMVd9NXi0K4o/tX3nfJNHBlzg+disGQ+3/w2AOgr3DHCb2VUkQkRmF
	TB1LcSVc0YiQeqyVfHbT/Cdf6FlIGfSeJoiaPKv36EIljLK53SAivrubZK9wM5uZSzKDHXM5+Ku
	WND0
X-Google-Smtp-Source: AGHT+IEFceMrc2r/sYs+dsPvGYmxRe4C9QbcJMwc8dq++b01oa35NndQm+DAlRNCmixB5fSWZNO2Kg==
X-Received: by 2002:a05:7300:ed13:b0:2ae:5cdc:214c with SMTP id 5a478bee46e88-2b17d30bff4mr1200117eec.39.1767771368408;
        Tue, 06 Jan 2026 23:36:08 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078ccf4sm6231156eec.16.2026.01.06.23.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 23:36:08 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH net-next] ibm: emac: remove unused emac_link_differs function
Date: Tue,  6 Jan 2026 23:36:01 -0800
Message-ID: <20260107073601.40829-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 33 ----------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 417dfa18daae..72936d47d011 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1277,39 +1277,6 @@ static int emac_open(struct net_device *ndev)
 	return -ENOMEM;
 }
 
-/* BHs disabled */
-#if 0
-static int emac_link_differs(struct emac_instance *dev)
-{
-	u32 r = in_be32(&dev->emacp->mr1);
-
-	int duplex = r & EMAC_MR1_FDE ? DUPLEX_FULL : DUPLEX_HALF;
-	int speed, pause, asym_pause;
-
-	if (r & EMAC_MR1_MF_1000)
-		speed = SPEED_1000;
-	else if (r & EMAC_MR1_MF_100)
-		speed = SPEED_100;
-	else
-		speed = SPEED_10;
-
-	switch (r & (EMAC_MR1_EIFC | EMAC_MR1_APP)) {
-	case (EMAC_MR1_EIFC | EMAC_MR1_APP):
-		pause = 1;
-		asym_pause = 0;
-		break;
-	case EMAC_MR1_APP:
-		pause = 0;
-		asym_pause = 1;
-		break;
-	default:
-		pause = asym_pause = 0;
-	}
-	return speed != dev->phy.speed || duplex != dev->phy.duplex ||
-	    pause != dev->phy.pause || asym_pause != dev->phy.asym_pause;
-}
-#endif
-
 static void emac_link_timer(struct work_struct *work)
 {
 	struct emac_instance *dev =
-- 
2.43.0


