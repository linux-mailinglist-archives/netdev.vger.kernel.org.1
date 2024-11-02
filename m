Return-Path: <netdev+bounces-141206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C39BA0A0
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 14:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB406B210B7
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D1C19D8B2;
	Sat,  2 Nov 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1jYIr3o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C331607AA;
	Sat,  2 Nov 2024 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730555350; cv=none; b=HgQ/gmhvtAqw3C0+EAeuF2whl7sBUi6iiKNC3GOqe9mEwf2Z92ZThNo0I7y2jq/dbUIeyTGFr7Cg8h5sQkidFbDjWQlOYYXXAdgE+7tyZ247c7psHPYASo/AiUgHI7Izolspv21X4G6U5rrBXy0y6Rzc+rp6jETjacYHox73qVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730555350; c=relaxed/simple;
	bh=QlN9eg7ts+7pJDsvtKx/3mxNo/F1JSwVO7OYNfiO9F4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/SMCuts3PDTuQsQGQorx8AdNcNd7mHb7aAQnamkPmcRa1W0RVCvN1DlZXVb9VaE6MdCf4LMJhcrCiGX4XAGhpi6HHjkzrAmng/CpEclvMeBmfzlZMZlWvt20e6DViBAUyLsjEpTjc8L/UzquE4de/OFPdVE4PHVM5PnYkWfejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1jYIr3o; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso21541205e9.1;
        Sat, 02 Nov 2024 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730555347; x=1731160147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZXYdOojQ5JCeFAKKAsf3AfZWq+8G43XEkW5mMC20uw=;
        b=i1jYIr3ogMxiQCsf0GsdOItYy7ouaS7q5+qN/B6/8576R4VtnrAazF+DH2a94ZQ7D3
         x3DZBCKLAN3kWpTMksstdAOelL4SZVwDOvoFMGp4Je3rEXMh5GvOf2/MHzxqSJUOU3me
         OqF5pVftPyR852DgQdwshFMyQFCrYP655RMqvEoVeUGJTMO+biojc1XHFqp4j0VaLNlu
         HXkfkfNldnqY8Eq7Nkh61Qpgc7WjHg/rPr6BFh+QoLgMJjlibtJCrqccr75rZw/uwW1E
         NfhXa0ee3+JQf7pGkwO+vhpgxvpTlzwS067/MRO1Ju5asIn9gWsdvf+kmNfc0M8wQ4Uo
         CKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730555347; x=1731160147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZXYdOojQ5JCeFAKKAsf3AfZWq+8G43XEkW5mMC20uw=;
        b=vd6C6qNOdWmOGx3oG20OnVhOoKVnfwhwAEGN8DG2CC+wOs5jNwuyHfdlqzoYFQsazV
         cfkLVJIY8B2nlhcHvAvfHwrakHLq0FmhfNG6hZCglN5SBIvj5Ai9qR7u3k+HMWmuojfw
         tDzrbCIgRDETXaLyw/tlGo5r4reaFHVIMKCgLfDHLZultKf+HPPF4rA0xbttaAmiRRI/
         4FaRWGskCyhCrTBtAc6hqN2WTCavbKdq78LPLHUVStBbDXU1tVUDWQcDN+fdA0nQRxK+
         x0O2wMFqO8LYLUdvAKYAPpF4KHjST71fOIlLnp/tuqrF5hFXIYaxo/mr5+vkUeqqYtfn
         Q2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUNsGoeZahHyMaQd4EToXiKwyBXUrLDOHiQDfQTGZU/qi4xbxZPyGe3AI5F3sO1hcGGpybIJmofch+xok6lz6g=@vger.kernel.org, AJvYcCXprq/n8PjPsPIZdwUb2j6AYOJ3EOCGrOJZRUdE4P9lmnM/AG89H6SessD18/272X6EfyYVybKWZi73pHOx@vger.kernel.org
X-Gm-Message-State: AOJu0YyGxcHCRNNdlK9NXOJ748bHSx31KcPAA28mh2ks21n0KtYMuEA+
	CSecZ6TB6wk9OhLwuVa1OUOByNigAhR0ixE8IWev1mpLfwr12szS
X-Google-Smtp-Source: AGHT+IFQv52kCU7Mwzq1OHsKKTo1+SsQhgY0RzuxusXU/D0yybpByXaiO5qp726iFp5CmIGoMcnGvA==
X-Received: by 2002:a05:600c:46d4:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-4319ad049a8mr216105165e9.27.1730555347446;
        Sat, 02 Nov 2024 06:49:07 -0700 (PDT)
Received: from void.void ([31.210.180.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm93256255e9.12.2024.11.02.06.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 06:49:07 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Karsten Keil <isdn@linux-pingi.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH net-next] mISDN: Fix typos
Date: Sat,  2 Nov 2024 15:48:24 +0200
Message-ID: <20241102134856.11322-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.170.g23d289d273.dirty
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos:
  - syncronized -> synchronized.
  - interfacs -> interface.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/isdn/hardware/mISDN/hfcmulti.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
index e5a483fd9ad8..f3af73ea34ae 100644
--- a/drivers/isdn/hardware/mISDN/hfcmulti.c
+++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
@@ -930,7 +930,7 @@ hfcmulti_resync(struct hfc_multi *locked, struct hfc_multi *newmaster, int rm)
 	if (newmaster) {
 		hc = newmaster;
 		if (debug & DEBUG_HFCMULTI_PLXSD)
-			printk(KERN_DEBUG "id=%d (0x%p) = syncronized with "
+			printk(KERN_DEBUG "id=%d (0x%p) = synchronized with "
 			       "interface.\n", hc->id, hc);
 		/* Enable new sync master */
 		plx_acc_32 = hc->plx_membase + PLX_GPIOC;
@@ -949,7 +949,7 @@ hfcmulti_resync(struct hfc_multi *locked, struct hfc_multi *newmaster, int rm)
 			hc = pcmmaster;
 			if (debug & DEBUG_HFCMULTI_PLXSD)
 				printk(KERN_DEBUG
-				       "id=%d (0x%p) = PCM master syncronized "
+				       "id=%d (0x%p) = PCM master synchronized "
 				       "with QUARTZ\n", hc->id, hc);
 			if (hc->ctype == HFC_TYPE_E1) {
 				/* Use the crystal clock for the PCM
@@ -4672,7 +4672,7 @@ init_e1_port_hw(struct hfc_multi *hc, struct hm_map *m)
 			if (debug & DEBUG_HFCMULTI_INIT)
 				printk(KERN_DEBUG
 				       "%s: PORT set optical "
-				       "interfacs: card(%d) "
+				       "interface: card(%d) "
 				       "port(%d)\n",
 				       __func__,
 				       HFC_cnt + 1, 1);
-- 
2.47.0.170.g23d289d273.dirty


