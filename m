Return-Path: <netdev+bounces-245232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97666CC957E
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 20:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBB33308A38A
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CBA25485A;
	Wed, 17 Dec 2025 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEDmJseW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nlF+/Yje"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F0252906
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998024; cv=none; b=ZFsfRTnWICsJdWgjsrGkx2mp6LjopEvLpZ72S2Ip0/NdCaXpY+ZTZXv/A5k6qvmF5vW19xCy+wisYGmCSTZx28fVA5775kPuj7oP3QVmQZn/DRzTLHlHJtZfFMhgLcAYOJcRpCePn/RLIvEQTOL9rGkfJ5N8fzhW++E6eNuxeJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998024; c=relaxed/simple;
	bh=Ib6lb1NNUtvlHQ8t4+rIbZXiZNG9w2m/d/u/BBbUoWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elhBBzlPBDgLzrdsuX1H5K/6SK9VN5zAHn6N0fkVFSycSs0xgZBxVWW3emIRcbZCpXKQbcKMCgI/ZaajWCTHlOYb+ovEzezQsTjvAQEYxpLL4+21+qiGlqHC0OfES8Rj2pe3+LApxZmIvIH8YUXvYIsTAn8Btq2cL0hnQB8MI50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEDmJseW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nlF+/Yje; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765998021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhYDK86DuWSEE7JgmhksefkOFbDEKuL8YwnjpwwufSA=;
	b=FEDmJseWrIzS1BpyjDubOoAapRsjsa4nAhj3BWCiLu0iTsmivSyLyUBgQR+L2XtEiCFiJL
	cdhKvRLwSDiJ2V6pfGlAMfSSYcCFKnD+Q/tcAbNcadJf9ShUQiHg4yZgFC8lrZb37JZwCi
	IvVEiHlLsm3zss3fBJZTApkSZlKC6l0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-da3Pz9GVNO2Gbw45-Air1A-1; Wed, 17 Dec 2025 14:00:20 -0500
X-MC-Unique: da3Pz9GVNO2Gbw45-Air1A-1
X-Mimecast-MFC-AGG-ID: da3Pz9GVNO2Gbw45-Air1A_1765998019
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477bf8c1413so39301415e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 11:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765998019; x=1766602819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhYDK86DuWSEE7JgmhksefkOFbDEKuL8YwnjpwwufSA=;
        b=nlF+/YjePHxMu69YSqSYBGvF+7sn2+wPU7+jAk70HxbGEJxPkBBArw+QYkZa8vRebw
         GKb7i76OHl6WDhZ0no/RD7CxIIrtdZuTPBeps13beu1SVDYyoP3o6FMDsLe7CDEUvSM3
         rAM4REEdiK10afU7RVjkHtj4dxdHeW6TIZA9Cpqn4Dz8zgHXPh6zrIH+pMgPwTynRV3x
         a8tdXUqOTtz3KjbK5mm2DEZeQl2dReEM197ICzZ8GdalZWEeYgTE9+G0CNAaTjDs0etY
         H4KPRZ8pYe6ZTClaJu81UtfPEAYPblEANEhezzV0X5jJ9Ac57mPBadlGlpOBQGl7GmiX
         NK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765998019; x=1766602819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhYDK86DuWSEE7JgmhksefkOFbDEKuL8YwnjpwwufSA=;
        b=PeWbOi+LgpUE4RpzUNKjPfKQ5BQ3+EM4lXL+V2NMb6B4TfJMIqrFKPMWLI72NDqIhZ
         coT0HWLjNTWK8fIQPWD8vheZSVUvkfXs0zirOk3tETRKDT6Iaf/jSpBNoqU7WNMgpvOe
         WzR1f+zShE2jPemfiCe3l40ecufrtU6TLgwuzSiWezQSMKBjO7nkys5+z1Iy0cuDDBJW
         jBrbfzYR0vr+glekgNdmIxKj7mwoNBoxtPprYaCHYGGr8YVn2QePmBMhCOu05lDMWRi1
         y4/2rpQ+o7jVKm+STtq6oiSFIP/VuEoDDjzRh2Uhpwe3JAvFdOc1hkrGmsFMrGhsG9ND
         tqZw==
X-Forwarded-Encrypted: i=1; AJvYcCVk8HiIQNMg4KE0EaeExQKnr8Xa03NtTn3uHbZpHwev/JKTSZ5U6QsBv+XiK2ZostHcl3X7t3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4fSATDO3+pkgsB2GU+DdxtMB2hSSliI/TasNvvlaz36cb7vK
	utSo2/YyYIHRFVTjQmQ1VNt82ynjsaz1Vr8ZkqdMn6MZD5ZyEJWP2KJtQpgIMPK2upszsxKJNKC
	Z2Cme+pHYrMATLzyvyHTJY1vGIGfxa8SiHOiO/Ld1rYc5cgxxSgaa9qKvzg==
X-Gm-Gg: AY/fxX4aDOZ8GnF5kKapMyF627/cKV9nDu4j9HM5HDPcLpn6WXawJVxgWNw6VNuT7Zv
	Cx+uqLBnwdOsnLg/pdpWqXK6QYh8SeJDd9NXtBnUaKsdcLJeGSIBvhJ/j6rfibHIR6vJdcUY70e
	wFDpy+POKRVtFr050cD0Qwy+6dH7EUnjJXDniX+kM9OkvLYjKcmn6dvHDZPEccTIKfDqIwxbjKf
	F8CZ/fBCbkZrDjekZdZfSsa5Pi9mKqLXLN1mIGQ8WFsqU4aI4XtOgBIjrAplvfMa0k3XZ40Ro9g
	8PhQkmBgdpCpq5agWZ2z26sqS8TH4GNLmdl1xY4MEEtNhqMLCTVkfTQ8iQTtI+zC+zywq+diGGB
	53RsAXt5XzZ2b2v2dY1yshA==
X-Received: by 2002:a05:600c:1c2a:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-47a8f905313mr209064565e9.23.1765998018971;
        Wed, 17 Dec 2025 11:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsZN+tAEw+K3Kn5UGDn9/s6CoBzkm/8OUw3hbNVQOUbAyPedrBp7TFbhiYDnOhq8MNoPTfZg==
X-Received: by 2002:a05:600c:1c2a:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-47a8f905313mr209064325e9.23.1765998018584;
        Wed, 17 Dec 2025 11:00:18 -0800 (PST)
Received: from fedora.redhat.com ([216.128.14.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2723d19sm7782105e9.2.2025.12.17.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:00:18 -0800 (PST)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	aduyck@mirantis.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net 2/2] ice: drop udp_tunnel_get_rx_info() call from ndo_open()
Date: Wed, 17 Dec 2025 20:59:51 +0200
Message-ID: <20251217185951.82341-2-mheib@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217185951.82341-1-mheib@redhat.com>
References: <20251217185951.82341-1-mheib@redhat.com>
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
triggering the lockdep warning.

Remove the redundant and unsafe call to ice_open_internal() to resolve the
locking violation.

Fixes: a4e82a81f573 ("ice: Add support for tunnel offloads")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
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


