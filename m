Return-Path: <netdev+bounces-46464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F67E4485
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 16:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756A01C20B8C
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A18315B8;
	Tue,  7 Nov 2023 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubIQpORK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A928315AC
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 15:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E33C433CC;
	Tue,  7 Nov 2023 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699372455;
	bh=D2ifMf8weUkab998trSoLuaVweCIqkI1KaVlq6HwFyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubIQpORKGiOCBnZHFEff3kx8EPqWLs+2JxAviNCpsW0xhb0q56tPNNGTLibRRgzC2
	 0Y7C+8jx5Fsm/soOz5MfnAzO+rvS/Z8hMcV2vRt/PRB2MDmdcAMzXteyayT5dVZ1y4
	 x/eFcvAuXgg6X8Bv/1mdcbY3WP8ct9G1AXbhdiT3bqXdq4Hqg1u9kVbEAjsfpQxTCa
	 IB5rSG0RNqYBL/aPa6tV23GL3Qtno6fRY7weudc1r0vXetNY+9VYz0YA4NIpQHNNZj
	 ScypKfUHr1b2sLwcsgUstS6PTN5DZ3yF9z0BR4FINvKlgq6DqR+ALwuCaZMhrvBkwo
	 fZ2W8oJwH+FHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	3chas3@gmail.com,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/12] atm: iphase: Do PCI error checks on own line
Date: Tue,  7 Nov 2023 10:53:28 -0500
Message-ID: <20231107155343.3768464-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155343.3768464-1-sashal@kernel.org>
References: <20231107155343.3768464-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit c28742447ca9879b52fbaf022ad844f0ffcd749c ]

In get_esi() PCI errors are checked inside line-split "if" conditions (in
addition to the file not following the coding style). To make the code in
get_esi() more readable, fix the coding style and use the usual error
handling pattern with a separate variable.

In addition, initialization of 'error' variable at declaration is not
needed.

No functional changes intended.

Link: https://lore.kernel.org/r/20230911125354.25501-4-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/iphase.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 46990352b5d3f..bfc889367d5e3 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -2290,19 +2290,21 @@ static int get_esi(struct atm_dev *dev)
 static int reset_sar(struct atm_dev *dev)  
 {  
 	IADEV *iadev;  
-	int i, error = 1;  
+	int i, error;
 	unsigned int pci[64];  
 	  
 	iadev = INPH_IA_DEV(dev);  
-	for(i=0; i<64; i++)  
-	  if ((error = pci_read_config_dword(iadev->pci,  
-				i*4, &pci[i])) != PCIBIOS_SUCCESSFUL)  
-  	      return error;  
+	for (i = 0; i < 64; i++) {
+		error = pci_read_config_dword(iadev->pci, i * 4, &pci[i]);
+		if (error != PCIBIOS_SUCCESSFUL)
+			return error;
+	}
 	writel(0, iadev->reg+IPHASE5575_EXT_RESET);  
-	for(i=0; i<64; i++)  
-	  if ((error = pci_write_config_dword(iadev->pci,  
-					i*4, pci[i])) != PCIBIOS_SUCCESSFUL)  
-	    return error;  
+	for (i = 0; i < 64; i++) {
+		error = pci_write_config_dword(iadev->pci, i * 4, pci[i]);
+		if (error != PCIBIOS_SUCCESSFUL)
+			return error;
+	}
 	udelay(5);  
 	return 0;  
 }  
-- 
2.42.0


