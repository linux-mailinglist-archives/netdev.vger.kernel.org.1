Return-Path: <netdev+bounces-197725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D438AD9B1F
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B1B17EBA9
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D820E007;
	Sat, 14 Jun 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvA+1w2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343D20A5D8;
	Sat, 14 Jun 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888017; cv=none; b=UFGYMVx6QwvJRSXr92yJg9W+UDZaXD5W7GNoAetV/rnAR89Jb+yKg7ez0i9rnRU95ysFCLuVs8r6DG1ev60yDyEmHFa3KLYmyBHeqxew5SzllZNpUM1KiZFGBzHiMXrKLnGcThlkBcEX7Z2XTHcSIHYF/En3dwFN+cm9PFVdnTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888017; c=relaxed/simple;
	bh=Jg+4n2zkm1Wb7nn5Uj/T96SQXwTLOnRWpCjgzX6pZcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8lVH9tjirPTd8sbsFA3q065yD/ices8PAdFC5bF1vJEyBAW6fdVp8AgsfOpEroodxoxu7nFsZcxGy+PfEM6TymDA4f+riWxz2uA2DOWbfSkoG3VpSIF3tKXbhAJX3WIahqT/pj3uBw93gKQtD+49F05VPh7qNKIjBPHXfmYVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvA+1w2g; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso23304135e9.2;
        Sat, 14 Jun 2025 01:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888014; x=1750492814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0TvRqql9xHjn+7eHzNDvmR8Gefl/j7dj40sw9VQTds=;
        b=TvA+1w2gXEvTYuCvQwzeomOMY4wHDqbEbL7jig9HB9P7f48anZxLQ1tM2LOUFepFDN
         F1NwTJTfCFTPLNfMPjuDLH2mKYofwWRPNWT+3bH/vXIvGc39B8JoOhT0TJKBFsTME6WH
         k+G+6CPFijMg5VIdjhANHN9F7gW3gJOGmFX/kTC3ZWe45kE01zGt6h8mknlvb/EfKo3V
         RcwVYWX8wgq15rq6Dfme4huh+vchjb1TcLgfgzYXamayK5O8Hmwre1tHGyMtsZ4Qj+Fl
         DqDVqdETcoZ6x8cpwiVLmv6TyICZSuhTClU1SzmT4cwGFJFQLII/oa+8WKL7Dae5NKYn
         dUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888014; x=1750492814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0TvRqql9xHjn+7eHzNDvmR8Gefl/j7dj40sw9VQTds=;
        b=m4cguR14lY/Oiw/rYPsL2YmuItx43pYnWsa1EgGtQDjN88QAuLtj0LhQxzmpocyHKn
         E3t9m6qNenZm7qxPJpKdZ6MjfO6+BOtogvRK/zNPHBm1onTo3sj6VgIG4bbJyvP0UOr+
         2Xxt2oUPoTZCD6D1GjlNPc4eokZ34ICMXt2yqLYTw7musMsyLbJQKSMx0rlR6NxWXC1q
         SrF7I3WIJo/DA1W6xhXowjt3jYiKy7p4PWDYQYXIhGK1eQsLVcICevIYtrCai+KhT7u1
         hygDpyyjFR2n8WyKT3i7CnxHCoPfeX29aAM3df5IeQyPRLDtFKjccsEe+Conhebo8EH4
         iFCw==
X-Forwarded-Encrypted: i=1; AJvYcCX4wvxnY/TfL3Qy7tQ/5LHPm/WlNc3Nux8mAeKKoat8y+VwM/NuqZ3vS9hYS6NB9qwhNZJr48Br5W6glkQ=@vger.kernel.org, AJvYcCXw+AVWIayEuhH7zYuL7jP6OW1RcXfMqsi7Qm/sQFPldXHVZ/06FN/yF6dEaT4kV2Z2D1MZR4cf@vger.kernel.org
X-Gm-Message-State: AOJu0YwXDJ1jR02GexgF2Y0HNboLQIezUbNVz3PdKjGfDQXgZu1tkHst
	nS1zK3fpb9mMO/SyMvo2H2L0MNYZd/gdoGxiOIURTjWOl5nfpQlRusO/
X-Gm-Gg: ASbGncs0jB+ev8+mV+FUZYjuuh+a/4D1ZvDEISzuJBb87+eL37z7w9LBOvZg5duMC3f
	ggpZDPf0G5FUukVXmmQQfF0JYll4gVyD8YyJDexPFzxiHBSsdoAwB+52lmHBs1hKYW/p/GCMERX
	B57kHbChc6PLB8PBp/VdkjdzclJOPm82x5X+Os+5P7GOJAQ4IT5aQOP82GrYmaqQn2nN2NTr5AZ
	wLE3GrXgs/TO0zSxj6P+8wTkmiMXaL1tmpcP9B0xVcu+wa1QVLp282bZqeeenR83GlWF3GtRUsb
	NKintjWQH9E7R04aabyn+7P7AlWRMwnK5K/IhOGTQPA6iBN82unzoYUQJZ3mGF1i1m89MvZm3xY
	EBj0agg85w7eDn/diWK6A/UxfgBtaWdVy2v+QOl3BVYvx3WE09JyKW/9A9xxWodQFzrTSos52Hw
	==
X-Google-Smtp-Source: AGHT+IGG5UVhv1L1iErZSEN+0avdVoZ4YdJO+ad0uSxodUSTzACt+JirCS7biIxIfgSKprwpgqbcHw==
X-Received: by 2002:a5d:64c2:0:b0:3a4:fbd9:58e6 with SMTP id ffacd0b85a97d-3a572e56e89mr2001968f8f.50.1749888014102;
        Sat, 14 Jun 2025 01:00:14 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:12 -0700 (PDT)
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
Subject: [PATCH net-next v4 07/14] net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
Date: Sat, 14 Jun 2025 09:59:53 +0200
Message-Id: <20250614080000.1884236-8-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
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

 v4: no changes

 v3: no changes

 v2: no changes

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index e4e71d193b39..24a9a0372122 100644
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


