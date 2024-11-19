Return-Path: <netdev+bounces-146112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A61839D1F71
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486BC1F21142
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594961369BB;
	Tue, 19 Nov 2024 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QZU3avrX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584029CA
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 04:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991925; cv=none; b=kopa9inriQ9C09vVzEhUw+yyNJtwj6kDW0oGhhDBWV3CwRcDHA7PeEhH3h2sPnvoRjqruIxWDNMG3CyYa1F1pWEWiViridOUZkwzG6nhIhILHvZ8eDaF0qarByDWLMeCf1V86ZFO+giCneVco89bD3G7fv8nqBbYxF95rcDdj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991925; c=relaxed/simple;
	bh=HqjqJsv2qL8vAkrr/L0CfwlII9JUFNGwgcw05Hn98rA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bcV/KWtuIWW/y72yWwZm/RIoV1RR0jBC0qxjTH6y9M13za+a7JP8ZvwFW4Nknj4v/tslq3zionWFYiwXIVLubKjmPVb+RkXcN4vc5Urm7C+ZSSqkyWQLHYLb86uJ9ijOSwOQzpfpplylvdFB+ZC5vuUr/rBUvsiXJoYpWTiIoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QZU3avrX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea2dd09971so386026a91.3
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 20:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731991922; x=1732596722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBdYSrze1oO/45stSvAjGcpqVYE9fkCz+eEQBnB3CAU=;
        b=QZU3avrXjn40gXJvPCd8kmOvNh0f6Frw2dOqZRvgmxe4+oo8LQREmYg9fxyqnKWmA8
         N1CPT7nusKTjZ3/TeJtSRkecTFn+hIMUCzjblRLb3gweCkYlaXAHOldXXT0SyvrEIIa9
         Qn7Ks2s+9mes5lskNMmocraex54sHW5uy8s1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731991922; x=1732596722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBdYSrze1oO/45stSvAjGcpqVYE9fkCz+eEQBnB3CAU=;
        b=hbql/Qtk9SPuUPYNnfKF55YWWD9+TdG291EHLfLq4XyQEKIspqtS6lrU00jarOnw8P
         EVdLCIukQrt03OEc8WnMqdTo8QtlnP4Uc/ARk/rwoiiSxdOBG5kLnf1XeyM00JFG62kT
         j92sR2RKAlifjUxYzPzLrO4shbWMYSh6lnrNBEftl6N9E/o+NB1UIX4X/vgAE4FBQimm
         QCPWr+bWh/R14DdVPpfbd2CEPPLjwGl4mzEWg/0i8Otyb/yJNl3AwvWWlWmWRM6GhY+F
         O0k40gw3au06yee2zHDIDj2bgVqLZFifa9cWaKiyWHey8siH7Fo9eyyq8UdBeYggBUyM
         czbw==
X-Forwarded-Encrypted: i=1; AJvYcCWECQf0QTIgpt7FG+GSVE0k5RCuFn21tySMT8/59N4lKCS/qEZs5u2In+eAH42NU/vdXJ8pQWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDibzQm9FJm39+QOdwk7iBf1Gu2FnS+XKg5Tb0EOC6Hg6v6L6I
	1YpfFDZgh5yF6X81XNqFRMKNT0Gj2RTIeVXWDYGweSFnYl4iQc+Y96Qxg3J14A==
X-Google-Smtp-Source: AGHT+IFP8pqLDy4cOIbaIjTRmHyfeZ993Dxy7MAICup+qcs0iARcu/zYlI/fUfv6SppLnzDwKOQZJQ==
X-Received: by 2002:a17:90b:4ad2:b0:2ea:670c:c6a2 with SMTP id 98e67ed59e1d1-2ea670cc714mr8798454a91.16.1731991922439;
        Mon, 18 Nov 2024 20:52:02 -0800 (PST)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea35c433a6sm5234361a91.14.2024.11.18.20.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 20:52:01 -0800 (PST)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: davem@davemloft.net
Cc: michael.chan@broadcom.com,
	edumazet@google.com,
	gospo@broadcom.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Salam Noureddine <noureddine@arista.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net] tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets
Date: Mon, 18 Nov 2024 21:57:41 -0800
Message-Id: <20241119055741.147144-1-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware on Broadcom 1G chipsets have a known limitation
where they cannot handle DMA addresses that cross over 4GB.
When such an address is encountered, the hardware sets the
address overflow error bit in the DMA status register and
triggers a reset.

However, BCM57766 hardware is setting the overflow bit and
triggering a reset in some cases when there is no actual
underlying address overflow. The hardware team analyzed the
issue and concluded that it is happening when the status
block update has an address with higher (b16 to b31) bits
as 0xffff following a previous update that had lowest bits
as 0xffff.

To work around this bug in the BCM57766 hardware, set the
coherent dma mask from the current 64b to 31b. This will
ensure that upper bits of the status block DMA address are
always at most 0x7fff, thus avoiding the improper overflow
check described above. This work around is intended for only
status block and ring memories and has no effect on TX and
RX buffers as they do not require coherent memory.

Fixes: 72f2afb8a685 ("[TG3]: Add DMA address workaround")
Reported-by: Salam Noureddine <noureddine@arista.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 378815917741..d178138981a9 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17801,6 +17801,9 @@ static int tg3_init_one(struct pci_dev *pdev,
 	} else
 		persist_dma_mask = dma_mask = DMA_BIT_MASK(64);
 
+	if (tg3_asic_rev(tp) == ASIC_REV_57766)
+		persist_dma_mask = DMA_BIT_MASK(31);
+
 	/* Configure DMA attributes. */
 	if (dma_mask > DMA_BIT_MASK(32)) {
 		err = dma_set_mask(&pdev->dev, dma_mask);
-- 
2.39.1


