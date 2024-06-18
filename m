Return-Path: <netdev+bounces-104330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEE390C309
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6578284E7F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D7D1C696;
	Tue, 18 Jun 2024 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlAwJN3v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FD71C2AD
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718687880; cv=none; b=fPdA5hHWX6XCEA9TivwiPYrreC+A9S+ACJ48i8b+U61rd3zw/lx4msfxWh+X++FVx4kKrIzCidpfTLeoFRp1ZndI8vMjjLOsamekIuFvf2PUiL970L2jMhXt2o1zbS85OchZ6QIVjDnzfB3Rf2Tx6cIJS/jzmbUMJNnUFjpHGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718687880; c=relaxed/simple;
	bh=85RiAwoWl5C1UMe3lkVQeRWMwB8Ic+VlmRvDNlAe2Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EoXX5GRk46JsclQucI6vGND+k1+1lA9T2ULD4byJC7TZEzaN4RfszkU3vp2tJFp9xTELS97NPhOo3Qortu+Px2Y9I4eKMHfPvjHb8NF/Z357a04C8Vd6sm9RlcZErZQ5yrgV0NhWqW0YBnXlkdIUp+zC8XDJ/U0DbadoCXXAJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlAwJN3v; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c2c1473f73so734592a91.3
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 22:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718687877; x=1719292677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiozheU6mth/a2Ku3j35BYjThqqQwmthUvBOeJLZoHM=;
        b=IlAwJN3vGgShqjLvzTRWix7IRjz3YFR3dl9aVgnwCyHBoPCtgrgXxPNYVEA0hqFS8E
         Jjjx/C62cuX+15d82BInpmzyoZO/34M8G+9vmMV/z8H5ZoKb0M4hBEYVQGWnb+LW2+wR
         DRIIbVIk5qyNC47ZLWuX9HrwHGYRTIlzlTP1GvwnhAxfY9KmSvVPGfhwrPVGabc9GOP3
         yceDf7bj/tsuIuFpa1eRYRNnO79C3DsRH7kqGM9oLA0ziUl5Gg5VB8reeInvRl7KOEtP
         jeZm42xCHUefYHeNAlM2/+sDoZcl0d+qsLphk4WLDwWXgKDjb7R4wptU5y3tk83ekzGk
         Vrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718687877; x=1719292677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiozheU6mth/a2Ku3j35BYjThqqQwmthUvBOeJLZoHM=;
        b=fZcKuFh1zBez9TwzLWuEwly0baM2MjMOSETgBBPgBHB3WtMKRsdkqWyNeQgcp27yMH
         LxgkzS0pRy10vxddBBB5jC4btpPqS/UrU63hwQ13QpGEa9C+EhPjqOGTnNjKxz1DqGql
         pUxv9PvTHFx2JGyyuKR8Z0zrnB1d99JeWxm5uh7S9klVToS+oxlp5LSEYM+DBQXJb2FJ
         zZkeTU8l0qBlpCQ2bnhhUWFrxS9Yx2IwH/cQTTF7xhbwb6PWXhWfGDAsZkoVH5e5gWCG
         WbnnNDf7I95CD6gjFqbmNxS3VRvR2Sh9Fkdi18sbqKGSxzpnY2+NaDJsScsGSJ7lLBsD
         rYdQ==
X-Gm-Message-State: AOJu0YzDR2Bz3Z2qXaaHslzYM51cl1xES3Yyj0wEkhq7HEyzaXLjVqNm
	+H4u/GYLW6w8U5zfpJxL7lwwNpeatQBcS1qXjeysld+KHipUJz3ReEt44CC5
X-Google-Smtp-Source: AGHT+IHwdz6YemaJf8CQ2xgJ/ldc7aEIuRq7sbUz0pizhd39zegsRLvchdx+LsQBeLNvnMGHM6Dwrw==
X-Received: by 2002:a17:903:1250:b0:1f7:1303:f7ae with SMTP id d9443c01a7336-1f8629fc618mr142149565ad.3.1718687877500;
        Mon, 17 Jun 2024 22:17:57 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6debasm88165575ad.65.2024.06.17.22.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 22:17:57 -0700 (PDT)
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
Subject: [PATCH net-next v11 1/7] PCI: Add Edimax Vendor ID to pci_ids.h
Date: Tue, 18 Jun 2024 14:16:02 +0900
Message-Id: <20240618051608.95208-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618051608.95208-1-fujita.tomonori@gmail.com>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
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


