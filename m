Return-Path: <netdev+bounces-234889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A4C28CFF
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 11:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F25B64E3B15
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADBC269D06;
	Sun,  2 Nov 2025 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiWCd0hz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BE1DB34C
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762078093; cv=none; b=iXLDdS63B46WqsXsZbawQTRm3MIfkA+R16D0S3+OnlbKILECXQZgunlLPFqlF7DKEgVDonHHx7oLZbtvSM1n35lntnSVvLS+4ZDNy9BZSrdQwgdwdU5qQ16aY2f6TahRluZTZPjpXdpyN3vXBShACf+LHHGKfxsztw+H709aybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762078093; c=relaxed/simple;
	bh=wXuc2UT9CuddcG0oxar/aqtPtcAO08squo1ytkyonAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVniksNIj2xmAOPxRjwXIblPrVdV33hszr91/BltJH6gbI4r+Z2Otg4qi86DOGmIDVUVJrquXFOFVgyFpYzpxA+budLR8uQtcZwJtyVsihcOOTFk9L+EBVKYkeFlTUVHQQM3qO2x+s+WXecn4Ujne9XmAc4A20cGjB+F+QGxVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiWCd0hz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3c2db014easo760445566b.0
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 02:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762078089; x=1762682889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PuPuOipH4chf+0MLazXdxhlsluowLstIXfKlMSv4oE8=;
        b=HiWCd0hzf9nn3GNseVGulZ6bX2Fd92GPj679KMvHexI1a1Z/W2XKCuKkB/thnFafkH
         PLAISV50lozBnF8savhbGqaDy5fGWQCdsuSLR9leq0OglH4EkpO3KPrpW4XtZ0LmE1qu
         fvgjbjWqnVziLaIYlIe/v0ZSgjEvxtHVzau0FVUD+z1tNgPQjSNO0u6Y/kgn/FghR+r/
         jq0cRmU9C0/aqXxIgqk3uvjcgcSsacw8brv3GfMBLHyt8X07oE+cruciRjR5ysmP3EKO
         fsiAP+nR3pjzLh4HP+6XwrlvVuzQrNncnrJrheN7tNBOW3724xrr1+zr0vVRHejSy1wV
         fBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762078089; x=1762682889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuPuOipH4chf+0MLazXdxhlsluowLstIXfKlMSv4oE8=;
        b=vkXhBavsWgUaTVmmyabSBlGFVLLQZ8LfsbsCCWZWuoK5Mvry3E0U9cPdXXybLq5hZV
         b5VH6W69IlLQ/KqV2ozMLU2+zAknA8/s3eFiBfxMGzot+jImgWhv+2RbPJC6cZRytfxs
         r4+DN7pOFcA8jfFTdVtMd15c9tyjVFpcrelTNJ1uHZZ5PN9235fEcpkY6pW/DxpdV2EN
         CWqqqjG7YRAd1Dm9AhEPCgBUk5fkRU/SvaiLr4t0rJFvQ8PSLbk2Qm7mQSY+KZP9Sa69
         M/W0cug4WyxA9K3SIJZZwzv8q6mAa7vhv19gSdP8PeDcznAkf4QdmS7EL2lcBAqScwM5
         k8hA==
X-Forwarded-Encrypted: i=1; AJvYcCXar3kRJvH9DRWW0GPNE7cPpkOJCjWmwDdWJxx+NZiaeTuY1ci1lCYoObRSErFIBqKV76g4EVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZP11fzoy/bJBMH0xpOfjt0cEYFZFV1VBVr/3cAuMvNh5hcfuG
	frU/0ZVax2FgiaDvMEPM3uPbkCB1DbimnHfzEWyRD4pfYztDu0ioxTiK
X-Gm-Gg: ASbGnctsfbXjp5xPGXr4KMSI+xixPKeo//gB6Zqd2C2iLA/fDRXcJORh3weW1AZ429x
	MbZabfcKO3kVGeeKwzIoe0PY6nHPnBmf3N3ei+pON3oz0C3g9yIo7GPJzRYBPMMxv9Qw8a0MFrW
	MtESTrKYRFY53o7k4O6rJYPNDnVL8j2ZH7GF46h0XSl/TzaaKfIrqCAELmhzjIpPcIW5ojPwkLB
	BHXPZ6zzElLkf7Jjrc3Hp5c5Wq9PqWThaNVcCMAGQB/v1COQWRC0+9c7PYLWE5RvU3INWemPxlL
	Zyyaj6vqX4wRjYNO8SNToczxZMqunQK6JUoe8MwN51m7Ne8YAkLmUjsF5+dQ3SwJycLo20mteqh
	vZe2aPgbxlNY8AK3FT4XNAUUCvoz3jnI5d8Mdhf2JbWp7V+a3AzsrYEJ4MUugPWnBoq30Ft7wPK
	1A6gA55d4WKleOvNmzYPVBVRUH67Dlq9dinucN0ucFSoc6TulZT1ZX6z1Wvbzd+AF1LgA=
X-Google-Smtp-Source: AGHT+IHM0dXW1VRWqhRiVfcoEs6GQopp4oyXYkqGercKeVItyykRTOO9GHk+xGm71DB98UvYkBTNpw==
X-Received: by 2002:a17:907:ea7:b0:b6d:2d0b:1ec2 with SMTP id a640c23a62f3a-b70708315e8mr915496066b.54.1762078088750;
        Sun, 02 Nov 2025 02:08:08 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779a92c9sm703313766b.22.2025.11.02.02.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:08:08 -0800 (PST)
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
Subject: [PATCH net 0/3] net: dsa: b53: minor fdb related fixes
Date: Sun,  2 Nov 2025 11:07:55 +0100
Message-ID: <20251102100758.28352-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While investigating and fixing/implenting proper ARL support for
bcm63xx, I encountered multiple minor issues in the current ARL
implementation:

* The ARL multicast support was not properly enabled for older chips,
  and instead a potentially reserved bit was toggled.
* While traversing the ARL table, "Search done" triggered one final
  entry which will be invalid for 4 ARL bin chips, and failed to stop
  the search on chips with only one result register.
* For chips where we have only one result register, we only traversed at
  most half the maximum entries.

I also had a fix for IVL_SVL_SELECT which is only valid for some chips,
but since this would only have an effect for !vlan_enabled, and we
always have that enabled, it isn't really worth fixing (and rather drop
the !vlan_enabled paths).

Jonas Gorski (3):
  net: dsa: b53: fix enabling ip multicast
  net: dsa: b53: stop reading ARL entries if search is done
  net: dsa: b53: properly bound ARL searches for < 4 ARL bin chips

 drivers/net/dsa/b53/b53_common.c | 15 +++++++++------
 drivers/net/dsa/b53/b53_regs.h   |  3 +--
 2 files changed, 10 insertions(+), 8 deletions(-)


base-commit: d7d2fcf7ae31471b4e08b7e448b8fd0ec2e06a1b
-- 
2.43.0


