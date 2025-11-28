Return-Path: <netdev+bounces-242508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 472A5C9117D
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 386F54E72FF
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6FD2E3360;
	Fri, 28 Nov 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWqegR3a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111592E06ED
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317203; cv=none; b=dtZb7D/WJM5maKbSbu+Xi4DJNfPgYUTPSxX1jgeHcfq5ku52Oac7K/pdKFdyqc7i1HRG23in2wlF3ZmJ+RUXH3tgAFVltScDTazUfoEPL+PFOQ9PWtcDKMP0EuJGBVLEpMidKxCckSBXVw0iPm52zoupdW3npPygYHM4BCzx+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317203; c=relaxed/simple;
	bh=ZXITNK4orXkHoe4Ya8LHW9gvkXoq8g5iqaLa1JHKtd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOJ05OtrtEacgUcQxIZFcHy+x2UWW+KvW2qgvoNa8U2pHFLEWEdspuSGagjfWPHNPNzDw3oZzrByOxoKzcQCu4eQp4Ls0HjI6+A6N3BuDhuUvIvUYB/otMk01x1+GLQM47PFKBygT6VGfR2jj4Xr+0Hujm35VomsBYuH8FswxlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWqegR3a; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7370698a8eso45979966b.0
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764317200; x=1764922000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1e4QIL1rNUNQDu2qhKzyqa3i8lBjekJrTGYyrwgBzE=;
        b=QWqegR3aDJA36fNQa84X7lTB7SbZ+G39hJDv8Fs2zhCTvhcfwaLH9tRE5n3u4Rr0zf
         zoJ1e++hlEq+582FLhUh0q62/igugCkmnC5G18RuDuArrkiNt416FFT4lhxzw3ZgsN2Y
         vhZ4nHeDA3Cthr93ASYawmNfkKlNxEQffgWEunoptRsB/rKSpfAjL5Jb69XKvV2/HnXv
         AWVoNRkRF1vVJT6UN6nvVRJ442e4B5rKXbwW5WwP24ndgoW6GEo4QJgTvujuMbDGy8Sa
         asE8a/ozz5r7nsrce1D8VCFkkQLCdyI42zPZ4jE/F3lPcM1uoKRi8eBVVD0ClpdtRbQr
         jFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317200; x=1764922000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R1e4QIL1rNUNQDu2qhKzyqa3i8lBjekJrTGYyrwgBzE=;
        b=DHRGYDxPFYa3VxrqnPcEHcIR36Rg8mUXbNYQV36qRDkbkU3GrmgiKLNoDFtI8Q6OxE
         Vb2qPzaXKnL6zjzw2KJnz571rXKf/fB+awB5wtubq9lMgDB8tVdCG8Tf2gdKHcQe78hz
         UQzeCVxrBACqmoJfWjiOVTqUkBZysJf89Mm38Wr+e1letISOxyr/JczjCZfDijpCApYb
         uvrVcxOoRldWd2CoqV/zSQeGydbwAJL+tvQlciz6c5yRb0v1cCasefAMKERQr07vtVNp
         cb5Nv8ioa/airBqB24yzq0QRUiTwDgZ7OvLcG99TasFkyT4x0v8EZexKx2Y9ET6NcBd+
         DbFw==
X-Forwarded-Encrypted: i=1; AJvYcCWTMUNc4tiw0bNdZQ4puHNNRlPFmGGolcUVWpPC+F1rKJzNKLQfNXaz8K6c6vMwED56KI7TCXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6YTcJ9hWHXl5LgB6TZHRy4OAe4GHhk3T9PQ5Zh1gVhVNjdoh
	BwHoxrVb/hfccz/4UW3S8JObfRmSJ4NrRl4zgecRZnFjXXKxlfPiWNBE
X-Gm-Gg: ASbGnctjmZKas+6AyzJDcgJWcEh1NFxXKT9y0Idz6hKmV2F+Ne+kQ8IR0teFOxOH2oj
	UIfPS0d7mI6I9TBTLdRwjVYR8Dd320HbVeRCxa3qSU/U4kZ6GD9Z98kPBtBlN9EWof7AEsXcRzi
	sqYCsn+4uB+ES61ABvo8Q2YdQTFThZ8ScSkViaxFvW1r9kznpk9txgIlMlBC6spQNHD1+X1RW8T
	Q8RVJ7kxuYXJsvMiclOxnirpcbmkQT5QIlxWiqXMeqrlyXXQQZ9b/2fhSuHht7QFX5U2ph9Nhc7
	Z1aAJkmO1JXNsqYpGS+1+SUPXh8eMBEpv5ZItooe71ITNgziXGA4ewPBML6MvESYkyNzal8+WKj
	tUzZrBWLnX1o0cqCCzRkaH6K7LbtORE3jjNswUuRL7PhNIagUWYURcX1AjcWE7xcQXO2Qb/VyHA
	n1q40fYD4wapKeYDpnibnuciCNiu7AW4H4wQT+0tew2frwAvB1VT2Ug09jQ6SWeqPJ/ZY=
X-Google-Smtp-Source: AGHT+IEpICKNTFtLVeV5jlCF/yBTwDY+shAqVIBuvL4tQMNocGn61vvL7NPOKUZP43sOD3JS6+9YJQ==
X-Received: by 2002:a17:907:1c28:b0:b73:3ced:2f59 with SMTP id a640c23a62f3a-b76715dcc1bmr3064602466b.27.1764317200109;
        Fri, 28 Nov 2025 00:06:40 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a4a652sm378485266b.65.2025.11.28.00.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:06:39 -0800 (PST)
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
Subject: [PATCH net-next v2 2/7] net: dsa: b53: fix extracting VID from entry for BCM5325/65
Date: Fri, 28 Nov 2025 09:06:20 +0100
Message-ID: <20251128080625.27181-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128080625.27181-1-jonas.gorski@gmail.com>
References: <20251128080625.27181-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325/65's Entry register uses the highest three bits for
VALID/STATIC/AGE, so shifting by 53 only will add these to
b53_arl_entry::vid.

So make sure to mask the vid value as well, to not get invalid VIDs.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
 * added Review tag from Florian
 * added Tested tag from Álvaro

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


