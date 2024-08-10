Return-Path: <netdev+bounces-117331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E4794D9E8
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 04:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839921C20F61
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 02:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313553C463;
	Sat, 10 Aug 2024 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P74P4bv3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B11802B;
	Sat, 10 Aug 2024 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723255642; cv=none; b=ZTVUSA1rDF07JyigbETJNseCi4VoZ+UGqVY8BSPXPeLR8EZSxyjqB7iJx3kND0/byWMt9MdBvUqynafoX3gGOd1ed8w1QldcmCO0mr5TEw8lG4loghQ1wAHqkG6ZX6owysb06EJv+vYWu40QBAwAlicMass/N7neCMbyX43W01I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723255642; c=relaxed/simple;
	bh=FszU0eWGF+7YV5v6loTRFKt9FQXPF/rqGxQmR77obo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n2OcOvDmOF69aJRWH2m+H8k0Vx+40xhYMxEGGalE04a1UdAKEQ9uBO9fbDqM7n19EP+YMCda+xUVJk+Ujoa1GLx1TTOfND9gSNb4s6Pd0y2p0W90CxWK0sPdCjfukXXFTrbY8B7uEOHM8KcYt8RoK6H5vzgSHIFYOBjrfyv1VPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P74P4bv3; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1fc491f9b55so21139885ad.3;
        Fri, 09 Aug 2024 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723255639; x=1723860439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EO3mVztBgbiVsE4xJVCsdRCCfzIJ6lRteSoBlqZb/Ms=;
        b=P74P4bv3z4M+Ht2W6cO3wLfr+JQ7ybt6gLqaPGr6bdJ8RYlV6M5S0GIQAbZutA06SW
         Gydpo3Dcw56XnmY/iGNF+XhFGhKesXNk45h4hKyyS7BtMje6ez9RTX+e7doM6qf6mDs2
         rWUthV66wgp7rgYFtDgFi/umJiwbwK1ROqbTmBFf7shW+WMXZI48yncby4lI6+ngt8o4
         gjnltyH3MFNMNPI6FGtAXiH7PQeqeUD3Q/FTLCZxC6RLs9SC+wiUiO3gsPwsZfh5UoOo
         Qoxf0UUWX/kfW4gbKfaKnz6v9J774YvH2FxeUiyUvmmACZtNkpSbCUlFXO7dNu6W14Qy
         s+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723255639; x=1723860439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EO3mVztBgbiVsE4xJVCsdRCCfzIJ6lRteSoBlqZb/Ms=;
        b=UXaSzXAFrzmdrxxFuGVvHFDwt+8kgZIjK8lxDVkf5xfn9w77JYE4+U5yIp8Xhli2My
         opnPO1c8+TN/iw7na+H3pkP7Yz7HGIPUSt78zvoFGvHKyxQORvBaYXUJ8cw12kUCoV94
         wuHLm+gOa5cVbB4f9KVKnPDf6UWuO/8pu2PYE3UjFrdLOkKLi7SFPfqP5M8aZ5/2rOzR
         EepOmZsm5S2GiR5Q/tXsH33xMN1NSKofXXJq1Yr57i+tGBaTFKso0EKmtIHtYqdkWokd
         0y1H5zZNMNetKDwvGb6TBqCN/rMHOkyf/aZ8S5A6LAbmq4KMFAiWH+CNZmzPIbgPkVKQ
         YZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCWaOrG23KNABTaA1V1WfxY2SA1jhnbZlx/+GKSlNeNqwQ+9wDqwz7Y4PacsOaV1F6F4OTNuuOiAlCXhMNaZ2llBD/S1j/vknq7vjuhz3XuxrnIZtX9ccV75MDEPc/1c589mFj3l
X-Gm-Message-State: AOJu0Ywb0z3BTNJgrkPdvwIEKDC2oaOOJFX/1jtUArODXoHnmEBAHiB3
	nBg1r/VO+M7pedAuI+ikpNgJkzfUGgGhLzJNURBQyKea9/bUTdfP
X-Google-Smtp-Source: AGHT+IE29VQRew1pZF4nx0oomtXBBNwOeMsSjUnyHugVMaDdB4CGqdPsdW5FeDg6fsq99QTJW5HQPg==
X-Received: by 2002:a17:903:230a:b0:1fd:6766:6848 with SMTP id d9443c01a7336-200ae4d9da4mr35459185ad.17.1723255638720;
        Fri, 09 Aug 2024 19:07:18 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba01c8dsm3677385ad.231.2024.08.09.19.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 19:07:18 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	dongml2@chinatelecom.cn,
	b.galvani@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: vxlan: remove duplicated initialization in vxlan_xmit
Date: Sat, 10 Aug 2024 10:06:32 +0800
Message-Id: <20240810020632.367019-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable "did_rsc" is initialized twice, which is unnecessary. Just
remove one of them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index fa3c4e08044a..0ddb2eca744d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2710,11 +2710,11 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *rdst, *fdst = NULL;
 	const struct ip_tunnel_info *info;
-	bool did_rsc = false;
 	struct vxlan_fdb *f;
 	struct ethhdr *eth;
 	__be32 vni = 0;
 	u32 nhid = 0;
+	bool did_rsc;
 
 	info = skb_tunnel_info(skb);
 
-- 
2.39.2


