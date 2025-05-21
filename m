Return-Path: <netdev+bounces-192452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C1FABFEEA
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41864E5497
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21FA2BCF7E;
	Wed, 21 May 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kBOvpatt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D02367DA
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862841; cv=none; b=abZcDzLEPFZU8JU5yIRUgdsaKSqopOwNBTrSsckwB30z0+2Y+/K5UC77jEz+U2r3AmhfRsMpfnwpRoU9Mh8TXp2wyBrfGcyh7g9FNqw6K1rYtVFpYODkYIvuDz0+5IjIhmAs9GRcCQn4D8OjA1+sHixYx7yqY7M2Rdr0hiqN8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862841; c=relaxed/simple;
	bh=gFNpEdUUeb66cgnpY7pgymb1J0f31G+QOxN0RNBKp4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4cpjMuAvC8Qs5plhuhSd5owVpzSa4+oZ3ykPwyuodH2ffyF85MqXCHG9I9Wppr6JRoJ5w1BZzbStLFOMdMtCptqIgUobFsii0r1AtJGy0jMFxnZAls3viDCoW3SPEwxc+afeERzmQGVPYzor9JLy6aYQYdSrXadcUjY73M/cWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=kBOvpatt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91924C4CEE4;
	Wed, 21 May 2025 21:27:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kBOvpatt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747862837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BMJqugZzhRL4B01TTXZcWexDxBOWDxwW9juMAOSZrfo=;
	b=kBOvpattxXi6vKg/bj36IJPDmNO+PVhTr6ZYAsiJP1OZiVKrYVeQIpv+yWEE0EaQVhXX+4
	Dk/7Igsjs6cb/c/vH+YYZ2kz5fmIiJnAeuShOGx4FlQ7pejQ98wiPvjGUl7jnfj5bVmj3l
	y3TIWRW8Ltht+30RC0rvYTjGXBLyqX8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 70151021 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 May 2025 21:27:16 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 0/5] wireguard updates for 6.16
Date: Wed, 21 May 2025 23:27:02 +0200
Message-ID: <20250521212707.1767879-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

This small series contains mostly cleanups and one new feature:

1) Kees' __nonstring annotation comes to wireguard.

2) Two selftest fixes, one to help with compilation on gcc 15, and one
   removing stale config options.

3) Adoption of NLA_POLICY_MASK.

4) Jordan has added the ability to run:

    # wg set ... peer ... allowed-ips -192.168.1.0/24

  Which will remove the allowed IP for that peer. Previously you had to
  replace all the IPs non-atomically, or move it to a dummy peer
  atomically, which wasn't very clean.

Please pull!

Thanks,
Jason


Jason A. Donenfeld (2):
  wireguard: netlink: use NLA_POLICY_MASK where possible
  wireguard: selftests: specify -std=gnu17 for bash

Jordan Rife (1):
  wireguard: allowedips: add WGALLOWEDIP_F_REMOVE_ME flag

Kees Cook (1):
  wireguard: global: add __nonstring annotations for unterminated
    strings

WangYuli (1):
  wireguard: selftests: cleanup CONFIG_UBSAN_SANITIZE_ALL

 drivers/net/wireguard/allowedips.c            | 102 ++++++++++++------
 drivers/net/wireguard/allowedips.h            |   4 +
 drivers/net/wireguard/cookie.c                |   4 +-
 drivers/net/wireguard/netlink.c               |  47 ++++----
 drivers/net/wireguard/noise.c                 |   4 +-
 drivers/net/wireguard/selftest/allowedips.c   |  48 +++++++++
 include/uapi/linux/wireguard.h                |   9 ++
 tools/testing/selftests/wireguard/netns.sh    |  29 +++++
 .../testing/selftests/wireguard/qemu/Makefile |   3 +-
 .../selftests/wireguard/qemu/debug.config     |   1 -
 10 files changed, 194 insertions(+), 57 deletions(-)

-- 
2.48.1

