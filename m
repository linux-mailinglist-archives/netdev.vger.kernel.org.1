Return-Path: <netdev+bounces-186842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7EEAA1BEC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9509A723B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E8D25F971;
	Tue, 29 Apr 2025 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr4gewFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEDD255E47;
	Tue, 29 Apr 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957851; cv=none; b=apSyaFnon2QAx7MdRPHdXubd/Gm/2xfpOhN7m4VjkhHvwiQHBr47HdJgiOlxPcpXqeqlhLHK4XlWOEVxEmrnOJqSIQYOuQh0jkeYvIJRzNWmfsKnB/ehgBjaQjGIB5LhthThnZrcBoQt7nU1AFIJENXgn7A+bxvWfuz1iWpylxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957851; c=relaxed/simple;
	bh=rjpoDKDVhZTqHFvznQ+aLcgS+We6aZfken0Yuc6n86U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ov42uHIQxux/tjprN8E1xn0WkhYQ0SICOW/j6MSLWIN+PBh9Rce2acHO7LqALKFT2rP8qYt1n4ZihNjPB526jlJmmd9+AYP39YYxgowxbOPa4uip5B6ozNdmL3HayRSUwMGlkV36BKf/NLWHioDhwJBff1DJ7SSJH81oOdzmHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yr4gewFu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acacb8743a7so41249466b.1;
        Tue, 29 Apr 2025 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957847; x=1746562647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJXqJGTR9eoXWZ1XO061gyOcS3WGgpE3MfcNzatM3x0=;
        b=Yr4gewFuPZFhEL8Poxk6bxLzLGfFF1ODgg5zmbxmGNVPf4ChfL8ddFQmteXz3kxFeF
         dbyA3A8boB7XTimKdimcjW7XcjJBan9FM2WHYkkVE6b5wlCkH++ToZJhkmTDsF7zDuZa
         wJ+C+mL2vEtmM/TwbA2K7ZWPW4dtJrmbDoVwZtzwBkFlEden2Z9rGAAKfLr2sgiE6k+c
         UtkmI+kIVti6QFvWZsnvMdYUBXqhlud7aErzPWMQV7z0WB19e4pkBFnjNc1rmSa1Sbtz
         Ilg1rvYDs+C/VPNb3WMp5wESU//VlWZ6hiNY/2uKo4u+7AGP7vMJa+R+XzPfiInsuoSe
         xUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957847; x=1746562647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJXqJGTR9eoXWZ1XO061gyOcS3WGgpE3MfcNzatM3x0=;
        b=jIkqn8+kXPDCsQMYPGE0Yn7WboahUNYMktvKXWf46X3XnPKtR15JU9L85DpeYo9Sgz
         NbF8Jis3+ExcsV+xoDmY7oObo4vdA/HlZaEhcREYbP+4rFKvjrFKIAVXlC+yNvuLOnrf
         FU9gkozaGA/g7AUbUiAP8W1f6E0PWUMRSz7oyG2n8lI0nQ7p1kt/3Gfw9xzI3eAenmrx
         4RjO5ztCKs6TcrE4frDbzqGSEwdw8XSbJY+fVfG0IPenNsQVRL/KnhciVhn/6zaR3uGo
         B9TqW7c15YzPiWsxrB06/Xvj4ULjfxyu913dASPMRhthwzRW5wcVthI2mvH7GB/TEKAW
         ss9g==
X-Forwarded-Encrypted: i=1; AJvYcCU2u3AIVApf+mk58ynuJC9pWBvdEIkgGxIU8Kwgh9pDZxPSXuWaQ9GzJZF/F7RH9QgwgRZ0muuA@vger.kernel.org, AJvYcCVt7rr+Cc6FSxjaYMkOEi7TyebPITt2lNfjtiZ8322W6DMqpkELanP+9NJYzlbUkNqQqQN02PbBXB+bZZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSx9Xxp5jT9Vz7cbb6ZfYwDOH08mSeuzA91Tyjv2bP+2hw2x+7
	iBRmj6oW7GqgXhwKr/Q67CYpmh5P+fTM/wkBHSQ+AmNdajg2BV28
X-Gm-Gg: ASbGncuiRazsmyZDwnXj80nCzYl97B8YxhbLQabe0BxNO8CKUp9xnSEyR6RTV6xWydW
	46lnBix8g/DU+izv/sOD17REtotXooj20+I6nc+CGX7nojOaBZf32EsoS0P24Tap9Qs5kfGag5q
	yS7nt4BFInVDAbOI4oJTTKcHpP1p8jAUPe0XWJrOkkKNhu9y9Md2m9yQmxHIGfu96w1w4i6J4rq
	5EYbUIk6UWHeKxV0ea34yH73S9PWX/wEtmhmo2rxvo9opFGbsG9Kuoyypmby95eJBSV9UBHTurb
	cf8vfMuDT93IGbgx02WdB5tLOwUPJggv9u1JUSoPi1L3adaUY6Hc3Rn9Ua184uX/eblO20TeI7A
	ow3q1kUKOI0pjcAEdfp8=
X-Google-Smtp-Source: AGHT+IEN5dmuDUuaBVUsWbTbxMTVFfCdun/yQx3P0AU893RfJV4ABy+fUaLKEgZaq4HKTa96E98eiw==
X-Received: by 2002:a17:907:805:b0:ace:4870:507c with SMTP id a640c23a62f3a-acedf98ee37mr15997166b.23.1745957847243;
        Tue, 29 Apr 2025 13:17:27 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec123a3easm229896466b.147.2025.04.29.13.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:26 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Kurt Kanzenbach <kurt@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 00/11] net: dsa: b53: accumulated fixes
Date: Tue, 29 Apr 2025 22:16:59 +0200
Message-ID: <20250429201710.330937-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset aims at fixing most issues observed while running the
vlan_unaware_bridge, vlan_aware_bridge and local_termination selftests.

Most tests succeed with these patches on BCM53115, connected to a
BCM6368.

It took me a while to figure out that a lot of tests will fail if all
ports have the same MAC address, as the switches drop any frames with
DA == SA. Luckily BCM63XX boards often have enough MACs allocated for
all ports, so I just needed to assign them.

The still failing tests are:

FDB learning, both vlan aware aware and unaware:

This is expected, as b53 currently does not implement changing the
ageing time, and both the bridge code and DSA ignore that, so the
learned entries don't age out as expected.

ping and ping6 in vlan unaware:

These fail because of the now fixed learning, the switch trying to
forward packet ingressing on one of the standalone ports to the learned
port of the mac address when the packets ingressed on the bridged port.

The port VLAN masks only prevent forwarding to other ports, but the ARL
lookup will still happen, and the packet gets dropped because the port
isn't allowed to forward there.

I have a fix/workaround for that, but as it is a bit more controversial
and makes use of an unrelated feature, I decided to hold off from that
and post it later.

This wasn't noticed so far, because learning was never working in VLAN
unaware mode, so the traffic was always broadcast (which sidesteps the
issue).

Finally some of the multicast tests from local_termination fail, where
the reception worked except it shouldn't. This doesn't seem to me as a
super serious issue, so I didn't attempt to debug/fix these yet.

I'm not super confident I didn't break sf2 along the way, but I did
compile test and tried to find ways it cause issues (I failed to find
any). I hope Florian will tell me.

Jonas Gorski (11):
  net: dsa: b53: allow leaky reserved multicast
  net: dsa: b53: keep CPU port always tagged again
  net: dsa: b53: fix clearing PVID of a port
  net: dsa: b53: fix flushing old pvid VLAN on pvid change
  net: dsa: b53: fix VLAN ID for untagged vlan on bridge leave
  net: dsa: b53: always rejoin default untagged VLAN on bridge leave
  net: dsa: b53: do not allow to configure VLAN 0
  net: dsa: b53: do not program vlans when vlan filtering is off
  net: dsa: b53: fix toggling vlan_filtering
  net: dsa: b53: fix learning on VLAN unaware bridges
  net: dsa: b53: do not set learning and unicast/multicast on up

 drivers/net/dsa/b53/b53_common.c | 207 ++++++++++++++++++++++---------
 drivers/net/dsa/b53/b53_priv.h   |   3 +
 drivers/net/dsa/bcm_sf2.c        |   1 +
 3 files changed, 154 insertions(+), 57 deletions(-)

-- 
2.43.0


