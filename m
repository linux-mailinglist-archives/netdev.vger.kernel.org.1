Return-Path: <netdev+bounces-69338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC5D84AB4C
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A731F25963
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8ACEDE;
	Tue,  6 Feb 2024 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="UvIsaiFu"
X-Original-To: netdev@vger.kernel.org
Received: from egress-ip43b.ess.de.barracuda.com (egress-ip43b.ess.de.barracuda.com [18.185.115.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597804A06
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.185.115.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181188; cv=none; b=CcISugNRa3hZGRlgakc+W6uayIDvgm+2GKydwvnW45uMMhrlFlE/VkWoaHzFFiZ5L3ukCxzB08FeB3aZPZ0vOnz4hId5At1ORG1OjhkN6LyzETLIx3X/BKtVKRExHw0egO0wAdEVI8a6eJVa+tYHFy+k1RSL8NYReUlX1B5i/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181188; c=relaxed/simple;
	bh=/6zDVpTQxTpO8Rt7fqCeo96mpq7mjUP0IlGNFtYHc1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rO9tn/F7vtjwLPcJ/F5RnjQbnzpZEu67j3ZFkBLL31ohPy8HLsTgrB2n6xvW7prGeVV+qzxWA50uzhGpIEgC7H1/oZ+O3F89McZzu8w4q2jAinGEnheLIV1bUxm0npaBq3uY3DdinGODVqx3w5G5iold4FoOIx2aIu7qedDTRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=UvIsaiFu; arc=none smtp.client-ip=18.185.115.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197]) by mx-outbound16-171.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 06 Feb 2024 00:59:38 +0000
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d9765ce40fso34407515ad.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 16:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1707181177; x=1707785977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMXVXJW0OFWoix7qY497nt0fmYOWqwLi2f9LeVZ82B0=;
        b=UvIsaiFu9upnb3HcojI5D513hQvvxkfw1x9B3UY0f85T0Sq7qtXdIl+1bgQ25rNseo
         3I57B73JJSHPwnaoC6ZVqlSE1pUVPZGmeNyqJucBrAr3Rde5lW0D37uOGGJI8neepp4b
         IOC1AANOueHgki1QvHX4UCsRVoAukDrKf5KaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181177; x=1707785977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMXVXJW0OFWoix7qY497nt0fmYOWqwLi2f9LeVZ82B0=;
        b=P8SsnUzs6a1TKbibkfEyK0Or+cpppfmADF0ag+skeniU1sgz7yE0kSK0J0vaoV6Irm
         Pxpo6hs0anezLvM3+hwxGtZBNXZQ35Ls5FZzvj9z43XToqu5DYD5K3jV+PnelxjqKJHx
         Gpxf/YvGqjgDa8nxdvkWIUzkWxuKgBNfoOtTQQywZrkummZG2dGewu6vRclR2DO+dLc2
         yAR/LSerfPt5ZLOesKLU5aws+VLKrtkij7saqwatMUPPzxK5F8rK/4+lgAd0m+stvKZ2
         1IN69fw9bOz/8HhdiFNr2kbA2KGm+vvzXK4XX40DLJMJRRJJ86fWT3a87S9YfjEVh8/L
         YxVA==
X-Gm-Message-State: AOJu0YyDCEr8WekMrl/9SqDmC6CL2GKTGSX+GqhoToHayIVk4lFA1ERS
	7tsjjJy4luJTjFT5llW6YX1vOh1tlkejMVFBHhCT8ReneXYz/oeDCHZx+ykAofYAg/9YkfQVd2w
	qo+FHHutfv87aPAnLAnYcs4/zxABWGWtdgTMJBqtUYFUexchEJi2r/ev07Hh0G8yswsLErnjNG0
	CROfJoHSBbb6xt
X-Received: by 2002:a17:902:ef8d:b0:1d8:d5b0:aadb with SMTP id iz13-20020a170902ef8d00b001d8d5b0aadbmr156381plb.66.1707181177690;
        Mon, 05 Feb 2024 16:59:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1Ec5BUuM/8SjurkqK2dgM8NYOaBKTGquT3BUcAgyNf6Xg2XMyEHELeCJkp9kCryCflmVN/g==
X-Received: by 2002:a17:902:ef8d:b0:1d8:d5b0:aadb with SMTP id iz13-20020a170902ef8d00b001d8d5b0aadbmr156370plb.66.1707181177388;
        Mon, 05 Feb 2024 16:59:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGLWeAahHWmWIqAdH5XKO/jVf2naBPslSxn5hx9J9tTjSY8npnBInKMCPASTF1LwvPtGsuB8Pm4s2HWTI/TciTs+0JJf82FtOqB0TjJ0ByCyzsPPlDwPwvsgtabFIR/2GFksnpUwpFhtun5+aFLhhOyQR0CUryZaznix1EFoG4kBfwP1x5blp7VWGsxo9qldLjmElHCR7+
Received: from localhost.localdomain ([49.207.212.181])
        by smtp.gmail.com with ESMTPSA id le11-20020a170902fb0b00b001d8f251c8b2sm496534plb.221.2024.02.05.16.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:59:36 -0800 (PST)
From: Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To: Denis Kirjanov <dkirjanov@suse.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 0/2] CPSW: enable mac_managed_pm to fix mdio
Date: Tue,  6 Feb 2024 06:29:26 +0530
Message-Id: <20240206005928.15703-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1707181178-304267-30761-4853-1
X-BESS-VER: 2019.1_20240205.2236
X-BESS-Apparent-Source-IP: 209.85.214.197
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrKysDQDMjKAYsapiSkplkbmyR
	bmpslmyUapholmZkYmFsYmqcmmaSZGSrWxADALva1AAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254014 [from 
	cloudscan14-232.eu-central-1a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

From: Sinthu Raja <sinthu.raja@ti.com>

Hi All,
This patch fix the resume/suspend issue on CPSW interface.

Reference from the foloowing patchwork: 
https://lore.kernel.org/netdev/20221014144729.1159257-2-shenwei.wang@nxp.com/T/

V1: https://patchwork.kernel.org/project/netdevbpf/patch/20240122083414.6246-1-sinthu.raja@ti.com/
V2: https://patchwork.kernel.org/project/netdevbpf/patch/20240122093326.7618-1-sinthu.raja@ti.com/

Changes in V3:
Address review comments:
	- Add the same fix to the drivers/net/ethernet/ti/cpsw.c file as a
      seperate patch.

Changes in V2:
Address review comment:
	- Add Fixes tag.

Sinthu Raja (2):
  net: ethernet: ti: cpsw_new: enable mac_managed_pm to fix mdio
  net: ethernet: ti: cpsw: enable mac_managed_pm to fix mdio

 drivers/net/ethernet/ti/cpsw.c     | 2 ++
 drivers/net/ethernet/ti/cpsw_new.c | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.36.1


