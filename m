Return-Path: <netdev+bounces-197007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5511FAD7549
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDCE3A2286
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7826D4C9;
	Thu, 12 Jun 2025 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFNcNwDC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50AA271454
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740904; cv=none; b=SUIhdgmRgDrRNFSkOOmwqZZZ1Mbrvx2er5aA61F2WUmfbnqj7tpo5KLW8uZ+qPWBVyYs5FRH5Rvqe1c+h9DNRR4lpCmhs+UToGJkXnnvaevViTKZJQv6oGOVBsrX716RWJG9zFra4DbQfcs5ENNnMCqmQKcDNfujE9jbQGA46rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740904; c=relaxed/simple;
	bh=hAk3bttaDjaATfdUQqEjCAlzOSdynrc09wibh8X6SLQ=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=hI/CehwTniIMJ2rS5HjeaaenV7Mn4fYcxFEVRO5WMrUQPLAMjTXPFpHgh8nehjW2f6FCsPNpS49D57faGsDyxmg0kNn0h2GH1u5tTBCGqC8hsHXB6oZm0jx6DDtCpSEUkBH3R/Z+MTEQUiOh4/TtOL+QRHHaG3QbGMz8nAZyBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFNcNwDC; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-afc857702d1so743146a12.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749740902; x=1750345702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=e/jnAXiUl+X9dHh4nZhdh8lVReW+HG93D148+uTcn2g=;
        b=RFNcNwDC9b7er8IJ/1BXlkDhuPtm8SSwYv0Agc1svTumiQ/muGY1ZiA9YGy+Pxx9Ow
         sC04PFYIaKFHC7nwTEXhQNIFKQzCa2VI+SFkUMVzMmGeEyGo+CUxJJyJcEhg+dOXw1ee
         SlvAWQmALyVs1KQhu6p+PlSw1mnQ955mw4StsiWZ8ym17ya1h6LhoXufYltWWDAXk7bJ
         fdxDtH4VJ1YexZY/l2x8G64Mg1ImZvBmOSjMUpR5BLzuvej/orulZAgDgVleGcreK6ZA
         gjF8tIxsMLm+HCq4N/U4YcAkHgG9AmD39lS8aokfEcgqo7V9pYKD4aY0L7nIspzPU2bf
         1ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749740902; x=1750345702;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/jnAXiUl+X9dHh4nZhdh8lVReW+HG93D148+uTcn2g=;
        b=EPPC1lWVfffrCCvA/oLfRXOQGcB374CFKYGB3m8LDhXk8XsEirCop+y0g+GhOxjPap
         26c+aEtDaqgPcsYYpzx8HfDahVN/YaTSm4Q57PjH//BFUnKHAoeoogM2yAyqXQ/93YmO
         joJbm0H1pgUkBWg60QKZ1JNaD32MIfBw+4ocB6BGqXz9qhyNNIEk6jDv9mV0nenjRBvi
         SGCsG8JQuS77YTMRIioiJzLHBEqevrQx2pnI9PrL8QIOQet/LtwGeOG/uIJVWhnQUcjc
         UYK5eADK/YME44TPp8zglda5ADtKShGKKrTQmPxcfB/SHgInzqf0ioPH08Org/Tnp8rh
         MWPA==
X-Gm-Message-State: AOJu0YxkLivojIUVlx7vCl/KbD59GxsowvEwBsWyR/6/V+O5KFUpmqny
	jVX6OB5W4j6/L1Xq83FJAGoZ+InMrUnzCGNBUg9+LVlAhgfS0hENxxDRxUuedA==
X-Gm-Gg: ASbGncuPmUYgWZAbH0On2bUwJpAfbqQENzn9CfbEiLufOLBzU3DJmo79PBrTortpF2r
	W9OpVSKBrKuy0wt8vItqUWp/ojfnKhJqzYorc+NNA1vpr1U+K0X0s+g3sXFd+2arV6v57U8nCR+
	2Ew3oJqaUqIoAMXlOqzUKc82p1N5xlId7Io/fUhtOp4y9M4ljE4mooIOKWIqWdPd419eF3kaJaF
	6D5jPaZM3my6/YvLYV4aoVtk7jU2TrIy9xN6ET1B7zM6ubYt8NMz0qqEFocL2LEOi89JXYZVop8
	S4x7M+mPqzHaNrhV8aUV/WCOVZFprGlWSFEEEWNa5nU7b6neBDKCxe3Bz6Wys/l27Okocrou3Ah
	Rb60+BZfuQG0FDjIyXXp2
X-Google-Smtp-Source: AGHT+IH0uYshXuGUYg7k8Q0bX9mPuLSOlEFl3TijMeeWfHuqw8LwEoFajJTN+WkiG3VyZ1bzqk8xgA==
X-Received: by 2002:a17:90b:5249:b0:312:e90b:419c with SMTP id 98e67ed59e1d1-313af209387mr8995036a91.26.1749740901960;
        Thu, 12 Jun 2025 08:08:21 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd613fee4sm1477694a12.26.2025.06.12.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 08:08:21 -0700 (PDT)
Subject: [net-next PATCH v2 0/6] Add support for 25G, 50G, and 100G to fbnic
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Thu, 12 Jun 2025 08:08:20 -0700
Message-ID: 
 <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The fbnic driver up till now had avoided actually reporting link as the
phylink setup only supported up to 40G configurations. This changeset is
meant to start addressing that by adding support for 50G and 100G interface
types as well as the 200GBASE-CR4 media type which we can run them over.

With that basic support added fbnic can then set those types based on the
EEPROM configuration provided by the firmware and then report those speeds
out using the information provided via the phylink call for getting the
link ksettings. This provides the basic MAC support and enables supporting
the speeds as well as configuring flow control.

After this I plan to add support for a PHY that will represent the SerDes
PHY being used to manage the link as we need a way to indicate link
training into phylink to prevent link flaps on the PCS while the SerDes is
in training, and then after that I will look at rolling support for our
PCS/PMA into the XPCS driver.

v2:
- Fixed issue with fbnic_mac_get_fw_settings changes being pulled forward
  into patch 3 from patch 4.
- Updated CC list to include full list from maintainers.

---

Alexander Duyck (6):
      net: phy: Add interface types for 50G and 100G
      fbnic: Do not consider mailbox "initialized" until we have verified fw version
      fbnic: Replace 'link_mode' with 'aui'
      fbnic: Set correct supported modes and speeds based on FW setting
      fbnic: Add support for reporting link config
      fbnic: Add support for setting/getting pause configuration


 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   5 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  23 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |   8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  89 +++++--------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  21 +--
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   2 -
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  11 +-
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   | 126 +++++++++++++++---
 drivers/net/phy/phy-core.c                    |   3 +
 drivers/net/phy/phy_caps.c                    |   9 ++
 drivers/net/phy/phylink.c                     |  13 ++
 drivers/net/phy/sfp-bus.c                     |  22 +++
 include/linux/phy.h                           |  12 ++
 include/linux/sfp.h                           |   1 +
 14 files changed, 257 insertions(+), 88 deletions(-)

--


