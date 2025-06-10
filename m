Return-Path: <netdev+bounces-196149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62132AD3BAE
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DD43A5DDD
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D9520E033;
	Tue, 10 Jun 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INeglyPA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58020C463
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567073; cv=none; b=OEHxc8zC5lYuetL/RMzP/17pFxdy3t0pTEZWc/jvnYfrIRlqD3U2xE1Lvmu6gHVMw74J2bxw55m/JyJkdQACZYYKTDJmO2qyuJT0RHjM3P//n4uyXTlg+LPc8QA9cRAgI45vbedLbtiCAYlphn6AZNarp96YJZ6cvVuZVcRJgQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567073; c=relaxed/simple;
	bh=5pCqGM06Yjhn3AECLbBoKEtOcpT9wIjFsxprqKAZS78=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=hO3AdVNq5vHhLjBnqPmw9a6pk1Z4h18kSb9fVAm/3HAe4gxlEiuXDR1LEklWPEVMKvuOgvTKmxwdIY3apeVZMOV2F0bIajFFd8iC7tAhI4mhxN2QGX0QQJ9zS3fhAy/QWLHRAtyXJD1xaoqaQkPEIxsquXK+fLcsV0Q8aYEhMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INeglyPA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2349f096605so66315675ad.3
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567070; x=1750171870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=v9LX6FrCCurkSSVo+cYYYfYcwVf1oi+hWx/DltI2kr8=;
        b=INeglyPA0tTicWt6lwIYJL4GORelt+CEtjT4UKUmvAjrbBuz4BTMooRM5PTvJmUgNL
         0HuNKXqglUQWTLMhUankAiK1BUjASTUEmLKyWql465BNsyoCh2AvRvaWGXvDDXum1R+j
         TwozvAgbi7Q9eI67vEBA4lGc0PGFtQE/xynoX8VTIZ4oZIE19O5fZ7dcspoCdtrRn9Zt
         1LeEHjtK3nbPibmvg6l5a6iO+eNaWaYlMznZSjWngmxysgmsVzql5Emq0rr+V+IbxAEn
         QF9YhUlixPihcZxoNfIvGgbLoIweaA3jLGql3nkqiwviN1GyZfXSM+6Ryp3ZWfcYrwE5
         U/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567070; x=1750171870;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9LX6FrCCurkSSVo+cYYYfYcwVf1oi+hWx/DltI2kr8=;
        b=MJe1u4ST0eWNs0gLrcdh0RhlhDWCIchqgxRkgSOe9o8rttvvEcaJyplg6AJfgW+ysj
         PJESoOaT9neO4leeirfPyfzs0ttiKFNHkO2aSG0eLM9aC/TDZUEc7v1bm+9m+w7+cV1e
         lqM2TExgVe0WQzz8Eqm1/fjuitfabKEkCDMU/WS15oF9WFYOa3SW/sS+ZqzhVLJugLNq
         LqwTn3D5fvw6I10d65d2hNW7FkiMqQ8VQtWov3MJvzbSIKX4qeJzkfa1qnZgflp0O/IW
         GXHhVz7McOM1bSHKbsZL+fKAgNEzzOkxDxbFse31pGbJuRL3jSTu1pR2vmL+zbDQ4GgP
         L0ww==
X-Gm-Message-State: AOJu0YyIF6YLaqC59G0Yzbt3JqT2qvLKVtFh99k/ODkfmvlUQJjRVBvc
	rKsw0YVy/iHjVnbyCALr+L1Nl0Z+yy2C/ahkS0IHbn7uXn1D1PH/EbITvIsHfw==
X-Gm-Gg: ASbGncvlQ32ELimP+6Hif3OXvyu2ntb+5eKdK3g/arOw82mlYFbvM9YmnP6MA0TNyYi
	03ai/wnDP72JapA3+8QzCdR6YcAaUFov2b5Ntyab0+onyNzVgr94v18aK5cnt1ztPfR51865bxH
	rpm7ZDphID8+7E9Om6fm6H8ALM6oI5fnPjPGreXIdGAHYz2ID3PIEQEvtuJTZI9VuYaRJmI1rP7
	mmvcgrrbl/XtQmTWGj1wRBEVmGfPfzWYEx9oR8IWyWBtknYuxfQMI38tW13ORsir6l7DcmNhJUs
	43CbFz4Y25QBPgADZ6iWp0nGE6IqNbk43oEc2cQ6TidUc4V8NtfvNRQvIHsmISCGEvg399KvfNY
	lRwIzhqIZhFdXgQlY0lhC+i3S
X-Google-Smtp-Source: AGHT+IG3zdwA0OAeLmB6RMsue2y4hhDaIflqmiEFiOcLBB0SxW1jyEtleaDV5r3QoVGWwCj6EmkB6A==
X-Received: by 2002:a17:902:ecc5:b0:235:eb71:a398 with SMTP id d9443c01a7336-23601deb495mr262508385ad.53.1749567069917;
        Tue, 10 Jun 2025 07:51:09 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236035068f3sm71704595ad.236.2025.06.10.07.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:51:09 -0700 (PDT)
Subject: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org
Date: Tue, 10 Jun 2025 07:51:08 -0700
Message-ID: 
 <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
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


