Return-Path: <netdev+bounces-133550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1E6996367
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855C2B27AAA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E635199254;
	Wed,  9 Oct 2024 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EieKqTAk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A41991CE
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463095; cv=none; b=ZfbjL2BBq6Ppp2v2X3tm1FK8qFqL1TuOlmSI1DR+K0UKNsfKW9Efo3dfQZWHSpwUCvcQP984pqU8bugP36jqxyCVX9MSP1i2TohutWFt97hTd2KbajSnJEKFj8IWiNtspUjXrlfMBb3lnFr18rNXgZIwfL9B0OtcJ8Cvgq5jE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463095; c=relaxed/simple;
	bh=WtIqqb3Qz76cjqi0EoDty0yZzRmnvQrkK4n/LtQ6xEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe6GNvfFXXD/z8Mf6U/qlDVZx3yjHzVANTFmsOjx/CC7F9yUVEw5itM7CDjeQFfb0D723hR4ltuvqH+s4ZLwwTLeeI+vV1vZr022vhBWBDZfKgR5bjkDWlNDXxpF+ps221dkC0dz+lGt1mNK3cC6m9+zAk54T1L1QnfAxwLTi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EieKqTAk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728463092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whIiuNRJJmYlfQ3wiaGZ/HmATem6GNPoxo7pUmmbAqQ=;
	b=EieKqTAkrDo0LDV1F9bo1DPI8UsrfVuin/ZUB2iLfRFIID7Vqf0qKIRCx9Ro9vLkqx4siO
	f2vW2uRdbADcuQDmlOFpcUQeeqs+wKDj/K7Efzmj1qK20EnomDaB4UE5bzPFkaclsi46kc
	rgvlMyoN/aqyg0vnD7vpClmifJH5SyU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-JWKYVcbKMmGpKMQDmSqaXg-1; Wed, 09 Oct 2024 04:38:11 -0400
X-MC-Unique: JWKYVcbKMmGpKMQDmSqaXg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b10e7958c6so78217385a.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 01:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463090; x=1729067890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whIiuNRJJmYlfQ3wiaGZ/HmATem6GNPoxo7pUmmbAqQ=;
        b=m2GxJU/J1/Z53vvFpT1/8DE9B6eHXSrSHWEFTX58kioLjes/YDomFd73AYpnz1m94b
         3JWOhPwwJrboqWCGC9YfBV9a8Fd8eK5pxCcLk95KVUq4p6+s+HHtU5DHGD7v2G5Kjv/Z
         0m96ZwBpo5veu6vig3+qsDBKfemqx+N0c9Y7wtVNEWiJa2HJnGfXkfh2LODY6Tz+/uGz
         eUKLTJBY5lQ3YRDrb/aOkX/XmwlmlcAp7si+wInG3kW70mfsjIW0ZvFejYbp3KJkl9hO
         U5HoIjVkzsSYURsp3Nng1S98no8pJqprbPlWMWX+y8pDXexiRracCuvsjFivswAfOqEI
         p+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9JwyKe9XDdAHlk7Z5pEIpma61reYM8+jOY2EHyPenwEtxf9UHZcDBRNLhgc2SXs3W0vCAUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVe8jj38y5dX2wpaELkblghy/NbgZy2x39mRCZc/66ymWFahi
	ikP0O1xmc8k7fQIXzG5adrPic261IGE14HqqvT5GevpSOlb9lvRGDejDDTym1ooU4C3mrrAAdl+
	oGf/tnU6Np3v7OHcksHAW3Kb3btbH1SAvOQfgkge10+Il71PQbhOiGQ==
X-Received: by 2002:a05:620a:6006:b0:7a9:ab72:7374 with SMTP id af79cd13be357-7b10ed4fff8mr102278885a.35.1728463090664;
        Wed, 09 Oct 2024 01:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/MgCEUv0CJEAIc6rr0qvcu86NTMXEfUgLL+h2hiKBHzQb8C5W8ydxW51ghGpiTPgzdZQtmw==
X-Received: by 2002:a05:620a:6006:b0:7a9:ab72:7374 with SMTP id af79cd13be357-7b10ed4fff8mr102275485a.35.1728463090297;
        Wed, 09 Oct 2024 01:38:10 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75615aa2sm439643585a.14.2024.10.09.01.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:38:10 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-staging@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [RFC PATCH 10/13] staging: rts5280: Use always-managed version of pci_intx()
Date: Wed,  9 Oct 2024 10:35:16 +0200
Message-ID: <20241009083519.10088-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241009083519.10088-1-pstanner@redhat.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

rts5208 enables its PCI-Device with pcim_enable_device(). Thus, it needs the
always-managed version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/staging/rts5208/rtsx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index c4f54c311d05..4831eb035bf7 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -246,7 +246,7 @@ static int rtsx_acquire_irq(struct rtsx_dev *dev)
 	}
 
 	dev->irq = dev->pci->irq;
-	pci_intx(dev->pci, !chip->msi_en);
+	pcim_intx(dev->pci, !chip->msi_en);
 
 	return 0;
 }
-- 
2.46.1


