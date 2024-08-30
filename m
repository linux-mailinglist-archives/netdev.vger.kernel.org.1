Return-Path: <netdev+bounces-123710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E45889663E2
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F1F283C18
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC241B250A;
	Fri, 30 Aug 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A++TdaBw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471E1B1D67;
	Fri, 30 Aug 2024 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027182; cv=none; b=oG0AflJPbmHwBACS3jeDoVWtmK7oSgBvVEq3U9LSHi8bFjE46ykbnb4e10bLgeG1TyuydWpCjTsyAfuHfENlNqqRmc9TG71Du4LfO6pSWVEFMvo/kcy4ereO6798vMeqqsv/cjM8uQlgiO8cY/a5YYkSANjb9KYI5XJTKfEEx2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027182; c=relaxed/simple;
	bh=4jjODYygI5v4TKq/3DcB5lBQd4Z3AGVpan41XABF4mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZtXbOP8kohJpZEkdpi80oB4k/wVEgGJGeqUyq0wQHz3+yZLnaOvCTijLIkhWgQ4wmY0nj8ovSEpsvZ1YSYiDkRLoRO0BYfZ3iaebC5zpEZo+obFzmKyAR3ylatAohXTJHBUDDBgpdZFlEIroVP8ikdW2BF1qUeR8G66Kt60oobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A++TdaBw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5343eeb4973so2877074e87.2;
        Fri, 30 Aug 2024 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725027179; x=1725631979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XsRPOZUbVSh4TmMks/m3gnEjtV0k/xjxJYhfN5Lp4KA=;
        b=A++TdaBwbpiHm2XitfOJh/Vxj3W9J2MuodyecxwI54OI1KXv9HZwkN9w2e7MSxT1WB
         hzRijuLaq6cTyxTSb4Ed2SDbHqOxr6qaHYP25HTzRpD0W+Vfkz67NKRJdiUObzmUMJX7
         p449vHLmsa316ZggFEnUOq4sK/OWOF7nk9B/R1r3Gk3MQ9w7Ebm8UEZZTSpnPDJOVfCG
         f1R09ZTsoc23A2YtdqkX0m1SSl3lHDmVUVeACAtSKRn17VQJX2qQzbtexi18iYoZgDUE
         HJ+fDyOWLOfxB1fKap9QHeLUjVo9DFVj0PnttABBbEClCoi9gBAzqfQL4w/N2GKC7Igb
         H5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725027179; x=1725631979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsRPOZUbVSh4TmMks/m3gnEjtV0k/xjxJYhfN5Lp4KA=;
        b=uBepHZIEf/QYjonSP4pKRLNLwKfnSwNcWu41SxdtWJ5+XKA8PCj/PJFHfzaisAxtby
         TgeRfu5hOOK3d+fvET185BY4JNCDaXRfRh92YH4g/EkXGGZ5vDpVt+WvOD9GlEus1Fsm
         kwAXzR8xj2unq2TJ9XNrodjzk6X0oi5hEG/ceAHDf0CHRr4PNjCpgAuV/n7N325U6Gcu
         NJzonY+4iCNYtRbTJPYVM5uQO+X/YonYPbvWqlj0RTNteTZ2+wkbm+il1ka1O8jujwze
         lDPY5skAchWTR/1mlmqEZrBOqN/5DY+bBv5wyoAwe9G8LD1qlXyETN9Hl0FSyuTEZIXa
         GjMg==
X-Forwarded-Encrypted: i=1; AJvYcCVakMTYjEBLDPZ682m/k7r2W7j+t1WZD6dUfEEcLA/KKY0MsUpilQ0Yk88Vy+13PxBlyf3i26TrCbVpxc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56jlQkiQiJHkrd6chFVvOSctzIxaRoc1vS8ykL0JfgQN/HBDq
	zjbJW/g3nz/X4Fm7r/3YA/egqWs2HZvAfvRkNiDWVDiEji8xhryj
X-Google-Smtp-Source: AGHT+IFwp4sw3c9q7LvAZ3T0FV4yOTl6fzKEz1VuUN6xKResTEiGakaop0k6mqTIpR8Gm08UhpUA9g==
X-Received: by 2002:a05:6512:b15:b0:52e:976a:b34b with SMTP id 2adb3069b0e04-53546b33aadmr2037799e87.15.1725027178681;
        Fri, 30 Aug 2024 07:12:58 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196975sm221304166b.135.2024.08.30.07.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:12:58 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arun.Ramadoss@microchip.com,
	Tristram.Ha@microchip.com,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v2 0/3] net: dsa: microchip: rename and clean ksz8 series files
Date: Fri, 30 Aug 2024 16:12:40 +0200
Message-ID: <20240830141250.30425-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

The first KSZ8 series implementation was done for a KSZ8795 device but
since several other KSZ8 devices have been added. Rename these files
to adhere to the ksz8 naming convention as already used in most
functions and the existing ksz8.h; add an explanatory note.

In addition, clean the files by removing macros that are defined at
more than one place and remove confusion by renaming the KSZ8830
string which in fact is not an existing KSZ series switch.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
v2:
 - more finegrained description in Kconfig and ksz8.c header
 - add KSZ8830 renaming

v1: https://lore.kernel.org/netdev/20240828102801.227588-1-vtpieter@gmail.com/

Pieter Van Trappen (3):
  net: dsa: microchip: rename ksz8 series files
  net: dsa: microchip: clean up ksz8_reg definition macros
  net: dsa: microchip: replace unclear KSZ8830 strings

 drivers/net/dsa/microchip/Kconfig             |  9 ++--
 drivers/net/dsa/microchip/Makefile            |  2 +-
 .../net/dsa/microchip/{ksz8795.c => ksz8.c}   | 13 +++--
 drivers/net/dsa/microchip/ksz8863_smi.c       |  4 +-
 .../microchip/{ksz8795_reg.h => ksz8_reg.h}   | 15 +++---
 drivers/net/dsa/microchip/ksz_common.c        | 48 +++++++++----------
 drivers/net/dsa/microchip/ksz_common.h        |  5 +-
 drivers/net/dsa/microchip/ksz_spi.c           |  6 +--
 include/linux/platform_data/microchip-ksz.h   |  2 +-
 9 files changed, 58 insertions(+), 46 deletions(-)
 rename drivers/net/dsa/microchip/{ksz8795.c => ksz8.c} (99%)
 rename drivers/net/dsa/microchip/{ksz8795_reg.h => ksz8_reg.h} (98%)


base-commit: e5899b60f52a7591cfc2a2dec3e83710975117d7
-- 
2.43.0


