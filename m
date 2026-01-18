Return-Path: <netdev+bounces-250826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D39BD39452
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 12:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF1D5300C36C
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC032AAAD;
	Sun, 18 Jan 2026 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je814rp/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216B82D8378
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734030; cv=none; b=qNDUjDmr9JzDv9Dsh5dRgiJryvmaWkgPTGkM4XvpkxfAuDcWDrYg6+6qp+edcksQtx3gDmzvHdprIzmt31L+Bjil2k9uti5jvRCuvSioKUQS6q5jM4k7Wgy4efqUSd7fNzmoWBUCpd2Ilpti9pncB1u6XOmhnQGDPlGV0COfew4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734030; c=relaxed/simple;
	bh=j/O/ZdXNE/AJ9XmfXXavSQWdNO19Kh4bM+xEHlKCQS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hI7PdakWK8idLpmRmadA5iWrkld//yBD0iEe4y5bfN9iREFVIpNbxnec1VO1a6JYe3UxSvlnj1RfWliZE1dLZFvueXIsJPG/fayuKpf0qgoV/pveXcwVqzGfMpUinQ625o8/xm+N/q8m1N2aATfCeNepLVrwn996gVTlHBI5pzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je814rp/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4327555464cso1686664f8f.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 03:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734026; x=1769338826; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2QflZZM30fHvvXvMmYMqyrigzgY4KSpjxPmG1MN9fo=;
        b=Je814rp/qRiR5TEltjiSP/Kh2wX/QbXC0D7+pnha98qCSP/2q3ccJsDxL4nqtociqH
         x4DADlYVlwKnBQS76Tq//qffXSivmJcyLUFS2YQEQ2c3DYXq1IaVxYZ5ZXkIo35XehbK
         yhDBGx4Za5GCpVCTr++TgnHm+19pgKR3WjM5DjO4mTk6tSU+YNJDWZnsznxWvnSYf8Ng
         WZVs7TTONf7TnGOsCsavGFIrnjPsr2VTzl6gt0qds+4jWBC4qv0yvoo505kRlRmKGyoK
         YIZDMgR/1zJ1JQqiWtQTWa0QEM6Nd08SZdnD5uZXGXL/2LS+SAgr0k7Y5/lm28v5uwNZ
         HOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734026; x=1769338826;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2QflZZM30fHvvXvMmYMqyrigzgY4KSpjxPmG1MN9fo=;
        b=hnXVVfQnHKgjU9qjczE3CiPWrXMvf84WZindnm0p6575ZjlUWPXohn5Am+wOwj3DfU
         FfLC6lgLz5DwxMcX/WrhSV+JyEqfsLPDOml5yrZaZ5h2yXfMrTeXXBpup1yr6Xlmck+H
         I6ZzjcBzVEt7Fx9kv0Tca2CG3GiCMKpUniXFTnalDb1zCWid4EPaaZaLVxpGWxgiseM3
         0bznWpjXNzo8ZWRbTH21fblDOA8Oxm/duXnylHTXnCFJbz+OtZXVp77mqE4EPGax+ArA
         qe/u62bG7xQj5mII05ZARaQDEs1HXWmUy8cddDKQtC+m0sW6Y/+FOlF1FThuvXCFS3Io
         i7FA==
X-Gm-Message-State: AOJu0YztZRfRMkogGdGXUW7YGz8f2KizZCwBZ2j99eejI+KKsv42VPN5
	r4AFEHJ6VSb0sEcAgvc5eJLZP7Pwed4Pvd/KNMj48/ADSOtBiM2ZOQ4z
X-Gm-Gg: AY/fxX4jbxOjCeNSl9cfLaf8Xv5jgpkV+u9tkbZbB8Ep9wMyn2PChjPa3L9e/6D1CdL
	QQa2+TXF3cgj3fIzba2poiTZdi7El/7lfhMWj9jIE+LmSx+0/QqP5U3nKF7ZY4a7wA5pTJ+iZ/b
	td9eJUkybaZnSaZY4w/hpyFJlFIySZVpBmPiqAcNw2/GXqe9WtBneNHvQy6+EokbXMXezGKdHt5
	WxphxYhvw577nGnlvSFKdNYrJ5VGdEGSNUYr7kHKwU/5zC72fTV5QvT44MnOUHs/sShDhAGrztm
	hAGpUcmuUqhRStTlRX5U+xeopodJn9SUvr09ywmAkPzHt4ORzxNZYBF/SITZiykAhUp+dTQp4Nw
	d+TTO0Q+stKy9o3zqJ6c563zlSN54JKv3uzA36QQsvacSXZK7sJrnIl1Q+pdWeqYelcVUMJnnun
	sacZD5cTZHZLYHAQ==
X-Received: by 2002:a5d:5d89:0:b0:42b:2ac7:7942 with SMTP id ffacd0b85a97d-43569972ec5mr11440987f8f.5.1768734026180;
        Sun, 18 Jan 2026 03:00:26 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm16864635f8f.2.2026.01.18.03.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:00:25 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v11 0/7] netconsole: support automatic target
 recovery
Date: Sun, 18 Jan 2026 11:00:20 +0000
Message-Id: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23SyWrDMBAG4FcJOtdlNFos9dT3KD1osyNo7CIbk
 xLy7p0YWoSjo5b59GuYG1tSyWlhb6cbK2nLS54nWnD+cmLh7KYxdTnSBkNABYbrbkprmKelK2k
 teRxT6ZwclOz9EIzuGdV9lzTk645+MLpOJdeVfdLJOS/rXH721za+n++uBdtwN95BJ1xyFqRFH
 Yb38eLy12uYL7u2YSUgbwlIgoNkJIBG0T8J4l/gvJ1BkMC1kgENeJ/0UZCV0OzOJklQaMGrgUs
 IeBRULTQzKBIw9DE6DUrFpwy6Etp90CTYAGJQDn3UT33oa6H5i/7Rh2h09M4Iz8NRMLVgWoIhA
 XwIfpBBC6OOgv0TNHCQLcE+5sE4p6WIiEYcBQ4VwbE5UpShiwYTjSuNjUi1cb/ffwGFKybjEQM
 AAA==
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768734024; l=5665;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=j/O/ZdXNE/AJ9XmfXXavSQWdNO19Kh4bM+xEHlKCQS8=;
 b=3yLjTs5FCZwgBaXzT5NYtLsUs/Scbb5lae31ukx8HNtOrzSCOkpN/+T3rG/j660RORtOw+1cM
 395/2UjqrKNBCUa66mIB6LlEvQYrDdiX0psENA0KO6wSCaw5syLi9A7
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
Changes in v11:
- selftest: Remove dependency on persistent mac addresses for
  netdevsim devices by saving (when disabling) and restoring (when
  re-enabling) netdevsim module. This should fix netcons_resume.sh test
  failure in CI.
- Link to v10: https://lore.kernel.org/r/20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com

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
 .../selftests/drivers/net/netcons_resume.sh        | 124 +++++++++
 4 files changed, 391 insertions(+), 74 deletions(-)
---
base-commit: 74ecff77dace0f9aead6aac852b57af5d4ad3b85
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


