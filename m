Return-Path: <netdev+bounces-212208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F0AB1EAE3
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E936580EBB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDAD286D72;
	Fri,  8 Aug 2025 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b22oVVYv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE57281525;
	Fri,  8 Aug 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664837; cv=none; b=QYE0bwJEfoCPHk+maIbLEBNY2jkPtKbyR3UkQO4oDjs320ci+/RxAKs+qNSUXAsHHFbyvmcRnGriwA4+HMFN3OFC7EkBfb7T5DZf8TUWeKAzWgSBIVwFTkSH7FRAS8ksVIWDO8FmO4NEo1ejRWM2oSwYHWyG5n94jaKqPt0XsVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664837; c=relaxed/simple;
	bh=3WUy0av+tGrLZwws0zMeXgY+WuB/iILuEK5qJwZ+2+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyO6duMpOp3TETT8BkC6JE68Xxsku2maFzVksdRe0UsF0B+kGScivr0y6azKUYMzJtF0U26QoL7JW2Pf/12dxC86GdKOiM/KD7owoCoTe9A4kdJ0xw4xMyMbUiBXzJNxybcgJwof6gnCGPLJjF6fyzQeRtrdqovadS3aT84ljqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b22oVVYv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-454f428038eso19169665e9.2;
        Fri, 08 Aug 2025 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664834; x=1755269634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzl+/yw2SoeEUSeRtFTbAhZhsO05Pma8ahiXaaydnis=;
        b=b22oVVYvIO7h720yOTie0HjrLjYuPZzE3KaLpGa0X1+EdAwNcNe4/iSMQXi7tO3oNq
         N2hsa5ZR1aDlkR8vyc5ktHSW6aXjGLLwU/FWXbSCsulfyOrpN2AQbu+FgNw19uybjOcZ
         PIg6ZRItCik2IxkJzJiP4Cyf6nO/2OQh/UnxXw7H0yyCKetejq2lCwvd06VIarbJDUMF
         l9KUckpXGUXHJPImod0pn4i3gTOuD7vlbEln8yvUwz7YYJCXHxq1S01xTzu4qa+6hGUJ
         /6mcHgXRFxev96LmPrCidt5Pkr+u/LzcbxtxIU5p8G79BviNNJCIiPqOqbkfS6pzZgoh
         2T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664834; x=1755269634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzl+/yw2SoeEUSeRtFTbAhZhsO05Pma8ahiXaaydnis=;
        b=JDjV360GAtg1Iug/5Ojmie//Bgch8IJWhFrAPs4HJyFr7T3+rgznRtuRT1GvsLzVcn
         I5x3yzRxFKIfIrFXAD1AWgLrvE5sMZ9eJBnTBSxUZqbiMsFxQ7gckdcdh5SykUEr3tWz
         mooau6+BHAajRRdppb1qmmMGEw+D/cAsA1jPx/kw0OFq9bL9qoK4FEobOgi/EauEFqQq
         UOOxG2IdVadFn/ApAClLxr0YFR/jwqwbOfZh9vFaceAhBCCw7slIge2Frb965eJHd9zL
         uJnYQ0rfnruYB3F3WcHy6v01HGhFRhcdiORLkoM6p84czxEvV+brkXMlz+MFKXKfDbik
         HRig==
X-Forwarded-Encrypted: i=1; AJvYcCWVWr8SWI1qoFqkxHeUsd3mCIs9ev1vu5s2INlNyghrj3/AzV5gshzLfdhOq2z5caxRefOJCl3hSsoZHGQ=@vger.kernel.org, AJvYcCXKqR55j6LGzXp491Cic63efApNdCt2HAV4pyd75R7nkV7zFPDeBUe/DOXDmRhZ9JS/a6ZmtuRc@vger.kernel.org
X-Gm-Message-State: AOJu0YzIibB9zokWz7C/PMvLX/abcipBOa2+g00sYAlyKxKD865A9WSb
	0L8LM5a9vfi7eez9e88PginWiPV5+Cv2E8lo416Ma5CUEscUGMOtIVGV
X-Gm-Gg: ASbGncvFXADHELhYaI7ZiaSLs4GTgjcMOrp/RdZUX+UaHYBXYZoWeL2CfITUpB1GVDD
	yxaoQutBlRR5NPDVSnAg0lVZjRzCZMus6mKYuDlAeK1ugQYsudhA8jNqIAev2w2IAQ6FlMHM9m9
	k3Agvz5g7ugT9nU7spmQpMumqtBIMoy37tw8oHonHsaIlYOgazSPbgv7R0aA3AKVOFOAF7rFtbS
	83QJwBHd0N9RgSzdUZKpOfaTm7YvvG5xuuT/b0Ia2/38QdrGFlZf/iWwAqKmiHpZZwKQJaDvBuV
	IBAAoFAAnPS2F5ZGOA+piahAtZo6d+BeE7ubo2VRTOdHHu3gGcCA8qh74ruvS0hNC203MzWw+W6
	k3hm+he15OasoEXh6
X-Google-Smtp-Source: AGHT+IF0tcJ53xSLHaSv1PHGmbfAqJkCMqX/SXSe+zsI/JAM02VfOip/w8gRcmnplAGDo5Wv3LFqsQ==
X-Received: by 2002:a05:600c:4f42:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-459f4ec6a99mr32141485e9.15.1754664834159;
        Fri, 08 Aug 2025 07:53:54 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:53 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 15/24] eth: bnxt: always set the queue mgmt ops
Date: Fri,  8 Aug 2025 15:54:38 +0100
Message-ID: <13a344abdba73c39ba7a06dfb28909e5f3ee53ac.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Core provides a centralized callback for validating per-queue settings
but the callback is part of the queue management ops. Having the ops
conditionally set complicates the parts of the driver which could
otherwise lean on the core to feed it the correct settings.

Always set the queue ops, but provide no restart-related callbacks if
queue ops are not supported by the device. This should maintain current
behavior, the check in netdev_rx_queue_restart() looks both at op struct
and individual ops.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: reflow mgmt ops assignment]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e8e88782fdf1..933815026899 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16118,6 +16118,9 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_stop		= bnxt_queue_stop,
 };
 
+static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
+};
+
 static void bnxt_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -16771,6 +16774,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
 		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
+
+	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	dev->request_ops_lock = true;
-- 
2.49.0


