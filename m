Return-Path: <netdev+bounces-109065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDFA926BF6
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74351F22B9F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F721194AC5;
	Wed,  3 Jul 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Osm/d23j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE15194AE4
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047031; cv=none; b=WwJ5pAM8JaN+nSvXEEnUE/woK1fhZhI2gMQcsenViHOKB/iCMkVhRTjzQqRFkOxUF8bsK77DpACS2bdFgSSbCsdgV+jGkY7uQ/r1pZ/JNTh+sC+6TzYB58GGM28YTk+nw4dbBcuaInG4IMEsu3xY6mHVZP8UlCOW2JJoN45VoRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047031; c=relaxed/simple;
	bh=I01JCujZD1QdPv8eAGWz+U8ixUImkinN7MOWEG4qw1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GgI3a8y+dQS61rPH8PkFdL8cgSkxRHMJGQ+VM3wXYICr+NGI7wXk+zwXdE/gEP8iXmZVjle85a6sEvgzF3mTHGMGLVZR2b1nChN23YcUvSJ6bhQamg8ggJdDYIszSXQb6h7rgWj6luAplMyVdOYr16dgDKeYeBJ6ZUsbcEHDdAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Osm/d23j; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70af5c40f8aso55701b3a.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720047029; x=1720651829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTJo2+TT7Z/E9Sx4mrv8YBG7pTNZiSk0WbKEcv0vnsI=;
        b=Osm/d23j2ADi/HYVO/+zNd2vk3ryU48fpmBcgsy4MKEqdp5RVwkw+bR2XYoFj5e+jF
         eVUpDZTabP4TwhbXbgvYRpnfIuDi6XbLiQCCtyhWF5vYWv9sGuLtW9tA7lInfFKnWfVM
         XZve40pPzL3hvCa1luWw3bNwJKzewoCxW1plXp6aul9EKbkEKaAzLZsFxjV+8duPk3D/
         /zbcHpIhBIRrnvTKA/FCV1ZxrokSLqRYIYzJ3c73DIlVvf1GuQQ9QxSIsiykozdXFfsp
         BGETFJLuahejHFH6HNHd/BIKRFB34kvpZZiwwTNBFtNmOvun/2NYs71aaUTC+r17M3FJ
         NlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047029; x=1720651829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTJo2+TT7Z/E9Sx4mrv8YBG7pTNZiSk0WbKEcv0vnsI=;
        b=dXXo80HySoDUPCbPAsaVFsRAmojPKcHMYgv7VblcLUMOVXFu97muuVZeo9wjvWSvmG
         VtFiRy94IsJDxK1MH0nBr8Yh1PUX7+053Y1Gy1X7RIfEv+Lhuf65d9/tBvQCW2ybnZy6
         CAwcsYRfj3g5e3wf+ifbyLKsruaejZPE0Cd9VTaFlVMZky2B6+4ATKGE3eTw2ZJiughH
         Q1bRUuW+dOuWMylwgQuCl7o3GP9ipjdp2SjK0j8M1hvTOVvF2w2VKxLK6lxnxdKnflk2
         B4lq4Al2RIi8l4FlAU4H3FhYmoLRQavy4SKGOxhPc/q7gUDNThIotgiD87exWejmwR7w
         AQDg==
X-Forwarded-Encrypted: i=1; AJvYcCUrIapSxcyND9m1qoeStfwLHbAnbdOxPsNIKouHKPN/F+VJ0Awp5OkTFAQQ9XsEStS9FjUUGNIbaYVmQ4T48EjmyVZrJGGs
X-Gm-Message-State: AOJu0YykaNUE4aobJcZyhzZ9YY0m9v2qlx2Ll8YV39XK0z7giLlBuy4F
	fvC8U7GMuB4RX4PaRXzZfETGtwgSgklQ0MYp7YOQbSbYN+saH63XEj+VzPis8g==
X-Google-Smtp-Source: AGHT+IEpoxIlMPMkciQWHoIgF80I2G2SKnASFU6Q4wZeIQNRPbU26UlEjqw8rPc6IXvxIHYhOrU8AQ==
X-Received: by 2002:a05:6a20:9143:b0:1bd:2358:8c94 with SMTP id adf61e73a8af0-1bef613f4a7mr12661149637.20.1720047029034;
        Wed, 03 Jul 2024 15:50:29 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:af8e:aa48:5140:2b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf75b3407sm40242185ad.85.2024.07.03.15.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:50:28 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [RFC net-next 08/10] idpf: Call skb_set_csum_crc32_unnecessary
Date: Wed,  3 Jul 2024 15:48:48 -0700
Message-Id: <20240703224850.1226697-9-tom@herbertland.com>
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
skb_set_csum_crc32_unnecessary instead of setting
CHECKSUM_UNNECESSARY

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 4 +++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 27b93592c4ba..0ba7abd87d05 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -698,9 +698,11 @@ static void idpf_rx_singleq_csum(struct idpf_queue *rxq, struct sk_buff *skb,
 	case IDPF_RX_PTYPE_INNER_PROT_ICMP:
 	case IDPF_RX_PTYPE_INNER_PROT_TCP:
 	case IDPF_RX_PTYPE_INNER_PROT_UDP:
-	case IDPF_RX_PTYPE_INNER_PROT_SCTP:
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		return;
+	case IDPF_RX_PTYPE_INNER_PROT_SCTP:
+		skb_set_csum_crc32_unnecessary(skb);
+		return;
 	default:
 		return;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index b023704bbbda..3ff1d181534c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2804,7 +2804,7 @@ static void idpf_rx_csum(struct idpf_queue *rxq, struct sk_buff *skb,
 		}
 		break;
 	case IDPF_RX_PTYPE_INNER_PROT_SCTP:
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb_set_csum_crc32_unnecessary(skb);
 		break;
 	default:
 		break;
-- 
2.34.1


