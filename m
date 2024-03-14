Return-Path: <netdev+bounces-79968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121CC87C40D
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 21:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925CE1F217D7
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3EE7602C;
	Thu, 14 Mar 2024 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nrb/VxVD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEBB74E0C
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446929; cv=none; b=GhlcCoKXJauOx1R0z2brSdb5cw4oBdgwHpsL52/teh6ATyGq56uQtwgq7ZKTUx0a4L2bKRjFmTo7PriFqz9UePOcy35D1G06J7I1ci502OybLhOuqjqg3WOfGe7bWjApOFXzkIXAVtkVNmJ4CCZNaJPaMLNqd2ih/xiY0EPwbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446929; c=relaxed/simple;
	bh=QXDn+zd2VVXZe8DgdmOjhKPIavoS4i3xnP62Ns1sDis=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kjl4+kNDOBB1MZFDNltUvJMbHxSXsOXtpcmiHkmaao55RTVM+jP2zezXD36AoakngEEa2aUrIR9pwkJZayTqwhg+9ZLUsFJfFH6VMijNWzCjSt7Qb2PZmtKYpZUMulxcicHvC0Ssu9e8Rwzgwi6Z6560BIHLV33m/NSYh6D8MpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nrb/VxVD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso2018294276.1
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710446926; x=1711051726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WaihemEoOpKc/foU9wdPOj8HmOIlNcTK9VdMiM1RKeU=;
        b=Nrb/VxVD4GVNMhgKPPOXBiLbwyUcRk3ftRSYl2JwIj9OchZFIhHWI/GMPS7kpGpuVG
         7vnwjEY1dVpmgnFN5x4rCvVZu479N4BfehS1+zcmDbqP/IclPmH05yzPB/oXhwmQQkEu
         cF3PY0o029W3vWCqMxVE0Lu4KbP91wKQ9fM5PxPmuH0h4zq99tOc3cgw1GWkD42QcvCq
         xiNDxWugAEq7iry8QnCrP1X2ROqiAnSgXiyS+kBLxrw9iGWz66Wz/2H/YS5GsQnvqbKi
         Zo9Wye4XgYJLX0y4hrcyTgNOLCX9eBl+Nu8jTUPFaxRBYkxYSxXgr+WBy5O40heVj55k
         ayGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710446926; x=1711051726;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WaihemEoOpKc/foU9wdPOj8HmOIlNcTK9VdMiM1RKeU=;
        b=UZIIU6Fv+cZ+EwJaO3uRx/It2bvP/UVf+uRqVOL4QL9d2oyxZtKgKEuBe77pe6oa95
         Kul/BnPMeYndQd6vFpLeH2AfYGsdaa7tpVfkjkIOJSLKxwD2ESGD+18reDc4TR27HCwn
         3cAzYeFozTDTpTq5ZBf1BWxIC3vRkgE7a/LpmYFXJV6KhikLmdbWiCa+XSWUpDgc39Ik
         4A94S5gKu+4mYbPh7moXHeDcZO7fck9Z/ynNtlhD6ZpHWRH8XSI/5ZrwBhUpbUEm1SXm
         DGIVfowzbq1z0fANZ/96J4kxjIM8bwy86woCadV7QrMcf39U8cfKmuc1ADzSR9SkSrC9
         Qfeg==
X-Gm-Message-State: AOJu0YxSkY5s0HzfA5/Oqb1L0hugPoiihI90uPetlCRFLGmX/wB6D9co
	mzBhlf1x+FQNbeZjOSWZgdD8azJbUjPB1fysqyfsolLYdQ/2gWON0Uj1+mmq6zxxhFpQsDU4Y2i
	zWsmOuz4lJA==
X-Google-Smtp-Source: AGHT+IFkoC+arSjwhgTurG6lnAm2vxquI79HL3A03LbNvGPc9lxBK5PhDqm27zPTryIudXr7COAb2cxlFW9hsA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2408:b0:dc6:dfd9:d423 with SMTP
 id dr8-20020a056902240800b00dc6dfd9d423mr126412ybb.3.1710446926677; Thu, 14
 Mar 2024 13:08:46 -0700 (PDT)
Date: Thu, 14 Mar 2024 20:08:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314200845.3050179-1-edumazet@google.com>
Subject: [PATCH net] net: move dev->state into net_device_read_txrx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

dev->state can be read in rx and tx fast paths.

netif_running() which needs dev->state is called from
- enqueue_to_backlog() [RX path]
- __dev_direct_xmit()  [TX path]

Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Coco Li <lixiaoyan@google.com>
---
 Documentation/networking/net_cachelines/net_device.rst | 2 +-
 include/linux/netdevice.h                              | 2 +-
 net/core/dev.c                                         | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index dceb49d56a91158232543e920c7ed23bed74106e..70c4fb9d4e5ce0feb0d82578b878da3dbd00a7fb 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -13,7 +13,7 @@ struct_dev_ifalias*                 ifalias
 unsigned_long                       mem_end                                                         
 unsigned_long                       mem_start                                                       
 unsigned_long                       base_addr                                                       
-unsigned_long                       state                                                           
+unsigned_long                       state                   read_mostly         read_mostly         netif_running(dev)
 struct_list_head                    dev_list                                                        
 struct_list_head                    napi_list                                                       
 struct_list_head                    unreg_list                                                      
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c6f6ac779b34ef1a8f98853c84a7a2e0192e0e8f..cb37817d6382c29117afd8ce54db6dba94f8c930 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2072,6 +2072,7 @@ struct net_device {
 		struct pcpu_sw_netstats __percpu	*tstats;
 		struct pcpu_dstats __percpu		*dstats;
 	};
+	unsigned long		state;
 	unsigned int		flags;
 	unsigned short		hard_header_len;
 	netdev_features_t	features;
@@ -2117,7 +2118,6 @@ struct net_device {
 	 *	part of the usual set specified in Space.c.
 	 */
 
-	unsigned long		state;
 
 	struct list_head	dev_list;
 	struct list_head	napi_list;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0766a245816bdf70f6609dc7b6d694ae81e7a9e5..8db23b3c55f10a98870b2b4b9c403bbf48c41d77 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11665,11 +11665,12 @@ static void __init net_dev_struct_check(void)
 
 	/* TXRX read-mostly hotpath */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, lstats);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, state);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, flags);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, hard_header_len);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, features);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, ip6_ptr);
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 38);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 46);
 
 	/* RX read-mostly hotpath */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ptype_specific);
-- 
2.44.0.291.gc1ea87d7ee-goog


