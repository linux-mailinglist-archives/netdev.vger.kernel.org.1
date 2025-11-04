Return-Path: <netdev+bounces-235315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C72EEC2EA9C
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 01:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885BF18991A4
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 00:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10E6200113;
	Tue,  4 Nov 2025 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VGgMDJkb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9571FBC8C
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762217873; cv=none; b=fjkSnU03Ln1P13AjiHTIR6VBeLuf/N8ZLEd/djH9rw8aT9xmwRekn5eoj5HUKm24Menllu1MpFxRfLK0H6w+3zAiXDLkANcaiIFBot2t0NiWMCAu72V+o5WrMudtBmCyE15rGkz+n+9ghvT9aCHIrB0ZiYO1O168V4dvNqWLLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762217873; c=relaxed/simple;
	bh=sBwhsoDBG2iP0rqlTN5vrPB5tiOvhIqq1hQHGesXqOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1abHdEqkV77rw0Tvwg43cI3yJU2fBoXTknquk9zXpqyqpZnZD1pNWb7FdlOoMWfaGg6gcQhot9DsPjfP7Hnbjp+xwNZ1a16eEoAUZzzpif+A7KsJFfipVSBNuJQufvRAHURbmvkY6pYr0cVM/V2KYGut/hWEt+rKZEL4iuU8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VGgMDJkb; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-88059c28da1so15924326d6.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762217871; x=1762822671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzSNHEHZ+hWd5dNkc28IencSqOPNHNH9ywgVQV+a+jI=;
        b=W+1P+jBxmAfkgFwa4+OZnPhfutNXZ7WCC4yTa+CAY8AadpBKugCYcS6hmGTFwpCzGR
         a+qXOkpS5TfthxfBY1APqtFE/roKzJXL+xR1WUVR5kqYqoWlYouAz8Csk2Wj/MMyKtGj
         c2cASaR+0z3Z6gq5bterJ/Vfja8Ev2xG3b6VfjtilEK9PtxHnopsRtas47H3RhqIZ59q
         ARdl7jECbzky8tqzLxwx8BmbY5BVSRD94x4vPok80H3zm9Dq3blh8mWEVhKGeIrmXRI1
         9ujGahScq/OoXhccmOd9YV3cNrDJLCQefclD3gXQtsI+ycomdmTlhWKW6ZY05Yb/6yQc
         6mDw==
X-Gm-Message-State: AOJu0Yx+ohgjO5HdjNhcQTtlFsgkkRkXn5A16+2AKnNeafz/CzfdHUyc
	pd7BvEeQo7BDe1d3sNkkoy5NdUhJOGwnbaoCiM7C/B/UaBDCwG73nMKTkXUsauS0Xg/EHslBVbf
	vi1YCnWsNRgrGYzEl/PXtQbIIv5KS34SwdB7KrqQ4AWwOLWt+fbwLFQScCXOinG4E3M10A+KHQ8
	pswDZhiV0BcCohxrYGKa5islIoyGS2dNVInMa+HEBEUSwZeBpyuzoBb3aCe2XhjXlZKrVp3I/4o
	vr0nU5oYHg=
X-Gm-Gg: ASbGncvtPKiUsy34xvxkjsXigW3aWdKBOYWVDwKf0lI8RVPI+hatkru/cJsgfEe5Egu
	DxVqoOo1XDsywbwiRvXKSKp8c/dXax5OWzEeyYmX3k/xpAIXEj1PUWSAgrKdWRtW6gsQvow+qJp
	G1EmQumrHJxPFLMnYHkC7b9UfL6Yd/jTIn0juHvcq2C5HS3wxbGKXFJIQcX4yEFEgnm1XQnKdnJ
	bftswcg+wbQjbBhs0JEGHMTFQ5G1l0g0vSvHgUc7oePtVn0BewVYJZfAyih6omPOUCa+N/SEtQF
	4crxAQsF8cLX7Uuryoahwi22NvArP11x38yrzigi120CWzkc4UQt/+QeVqa8wNRDeJ1tRbdUBzq
	08A4oHA6ZYyvCA8lOx8v4c4SGpIyNjIUDnbQu+aGj0ZuWW9VZdE3kWSVJAI+m0lCCVOzD8zNRow
	xQluWSJk7XMYQCWY+GoASNNrMy3fx4qt+cHQ==
X-Google-Smtp-Source: AGHT+IEL8IvvhxiSpPYf3XeU2ffT2k76TyIfHgcLg2Ltrr0/T/bqXejixAcVqGwj9+E9s9C7jHXTGmNboGl4
X-Received: by 2002:a05:6214:2404:b0:880:531a:a32d with SMTP id 6a1803df08f44-880531aa5f8mr86985196d6.41.1762217871046;
        Mon, 03 Nov 2025 16:57:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88060da9234sm1532846d6.6.2025.11.03.16.57.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 16:57:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3416dc5754fso700240a91.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762217869; x=1762822669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzSNHEHZ+hWd5dNkc28IencSqOPNHNH9ywgVQV+a+jI=;
        b=VGgMDJkbmvLmF+kKYgEL5aHvXreTE5rn+fJAEFNxzLqHcbQPFfaOOBL+gLKjFqjDWV
         hHoEBWnVmxtIbd12kjicWGHsNrXB729TKZedywcFRoOOIfk3e2e1Mg8U3tQDvchJ78J8
         7a1DOo1c2VLb1so0IIKTxJmI8gUdRLXdm+Tno=
X-Received: by 2002:a17:90b:134e:b0:32e:3830:65d5 with SMTP id 98e67ed59e1d1-3408308c65cmr17749837a91.36.1762217869160;
        Mon, 03 Nov 2025 16:57:49 -0800 (PST)
X-Received: by 2002:a17:90b:134e:b0:32e:3830:65d5 with SMTP id 98e67ed59e1d1-3408308c65cmr17749814a91.36.1762217868762;
        Mon, 03 Nov 2025 16:57:48 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14bbsm2474553a91.13.2025.11.03.16.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:57:47 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Jakub Kicinski <kicinski@meta.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net 1/5] bnxt_en: Shutdown FW DMA in bnxt_shutdown()
Date: Mon,  3 Nov 2025 16:56:55 -0800
Message-ID: <20251104005700.542174-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20251104005700.542174-1-michael.chan@broadcom.com>
References: <20251104005700.542174-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The netif_close() call in bnxt_shutdown() only stops packet DMA.  There
may be FW DMA for trace logging (recently added) that will continue.  If
we kexec to a new kernel, the DMA will corrupt memory in the new kernel.

Add bnxt_hwrm_func_drv_unrgtr() to unregister the driver from the FW.
This will stop the FW DMA.  In case the call fails, call pcie_flr() to
reset the function and stop the DMA.

Fixes: 24d694aec139 ("bnxt_en: Allocate backing store memory for FW trace logs")
Reported-by: Jakub Kicinski <kicinski@meta.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3fc33b1b4dfb..c0e9caa1df73 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16892,6 +16892,10 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		netif_close(dev);
 
+	if (bnxt_hwrm_func_drv_unrgtr(bp)) {
+		pcie_flr(pdev);
+		goto shutdown_exit;
+	}
 	bnxt_ptp_clear(bp);
 	bnxt_clear_int_mode(bp);
 	pci_disable_device(pdev);
-- 
2.51.0


