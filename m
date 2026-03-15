Return-Path: <netdev+bounces-267961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB7tD1kat2lGMgEAu9opvQ
	(envelope-from <netdev+bounces-267961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:45:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9188B2926CD
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72BF4304707E
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9011737BE94;
	Sun, 15 Mar 2026 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlGt5QTS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163E637BE8E
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773607509; cv=none; b=lgc1PbqmUJXwdixO/RG0YVOVaYxUzRLbNz+l6xnIxiO6pGANNsZSnrjbQJYm8bOdcHQ6GlXvySs4EJSnm5rQidCzWP5hfStiW6FuVK4AN+aWHvj/82HfKOO6u1oBYOy8//DhauMeQnMw4tW9ycIk/r81iNJykpNJCc+K02BidMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773607509; c=relaxed/simple;
	bh=TL4YnckqfDAizb9G4bEiBhT/Q2gm3gBjFhf7dD9W5vI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWWQ28EZ0K/aR46kudqJN/aWkhzddZ+UrsJAbtZ9fJEzCGe8SqM35m29NUR7vFTKDmDM/NOSy5w13PHzK71JpyeM6Zi0EUcZ3b4zPZHfhhap4DmePmIevjqwUQSUe8x3iKUip4wqxirxIgGGICIIm2bcSMUmyCHxa1w3PfMlprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlGt5QTS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48539cbb7b1so21903275e9.3
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773607506; x=1774212306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iqIKekWl2Og8NkYhNx2Re8stLohnmIm/R0Ug/sDV85Q=;
        b=JlGt5QTSLUsU/BClmsd++eXvjktPwnZGpfRciezoVKKR9T7a2l/nL/8aT0A2eP1/9g
         x+JQ8OMaXPnpAab3h+siGpMHZN0HZNKdkX4kCHeZYc7edrWI7MjQQ8Sgy1U2FStzMedx
         mmzAoDYxqv3tTA68x28eqI1EcLkQCVQF4RhNM/6Cy7jsZkg+y/wyHj+q8qYtJstiUrGq
         LNarEg63qaBE3uPXlh+f+ZueNSQKD4rCMWwA6V+FvvwqN4hO4vVyjAy5x0MWaOHFbmgC
         D51UIBrA9QJm0Pmsn7kQZra0tEgn8ifWPLJY/GZHnzZmu71DuCug2ntJpM9QyNaikh5E
         v04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773607506; x=1774212306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqIKekWl2Og8NkYhNx2Re8stLohnmIm/R0Ug/sDV85Q=;
        b=nDay78BXjeA6GHL4PIM5C7wwc+ysUnFl3/UiKjP/6XtzI6BCehPbQdf44GLbio9Wa8
         lhodspfzrq7HfGIjY1wK9+7Cwww/0KpweAaTnSNvJsFqKogP3DNQcnOgV2rGPcGrnfg1
         XuBGq0DLbHWA7jeuA3Om8XInMMrLZu1dVdpBBrgNMNgRvKKFW7fXjgmJqvBg1QJ+t1tf
         /eMbCm+8adSNQHr27PRMWvbaBkUbvjiThtEJ5g8n37oMPq6+tJTFuuLPIzjuCwfHOx5a
         x5JbfJDFBlDG1Ft8SlY2/pozfU/QFXILyjmNG5HcS96VFjmC4ETfrqWs3zDbqFzv7HjO
         klAA==
X-Gm-Message-State: AOJu0YwxDGKtVkPMUGESTkulql4BshRO4/Iw7vpB1hfCFvOpKnC8bWJq
	F3mSx6Qn3DDMjfz8854DsA7vRM4mGDjtKfZ7Gx9ctbwX/7Q3jECM11d9
X-Gm-Gg: ATEYQzyP4OCVdRbZpM8dHi9ete4HhDCgkm1EhfWY8j5fvRR4JPU67aB7nuhX6dKE+CX
	/9WSSZsLPjaQfHPnxDU0nKZ7NBIxfIYAzbYRz83bdCS8KdFZSuvGLrvXTQDKYENlHaCKcNygFRI
	qPSmQGJCK9nRGAwSPCIZeuCTLfz24mF109nFcLJXUywJdASG8l1dv301p7paLg3lHghXaOCu1aT
	RCsyT3HOiOoq1oOtExu/zagthO4llcKB4uM1mEI8S1EQysRmMecWlSe/RG2UKphCKWa7V40QRFx
	ZeoLUBkBrSydfL5HJXRQUYAvRfYTn9kNkWl0foO5/RCQlhI453QDxJWyD/CJyiMNBdimai0fDr7
	BFW2ZXpJIevBwqMiIO2DdiHotgCmmAysc1W/v7gXkNH7316Zt1kkFU6C/q4xCVNkXsLDaqOvr8P
	BL2o4CCF1a68xT1IFtL0PqRZtHx/A9KfKt5Q==
X-Received: by 2002:a05:600c:1d0e:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4855671fac1mr196204405e9.25.1773607506202;
        Sun, 15 Mar 2026 13:45:06 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563f8c23sm132043885e9.1.2026.03.15.13.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:45:05 -0700 (PDT)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH net-next v8 0/4] net: phy: realtek: pair order and polarity
Date: Sun, 15 Mar 2026 21:44:50 +0100
Message-ID: <20260315204454.124544-1-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267961-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9188B2926CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8224 PHY gives the manufacturer some flexbility with the pair
order and polarity to ease the wiring on the PCB. Then the correct pair
order and pair polarity must be provided to the PHY to function
properly. This series adds the support to configure the pair order and
the pair polarity to the Realtek PHY driver.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
Changes in v8:
 - drivers/net/phy/realtek/realtek_main.c: introduce the common helper
   in patch 2/4 instead of 4/4.
Changes in v7:
 - drivers/net/phy/realtek/realtek_main.c: factor out a common helper
   for package bit modifications.


Damien Dejean (4):
  dt-bindings: net: ethernet-phy: add property enet-phy-pair-order
  net: phy: realtek: add RTL8224 pair order support
  dt-bindings: net: ethernet-phy: add property enet-phy-pair-polarity
  net: phy: realtek: add RTL8224 polarity support

 .../devicetree/bindings/net/ethernet-phy.yaml | 14 +++
 drivers/net/phy/realtek/Kconfig               |  1 +
 drivers/net/phy/realtek/realtek_main.c        | 96 +++++++++++++++++++
 3 files changed, 111 insertions(+)

-- 
2.47.3


