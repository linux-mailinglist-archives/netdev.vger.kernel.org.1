Return-Path: <netdev+bounces-184439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FCDA957F2
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 23:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1A53AE39E
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 21:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F7321579C;
	Mon, 21 Apr 2025 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFbe4nGB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AF1DF72E
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745270926; cv=none; b=hgoYpnwwH55efHimjczdVETRiOCwKqhmMSdLnVyuOCSLpLcyd1AP+ltf3YtBC7KryI3ywtVCDXvI5zY43yP5tEptNsAcTMs6hPw3mbw+GhWWXRom26DMDPEliKqrcvB8i12DHOn3MO0DhFXYqjsxZeounDc8mwtTUhP+Xnicgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745270926; c=relaxed/simple;
	bh=cj5Ks1uWmBi3jvbXo7vmiWm0xiYdo/inZP+2yuC3Fpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YB7nuwYCk8UTrdxBQttqWV7Emvhw9Whahi5j+Iz+jjeWLKaHymzmP5B1uOG0HlAV0VDLKWNQ1hLEHzxRFTYqrAf+LhdR8TR+gn/buay/ThWbQJ3e733FRM0dKAd3RKcdl0JMSTblr17hLW8VdUVqQpzG82ysKot1o0XqHLFC2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFbe4nGB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54acc04516fso4714720e87.0
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745270922; x=1745875722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4H+pVshPZ+N3oOAe5R0RofSWaUDM4w267tTXN7y6tdQ=;
        b=fFbe4nGBU1GLaPrplNJVlUjC8mE4YvK01Kxp/j7TkGgbc/hgN7xaRC0xGaEmRbP/Lq
         qN8ZU4I4nuLEfzQvG2EgNfWsjLFNupxs8Pb6QlZWV9aZ8YAMFt/xCvzyIukThlLL0YoT
         EP29vf4H8Vr5ei1HNyuEd03Po9mudz5A0oq3xS0VDwoXuaFmMaSaz/aRqh1t+1PNzIs1
         K3aIKEuV1QX0LmgsrIDKCjLnt+xk+dsG/BQYu3a1FawqoKK3u0aQYVjVRfzE8/7wnDVL
         gSGZ73usAm8ktqpTyLz1uedZk+04NfFmx8DakOT/wVyF+4g+WXiTQvk1qkjSclhIOqpT
         uRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745270922; x=1745875722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4H+pVshPZ+N3oOAe5R0RofSWaUDM4w267tTXN7y6tdQ=;
        b=WWVgn570fS/CbURpWx99J52L/gHzKWQlKwZaqaUGPYVOeejj9OLpbjR0AZVJygDP3f
         8NXn9M1k/KDZQHQmGWyAc0x7E/N4WyGiZnk3s9lSRus4IsLGMtyJu5u1Bk2/3osmpkQ0
         M3SWgVeC2snzRvDJXO0G0qjpT407OwomXhXqmgShIiKSpZhbqQB9sorxf/BpYWOMuASn
         ljCfrrBx9a6F2oUwgzdbmzo+f+6nA4NnGa1YvMKqrvuE6RgASc0usd5hfu2/0vdh9hfL
         2/p7zC6REWm1DCJgJurgoY4IQO6V0WF4C48E1rBBHW+gml0dBYluqs0992bYIvbpjZbS
         1gEA==
X-Forwarded-Encrypted: i=1; AJvYcCUAboUqF5XQXxROwzhwsYP5sqhR8QrRFDtJjWQuQwcgoXO9mG5N6ifcVcD/dthZ9zcbED8r2Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwfPn5y4X9V2mip6PGjJw1i0uwMTc4/OqQbAaOSmjsZs3lkHs
	/7XF3Gyz0yERK1bUwrgIM39/HztfBwK3j0FJruQjZ6S+jucOcXBtAuKqlIMZaFc=
X-Gm-Gg: ASbGnctwpbEyJHU+sTB9AobIw0GNYm1KBBL7n96GMOoz9vg2dakw6BfxNqL65ls1vCC
	bwrQGQZWZJAeaPLPnhFHH2n78O+q78i/nQsLJZmUknmpEDg5bzbjw5Sgy6vFcArs+MDY2xrIRGd
	AWcxLiSE2eUNFOObL2+0cBjYScAlnZbKIZZlGB+odCTyqTjvjZO8vb8LEyVJdSAICE1AVnhQkXz
	Pal3X1znCWOpdtM6SpjCmFXNmL3hy9ODP01XNH0ghjSLLaJIoJ/xAW9Hi9xBTVC+6GdUjiirSlY
	7QReTlT79zBzkzzUlsuDkcdfk/kLego28vSSBxNUiW2lli52Yxf3hA==
X-Google-Smtp-Source: AGHT+IHrB5+Gs+5ymBeBdDO16MTL1evv43zT3u2uT/2TZTgDIF4MogWUfjyHq4H4fdDl1lCDD3YCTg==
X-Received: by 2002:a05:6512:2386:b0:545:f9c:a80f with SMTP id 2adb3069b0e04-54d6e61a370mr3927345e87.1.1745270921634;
        Mon, 21 Apr 2025 14:28:41 -0700 (PDT)
Received: from localhost.localdomain ([185.201.30.223])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e5f5177sm1032746e87.218.2025.04.21.14.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 14:28:41 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Aaron Conole <aconole@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] openvswitch: fix band bucket value computation in ovs_meter_execute()
Date: Tue, 22 Apr 2025 00:28:34 +0300
Message-ID: <20250421212838.1117423-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ovs_meter_execute(), promote 'delta_ms' to 'long long int' to avoid
possible integer overflow. It's assumed that'delta_ms' and 'band->rate'
multiplication leads to overcomming UINT32_MAX.
Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 net/openvswitch/meter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
index cc08e0403909..2fab53ac60a8 100644
--- a/net/openvswitch/meter.c
+++ b/net/openvswitch/meter.c
@@ -594,11 +594,11 @@ bool ovs_meter_execute(struct datapath *dp, struct sk_buff *skb,
 {
 	long long int now_ms = div_u64(ktime_get_ns(), 1000 * 1000);
 	long long int long_delta_ms;
+	long long int delta_ms;
 	struct dp_meter_band *band;
 	struct dp_meter *meter;
 	int i, band_exceeded_max = -1;
 	u32 band_exceeded_rate = 0;
-	u32 delta_ms;
 	u32 cost;
 
 	meter = lookup_meter(&dp->meter_tbl, meter_id);
@@ -623,7 +623,7 @@ bool ovs_meter_execute(struct datapath *dp, struct sk_buff *skb,
 	 * wrap around below.
 	 */
 	delta_ms = (long_delta_ms > (long long int)meter->max_delta_t)
-		   ? meter->max_delta_t : (u32)long_delta_ms;
+		   ? meter->max_delta_t : long_delta_ms;
 
 	/* Update meter statistics.
 	 */
-- 
2.43.5


