Return-Path: <netdev+bounces-105963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A16913F4A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 01:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A6A281AF6
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 23:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E63186298;
	Sun, 23 Jun 2024 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz22wEQS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A035186296
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719187006; cv=none; b=FP3O19LI+cmMheUSrap+Hcz8ZEHElMx73FQp4FnCtb/gQus06qTebCxBMfhxKyKRf3UyfKzXURGajteEUcVF3h++lclvA34n2pKmxeiqPW5fYZzb15Grf3JqUVwzXX2Z86vIyeUWN9S4soNliLGiNOWr1kciEt3v/gFcZrsXqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719187006; c=relaxed/simple;
	bh=85RiAwoWl5C1UMe3lkVQeRWMwB8Ic+VlmRvDNlAe2Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQOU3Jj4zEz1x7hVVb4uhE6Za3on4zTbCR1tvPf4H7ldeAPOrUsQYGpeC/o3Asd8vVf2yUDcuvUhdRqEhibybWUvoxKFcHAHdMcqCPZZwPjt2cLrI4btTQt9jN6tcwDgLpULPplL3hYLcHkRzyK3OXRIGOC2bRepnRKywWAvuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz22wEQS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9a8c59d44so1326695ad.1
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 16:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719187004; x=1719791804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiozheU6mth/a2Ku3j35BYjThqqQwmthUvBOeJLZoHM=;
        b=Nz22wEQSPr7PIHDENzwi6dwjtDCN5jm+QbbnKghtsVUkLtDNGCPEfqhFrLb08xGxg+
         QWknNyVvbJMyeZkjdQkmom2gOc/DEVhRk1gOe4I3zHTEO+zdbItWTt2SGD70TNOG9ZEl
         RuFVbIFso8ZuC0rsFU74NmEFwf0iuCiVWGNhrnnAuX6UE4EmqINZkJneajn1hFRjF1v2
         MzzHZlg2FFDPAwlQOaIU1CH2qljG4M7fRYrdhEoo9buatq7lxjx8lw+q6/UMkvj08O3N
         Qux7PeMVPCQtVdSdqJVdbpCtGyFintGM4JxoKYxw+GDJByWyMeE+jjAH1MPEvn80a+lU
         Zz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719187004; x=1719791804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiozheU6mth/a2Ku3j35BYjThqqQwmthUvBOeJLZoHM=;
        b=WzFmP5z2iGt1tkjvTfokwPrJ4VSiUoZAtOn+4TcDnaM09rQIofJwnDorHS07qFranE
         Dp2gKFJ0FgBeYpuqng6c0TyiSiP+t4p2CtHmv/wSBpuKCslZSzGRRBbBkyfQccAXNRRN
         8zdd5pQfoJHvvHDDTBBmxo0j8DuyiATy8q7XYHfDjhBnjEx4X2JrW4PSxnCb4TjaCELa
         3PzH3arjld8ICeG1b36uIZe64nAAYo9809mDHBF6U7tnmFJjS2l85KfAem9Wvzqcubwl
         F0L97IAaXC+Szk8ywar1lp70jEwyE+DQnCg6pYahTa6v/Q0xLMNpgRh2pObjwx/gg/b4
         l26A==
X-Gm-Message-State: AOJu0YxaJ0lcBMR9TLbnFtHO4LhykUFURynZIpJZhJrpoQ2mnQWYWClv
	+04LHEoMI8qdRsLJmoU93gF4A2R075fE8aobVBV96Muj0E4S0fLcqwGDmsJQ
X-Google-Smtp-Source: AGHT+IFNFkl0UYqb2cN/iW//CXk23zzfG6yDk1W+KUAncXjxCa0OKaWG9PSoQFrePawLoCjp25R19A==
X-Received: by 2002:a17:903:22d1:b0:1f7:178e:6091 with SMTP id d9443c01a7336-1fa0d5a9725mr61294165ad.0.1719187004206;
        Sun, 23 Jun 2024 16:56:44 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb1d448dsm50501985ad.0.2024.06.23.16.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 16:56:43 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net,
	naveenm@marvell.com,
	jdamato@fastly.com,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH net-next v12 1/7] PCI: Add Edimax Vendor ID to pci_ids.h
Date: Mon, 24 Jun 2024 08:55:01 +0900
Message-Id: <20240623235507.108147-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623235507.108147-1-fujita.tomonori@gmail.com>
References: <20240623235507.108147-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Edimax Vendor ID (0x1432) for an ethernet driver for Tehuti
Networks TN40xx chips. This ID can be used for Realtek 8180 and Ralink
rt28xx wireless drivers.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 942a587bb97e..677aea20d3e1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2126,6 +2126,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
-- 
2.34.1


