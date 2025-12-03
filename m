Return-Path: <netdev+bounces-243343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D821CC9D64F
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 01:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E9F3A8C9F
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7E61DE4E1;
	Wed,  3 Dec 2025 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MboY9yC0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E212D1F1
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764721852; cv=none; b=p6NZJpeCYMCj0VF/l4TDSDNDrnag2zR815Epo+5GpYOOhy5yxVU5BNBdFLe1K5v7766lj32xdbBJ6hd6ipGl2a64PTZfXZdYYCreXWY+Z9rdwgsKR0tzQAHPRnJjtFKS7VvlD8r+qnFHwur4OpPb/UlcYfdu+r8jj9OQnUsyViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764721852; c=relaxed/simple;
	bh=1xTtTMtzCycGMEB/S54GzNNRtGwLzqStMcYEvwRKAm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqPq0Ht+qlG27F703ToyyJOEZujt7srMuwn/3jBC7CJvg88kmPvaNYBVoJ6DPjcaQ1Oja7SkVDHw3NEZBm9vbk6H2/lhKuGUlP5I2hvOrqNH6mER3qWEslvR9lpj2XwISUcdbqK1zkwbDLJ2PDM+MY1q4HoxmcFRHrFq5Q26NgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MboY9yC0; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-880570bdef8so65419686d6.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 16:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764721850; x=1765326650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voQQrbWJKCpunIJwZEF7eRPN1HzwT61xuE03pifgTaw=;
        b=Cf+M4bmfvwZS6ncWrz6cqhAz4y0yUnzkc+CAbunuh+GhIRp4mdlqcbCtqnE0tmnSh1
         8IBtCF+BXPcOBUouYZziXD76dreRF7xwfUe5t/Zw6dh4HpPmadHrZFz5Mhb3YexKnJU+
         9orsZtV5ZAuViR9XAJ0D0kltR+LAPCRrmCwOmPhcF4JQk3mXcJUNJ6AJyxxpuYHFebKG
         eVL+KiU4XrLN84mpluC7GGyF+2L2BQnDyfWX6molbRanW2Hnv8MJ5AcCLHR6Ab1C2o7C
         wJ6xy3VRxjti8PsFIRcgyzymzA6kMgmp+Py6PW93bNapYrLZBZp5ChcnVTgiHyX104Zu
         bVhA==
X-Gm-Message-State: AOJu0YwH0GoXOBMmGls1xdAfQO708E4qh9NOk7xK3S7DUgRQul635bZc
	kBPO2ohXGh+DFDyL3BuXaVpKlJD9zBQb3eem76vwCi+ETLlzQw0xbjvwpsWPqDKIpUt6w9/+Tuz
	MPZIdSRNWBW7jJZ/s6UQCGnVKTMuQH1sVCiFcMPsp9fqytcHbwN2oKMM3rArszfXlAODloStvlu
	oN00tiquszQFBOid7xksG6lx2DtZnij1+eVg7raxgDt3MtBRTL8Hj1VGoG3Z5H9MH7I4ys0kGm1
	Uft/roVWX0=
X-Gm-Gg: ASbGncu5YaeTx366jWC4D6j8sscUAP1uT3eYpG5zLu4Gn6twWhuRB0Whp4snwjp8k5n
	ZtYXazwcHFoSVVorHvtvg2SnvXJ+5JWXXY+WaJ8AaOlBnxC9HzSvky+L+avx/He2JXCALj2s0Fa
	Bv7tLceqIMViob4NKWMJlPDkHmzEECcm2ChK40LNwxgu0sKS7yA/Iddlk0Cpgo2OGQRGaapNKTx
	BNrdmg/JCczxii0eZscuxOJNRQM3wLyzDK6VFLcp+gWvcQ1Vj8zAAgzA/ond5FW3wfnPQXI14MX
	Hyb+xkPY2ahqz713P6lr5Kha63dPnZSlyhQ3k/EuopQr9PjqA2hewAT6hTJ9Dk1B5dS7jfy3f4A
	74mEIbEJoLHa8C2R7bCbwQjYPkqAMeOscDJLwIZ9tJc2gIYE4mwMdsISVmxLOfGbIqrvuSxzkB7
	HadqVIyDEljbQ+znt6WXmMi6zCPABithh8kqWvs6AyUlP5
X-Google-Smtp-Source: AGHT+IHz5fXr0YWAE5qs8z5vCxFGjizJA+G6vKGK9BeRCrF/okaQKDL3e+atHbPvNqIIeLRF0HwjmDwodR1w
X-Received: by 2002:a05:6214:2e43:b0:78d:be82:fffa with SMTP id 6a1803df08f44-88819555ab9mr7402396d6.33.1764721849787;
        Tue, 02 Dec 2025 16:30:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88652b157c3sm23128806d6.29.2025.12.02.16.30.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Dec 2025 16:30:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b51396f3efso938870785a.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 16:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764721849; x=1765326649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=voQQrbWJKCpunIJwZEF7eRPN1HzwT61xuE03pifgTaw=;
        b=MboY9yC0RRUbV9FW6JP5vW2xorHSmGqgykeU8jzjdx3QKkxISEnpCi5oFg/BWKLSQ7
         1tSpj6i8OcaWWnTU5KNi+MxWFiZVmaJxjVmqPRhE8XUZjXY4F3jt8ES6qvtZhiItqs6O
         ssV3Q7WGfCNVG6Vb4PN/5iMlZX2OZltV76GiQ=
X-Received: by 2002:a05:620a:2988:b0:8b2:de6a:d1 with SMTP id af79cd13be357-8b5e63cfe10mr49364785a.56.1764721849032;
        Tue, 02 Dec 2025 16:30:49 -0800 (PST)
X-Received: by 2002:a05:620a:2988:b0:8b2:de6a:d1 with SMTP id af79cd13be357-8b5e63cfe10mr49360285a.56.1764721848548;
        Tue, 02 Dec 2025 16:30:48 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b74f3sm1182779285a.26.2025.12.02.16.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:30:48 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	pdubovitsky@meta.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net] bnxt_en: Fix XDP_TX path
Date: Tue,  2 Dec 2025 16:30:24 -0800
Message-ID: <20251203003024.2246699-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

For XDP_TX action in bnxt_rx_xdp(), clearing of the event flags is not
correct.  __bnxt_poll_work() -> bnxt_rx_pkt() -> bnxt_rx_xdp() may be
looping within NAPI and some event flags may be set in earlier
iterations.  In particular, if BNXT_TX_EVENT is set earlier indicating
some XDP_TX packets are ready and pending, it will be cleared if it is
XDP_TX action again.  Normally, we will set BNXT_TX_EVENT again when we
successfully call __bnxt_xmit_xdp().  But if the TX ring has no more
room, the flag will not be set.  This will cause the TX producer to be
ahead but the driver will not hit the TX doorbell.

For multi-buf XDP_TX, there is no need to clear the event flags and set
BNXT_AGG_EVENT.  The BNXT_AGG_EVENT flag should have been set earlier in
bnxt_rx_pkt().

The visible symptom of this is that the RX ring associated with the
TX XDP ring will eventually become empty and all packets will be dropped.
Because this condition will cause the driver to not refill the RX ring
seeing that the TX ring has forever pending XDP_TX packets.

The fix is to only clear BNXT_RX_EVENT when we have successfully
called __bnxt_xmit_xdp().

Fixes: 7f0a168b0441 ("bnxt_en: Add completion ring pointer in TX and RX ring structures")
Reported-by: Pavel Dubovitsky <pdubovitsky@meta.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 3e77a96e5a3e..c94a391b1ba5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -268,13 +268,11 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 	case XDP_TX:
 		rx_buf = &rxr->rx_buf_ring[cons];
 		mapping = rx_buf->mapping - bp->rx_dma_offset;
-		*event &= BNXT_TX_CMP_EVENT;
 
 		if (unlikely(xdp_buff_has_frags(xdp))) {
 			struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 
 			tx_needed += sinfo->nr_frags;
-			*event = BNXT_AGG_EVENT;
 		}
 
 		if (tx_avail < tx_needed) {
@@ -287,6 +285,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		dma_sync_single_for_device(&pdev->dev, mapping + offset, *len,
 					   bp->rx_dir);
 
+		*event &= ~BNXT_RX_EVENT;
 		*event |= BNXT_TX_EVENT;
 		__bnxt_xmit_xdp(bp, txr, mapping + offset, *len,
 				NEXT_RX(rxr->rx_prod), xdp);
-- 
2.51.0


