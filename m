Return-Path: <netdev+bounces-245337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 091B7CCBC15
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFB9D3006AA4
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F7B32E6A5;
	Thu, 18 Dec 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYCD2EOG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdyT99ut"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8E32E13B
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060029; cv=none; b=RJfa44f2/dUha+UHqlqPvIhim32dAvGr6W3pyTsLJmQcjjbGMYFy8EDNtf71q0om8pdwcfPSZxuYc9qfQIdKpoJ/nsfHvbV/8XvlEL7EHhGmqlso9qWnqrHAC+kCj2wKw175AZczA+X4V5I8CbzCKHeM4STKpr1XbImJOk2AhY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060029; c=relaxed/simple;
	bh=jrr5O9AkWqeMAUBLnUJ5Q1Zz2HsiNEBw1tH4SCcXVYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWpcQ++EnIvqDvEqN7YNxct1QD6h7mYAMG7yY2xz02WPcoxFO/MQDqW/1Otv7NnPX1FdsszOm5qJ3zMyUg/cZvnLvw6vOxiraWqktQDbWnDFhoNsBj0rfHx8/lzCr99h/7ODeF/sr1X8vtWvBbZEelH6ANynqP9ycvlnaCe2Ns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYCD2EOG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdyT99ut; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766060026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcC8708HWzanGRdv3W76eR6gK5ZwOXyZ4c+NmrctZH4=;
	b=KYCD2EOGWairDBcUoynnVU2X7tEVD9y0ItCtxlFE0dpcEbK4rihfUuwbUGSGX9PArH+rJj
	jEVE5oPPStry/Eu0XgemnSYQEQX+iNZqeKKeHY+tMJkto25ioutNkLH4gAlZGyP6ayAXU1
	6O2ZXVDw/rgs1Gpzieyt7IVLeeIVjz4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-mrLu4aijPbacPuRxMnhjJw-1; Thu, 18 Dec 2025 07:13:45 -0500
X-MC-Unique: mrLu4aijPbacPuRxMnhjJw-1
X-Mimecast-MFC-AGG-ID: mrLu4aijPbacPuRxMnhjJw_1766060024
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fd96b2f5so403610f8f.3
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 04:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766060024; x=1766664824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcC8708HWzanGRdv3W76eR6gK5ZwOXyZ4c+NmrctZH4=;
        b=DdyT99ut4Cpv1z1ZukJyD4g2GtJG6a55J36FL+VkS1Srlv/X1bj8sdpUPVw5/GL42I
         YIxrDdQDgslrBgovh3sZ2hWzKB3ANYhhFiAAxWs2rglzjWd4x6n3OgMFf2MN6XfhjUHS
         XK/VT4RHhWGPVGshdz13hZdT/iHFjLW4ELt/gtSaWZoRSLjQpyhm9LAdOTuUlizVS7gB
         wg1Ol5vCFOW3cTar94Y9aFZPzlRhLoNMm424HVKOdoJnLEjhiDwYxkg0qBoRfJbiRp+T
         iY+XzC54NjcTSfdRLTwE7Lm199hAZonmonmxRXwtz9DyuQ38uuQCoBwmBZxBszK6BYVk
         8SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060024; x=1766664824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KcC8708HWzanGRdv3W76eR6gK5ZwOXyZ4c+NmrctZH4=;
        b=Mv8TsfNG6/dguLz5Z4UiZggzt9rHc+s/eTHEFAKD4q0OFHU0NWuTRVDwV/WICGEJkj
         8RYpaXLzpk7x3+aXGgcTagwep0VYf+TX/+CBNIVpaYmIWOMpclWbELHpEq1B21mr2+TF
         D7n6UDJi2Q9/3GSYAFbwj/XjRxOKB+3nOZE21LQSVFQSH3aZW/r/pKxDMb/Cf1y59zQY
         OVDgmOAu+CRQstsRGR5Hi2jtBu8HRG4FbsqgnTOMj6zdZJt0yDu+yUXSDsp4BH+coam6
         C+PWcGFZYzmjVJ0xI+3z5exzn5cnpBVxLDgauMBN6OmgI2o/QDsVOugs/btqgZiqIGAh
         7ftw==
X-Forwarded-Encrypted: i=1; AJvYcCW7efC6EjupdK5CUYrdc0DOjgU0ijroPTp31P0EWQNVe9rX8ECav2Dh4nwV+y2lluS9pf/NdP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+/5ELSWrSR74QKndZajxlhqqBF5psBoIZdykrAWqfcz8DvdH
	nqyqCgoomd9wNw5Brt+841Uxr/UGN/zdqqI6Xs16aqIjM2F5b7E0Lnygw0CNN2FD/nIIOEq826Y
	nICQRv6ZD3LusGckjCsbaTKoj6lkCxLX6XDwQy5R5m5U9htYtvv/W1UWThw==
X-Gm-Gg: AY/fxX5RdZCGohjhGunFSJ6fxsOYC/654qXLBdkV0pkyRIDjma5mH0+l8XKm8+V8+eS
	w+vryVdf+hOKwh3rEigjcy1LClfVideXVDBciHdRwWFfrNDmHcAL3hdOvZXez3WqtkPbXH9/2QV
	xF2uV+ysB2N0wuEUtBVoL+kJAuU2iAzcCdVo3TnKkCg7xMOnHagsxh22zgC99vOtfU1rsPxo//h
	LxwUrzkMl22OTtCHPMWSkXTnVVliZ2VWJ1zMVDHgpOkB20I7SiqhWIgxWE3Zq/FnbL35Uzq+LuE
	tpF7E1rnCEQq2V1Ifn3eQmeTZ7MVwwIoeKDfV+fzpYxfuSDVYzj29aKs3tGwA1jxE5bsf4TcSSa
	LDW2JUDwswlnmRX7IaTxESA==
X-Received: by 2002:a05:600c:4f09:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47a8f916685mr192993865e9.34.1766060024477;
        Thu, 18 Dec 2025 04:13:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSjzigBljqVHxrq2NFftERN7thLI7BKGOWw3WfBzVAkcGIWXhr7Dc5D9WQa5nOHuam1MNyEA==
X-Received: by 2002:a05:600c:4f09:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47a8f916685mr192993515e9.34.1766060024012;
        Thu, 18 Dec 2025 04:13:44 -0800 (PST)
Received: from fedora.redhat.com ([216.128.14.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244949ba6sm4736776f8f.19.2025.12.18.04.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 04:13:42 -0800 (PST)
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
Subject: [PATCH net v2 2/2] ice: drop udp_tunnel_get_rx_info() call from ndo_open()
Date: Thu, 18 Dec 2025 14:13:22 +0200
Message-ID: <20251218121322.154014-2-mheib@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218121322.154014-1-mheib@redhat.com>
References: <20251218121322.154014-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

The ice driver calls udp_tunnel_get_rx_info() during ice_open_internal().
This is redundant because UDP tunnel RX offload state is preserved
across device down/up cycles. The udp_tunnel core handles
synchronization automatically when required.

Furthermore, recent changes in the udp_tunnel infrastructure require
querying RX info while holding the udp_tunnel lock. Calling it
directly from the ndo_open path violates this requirement,
triggering the following lockdep warning:

Call Trace:
  <TASK>
  ice_open_internal+0x253/0x350 [ice]
  __udp_tunnel_nic_assert_locked+0x86/0xb0 [udp_tunnel]
  __dev_open+0x2f5/0x880
  __dev_change_flags+0x44c/0x660
  netif_change_flags+0x80/0x160
  devinet_ioctl+0xd21/0x15f0
  inet_ioctl+0x311/0x350
  sock_ioctl+0x114/0x220
  __x64_sys_ioctl+0x131/0x1a0
  ...
  </TASK>

Remove the redundant and unsafe call to udp_tunnel_get_rx_info() from
ice_open_internal() to resolve the locking violation

Fixes: a4e82a81f573 ("ice: Add support for tunnel offloads")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2533876f1a2f..1f94bdcbbba9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9633,9 +9633,6 @@ int ice_open_internal(struct net_device *netdev)
 		netdev_err(netdev, "Failed to open VSI 0x%04X on switch 0x%04X\n",
 			   vsi->vsi_num, vsi->vsw->sw_id);
 
-	/* Update existing tunnels information */
-	udp_tunnel_get_rx_info(netdev);
-
 	return err;
 }
 
-- 
2.52.0


