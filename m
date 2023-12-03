Return-Path: <netdev+bounces-53344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBE88026EB
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 20:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B50280E46
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9014F18049;
	Sun,  3 Dec 2023 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgytcY7N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A556113;
	Sun,  3 Dec 2023 11:34:00 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cece20f006so44070457b3.3;
        Sun, 03 Dec 2023 11:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632039; x=1702236839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOA21j87mR+yiywFqhw/n2ogDgEt85D4G/d7gO/inIA=;
        b=JgytcY7N94v8jdinYmONzMtSa4aq07zgEq2N2MywhkQAtb67A7JzB67D86goKcEWMW
         9epDoR4YQTtvbPmTodJynrjJts199/nCIhuOQk0ip8ZJGejsCnj23v2+GPrNoyFNeQLO
         RmQHuRTF5E0xugwA8Cty2QcvznEqIxqNArMweIaTCirV+w0m/H0NNsHItRDrPTnVuEvE
         k/mIe8bk69cxOz5qEggKAo7ryY38Ivb1ShUkHw9jxfnEEBb5jNuVY0VapMhmGMEJsKbp
         BrpNOpJFHV545SR9rTvV1Md/vSDziEXDLO1eKoWQkpCwD4MDA5uOJBDJcRGyw675YnWb
         xGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632039; x=1702236839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOA21j87mR+yiywFqhw/n2ogDgEt85D4G/d7gO/inIA=;
        b=WO8Vu98n1OGwzgAimE/o0QuC9FmRN/9z53Cx5Fy24wetDMMGpoOeQZSNAB4ytrMLJm
         txHJ6fDhPB36Yw/ItZCvnD8/4iZ9ApoqQXAiwvqmv7v7OXcc0jPmPBq3Ag04njmvfqpJ
         UJGy61wGUJ+V5E4r/vCEye0u5PkyNADhjRsN/a9UIh/RBLc/W1EiHW18i72Gi1gi94HU
         P7gq/FRz8kVuomtpniQpbDrWOIl9SEc0+AcHlIc4CjzM7yW9PlwT8noPnic29omxLi8i
         0dOYQX3ARF0+3ikXOSEO4YAVf/6mrGxenSAz7QmuJpla6iW1jcZDTQk3GQbboYuhOLCb
         OvCA==
X-Gm-Message-State: AOJu0Yxxlv/KsbJOStqB0Io9YY/EMlJ/m6UMU2anXU/N2gZhn+ZdAE3b
	AcVhMWC8u5SW1tCsYvZaY9mSEW8husdDJA==
X-Google-Smtp-Source: AGHT+IHXy1WAEEEpXL8d3Qiwz0WaUvvRd1DJhAPAt9NZCAbQTeYlZnMbDBTKqf04Wx3t8kWOvaFN/w==
X-Received: by 2002:a0d:ebd4:0:b0:5d7:1940:f3ef with SMTP id u203-20020a0debd4000000b005d71940f3efmr2486245ywe.87.1701632038986;
        Sun, 03 Dec 2023 11:33:58 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id w20-20020a81a214000000b005d40a826831sm2113106ywg.115.2023.12.03.11.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:57 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 28/35] ethernet: rocker: optimize ofdpa_port_internal_vlan_id_get()
Date: Sun,  3 Dec 2023 11:33:00 -0800
Message-Id: <20231203193307.542794-27-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize ofdpa_port_internal_vlan_id_get() by using find_and_set_bit(),
instead of polling every bit from bitmap in a for-loop.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_ofdpa.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index 826990459fa4..449be8af7ffc 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -2249,14 +2249,11 @@ static __be16 ofdpa_port_internal_vlan_id_get(struct ofdpa_port *ofdpa_port,
 	found = entry;
 	hash_add(ofdpa->internal_vlan_tbl, &found->entry, found->ifindex);
 
-	for (i = 0; i < OFDPA_N_INTERNAL_VLANS; i++) {
-		if (test_and_set_bit(i, ofdpa->internal_vlan_bitmap))
-			continue;
+	i = find_and_set_bit(ofdpa->internal_vlan_bitmap, OFDPA_N_INTERNAL_VLANS);
+	if (i < OFDPA_N_INTERNAL_VLANS)
 		found->vlan_id = htons(OFDPA_INTERNAL_VLAN_ID_BASE + i);
-		goto found;
-	}
-
-	netdev_err(ofdpa_port->dev, "Out of internal VLAN IDs\n");
+	else
+		netdev_err(ofdpa_port->dev, "Out of internal VLAN IDs\n");
 
 found:
 	found->ref_count++;
-- 
2.40.1


