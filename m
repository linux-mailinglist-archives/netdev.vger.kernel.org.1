Return-Path: <netdev+bounces-245340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5219CCBC46
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1BF8300EA05
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2952D8379;
	Thu, 18 Dec 2025 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OS6MvETB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qm1IHiDL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D7232E14F
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060335; cv=none; b=G3DHt4x3TxTdow404A/o7gijJRJu+EArjKksgSCBo9swUCxz70s44xJKaVJEWhvjJ9QGUmo7Ov5B2kfY68L3YxU9uQ2LbHzlSsBfaoc6cZC1I0xdV23X8bkT0mcluGvr7BGzPu8nzFmzNwtdZZ7AAWvKYJExxRQctRvr+gmAWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060335; c=relaxed/simple;
	bh=hWBQJ3+E0U8FJpuVs/xk/C0ReJ72DkFFHC8a0FQo15k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VRM3GJXMQzRloNtj7pkMTS0EmTYR0Kiyovl1xixlAhdHBDjp8PG8b/OBBpthp+imQCmvwBY7GWFGlW8zMos1H+7rt/SyptzOdhYdQA6Dz1oucNBlZhUp/6upnLgQyiYB6cNfw2fh9Z3hbT9n7yz+fEetUfRdNYcgmDHLHDG4N0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OS6MvETB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qm1IHiDL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766060329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cVewZK5xu+ugU2Wd3i3iaoqWcPOVatkqKNFF+c28jHw=;
	b=OS6MvETBNUBjn3wxaj9e1rQae+x46C0pebTgeKKCOR6EJy+0xV767RaKzGi+i/e4xmYvQQ
	7z86ruBjaD2pZd8NiCJaz7VD+bY75QXVLWo9jtNed72cWbBTtn0cXmbhYm72aLHE6P27+6
	z+vCUrzAzAtP7iTwqdgTr0iyIiVrSUQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-GWTLtKXROV-TJU1CkAHv3A-1; Thu, 18 Dec 2025 07:13:41 -0500
X-MC-Unique: GWTLtKXROV-TJU1CkAHv3A-1
X-Mimecast-MFC-AGG-ID: GWTLtKXROV-TJU1CkAHv3A_1766060020
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430f79b8d4dso429546f8f.3
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 04:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766060020; x=1766664820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVewZK5xu+ugU2Wd3i3iaoqWcPOVatkqKNFF+c28jHw=;
        b=Qm1IHiDLzG8nJzTRYMUUgBrvdi/A5pO+mWEdAMYDfnHHR6A+tnPj2tDbb6s9zVIVQT
         Q1hXBkGvZXgFXz2RojZJ1pLTUStZr3DYKqYGcUPshERHi5jJ9V9phmylOAvk+VnqxVaY
         4nMFoVlD0E0wasqkm7Z6DXeQIdLBGT9K/e7kYHDvGi/q0XiKacSCufASNcfFRWKtSjIB
         1yWHK1T9u+Aveo2LdIR+H+QjKTjmFpJITYg4U91f9GxCxENQgAF98ZMQFVG2DsXTFuxd
         y80t5CLpyESFA+S+ew30Qv0oaiGI+50E3L+gfdAmu9URHr2R9MverzngmPNd0rBpOl2U
         BcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060020; x=1766664820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVewZK5xu+ugU2Wd3i3iaoqWcPOVatkqKNFF+c28jHw=;
        b=wVQEWG98DVOHomlhPTVgM2ev2Lu9HRtXFdA/v7+nXK9/9G4Gbg7Q49eAE9uir+38C3
         f6Pb85OXrFf+IIy9SDEfgDTyhz5DWES7tcf+MCXp+3CA6rbRDK7YCv5jnRlB6OTt0F6p
         n6XAMUT4pDffJe+F351j3KleqBSftXyYNQ0V2z34gQutMsjrMadwUZS/MuCPpmhnLGJD
         cePoGeNtyXWGX8pk79uZTy9uflrCXg4vCoiOTGpeqXj2zBU17r7Wl+eUbZ5rZd7WuG7j
         2pHpw0o6qhwgLF8RTjjQwjJ1oFO8GBC7FlmDm2M63sVZ+Wr9yU/oyvHneBXSsQ+QJcsB
         EuCg==
X-Forwarded-Encrypted: i=1; AJvYcCVBlRMMFCaAinYF5i5p+KHO6Ua/50BLGafPN7aH3YF879fuTICgGWF+8bPI3IBbjnD6oVSSMdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8GDkuzOS78fJ1sGSfB6u39dzHWav6FPU20bRUMl0Jz61NHOUr
	50YlX94pgFK8nDsB6yMp7g7WKivrNciwFlt8mH1N2OqI6+WlfnViV9hmREhHeYOZb4VJtaejmHX
	1YD5m1lom2v4lu3+dRXNkTFP0NRhx21mub9Ihd2LANwrXPL73mO/Bwx8Bnw==
X-Gm-Gg: AY/fxX5k1z3uldDXT+hzLsviCMgaYVM+NhWKFy8CIDmMhJgXc0bNhmJ5rQ8oL+ngPPL
	nyAlgxNvV2OdtiORwMf3+wpeoi3IDsP/ydfZVGaJ7mF2nY2ap/5/dVBrDpe0oZ2R5alOe4XzuBs
	7+eELygzNRPK4n2TZCK5tLnH+rS5M4OtOUCh0O2Mr839fn7VvWx4+HWRrKQCVYxit8pauJ8N80h
	gWLskTTaJrxs+Ysw452xAxxksRLpxEzOc8BwwW+MM1/vALxaHx6SAReUoPM8ipn2jkogjulbHnM
	8uCYieS8YxKgw9oIP3mfTr3RgD//5jgYO2gurvKUbcvSNt0wBrgbkzX/kvoZvv72KHipBvH9lhe
	4gkLjbxdV+Fpo3pj5i9nm9g==
X-Received: by 2002:a05:6000:1a8d:b0:430:f742:fbb8 with SMTP id ffacd0b85a97d-430f742fd90mr15115277f8f.21.1766060019887;
        Thu, 18 Dec 2025 04:13:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH27kkLq+A8uY2cwCBat1PJ84Xqlcq0VaH2VgsIUe2PvmJU+4FaQRSQFmIkqVWZn7sETosQcQ==
X-Received: by 2002:a05:6000:1a8d:b0:430:f742:fbb8 with SMTP id ffacd0b85a97d-430f742fd90mr15115247f8f.21.1766060019422;
        Thu, 18 Dec 2025 04:13:39 -0800 (PST)
Received: from fedora.redhat.com ([216.128.14.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244949ba6sm4736776f8f.19.2025.12.18.04.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 04:13:39 -0800 (PST)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	aduyck@mirantis.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	Mohammad Heib <mheib@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v2 1/2] i40e: drop udp_tunnel_get_rx_info() call from i40e_open()
Date: Thu, 18 Dec 2025 14:13:21 +0200
Message-ID: <20251218121322.154014-1-mheib@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

The i40e driver calls udp_tunnel_get_rx_info() during i40e_open().
This is redundant because UDP tunnel RX offload state is preserved
across device down/up cycles. The udp_tunnel core handles
synchronization automatically when required.

Furthermore, recent changes in the udp_tunnel infrastructure require
querying RX info while holding the udp_tunnel lock. Calling it
directly from the ndo_open path violates this requirement,
triggering the following lockdep warning:

  Call Trace:
   <TASK>
   ? __udp_tunnel_nic_assert_locked+0x39/0x40 [udp_tunnel]
   i40e_open+0x135/0x14f [i40e]
   __dev_open+0x121/0x2e0
   __dev_change_flags+0x227/0x270
   dev_change_flags+0x3d/0xb0
   devinet_ioctl+0x56f/0x860
   sock_do_ioctl+0x7b/0x130
   __x64_sys_ioctl+0x91/0xd0
   do_syscall_64+0x90/0x170
   ...
   </TASK>

Remove the redundant and unsafe call to udp_tunnel_get_rx_info() from
i40e_open() resolve the locking violation.

Fixes: 06a5f7f167c5 ("i40e: Move all UDP port notifiers to single function")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 50be0a60ae13..72358a34438b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9029,7 +9029,6 @@ int i40e_open(struct net_device *netdev)
 						       TCP_FLAG_FIN |
 						       TCP_FLAG_CWR) >> 16);
 	wr32(&pf->hw, I40E_GLLAN_TSOMSK_L, be32_to_cpu(TCP_FLAG_CWR) >> 16);
-	udp_tunnel_get_rx_info(netdev);
 
 	return 0;
 }
-- 
2.52.0


