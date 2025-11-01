Return-Path: <netdev+bounces-234831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631EC27BBE
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 11:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0E13BED9E
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91062D1931;
	Sat,  1 Nov 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTJ3CWKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281B2D0C97
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761993613; cv=none; b=NNhWZ+8eRJoKpfcfir/HZfw8/3f7ztwLRC1JLQy7/2nNrd/W86S8TbV0H2Wb2nbrBpBOiYUfvnFYOP6YzLc2tlcfdh3upS5rmJna5qDPTb5MbghykXMhBvayRR9E9H8p+wJyrAHkTYdRuLrUn1tKnwBYKug2OupIltRV0w4JlFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761993613; c=relaxed/simple;
	bh=rMXiFLvpQUT4YjMhrcIXAAgicUEHEVbOsokr63okOGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmnBpy+LRgly7q0RNuBzQ611udcati/02RTPwgODZGODCWNJRDTLp6RKdihNHkZvoUpjuV/zerYd+C0YuwJUbI4o5y8SJOHJLemlhqwARhWTFMRl9Hg1dFbE/80vlMkVI5SC/4ei1aM8/RZOSyoA0gw0KOHKjhOhr/x4hi2snN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTJ3CWKQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso5532858a12.0
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761993608; x=1762598408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HSPS4XoS5xGMUr7hcQifmzLnmdxVPw1IDCXF3+FoJP0=;
        b=XTJ3CWKQ7FOaVfOLvcNf/LZzFXiyLajrCQEH/LC10bHQ/RfNFcSlEHaKitZ2ZIbaF8
         FDVJlqQUtZNpd7h78wM/uVoXEcNZgnjhovkeOYAJgt1IMZ765ZcbqWHVmejLqQQkupo3
         6TPOfbhDZcSmQLxSnSBlG7xVSP2Hh5qSIT5P/vTXHopUMQmiDj23rV9RJCIKhtiKiGMq
         SqCzGWJ4rwEOu3wd/WnygPHWENff+vQkpVn6xJLpon9FPG7IJRn4XYSsid/gQ55LZahn
         Ju8JD+OOOdsUH9+rMz6G5Aw6Le6j2W5uH0EbJ3dg19OatL4dQ2IrzWMkY4crmuKqnijp
         gV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761993608; x=1762598408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSPS4XoS5xGMUr7hcQifmzLnmdxVPw1IDCXF3+FoJP0=;
        b=OnYEwJ6lCuAG4y2Cga2D3s52Jp+tieWjLFxyQveUQPsHFcJ6pjnpmb+MEDw3fxNjPY
         0PmrKMSxQt6ysOvPc/10wXZmykxG3C8t02cl2NnhCj5E2KZvofVzo/GwdARjZHDJL0ef
         vEQ6QWiaDF/XeGG473ed5dDWcn/reSFXeWMevdX8T3w2lrYNYL9TpISfNokusgDEh0+v
         q1MaxogB5w3aDDY5h1+7WeLtFbAp31lEMLlcFPaoPtC5ixr86RaKmlKucCqLR8WWA9bt
         8KB6P2IgbL69KfCcO7/ls83Ol4dE52gsq7eJ5Yi9UeBlsK/bePy+0x9U73+wEVvTUgu1
         OHxQ==
X-Gm-Message-State: AOJu0YyoHHlSH/0Xjcz7DUnqiIEG+nANdzzNLCzIE3i/l7/TmSRpFXj3
	1c35QShdgJL+KtUDP8sjpD2T+s6brq/zco/epEP6CFiI8RP6iCNcRKZ7
X-Gm-Gg: ASbGncsJN7pyopGiap9y0hIwgPRT9IZtfhNixviP7pfcwdBclOeCcKAuGMFA/xRbqd4
	pBWHiU8VZXg+jqFfkIPpRN01n0n/WGKlHI3Jp38eIWtXvIHEDIfOBOJ7Udsw0CM7SRUe//4M+aE
	J4DjfusSmhBxuYcHZsvrgHDJCL+J6IV9TP7DaJBoY7KOYNJAdpllv0caqQ6kHvOKpWVlYXvYhb3
	QFBt+E6H3eee4kiQ7HfacVRJSXSsNLNhT6pL3zQJe1kHsx8LflctdQmHeDBxdfywj4wOzbLaU8q
	X7KjroZd0ogJ9Xo5q2mMUaZ9ogLnRgscj0BqsSJu7AbrlGBloZ0iVywBDo3x1QIH1VrqOMYWptF
	1u0N2qz1WhcZrEyvUIvTVH9uxbud3ixW5BUyDGnU7sIPUzKGqOcXLr/pBv78EYOZuZM9mZb12jM
	OeSipxjKwrU8i0L6VhiGxPiVZkNVaccKyIQsI5lSc065HQvEoabJThTPYm
X-Google-Smtp-Source: AGHT+IFSQkmcG1L4146AF/e/lAuoEsq/7sNCYg5IR+3oTzTE+KGBv3Cj0TZ6j67yGbbsHvpaOiZ4MQ==
X-Received: by 2002:a05:6402:2350:b0:640:7529:b8c7 with SMTP id 4fb4d7f45d1cf-64076f710cbmr5615546a12.1.1761993607870;
        Sat, 01 Nov 2025 03:40:07 -0700 (PDT)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b438b05sm3751508a12.27.2025.11.01.03.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 03:40:07 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] MAINTAINERS: add brcm tag driver to b53
Date: Sat,  1 Nov 2025 11:39:54 +0100
Message-ID: <20251101103954.29816-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The b53 entry was missing the brcm tag driver, so add it.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20251029181216.3f35f8ba@kernel.org/
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0518f1f4f3b5..92e9cd1a363b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4818,6 +4818,7 @@ F:	drivers/net/dsa/b53/*
 F:	drivers/net/dsa/bcm_sf2*
 F:	include/linux/dsa/brcm.h
 F:	include/linux/platform_data/b53.h
+F:	net/dsa/tag_brcm.c
 
 BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
 M:	Florian Fainelli <florian.fainelli@broadcom.com>

base-commit: d7d2fcf7ae31471b4e08b7e448b8fd0ec2e06a1b
-- 
2.43.0


