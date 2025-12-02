Return-Path: <netdev+bounces-243310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83427C9CDC3
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 21:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCCE3A3159
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB72F1FF1;
	Tue,  2 Dec 2025 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPxOHxAT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0EA2DC78D
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764705733; cv=none; b=WmiTFkSOid/OkCBv6gdUYaOPWDlLWeWbpy/1edh2Exlp0Qd2dnJhfmE+PWW10Bt8F8EBhM4b3ciYcDyYmGTNhRs564lJykKuRPWqqCbkpCovlEyHVYIhit3ctEdkn1eZ3rYOd8HVYI3TOYyhsdFn11FivsAJZoAZs7JdnrYD0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764705733; c=relaxed/simple;
	bh=TDdA1Lk6W/430pHO40A0kQFQ1LvzegEfZLHPxrWizSg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bj9HwJ3Ano3EBzhAOgfjgPsO65o4uM9HwoScxYoorTBseWnEaAbGx9GcUznsky3MYVsbSmcKm+vDqfSlbcZ2KusEwaeq5YPF6q+ahMAEVsrkp+e/yFb+UkQFYmgzq4V/bg/9mM97UWvClWBLHwk4OLh15+L70R+ComBfewlD8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPxOHxAT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297dde580c8so149564615ad.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 12:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764705731; x=1765310531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iWS4ilWiOPuoqaivVnR9bwmpKBEoYpCLvIXZZjrAIWA=;
        b=wPxOHxATpN00XX+Ovo/uzF/wBiMCsHKRf/AhbkxHadX2JSHZ4/7aIxBTGi0semhAex
         En7Hin4jml7wMsrWA6AnSBMpA/zaIfrDNF2gTrfmydiA1S8od/Kzxu1P82sU5AeTF215
         Xn7G7wRKM3imsWsH2AuqpKzLv+fOK9y6zq7XPiEuIH/uF/gsXrEB+nnrGRmkAoUXE4ap
         hq1MGmgLQYttkyGfoKVHdGHgeYeXQDMlqM6qDnk+PG1KQtOmPnkG527VFo7yA43Xt7xx
         jb+gwQd6+WH49HL2OKaLGfohBj6Cgw4XbG5y5jqQ41tp782wz8NDH6BwQDq5Uidsb90g
         MPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764705731; x=1765310531;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iWS4ilWiOPuoqaivVnR9bwmpKBEoYpCLvIXZZjrAIWA=;
        b=NjepIeQLHRRmaSyYsiTkP8Lpu/RyI15Wzuc/aAKm/uC3bzkiBSSuJxDmfAc2ifnhsd
         YgyBNgnX4WKHj76aXnmAReYUsFHaZ+sR2Qyy66lHv407JYYYsCfja1UyW2Qj8I7BWaWS
         lenziiceJTd4pJg3cHZzIJVp1Yf01NGPEyk8wz1CFxzm9SAOTKToVAzLOqo6An2EC5XO
         H7VBhSsNibzVLthWFj0iyYtsVGcy8xTOM+JrkOMsC23AKqAKKlyTVyjHZD7bsb1zc+kr
         aTDPDRQIPV67h2umpTxYweOjof1rhhitZpod0f7DzM3An/i6nBzZ8YqnWCQkWgTuDXd6
         zUBw==
X-Gm-Message-State: AOJu0YyKGU9l5XzZDceyojjwYZYrIwI735LdlwxTRQ1CluENf7KOytrr
	qFBFKNYvhnVejvk6dgnIoW+9kMmNOnkmKnuDHMaWENLEi0gdW10F+rD/iJ7LBG3WtvONEjXoVZQ
	lSXiw5ibfG9c8XJzBZY8MCQjtcRd826uXYfLelE7/G2Yve+6XQQB4MEXcHfuZ8TqLzCA7grrtV/
	kdZQ4ULnIk53E8mhFZS70XYhgkCde5cn3FAT8DvUU/s69lp0WAvNW612AfMlFc7gk=
X-Google-Smtp-Source: AGHT+IFqfoIRRiJ1vvcwM32p00wPCjeHo/C3CJAMwvUUK0GCFMTSt6XtEAgVsdeowOzCcSSPaIlar2F88q+2kpYEbQ==
X-Received: from plog14.prod.google.com ([2002:a17:902:868e:b0:24c:966a:4a6b])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c70:b0:27e:ed58:25e5 with SMTP id d9443c01a7336-29baafb784dmr340719965ad.24.1764705731023;
 Tue, 02 Dec 2025 12:02:11 -0800 (PST)
Date: Tue,  2 Dec 2025 20:02:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202200207.1434749-1-hramamurthy@google.com>
Subject: [PATCH net-next] gve: Move gve_init_clock to after AQ
 CONFIGURE_DEVICE_RESOURCES call
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, pkaligineedi@google.com, 
	thostet@google.com, linux-kernel@vger.kernel.org, 
	Ankit Garg <nktgrg@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

commit 46e7860ef941 ("gve: Move ptp_schedule_worker to gve_init_clock")
moved the first invocation of the AQ command REPORT_NIC_TIMESTAMP to
gve_probe(). However, gve_init_clock() invoking REPORT_NIC_TIMESTAMP is
not valid until after gve_probe() invokes the AQ command
CONFIGURE_DEVICE_RESOURCES.

Failure to do so results in the following error:

gve 0000:00:07.0: failed to read NIC clock -11

This was missed earlier because the driver under test was loaded at
runtime instead of boot-time. The boot-time driver had already
initialized the device, causing the runtime driver to successfully call
gve_init_clock() incorrectly.

Fixes: 46e7860ef941 ("gve: Move ptp_schedule_worker to gve_init_clock")
Reviewed-by: Ankit Garg <nktgrg@google.com>
Signed-off-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index ace4ff4c6b3a..8fc9ea930fdc 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -657,12 +657,9 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	err = gve_alloc_counter_array(priv);
 	if (err)
 		goto abort_with_rss_config_cache;
-	err = gve_init_clock(priv);
-	if (err)
-		goto abort_with_counter;
 	err = gve_alloc_notify_blocks(priv);
 	if (err)
-		goto abort_with_clock;
+		goto abort_with_counter;
 	err = gve_alloc_stats_report(priv);
 	if (err)
 		goto abort_with_ntfy_blocks;
@@ -693,10 +690,16 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		}
 	}
 
+	err = gve_init_clock(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev, "Failed to init clock");
+		goto abort_with_ptype_lut;
+	}
+
 	err = gve_init_rss_config(priv, priv->rx_cfg.num_queues);
 	if (err) {
 		dev_err(&priv->pdev->dev, "Failed to init RSS config");
-		goto abort_with_ptype_lut;
+		goto abort_with_clock;
 	}
 
 	err = gve_adminq_report_stats(priv, priv->stats_report_len,
@@ -708,6 +711,8 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	gve_set_device_resources_ok(priv);
 	return 0;
 
+abort_with_clock:
+	gve_teardown_clock(priv);
 abort_with_ptype_lut:
 	kvfree(priv->ptype_lut_dqo);
 	priv->ptype_lut_dqo = NULL;
@@ -715,8 +720,6 @@ abort_with_stats_report:
 	gve_free_stats_report(priv);
 abort_with_ntfy_blocks:
 	gve_free_notify_blocks(priv);
-abort_with_clock:
-	gve_teardown_clock(priv);
 abort_with_counter:
 	gve_free_counter_array(priv);
 abort_with_rss_config_cache:
-- 
2.52.0.487.g5c8c507ade-goog


