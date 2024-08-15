Return-Path: <netdev+bounces-118824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E6E952E31
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE06282F62
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049A717C9A8;
	Thu, 15 Aug 2024 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeMuCeHl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35B2770B;
	Thu, 15 Aug 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724694; cv=none; b=PYzMPyqS806w5HgkgVzNiFGMX2C84g1JyzOc5gA1MTvMY5qtjhAEEjqgxFa0camiEZcxnTneCfnIX7Okl5ZLdqDAVHOqOrTf889V5nXc2eXdexcKDoLOQz+3PNOaacWu1L3NSrsMhlsxlin37OMJbGYe0ZMt4U2DMx8wMEHlsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724694; c=relaxed/simple;
	bh=+8XLyx5gD7zmeN0Xi7DKcQU4YaXWAtMWwR1bYjpV5BU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XewEEcTIok8kZC8dlE6LCXEQJ9vOB8U75pY8n81ymqlUaHVzUt3ebO+ABCgSwdGLcqzLs7mXhqG7+WhRACfSg9mtY3G7DpXZ9CRNnVAn5XrYADRJMNcrK0nXLdYB1xSneFfI/28weTiXCVddCLsshvmXxym5SgNQsM8KYgSJLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeMuCeHl; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3dab336717fso523662b6e.0;
        Thu, 15 Aug 2024 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723724692; x=1724329492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QxS9QDTFLbA2CX3R1ChvoqHgn0+hEmCdq7e6c92S6PQ=;
        b=DeMuCeHlATpofc4YW1mEcapqTzvjJUmvdnVUUgeNh83oC9NhiOgU640zPfxyyLAJw4
         WtrfY/81v4ynCDihgvMqhR+or4kzenn5qrPxa11FTqhOC5E5MQomk893lz/+XcT37JA+
         HAX34DqYsVNUh3Z/qPsuo/89ugPyZNiO8dXJ9UR+vUTvHIQzbY3zSTPt+Fi2PEMq3lSX
         9qLd+9tXllSIe5SpwiGL/n0nmreo4ifijCqHV62cJx1ZBwdV4kF6yisLJxdauvvKIW/U
         FppBLrlFPsB/8YoWRGnAxDuTQqkeyBY3YQW003s00MoB3PGXanB8glbgMXYqRLEj4msz
         dngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723724692; x=1724329492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxS9QDTFLbA2CX3R1ChvoqHgn0+hEmCdq7e6c92S6PQ=;
        b=CYiBRqu5646/wrrQeWME5Gf3Agh9yY4hnaQiGlfD9neTE+WOp7FbkbXpSWbpk1frLF
         VwnF+H/otCMQfMuhdHiOqv0Ny+a4fI6Vj8tXXpNwEZOBdtu2QlZaFzR5HsjsYeB1DnFb
         3I25hBV4WEHJI+FyFij9dRajm520SfO1vwAN80G4EVb5dH+/TG/nWRsn8liVRTaZEDL0
         D8c/irOXigr4nYpztltt93vzVMBVVJpx7zpKk6/44LRVL+xwA8rg46ez/1By0D8nA6Di
         CfYb61FbwyxSfswO6lYWZvhNTqbtLcxC0n3YSFSjJJS71P1BiUqRnEMKzVKGLoP3I63L
         wu1g==
X-Forwarded-Encrypted: i=1; AJvYcCV+e7s8JQK7W/zVwbZtCokkFdulaQKtmbat1t4ty9IdQ6SvsW961EDjYliI3lKiaq3ZIbaE6sQwKX2qmCLUeIox6H4N2SpXKsl/q/5JYM/O2nSoOhaM9KD8j81LAYSC94unnLBP
X-Gm-Message-State: AOJu0YxmfTkRzrIS/++kAbroq9thYCInhbikw4k43iiDCx0R4NQkHoyF
	VEvidd+77wAmwzw3oJbMnO2OSatNIC/c29VQBiQ7vP/vnt871GGf
X-Google-Smtp-Source: AGHT+IHIrTaJEIUiOcUHjqKGw6Ka09v76TLRn7Sp/z9fRuaNGgGF03pll2eFfDuHHArafP39b1s+FA==
X-Received: by 2002:a05:6808:1892:b0:3d9:41d1:acd2 with SMTP id 5614622812f47-3dd2991b8e9mr7225116b6e.27.1723724691653;
        Thu, 15 Aug 2024 05:24:51 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b63585d6sm1031724a12.70.2024.08.15.05.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:24:51 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: pshelar@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	amorenoz@redhat.com,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH net-next] net: ovs: fix ovs_drop_reasons error
Date: Thu, 15 Aug 2024 20:22:45 +0800
Message-Id: <20240815122245.975440-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm sure if I understand it correctly, but it seems that there is
something wrong with ovs_drop_reasons.

ovs_drop_reasons[0] is "OVS_DROP_LAST_ACTION", but
OVS_DROP_LAST_ACTION == __OVS_DROP_REASON + 1, which means that
ovs_drop_reasons[1] should be "OVS_DROP_LAST_ACTION".

Fix this by initializing ovs_drop_reasons with index.

Fixes: 9d802da40b7c ("net: openvswitch: add last-action drop reason")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/openvswitch/datapath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 99d72543abd3..249210958f0b 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2706,7 +2706,7 @@ static struct pernet_operations ovs_net_ops = {
 };
 
 static const char * const ovs_drop_reasons[] = {
-#define S(x)	(#x),
+#define S(x)	[(x) & ~SKB_DROP_REASON_SUBSYS_MASK] = (#x),
 	OVS_DROP_REASONS(S)
 #undef S
 };
-- 
2.39.2


