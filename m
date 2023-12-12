Return-Path: <netdev+bounces-56185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9CC80E1DA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BB31F21CB0
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0623016438;
	Tue, 12 Dec 2023 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlclOvRa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3688E3;
	Mon, 11 Dec 2023 18:28:36 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db54ec0c7b8so4445108276.0;
        Mon, 11 Dec 2023 18:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348115; x=1702952915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOA21j87mR+yiywFqhw/n2ogDgEt85D4G/d7gO/inIA=;
        b=QlclOvRaQz6AziWYVY4AWjSy2mUfSLrWkjUBpdLcbmh4qdhHNCEMcQ1asJIklKcPsE
         tFAq0eElAeDofNVgWx5Hx2h9QLi2ViOOqlYiKUnIM2nbzTPsqkNPLYRNOfnCBRG7P06E
         6CzXNy2h5YNq3Tp74FflwevvbLakN0JyqDczCr6+fGXDx49MAKYL8ObYA761okuvsWL3
         QWJP5bmSa067TF4eGEmFCuS+G9pU8bMop7AUyyjZg9NHImAT8rYfpXeD14b+yGjiBVis
         Zct32D5ELuLI1wMXlKthdmmD5mVjcg9fCq2myi6yaEU7aRzG5xTHqmjiKzlnH2g/NoKN
         V1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348115; x=1702952915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOA21j87mR+yiywFqhw/n2ogDgEt85D4G/d7gO/inIA=;
        b=hWq9Rk6FGOugdKlDX9bKoz+4/DdnaB3/DilTD/j1SN0i/BtRiob734X2NWvgAgqkwX
         FOtSWUKSsjc2YYLmo1L903KQbtnYbyeEY0eWjvOfQu0o6ntkyCfD3yvo8DOoUoYevFtx
         BvwNxDhvOkxtORpkIqkczYeeOQqldoRb/ChyAiPW5edsbmpfD7H8RAlEUHP5tSXWCvyR
         HMBjahL79U071FGW8o7HuI3ODXtgo7grB9GzuYfa3+ohrQTQjeQ1pB2WhiaJJBv0eyWF
         oXbDegSwWyTvjX7XXYpqug7ReSDVVHWidOKioLsd0oG1jpRNt5LSIYEejlhswIIRuyqO
         H1bg==
X-Gm-Message-State: AOJu0YxMSEvIg2GxzcXqnxhNMnhC3wKcL5F1/S3qZakiJ01jghWmpq6n
	FbZgkFqsH5BbW+8JNF1buY5rmhuxf67nxA==
X-Google-Smtp-Source: AGHT+IGUqMV7iMvGJDiUE74PLSFKooWRU/X/MrocrVF8HkjFRUt5+ftRt7u+FFzqw0cO7NvouT07Xw==
X-Received: by 2002:a25:9391:0:b0:db7:d3f9:add7 with SMTP id a17-20020a259391000000b00db7d3f9add7mr3731570ybm.31.1702348114983;
        Mon, 11 Dec 2023 18:28:34 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id 205-20020a2500d6000000b00dbcafb31da2sm479007yba.31.2023.12.11.18.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:34 -0800 (PST)
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
Subject: [PATCH v3 28/35] ethernet: rocker: optimize ofdpa_port_internal_vlan_id_get()
Date: Mon, 11 Dec 2023 18:27:42 -0800
Message-Id: <20231212022749.625238-29-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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


