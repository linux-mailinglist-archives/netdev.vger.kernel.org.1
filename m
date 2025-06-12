Return-Path: <netdev+bounces-196846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D310BAD6B08
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA003A7880
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68856230269;
	Thu, 12 Jun 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIIaXuhk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FAF22E00E;
	Thu, 12 Jun 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717482; cv=none; b=CKO/NWAA8QSabDs3lplyB61qWLEUwREMkAb9XQNKePPJuECYEFHZraAaLSOiDX0pLoS0Adv3qqM9SXYMAemCxeNRjjrLas1AxcWrtlKxPTFXpGGaopym2tNhqKg4GAdlUOqyHZJwAGnLHgX/+xBw55zy7JuvFzxXnSfbYDDkur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717482; c=relaxed/simple;
	bh=Q4v9J26HZdNWwOGNTpjpEMqW9J4W3sJ8tZB6LBI16RA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4CaVX6zcaVy8e7N/6avfH57QvRz5fzLKx4cM9EaaW3ILJqxN/zwR6uq3nF6eA3td+fikj7QorR4E5Euj3T5pVayYXo/CrAeI/7gAI3BiHe0pCIX7qCSiSc9R37c7R88ZuVRL90RjzjMSmh9N63G+iYGLQ93gsX7MM91blJYuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIIaXuhk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a51d552de4so450497f8f.0;
        Thu, 12 Jun 2025 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717479; x=1750322279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJzX2R2KfTeXXlJYQHYgRh4q4thsZ383C0wvsVo42i0=;
        b=LIIaXuhkOd99bSdYMSOtpGYRTOjbbbEMPni6UQ3hMovTV53WF5XnmVnGrSjc2pEXhj
         EEP79IJAm0Ig8Rn883XAnexR0cP/uyiMyKPhGuudopgmJh73LTMpqvMukYpby+vafoP5
         usMrSNecKpmgPTaBVbLd+DZeVWIOHcvBGppad3F8sf/qorhhFee32gqt9lfhMK0A3v72
         yFjWSLHdh4+wvpQ3mfDXlefHGGce8Z+hHGo3JWtEqUy71lebHCe50NigwlCoXSC+5NXt
         3BCz62ZX+5rhg6AdwDTsaKyXk9rYVCVwscTpM5eSXk8vuL+Wd4ZyG7PVnrvq9stj/iwB
         sWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717479; x=1750322279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJzX2R2KfTeXXlJYQHYgRh4q4thsZ383C0wvsVo42i0=;
        b=XZJ43FqPKi2R1bi30c6yN9JevRmGvk5FyJEcMAdsj1JcvMF80FNd1wkpC+9DQSEkyp
         xF9f7g7YtuOpZfOgvNjb2pXsycNGgkA62qmXMGwYyvXUXyEJnqTyNjWiybgCTCOYzOyH
         61bDsGGqmIGH4b4Fy58j0TROWmh1F12GaCp8mkS6yJbnMqc0oENlIJD6OcP/Jk7l3mu+
         mZBsJkH+wT93ZyRyx2Y+i2odhoPh9MRpBOhWuOoZ87u7SLHFinUi1O2zfRjVj2DbhTy+
         CRtLThgk36sAowW8FjEKBluUOqpLWdHgH4/6sh5gTRDocGC2CqHeYukHZBYQ8263BXfu
         uFTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVD4kCvx8udBA4xL7DXji7f72qaJwkQlKOw2WFklLLCskZH6HLokK+TGCcyeGxlYojgEu0RaXF@vger.kernel.org, AJvYcCWpL19JQlQ54Jczs4KL1RZmxRX7ISdsw9/JL9nOS2nN/aOOT9+YeFY/541IeUeTsxe58fksbRVDv4bpfwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI9Y3bVznC/DonUz/A0OdfWOlu3YJA6Fdz5JWitDf2TNEM+2/w
	UgU3yHwo7ad8u0WzJcdMNNdwStJrrHSi6QW/d//8NDzgEF88DTA5QbFJ
X-Gm-Gg: ASbGncvUYesalaFlse9HBS+7r3KKUo5yGhzlAw5YlKGoy3BNiRPGaR27GsciJ2PoC0M
	UsszM+Wc1Ns9Qn9ooZAFAkJGmLbl3dk0udckO5S3h/MbZ+4wntn5egHQ0vULdVYOlPUelK7HWFk
	dEPiwKCoj6edqVx0dgqoD6N6WqoPrQWSUzgeneJcduWnRRlPxzzaopKqqa+Ir2f8iMFL5cgK56I
	0E59wSFKpNNPyXCZX7RlVbWNmH/sUisHNnXJhn/oZxU+PA4T+qpePv743xSFVV7DCL7dh6XmvFC
	3ZM4S8PQsEaqv/eVLsrnTwE3ginBJvfR0Rnb3Lwu9hwqFQ+dnJHTz/h90IEbU3nGevxhrHDLqhI
	8rt36snyzF28qZZHSDh8LmgoMR5IUKM1n4Ydypdu9dQ1yv0XqXSMJ55qHraL+IEOuVz6MTdmFmE
	RKDQ==
X-Google-Smtp-Source: AGHT+IFAkeuUz2I+r+Oceqeg8mNB5CqTuTR+pyfoY+U4k1Ia4uVVMgO+5yP+6KCEx5KQlcPS4z/Wbg==
X-Received: by 2002:a05:6000:4284:b0:3a5:2fe2:c9e1 with SMTP id ffacd0b85a97d-3a56075a5b0mr1888946f8f.30.1749717478914;
        Thu, 12 Jun 2025 01:37:58 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:37:57 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v3 07/14] net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
Date: Thu, 12 Jun 2025 10:37:40 +0200
Message-Id: <20250612083747.26531-8-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement SWITCH_CTRL register so we should avoid reading
or writing it.

Fixes: a424f0de6163 ("net: dsa: b53: Include IMP/CPU port in dumb forwarding mode")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

 v3: no changes

 v2: no changes

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 4bd8edaec867d..b8fe0b24a8341 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -361,11 +361,12 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 
 	b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_MODE, mgmt);
 
-	/* Include IMP port in dumb forwarding mode
-	 */
-	b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
-	mgmt |= B53_MII_DUMB_FWDG_EN;
-	b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
+	if (!is5325(dev)) {
+		/* Include IMP port in dumb forwarding mode */
+		b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
+		mgmt |= B53_MII_DUMB_FWDG_EN;
+		b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
+	}
 
 	/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
 	 * frames should be flooded or not.
-- 
2.39.5


