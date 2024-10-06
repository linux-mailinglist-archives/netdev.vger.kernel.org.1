Return-Path: <netdev+bounces-132497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE11D991F34
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701DC28281F
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F6613BC39;
	Sun,  6 Oct 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="CkFMeOmT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C945008
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226815; cv=none; b=fuWmsT1f9MsUx6MxWzsCkpfXb7j0NU8zhf+EX7eAjvflXJDYONrdefXYDhcmPys2xrpcbfPLDumKOVvuLAiMyX6dKr6N2mKy+fBjrkq71+GHjNCJnEu+KGzCPt4w7kJCouBNQCWjKFg2QkLoNUu+Tdgj2T6MJFgsXCPxRI1cRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226815; c=relaxed/simple;
	bh=ittApZxD/9gM+1SUthHpko8+1Xc4e94NvsqkyYFi3js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQTJmp416h9UInOEYeBLBOu8L1eymV7Z+fW2xWyXPcKHCyxnLbnhWs+oR5RhgPgiXZfzckZe2y1tqFgXPzJd5UFuospBSulKIsE036vd28l9X/Cij+54urk71W3OaOf1P/G0X/VqdG8NZnrh+w71dYs5hmvQiyItp9BezuJw0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=CkFMeOmT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e6b38088f6so719517a12.1
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1728226813; x=1728831613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+lwjdhuvOHF43G9h02JUNybiY9zH9r7ieOmyLfyb5OQ=;
        b=CkFMeOmTGT5APMj06LMNkAJrTtfS5dohhktdLM9TYU2QieL1ZCaVTkkfEFvjYHvad5
         CTHibmIW7agrzFPkHVo/q+Zf8BNZo5su2fy4dc430epBr9yT5wfEz2rAXA4nFhY/MsBs
         lq1bthIIl0KLDnDJJNb6E1Q0GRBrRroX4F72dqTLbtzRitgBegOgCu9czcIpc0C7ll4D
         FyFN8g4Ygty88vld86OcNUnKkQ6D2kCoD8DipWXBd6z0ODXzyvb6a+5s/P2NRXMJk3u2
         zx0494XONfRfgytHCfT/gM4B13CJ1XsQKdll05xvC9xca3jwE5Mh/ERJgXAfFAXK2pN4
         prtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226813; x=1728831613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lwjdhuvOHF43G9h02JUNybiY9zH9r7ieOmyLfyb5OQ=;
        b=rRZFsyfJ9bbGdCVLwKu338KgLDtIKBURv78VDGsf5XjgDYwa8yogqtn3JYfiyGsn2r
         SvIn5NNab7dQO+CpbbVol6wqW4mPavDIbzMVWF4igsau8J0Oh4melzFTPKTG/L7uNEKs
         P1QL0hhZAhzREaFb5j3XofYVHB4CRH4CzD2zotHIUT53FPaqD0XuGAxH0YoJ43xvBi49
         k5B1vMgWbHqbt+21V672XnUemd9iDSUCdoxICYtawN0dboozyolKxi7o7s0JBsCb7J3B
         cqw5m2MXo/LyjzD3r5fOoE8Q1/21ELa1Pz2xuIN32tpHeAoxBfEWMKuybn3veYKrSoJr
         5Etg==
X-Gm-Message-State: AOJu0YwY/OCoRbSrJqNVoN2Km4BI6q5bVKJbcEQts2lMocJLklaXQajW
	RuBJVVEiMfQQ31pI2JcATNN9IOWb+EnGluWPQU7OBinwe4jSVPSasWBSGUBH8aZlhh8YSrLCJsi
	GkO29pA==
X-Google-Smtp-Source: AGHT+IEBGLF+Q9MvHOP0bvPh7T7mPyjxkYUTyORQ2HFS3Wisl5Bl7gcTwd86DAO6BGwNQo3eQf+KYg==
X-Received: by 2002:a05:6a00:228e:b0:71d:fe9c:dcd3 with SMTP id d2e1a72fcca58-71dfe9ce189mr1341700b3a.0.1728226811581;
        Sun, 06 Oct 2024 08:00:11 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7e9f680c727sm3329366a12.2.2024.10.06.08.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 08:00:11 -0700 (PDT)
From: Shenghao Yang <me@shenghaoyang.info>
To: netdev@vger.kernel.org
Cc: Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	pavana.sharma@digi.com,
	ashkan.boldaji@digi.com,
	kabel@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net v2 0/3] net: dsa: mv88e6xxx: fix MV88E6393X PHC frequency on internal clock
Date: Sun,  6 Oct 2024 22:59:44 +0800
Message-ID: <20241006145951.719162-1-me@shenghaoyang.info>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MV88E6393X family of switches can additionally run their cycle
counters using a 250MHz internal clock instead of the usual 125MHz
external clock [1].

The driver currently assumes all designs utilize that external clock,
but MikroTik's RB5009 uses the internal source - causing the PHC to be
seen running at 2x real time in userspace, making synchronization
with ptp4l impossible.

This series adds support for reading off the cycle counter frequency
known to the hardware in the TAI_CLOCK_PERIOD register and picking an
appropriate set of scaling coefficients instead of using a fixed set
for each switch family.

Patch 1 groups those cycle counter coefficients into a new structure to
make it easier to pass them around.

Patch 2 modifies PTP initialization to probe TAI_CLOCK_PERIOD and
use an appropriate set of coefficients.

Patch 3 adds support for 4000ps cycle counter periods.

Changes since v1 [2]:

- Patch 1: "net: dsa: mv88e6xxx: group cycle counter coefficients"
  - Kept MV88E6250_CC_SHIFT and MV88E6XXX_CC_SHIFT to retain context.
  - Made newly added coefficient structures static.

- Patch 2: "net: dsa: mv88e6xxx: read cycle counter period from hardware"
  - Removed fallback behavior on failure to read the TAI_CLOCK_PERIOD
    register or an unrecognized cycle counter period.

- Patch 3: "net: dsa: mv88e6xxx: support 4000ps cycle counter periods"
  - Made newly added coefficient structure static.

Thanks,

Shenghao

[1] https://lore.kernel.org/netdev/d6622575-bf1b-445a-b08f-2739e3642aae@lunn.ch/
[2] https://lore.kernel.org/netdev/20240929101949.723658-1-me@shenghaoyang.info/

Shenghao Yang (3):
  net: dsa: mv88e6xxx: group cycle counter coefficients
  net: dsa: mv88e6xxx: read cycle counter period from hardware
  net: dsa: mv88e6xxx: support 4000ps cycle counter periods

 drivers/net/dsa/mv88e6xxx/chip.h |   6 +-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 108 +++++++++++++++++++++----------
 2 files changed, 77 insertions(+), 37 deletions(-)

-- 
2.46.2

