Return-Path: <netdev+bounces-155020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 368AEA00B0A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527201882667
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA951FA251;
	Fri,  3 Jan 2025 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3kefjgv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6AD1FA156;
	Fri,  3 Jan 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916652; cv=none; b=KcsYWgxu6BKpr4Tv6Z4+CsvRqoQVdQ1Vt7/0PgMeZBMyt8qeq2SbR3cRHtiZyjsir12reB5oyuLY7F2c/bFUdwikSFgOYyq1CyPy8DzfFzHcKQ57JpERgyKpYtAExmuvfMcoMA60T2Bbf70U85bJpe1uNkz+f9sUQscvXXwe+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916652; c=relaxed/simple;
	bh=uSa9PUwB4OW8OGNrdSS1mmwamYRUILjAefzKeR/wxAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0AayH1UBtsvFUeHrBrK2Kjvi9ViiUMWa2AQMlWB8e2oXF67xkrcULpedlp5WZz1402AZsc80gn0rEu4JdFVO3vpj8kr6Z3X0NDPDl7XQfh2A6g0NiKIT1sICPvTGS9AYRlsRpi7G6v5PbbRWdzZ6KiYtaB/BSt47Aeud1CXnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3kefjgv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163bd70069so73181695ad.0;
        Fri, 03 Jan 2025 07:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735916646; x=1736521446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0z9IG6tvWKQ6IFAPmi4m2CrBnhRTm5oc5hWuduto3yY=;
        b=G3kefjgvV2hkmZ7A9Qqwr/sGKpncwvuXEbNI+5JXeOoTa4yjR5UPwg81wEDCxVHFtD
         /4pf04lyy0xUBqBTfFPjlS/J2xti3zkyXIzCq1J4jX2W4lZnL2Ke+pPtAOGGkKpatTH9
         OKQ30zuIZGBeLMZQboiFRXY0Opb18KnGO015eKBu6Ix/jqqq9Sc/JxmpdJso91cA3hY/
         z9p0giafk9+Lox6MPzVv64YgcnEbVsVL/ubIPnMQvWjTdZ+HZ8Kaydo3bVgMp3LOj1XS
         pU0mECNcfDlxRIbuiJiumyrFV7PbIq7i6mCLAJht1F2d5SLksxp7CTRYcZKqYOr/2FTS
         y6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916646; x=1736521446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0z9IG6tvWKQ6IFAPmi4m2CrBnhRTm5oc5hWuduto3yY=;
        b=FzzotpZniy+Mvj8L7ZnanDXJBaMEaDoCnim8vBnutp6y0iCoUigQ2mmgHEFHeaT+2R
         X3r7pwf5c2IQpPI4xyihaAtZ3ImsnEvogL5rXfcnN5PX+wSsKo5v5sVNP30bVsP5Pn7I
         0YLC+Kk0cjz62durU3z4MuOKAzR0MAzqSkEmNpwyfO+GbAsRwFK3cQGpkNCuvulCwR2D
         nFQXTXl30N33Iica58PquLElJAIYY0ly48CrcrO7uaXGqWHE8IKn4HWiJxlYUo2dP47u
         ESV+Pk3ExfJW3817roNtkNvjaclSOZJjZ9BVajQthVpVdjW7940VOeMssYbC1QANWV58
         TEUA==
X-Forwarded-Encrypted: i=1; AJvYcCUj8CuhrdbX51skEchAQdPaxBWH7/3FHRpJbyacK2Ym+CGFxQS2SMZ2SEWN8Gfq4C3giUjgwfd+@vger.kernel.org, AJvYcCXOTCYPY5Rh3YezxQ49R8L+/P0pQZfmncCCRs4qzZDcSj6v5oGoKimXYBki9byl7GM5+dNR7hNonKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBADNabLph7Ik/ng8JAlWTInYllGEH+dSfMDUO9NUQJso+sy0t
	2unh26P1LEH68xBpmUo6R2j8Q3+bYL+Sru2At7UCR2i7XBbX/WAa
X-Gm-Gg: ASbGncvqcTfTh6uKE5Hmm+bermHFR8KZ1gdjn+uhPKxg8HFCbW/vfidiqtAdSPs09wh
	x/7sM5Da3bxsmwWgqR3DhgC2lWWAAbKCXqtwRrd8IbATUD1AI+LsN1+P+nfU2mG+folQvd9/1u/
	FXSiKG5MP1Ua2TW68O2aLvMspiI7y5n1SQPaXVWLIKozj1g48J02yUQxn9yBhStsZpwfiNyUYmQ
	gpbJu9JzsDUkkdQWOjwGIcwf3EvurjC0J0xPlC2nnf2pA==
X-Google-Smtp-Source: AGHT+IGxhaLOaNDfKIC59zsQREZQfid08smgwim1yFU+kJqcyAYumjlfHWZpjElIc33CvoSNRg5epA==
X-Received: by 2002:a17:902:d54a:b0:215:773a:c168 with SMTP id d9443c01a7336-219e6e894d3mr867393265ad.1.1735916645950;
        Fri, 03 Jan 2025 07:04:05 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629d0sm247047255ad.41.2025.01.03.07.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:04:05 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v7 03/10] net: devmem: add ring parameter filtering
Date: Fri,  3 Jan 2025 15:03:18 +0000
Message-Id: <20250103150325.926031-4-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103150325.926031-1-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If driver doesn't support ring parameter or tcp-data-split configuration
is not sufficient, the devmem should not be set up.
Before setup the devmem, tcp-data-split should be ON and hds-thresh
value should be 0.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v7:
 - Use dev->ethtool->hds members instead of calling ->get_ring_param().

v6:
 - No changes.

v5:
 - Add Review tag from Mina.

v4:
 - Check condition before __netif_get_rx_queue().
 - Separate condition check.
 - Add Test tag from Stanislav.

v3:
 - Patch added.

 net/core/devmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 0b6ed7525b22..c971b8aceac8 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/dma-buf.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/genalloc.h>
 #include <linux/mm.h>
 #include <linux/netdevice.h>
@@ -140,6 +141,16 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 		return -ERANGE;
 	}
 
+	if (dev->ethtool->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
+		return -EINVAL;
+	}
+
+	if (dev->ethtool->hds_thresh) {
+		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
+		return -EINVAL;
+	}
+
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	if (rxq->mp_params.mp_priv) {
 		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
-- 
2.34.1


