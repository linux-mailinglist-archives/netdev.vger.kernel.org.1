Return-Path: <netdev+bounces-194493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C4AC9A6D
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 12:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899A41BA2B9B
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D08239096;
	Sat, 31 May 2025 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI2i9ajm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FCFEAF9;
	Sat, 31 May 2025 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686395; cv=none; b=O3HUJDEhdK537li17zgtEP/2BPAQaUe8UluZj39Nz2VKI9RkkDVa2CZLJXhFLYJujxYh/Yr+9KmG9UWGPc2CyN4rKgkQxXEpu5Hf40UW7X4fV5DOX6JEyhkkwmww5EwRdeFi4P6jPlc/giEOQ1u/6L7o9JKZRwO2Ca5qd6hrAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686395; c=relaxed/simple;
	bh=fE9rjcOe73GczV4f3iFeM7TbM1yMFp+vz1ozRku4LIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HzrzQWHVXq5udoZAULST08WNHLT4MEEFhgzM65dJNTCgfWZReN48uwchakGLbKo+wwZ3O+k75d6bv4fP+5HRnKBgNtEKTD7V4uVg3rK+Qbd6VAWLdZmGfv/V6gMXPJQ48R4GJYvU0Beg05kseZ83Uhxpl3KH2Jxyf2egJtP79T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI2i9ajm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450cfb79177so13474085e9.0;
        Sat, 31 May 2025 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748686392; x=1749291192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQyDzOUbw+LDtAyftP1KtxZK0csZCuFuzRG5f8sdr2M=;
        b=KI2i9ajm5fonXYMYcOdLHRK44umKBiKvpQOf23Dmv8jsqOJoz03XL8qGzlMEVc5zAJ
         DF1KH5uXFcseLljjnNMqZnkw1fyPYaq3CYzu47Fp2A1WjChE+ib2uy3m2H+QTIVrKziB
         ilF070weQEArj3g9E70sAd+zMjpvXJpCgD6hjOn03XvYqNkMel6G03YOSure6mTzPeq/
         2t8G0QFAG6IOI1LqiF2UaqGVxJ5VlJASoqAenjk1bydQfpG+jz4htOl55aqOwVXe5qnc
         r0uls/Sc9iw6kYDAX9FplX9jQz1KO7tDtx4Fqqf8UMfRNsRBpv8bZbzpxjm2lPiFnm8A
         AClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748686392; x=1749291192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQyDzOUbw+LDtAyftP1KtxZK0csZCuFuzRG5f8sdr2M=;
        b=oP+VCzWNCLsW3msDUH2BUeZrlMnT7bWrc1fS/WtHjpEg0E9N8gohrNiur98ZaBRoyx
         CnRdU7j16OGTBjksPtqm/GSYXnwg/Cam6XHIcGBC5VsWTWpcqGUunSWLqsJW0qA3HEX/
         Lxu4t8c5X57j48oenPLCjl0EkCcyHs6F/bT7iNFcwTyPEqODW4RBXaCLv0jXY1IucMdW
         Jxa+T4RGZGPmDb8hb1RcxnWOqGEOkUn9QfiScGFUPi+3J9SlpVQWgWSIY0/ahFPlKdQV
         kmp5s17JLkyz++Hp7Ja9uKVYxxAvSdqwozSeJm/7IfJ+X+lnrc/uE+1sFw4hgFtGrjn2
         fs+g==
X-Forwarded-Encrypted: i=1; AJvYcCUMVt3ks9ZWQz/pfqw99QaM5putf7pMa/T2AY8NJtfxqp1n+ZfA5hEJYykwh+4iswe6D0Hi7o+0@vger.kernel.org, AJvYcCWmU8xMsto1WLx7n8GHOHesFQUBim/65BHRSI+fCWvKvbq0l/vrWaiEKv3Vk8HuLatFqsc8v2j4E1iEG7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8hem4d1QFNMatNPCT97BOWW+8eLwCi5NZsG/dzaUH4syc0rY
	/qNe/uuO2/hdjauaeN6MoYta9T5GAGRWR1Mb7VSnj4yjHYjZO/Top9kH
X-Gm-Gg: ASbGncvRKDdX3cwW6UsfGChtouEsLzzSAv8Lkx850LEB6SpCR4jYy5k408eZPVi7BIb
	BelVRL7TxTkHxJP7qliNNctlV+juVk/C50FBTR6EytgkyKRm2kmy9IuPccBQB/9qmifpCW8gFT/
	h2B2HuOfZ9zBJQOCePiAYjnYZM+Ns2nwekBUp/DA/C197C8DCisZoaSxGs9qaZZxlIpskKwdc+f
	Lk2Vj3qWIT+HreA2VMFKpwp1OnX9F61CXuX3b6a2aGgWJL18YGw7dTuyOmI2S0pOTYSOIgvAeBC
	0CUIFqjjrzRvoHmwcVayw075qMMPrzJJD2JI7sUvi/4+yF64iB83coSsHdx7QRwC8srUu9XkLER
	l0hsNcKQOQIbVnPd7ex/vR96pRlyOZ1YKSIfXWblATJQyrh+aPM3TOVKWvVuoEY0=
X-Google-Smtp-Source: AGHT+IH8gXomumzVn3X1fOVNK/UdIN3tXAOtzUrIbf95bqUOQc8bsc17bEKmD7i5aHj0OIc3P580Ag==
X-Received: by 2002:a05:600c:46c7:b0:450:d019:263 with SMTP id 5b1f17b1804b1-450d886f76amr53507445e9.18.1748686391844;
        Sat, 31 May 2025 03:13:11 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d5dsm44500205e9.26.2025.05.31.03.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 03:13:11 -0700 (PDT)
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
Subject: [RFC PATCH 00/10] net: dsa: b53: fix BCM5325 support
Date: Sat, 31 May 2025 12:12:58 +0200
Message-Id: <20250531101308.155757-1-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These patches get the BCM5325 switch working with b53.

There are still some sporadic errors related to FDB, but at least the
switch is working now:
bcm53xx fffe4800.ethernet-mii:1e: port 0 failed to add d6:67:0c:XX:XX:XX vid 1 to fdb: -28
bcm53xx fffe4800.ethernet-mii:1e: port 0 failed to add 5c:4c:a9:XX:XX:XX vid 0 to fdb: -28
bcm53xx fffe4800.ethernet-mii:1e: port 0 failed to add 5c:4c:a9:XX:XX:XX vid 1 to fdb: -28
bcm53xx fffe4800.ethernet-mii:1e: port 0 failed to delete d6:67:0c:XX:XX:XX vid 1 from fdb: -2

I'm not really sure that everything here is correct since I don't work for
Broadcom and all this is based on the public datasheet available for the
BCM5325 and my own experiments with a Huawei HG556a (BCM6358).

Florian Fainelli (1):
  net: dsa: b53: add support for FDB operations on 5325/5365

Álvaro Fernández Rojas (9):
  net: dsa: b53: prevent FAST_AGE access on BCM5325
  net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
  net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
  net: dsa: b53: prevent DIS_LEARNING access on BCM5325
  net: dsa: b53: prevent BRCM_HDR access on BCM5325
  net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
  net: dsa: b53: fix unicast/multicast flooding on BCM5325
  net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
  net: dsa: b53: ensure BCM5325 PHYs are enabled

 drivers/net/dsa/b53/b53_common.c | 213 +++++++++++++++++++++++--------
 drivers/net/dsa/b53/b53_priv.h   |  57 ++++++---
 drivers/net/dsa/b53/b53_regs.h   |  47 ++++++-
 3 files changed, 246 insertions(+), 71 deletions(-)

-- 
2.39.5


