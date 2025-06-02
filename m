Return-Path: <netdev+bounces-194653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A28ACBBD4
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8768E16E4B8
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE891A3150;
	Mon,  2 Jun 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj+VrtWh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF0E4A02;
	Mon,  2 Jun 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893201; cv=none; b=Oxc+Ncw+JbhL/bRIQ+H3hbwPWHJzcut8byDKg68SLh5QSVrwwz5SqVjgx0e3JRAi35EBcmHmZoWO+LIDlV+wLQipL2RCQN1XG2u3yqZifuoif1/jBY+14PvHsENvcBdnLHPJG6xHDJL0bxnv/ygsPSgn+yMan1b3Wnp4qzdHWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893201; c=relaxed/simple;
	bh=GT1zv0fCygY9w6Z9DXyOtDB40JgDxHwzHtGfZNS2Ngs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nX6NNvS+UeftQPR+Cjgaa2E90sKSNBi2hn6adiHh89Y11+56tu12/NW/4hXRAxaba74Uvwl8hlhJh4HmCLAlrKZoga8mJaHYQHe1c/U66+BzxxfLoxP0Dn9j23enwdB44OezcmBlX5kHZOstqMWNTONNnlpe4W77HfFURwT6Fmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj+VrtWh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad89333d603so932349166b.2;
        Mon, 02 Jun 2025 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748893198; x=1749497998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oBRyf5h+e2S/sAJwDICV85vmseV9SuQfSptP7Gwtakk=;
        b=Qj+VrtWh91z1M/qAm49PFP3VyCC6lHuRu+YqVu+F2hCeupIFDodfpCpmi3IIOrHK12
         qRfET5RKic7w8pmzUATGqsEyCVbn8v+xrwOWilMCZa2lRVz0+cdLOQ7A1m5p+unyIUse
         4omdXf9MiVrbQTqt+BHjKDM/bPmyjPoKvqWcm78ZuE+C0EH8Jt+yjOEu1V6n6WIayyIo
         t+tL2WI238tSJWrLERqg7X3h9GOBlGwxTAPlcIiz696L2Dl45ar+O6k8CRudxfuvNtIi
         gpTe9D6rtHh74Yei2RH8qHYnRO7X0E3mTDq5Mqm7idvv1VaoVI5T5m8Rph5v4ogT0Svu
         Y7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748893198; x=1749497998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBRyf5h+e2S/sAJwDICV85vmseV9SuQfSptP7Gwtakk=;
        b=sKU32P8gkJEcrEz9L3uvExfzlDARp8P055hMxs6jGJheuRiS6fq54vyUmAwfup6jW4
         Cvhpl0rNCxgIEMDwjonZLr+tdsHhHw2Rm2QfPbn1bXh0EUmRsoezug4Ty7jiZguuaI+F
         7J/j+SI7gKUczsVzqU6yIUJMyrWJraJYS9XIn6e9br/dfbWfJS+Qlzh8xfPnomLpvKNu
         qx35j9jUhqJq7WP2L1HEg128yHmkgcSmATY4lT+iK8CZ4zqCGlj1+2QQXNZrIEnD4CRr
         NB2/d2bxmF2inZ81jJLOA3tiMfGUsizaphjJjJKihPCK8PtCpBz1XBkvt3o4R01I7Kv8
         wW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCURvVyjWmJn8GGldtwICwyHsFDVmirJMtTJ7uwtejkzYLgrYoMs6XiggUQ7vfzM1tQgUsI/Yqd2EXpXqoc=@vger.kernel.org, AJvYcCVcwxTeflHjVHPsEJAJ/6lxx+hiCVmaVMe+YAED6v+7xI0W466P/QTco00+h8CpyMsOtytbVJPi@vger.kernel.org
X-Gm-Message-State: AOJu0YwvT6hw82DO2agFgVl158fbuaxrZ4AjtssXu9CmgD6VFtqLIVml
	D4K5IXCzk/zTVvemyAWRWHwSgXECA7IXKV+H7x/yAHUsXogwT/r4e8ER
X-Gm-Gg: ASbGncvFCg5C9ZKIW+fs/gRgB36OXAz+KYovkEf0KqHHzxMGI2ZPqYwacacbulDnIZB
	CxcWIh6ma0QmzgwNiBQTh23769V6VXQHafDq4+s/+B6o9Im1kIHsUpC+MHEf2yATBI5viFxP+jK
	klKuaLYxC1FI6m0hA8M+VnyeF49guvEn9kMsXkiuAvFPd6oiRISkvu+Gv7jlfyBxZ3/AmqE7HsP
	r6GJAXy/X9dpLnCnTf/lxWCVURpCcCW6fjKBj9EIxZstkXPq5Sk1aucCs7NFh7OQmOWXQtMCx9h
	/hvT/xpZjE9i8+LqGjtWQESc5xDjPATRI+Fwaj19p1KQqJuPdeddKOg0ShQpRKlmJZEklP+neFj
	CzSs3+3g/u/1H7Jn0kiDl9/6ykVH18QE=
X-Google-Smtp-Source: AGHT+IGw8gDWod663cW7nH3VrVLoUwZOVOvyyd/bDS2oBb9Q2UptfpFUKwPecHLHFmh0lZQ8vfeFeg==
X-Received: by 2002:a17:906:6a21:b0:ad8:a935:b8f7 with SMTP id a640c23a62f3a-adb32248c07mr1434448566b.12.1748893197560;
        Mon, 02 Jun 2025 12:39:57 -0700 (PDT)
Received: from localhost (dslb-002-205-016-252.002.205.pools.vodafone-ip.de. [2.205.16.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5eb54d24sm833535166b.123.2025.06.02.12.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 12:39:57 -0700 (PDT)
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
Subject: [PATCH net v2 0/5] net: dsa: b53: fix RGMII ports
Date: Mon,  2 Jun 2025 21:39:48 +0200
Message-ID: <20250602193953.1010487-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

RGMII ports on BCM63xx were not really working, especially with PHYs
that support EEE and are capable of configuring their own RGMII delays.

So let's make them work, and fix additional minor rgmii related issues
found while working on it.

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

Changes v1 -> v2:

* add tested by, reviewed by
* do not enable RGMII delays on bcm63xx at all
* allow RGMII only on RGMII ports, not cpu ports
* prevent bcm63xx's CPU port from being configured
* prevent DLL_IQQD from being changed on BCM53115

Jonas Gorski (5):
  net: dsa: b53: do not enable EEE on bcm63xx
  net: dsa: b53: do not enable RGMII delay on bcm63xx
  net: dsa: b53: do not configure bcm63xx's IMP port interface
  net: dsa: b53: allow RGMII for bcm63xx RGMII ports
  net: dsa: b53: do not touch DLL_IQQD on bcm53115

 drivers/net/dsa/b53/b53_common.c | 58 ++++++++++++--------------------
 1 file changed, 22 insertions(+), 36 deletions(-)

-- 
2.43.0


