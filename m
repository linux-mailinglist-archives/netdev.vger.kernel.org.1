Return-Path: <netdev+bounces-139472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392929B2C31
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6F71C21B96
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680A18D64F;
	Mon, 28 Oct 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2Ow7YgB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B72186E26
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109621; cv=none; b=NKZ0KOQkF/97HG+RbuyZCx1DOkFJ8Bj1cgggCxTZr73iVlst8LKtG6dlG5RwZxyB9e6H+S6DrAoHRDP8pwd05BrIxwP1bdvpNo3KhcNZ4UDl7oigY6/onqJUxIc7mW2iNCRmOqf/tVpgP977cYvsbk8nwjhNdlQavuHrqSAA52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109621; c=relaxed/simple;
	bh=cVMe9I+xf7ecSwjH1FSm/7gF6HNNdaU/Br9lzJNXdTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BpOk5buyd49ztyYw5GtbTEruLTvYmQL0Igrsgbh5OVocPtO0GA9dEVsC29zmE0pyOzpZwMnzY0FDvVR0Nmh/ZoCNpX1U7W0laUCtr7iMr4bxevYO6fTIAwiSrOONgzP8ZT+f6+lleZOVeBChexmoIoBKMAibGdlOYC3tcGT4PKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2Ow7YgB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730109618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8YpabpOTIA5fu+COziF12YDYMmgu6EaSPVt0xaySJZw=;
	b=V2Ow7YgBpnSslSIkNtXg6gwHyQkUvcdYvkt2ueoWDydAccphuLu2u36nDJmd9VZUTIkIDO
	xMuFc7tVMFaDp4SybpIxdEUxASKqHfOY0Bsu5FUHJJpHe5Mqgrd4Yevi+TV80r6L2ii5Bl
	AXLg3FKAloRsOV1OqYEmbn/v5ims3go=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-YeXviWCHN8WJnDhYYtLeUw-1; Mon, 28 Oct 2024 06:00:17 -0400
X-MC-Unique: YeXviWCHN8WJnDhYYtLeUw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d5ca5bfc8so2216925f8f.0
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 03:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730109616; x=1730714416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YpabpOTIA5fu+COziF12YDYMmgu6EaSPVt0xaySJZw=;
        b=q9vzKQ8+dzjumLaCKbSOEjgcWY87PCCD4zbbBW2h6UI960ZkpiTvIG4ps0KMR2LX2P
         6/NzUuetcq9n3itEhB7ecajBhA/IFaAPyXWowv2dkNTjbyJXZg/V6Ib4JHCzMLZOuNP+
         XWhBcwsKMq362h2VP5LJpZ1dH7OJ1/ml+E7lTOhwYF1tFzqm/rh313zRBNG0kc/0BO6w
         FI08iIUcPbetGTfLanjdfi8h8wpYcjBnft9HKY//iFaTSnkIdl0SnXWKz3mcwy9X3kQB
         C8LaVFseIya/eWi/iriSye6omPnGsFS3GvOTJaKQFr5ehPJHOnuFgQISs3EV5iv7x6Do
         7Ihg==
X-Gm-Message-State: AOJu0YwK8jgO3TfWsUkeGsJHLejKvL5UGXRd2BXVkqqgFSUOWV+OPVbS
	iVtFlbn8GoEoKFYhjoZEcKuPeuE1rzs9CxcrzXw9qfr2guxP/z13mf3GIU8tEmrgzQcBXPASAUd
	8V6HNMJMRdA9dsbYeHXb9aMeeiH9H43RswAxpCxpvcUDYq98NqBbBg7L41Ef65Q==
X-Received: by 2002:a5d:4a43:0:b0:37c:c5c4:627 with SMTP id ffacd0b85a97d-380610f4bb4mr5224637f8f.5.1730109615722;
        Mon, 28 Oct 2024 03:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIi6IZdt1MNfNyvMwAD0TZOBvib02WaB4Udm2NRudgqSX5IaZwE0C9f76/Y7ROIYfi1CqIoQ==
X-Received: by 2002:a5d:4a43:0:b0:37c:c5c4:627 with SMTP id ffacd0b85a97d-380610f4bb4mr5224621f8f.5.1730109615369;
        Mon, 28 Oct 2024 03:00:15 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm9077706f8f.70.2024.10.28.03.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:00:15 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] ptp_pch: Replace deprecated PCI functions
Date: Mon, 28 Oct 2024 10:59:44 +0100
Message-ID: <20241028095943.20498-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Replace these functions with pcim_iomap_region().

Additionally, pass KBUILD_MODNAME to that function, since the 'name'
parameter should indicate who (i.e., which driver) has requested the
resource.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/ptp/ptp_pch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_pch.c b/drivers/ptp/ptp_pch.c
index 33355d5eb033..b8a9a54a176c 100644
--- a/drivers/ptp/ptp_pch.c
+++ b/drivers/ptp/ptp_pch.c
@@ -462,14 +462,14 @@ pch_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = pcim_iomap_regions(pdev, BIT(IO_MEM_BAR), "1588_regs");
+	/* get the virtual address to the 1588 registers */
+	chip->regs = pcim_iomap_region(pdev, IO_MEM_BAR, KBUILD_MODNAME);
+	ret = PTR_ERR_OR_ZERO(chip->regs);
 	if (ret) {
 		dev_err(&pdev->dev, "could not locate IO memory address\n");
 		return ret;
 	}
 
-	/* get the virtual address to the 1588 registers */
-	chip->regs = pcim_iomap_table(pdev)[IO_MEM_BAR];
 	chip->caps = ptp_pch_caps;
 	chip->ptp_clock = ptp_clock_register(&chip->caps, &pdev->dev);
 	if (IS_ERR(chip->ptp_clock))
-- 
2.47.0


