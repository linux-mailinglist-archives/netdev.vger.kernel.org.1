Return-Path: <netdev+bounces-135838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66999F631
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29011F26BEB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4953E1F9EB4;
	Tue, 15 Oct 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8cB6U84"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D91F81B5
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018316; cv=none; b=As+H0zftLjAz37SHVnNj7y741w71MWbso7y3vGQJebZBOgT45Nx529u1vq/PxDa7t/3FfY9/cmRtOaB3FWb33Q5f2eedKxXI+GXp/eaaxz2t9Xn1ZhNbkg8fFHOhz/8Soc7uQSdCkRo20pB63PcDnICvi2Ri7pSshLg6FLhcybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018316; c=relaxed/simple;
	bh=dO0Bt5S9xKcwhKAQUQyexaV6kggyDnL6IVx7RfRRupg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9DfuZ8asv525cLnBXmPc7xNpu1WUO1JWbMrgcBUCmQB3QvDQqmX/IJm1gTP5kuADS5VoxGbcf1nxVDs1h5F7F91PN91CEl/kFGgLQm1rK/p3w4XhRTD8WJmqL5AcOpPQPmJ0/HcTS+s1i3O+hgxdMpV0KK5EcXPFYz9556tzIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8cB6U84; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729018313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UdUsG2Ce2FuhD+Vr0J1b3PhjfLKCU3S+xUJ9DfCqJQ=;
	b=g8cB6U848Gt9XQxP5auObeLjNMqwplENKDWcSmOGafvXqiDlZvJKb3zC1FcFSFU3Vcvhgt
	GOhxwo2HQU9HYF81sQctGWlkh6n2Ed3O+lmEUn5b6EAZ8P+1IBhsdj0S3+zsDykE/1BpEw
	GyLonnEtsi8Mni5cK+o178RrLLnJAQk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-9ga_kUuYOK-AyrZct5jlpw-1; Tue, 15 Oct 2024 14:51:52 -0400
X-MC-Unique: 9ga_kUuYOK-AyrZct5jlpw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fac504fb8cso40370471fa.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018311; x=1729623111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UdUsG2Ce2FuhD+Vr0J1b3PhjfLKCU3S+xUJ9DfCqJQ=;
        b=sxsp2NoDgKQrS/HoBXYpaX9bmiFD4fqOnSlXo6AKuSqqFjJPpbf7t1IEjkMrc07abN
         x8NLXPByvz/bDqbxUu6AAMCgN3uF8FYM4k9xMLy9U50RLBGQCHqu4WwbPstLijFWyv+9
         RUUMXHmW6k1R+VAAERJF6nLpkNq4g32E1AaEj+TLIU4y+H4pmSNxfVjtCgcxjfxSWwP4
         /r+A/1sh9vQAKL9bZdkOddT7OswambR1SoYM88QSa+ahGj/VZr949msB1L/DVsvzQfqk
         86yQBK9SLjaB51mCXs6t9dBvxy3m8ijuaJPA4HBTbDDfMq55fowmDEMsVIiMkUxwcRKT
         6dOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWOk2u8U7eZk/1HoLmKEtcCsyjrUBJj6c2V9NNZFk9ExY0z+XUnzRqqDbxibzrCoiz2IaQjBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvM1gVv5s7dqgQwV7jptu+C7NSTSDsDFDLN186XiVzflbB1lp6
	VoETr3kDpgEGV8cmTgVlIb3L1c+3beR4+Hd96xqB+LGNdm6CU/LbFiTo9pX7dDJE6XKufWmJx8e
	kCmxV4ZIMPGcI51b01usT/oMIcAqZV6NLqkareO2Sn5jONmh3+sTZMg==
X-Received: by 2002:a2e:be13:0:b0:2fa:c0fc:e3d6 with SMTP id 38308e7fff4ca-2fb326fc5a0mr82286341fa.7.1729018310980;
        Tue, 15 Oct 2024 11:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg0lXB9d95359mfSRgxCA4dveTgVHKUj5pW+Si5SQOi+coS4w/96kFO+qIGBhPz8zuJnYPgA==
X-Received: by 2002:a2e:be13:0:b0:2fa:c0fc:e3d6 with SMTP id 38308e7fff4ca-2fb326fc5a0mr82285671fa.7.1729018310336;
        Tue, 15 Oct 2024 11:51:50 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d5d5a0006e2615320d1d4db.dip.versatel-1u1.de. [2001:16b8:2d5d:5a00:6e2:6153:20d1:d4db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d39a9a2sm974438a12.0.2024.10.15.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:51:49 -0700 (PDT)
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
Subject: [PATCH 03/13] drivers/xen: Use never-managed version of pci_intx()
Date: Tue, 15 Oct 2024 20:51:13 +0200
Message-ID: <20241015185124.64726-4-pstanner@redhat.com>
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

xen enables its PCI-Device with pci_enable_device(). Thus, it
needs the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xen-pciback/conf_space_header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index fc0332645966..8d26d64232e8 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -106,7 +106,7 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 
 	if (dev_data && dev_data->allow_interrupt_control &&
 	    ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE))
-		pci_intx(dev, !(value & PCI_COMMAND_INTX_DISABLE));
+		pci_intx_unmanaged(dev, !(value & PCI_COMMAND_INTX_DISABLE));
 
 	cmd->val = value;
 
-- 
2.47.0


