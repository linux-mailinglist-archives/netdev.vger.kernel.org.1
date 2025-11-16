Return-Path: <netdev+bounces-238948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F29C61908
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98F734EB265
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EAF30EF97;
	Sun, 16 Nov 2025 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQzquzNc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7E30EF8E
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313254; cv=none; b=laF9278GcFQYH75bscbvkhL70kk99d17MrYQ8rIWEcoy0zkjV5GQCPE+w1flOUJOIHKkQosBARUWFbXb2kKTmHNF2B527L93IIcQxZw6F3Q8UrLAsdMh6EiqRs4CJy+21zm5WyBuMc2Mo+5IaoQpj7I8xC/oUjF0vVOcXjBFCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313254; c=relaxed/simple;
	bh=oDdFLe5G68zDI/sfiRVRE5RmonM/lY3XGU8guYjTuSs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hu2IiO4HJ6a1SEkkHdI+b4yHoROeqMLaFmGLBLOQA/6Rl3kSD/yxlToXgly1TkP6dBow2McxD+GDhZdkDyrA4TzRs2Pvku1ihoznxRh2frjJGwmpWJb0KJr8wAlw/M6dwS9J8KRN3UEk1NxbAw0o/eYdcI9xfrBieln0FW1JcaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQzquzNc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so24027335e9.3
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 09:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763313250; x=1763918050; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=noTei/m84Gtc2e5bHzdK47PXkQjkwMARKvT/7gOqaU0=;
        b=gQzquzNcXmwKs4dEyw3xxIf29qHiW32RPVENd5C0J68bHUijI+9ZKntHrn2ZxvS8hn
         ImO2GPQa/XHfL2zSGSkglBIYZSfWXVUejhpR0Ndq5L/vmjY0Jj4wcwBeexFPAoDyOJvE
         D3Ez64P2RXY11jhcnxvCjZDlh5MsEawSEwkqu8ymkK8+qTD3bTN/LoRqz8ghmk9SQBAV
         kZ8b+tgxhnBhni1TxWB+vyviWlM6WZ5GpORJJGAfQmhJiIsUCWZQXoffpnSyjgy075l9
         gsmHACRduklQEKGJ13lFB7DfDjWhBJ62ZZqzXNgh8ysdpqGu244oqrUoZIETtixVLt99
         eFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763313250; x=1763918050;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noTei/m84Gtc2e5bHzdK47PXkQjkwMARKvT/7gOqaU0=;
        b=hdw8C2NqpaBuCtD1Bz4EPvSslkU+kL8I/IKhTfrUa+pL2OvsKuFh4oNNByfnBjSYhQ
         V4DAtBIV/0uQCPFBMiWzTneTG86MmEJRjHVBjINLkPdIKOrxgpC9vEqv6obq7TaeEVep
         JvRr76CLLQkWcaRLHt868ZSKqPVff+nHgEJvffYBi0/51OGSwZ7INS5VZFHeWrWV9k8f
         ne95O+mkYZmGjV4JOGlem5Rg94E8Sk28bWZWqzKBdB41C/AFlXKZLmmQZsUPRJXzLv8I
         xFCXBk2ra04noRY6n/AWqxkldg1C0E7ZpU/ex4tM5Dwey/gtYsb57fx9EO/rncEvvDlK
         lBWw==
X-Gm-Message-State: AOJu0YzM+847Uva22MYrm8BZ4guL+FmoTCvy1m4tC8b2LpUpDsSOu20m
	3lGB/5tdexOGr8C9MAWCP21Ybn7C7hJtkWBpSkvmDLT71dxGymsF3yYr
X-Gm-Gg: ASbGncvHxT54xo5RdTt1Umqxdudb+6mBS4w8bRZQWVmjTBjQebyocXKNmO+rz+P1Z7L
	ESfYnWrNtpf6TyMyCFuqXrqd5/N92IV+0/GtHamTZEh8wkV769nUyLaLXrgviLA6aa2DcvKZ4HH
	IGqSwyehQ5z0YIBEHeUDUdqBMtvDL5HK+JiKRkbRK/ttu1rz3731E5qWLrBSRjtKVq501to8oIA
	kDOeFSmV3AoPitYWXwE+mib4pJykeccwm9NXFGLIkL+AbULS9jCf0bPvxF1ewR7hMQ9nabY4tbn
	ggRhC6pjK1xNTiRjKHBTHXCwRUU5bTQOJCCeRctXzrFsqtOH5TmYfzvPfXiTibK/G0dcLrFVYqD
	fKanSd3G5lL9czi3Jw5NTzpxLt5/VL6UG4ErYezgKjynxaBH9hqc7rdLovcCLpQ7MqVlGWiM4+0
	zJsXWpM4lNuuHzIwc=
X-Google-Smtp-Source: AGHT+IGL6AV0B1oaIWHJgmVKpOsmeJef5gUQUkTvD4yoafh0RmKM+J8VrAy/OW0rZjNvWxx3l8Cgcg==
X-Received: by 2002:a05:600c:4695:b0:477:63b4:ef7a with SMTP id 5b1f17b1804b1-4778feaa8a1mr75576025e9.20.1763313250287;
        Sun, 16 Nov 2025 09:14:10 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779d722bc5sm70874245e9.2.2025.11.16.09.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:14:09 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v4 0/5] netconsole: support automatic target
 recovery
Date: Sun, 16 Nov 2025 17:14:00 +0000
Message-Id: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFgGGmkC/23OQQrDIBAF0KsU17WMxpikq96jdGHsaIQmFpWQE
 nL3iosSaJbDn/9mVhIxOIzkelpJwNlF56c8iPOJ6EFNFql75plw4DW0TNIJk/ZTpAFTcNZioEq
 YWjS90a1sSO69Axq3FPNO8nquLIk8cjK4mHz4lGMzK3lxO+gO3JlRoJVC1YHouNTmZkflXhftx
 6LNfCdwdiTwLCjAVgBIXjV/QvUTGDv+ocoCk7XQvIW+R7kXtm37AsRCTh1AAQAA
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763313249; l=2901;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=oDdFLe5G68zDI/sfiRVRE5RmonM/lY3XGU8guYjTuSs=;
 b=qDpY74269FCf6ORW4bh+saJsR8WmukkNxzemVggUzDTskMBBpzndZkqmYgjOCScEDgT/MRwVo
 JZyji65/7M0Ab77dITwWeYelMniS+2PuH8PY4n9kEHWK5NjoHQm8I3B
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

 drivers/net/netconsole.c                           | 145 ++++++++++++++++-----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  35 ++++-
 .../selftests/drivers/net/netcons_resume.sh        |  97 ++++++++++++++
 4 files changed, 244 insertions(+), 34 deletions(-)
---
base-commit: c9dfb92de0738eb7fe6a591ad1642333793e8b6e
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


