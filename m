Return-Path: <netdev+bounces-242045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C77AC8BCF3
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401BD3AE214
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBBE34167A;
	Wed, 26 Nov 2025 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqI4bCla"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6032936B
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188585; cv=none; b=Vg4cbrIyHU8YqX4m+KqU1disFErnibeUamyag2ECKmRnIpN+/q16M4ylgDDpCadJcPjKDEUGoY+3phsL8gbemKuP/kWhpKa9ung6V97ITwfB8HJf1PcHvEncIZDeGo4ebAROGGU+6U4rLww6EkCnNVbfWMB/zTfPc3OJnUJKDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188585; c=relaxed/simple;
	bh=CkoAOT5dfaR5LU3r1d65dSm1AmgA1mv63WWdM5dMwLo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MWFj4Ozy+T+1ulUjzZ2ExuXcE9eCPNmLvQ/kMRN24Sk4iK9BvUTHQyjHK7TwhX05m5jBWu/5FRvc0ePQLAnHSc8pWssBoG/fg59b02iZbhH2pC3NFOofKi5ReIh7/+m3vquwU6ikbQet3cDDYDLlsHgL7kYXCLOQxSXVm+6gBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqI4bCla; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e264528aso1751665ad.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 12:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764188583; x=1764793383; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7e8dxkWxLgXy/8RA2rSCcjfvZCVyQEqhBlms36Lhfw=;
        b=SqI4bClaKX0FpwiXHpgYHPWu2Zaj5vUtQWkLsWE9xwmarHPnlUSaxS8fjj7nBAiKbY
         NCpBA716Ee9LQrBJrER8zwuCPT69DqZlv4TnvKAuOBKS2cn0uDUOp4zM5D06A4WvrsOE
         ZJVo7f7OGNoUYrAwM4f4Bon00BUnR1PolW6UL3pxaqsFtKXcXCDUxh59aBxyRh2DKg8R
         89CnN39ZVcoY4QFYHk8XlRkm/1i80vJVAXSWl7W+azQvZlOG6+8yZbQlgfJRV6f86dip
         uUmTUE+mNTbS/5LdPuA5gC/Ho6wsvePoKQqC/aejmgo/GS29LguMTvod6lYk4yLUJWHG
         ueZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764188583; x=1764793383;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7e8dxkWxLgXy/8RA2rSCcjfvZCVyQEqhBlms36Lhfw=;
        b=UW9TDLlAub/nyp8TE5+fDtYQCvtWk8dIMJrTTE8BFIFr92z6yI27Nswuh6AmA55vZb
         jQmngLBpa1mkHipy5SwnRvE6PYCanSvTSaUMm2Su5a61yVYnYKguDyYRKQaitYb+RVuL
         ofe+Vos5nYa+3l6FZ9zwRKeK4E69XSfyCUnVlJbx3WbGsSwtiRxwIoD+qEU1xkFt0JR3
         3W1p4T1KHxePF8PTFuBBR7X51kbs/2MLMPebC2+z8bVbeHRTWwYSlyyCva2BaWX+N+de
         z6BGyGZbnd9Q9TwddrB7No6NySZFe4kRCmrGZTv50wsWqjjaLD39wwNXU3waO3t/FU00
         CVrQ==
X-Gm-Message-State: AOJu0Yy8lCcRKITHVGay9Bcu3C340OE0OEUznbWsXAVtvAMjgEPWenIj
	CP63g8wgpZ29ZgQ8GhqvB5eAbZBmkbDo/hpPtNXxOPc59Zondz9EIVbP
X-Gm-Gg: ASbGncvLxwCcXEzGDzV9YrA2cFkoh5pgyERMwG+h7T+WhTzZKIACJaBQBS1ym1dHVI1
	cCAkwv1klQXgsZq7aFz0viIF8uqYgQzmdGg+pWhz4htl8CJDrxJt5xkMjvdkGz0PjmqF0nf0uTu
	inRVdfQNXcw1/WNRAP6lfkagyipW+q1HLmHMUkOyhquaLdSDOIiNwu7gw1LABir13yXtvOzBG1/
	CS3N6Q8MuSsEc1ZBAhqWmuVQZh9luJ5rbEq38HTjljKLgqnnvvje2qqZtL3uEkZG6pyNY5edVJA
	+yb8os86+6169sWgDKIKy+aLnRGGupweP4FtZaePm03hgVs9osPcX5o9EQFjyPVvZAn19xvE3Vy
	r84wBrGjkI0NlHpdoVMgozAn6GgFaI3fIktLuGEvZonj8+pcjegk/jnmu+hBA3P6SPI+iYBM0pI
	X+G0JHb0hyC/FlqnFE8w==
X-Google-Smtp-Source: AGHT+IFRTSFO/MKoB98sTD1DZ+tV8X8B7XD531tYopVzZrSobUd5V2ps7M3RGKr1Jlxbj1VQnB/yCA==
X-Received: by 2002:a17:903:4b47:b0:295:4d24:31bd with SMTP id d9443c01a7336-29baaf85c44mr101322815ad.17.1764188583202;
        Wed, 26 Nov 2025 12:23:03 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a80csm207100475ad.35.2025.11.26.12.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:23:02 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v7 0/5] netconsole: support automatic target
 recovery
Date: Wed, 26 Nov 2025 20:22:52 +0000
Message-Id: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJxhJ2kC/23QwW7DIAwG4FepOI/JOEDCTnuPqQcCJkVak4lEU
 asq7z4rhylrOVrGH7/+h5ipZJrFx+khCq15ztPIQ/t2EuHix4FkjjwLBDTQKStHWsI0zrLQUvI
 wUJFeJ6PbPoXOtoLvfgqlfNvNL8HP+eS2iDNvLnlepnLfP1vVvt9dB67irkqCbDx5B9qhDelzu
 Pr8/R6m666teBBQ1QRkwQN1GsBi074IzZ+gVD1Dw4KyRgfsoO/JPgv6IFTbWTULBh30JikNAZ8
 FcxSqGQwLGNoYvQVj4ksGexDqPVgWXIAmGY99tP962LbtF4UEQMoGAgAA
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764188576; l=3770;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=CkoAOT5dfaR5LU3r1d65dSm1AmgA1mv63WWdM5dMwLo=;
 b=HmmRNzhldp3z64+jNQ+Cd8o8m+ugMHzZVKd6I8L00xpCsIdzeNvsHt0pGbAH4cbuk/rAaEF0/
 yqDTZZa7Op8Di9v4pBax3Wzq517Td167xktzqy+SLUhDf2WSBYfIQB8
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patchset introduces target resume capability to netconsole allowing
it to recover targets when underlying low-level interface comes back
online.

The patchset starts by refactoring netconsole state representation in
order to allow representing deactivated targets (targets that are
disabled due to interfaces going down).

It then modifies netconsole to handle NETDEV_UP events for such targets
and setups netpoll. Targets are matched with incoming interfaces
depending on how they were initially bound in netconsole (by mac or
interface name).

The patchset includes a selftest that validates netconsole target state
transitions and that target is functional after resumed.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
Changes in v7:
- selftest: use ${EXIT_STATUS} instead of ${ksft_pass} to avoid
  shellcheck warning
- Link to v6: https://lore.kernel.org/r/20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com

Changes in v6:
- Rebase on top of net-next to resolve conflicts, no functional changes.
- Link to v5: https://lore.kernel.org/r/20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com

Changes in v5:
- patch 3: Set (de)enslaved target as DISABLED instead of DEACTIVATED to prevent
  resuming it.
- selftest: Fix test cleanup by moving trap line to outside of loop and remove
  unneeded 'local' keyword
- Rename maybe_resume_target to resume_target, add netconsole_ prefix to
  process_resumable_targets.
- Hold device reference before calling __netpoll_setup.
- Link to v4: https://lore.kernel.org/r/20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com

Changes in v4:
- Simplify selftest cleanup, removing trap setup in loop.
- Drop netpoll helper (__setup_netpoll_hold) and manage reference inside
  netconsole.
- Move resume_list processing logic to separate function.
- Link to v3: https://lore.kernel.org/r/20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com

Changes in v3:
- Resume by mac or interface name depending on how target was created.
- Attempt to resume target without holding target list lock, by moving
  the target to a temporary list. This is required as netpoll may
  attempt to allocate memory.
- Link to v2: https://lore.kernel.org/r/20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com

Changes in v2:
- Attempt to resume target in the same thread, instead of using
workqueue .
- Add wrapper around __netpoll_setup (patch 4).
- Renamed resume_target to maybe_resume_target and moved conditionals to
inside its implementation, keeping code more clear.
- Verify that device addr matches target mac address when target was
setup using mac.
- Update selftest to cover targets bound by mac and interface name.
- Fix typo in selftest comment and sort tests alphabetically in
  Makefile.
- Link to v1:
https://lore.kernel.org/r/20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com

---
Andre Carvalho (3):
      netconsole: convert 'enabled' flag to enum for clearer state management
      netconsole: resume previously deactivated target
      selftests: netconsole: validate target resume

Breno Leitao (2):
      netconsole: add target_state enum
      netconsole: add STATE_DEACTIVATED to track targets disabled by low level

 drivers/net/netconsole.c                           | 155 +++++++++++++++++----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  35 ++++-
 .../selftests/drivers/net/netcons_resume.sh        |  97 +++++++++++++
 4 files changed, 254 insertions(+), 34 deletions(-)
---
base-commit: ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


