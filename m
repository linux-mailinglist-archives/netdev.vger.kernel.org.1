Return-Path: <netdev+bounces-241425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FAEC83CB2
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B77034E7004
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5F52D8768;
	Tue, 25 Nov 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBQ+Y+TE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9352D3A96
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057127; cv=none; b=DNVxFIru+Oa8ZfOTXE/9S5KMtky03H4htUVMpe9nJnjJu6MGvq0LrCQE0T3faU1ZjNn3U4eA63KhkwgXBfOWZE9kxJjSpwUwjPSw4IQ+W/6dgh25HnvQkKr7i9JNT0Cwu2JgX+Dqz1hwgjq0rKApIfoRxfkY5lAuRKBxI/pHIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057127; c=relaxed/simple;
	bh=xJrLWiypSzv7tbm+UXydfgomeBu1RIlJpABvqb+ejXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2NPhlmdkwcosDovmVPIrvI4gB7jCIandqXf9JM+A8DLgr4NkieMouoqaJJ5U8LSwaYekARS7Xw8SYQwkjF4NxpwLxpExQMQFZxiWmgxmfRmNOULBbyT3xIqvkRUYHRh3BUGK+CBebs3Z30LMPqGYQ2O55HEaDkqSHwcgUasFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBQ+Y+TE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so9190430a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764057124; x=1764661924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnGk+tUKUAbUfGbDKRIvVPAkIwqqrCfs0BfcYDE6rSQ=;
        b=fBQ+Y+TEO9lTP3MFNs38JTikW25Wda/K7mgZbSC2lmCwSdLcHSK6GPGcX+yc2466CV
         YogCNBDWfxY+MqSJ1OXqkg2G+yvFvgSBPuGRJoLQM0kgu3DRKwPKuwGSIUbtan23MKTX
         /saGD/O6ooXA1bnGDaD+8XOVy6zqTtYHhKCmZkOZlapGcAPlbnM+oulTGMEE0Td03eCx
         Zeb3Nt2g4u8r+hoohJt6ve6rCdL9ziDcJjKSViEOH1LB4qBzZ5G9XsZ/+3Qw6Yj5913C
         tQSwPgsI4KPYFVmYJCgh6Jspir0LibgyVdeg7zfBKjQ+tseEtV5yqN28JBC4St/RJdOe
         coZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764057124; x=1764661924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KnGk+tUKUAbUfGbDKRIvVPAkIwqqrCfs0BfcYDE6rSQ=;
        b=XsNAyRQg/mAWmyR7VTkKR3H5PRmtVI/sN9sljqIf5QVDRAJDX0JBwa5QUAdh489H2K
         gNpWmBQWKBfxhKw6am5inHyNiVVDHY2XKYaw1mhRBsQ9rvg8xqTUvcDo7hA/CUggwiKN
         FpF+97cDf75QIOzFz0/8YkCiElkJtksq7WWCV1ZP0YYmlBIZL9mi4p74lMT8f34PbgjM
         J6/HFVmIvqNBJShMI3cxol411pqwGFv/46+OWc82yv0ka3r9ZRUnD1TVyoR3LeizT/7s
         p5aB4qz2oQbMbEbqAP+NrqAL50avizHkrMDCnawsB+lAHDXlw/Cem8bmDH4IRDS2DrEa
         wC6A==
X-Forwarded-Encrypted: i=1; AJvYcCXUFJ62SMCBmoaC7jRBf7LiXkL5NYF3iYC+P7wqb29peZ24wTT0dFhGN5PDiGrTaFikLCOtWOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLAWw8XcK9042IiB7KqmGsYkO5JgP6WQ9KIDbw70DTjpvXPFNK
	ePiILzBFRs1ce7M6xBH/Bhjp1QJ+nedQ1W5oMrx2/GfzXNLGTjos4snP
X-Gm-Gg: ASbGncsYt7MmM865qFXjKxtJGyVgd9rw6Q0xPEdvMWQE6RLlgWMWWaIYFt2/eAzG9lg
	yEC6d2Fsp878pRxzk4HB9alv7Hjrd6srZEvMI16hUn0sP1Ldx31kY6FIEDnnLnEDCCOc7pIVVnE
	xoNP1eEm4hvTvNQBqtqc1U7alAT0/8zJ+/I4T1gw4PONm3IdNq1lUROz5JClvAEDCQuJf6ZVGnR
	qjVncNdCYle127o8goAs0TTCaKSsiruw/wmYYhSy6wENkdRW9j84dSIMdhEmbRqtsMwDOCYHL6+
	dWo+RKv6KsUWjfCQ9FeVgN/Jr6D0t3cOki43uIFRmNPEnJILyLUO5rF6f5U70P/c0sK+99pc2NR
	zZd1NkKX/1ll1T+v19QQMOwbfE1/AGbcoA6ZO8hh873veF9rXkXHREP/1a2ityruGfr+h+4ojzH
	AkD8iJ7NX+y2OCBmVw57L43HF/Cg6z27FxU8/vQSB4cEa6H7A0rAjoHWFobErGuMUogTI=
X-Google-Smtp-Source: AGHT+IHvwo9+xV6GMAjFeApyTuG7qafGljCCYbe1raelFMtRP0VrlQdL6+eKz4zTouxKDzCMub8spA==
X-Received: by 2002:a17:907:3f9c:b0:b73:9792:919b with SMTP id a640c23a62f3a-b767158227fmr1611162466b.13.1764057124254;
        Mon, 24 Nov 2025 23:52:04 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cefeadsm1528801966b.6.2025.11.24.23.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 23:52:03 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/7] net: dsa: b53: fix extracting VID from entry for BCM5325/65
Date: Tue, 25 Nov 2025 08:51:45 +0100
Message-ID: <20251125075150.13879-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125075150.13879-1-jonas.gorski@gmail.com>
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCM5325/65's Entry register uses the highest three bits for
VALID/STATIC/AGE, so shifting by 53 only will add these to
b53_arl_entry::vid.

So make sure to mask the vid value as well, to not get invalid VIDs.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 2bfd0e7c95c9..3b22e817fb28 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -350,7 +350,7 @@ static inline void b53_arl_to_entry_25(struct b53_arl_entry *ent,
 	ent->is_age = !!(mac_vid & ARLTBL_AGE_25);
 	ent->is_static = !!(mac_vid & ARLTBL_STATIC_25);
 	u64_to_ether_addr(mac_vid, ent->mac);
-	ent->vid = mac_vid >> ARLTBL_VID_S_65;
+	ent->vid = (mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25;
 }
 
 static inline void b53_arl_to_entry_89(struct b53_arl_entry *ent,
-- 
2.43.0


