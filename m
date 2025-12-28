Return-Path: <netdev+bounces-246193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79ACE56A5
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 20:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C955930351ED
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681132AE77;
	Sun, 28 Dec 2025 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vj3V+5NZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qk/JQsXO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590621CC59
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766950871; cv=none; b=SDq88DL17xRkKzVKZFDaiNEQBA92oTkn1tnMHOCtA/tWu7jWcQJpX48T4rt6h0EYqZm7s1yQPfNNLaAMELChlBEwbiobEVd43cy3gdOiAiFhJe2fBm2dhcsMpRBKznvn9ZtSdD7M0Qy2RKL88ZSlIMnHjti0bMDkza77ZbFYSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766950871; c=relaxed/simple;
	bh=21bcbUg/Jm5WJLiHoc11VOU4SUzRQEvcHt4aWBRAjbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GalTGcjiZD5wYHB9MZW2ePEu317G3Di9On5/XdNcJBs00953DhiPSmt+bcVeOmXmI6k4pOOx+kIRCmuvMg6MPX7b5FdEE3598NnzZ0lne6I9TlDIxzH7flKExlCgMxYPjzgMrrRuijey7JwZy1VX10m+/0/OwM1tfnbNisxD+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vj3V+5NZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qk/JQsXO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766950867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KPyZXn7HWfk1U+VNcBhSlEAG+YOIOxdW/Kr4DE2rJc=;
	b=Vj3V+5NZo6u4JuxVc48bwABeoehzKGbjwWZA9LM0QUd8VSIj0auWd9lZI4uRSpmXcAxA9q
	I3n0ouaF2oewbTm3AhTHPMcDQfTxpS0tFYd9AM9xGnC1gkuX3PKIpvLzKlH69dRqfQmygc
	HZtviKIGAVjbojgBTGdHu5dhsVY3tPU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-vn2m5_LOP4iyA2KPehQVTw-1; Sun, 28 Dec 2025 14:41:05 -0500
X-MC-Unique: vn2m5_LOP4iyA2KPehQVTw-1
X-Mimecast-MFC-AGG-ID: vn2m5_LOP4iyA2KPehQVTw_1766950865
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fcf10287so5995935f8f.0
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 11:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766950865; x=1767555665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KPyZXn7HWfk1U+VNcBhSlEAG+YOIOxdW/Kr4DE2rJc=;
        b=Qk/JQsXOGyqYnbdxSjK0CpBxbz3icRnSDzCrKI8azfcfNMBP+GGJVTgog2G6V+s7AS
         WV/AGYFgdUFFBcpXKs35T5zloFs4SqPmeR2vyuS5F07ubXqaMfUhp3raWrI8f8aKYqYP
         bxpSudUB/UZeHlcG4PuDXY8iF2K7X4pawWpios5hWp7nWt/LAeaewcDgLUxr2iu+XQR1
         tz2MFDuog2D4YpKB1b598D7HQbo7mrqUIrVWZvsQcsZ+458YivMe+vzH8yOjrU3iIqLG
         ErWVNs5EaDW4c/96ByZJAmn1/XwcY8BvHfF1hYEFAt6kdbGX8nBqpS19QZdHXwy+1Re5
         qGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766950865; x=1767555665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KPyZXn7HWfk1U+VNcBhSlEAG+YOIOxdW/Kr4DE2rJc=;
        b=Zja9Lr2oQ5Afg+fjFDQ5NO04dydTW2qk7W8M2q7vaeA6H4SZnjcX9dRq0ptqKdpSqU
         9Ze5GWwFMax/sWak/NDh2itOuu2fc6irINjN1Bs6q6IQDBVcop0s/e4LFf9/07S3Nktn
         zE/kW/YbDiFLS9kwtDPrxtirv+7CF1+5+q5Oz6hOejTu/lXVYNQXjDraybrdLFQE0Kkj
         VHZm4JF5hYPRN/G6WmHPD44lKQ8Q/OwxTcl+DUnSXFti3ufG86t+80l6IhIVVSdtLvnH
         SJgYEGCUIAuhmLEEsUfIGPnlAsYW12k62n/a+eAsMjRoT9cWXK/UQPgXnIHpdGQiR3Ci
         7Ahw==
X-Forwarded-Encrypted: i=1; AJvYcCW0IcaSkQ+vLPAqQAfVbh5hvj/ZIxSXVOGzET1LVXpcszFnLbiojDx6/j6daNNf+yZRDDsyRX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAgEiHHeIh1ZL6X8WH8KfgilPPOWo4kkTrOhMwLH8GCO/EFHkg
	dqT/r8bE6grMCc48dC91Z6Fbs+7iHgjolkOAEjC4XeGA52pNtLuRw4o0HD+WyEirRlCTGwonQ1F
	WP/Y1svYjNEiVXT/MkD/jQt70hvgNX7Xl1BX70ZLZnkYQdGoJYxAq00+dig==
X-Gm-Gg: AY/fxX5MOFFT46pBGU+HG+hroWUtDe71RGwJSH5UJXVntWZW4oeQae8o1B5ovfh1D0n
	I6vdmAY0Vu4kzz1IIvvUQm7FXX9ZbI4i66XUWBOig7yFiQ8wqiq2dCK/2JwxIBVJ0BUHik/Xr8r
	Kj0bLdgnKlICRulLOgQ64PYao451a8Ghr+sJRgG8hlbcXm0cAyrg7lzvAyAPp80dEBUfEBEnRSe
	5afWHJS3oB6VBRdp28FYN/7aY07H3tFnxVTqVA1516gWbGKs7tZjDScjrx9tFxfasVcAP374jD9
	GucMclA4jTVtWBGIFXMCEyJ38sDudl/H/vGSPX/v0o9hyAp9NQjdUGneqL8ABbDlHh93dk3u0YF
	MdszLepe3j2P0VMImCjjxPg==
X-Received: by 2002:a5d:5f46:0:b0:42b:39ee:2858 with SMTP id ffacd0b85a97d-4324e50ab82mr37440595f8f.42.1766950864755;
        Sun, 28 Dec 2025 11:41:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo5eKLHCPrMiuJAWK3dekdFQFm58PxWVXUObBNMtZL2dxBCtvZnBDDfY5oX/7RDiguI1XDyg==
X-Received: by 2002:a5d:5f46:0:b0:42b:39ee:2858 with SMTP id ffacd0b85a97d-4324e50ab82mr37440575f8f.42.1766950864378;
        Sun, 28 Dec 2025 11:41:04 -0800 (PST)
Received: from fedora.redhat.com ([216.128.14.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327791d2f3sm25324182f8f.11.2025.12.28.11.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 11:41:03 -0800 (PST)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	aduyck@mirantis.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	pabeni@redhat.com,
	Mohammad Heib <mheib@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v3 2/2] ice: drop udp_tunnel_get_rx_info() call from ndo_open()
Date: Sun, 28 Dec 2025 21:40:21 +0200
Message-ID: <20251228194021.48781-2-mheib@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251228194021.48781-1-mheib@redhat.com>
References: <20251228194021.48781-1-mheib@redhat.com>
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

Fixes: 1ead7501094c ("udp_tunnel: remove rtnl_lock dependency")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4bb68e7a00f5..a91f96253db0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9631,9 +9631,6 @@ int ice_open_internal(struct net_device *netdev)
 		netdev_err(netdev, "Failed to open VSI 0x%04X on switch 0x%04X\n",
 			   vsi->vsi_num, vsi->vsw->sw_id);
 
-	/* Update existing tunnels information */
-	udp_tunnel_get_rx_info(netdev);
-
 	return err;
 }
 
-- 
2.52.0


