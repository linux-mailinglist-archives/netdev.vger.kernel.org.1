Return-Path: <netdev+bounces-153346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE39D9F7B6C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF0816E82F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CA922576B;
	Thu, 19 Dec 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="aUEadRkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB710224B04
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611493; cv=none; b=jwLtW3NX2dhN7DEVRsUwFI74H7qorEz+4Le1cajU/4c9XMZIGkQOh7JtbqTNZTayZRtfdH/HUX0OWNBAHC5WdsSfIczlVPC2EYHrEXrnxSqo1qNqPZHCskDZFUKo9wggpu0yP4gSOjVqwlfjsCAeAdUeOfV7tv52KFdKj+qqtdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611493; c=relaxed/simple;
	bh=554KnmQewfLNAaaVI7EBynvYbb/1peXCRMYhqw2CdDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLbm5YksSHFq50TlxwLMTrBS0BsoaDnxgB6xHSTFYtA3BXtowcZVKo40Kxvr/hgOlP3wBpShUAmqH7w6mM0D432NK1XAirgogtvhPPSWTh3WwzAzGV+sA4LviwYyUmVdbLmnP8sz9GVTRGXVsN+jLDc+hwZZMy6hGN623iZ1OCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=aUEadRkG; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so6861161fa.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 04:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1734611489; x=1735216289; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0aMpJcJTSWMr2EaVqhJNcaeXRle7w7jsNMq5lBPsGg=;
        b=aUEadRkGLD8zrm52NOMBmi0WuGsaYSkE35D4MudXovYJrUOk1b9lk/QX8j8z0FJzrS
         2XSJb2loq9jEQtOhaRv4svn/DJJ/IOo715tA676kNCrgHGtmJmpC43hv0xtsNHy05o/9
         wLzg0Gvnugbfa0qLkd62kLvxTnqlgPRfzspYD0k3cVUQ7SaGe6SNzHfRH8LvhAYtYVZi
         XRFs1lB4gjqtoDdGWwAM2d10Qknki7JalX38I5WMcvmlGl/MsuNdlUkezmHZf6Zk10B+
         +4J2s/HUYGuTeC04j04GEy0e1cXqHDgDSYPKoTxvOarWebeu93rYksx/gVQtcJEsl21X
         8kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611489; x=1735216289;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0aMpJcJTSWMr2EaVqhJNcaeXRle7w7jsNMq5lBPsGg=;
        b=gM1lDkMKRa3wuOotl6JDsAksHLEXytmZBeOlFFPmN6WqDMNHuepX0k7HNCsBNvYshn
         NgB7ikXly76ksg2gEv1D2XKCvOaGyzLAP2BsIfkBb4wF5QNT4RIG+BEK1bHqd/Qs/Cgw
         qUolPIbfm2ghUfTV7+hmj6nUsk3Tmm2AsK1cUeOVdT/zj009BWZjVS6alT9GRFGVfK0W
         OOWq1ljwkGrVy2SnrG6WW8Bk403C95sMvsV5ezGIiWj83KuM3G9/n9z0kLvY/jH6FLRh
         TrnbWa4mppIj3TL2cLcroZo/AepOai5TWc0uAeHuZshmdUXdvCyYog2D44vvUs/WNxEm
         XxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrQEkns2cOsVqFWlqwxLWcdhmdKHUIcI8TJLwNriL5WiHwdvKXZOp/FaSZ5RHz5JAs3TUqZPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+Pb3asqP7FXsWG99lVz3U2etZyWKyztUj20skvD9Yy65ShE8
	PMFT+vnocUzU7pxosP8QDZII3O1McP3Yfj49rtQLpxl9fXc5iX8zQC0Gk+hREJs=
X-Gm-Gg: ASbGnctgG7gykHTrOavZSxc9/GIheL94qAScTGcr1WJHUZGYtcAN/vvBX1y7PCMmVKE
	uacsQeb54M+GU7BUwj4lR8Wp0fvVeMnW06PMp7O5md+W/g1cM0qb5mnLlUq2A7fhuRJEWcUJh0T
	xCAie8PRfuV6uV7/0KL/zr/TiQbEI2+Do3XZTCU0OOTC27br+LuNxJYugq87mM2eYGw+ZCWlAbv
	kE0tfL7baFTU8OMPPorKfRFDxGU6OXNhR2W9zozNnkMaetKzjpnX4CRSjOIxzTYRCjG8uIrZTc3
	H+o5C2e8BSka7fwivQQTAHfo
X-Google-Smtp-Source: AGHT+IGyOn5JesJIllper5+aBTClH9ZXtDTehHux4azl9vNfoxZonXPgoVZYr22mtBchQPsZXti+CA==
X-Received: by 2002:a05:6512:3e15:b0:542:2166:44cb with SMTP id 2adb3069b0e04-54221664572mr1025716e87.35.1734611488717;
        Thu, 19 Dec 2024 04:31:28 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223b28722sm145975e87.243.2024.12.19.04.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 04:31:27 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz,
	pabeni@redhat.com
Subject: [PATCH v2 net 0/4] net: dsa: mv88e6xxx: Amethyst (6393X) fixes
Date: Thu, 19 Dec 2024 13:30:39 +0100
Message-ID: <20241219123106.730032-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This series provides a set of bug fixes discovered while bringing up a
new board using mv88e6393x chips.

1/4 adds logging of low-level I/O errors that where previously only
logged at a much higher layer, e.g. "probe failed" or "failed to add
VLAN", at which time the origin of the error was long gone. Not
exactly a bugfix, though still suitable for -net IMHO; but I'm also
happy to send it via net-next instead if that makes more sense.

2/4 fixes an issue I've never seen on any other board. At first I
assumed that there was some board-specific issue, but we've not been
able to find one. If you give the chip enough time, it will eventually
signal "PPU Polling" and everything else will work as
expected. Therefore I assume that all is in order, and that we simply
need to increase the timeout.

3/4 just broadens Chris' original fix to apply to all chips. Though I
have obviously not tested this on every supported device, I can't see
how this could possibly be chip specific. Was there some specific
reason for originally limiting the set of chips that this applied to?

4/4 can only be supported on the Amethyst, which can control the
ieee-multicast policy per-port, rather than via a global setting as
it's done on the older families.

v1 -> v2:
 - Increase the global timeout in mv88e6xxx_wait_mask() to cover the
   slow PPU init, rather handling PPU init as a special case (Andrew)
 - (Because of the previous change, Paolo's suggestion on lowering the
   priority of the log message was rendered mute)

Tobias Waldekranz (4):
  net: dsa: mv88e6xxx: Improve I/O related error logging
  net: dsa: mv88e6xxx: Give chips more time to activate their PPUs
  net: dsa: mv88e6xxx: Never force link on in-band managed MACs
  net: dsa: mv88e6xxx: Limit rsvd2cpu policy to user ports on 6393X

 drivers/net/dsa/mv88e6xxx/chip.c | 88 +++++++++++++++++---------------
 drivers/net/dsa/mv88e6xxx/chip.h |  4 --
 drivers/net/dsa/mv88e6xxx/port.c | 48 ++++++++---------
 drivers/net/dsa/mv88e6xxx/port.h |  1 -
 4 files changed, 72 insertions(+), 69 deletions(-)

-- 
2.43.0


