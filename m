Return-Path: <netdev+bounces-109063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C16A5926BF3
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767EB1F22BD5
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62025194AC7;
	Wed,  3 Jul 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="HKP11kKp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01799194A70
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047028; cv=none; b=HLuypKInxznJIc071zt2W+z7D1hsyXMlClNaMv9cocg8uqxzIpBvVyz5B283eWgjy2cALqiWcS96kBxvAjC0v4yOEzSU0eNQpc86Tmv14vQXCXLhFVRA63pYaEQs2biUdHiQXqptT2Yyssen7291flNmM6qI8EuU5Mumyp6fpNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047028; c=relaxed/simple;
	bh=ODC+NLHO9+y5HvYJTWpPj/RQZYWNemYz2CDOr4dRepg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8PH+1begir8r9SAecJLzS12UdLX/F5ijKCUY0S9IbQOPC0x/njsRC7en5DyZ77yYcHm5RBNx7CPwHwO2KeHhLzy3uv25n6ks4XEWMvGJzkOcVTKUyW5RBB8F+bn0i8jOqmRwjPK3gGSUE3jT7jf71aXtddgrlRHSKowg0/h8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=HKP11kKp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb1c918860so7201665ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720047026; x=1720651826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG3PkBYfDw9CXlmfyI3No1z8oDJJz2o+0E4ZNJ+xuns=;
        b=HKP11kKpYi3YlYvMvuNg2IkdLa0+AtdPrA5oa7ZzP05yctTmqXxFtDZKT1IMRmh73w
         3+ui10GKNunGfzfPNTk59Ukr0DM1VqDqT2hEKTTLVe5YoMOH5THAPYFWTHn8kLJzZ5qI
         +z5gWeDXQ6TFm75Us/5nccaAPIkfy0/dO0sFzJqNOIOE7jhkOB61yym0apl0G/mnvsk8
         pdpMb4VHmkDLa7MvG5d1aa4vZud+magO6HMRTKTxsfa0UWnFCkU0exo+eg0AhXzCZjKE
         tT6TtJU9eJ1zQw6GRlOhgg60JmLVxUYNPuCqjm4ukZjzvr0Iwb7RyRchfE9ubFpzSsiG
         qInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047026; x=1720651826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG3PkBYfDw9CXlmfyI3No1z8oDJJz2o+0E4ZNJ+xuns=;
        b=fTKd76OLke4CPF+L4zXXuO6rACZgJ9RLc9IVAfrmb71pbOXWIfGKgJDgleGSNLv2ID
         m6JU0qSc6PhO0U620trD+iFtqC59F6xx/n0R7i80gh40TuljztbxDaGnHA5fJJfF2m7h
         0B2YqbcMRCog784tIAe7p45xK8NPtyHW57gE7nIngXc5dQVncNcthCj1EnOMsZt/7KeE
         kktpEzIuUXZXfvDgty1bioCEEkq872LnKKu/WwL5iQYWDksRDmCJFV0Pb8tuhWsnGehw
         ZlKECNQGT9V0daEPuamngljlKDPH9RE4MaQ2adEI00QflSSnvdan6XjqiTIuEA2cePnP
         m96Q==
X-Forwarded-Encrypted: i=1; AJvYcCXR9+wlgNzK5iotujB76Q8fmnlQLD86M7bD4yb0GX+HxMELwcqvQz8/jCgGlUdMOuXrFnPb49sP0bVPEVSOL7d1aoY7ApLE
X-Gm-Message-State: AOJu0Yz3pNyT9Kr6pO3XPICIGSYPLRCaO2wXchv8Clp9tO2DAhAcaBdk
	Dco747ON9CSnE1JQAIffMpNIuVzSNg/gjoJO4GTloU/vG9cuSJR7EjDgy7c6jL1hcTD7Ju3w02c
	Urg==
X-Google-Smtp-Source: AGHT+IHzSW7pMQq+b0QPnBGlwWl5gKhlOIoqlcec1vBprsh7VjFfAfQm2aHuLNZTwULfQ66+Rl6z5g==
X-Received: by 2002:a17:903:2350:b0:1fb:3c1:cb1c with SMTP id d9443c01a7336-1fb1a040251mr47730175ad.10.1720047026395;
        Wed, 03 Jul 2024 15:50:26 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:af8e:aa48:5140:2b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf75b3407sm40242185ad.85.2024.07.03.15.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:50:26 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [RFC net-next 06/10] gve: Call skb_set_csum_crc32_unnecessary
Date: Wed,  3 Jul 2024 15:48:46 -0700
Message-Id: <20240703224850.1226697-7-tom@herbertland.com>
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

When a validated offload CRC for SCTP is detected call
skb_set_csum_crc32_unnessary instead of setting
CHECKSUM_UNNECESSARY

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 1154c1d8f66f..d3d6d7c6f253 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -625,9 +625,11 @@ static void gve_rx_skb_csum(struct sk_buff *skb,
 	case GVE_L4_TYPE_TCP:
 	case GVE_L4_TYPE_UDP:
 	case GVE_L4_TYPE_ICMP:
-	case GVE_L4_TYPE_SCTP:
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		break;
+	case GVE_L4_TYPE_SCTP:
+		skb_set_csum_crc32_unnecessary(skb);
+		break;
 	default:
 		break;
 	}
-- 
2.34.1


