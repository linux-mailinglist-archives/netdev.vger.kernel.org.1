Return-Path: <netdev+bounces-248933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE8D118E5
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07A9830A99BA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B434AB07;
	Mon, 12 Jan 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbrDW/lb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945FB3491E8
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210869; cv=none; b=rrNRq7txvzyT81KUwsqJOozJYF54qNzn/mQ6Le7h687HckPFJ10AaT4RILFpfvqiFEhk3T8wE2xPTkAwA8NHrbALDY33ht4yhIvZYYWsWXzu64aeyzbgu0QVnOwm0BZleuyOKdZEHCuJl70l5oFI+smvdSx0NYBQ4n7J4FKMPT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210869; c=relaxed/simple;
	bh=D1nZ9kM/EuuYno+ZDSEcuEqHNLsDwCPEuHBego3wBFU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aVKLgjDWNM5IC/CuIYsdutgCUjvOu6EIFmHxE3g3TijSpnKa4YurV2TtXu+yVct4VKT9gTnNEZbASPsVjYjEd7pFbdAa7E1fRp0AnVGAI+9Y5euK//Zs1PG7fi0bIhYvKjgfTXlbsnyPxRYpMhtvEajJyzu5Iipx90rbRcd1ifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbrDW/lb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8716197f3eso119300266b.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 01:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210865; x=1768815665; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NcMCCbvb41kzTSUcvB+DuO2lx4ImVuo+wx0RXCc+wKw=;
        b=SbrDW/lbtiIqu6d8HO68/knngsw5di+Fe/1guDTerjtHsHpTkTiCihnuWkmvDW6cdF
         pxr8pQOT1P1/amv8RSerVYNKo2LQOe79NBg8r6LzeTut3ihG5S5otwSPgg9aqssmhXWR
         2iK6gZCpJ2xoqXZNNLoSySXioiluUn3LAyleeI7vg+u9y525AAf8plrRzVlN8NE9uFjz
         s7B12Hi64i8afjFfhi204kn4JOJlcLhRWCRrqoUA2cdLRBDXtD9FmM1BmWErqGLigHmm
         RCkzXBDKbnVxytIewKM5RnbADgys0r4OaUwLg4xJFzmA93og+PpgnnuD3v6WXqmwdomP
         TOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210865; x=1768815665;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcMCCbvb41kzTSUcvB+DuO2lx4ImVuo+wx0RXCc+wKw=;
        b=r+sVh1YDThl4izZbeitQ0xFmDuPUWhHYsoX8mO7EmNoantyP3EyJP9kPkUnTGAYTRG
         bsWQ5pECDLAWo3ameQjVT6ETOqiUjobkprs4h7fw1gctEEoXdMiCikhR9H0TfF9+9wMw
         LCzt7wKAYNhNF1pCTjR8SSozxXTR4S/9QdatWHAr5P8liWg+Wm22IfI7KeJJUUKgKII6
         rtRtrb9AZyWhemC7jjMWBXaq76HGTcXcr1AEpQOlW2C7APBXR4y4L2WupoK0I2JVarvu
         dpJqdoqsgf3cTIjs94FdHwERPyb276q+gX8u7+/e4D8C+MXYYsggyBzcjOSgXH0eAS3C
         5m/A==
X-Gm-Message-State: AOJu0Yz3HeV6zqfVuNKo1iGuo0l9Rn3jGnxpaAL9n9NKH2LhhFiIT7eg
	J/Zw0A3tGAYNTB5y6JeozUEefSAcUYpz5lhmGJfbMALi0hEG/J5Hi2/x
X-Gm-Gg: AY/fxX6uX3+7B61HcZHRYxEh6eiTYplsySpjBshhRYXRwj3CTWNbjFFJ24z7pXTVw4K
	oVQEdhZfTq479k3TSZVUysDVTmr5Ko7JbukPRbvV6JTDi2rvOYEUYuFjxbQ3uGS5qsN6OX7v85l
	nJIAsBTNKfw3RgUijDoEjEp7Sn38KPO/3GDTsMskUK80+HUShhb9m2XvWzg2NQ7569tyLEjr6cK
	Vx3FSoPWVxnIOhHQ3CNDQWhYpCUU3P1nsyLniXBEnACTLXaZ8dmn0784sq6Yl0HAGHrsNk337iS
	i4eHJg9TnhOjIkqG+Vklomgt7/Q7cO4yPYgAmsRXD+76ZFzaffndD7tSv3ULWfbKWptij0a8kjI
	uQNP4cNm4IJFlM8wCqiwzmO6USmXkeAaEhm02qzV34c/WP9Y3paprhfA9nQ7UUXEm5zECyKFlbI
	2iTt5+dIyaxWnme35B0B9s/hRZ
X-Google-Smtp-Source: AGHT+IF3qwzBAX6fMwi+kTQzS94PxeyMpNh5glINk3hu98hkCYF7yoeLu5hs9WjReRTsg2GxRg4Jkw==
X-Received: by 2002:a17:907:3d4c:b0:b83:7fb8:1f54 with SMTP id a640c23a62f3a-b8445357b42mr1845150866b.39.1768210864497;
        Mon, 12 Jan 2026 01:41:04 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm410828766b.56.2026.01.12.01.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:41:03 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v10 0/7] netconsole: support automatic target
 recovery
Date: Mon, 12 Jan 2026 09:40:51 +0000
Message-Id: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23SzWrEIBAH8FdZPDdlHHWiPfU9Sg9+JSt0k2JC2
 LLsu9cNtEjWo47zc/zjjS0xp7iwt9ON5bilJc1TWXB4OTF/ttMYuxTKBkNABZpTN8XVz9PS5bj
 mNI4xd1YOSvZu8Jp6Vvq+cxzSdUc/WDleWq4r+yyVc1rWOf/st218r++uAdNwN95BJ2y0BqRB8
 sP7eLHp69XPl13bsBKQtwQsgoWoJQCh6J8E8S9w3p5BFIGTkh41OBfpKMhKaKazySIoNODUwCV
 4PAqqFpozqCKg70OwBEqFpxmoEto5UBGMBzEoiy7QUw59LTRf0T9yCJqCs1o47o+CrgXdEnQRw
 HnvBulJaHUUzJ9AwEG2BPP4D9pakiIgalEL9/v9FxFYnA/NAgAA
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768210863; l=5324;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=D1nZ9kM/EuuYno+ZDSEcuEqHNLsDwCPEuHBego3wBFU=;
 b=1afp2v24P7yuBbwAAnExTNyO1WOGF/SSGt8ULaCiEPvIup1BBSdm42w5whAQqdFDFR843w2R7
 +2FCTRI72X0Awdb1+JbYSOZvrSTHnTnTsq0GosRsOHCpx/Qsy++SI0H
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patchset introduces target resume capability to netconsole allowing
it to recover targets when underlying low-level interface comes back
online.

The patchset starts by refactoring netconsole state representation in
order to allow representing deactivated targets (targets that are
disabled due to interfaces unregister).

It then modifies netconsole to handle NETDEV_REGISTER events for such
targets, setups netpoll and forces the device UP. Targets are matched with
incoming interfaces depending on how they were bound in netconsole
(by mac or interface name). For these reasons, we also attempt resuming
on NETDEV_CHANGENAME.

The patchset includes a selftest that validates netconsole target state
transitions and that target is functional after resumed.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
Changes in v10:
- Define wrappers around dynamic_netconsole_mutex lock/unlock and use
  them on process_resume_target to avoid build failures and #ifdefs
  inside callsite (suggested by Breno).
- Refactored other dynamic_netconsole_mutex to use the wrappers for
  consistency.
- Ensure we cancel pending working during removal of dynamic targets,
  which requires also holding dynamic_netconsole_mutex.
- Introduce standalone workqueue to avoid potential leaks during module
  cleanup, flushing all pending resume events before removing all
  targets.
- Link to v9: https://lore.kernel.org/r/20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com

Changes in v9:
- Hold dynamic_netconsole_mutex on process_resume_target.
- Cleanup dev_name as part of netconsole_process_cleanups_core to ensure
  we correctly resume by mac (for targets bound by mac)
- Link to v8: https://lore.kernel.org/r/20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com

Changes in v8:
- Handle NETDEV_REGISTER/CHANGENAME instead of NETDEV_UP (and force the device
  UP), to increase the chances of succesfully resuming a target. This
  requires using a workqueue instead of inline in the event notifier as
  we can't UP the device otherwise.
- Link to v7: https://lore.kernel.org/r/20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com

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
Andre Carvalho (5):
      netconsole: convert 'enabled' flag to enum for clearer state management
      netconsole: clear dev_name for devices bound by mac
      netconsole: introduce helpers for dynamic_netconsole_mutex lock/unlock
      netconsole: resume previously deactivated target
      selftests: netconsole: validate target resume

Breno Leitao (2):
      netconsole: add target_state enum
      netconsole: add STATE_DEACTIVATED to track targets disabled by low level

 drivers/net/netconsole.c                           | 305 ++++++++++++++++-----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  35 ++-
 .../selftests/drivers/net/netcons_resume.sh        |  97 +++++++
 4 files changed, 364 insertions(+), 74 deletions(-)
---
base-commit: 60d8484c4cec811f5ceb6550655df74490d1a165
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


