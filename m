Return-Path: <netdev+bounces-68345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F314846AED
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E29291C6C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A015FDD1;
	Fri,  2 Feb 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OtLnsWz+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75C5FDA7
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863314; cv=none; b=jHZTex1aHKkBcVDcAG1Drmz5CGEjxgzFtr3xAgBilbab8Z1unb5XMjL4y+LItOJrv8HDzYifTyGnWXw4NdFXXNuqbPhYfxfaGo/4cE0J34vrfjN2CfL8XcxDTWshhNar5CTqvzovaAdZkibYC+ryCyrvpvCT0UiUE9DGgHXhRMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863314; c=relaxed/simple;
	bh=MBAB/0CBVPyRPmZ3hSKavNrZvN5Wx967I+Ouurnw8Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kh03CMCPuhJFWIJsuV4e9rThTEirsY6EwEq9OmqeujF4w68EmJYHUTj1rUGmgVJaTZONYO7v/ygWYF2OC0dndLwVs73EsXvKHu8QSQUASre3te/WQmqPLkrGQNJT0VhaXcubJ4yTzaHc0/zLafmXS3mOVrr7fGzJlSXamzkeGkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OtLnsWz+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a354408e6bfso501151066b.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 00:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706863309; x=1707468109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SSoBZVr93rlDPr4MSV9PvVLu46YdUcIaT5y9ftHuXco=;
        b=OtLnsWz+Z4OFCtTUSYRi00ku0fJlZz2OIawQ2a9wOa6NmR2B2LjFbfzxQCZ8/jm+En
         CTwRw88yyscvtt8sBv3zBavAiI9HcXvADGlGg49Lvhz7p58ILkrfHHcMXgrhswpNi1v5
         0oJZRtBCMdP9H/lw+/st5gSiD3ru9Yg09q30gTNEJYkwagyzSPWBNCy72uvnDLPNX/ZR
         hi0nFzXgEWz0OY10LgYKQsFgA7+DZp7RnTGwhjGklAtyJ4E4ETMe+ts2IyK5yus2dtYT
         3DbUpU+ZSxBbUqj8Hf36++NR9lBe9+Y2T6w8SW4HpA4vV4Epxii4jnDQPXvq+LiVV6jH
         qdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863309; x=1707468109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSoBZVr93rlDPr4MSV9PvVLu46YdUcIaT5y9ftHuXco=;
        b=pGRBj066PnDdXiW7VpRakC8CK1knMFY/bGNwFp6ULKcKF4GxJKhs8dbLW4WlgzkDP5
         /dkFhcuKYWfrRXQJoikb1YQUVqOhDvJWhqbDCqRfdocq9lQh9Pe5/s/at9OFYNqZ7h0A
         USTB3n81yjodzvohD+WqyccBUlUmeUHw6NEBkL2HJjdBurhau2fzfYS/u0TcADMNrjwn
         PkWpjbI4Wq1/jEy+IpTBmAppGa/1liTs6TPQ8EOeRm5jmkMJEyFsiJPdPUyTfxaFs9r9
         CS3UAgplw5sILVLHwurXYNdIYxATFnYbV7ugHl+IFH+6xzGb+gQ4miWxgdq9aS95sS4W
         5lNw==
X-Gm-Message-State: AOJu0YzW78GW9la/R3o2j8nzfdnl6+kfbvAndsg7ZLfkU6n5GxVvAZ60
	VtlOdTNX/cwUaXuuweGvvRHNbY7Xcu95oGA83/C3zkxfkR3z2gFHCFF+0N4m9m8=
X-Google-Smtp-Source: AGHT+IEZ7qT9gFTdZq18PmoTl8DRcK+1f1n2SMSsXsIPyjcy6dzJm1cb3V5xJqDHfEQnkimA/TEwRA==
X-Received: by 2002:a17:906:6959:b0:a36:83b6:385a with SMTP id c25-20020a170906695900b00a3683b6385amr1075783ejs.7.1706863309103;
        Fri, 02 Feb 2024 00:41:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXg1Zn6rDV6zcQEAZbJVWmiDmI1dT5azaR8AhI6sYZ81SDmZpmf3z3JJzIuip5Kx2vuDkZGoUP57ozgmlCJ2Vcfmgn0otLQraiO03s66HJ07PHxZYY7EqVMg5vycIYGeRpafutUV14Pd6/vT/angfYKuHEt7FJwwtMCRVgjtGfFWciMu6HkZi8/nex6WBBgjH5WjFY0MBqkzfR/V2etHo9Xns3/C7CDGEHEGHWJMXBIrvyhwvmKRoxX5NdPthtxmlp+q+vrPa+YSgPT+fO6L/Cjb2GdiaUDGSKxoTk3S9S+RPRuYVMOCDUzcBp24eFEGpb+bj7XeRch83CPp5lvtNIXbt8LLfkoqG41DGS8wTa0EahqGoYIRJrwJr+2paarTyz6LWRQwDDAKvLHaQ==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm631642ejc.133.2024.02.02.00.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:41:48 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v6 00/15] net: ravb: Prepare for suspend to RAM and runtime PM support (part 1)
Date: Fri,  2 Feb 2024 10:41:21 +0200
Message-Id: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series prepares ravb driver for runtime PM support and adjust the
already existing suspend to RAM code to work for RZ/G3S (R9A08G045) SoC.

As there are IP versions that switch to module standby when disabling
the clocks, and because of module standby IP switches to reset and
the register content is lost, to be able to have runtime PM supported
for all IP variants, the configuration operations were moved all to
ravb_open()/ravb_close() letting the ravb_probe() and ravb_remove()
to deal with resource parsing and allocation/free.

The ethtool and IOCTL APIs that could have been run asyncronously
were adapted to return if the interface is down. As explained in
each individual commits description, this should be harmless.

Along with it, the series contains preparatory cleanups.

The series has been tested on the boards with the following device trees:
- r8a7742-iwg21d-q7.dts
- r8a774a1-hihope-rzg2m-ex.dts 
- r9a07g043u11-smarc-rzg2ul.dts
- r9a07g054l2-smarc-rzv2l.dts
- r9a07g044l2-smarc-rzg2l.dts

Thank you,
Claudiu Beznea

Changes in v6:
- fixed typo in patch 08/15
- re-arranged the tags as my b4 am/shazam placed the Rb tags
  before author's Sob tag
  
Changes in v5:
- collected tags
- fixed typos in patches description
- improved description for patch 07/15
- collected tags

Changes in v4:
- changed cover letter title and keep on 15 patches in series to cope
  with requirement at [1]
- add dependency on RESET_CONTROLLER in patch "net: ravb: Make reset
  controller support mandatory"
- use pm_runtime_active() in patch "net: ravb: Move the IRQs get and
  request in the probe function"
- set config more before reading the mac address in patch "net: ravb: Set
  config mode in ndo_open and reset mode in ndo_close"
- collected tags
  
[1] https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html#tl-dr

Changes in v3:
- collected tags
- addressed review comments
- squashed patch 17/21 ("net: ravb: Keep clock request operations grouped
  together") from v2 in patch 07/19 ("net: ravb: Move reference clock
  enable/disable on runtime PM APIs") from v3
- check for ndev->flags & IFF_UP in patch 17/19 and 18/19 instead of
  checking netif_running()
- dropped patch 19/21 ("net: ravb: Do not set promiscuous mode if the
  interface is down") as the changes there are not necessary as
  ndev->flags & IFF_UP is already checked at the beginning of
  __dev_set_rx_mode()
- remove code from ravb_open() introduced by patch 20/21
  ("net: ravb: Do not apply RX CSUM settings to hardware if the interface
  is down") from v2 as this is not necessary; driver already takes
  care of this in ravb_emac_init_rcar()

Changes in v2:
- rework the driver (mainly, ravb_open() contains now only resource
  allocation and parsing leaving the settings to ravb_open(); ravb_remove()
  has been adapted accordingly) to be able to use runtime PM for all
  IP variants; due to this number of patches increased
- adjust previous series to review comments
- collected tags
- populated driver's own runtime PM ops with enable/disable of reference
  clock

Claudiu Beznea (15):
  net: ravb: Let IP-specific receive function to interrogate descriptors
  net: ravb: Rely on PM domain to enable gptp_clk
  net: ravb: Make reset controller support mandatory
  net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and
    pm_ptr()
  net: ravb: Use tabs instead of spaces
  net: ravb: Assert/de-assert reset on suspend/resume
  net: ravb: Move reference clock enable/disable on runtime PM APIs
  net: ravb: Move getting/requesting IRQs in the probe() method
  net: ravb: Split GTI computation and set operations
  net: ravb: Move delay mode set in the driver's ndo_open API
  net: ravb: Move DBAT configuration to the driver's ndo_open API
  net: ravb: Move PTP initialization in the driver's ndo_open API for
    ccc_gac platorms
  net: ravb: Set config mode in ndo_open and reset mode in ndo_close
  net: ravb: Simplify ravb_suspend()
  net: ravb: Simplify ravb_resume()

 drivers/net/ethernet/renesas/Kconfig     |   1 +
 drivers/net/ethernet/renesas/ravb.h      |   6 +-
 drivers/net/ethernet/renesas/ravb_main.c | 738 +++++++++++------------
 3 files changed, 352 insertions(+), 393 deletions(-)

-- 
2.39.2


