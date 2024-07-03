Return-Path: <netdev+bounces-109066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D23926BF7
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557451C21BD1
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7F219413B;
	Wed,  3 Jul 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="VXZxA4NJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39297194C71
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047033; cv=none; b=TqufPLBPQoMQPXf3fNjWhWLOThsuETPfvpwYhif1g81gvmDLVkDv1L0nfht31zV4lAzKbd7HKxZRVU7mNP9LATFnFt9oTuOw7EviuNPzGNOO69u6KWkYc8Sp2Qgob8aQ1hvYzBS3FLbe9Zm2ndz4elcrbgsCb5UydZ+EsIA9Dws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047033; c=relaxed/simple;
	bh=HdhNc6puV5LHlIu/FJNDxQMKEPvfSVr2WnOn18/pX5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uDhIBZhkqsCKJXK6Z4YwiqbHAQ+tbaRz6wT9cysZcYdpt2k5yUzKfU5IZ2oBvZbRXVZzV1fN222B74O0o1s0Xj5b+JUREiMF4kJojeFvN52spNp1lebXCrQ62WLGLDqJ1ekudGXxEi7I4OF5aWNacJMyfM2ZWvBrQWFEUgAgVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=VXZxA4NJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f480624d0dso44473535ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720047030; x=1720651830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+yNCweG/Yf8+MG+MGoYnYSGFgT1VkrzUbhAYTabS04=;
        b=VXZxA4NJAf2qGgVqHrBApLOEYAaumoH790I8kk8an/2Jcpn6EDOhlqfr1qlDB2EU2u
         7zA+cA7jpNe3mm1h/+eJtCCTwtGz5U7FO3oYnVsGnQA9uknObcS0Bh9EJm2e/z0oPLGU
         yhe8+63ZHfrqu/+ToeekIuhAvLcRMU0k2u8tiJvDQrsvjv4NPku41DSpvrpcB8roHXn6
         VxS+IOngoHHfzDIGrPaJdCCkHlApsQ4gKQ6b209GCVWsabnzrxYmzx2dtueBXSU+P1Uu
         vLjaiLW2ELwNiE6DedM4oVgXsJLoaUFr+JdSUxApyK54w+yscaeDr4PO2QgFBfWG8BTg
         Nw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047030; x=1720651830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+yNCweG/Yf8+MG+MGoYnYSGFgT1VkrzUbhAYTabS04=;
        b=rOIrZnTwIpYnRtdMOyQK9K2pBJLgyJVmPv+YMwf+NF/NuT8e6FLIEsB1wg4VLURQnd
         u5TO1nwR5fsjd8xRzjArnp02YMCGeMlwi60Fr5rY6CPTHglmtlmw1DuqI3JgZG0ZCApD
         /QEj2MxJXHple0RY6r+UF7iXCl0N4V/8cUgAHmw+u1k1KIyVBwmrzvnaTO5uxARc0cIA
         41cLAEoKPMs0yYyIU0VposZbapCYPc/l/yzsMBitOK3paJaDBzujDw+wmq8M8ZlvEpFl
         ipazM6W3/GPY11Lbm6EfCPT8HvVf32FHoxgWFOWVJwGqFVCCwd8DHPD3fyUDb5Ep9Mjp
         Jyjw==
X-Forwarded-Encrypted: i=1; AJvYcCV7T6FoTLEQw8dNr82kJkMa97F3teuDigcsUZAkc3cE7ZULuaGBhcSnjj/e7wzaAptlyV3GtP8KPqF47NpulhEVxtxgPOG+
X-Gm-Message-State: AOJu0YwVSiJXD9u6/Jm+4mvgfhEWVOrQisKNnroZ+jRYKZqQo3R0+Q9Y
	RhmXBL8cMoFFsmfz8SieLHaj7EMqiAjTtX2uIcm9/wz9zFMXcuyX/PqzHBqNIA==
X-Google-Smtp-Source: AGHT+IHlG/rKOsUbmB3AFd2YKQDvaT2A5M6VRv7uxMT/MEGoVtPuwXaInmMUIMn0qTOvIf2M8L7smw==
X-Received: by 2002:a17:902:d50f:b0:1fa:acf0:72ab with SMTP id d9443c01a7336-1fb33e1835bmr229535ad.16.1720047030528;
        Wed, 03 Jul 2024 15:50:30 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:af8e:aa48:5140:2b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf75b3407sm40242185ad.85.2024.07.03.15.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:50:30 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [RFC net-next 09/10] ixgbe: Call skb_set_csum_crc32_unnecessary
Date: Wed,  3 Jul 2024 15:48:49 -0700
Message-Id: <20240703224850.1226697-10-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703224850.1226697-1-tom@herbertland.com>
References: <20240703224850.1226697-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a validated offload CRC for FCOE is detected call
skb_set_csum_crc32_unnessary instead of setting
CHECKSUM_UNNECESSARY

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 18d63c8c2ff4..4596dd85a171 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -398,7 +398,7 @@ int ixgbe_fcoe_ddp(struct ixgbe_adapter *adapter,
 	if (fcerr == cpu_to_le32(IXGBE_FCERR_BADCRC))
 		skb->ip_summed = CHECKSUM_NONE;
 	else
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb_set_csum_crc32_unnecessary(skb);
 
 	if (eth_hdr(skb)->h_proto == htons(ETH_P_8021Q))
 		fh = (struct fc_frame_header *)(skb->data +
-- 
2.34.1


