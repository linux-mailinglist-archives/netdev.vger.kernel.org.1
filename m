Return-Path: <netdev+bounces-234842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AD9C27F58
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 14:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1141897A88
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 13:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845E2F6597;
	Sat,  1 Nov 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2WAib4U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562EC2F3625
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003697; cv=none; b=mdpNdDjMllCVF/5i7nWde2LUgg1QfF3EG/SDMWHBfKRYWRqm2pI8fV2Hgupack5dlKLtRjRe5j8qrWSeWJrL52xCj6VaPJcNfQdi8vSxhj9ywVF/7YMsmauhy9mzwW3mhWV0Sutd9elz5w23PT/cwRX6bDzpmawWs/1jiceoHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003697; c=relaxed/simple;
	bh=gAgc+jApGGkkwyUp36XmfvqsPjvOHQyW1LpchMLaSBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOrVEXTGookwtl149XCnVhSfPUa6RBXTwsdmhMXP9xSQAlP92NtDDHC/SsIkBWyMqoo3rcuylW5w3YoGPlz5AjRF+kg6uVW8/LN9F+HrICEr8WNeaOLFLbVV/02atGvWwUSxLGWENc0A2c/dCgMmyGNyvFyUdKBbe/IbDk3ZWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2WAib4U; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so1440758a12.2
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762003692; x=1762608492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONIF9EAoYN2P35o4ugvv8mkCoUJAyvaPuhuKkOC/Ehg=;
        b=k2WAib4UD4/suQf6SlBJhoDyXxeqRxll/FIdr20OA23vHjRbTbDPhtGcF8wh6o00zx
         YVyrcQO0iLPRxq5qOmiAWqlmgmIQotWa4ja+ahMh8NtuJSVDB9W5GaL4LmyjEZf66CoA
         UjJl6cG6nS+M9uG48jvPv+MgqS9N4rqsGCKiRU/ToisiufcV/ePQGjYAqq2l+MOg/d7o
         lNkkPwWDqdG3MsDYr2ncyUzt3eNaWG7vVw8wudH5uWttMBZjVOkbJJf2fkMvQAF+OZNj
         fk/b9mPb3csem4EoUDNVO015+ZLpj+OvUVW/7Dq6fZ8isyQ52De28Oqt0zkTGBr3bVZV
         a/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003692; x=1762608492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONIF9EAoYN2P35o4ugvv8mkCoUJAyvaPuhuKkOC/Ehg=;
        b=JS5+BEq0p99Yd6xiRSx/jVoYu3NFsThX0MAtc5xcLGvxelmYkA8Qkc0Ae5QF338yef
         ipH3mfkbBmq+AroMpoIOJNnVehjeVbp3YFsmc5178Ej8uGOZWjsxyRPnyMOXeZGJ3SpG
         kBXvNU10H1wI7pwO2328paDQq0/l4nz+Sp+WQI0y1UWy5C+7p/zC50e1J1BJ9dMvzYmH
         W2KICG+zwFoHcm0/9qxIHqhGrq+iqjk/vz1CA15FY8XPJ4QA4xVuvIfxgu9pqlyc5mqO
         DXAaQoCisdO5Q4f2Qa43UNWw0/yAI36LUJQgJYBgfNEBspV7H8PyN7E7ID5AkkfqsQog
         9sHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdp+fyiTrfrV44oJ6AvqEJli8UZmgLHJbB+NDLx79OACaMM/1yBYMtMpSUo4OOBuqLpXGg8vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGdKTp4PncPy40osMQkc5fKafZTt2Pl8It4Oc6uAShrfY1c1L+
	SWsmfwIfluGWkRt6FUsih9Kfe+heerBWfE24MaQ9LRm5oShv80HaPtao
X-Gm-Gg: ASbGnctpcoMRe5ImO6iq32ykfYs1rKQL4i0IdGx2//pjIATocfGBLqoQ1BXxyJtTl9T
	wCzjAdjSMrgUvYGlkZAEkpgwR8sKUM2nnag6KXxwJJz7g7roB7GGBdkCM6LapZ34w+0Q2uS1Fhp
	VS7+CRy+NDy9otyzVP2NGKmOumnskxOiGmiYESmdiNKWni+zK91JBZoEnwTIO3RzELnOn6fUgJr
	Rf/M0+qO41Q58l3iJjXb4GfNxEEUvCfMJoKUdlLPSsvsWTiuM/2QhTm3RjZf+4jpHa5DkDerO7R
	Phlgw0NznjZGreL/Tr0jVuFeAx41rKnLchl65tRU1YWzG3ubAeOmuXwdTdvva0FpMHtXr/BXYqD
	kRx1KFPppzF6TqwPJ+WRuZ0/2NBopy0RF3mGGAhUtexFvhvDWiRNXHNM9ufAUyykcVurCuJIGSh
	4P5eA/81cDDG4mvwyNGqM3mAqayaIR64zD9fNB5ChKF8IQc9GRCYTcdoycOfAZFzseY/o=
X-Google-Smtp-Source: AGHT+IEkkIjbsnvjLHIsgEaTZR8QN0VYoBx925w48c7nmnrJD75okGYjHNezpBJlCKTezTSeeku+kg==
X-Received: by 2002:a05:6402:2744:b0:640:6a18:2914 with SMTP id 4fb4d7f45d1cf-64076fad99bmr5315981a12.14.1762003692322;
        Sat, 01 Nov 2025 06:28:12 -0700 (PDT)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b428102sm4022741a12.20.2025.11.01.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:28:11 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: dsa: b53: fix bcm63xx rgmii user ports with speed < 1g
Date: Sat,  1 Nov 2025 14:28:05 +0100
Message-ID: <20251101132807.50419-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that the integrated switch in bcm63xx does not support polling
external PHYs for link configuration. While the appropriate registers
seem to exist with expected content, changing them does nothing.

This results in user ports with external PHYs only working in 1000/fd,
and not in other modes, despite linking up.

Fix this by writing the link result into the port state override
register, like we already do for fixed links.

With this, ports with lower speeds can successfully transmit and receive
packets.

This also aligns the behaviour with the old bcm63xx_enetsw driver for
those ports.

Jonas Gorski (2):
  net: dsa: b53: fix resetting speed and pause on forced link
  net: dsa: b53: fix bcm63xx RGMII port link adjustment

 drivers/net/dsa/b53/b53_common.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)


base-commit: d7d2fcf7ae31471b4e08b7e448b8fd0ec2e06a1b
-- 
2.43.0


