Return-Path: <netdev+bounces-135837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA9C99F62C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A759AB20EC4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF61F8180;
	Tue, 15 Oct 2024 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIhh/qmg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CB81DD0C1
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018312; cv=none; b=NPQ+N4lsICceAHRW6F5dZwCUHXop1GTZmfunkZQ5wsSL/6gpkB4/7CykKyCmTFuWGnxwFhs3ixO44LMJv6q7vmt4B+akSC2DNZbXwkfvyPnp5Ys3fT1VQTsCi+guD61+bqfETdDnA4tTtEoJNM+HF5yN9bJ6NQg9LllcjoSz91g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018312; c=relaxed/simple;
	bh=KHLKi60pv4gLVTsiuJyXLJXAzGodCYBvpuQkjf82Rd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udpanVxZRo0HDpBtSG4jt0zU1mF2EhyZdwyJmFyXtXqMXFdLW3cRFPSbB7leQTACUZPzDcXKhH1ieR9qzKjjXilqRUskadDE29EW2IRFDyAJczxkrD9zZqMuf57ZzZFABf9/ZTSHmD98IPjCICQraZGYdRK2vm3dB7bVixsukWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIhh/qmg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729018309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bl3QB30NLAEEM3JzJm3v9Fl/AaPLWrckmhbzUoxAcY=;
	b=gIhh/qmgxQ2pPvvPJXjiSGpFhRQDI+Gs5k86wb6DxozkgIdYOV+o07b/lq3rOjlym0us5x
	aAvfst7M+iBJzquqEeHZ6oNfUOBmbE+ScLH8JmLx8EF2ZXi1TwQR+AU8Yl4eaaOR6w3VZ6
	puJat6inyEktFLT1fH/wA/BLUv24U8s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-5n7JxDprPCuzFbVOqGC00A-1; Tue, 15 Oct 2024 14:51:48 -0400
X-MC-Unique: 5n7JxDprPCuzFbVOqGC00A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c92ac59bffso4352479a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018307; x=1729623107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bl3QB30NLAEEM3JzJm3v9Fl/AaPLWrckmhbzUoxAcY=;
        b=JxHPl3PvuF7oW1dHRn7fW24iLFCnYtn9qp+cshU3QcE6UVZGwKdGPiCBVTZRBAV/zZ
         TLmiikWvP2M9rM7xS3SNHUtNpHdgBDd8dYQzQcxt3Je81pgxz84tgPWjhYP5f05hwyqE
         QIzeSlNA6afcvNUK34C1LXbCgu046ZzkBlupZBxDWuY9iuNtZG0ZUP1P8+ZlTpfwpr1X
         twAhfIEoV+QaWDnqFmHdKYAta9aZ6fi4Ov/fYZXD9cn1npsSgTctnyeei5+jVV4e9CqR
         Ue3h+JPH/zNNONxgV32Z3qAca1LUpuIVhnFSUjCreSrTKEFPQJOcs3CLN2eEw4Ex/HcR
         Fyug==
X-Forwarded-Encrypted: i=1; AJvYcCVBiqzbST2ELoSJvQV5XqCHq2I7Me24HDvIC9aVSfxcbhawd8XlB/kJr5xewFzm0lXtl/gNRds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuJ6edSd2o+B3QE1TyEX+TKpY8703YIP2sXxh563cPwhRoJ2kY
	9IagR//8mIy9/92F+/Gs28aeMwgyTWIasPMaZdq0cPv6xlllMUZc0tQZwdDoGtbsqtDo4sQo8gJ
	or7wM9iE0xhghB4Laoi6JH94k505uuJ5R+7FAUkN+kRVg9SF1Xp/dYw==
X-Received: by 2002:a05:6402:274b:b0:5c9:758c:307d with SMTP id 4fb4d7f45d1cf-5c995123e65mr1042674a12.34.1729018307263;
        Tue, 15 Oct 2024 11:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcpsVUn9n0QaeMUMW5c7DLX/r1R+cfZY7789CvnHFdFGuHG3lQrtgeZ9VzucvxMpAlT7QteA==
X-Received: by 2002:a05:6402:274b:b0:5c9:758c:307d with SMTP id 4fb4d7f45d1cf-5c995123e65mr1042656a12.34.1729018306780;
        Tue, 15 Oct 2024 11:51:46 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d5d5a0006e2615320d1d4db.dip.versatel-1u1.de. [2001:16b8:2d5d:5a00:6e2:6153:20d1:d4db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d39a9a2sm974438a12.0.2024.10.15.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:51:46 -0700 (PDT)
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
	Chen Ni <nichen@iscas.ac.cn>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Eric Auger <eric.auger@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 02/13] ALSA: hda_intel: Use always-managed version of pcim_intx()
Date: Tue, 15 Oct 2024 20:51:12 +0200
Message-ID: <20241015185124.64726-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015185124.64726-1-pstanner@redhat.com>
References: <20241015185124.64726-1-pstanner@redhat.com>
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

hda_intel enables its PCI-Device with pcim_enable_device(). Thus, it needs
the always-managed version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b4540c5cd2a6..b44ca7b6e54f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -786,7 +786,7 @@ static int azx_acquire_irq(struct azx *chip, int do_disconnect)
 	}
 	bus->irq = chip->pci->irq;
 	chip->card->sync_irq = bus->irq;
-	pci_intx(chip->pci, !chip->msi);
+	pcim_intx(chip->pci, !chip->msi);
 	return 0;
 }
 
-- 
2.47.0


