Return-Path: <netdev+bounces-137076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63A9A4464
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840511F22EEA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EAE20403A;
	Fri, 18 Oct 2024 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="b34yZSvV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C82204018
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271650; cv=none; b=TyfDjwRvs1zoLXhHpWTtriiRPBwI1cp/BENJOBAX7e92efdSLTVTbkpjvZQef8AvT3U5UCQsU3tmtvS9m+joNBXXo6faLtEyUYnkCua80E8yLx6PzCGAPUycKmIMLvaE2mPf5KTl9WVhi2s6BIrKNkxyxLEQE350UroxJIZ2Du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271650; c=relaxed/simple;
	bh=HnbtrZqvtBMyHY07krjAHil61HhO1mPhEJz+kHwxeiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FD9IGtDwbYV8dvHDFEv2l4tdZ2Pe0Z7c/vontpQMdlhQ7jJN53S9UoLR8zUOG3A6ego/CinUYJCwFkpSDPA9ezMesMC4S+sP4v9V+lgN6fQXnG7llBrKi1F6cpJJRm07LKQTrmcXrOUDPUdMryOeuLQxTIQktMiTe/LKB0CQxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=b34yZSvV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cbb1cf324so20559585ad.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729271647; x=1729876447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bB7GKiKjrs56WpSf5KFX3Q1SGNDmUOvqqDaUgWFtQs=;
        b=b34yZSvVnkNQ9ABsMgxhjUlJYw23dS+aL9l9l5Y/qzaPU9HaH1759f1AGN/AwixGms
         aogeQCMLf/1Bky+pdMGM60mKmysXTIopGxtux4xKxj3c0LC2F84o4GG4Zy3HcnpihywC
         QEQDGW8uVxg68w7T5j5/hkXtTNYwxGB+u2O4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271647; x=1729876447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bB7GKiKjrs56WpSf5KFX3Q1SGNDmUOvqqDaUgWFtQs=;
        b=fRs8GgT5+OQxc0NgNLs1FvDWOmbuBISIcKFSOjNifuC4NGOlQdQwEyWUYBa92kbnnF
         MQsCLw1FDFtDQmrY6zsQYb23My2VXdMPOv6HZQ9QjPL3Jxav8+FUG96SouhVHr18fFdF
         ctQbzIdAoCUUXYZ6goSkVPQdh5mBjjrW+/kEvr8+Bn+dkNOSei98uvcfwvCc9Hb/KtGt
         dKZgcUNqBUJT598WVKZo9HFqmkBrIajOjym9HGvb3J+kCnv8X3Z9bVIBmNErKosf5w8v
         f5WAj/+gNjGuSw5zDsKS22xgD57395+Fcf9DDH7AsUOj0xP31/yODzZ+RvKpoECHmDOK
         m/Ow==
X-Gm-Message-State: AOJu0YxSeYfyLuZg1YsqbvQ86+1A+DFoqroQ64N0acPjyREgfGB2KabM
	S7PgnFswGTick0mukx60HFR+sEQaUPSeYzPTgN0sxl6BvdOU+ppVnwzcA4kkM4+2oT72WF5QOOn
	xKFE5k+pwizJq8ugNhS8jF1pto6tvNkgYudoIw/Zi0iisUnSyF/Mto2iLPEyRvWyd3+mZIW96it
	PvVvn6dcdolekYExKJKR2twGev7QehjpnDmV4=
X-Google-Smtp-Source: AGHT+IFCWKoisVtc7X03EHzO+83itiW9WT1uyE+v7mtQuTkGZD4rTpCGFn7kmp6n/+EACxPFBSN+Og==
X-Received: by 2002:a17:903:234b:b0:20c:fa0b:5297 with SMTP id d9443c01a7336-20e5a78e147mr39948375ad.26.1729271646935;
        Fri, 18 Oct 2024 10:14:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a71ecd2sm15000255ad.29.2024.10.18.10.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:14:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v3 1/2] igc: Link IRQs to NAPI instances
Date: Fri, 18 Oct 2024 17:13:42 +0000
Message-Id: <20241018171343.314835-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018171343.314835-1-jdamato@fastly.com>
References: <20241018171343.314835-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link IRQs to NAPI instances via netdev-genl API so that users can query
this information with netlink.

Compare the output of /proc/interrupts (noting that IRQ 144 is the
"other" IRQ which does not appear to have a NAPI instance):

$ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
 128
 129
 130
 131
 132

The output from netlink shows the mapping of NAPI IDs to IRQs (again
noting that 144 is absent as it is the "other" IRQ):

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'

[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8196,
  'ifindex': 2,
  'irq': 132},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8195,
  'ifindex': 2,
  'irq': 131},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8194,
  'ifindex': 2,
  'irq': 130},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8193,
  'ifindex': 2,
  'irq': 129}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Line wrap at 80 characters

 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6e70bca15db1..7964bbedb16c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5576,6 +5576,9 @@ static int igc_request_msix(struct igc_adapter *adapter)
 				  q_vector);
 		if (err)
 			goto err_free;
+
+		netif_napi_set_irq(&q_vector->napi,
+				   adapter->msix_entries[vector].vector);
 	}
 
 	igc_configure_msix(adapter);
-- 
2.25.1


