Return-Path: <netdev+bounces-209211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D125B0EA74
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 785D87B5D52
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 06:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C84726B748;
	Wed, 23 Jul 2025 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjgMPxV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8425CC63
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251376; cv=none; b=MJWiqb92+TXg5R7GymSXjAkxDJIBBT+DKIeNyhS+ioF5xJsW17emHg4sVPX0cf80ORCLP76fw2lZeGDeveqvUyXcpCHqWPyDv+OpmpvKrEPf1sAvc7FepHeNINU0vlkukCzpJ7o0gWtSKuBCSQZbRNW2V+P77WRRyGgrw9pMQTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251376; c=relaxed/simple;
	bh=nyQ60akwTO7CwWbX0gdO/UaxQKyumyv74IWbBFYbpuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdNY7P2G//lN5hUHLL3+7QKgqVyJ4u9wkn+RljAhnU3U5Hk2EIjNN/fC1patoRb5OKvjNEg8goZJjfCFQGzwAtaKXsAxbr7BTlIqdvU2rPp+4CppqXesEpiW/CyOiIRPj950xc/AbpJaGH+CMF0yZfI8gVbyPJCeVjHQqcXgLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjgMPxV6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234b440afa7so58634495ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753251374; x=1753856174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PDKg7ePUHJDoQ1oMJwhR4V9KfKAK4XHoKDAA8OdhErI=;
        b=ZjgMPxV6/AHuS47+RApM18Ac/FrEjlnh2m8E6DmkgJBw10uXv6YWtHXnp3fpcdBrjd
         IMbSImE6sx8xftOddxcbaKddQhAmFBhK4vAJvi410Qh4Iv85nzb1EIaCBjkEqiR2y0K9
         23FLxl5xkgrMLtx2rxu1ADzx3h0TXHnD8W9Ek94JctHbG7+x7zkdEBaTMD9xV2sdWJgm
         I+uUmQwFnLrXBrJsWllc6k0K/q69GMjl6e+03bQptoMUWIQo2KG7r4POSXCV/W/A2ds/
         DD5NXDyP+KNwKYYs6xG0DTiiD+1xnP4d5K8A6mKKJb4Cl93Z0EN7RDPkFU9T/jz5pEf6
         wMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753251374; x=1753856174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDKg7ePUHJDoQ1oMJwhR4V9KfKAK4XHoKDAA8OdhErI=;
        b=lsTCJiQ4LdPmHDV68rSgwXRi0tRKyG0Xn6K5ZgFazMIRYpndADtlWxOxk0oGvcgvEL
         iyR6b+XP5uHF1dAkSdUrsyxhwl/j/haxW1n3J2faP9u2i5voJAnz6ahn0FXpHHQQ8rws
         XXJ90U5guPYPNMbMVvSIk3ZFGnw9wwN7EUcNR7ytCDRge/n8IvDsBM4C1ZZmE2lFsUbR
         WFdkGMnI5JozpQ0pH2wGRUHcUFXKql6U5KUtnLaInOubvlQNd2kl47fkMAXa/OvWj0ZL
         ednZb3Lqt3Osn2iV/uFrieTG8KHqGDsGMm4iW98rdv2EnHEFQjr8pAQnOjiEUALTxYRl
         na3g==
X-Gm-Message-State: AOJu0Yzvy1ohzWsXttbIZwWzoOaOb6M2bVWHvhvsJ8690XbBv1eAdwAm
	h7nBNZIqyc4gYA8bWCq0A7bkk8m75frFKFJ00ng4K5EBfOiRXx4G4YbWdhvh5IvY
X-Gm-Gg: ASbGnct9Bi5ek1ElUq6E42VFOZc0BViGxhSqy60nZBOV15niOFsbBt4JhDklFxuxQrB
	WL3q6saP99cqphDldQQAfTiZImhEPHtsQYLZESoDF9okBbc4vXVWufnKneSTq+ltvh5/a0xze6x
	dtCdbfVU8W+OjJmHY9FjnZi2NSgnOGJrEx7keh2+uXViv/FmSwdjwb07B4JOUrJRU7rKAPm5Gh0
	t1pcSOBEXBQ4gSBnsa9zKhc/ddeolb+IE0WzCOHHJUds3bUM9ODptIb4XZVio4hjEDKUmdpnrw3
	AfWjBQE9P3K+snb/WF4B5EU1leK6jyM2/bIQsbYhx8IASez0fgzXNiw7Tl2Snq/nMnioYsvDoBN
	RHENb6jH5/VPMY/hkeG7fpRolNs2WY3iq4dk=
X-Google-Smtp-Source: AGHT+IHtcfAwE6MRlwmdk0CgZotD6OwJZQVYPLudPrB3Vw1n6+JYrP8FxNP9ShtXyyeqJOG9iGgSXw==
X-Received: by 2002:a17:902:d483:b0:234:d292:be7a with SMTP id d9443c01a7336-23f9812b545mr25236505ad.1.1753251373643;
        Tue, 22 Jul 2025 23:16:13 -0700 (PDT)
Received: from krishna-laptop.localdomain ([134.238.252.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e51b9329csm798044a91.32.2025.07.22.23.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 23:16:12 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	tom@herbertland.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	atenart@kernel.org,
	krishna.ku@flipkart.com,
	krikku@gmail.com
Subject: [PATCH v6 net-next 0/2] net: RPS table overwrite prevention and flow_id caching
Date: Wed, 23 Jul 2025 11:46:02 +0530
Message-ID: <20250723061604.526972-1-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series splits the previous RPS patch [1] into two patches for
net-next following reviewer feedback. It also addresses a kernel test
robot warning by ensuring rps_flow_is_active() is defined only when
aRFS is enabled. I tested v3 with four builds and reboots: two for
[PATCH 1/2] with aRFS enabled/disabled, and two for [PATCH 2/2].
There are no code changes in v4 and v5, only documentation. Patch
v6 has one line change to keep 'hash' field under #ifdef, and was
test built with aRFS=on and aRFS=off.

The first patch prevents RPS table overwrite for active flows thereby
improving aRFS stability.

The second patch caches hash & flow_id in get_rps_cpu() to avoid
recalculating it in set_rps_cpu() (this patch depends on the first).

[1] https://lore.kernel.org/netdev/20250708081516.53048-1-krikku@gmail.com/
[2] https://lore.kernel.org/netdev/20250717064554.3e4d9993@kernel.org/

Signed-off-by: Krishna Kumar <krikku@gmail.com>
---
v6: Keep 'hash' in 'rps_dev_flow' under aRFS config.
v5: Same v4 patch sent with a change in documentation style for "return".
v4: Same v3 patch sent as a new thread instead of a continuation.
v3: Wrapped rps_flow_is_active() in #ifdef CONFIG_RFS_ACCEL to fix
    unused function warning reported by kernel test robot.
v2: Split original patch into two: RPS table overwrite prevention and hash/
    flow_id caching.

Krishna Kumar (2):
  net: Prevent RPS table overwrite for active flows
  net: Cache hash and flow_id to avoid recalculation

 include/net/rps.h    |  7 +++-
 net/core/dev.c       | 89 ++++++++++++++++++++++++++++++++++++++------
 net/core/net-sysfs.c |  4 +-
 3 files changed, 86 insertions(+), 14 deletions(-)

-- 
2.39.5


