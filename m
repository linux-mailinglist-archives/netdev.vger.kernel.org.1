Return-Path: <netdev+bounces-134352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CE998E9D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8BE1F2172F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0816A1C330A;
	Thu, 10 Oct 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrASQJTl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F519D087;
	Thu, 10 Oct 2024 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582268; cv=none; b=qYCIousvDPBAICVSq/quWjcG21IWCOppaGBDVtxeSieE7sc1R9pR6nUkAq4DU1KPeJ61Hpiup2LQe0dydsIw2DRZhr9AmrEFSGsPcXDPSo24UPu2i7bICHqL8703aswFucWR55yeK1A7ImuOn6IncKXq4HPVIgKRNimlFQwkQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582268; c=relaxed/simple;
	bh=LK+H95GxpbPFIkC8KoGpPXJMYitAE3j/BIM+sN4TtYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hS28qjgGnrLKcn4gfQpCUIrDStLT+icIi+lu9bK+sDYIRPPJ4w1P8kZNsFh8DmwuKRdERI+4yIHqSO5V1R5lUfUcshXQ6nsopY50r75xkW37i5WzktYTFFxzHlvkeLuoxSlbo2Qvb5gHnmOWBNfkf0U+/7cn1Px1Ex+XNEHzi2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrASQJTl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8b557f91so6407265ad.2;
        Thu, 10 Oct 2024 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582267; x=1729187067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s56vDE78zK+wxwYWrHfFQSLnS4P6asCSaBR3cJf52Jc=;
        b=lrASQJTlDB+XvaEU3B/tF4o8LIpH2AZA+AEdNKPwz7OyRfJvBcLH/7osC8Aot7aLMR
         gqxymMUwaOIRv9b/DAbn+nf3GY//MVlb5WIipWYdFYm9cIaNlvBxj/T/6NnC4czp9UlX
         daO6FsXOB3O4/8ipk59ADvT30MnLoWhGWFuJVGyA7N+ga5D3VRs0vhacvtocuYNU+GNm
         Cr94bkQYs94aZSWZ4jskjMqhYe7fBvEeQ21+kKsZzl4/h3BHdaiwDPD3vE0QEww7rbKQ
         ZS+0JUQ1VYUFSzAyweYG0/suNfv4L0XUtRK1IbpV+PfqaJ7/P2PjrilaisX71q5YCaMe
         PUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582267; x=1729187067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s56vDE78zK+wxwYWrHfFQSLnS4P6asCSaBR3cJf52Jc=;
        b=mdYejDbfRrzvRA4Jx2p5sU7JCgAhIVPBxQ6/HK/LgU5rOEt2vnW7b3gYmdZ8oLL+aM
         SR5AhgladgNWqF2PDvcoeUqtGlcZQI9Nr/d3BxPv1q4dNMDqQ9I/7vTlAmXypzVkZhJE
         7jbC+fEtsv+6K9bMFKC5WToJznyxe4p8PzvFlpHpUs/Qpf4VNXDBuANcZk6RV5GwjACT
         H//z9NVC4xLSwX3OOhCQ4PMx/CDFZEoH8TavEIkZ/4TLvtfAgu8MtZVzYj3R0W4xh5oN
         8sLaT568KC/OFfaeQ7I9mJGUzUEMO/My+Ki8BqrOwGgAdmacINxZay+vBH8wsI4aDrkW
         iacg==
X-Forwarded-Encrypted: i=1; AJvYcCVnY/jTQ7PiVvnB87IGrdQopsGgpUY944MKm0E4deheZTjf3lIb69IducQnjVjYD3FBFTpRzaPJB4cy7xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9VjTX2dHVqNocivfK307GdrEbyPlZ9t9onPiwHp/WCDC9ff2j
	v5ZHqB72+CV3PutBzXJ/hV2NhSYYnQHU5FaxlY9H6OunDs/C8TbDnIBWoQuc
X-Google-Smtp-Source: AGHT+IHk/V4lE7Tw3jsSbaQCbZwdX6GqmMVQIg+6nHsmmjadxSApuDhZPnWU0MzayAtJSZbrX5ajdw==
X-Received: by 2002:a17:903:2309:b0:20c:9936:f0ab with SMTP id d9443c01a7336-20c99371035mr17961085ad.47.1728582266712;
        Thu, 10 Oct 2024 10:44:26 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb470sm11826495ad.126.2024.10.10.10.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:44:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv5 net-next 0/7] ibm: emac: more cleanups
Date: Thu, 10 Oct 2024 10:44:17 -0700
Message-ID: <20241010174424.7310-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: fixed build errors. Also added extra commits to clean the driver up
further.
v3: Added tested message. Removed bad alloc_netdev_dummy commit.
v4: removed modules changes from patchset. Added fix for if MAC not
found.
v5: added of_find_matching_node commit.

Rosen Penev (7):
  net: ibm: emac: use netif_receive_skb_list
  net: ibm: emac: remove custom init/exit functions
  net: ibm: emac: use devm_platform_ioremap_resource
  net: ibm: emac: use platform_get_irq
  net: ibm: emac: use devm for mutex_init
  net: ibm: emac: generate random MAC if not found
  net: ibm: emac: use of_find_matching_node

 drivers/net/ethernet/ibm/emac/core.c  | 91 ++++++++-------------------
 drivers/net/ethernet/ibm/emac/mal.c   | 10 +--
 drivers/net/ethernet/ibm/emac/mal.h   |  4 --
 drivers/net/ethernet/ibm/emac/rgmii.c | 10 +--
 drivers/net/ethernet/ibm/emac/rgmii.h |  4 --
 drivers/net/ethernet/ibm/emac/tah.c   | 10 +--
 drivers/net/ethernet/ibm/emac/tah.h   |  4 --
 drivers/net/ethernet/ibm/emac/zmii.c  | 10 +--
 drivers/net/ethernet/ibm/emac/zmii.h  |  4 --
 9 files changed, 30 insertions(+), 117 deletions(-)

-- 
2.46.2


