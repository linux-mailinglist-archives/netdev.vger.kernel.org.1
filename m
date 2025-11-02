Return-Path: <netdev+bounces-234890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F2CC28D05
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 11:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFB5C4E646C
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C3926E175;
	Sun,  2 Nov 2025 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/KTyXku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53923D2A3
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762078094; cv=none; b=mhBActygSkeL30HivYwUPIJ0VcDsPeo9Mns/Lu8MIZXu2D6HHF+pSFtWORgDBben2riMbsOXMCklmT714EoiAQ2H2qwKr8YrkF1nqOyQxgjduLAFtg+kFZRdsnA6c+v7puCFBXVLZ/6navAOaaQQj8gda2B8cb9bOWO2X7KwU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762078094; c=relaxed/simple;
	bh=Kk0QwPaRAZ9ti5p3bBxKE+qKelVinAAEdVK9YCEF2+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuQgY9W++biW2HF96IsPYBn+MGpMgX3rnHRH7fDtIgPG/Po24O/LJOOK+BryP9V6w4K7vilCNNNyVBI66w+CPCwtMoJLSn2q4MRql71KqnRbFEU8je5CQ8XaoiwvoB68mHDwFFWmmGMD6wFHPBKyi0mOJuPI29P8I9etOZWMN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/KTyXku; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so3826621a12.0
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 02:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762078091; x=1762682891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcBg3WESmBtU/e7ZXw1BuO2NrMipWvi+FGk/MOSixCE=;
        b=K/KTyXkujk4gMcIOIfid7Zycjh2U0WLek5ZmKKSzX2MMkHhrVzvFwmIwEihbWpJqXV
         avakgRb05B77x/8Mvep4rdWBasqkuDyUPnJaqo2cOQt232Tcp5Fx8vnYMBhUTQ0GqCZ9
         ZcTbS2mTORYgN/OwAEt1fNh3m3fQ+c/DTgVRyq38b3vKzc5nUD95mSqgqQESblB93SC/
         K2SsV71kqvR0hAJpDnwjR4nBd9lwpDax+JOTej0JEaq4pzypD0BeG8HNvlQdX4BNk5kT
         M6QQXQklEWzlAZ6G90n06LGZqDd/nsy1Z9dP770i9l/EH2LBXz7zLXkOIWTROpqoHEju
         9dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762078091; x=1762682891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcBg3WESmBtU/e7ZXw1BuO2NrMipWvi+FGk/MOSixCE=;
        b=VlHXqnuXmuoUqLrttFHdKun8O1yPe20/hViK5MWBAiC3ClJcj3xsVAr4Xy1nGvWQ7y
         W/gZOxUqQuBLDut0SIEJvhyn4L7T6ZcupUCEiMh1t4vPcTdhMg1TTwR/Prrq/2/VuZiX
         1ifGu8BdsyIyVjkADfA1TuU9jBsSzeqwQBrut0ab7OKHJAqUoJOHdjTnaxTAoiN5iN4D
         2UjvMShp537AA3RbpwlgGcdc8h0mR69+PoCxpqo1Rtj7cD2E0rW+15vg70C6iXtINxsz
         F+CfYbpYUOMLpm1tVRReY7veWcUkbMhW6h6uTSq2ErCpDy4BgYqbZHp/flmw4X2jmxl1
         ij3A==
X-Forwarded-Encrypted: i=1; AJvYcCWTIrEkloTOhgf9ugHgH2zWOy1VICEwplCEYV+D+rP+OY1n0jRA6PKHKxClZwhfshGPmyLzIRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wG0YzP4BRa07sDTrwRgQytxFpWQx7uy3kCnQZuS1dXhmQ44l
	LHQBJrXu8w84MkDoMa0iaYzr6zAhcsEuZHkPdsJjZ3PJiybbRFpPOHXw
X-Gm-Gg: ASbGnctYCNpLwX3IOzhA5s8TFVsgQ8HOizHub9fW9b15P7E5dPh3ARAhM5j6Qn5FVAc
	P4XGctNzmNGj5Ji/VKZJazk9UNQIMvRxfPSSkIvCd7rXHuY5axOK+i0vrzK0Pg65nlsIX57+hNt
	X9fQP3vdQ9KeBmgcV7TeATo3U1neE5Zidx5S6J0QvbbefxtJhdF9xQ1oxVkD2NOfsjVhzmBJD6D
	zkgYBlynlY3T3RfjSuOIZ95tbEFnMaw2RR1xs0+QVdYwHbW3Pd6wk+MN8l8whThGsQe+PWUsneA
	ZfZzEXFMP6t9hM2PvU9QKeEKAOOLdL63dKGyxyIllkHrfY69Hf9aGEgrZioYz9pjGutJiOOkHHJ
	oROeuOzb2cFRMYc+0ApLAbUdwte0gunoPJM6b/L129HZQxIuCcMWlIIUfUpiRcG5oDZ9kG0WnG/
	YFuXP+EYxqX2fhLutP8E9bK+j5KeqwTQIJfxkymBGGkpp+ShZXPFbn2usarTh9nbckDlg=
X-Google-Smtp-Source: AGHT+IFEwg0H/ZOkoKvaHy719X02ovYGNzJvMYxgE1bjzM/SuoLcpFybWMe1xEm+9adJKjvtSOJKmA==
X-Received: by 2002:a05:6402:5243:b0:639:f648:1093 with SMTP id 4fb4d7f45d1cf-640752fd1a8mr9106095a12.4.1762078090884;
        Sun, 02 Nov 2025 02:08:10 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640b9857d30sm722382a12.0.2025.11.02.02.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:08:10 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: dsa: b53: stop reading ARL entries if search is done
Date: Sun,  2 Nov 2025 11:07:57 +0100
Message-ID: <20251102100758.28352-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251102100758.28352-1-jonas.gorski@gmail.com>
References: <20251102100758.28352-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch clears the ARL_SRCH_STDN bit when the search is done, i.e. it
finished traversing the ARL table.

This means that there will be no valid result, so we should not attempt
to read and process any further entries.

We only ever check the validity of the entries for 4 ARL bin chips, and
only after having passed the first entry to the b53_fdb_copy().

This means that we always pass an invalid entry at the end to the
b53_fdb_copy(). b53_fdb_copy() does check the validity though before
passing on the entry, so it never gets passed on.

On < 4 ARL bin chips, we will even continue reading invalid entries
until we reach the result limit.

Fixes: 1da6df85c6fb ("net: dsa: b53: Implement ARL add/del/dump operations")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 77571a46311e..82cce7b82da2 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2018,7 +2018,7 @@ static int b53_arl_search_wait(struct b53_device *dev)
 	do {
 		b53_read8(dev, B53_ARLIO_PAGE, offset, &reg);
 		if (!(reg & ARL_SRCH_STDN))
-			return 0;
+			return -ENOENT;
 
 		if (reg & ARL_SRCH_VLID)
 			return 0;
-- 
2.43.0


