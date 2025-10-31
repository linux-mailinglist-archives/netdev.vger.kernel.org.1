Return-Path: <netdev+bounces-234673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F8C25E6D
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F6E1A62B44
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FA32E8B67;
	Fri, 31 Oct 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOjCy50d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24B2E8897
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925958; cv=none; b=EMVTdSZHzJ/9GrZUlQoJQS4oOSQqMe5dr71RNKI5Gnq5xqCe8R4FC8UfehtTX255VF0iRaNANN8azxOoGorO6y/DPHMRRFo5MicUVOkrZgHSRvO6604R52BZrFgLZQ1nNJNlQ0BdJfrFeWjfViTOa5nEKxEjG1n7lxdP7C2rknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925958; c=relaxed/simple;
	bh=OI1IZ6UgzF/k51tw6zNtgLIAhPXMRfDLslfwVElB/NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwTCIzd0V2YisE6csPdGYst93+NzxVWR6Lby2ZF3/pxXi1idZOUPQFVBeuX5KnHjBYvtufgnMQXfPGJ2YYZ9Bv/ZwHWaKXYMGeET0Og5S/6OBWS/brj4EtXtFLElEUo3+ALJ4ET372Ay2d6QnNZX9okRiavdH9oas5LvZYIA9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOjCy50d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761925956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIzM4fYdMSU0eX3UNpKPNMK43pz+VQr6Zi7lCYPO6bA=;
	b=jOjCy50dzAGdUZEPHVW6yp9HUNTPIZZoI798zdPh/+HzjELAal/TUVhKx+jVaI3+P0ebdt
	2EB64O4DDoLaut39DkFYRNE2Au1uHghw1Stsb7DT6OAULAND458QeBzNFRUVtyLttl7f5h
	u6Mo+K85kckaM9+d+Lmv5jZY9GXFt4g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-EoKNNH4uNVCgZrrW0Y3s7w-1; Fri, 31 Oct 2025 11:52:31 -0400
X-MC-Unique: EoKNNH4uNVCgZrrW0Y3s7w-1
X-Mimecast-MFC-AGG-ID: EoKNNH4uNVCgZrrW0Y3s7w_1761925950
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4773a7dc957so7180835e9.2
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 08:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761925950; x=1762530750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIzM4fYdMSU0eX3UNpKPNMK43pz+VQr6Zi7lCYPO6bA=;
        b=Li8RKJjjndUMBqZnQV/ES6cgJJKMeVYJLMMtXFtCwANR1r3kQwKsTK+6/dPkbFPZsk
         3d8r5bh/5SKXJmxU+wdkWSJyjeIFfmPAhgxe4lpsjEW+9yr5RJ4m0opPNZFuZBWfN44+
         3+VcWqqm4CQpajckiVHAKi4nilkRtDlGEOsluwLja6FzZH1VzbySmJhChaSysNqaFcS4
         5iPdmtQeZRD+QIyTmWnur6Lyd4XqVb/7gjTsckPeQ2bI/g+bxueeS1Im6AkwEBMZDxvI
         i5ZZx4/4C6jJcnNS0yyFLkjKfhWQI1pMVI3lFuvmsLQN47bIkp+jHw08uMg7enWRIEag
         Ma6A==
X-Gm-Message-State: AOJu0YwGtJHGUUJ86cPpIvRpJnpcKJExZGnAO0fKtP6V/qItS9hj4r39
	ROTOd2jhxossRzRbzkk3Kp55FVlz3m1aTY1qPgS21XX5m0Ztoh+psokmAvpvzTZpZVMUw6bRU3u
	kQNOEcTgSWfOry6bA1Av2aAWDMniINQJcsqz1061SPfpKrJ4eCreBVghVPl7woYmNzppU7/J7sq
	MGXc9OtLPQpHTjJ17pvPDFQ5zwh/ZYR13/XVsyEA==
X-Gm-Gg: ASbGncvxC/PBcWIGQbDapsp8CUIRImSFJ+KQmeH7hr5WtIJW9bmE8J7v3TMLyCYV/ur
	VguwovNv7DwQEpbiesuMMMuF1s93YcP6yfCbLeDzzbAn+S7vLK8GBt1syyFM21ufm4IaKg3aEP2
	3nmiq4wtm7apakQhrPD68K0nGqI85puu5NS3Vu/cn/cpMzKxKOOXHbc6HQGj7scJ25lBFucTLxT
	KOwq6DIL5orBegY/KK9G5gCDcK4TBDodP200HU5Bdp8OoM3xskg2SDmW2WTB6erbN3JPydIA3LT
	mULhmV8Jme8et0hnAsrbwwC3jFSgND6CPuFsK+UFnMv0WXR/2fxgnUspKc58K6UtdsJOIi1Qft3
	jPs2aZ7cF0k6d/S47W7H9XTM0HubB8GtdgH8M0IaC
X-Received: by 2002:a05:600c:3b14:b0:477:bb0:7528 with SMTP id 5b1f17b1804b1-477308b72c6mr33543315e9.22.1761925950174;
        Fri, 31 Oct 2025 08:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXPls56xyYVWzsFJMvSUf+1mH9/PAwJAHPqePZm1uzj2hSEWKRgv/O2fXeLPktq+CttxUPOA==
X-Received: by 2002:a05:600c:3b14:b0:477:bb0:7528 with SMTP id 5b1f17b1804b1-477308b72c6mr33543065e9.22.1761925949709;
        Fri, 31 Oct 2025 08:52:29 -0700 (PDT)
Received: from fedora.redhat.com (bzq-79-177-147-123.red.bezeqint.net. [79.177.147.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2ff79bsm4100635e9.6.2025.10.31.08.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:52:29 -0700 (PDT)
From: mheib@redhat.com
To: netdev@vger.kernel.org
Cc: brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net 2/2] net: ionic: map SKB after pseudo-header checksum prep
Date: Fri, 31 Oct 2025 17:52:03 +0200
Message-ID: <20251031155203.203031-2-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251031155203.203031-1-mheib@redhat.com>
References: <20251031155203.203031-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

The TSO path called ionic_tx_map_skb() before preparing the TCP pseudo
checksum (ionic_tx_tcp_[inner_]pseudo_csum()), which may perform
skb_cow_head() and might modifies bytes in the linear header area.

Mapping first and then mutating the header risks:
  - Using a stale DMA address if skb_cow_head() relocates the head, and/or
  - Device reading stale header bytes on weakly-ordered systems
    (CPU writes after mapping are not guaranteed visible without an
    explicit dma_sync_single_for_device()).

Reorder the TX path to perform all header mutations (including
skb_cow_head()) *before* DMA mapping. Mapping is now done only after the
skb layout and header contents are final. This removes the need for any
post-mapping dma_sync and prevents on-wire corruption observed under
VLAN+TSO load after repeated runs.

This change is purely an ordering fix; no functional behavior change
otherwise.

Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 30 ++++++++-----------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 2e571d0a0d8a..301ebee2fdc5 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1448,19 +1448,6 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 	bool encap;
 	int err;
 
-	desc_info = &q->tx_info[q->head_idx];
-
-	if (unlikely(ionic_tx_map_skb(q, skb, desc_info)))
-		return -EIO;
-
-	len = skb->len;
-	mss = skb_shinfo(skb)->gso_size;
-	outer_csum = (skb_shinfo(skb)->gso_type & (SKB_GSO_GRE |
-						   SKB_GSO_GRE_CSUM |
-						   SKB_GSO_IPXIP4 |
-						   SKB_GSO_IPXIP6 |
-						   SKB_GSO_UDP_TUNNEL |
-						   SKB_GSO_UDP_TUNNEL_CSUM));
 	has_vlan = !!skb_vlan_tag_present(skb);
 	vlan_tci = skb_vlan_tag_get(skb);
 	encap = skb->encapsulation;
@@ -1474,12 +1461,21 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 		err = ionic_tx_tcp_inner_pseudo_csum(skb);
 	else
 		err = ionic_tx_tcp_pseudo_csum(skb);
-	if (unlikely(err)) {
-		/* clean up mapping from ionic_tx_map_skb */
-		ionic_tx_desc_unmap_bufs(q, desc_info);
+	if (unlikely(err))
 		return err;
-	}
 
+	desc_info = &q->tx_info[q->head_idx];
+	if (unlikely(ionic_tx_map_skb(q, skb, desc_info)))
+		return -EIO;
+
+	len = skb->len;
+	mss = skb_shinfo(skb)->gso_size;
+	outer_csum = (skb_shinfo(skb)->gso_type & (SKB_GSO_GRE |
+						   SKB_GSO_GRE_CSUM |
+						   SKB_GSO_IPXIP4 |
+						   SKB_GSO_IPXIP6 |
+						   SKB_GSO_UDP_TUNNEL |
+						   SKB_GSO_UDP_TUNNEL_CSUM));
 	if (encap)
 		hdrlen = skb_inner_tcp_all_headers(skb);
 	else
-- 
2.50.1


