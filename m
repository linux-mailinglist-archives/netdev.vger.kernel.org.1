Return-Path: <netdev+bounces-130231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D49894C3
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 12:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98541F22310
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 10:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1D14AD3B;
	Sun, 29 Sep 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="RpUJIxhx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E180A42AB1
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727605215; cv=none; b=q7vTcqoqRhJb1IoBzlcyCplDuvuMtSORP7w2yan6vXmzakB2PkAkFhZ9ZAzc8HE2/qbLRVI+mf4C9+bYkr9poUqzbWLJHzY5RbfX9NHb0RW9Mvw2HlnUS6/tKPItpxv64lGUtgvYdgqt7DCJZonOnJL9tfqxLyn5Bcp0db4nWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727605215; c=relaxed/simple;
	bh=MtCEP/2fKeuwYL3LrcpzXVhPkCxkdx0+ecVldwVWklg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IiWhS7uXSoLmQ4SijLHI9y6f+aY160tJZHIAiZfaI6g5aHoNBF/T5DPAWIxLoAgJzFjkiZ9Bvmv4q7iGuLxnz6J7gR5QFBA0qovrBBCTmr9fY5QH8NCJWp8/jofB7IxZfURp/O2WCAxFc6oGLgooAE4utR3OxwQ9HdSGPh8p+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=RpUJIxhx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e0b467da03so577220a91.2
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 03:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1727605213; x=1728210013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iRaKcsHHmVPgjceCtPH9/ExaZGkiFA1bAtaefFr8AGQ=;
        b=RpUJIxhxaAArEZZJ9ur+gB8jmcntRB7XVrWpc+8zu40QeO3opiE4D6WwreLhITDn2I
         B1jMwSi0BSimhG75kC5YTmjLmRH9znxf1zPqx2lyLjwhX8cA3OiN4Hr+2ZEatetzrjqN
         8gB2aESfDia5r3SKfNdLmx0hYAAoC2lPosmXmO/zjTpOMpgFQ+OkAO/sqY7JBEBEge4J
         X5ItpPN7QhZa7CyPuM3qGb/58wdAZfmENI1yKbrYz0fcf5nDYtYlgL0gDckvQzCK1FoY
         VxZf94ZOL/2xCXTBkDB0dZYwAnVLUdL5aeOCWsp0LX1Ci8y3428mpZah7m8BNSyQCcB7
         d2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727605213; x=1728210013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRaKcsHHmVPgjceCtPH9/ExaZGkiFA1bAtaefFr8AGQ=;
        b=KmlELy4011Rc36SpmzyVRvxL2WY7brmVfBdN0p4lHYIFO2uv7LWegwL3i/hGc5eOLB
         8retBHHsLyc8CzndFqDzNZBTjlsO9ykQHv9e5KX1TXhB0FaZGrmexBpmjVUBgB+S97x/
         8TSV/HSKXIxLEqqHmF3fIAx/W5mwLe73vuAoJ1NvVjptPr39qeoKAwA8xHAxKDg5ZC6y
         Iv3OBgxJ2qhfVIr/0iCXekmnyZAb3KlGaUa9jUBcUG1FYwkZlBXZtFG+kyqoOHVloUTT
         xAlew5vyZWmtGRFLJrNE+8zOQxF6In5cWiTNwh7bnPSMfvGL9yYG3081G6cPODGLOgQI
         Z4kg==
X-Gm-Message-State: AOJu0YwsWZMAt3oY/SA8ElGjlP9h5QJZFKNj7+/SzaL9E+cp8W/AIBnn
	pa0vYf/YfemvtLzBlXfAk0wg7+uXM/hsM1bh9zKhAhS9+/xxtzUQuBqk8zIyH0wi4GjOrxmmSJR
	UyLJLVQ==
X-Google-Smtp-Source: AGHT+IGPlMYP48mymkfM88zZHnbGUBVl3OCJc7ah6m16razzo5tFbZxdKLc8vcmAmwbm8AZcsYhoFA==
X-Received: by 2002:a17:902:f689:b0:206:b618:1d8f with SMTP id d9443c01a7336-20b5794448cmr29371995ad.11.1727605212714;
        Sun, 29 Sep 2024 03:20:12 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20b37d68a93sm37775625ad.56.2024.09.29.03.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 03:20:11 -0700 (PDT)
From: Shenghao Yang <me@shenghaoyang.info>
To: netdev@vger.kernel.org
Cc: Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	pavana.sharma@digi.com,
	ashkan.boldaji@digi.com,
	kabel@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net 0/3] net: dsa: mv88e6xxx: fix MV88E6393X PHC frequency on internal clock 
Date: Sun, 29 Sep 2024 18:19:44 +0800
Message-ID: <20240929101949.723658-1-me@shenghaoyang.info>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MV88E6393X family of switches can additionally run their cycle
counters using a 250MHz internal clock instead of the usual 125MHz
externa clock [1].

The driver currently assumes all designs utilize that external clock,
but MikroTik's RB5009 uses the internal source - causing the PHC to be
seen running at 2x real time in userspace, making synchronization
with ptp4l impossible.

This series adds support for reading off the cycle counter frequency
known to the hardware in the TAI_CLOCK_PERIOD register and picking an
appropriate set of scaling coefficients instead of using a fixed set
for each switch family.

Patch 1 groups those cycle counter coefficients into a new structure to
make it easier to pass those around.

Patch 2 modifies PTP initialization to probe TAI_CLOCK_PERIOD and
use an appropriate set of coefficients.

Patch 3 adds support for 4000ps cycle counter periods.

Thanks,

Shenghao

[1] https://lore.kernel.org/netdev/d6622575-bf1b-445a-b08f-2739e3642aae@lunn.ch/

Shenghao Yang (3):
  net: dsa: mv88e6xxx: group cycle counter coefficients
  net: dsa: mv88e6xxx: read cycle counter period from hardware
  net: dsa: mv88e6xxx: support 4000ps cycle counter periods

 drivers/net/dsa/mv88e6xxx/chip.h |   7 +--
 drivers/net/dsa/mv88e6xxx/ptp.c  | 105 +++++++++++++++++++++----------
 2 files changed, 75 insertions(+), 37 deletions(-)

-- 
2.46.1

