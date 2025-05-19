Return-Path: <netdev+bounces-191594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C018ABC5C4
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D5816BFFA
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224DE1F153E;
	Mon, 19 May 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb9HQ7gQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB91367;
	Mon, 19 May 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676782; cv=none; b=V+dON6wFhOYBZPvzAisRArV4/Cwo1+P6OU2Ru348prqgPsrBG6T9YELVzrChvfqmTb/HXmI8zZX92gXVeTqc/pVg+1ZAcuEox+hTM0M1fenrAJbPqgHfw9xT4FcJhMB0FRWi4C8BZ5YpsY6ZWbbqfx8upqeUmBYCQMQn2rFO/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676782; c=relaxed/simple;
	bh=kQEs1IC/MKY7RD+4fBgEPZRs06wUcxxMMR6sXfKv3XA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCsjhOzdXKWorZGoKlwt3ko70JrkesfFOb85UfpAxBkq07NTx2Bsa+TaunzJAv5I2IHppuwpJEfZN8ycjBfvhThBTHx0tA/EpMdhD8D7n98EaivzwwZ7AjoCVBvzgV3zkUfaTs7ApcE0OJMKELQa/g5YrfmNADexUCK1a8Aj3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb9HQ7gQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-601609043cfso4980037a12.0;
        Mon, 19 May 2025 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747676778; x=1748281578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Imcv13gbBYtuhYi2Gru3C3uE7/2zlMKQ45Vcbv1y9oE=;
        b=gb9HQ7gQQ0jYWh8Pa1JcTEAJ/I97KhDyLIRHadiXn72M5PCaOfoC0if5O/gRVfRUUi
         PWqT+xfaK8jdUA9MC2ZbEv36e8597HYNiVmZbCnGwEKxzgCegsAcFnN84QMnAQokrGRv
         xD8JaD9V4Fjwen7xIKNpeAVShN3gYSUgng3A7UrSPMWsZ04DkwV7y+JwLRELK7ftW/Zt
         a/pFv1+4qDFHyhGdFyW5DqYY/mW6Cuigz5iAy7Opz2O3zBUQL0ViOvaQcHULWPqqgLO9
         AEFiUWVY847U3cMrgqj3e67x9u/sxuc6yZ2IHJ67nu3SWgtbfZn6E5HXennL/k7E7Dfs
         bzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676778; x=1748281578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Imcv13gbBYtuhYi2Gru3C3uE7/2zlMKQ45Vcbv1y9oE=;
        b=oRKbfTXA+coM3lqiXwTbFmmtodfb9txE/PKngKAf1asRzV7sa10rKFbSYZRnBXFVB3
         FbLw88EekF0sJal+bAa2ipCCsb209AH6DwRSiHTryf95zHRWizGicUP3xsuTk+xIF3pS
         lsrezOPbcmor9HpfE0gC/KcerND+xt2KEGPwC43WB2DklcZVhf3RwXD8XfYwZrnrn3TX
         BQOphnBdJdPdUNWcTSNt9uw8/lIO424Zxu9E0ZAdZqPee9Sj+eM7VyfWe6LNhy2bT5Ds
         XBVorQO/T1KRPmG5aBODn9obHy52BqvsvA0VTp3yCIy5cdbEOCzJUXjvdagAL2iGsA8v
         cEMg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Igkn+aWU+YAEvBlu8wNj4nvC5ESTLHG0q6w5wj08Tl5D3HYGPfSsRQhnY4WARJx4fyiAbVjV@vger.kernel.org, AJvYcCVHxSmP8tvqjb8a1mTp4la3B0fPV+T99pkA3g8smDUvCeRjS5b2Es7zw8oStu2rru0r3IFxLLgyRULdAGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuD/nyVRMCy/SlK2/JzKE8ECOGjA2gK9eZnrrDFp3Tyu2T7MML
	boWf0dZbxLJ0E/0rfXBnP8iTcF++LzXMJwZ+Gm8rWya/w7HKQRDEqHPZ
X-Gm-Gg: ASbGncs4kPmsSZcN88gK+uZ5C9qR/zpd6bMV7M+yqLeLFP0j/zO9QOhUgl472aWGSk8
	Ct7gqC4g3ag8gKlGeyw2YP34Fo2j36R9wb/TE0SXkiUKrdAK1vPGFnrfZbeRfXcNyciCbWOcE+m
	QDnvabBnSFy3+XpVqkXDwx61T/1r9r0bMubVfJeRsOd29+hKziPcP2BAMlt9gfItPxdA1wPFEm5
	xElbAXuKT/6oAphBsJFpqGf+pMLfo2u4I7wFumSQ/Ko96uoN5m1T9TCbnxbE+W6cc2D07vc5IuJ
	zIbTvaYUN9gDg7ewEiaeOw1M1diJZ7OZyhhbdPDs3XSUBmz0v9x0P3awj6FRk6Y9qSzouW+vY2J
	rsoKfv/PpvDeatwAiJt7nrRpLpfClm4U=
X-Google-Smtp-Source: AGHT+IEhgWL4mHOC0RnpPdDZfjbw/F/26DLo/Fo4wk74DYFTE4W/Q3CE+YT1RQWoIN59MU8INqWDOg==
X-Received: by 2002:a05:6402:50c9:b0:601:a681:4d5c with SMTP id 4fb4d7f45d1cf-601a6814f05mr7168452a12.32.1747676778136;
        Mon, 19 May 2025 10:46:18 -0700 (PDT)
Received: from localhost (dslb-002-205-017-193.002.205.pools.vodafone-ip.de. [2.205.17.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ae3b80fsm6076978a12.80.2025.05.19.10.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:46:17 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: dsa: fix RGMII ports on BCM63xx
Date: Mon, 19 May 2025 19:45:47 +0200
Message-ID: <20250519174550.1486064-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RGMII ports on BCM63xx were not really working, especially with PHYs
that support EEE and are capable of configuring their own RGMII delays.

So let's make them work.

With a BCM96328BU-P300:

Before:

[    3.580000] b53-switch 10700000.switch GbE3 (uninitialized): validation of rgmii with support 0000000,00000000,00000000,000062ff and advertisement 0000000,00000000,00000000,000062ff failed: -EINVAL
[    3.600000] b53-switch 10700000.switch GbE3 (uninitialized): failed to connect to PHY: -EINVAL
[    3.610000] b53-switch 10700000.switch GbE3 (uninitialized): error -22 setting up PHY for tree 0, switch 0, port 4
[    3.620000] b53-switch 10700000.switch GbE1 (uninitialized): validation of rgmii with support 0000000,00000000,00000000,000062ff and advertisement 0000000,00000000,00000000,000062ff failed: -EINVAL
[    3.640000] b53-switch 10700000.switch GbE1 (uninitialized): failed to connect to PHY: -EINVAL
[    3.650000] b53-switch 10700000.switch GbE1 (uninitialized): error -22 setting up PHY for tree 0, switch 0, port 5
[    3.660000] b53-switch 10700000.switch GbE4 (uninitialized): validation of rgmii with support 0000000,00000000,00000000,000062ff and advertisement 0000000,00000000,00000000,000062ff failed: -EINVAL
[    3.680000] b53-switch 10700000.switch GbE4 (uninitialized): failed to connect to PHY: -EINVAL
[    3.690000] b53-switch 10700000.switch GbE4 (uninitialized): error -22 setting up PHY for tree 0, switch 0, port 6
[    3.700000] b53-switch 10700000.switch GbE5 (uninitialized): validation of rgmii with support 0000000,00000000,00000000,000062ff and advertisement 0000000,00000000,00000000,000062ff failed: -EINVAL
[    3.720000] b53-switch 10700000.switch GbE5 (uninitialized): failed to connect to PHY: -EINVAL
[    3.730000] b53-switch 10700000.switch GbE5 (uninitialized): error -22 setting up PHY for tree 0, switch 0, port 7

After:

[    3.700000] b53-switch 10700000.switch GbE3 (uninitialized): PHY [mdio_mux-0.1:00] driver [Broadcom BCM54612E] (irq=POLL)
[    3.770000] b53-switch 10700000.switch GbE1 (uninitialized): PHY [mdio_mux-0.1:01] driver [Broadcom BCM54612E] (irq=POLL)
[    3.850000] b53-switch 10700000.switch GbE4 (uninitialized): PHY [mdio_mux-0.1:18] driver [Broadcom BCM54612E] (irq=POLL)
[    3.920000] b53-switch 10700000.switch GbE5 (uninitialized): PHY [mdio_mux-0.1:19] driver [Broadcom BCM54612E] (irq=POLL)

Jonas Gorski (3):
  net: dsa: b53: do not enable EEE on bcm63xx
  net: dsa: b53: fix configuring RGMII delay on bcm63xx
  net: dsa: b53: allow RGMII for bcm63xx RGMII ports

 drivers/net/dsa/b53/b53_common.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.43.0


