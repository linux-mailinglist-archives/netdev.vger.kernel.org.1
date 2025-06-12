Return-Path: <netdev+bounces-196839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569B2AD6AFC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002E5170714
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C5522068B;
	Thu, 12 Jun 2025 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ/9ZLqn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CADEC2;
	Thu, 12 Jun 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717471; cv=none; b=fTcqkHMfqGJafZxcIjmkP58TbLIPDwY2tFqNULt+memtyCi0ZucssrJkWdbTg1zzFZ5VaPe0L2oEtJjHCBLoFD7Uw7cqWU5fi2ldeeb6nueP7++VLmwZt30EvpPSsOFNBYTC3TGAe6C4Oue1oldTbv2ZLIq6952QXDyyV5uEf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717471; c=relaxed/simple;
	bh=CEFLa9n+fPpj+wqGGKvvw/pmVw9z8+q8e0CLX4B/Ck4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=InjBUqzlBMqwC9mOuUr6IWTbMdE5IPkYPF8O+xqK/oqtVp0dMfNc+kC3ooaWhmquIXrQM7/5OV0OEVFiTDxqQdRIy4bIxbhITD4ge9znIm/E82VWGwLHiNZutum31OB1SNEDzLNV30QgehlU34yc1ELzANLfRuF8tArK1PWimag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQ/9ZLqn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso5595035e9.2;
        Thu, 12 Jun 2025 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717468; x=1750322268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzEGJKtT75RAQvXoSTk2Z9JRuW+7se7xW3FgO1AhOCE=;
        b=SQ/9ZLqncvJ+qafB437DSOR3g1WA2N2/36v+kA4Q9KGpm20arFIxZy/10kKpgPWJGH
         4dpp0xu0hEoIO94gkkamqKWoetbp/SbkybCcaIbTGjBuWrlQlX43eX91bnCvOUULsPBp
         mDC5bFI+VHWqPYCHdTtXoHyCxK99nGBSuZcRDucsAtotRbonk+NmnooD1egCbFSOSv2t
         UCVbvXzJzz+Ftmgl3eIRCRD/Sikl5TGhBWFf/WAWhslN2H/qXfgkDeN40AF6GzdGjqOL
         FISo3JVQauAUTTpLO4+0fG2pQjtasZ2I3NPILQFgYduuBYBFFsDG67mmQJ2phjNGomzK
         fhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717468; x=1750322268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzEGJKtT75RAQvXoSTk2Z9JRuW+7se7xW3FgO1AhOCE=;
        b=RlfZYNSDRMA3BRpKHfOdr8jcA1D79Pn5f80A/piP4T74PJjV7jnWp0wtXVRBcbvVpW
         zDWSaGEcqo9mlc3bNHjw+/Fp7B5TfRSQ2iZ4OS1L1NtEG+X+7LvNye+gkbatnc+9tKCG
         VwRpGwzB2qqU6HZe5gLi/IgFKqsoBx4zCwAnRsKRFm2osiOWE8BGpo59aM10MtrIfDV3
         sprWa1RIWwP3XYvntoyfFtjr8RZ8vw6fUpIuWjRKCU8qiVQXgmq9maL2oDNNQbl4pth3
         7yH0VEpLL2qLx4nUr6avfDKX2Wtr/lOLRzKa6oAydWvqUO1HVQMR5gYoIGxPlrIeuz+L
         cLPg==
X-Forwarded-Encrypted: i=1; AJvYcCW+cIbFtZmeohlrfp/9CxKRks3eZGOHQlxqQ8dCKfGwNbdlYhKXxW2OtrHkBASte3sPwGaquGK/5Ug1nKo=@vger.kernel.org, AJvYcCWofSU59d43xfMrUF7u80XLdC3cQz7ziRhBK72Vcd/iBxeUs3+HYUYszo828OGbN0Zc3NU0Ktv6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8ztv4Qp/DHQ1+Tu89ElYgVvxKGwdP5lVFyt2GCA6gvoMRo5Y
	wJfJyFTN1xCH4/WGC/HW3b8TO/liduMkyMiviFp5Dkkizto0gUgMsLbA
X-Gm-Gg: ASbGncuJQ1BuXBpWeuDtaR1cwB1kPB9Jvu+gzLx6yibevYnXBt3ANCDc+gqWbjJJt0R
	mDsV+rhw2SZ1pGw+ZkfPUK+gjUZc8PoewAdhiXrWyDPdWdQ11eKvq3cpMEUDtucc+XqGRvwlGkl
	D7VjalvMbYnv8/eZlLJAVDr0Ui2UmpkvSCzWqhkNP/u59fyPdaYD9dmPRnhS0VeInJ+WkcKmH8+
	TdDGTAtebQJItWJmE7hBc28fu8DX1rlAQfgnsIpGrc8NRGIQuG/FARTeDKUyj4wMp3rUhaFVeOn
	4mMd8NZbOBGhcclYzmZkXUzuuZDBgDqvqf9Sj9WX3zafk6uz3zTVd6wKN/F8ZSRcGq6zDBFxNsb
	Zsynr3d3S4vZk6SOGqcz08ztl3xZBIcpvWCYZ7NrwrLvaosAP0Aoyz0xX9MMnGm4mwuNtH2ScJs
	dR4A==
X-Google-Smtp-Source: AGHT+IGMlAnHdu7jqnEKPsR3T+CXTeX2ZPjabtwDjVejO1UoYgXS0fDYrY2pacXuIIMe0uiyZM8DiQ==
X-Received: by 2002:a05:600c:5291:b0:44a:b7a3:b95f with SMTP id 5b1f17b1804b1-4532b966af9mr21379005e9.25.1749717468022;
        Thu, 12 Jun 2025 01:37:48 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:37:47 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v3 00/14] net: dsa: b53: fix BCM5325 support
Date: Thu, 12 Jun 2025 10:37:33 +0200
Message-Id: <20250612083747.26531-1-noltari@gmail.com>
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

The existing brcm legacy tag only works with BCM63xx switches.
We need to add a new legacy tag for BCM5325 and BCM5365 switches, which
require including the FCS and length.

I'm not really sure that everything here is correct since I don't work for
Broadcom and all this is based on the public datasheet available for the
BCM5325 and my own experiments with a Huawei HG556a (BCM6358).

Both sets of patches have been merged due to the change requested by Jonas
about BRCM_HDR register access depending on legacy tags.

 v3: introduce changes requested by Florian, Jonas and Jakub:
  - Improve brcm legacy tag Kconfig description, use __le32 and crc32_le().
  - Detect BCM5325 variants as requested by Florian.
  - B53_VLAN_ID_IDX exists in newer BCM5325E switches.
  - Check for legacy tag protocols instead of is5325() for B53_BRCM_HDR.
  - Use in_range() helper for B53_PD_MODE_CTRL_25.

 v2: introduce changes requested by Jonas, Florian and Vladimir:
  - Add b53_arl_to_entry_25 function.
  - Add b53_arl_from_entry_25 function.
  - Add b53_arl_read_25 function, fixing usage of ARLTBL_VALID_25 and
    ARLTBL_VID_MASK_25.
  - Change b53_set_forwarding function flow.
  - Disallow BR_LEARNING on b53_br_flags_pre() for BCM5325.
  - Drop rate control registers.
  - Move B53_PD_MODE_CTRL_25 to b53_setup_port().
  - Replace swab32() with cpu_to_le32().

Florian Fainelli (1):
  net: dsa: b53: add support for FDB operations on 5325/5365

Álvaro Fernández Rojas (13):
  net: dsa: tag_brcm: legacy: reorganize functions
  net: dsa: tag_brcm: add support for legacy FCS tags
  net: dsa: b53: support legacy FCS tags
  net: dsa: b53: detect BCM5325 variants
  net: dsa: b53: prevent FAST_AGE access on BCM5325
  net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
  net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
  net: dsa: b53: prevent DIS_LEARNING access on BCM5325
  net: dsa: b53: prevent BRCM_HDR access on older devices
  net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
  net: dsa: b53: fix unicast/multicast flooding on BCM5325
  net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
  net: dsa: b53: ensure BCM5325 PHYs are enabled

 drivers/net/dsa/b53/Kconfig      |   1 +
 drivers/net/dsa/b53/b53_common.c | 296 ++++++++++++++++++++++++-------
 drivers/net/dsa/b53/b53_priv.h   |  45 ++++-
 drivers/net/dsa/b53/b53_regs.h   |  24 ++-
 include/net/dsa.h                |   2 +
 net/dsa/Kconfig                  |  16 +-
 net/dsa/tag_brcm.c               | 119 ++++++++++---
 7 files changed, 409 insertions(+), 94 deletions(-)

-- 
2.39.5


