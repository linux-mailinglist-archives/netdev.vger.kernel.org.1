Return-Path: <netdev+bounces-125539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D796D9E5
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232AA1F230C1
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242F819C561;
	Thu,  5 Sep 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIlJGI4I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F61CFBC;
	Thu,  5 Sep 2024 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541971; cv=none; b=cTn8HVq8ykQMFYkTq2B56FJZOVLclZqGzQr4LKHW/zerrCmdk7rQH7ZUJFEOgwi91d3TSdVzGsue34XaWNkohVFfCMGQQ4vOVgRi61pMLRqWn4Cne4XgabRLFdqDIOfO6eCDah/sLUFaP0+2UoeLQkPqv63mMbHtOd0VYT1v7vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541971; c=relaxed/simple;
	bh=I02uF2EzqpWyIfum1tsxP20QjcYiXAczbcVcgpUb0jE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W917tintCbKyDkfWvDARrnQ0dUT+HINVcXTG/Glin4yWNFoydLx01gBeoSRuW/fSDmLeHZVYzeAkR5gTST4huFHB88lQ1FeD4xl8D55nPJAixtHnJloBOMBKM3NdKnog8Vim9upfSjKUQXyKCdurMEZxhBMihnG1lb9l9mk3888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIlJGI4I; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7179802b91fso120977b3a.3;
        Thu, 05 Sep 2024 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725541969; x=1726146769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mf1hn6rFJNXfTXIyUkUoh/2ZaZwDqRlw4GMc6mm/SWo=;
        b=lIlJGI4IwdxdqZnVmqbZeKVCpeK+CP9EW4BiG8xA64V2jcK176wXSzjuhic/4tX0jE
         D6qJlEnKuPiHrJ6WQ6JItxAJoBrUPG0C6CEyW50Enqh9ZQVj1Vk9lv6/pCA4MAQriiZ4
         t2N66pc08eC4mnLOkQEq+ySCJqGzOviqUfwgZ1/owPdG0gBOaVTwgcYdr/X9saNCq8B3
         j9cFHjwgYsAvADDQtxGUfHwPI1L12SrHMAf6EDnev60Mt8mC5MVbquDk3CZYQhzPzkQS
         kj9DbO+hkdAslVjedMq5Nigo6IFfbcjuSxCDQ+CbMA+kV0RF+TyY89x1hEN0neKJ8suI
         Ugwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725541969; x=1726146769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mf1hn6rFJNXfTXIyUkUoh/2ZaZwDqRlw4GMc6mm/SWo=;
        b=FoTL+Lsb8R6G5GfLPnuex4LkrpZ0WqBPpcXbt1iiBcYsdoQEcNSbTsrnERP0aEJ7Vp
         OfLD17d9rUHnm4xi+QBq53Vf5ysu1dmaPBZ2pFVb3iiJmSI3GuzzDFm9z2jFgkws9cjR
         ES1Plenz85sZtLUS2+56RzPxG/gDor/n3S7YUaiCuZj4SBDQm6kH2tPmGt7m/bct4wyH
         KZnrRC5ZeJEC6P/FSJio/I/zGO0AEwXKsNnwUyz7uw7cMHeLSAu7PkoD8S9lK6/8GPUB
         mEmufS3rKSiknTtHjn6KSGCZpF8GKN2httuS0KmYTpNanmoQqyRnk5JRTS/z3LnvDnpT
         Sl5w==
X-Forwarded-Encrypted: i=1; AJvYcCUZgKUYqJnHWLkE2reBcuKX/21LlR/55wgKB+cTIoPfwrf2P6Qq74wrXplhhn3hklV2eoxIy4PR@vger.kernel.org, AJvYcCVvvNVwUr+2cvyy+TISpnVwneZ1ToT/G4gNHZhaojFs86pFVGWXD1hSv6nsgM7AVzJrC9I3dGDNriWx/M4=@vger.kernel.org, AJvYcCXssFYsXJStu5uG0EgoIMr9uQDWimIf73fuROBSvf9XBw+fl6IIYBMAqPm4sgqE5aMW4qYvQrwJL64D@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZDMZ/MNZ+df21YsuoWkjoQaETBO/1tsFwo7BgHvzi1WBS+2f
	eOeb4NAIHwl6fNh6xGnZkXDNRRCvAsi+b9FxFyGxUaPPjAGmMnP9
X-Google-Smtp-Source: AGHT+IGI2z/Ccf1knMniW6K77uvNMqimo5zis8Ibm3akGlG52VO3uqRa+VPrVB4nVjc7WTbayCRWfg==
X-Received: by 2002:a05:6a20:c6ce:b0:1cf:12ab:320c with SMTP id adf61e73a8af0-1cf12ab346bmr2729200637.37.1725541968828;
        Thu, 05 Sep 2024 06:12:48 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbda7b5csm3313782a12.70.2024.09.05.06.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:12:48 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: ms@dev.tdt.de
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-x25@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net-next] x25: specifying bcast_addr array size using macro
Date: Thu,  5 Sep 2024 22:12:41 +0900
Message-Id: <20240905131241.327300-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is more appropriate to specify the size of the bcast_addr array using 
ETH_ALEN macro.

Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/wan/lapbether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 56326f38fe8a..15e4ca43e88b 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -41,7 +41,7 @@
 
 #include <net/x25device.h>
 
-static const u8 bcast_addr[6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
+static const u8 bcast_addr[ETH_ALEN] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 
 /* If this number is made larger, check that the temporary string buffer
  * in lapbeth_new_device is large enough to store the probe device name.
--

