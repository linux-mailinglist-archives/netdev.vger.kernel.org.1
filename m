Return-Path: <netdev+bounces-194840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2CCACCE69
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26F91715A2
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF3253F07;
	Tue,  3 Jun 2025 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLpTYfJC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9B24DCF9;
	Tue,  3 Jun 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983754; cv=none; b=kGPYOKrXSRoDUETRZJLzT+oCtOxo8INND3xq+8D8l1oqOYrVGMYxf1KjYU8x8t24dS+Q09Phl3QhB0fBj9BEPTaT47LIwtlrJOWXbqtOKEfaBqK2tOSHGNBgswR4iM3nL6nXoiQB+5k3HIJGWtGwkxEZsR09p8dmL1EnFy4VoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983754; c=relaxed/simple;
	bh=xMsq1BEmjGy13ZIn7lFR/lNYbjg/uXqfolLFRsEXlwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnGszARxPkHQnjccBkcMXzCwtJwqfvpPe1uRy2Tse8L09iQ7sBi7NOqPMBvC5LuARSADSXfpJyYGyQCKLCOxqy8WPi8BywCYPpwRC3GutQSfU/979iVXcWVk8SsPH3gMDD3PbWcm90LTlUG88oSzus9kIzR3UF/GDyzZoKexKzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLpTYfJC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d3f72391so42877555e9.3;
        Tue, 03 Jun 2025 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983751; x=1749588551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRdbt6V9pkRCMzRa1/bwpnovvAg9OUnHvZR1pc6vjHE=;
        b=jLpTYfJCXrnRWkjCCYW3FEZvfBuOfHrgc1yytIHnCNi/GBD6U+VX+XyfBpy4NKfRT9
         8+1w7F+t3iXotNzeVRoPKvfDB/GkS6KmGcDwQLtQkZUIoMscDD13bosxIzZGxmg3XLrq
         Tch0Sx3Ie0LF5WLUGt6px+VMJx+C3uIxWi7zsOXeZxZYCscsimkve2AnlZVhHl5KzjdT
         MKSYXGDVXEQRRtfrFOYdJWmdHfrTP9ZS48yHnBYVvW9S+C062hdyNeYndpyAwfwKlq/j
         c0M+El3Eu/NHSDN92BHWmbBoLVZJBzlxrh5n94PFVyTzENvMqBXvoqr8bOvmcZUDi8C+
         VaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983751; x=1749588551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRdbt6V9pkRCMzRa1/bwpnovvAg9OUnHvZR1pc6vjHE=;
        b=hQUYxA3BVBaRzDWWL038bqG4xx+UYkunP9QKt3Ot/YPLdvNB9+ir33Tj7Cz+HaL3N/
         u2/ovz7Wpq+eINpVRznaOcabCVU7HlHYz/SIbLeyrJ5lpcMR7DNmoITxAF/mFOzQanus
         kJ7+HBiyyPN5o8qJeVbcFyvNw2YaKKMp39fjFU5KIH9T3F+TRKbKisZfbyXts12HZ1Oj
         ZSxioD+J8oIh2iVABZo7fSZ4eIF5cxGC7z5LrvLaO2fWz0k0O3FiyMornSRFhlmGEtoQ
         oWpf3/XeZ6VTkpsWwhEhlThtSQqxzZZtHD0CDmz+3B8CZ6/QdGxVz65u0rhcg+k3RYB2
         OOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD8I6ulCqi+SY97SemI/ng7vq9rYStoTAiN8dTBiPdjzJRjwCSLLmPyudZzDJL/TXF1CU4AX+U@vger.kernel.org, AJvYcCXoI5el8QQSXZ6aB6M/YWK6fV0Uz82+nhzBxJn8dRGTmw8oYi4aLNw8dVPT9yepNBzmjXdCcRwJ2cIih7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP53apeIU8InHUaueLZjF8BLofRGrg8ktfnyCuNPFZMhAYM1LG
	OdXmOUUGmz2A1OT2HT7kRb6WICTnbf8onUDK0ALmScTp/8cJyHMPvAzi
X-Gm-Gg: ASbGnctTRYnI1MsA+/+pcu7RmcusJmIi0a6no/UP71gmg45qgYB3HMejk9cboJFraRA
	8IMztjV8rAkhpCcrMW1uvdiKsmdqkMLokQX2jFzXN14EfM3piShokFGn/EgdX7Cd6YottClhEv+
	i/L9BGibPcW7MKtB+BCC1KV6XrTnTPhRDVeDRw/mjuo4DVbFpwwbSLJe+fxOST8mj73EtYK+7C+
	unHhPg5K8HtRcBjZPn/pLKXT6RacjIvhX4aKGiQF+frlhUdBCkyz7tDx28ldIRtlvzSGRMiJy+E
	IPf+Evp+PdsBxDT6PXuAc/NKPwijtoNtb0Dy19OdTRPVkHn/GtsRaT2Nq+4PoULascsNTmbvK54
	aqs0YKyRJqMplqZReiB6soXcX8f1t4R2T3QxZxT6iPCVPa2a1s+80HMvUchqcoG4=
X-Google-Smtp-Source: AGHT+IH1WEGuyW9XKmKz4BjVDXrWRz/lz6TUAN58rrx8wLwtxVwwJw+frJLuVX0Iu/6RQ2MIMA8A4w==
X-Received: by 2002:a05:600c:1d24:b0:444:34c7:3ed9 with SMTP id 5b1f17b1804b1-451f0b256f3mr1050815e9.26.1748983750959;
        Tue, 03 Jun 2025 13:49:10 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1500-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1500::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e58c348asm26258225e9.3.2025.06.03.13.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:49:10 -0700 (PDT)
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
Subject: [RFC PATCH net-next v2 06/10] net: dsa: b53: prevent BRCM_HDR access on BCM5325
Date: Tue,  3 Jun 2025 22:48:54 +0200
Message-Id: <20250603204858.72402-7-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250603204858.72402-1-noltari@gmail.com>
References: <20250603204858.72402-1-noltari@gmail.com>
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

 v2: no changes.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 143c213a1992c..693a44150395e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -729,6 +729,10 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, int port)
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


