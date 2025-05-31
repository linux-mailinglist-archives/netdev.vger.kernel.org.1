Return-Path: <netdev+bounces-194499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB1AC9A79
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 12:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D504A393E
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7423E324;
	Sat, 31 May 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4oFMm5J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421023CF12;
	Sat, 31 May 2025 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686406; cv=none; b=ILbQbVFF04nsuU6p5t7vHPQZ/ifXS8Po6WiUAdyGyOvxth5KF+cFzLOpEU5Y/1j5sLLGzIyoQtk0a19DT+/lilAVz4CxWvKhhAy2lgY1+5dxNxGT7DD7dUn0TZwMDFb7RuQa0llMeJ/XZVFhd8uA2mOjXmMaMJx2E0pzugG2Tbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686406; c=relaxed/simple;
	bh=7/YhPWQDvdUVuI/1+XkZrLrSwyD+17gBCz4NIaKyjRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qn4kx1pDaGQKnFUj1Lw6YHlSiRy+p9g1QFlQIn3vuZ4vgomeivud24jAqRJv9rtbHa59+cNPqxfsuZrlycW0u5BGBwzeEl6GOD2WFAE6jHgJbmGs88PvFGEgAEoFIprFTLn1TsoIIFH1U7zbNe17ppu/0yOryrgOHV5GXJ1b/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4oFMm5J; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4dc0f164fso2649642f8f.3;
        Sat, 31 May 2025 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748686403; x=1749291203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghV/hDhB/JiuYoIk0aNe+BY/iAQV6v1+DxcZO2jXJFU=;
        b=R4oFMm5J65yYPQMKLWNT5yDs299hsv3rse+tuebDFfkpLjGxYpCtwiJMnOZ8ms7Nv8
         axc+dal6q0ohNotnK6jBCiWv1Wq6Zt8PJr6WdgCOEvWIXtXh364DzXKs5sC3riTKTIiS
         Za46GtYtsGZen0KGV5Z18/anhlIyYd7Pm4KjZBiOwkgd3DMz/u+t2tFzXdiglxt6qGx+
         4k+CwM6ffwVN+xWOuhQYUKa0GscPyIbAQyuwRUif4ktnYDNsmsV8ty0Kj1tPTIvKMt/3
         U2H4HwPHGlcF1czuWA5XY9aUtLhYWgkPCxtmEY+g1zDMnAbakCYfs4bKNA3pWSFsaZyg
         NRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748686403; x=1749291203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghV/hDhB/JiuYoIk0aNe+BY/iAQV6v1+DxcZO2jXJFU=;
        b=Q9uq+NFnzorTF4ktfnrz4/X0NO//oqXdrwHoLgPUEB7i1m4in103Lj7sglsU8Zno6P
         dAVz/CxGBSIHhoYF2mf8gULqEDyl2wEoxVAkA1PMQru/5uyXsEsyNerS9BvRxRswpRPF
         3MdxPPv5MMrynazR+NSE4Bn/02xBDTfW5JHzkbDrVLsadLMDyz1DWOJ1IlNf7RcpZAWr
         MYxuGTkRaAkjS2goFl5Oww5Bwh3jFCdEST0Ir7xGAdD6XCAdUJxBeb+w40X7We/1Rte9
         l3s9coCIzJE28TPrrmSM1vc5XW9rvnexg7TfJcXgKy4Bo2nbjm/mVM6KnXmSlos456Jx
         EYqg==
X-Forwarded-Encrypted: i=1; AJvYcCUuSBfoFr9ASnbKED41iETR6zX3IgUWk7V+/U2pB545JQQI3cc4Z8s/QqBSSsM+eNSZviiAVG6i@vger.kernel.org, AJvYcCVKpR6xNusz4Kcn+3BHDyZKVIAuIbOeEJw4kTXbI+mE7RI3IIin2kBM8cxfb9js+J9aC1+Xry1P2ZDzqa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIY1tJwj//TnTI99PlKltHH5U6pu7mAh5tiIUU27aw/wP19mpJ
	LVm5+50rkb1yngFfMqAZjTMAu4m2/GKtxDgsZSheH46VGbs/tehvzGpO
X-Gm-Gg: ASbGncv0JJaYJcykzBqo8tHN9W9EgIvaM2TlOyBjubxBiSVHtifccRGPGm6mgVhrZQS
	cMRqOM7LOoDl0QuIzT1PaWWcpWX+SuSWPR26NiPmt1e9HEwR4d7vO/lIU2KYxMFn8omSlhl3MJK
	K/MkE8uiRbo3pBAbDYOpTw1gLROymRzeHC32ixe17M708Q0Uegy9YhCiTFQsXlHK+nGY4ZntqNF
	yThQtgmXfrRQLveRW72bwV5avWNMfgQu9jHUAXv9q0Xei8rq6zU+sH3qiFmlV94m3HLrgWTv13a
	DPqMkaim77moglNukNnXHtrnQJ8tBRxOb0I+BMUCF52thazFrGzPw9xxbflmvQfu7uP3NI7bwfe
	AIQjs7VQ+0rs9NH+8tX9wCAMz3F7TCVxJMxfYw6UdQRajDwNSywiXeS2e3LqIRi4=
X-Google-Smtp-Source: AGHT+IG/T+QU4syZHvx6Gkj6jYjK8uO5S/YNUbYnYvz0Cibu+su3WnXnTYku6Y+bGL8hnotoT+M47w==
X-Received: by 2002:a05:6000:420a:b0:3a4:dd16:b287 with SMTP id ffacd0b85a97d-3a4fe178e98mr997698f8f.19.1748686402763;
        Sat, 31 May 2025 03:13:22 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d5dsm44500205e9.26.2025.05.31.03.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 03:13:22 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH 06/10] net: dsa: b53: prevent BRCM_HDR access on BCM5325
Date: Sat, 31 May 2025 12:13:04 +0200
Message-Id: <20250531101308.155757-7-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531101308.155757-1-noltari@gmail.com>
References: <20250531101308.155757-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement BRCM_HDR register so we should avoid reading or
writing it.

Fixes: b409a9efa183 ("net: dsa: b53: Move Broadcom header setup to b53")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 9667d4107139..fd0752100df8 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -730,6 +730,10 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, int port)
 		hdr_ctl |= GC_FRM_MGMT_PORT_M;
 	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, hdr_ctl);
 
+	/* B53_BRCM_HDR not present on BCM5325 */
+	if (is5325(dev))
+		return;
+
 	/* Enable Broadcom tags for IMP port */
 	b53_read8(dev, B53_MGMT_PAGE, B53_BRCM_HDR, &hdr_ctl);
 	if (tag_en)
-- 
2.39.5


