Return-Path: <netdev+bounces-200257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54517AE3F85
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FC73AEE17
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA32224EAAB;
	Mon, 23 Jun 2025 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtG0/woC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8F24EAAF
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680146; cv=none; b=GUjsItXodM+PE7huCyOL7l0xz3ygY+3VhqBlr7kn/utMfj1Gv03pBzSIyAFecCtlrStpd+fchRUT/2EvDlAS114USI/HVsPrLFxvOEyJ4E4BJcR01Yxt1bpa/q1EQjjXImFZn71g6kLxV8LEi6MI/y7yiIrWMRkcMYHb7ky9Wg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680146; c=relaxed/simple;
	bh=UrXXuswGBrEhDuJFLjACLiORDGcMXXbhSTxxbpVmPi4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJhZFkjrm4LDexZMTUJsMZDK5y0Cfp0DuuIZAPgsBa0nCFyQzYV5ebNUgbbveL3ble75nK7h4bB8o3q63FVDn//muNZIVClRc0Cp6ez5Fze0eZK2QSEgWgWZird/vcpm900N/IBVC8ApkYBjrDKBjgk1EVFXjW4Fn9ixGeRyQC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtG0/woC; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so4317583a12.0
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 05:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750680144; x=1751284944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r0rhmZeDjyY6OCGd4D29huCEcVuzBUoFuTh/lNKuMb0=;
        b=XtG0/woCSP8XVVBD0BpkJmNS0f5hEuSbT/W3K2XQMcwEJAOfi4XWb8f6L0s0TeJIQD
         gyBPAm44iaHAs0H7edQPSP73jLOS4XD7FKnQdtibVpox8WeOpjN6yLDhlf4YQrQXeNBV
         4dc8x3v+puBks2zKCVMGZtid5bM5lN1YI1qMzHObOS0yfpyeb6+3nPAFg16cd8Gl4Sp9
         boU1yrPSTKSjWp8byBt8IXWsOF2IHT6XGJYPHfaiCPEiR02hQRBuLyhryZeCFJfF9X94
         uZCodQ6td/3Y3ti9t0hXJXYmLTzRYX75ByGd2xmoJ5JlWEpYenOJqqAofnDJsCjJ6nq5
         1QPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750680144; x=1751284944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0rhmZeDjyY6OCGd4D29huCEcVuzBUoFuTh/lNKuMb0=;
        b=DQvuiPgHg0+ebVwyJL+DxKvooAHpSPw4tp+MBGHNkILiz8Vk3DLcoEbvURGYe9Vjd8
         ELg+KFeDs2oS8ukS1I+y2AJCaYvB4LCOVSjoYZlIeELpbQvtp3jGLYPRr+Ifc3tR8CAP
         v45YkDzfDz5P2lXvXTBYvBkh9Pl5h405HGvHB/DyhMz28Uw+7E6ey4uzTxwKfSN8dDZa
         9rltGSI3Xk2QSK6S8f8/2OYW3VMMQTs3V7Wd9kP5jKst0tlVU42S4gxG/PfjccSo9lxh
         RCwI7hHs3o/unflg+29Oi4QV5HHRm/hhbmrJ8/AKvZ4fgkgze/BgYo+zRFEG8+DwNNeK
         o0/Q==
X-Gm-Message-State: AOJu0YyCTFplsJfbDTWl1CS2cESaq1LsFpsTfLXdxzI6ms9Z8GwY9mHZ
	2OcqS033knM0TBFuvlSADbIh8ZbEoYh6QdVPcZ6J3lyYhsLmWNHw4JxE
X-Gm-Gg: ASbGncuCOsNbVdY9hs/Ko01iOiVu7GkocSJVrtd6DLZYOJHoJOMeZVbPSRXTne2+FBH
	sOJDH1aU/Z2/W7eBsFY2Tn3bGDOE0KrLg55cWkb1eazuOLRzOIK5QYIqPZrFnqpMNkEaBkc6OzJ
	8JTB5gkpWrMJbRwUsEcoWTO+T5/ULRaAQK1HQfGRRm+yLXMoYvDhLP1DvAgF1wxCeCiCva84V1d
	UAkUn4krafdxHdpINV+uuVZQvlPuHCGoRET0VVCBa25LNv+VnoTDmKidCEleqs8T4LXJUCakV2T
	D6e5Z+d94n+LqJjmRbJvrKd66P5w1YeYmkAhTiVl2uuURfhbrjxryehJQ3BqcoJeeF7E9Wah2CK
	ss+RCA7cZTirCf21S81l5Zj7i+g5/XxtNiw==
X-Google-Smtp-Source: AGHT+IHsT2Qtn3rI1muqEfuEG5EfpzA6P8jwcIzejE9JnwgsNmUmwYwojmL1A/jg6+CaEhHZ2IU6KA==
X-Received: by 2002:a17:90a:d64e:b0:311:e5b2:356b with SMTP id 98e67ed59e1d1-3159d642a64mr19781174a91.11.1750680144191;
        Mon, 23 Jun 2025 05:02:24 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315b5e0ebf9sm4509593a91.12.2025.06.23.05.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 05:02:23 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	willemdebruijn.kernel@gmail.com,
	ioana.ciornei@nxp.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] net: xsk: dpaa2: avoid repeatedly updating the global consumer
Date: Mon, 23 Jun 2025 20:01:59 +0800
Message-Id: <20250623120159.68374-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch avoids another update of the consumer at the end of
dpaa2_xsk_tx().

In the zero copy xmit path, two versions (batched and non-batched)
regarding how the consumer of tx ring changes are implemented in
xsk_tx_peek_release_desc_batch() that eventually updates the local
consumer to the global consumer in either of the following call trace:
1) batched mode:
   xsk_tx_peek_release_desc_batch()
       __xskq_cons_release()
2) non-batched mode:
   xsk_tx_peek_release_desc_batch()
       xsk_tx_peek_release_fallback()
           xsk_tx_release()

As we can see, dpaa2_xsk_tx() doesn't need to call extra release function
to handle the sync of consumer itself.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
index a466c2379146..4b0ae7d9af92 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
@@ -448,7 +448,5 @@ bool dpaa2_xsk_tx(struct dpaa2_eth_priv *priv,
 		percpu_stats->tx_errors++;
 	}
 
-	xsk_tx_release(ch->xsk_pool);
-
 	return total_enqueued == budget;
 }
-- 
2.43.5


