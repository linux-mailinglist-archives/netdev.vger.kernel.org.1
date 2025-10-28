Return-Path: <netdev+bounces-233605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E9C163F1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD2653564BC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A4734CFDD;
	Tue, 28 Oct 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l64mDNkp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8AE34C9BF
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673365; cv=none; b=iFWvz4kXwP9QDG54nefP7AMAmohsKOXBuLfq6sB/cqFVbtdXy14DmKRhTOJnqfn3HE0lBO+10UeJRZwvi3VE4BRSHyCFGRJi5wh0lEoVISmMdffpRfzFdC5UYZK1QVM5MDADz3QAJKNWGkdGHBGfHjEEHw6Ubbp+2vn0xGSQdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673365; c=relaxed/simple;
	bh=NB4/159VAJ/LOLYrEdLoYDe6gQW8IwjruqaLuSzroRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djvfZzYi3guCbQITsuls6uVg6JfVW0xEojnnY9SzVrJFQ+IqsGu2OS1mFqad1I2xIApj04CVRLOiNZHdA/kYbAtleZpDeRKBSHfBKIm8Y/iuuEuPSNpHhMb8C7/Q6wx5Bq4nWy45cOaeu+KZwkW0Soie2I+FdE+aO6rPsuS5PmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l64mDNkp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so3678351b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761673363; x=1762278163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUzQKBks4b6XgtXD3YeHoVuqCQLUAhrUCly5cGOnfSg=;
        b=l64mDNkpwyGxcOssSDTg7IatUFkEZGofVjCs2qt1FewOF6/6Mpobaw9ECAmBH+SC3U
         tOTITFF/N3wjho6Ta984rJdEWi01dosMFY7ZlShOvoXkMxPmTOU3nItgCzDZc9rzM8en
         NQTddCEyArdIevNn/fpsO+6pUkTMnQuirbEBxYJisTf5ezg/GGy1zTp7f9NmDq4T0mVO
         q9WIuyi01+8S8yufqgtTRSAi0XWqMXuhuoo8H246EkE/K3sjmlPOUGMACkD8nSIK58Uy
         MNTPc/n2iJVlYSCsrjQAX2pLig36SlK5wPb+abvVHmSOkn1csneA1Ulnm51gGjNPv7xb
         o71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673363; x=1762278163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUzQKBks4b6XgtXD3YeHoVuqCQLUAhrUCly5cGOnfSg=;
        b=mhe6jp8Db7kUOFU00yvGRC+4LkYNN4kf+rnIlPCtVexAhi5/mAuImWFVCBkRV1ucCZ
         QrLwF5GO2q6TwYEr8FsInb5HJUbnE7ipY4rfz42sFxsmAhdeWjKQVu/1jPHss7w1Waxj
         j1CSCeSv+l7RG9gAyYHNCvP0KPjcdvvAhV4vdeUXXOgMSW9u5v8MhN8kDIVqJsr78CK3
         95p371LIldzbQR0E92WlkgUzq/oO5vQzBWYmlWmVb2l5uBERC/wrogaTRbg6rQIPrG1t
         Va1a+Y+haKDdg8S0NHIZM02rUQLoNJeYtaigqkWBHGU9xpWxqJJ6U6xbEOqxuI7z9AYI
         vGiA==
X-Gm-Message-State: AOJu0YwwgtKiEGMr9F4xlQMbTED66Jli7sDpcfSCsIZO5KY0v18vKzDo
	b7DESssBE/DRJ2PwRG1ZLAci8hcYsDlKFF+UBz8uNezcIGEW73Bzx0bM
X-Gm-Gg: ASbGncsGbmmiU5AKroZ0BEnwAyKpmASNgCPU+PxHooFnPv9PKJ9mcxNzdStxcRnVZzH
	jNEjVvFSKl1M1lZJj8fKBsd4PoSY9hGznzejY5X8fGhbcGuFI4LXdM9+t9gbviUbBhPyeRmh5Jk
	lxo75sljJlQRB3Ya0+hYOPOCNfsr2puJ8R0dLvzE1U1uaQyaMAF2Um1KwQDc3Jd6SRjDiBqCvqP
	eXi+lO6uOgAuUkxm+9kzIOigAfhWouE+a7EVZJXPzwCsFNauW9mLpZ616N6Sw+QBwl7iUyV911v
	lWHQA4uHns7sa3hwuXRJyI2ZzM5p2g8fyT8DPkG29XkqDjR6XpYnXjb27cIkr12H14z2QI7s8dI
	6/S08EU/WHGN0TtLQBFORRqaRULZ7epKedaveSd0oedo32AQvYUwiK54apfBLRAm3viZLn3602K
	1DMf8tD0nkH+cPfBdJP/Z6tT7fT0Y4F6Mxv4VRg+UxuEiEP74ex0U7siIbBQ7Iv1iyX1U=
X-Google-Smtp-Source: AGHT+IFkagOU2linMs2kD3kWq1TGqg7rAVt5JSOnY9BDlaUoP7+rT5UX8pceuf3wIHeJnBVA96Qorg==
X-Received: by 2002:a05:6a21:3289:b0:266:1f27:a01e with SMTP id adf61e73a8af0-344d3e45d1amr5219012637.39.1761673362484;
        Tue, 28 Oct 2025 10:42:42 -0700 (PDT)
Received: from debian.domain.name ([223.181.113.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bde68sm11086746a12.1.2025.10.28.10.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:42:41 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFC/RFT PATCH net-next v3 0/2] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Tue, 28 Oct 2025 23:12:20 +0530
Message-ID: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an implementation of the idea provided by Jakub here

https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/

ndo_set_rx_mode is problematic because it cannot sleep.

To address this, this series proposes dividing existing set_rx_mode
implementations into set_rx_mode and write_rx_config

The new set_rx_mode will be responsible for updating the rx_config
snapshot which will be used by ndo_write_rx_config to update the hardware

In brief, The callback implementations should look something like:

set_rx_mode():
    prepare_rx_config();
    update_snapshot();

write_rx_config():
    read_snapshot();
    do_io();

write_rx_config() is called from a work item making it sleepable
during the do_io() section.

This model should work correctly if the following conditions hold:

1. write_rx_config should use the rx_config set by the most recent
    call to set_rx_mode before its execution.

2. If a set_rx_mode call happens during execution of write_rx_config,
    write_rx_config should be rescheduled.

3. All calls to modify rx_mode should pass through the set_rx_mode +
    schedule write_rx_config execution flow.

1 and 2 are guaranteed because of the properties of work queues

Drivers need to ensure 3

ndo_write_rx_config has been implemented for 8139cp driver as proof of
concept

To use this model, a driver needs to implement the
ndo_write_rx_config callback, have a member rx_config in
the priv struct and replace all calls to set rx mode with
schedule_and_set_rx_mode();
---
v1:
Link: https://lore.kernel.org/netdev/20251020134857.5820-1-viswanathiyyappan@gmail.com/

v2:
- Exported set_and_schedule_rx_config as a symbol for use in modules
- Fixed incorrect cleanup for the case of rx_work alloc failing in alloc_netdev_mqs
- Removed the locked version (cp_set_rx_mode) and renamed __cp_set_rx_mode to cp_set_rx_mode
Link: https://lore.kernel.org/netdev/20251026175445.1519537-1-viswanathiyyappan@gmail.com/

v3:
- Added RFT tag
- Corrected mangled patch

I Viswanath (2):
  net: Add ndo_write_rx_config and helper structs and functions:
  net: ethernet: Implement ndo_write_rx_config callback for the 8139cp
    driver

 drivers/net/ethernet/realtek/8139cp.c | 78 ++++++++++++++++-----------
 include/linux/netdevice.h             | 38 ++++++++++++-
 net/core/dev.c                        | 53 ++++++++++++++++--
 3 files changed, 131 insertions(+), 38 deletions(-)
-- 
2.34.1


