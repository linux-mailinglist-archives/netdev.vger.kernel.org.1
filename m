Return-Path: <netdev+bounces-237043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46160C43C4F
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 12:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCD81888997
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1CB2D5C9B;
	Sun,  9 Nov 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On+neItZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7324274FE8
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686379; cv=none; b=d+0WxXdsE2NLSu0RtqUtf9b6SPjJbDbFQLow+zhkRxHtHN8xcxmrBcQsRCJ6WMo7Ng5twJLANeph6xvEDs5MfzBVg24T4gItf0kHyBvHDYRlArP3C+ppQE7zKt08lrbHtuHbyo0AUUDGFaFqX4/hEiiiKpjq3w6/KPSG+v6UscE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686379; c=relaxed/simple;
	bh=De9+MX2vBk+SbIGIUhl/ERdEJOEzL0rWaAO/AnsvYOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OFL0PdYX7z1dnD8hWfRLKyPHDxFIpH7XWKt/ZBoB/3gOR8DA220XdySvhw8iFPSrhwkTetdhLDO2tE4QsO0i3d4YrlodESpimOb03T5sHDQpFDhfVpnREuVcVlOSvelgvM9WaSDtBSSYS3tdizUopcADlXt5adPcC/An7L+CicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On+neItZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so240016f8f.2
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762686375; x=1763291175; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbXLUKgX0TjXrMF250y0CMZbN90r+Agvhxuop5xsxpA=;
        b=On+neItZlelMtvUVkVgo9Y2xdgyublfgVzh/IHCYyV5FlsO1s0q89HSmRQCpFdboxS
         8wjt0Zq8ONS2yOg8s8hDWBUrmK2h1XeBrKGGbvEr2ui2sMjuscOFh54XpWbpnDlAwzZ+
         qScME3QidRds+bAJUQDa/iPYLthbqkgJ+rwR8Vb8RTlWk81lW4t/V/RJjG0NpC+4EwFd
         MBTcMnz8bxlmMMAY27KUwPSPUEsLwk/YXmJlWua3LQ7oR68abYaNAuqAHsYrvTqL9RlE
         aYh7AayOlxiwgbtakVuj2FnY1QjrToET+7NLVbq9xu2KoaINhkjEF/qmtoq1nVhPH5Rd
         z21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762686375; x=1763291175;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbXLUKgX0TjXrMF250y0CMZbN90r+Agvhxuop5xsxpA=;
        b=Oa4XnVRh2xO9FoQ/0tc6UirzvEfVQrvfzzg5iEDey8j/TqZAGpU1VKK7AbLur9lq2T
         hh7BV3M9OxdjYi8uj9E3jToaKciCBkarw6Tqeo4U414s6/Q6M8vBoB92t/az6zkZJCfm
         sFnBv+ClpwUahwVkjnJWRSTZF3i0NKqmOs+TP2swiAw9uZ7CC9wRDT98wYJpIx195gr4
         Rs54hHGDWmZJKQzjMdeXjHgBloO/iMkj0e1wgbU3wRT8FGJOqiHylfEw2MaKUxFM7UZ7
         JgLbqfROCDOSUkmCjHz6u/6Uk9Ok0Z/eKu6qPsbVfH631ZIxYO1o4yvBVxiyB23iglxE
         2ruA==
X-Gm-Message-State: AOJu0Yw1msGhNYdz6uSFZ3ppFyoD61GJTDDZzsr7A/IdPiH3rfElT1Z1
	NUAQQ4gFLlxP0wjA4uwaACSEfy6PcmRTPySKiwpgotBDz4ZWlB/fjTSd
X-Gm-Gg: ASbGncuTS6rA5Ew6pNIb/mj22uWqpcZ0zUwLnk8v+0cSV4IKtDkJCm5PK9mxkt76sy4
	sJblsoQZdkZkvzEgd2UXmqotFNOeEkvzetJgZ5sZJWULu3pWEOF1ktraD769ZhLPBTav66PtS27
	NkJUvGL3hG84NNQ7G+9PgbB+s4HavAoXPKiD9tQ7pex4j91xeO19P6uq9wZP9Ia+9/9Ex+f4bWa
	DJsQBe/4x0wvnX5krvTSJUk4RHdBwxaAIb1xp9u7b5dTNejodAIhzm91HLLZgySYJObrKPAeK2k
	2BMDPfZqzPraSEGU8Tt/Ed9e9QwEZup2UIvc/MAVjima6KeijKNV+tAKbEkuoP3lj2RSKIW31+O
	HW9utl6HGvI36eULDSVlUBEr6JVGQBbDK9k+1+xngjtwWLw1baC1Zkwe7TbFybQndJ5+D/bNUw8
	JvoXZv
X-Google-Smtp-Source: AGHT+IHOM8dW1nNtCVe3CJGefgr1ytYvZGBfxsEPPKC2wEBPgxCwVt7raDzU9Z8qtaYHfVcnNwAhDA==
X-Received: by 2002:a05:6000:144d:b0:429:d0ba:f002 with SMTP id ffacd0b85a97d-42b2dcb7b58mr4045923f8f.51.1762686374822;
        Sun, 09 Nov 2025 03:06:14 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm6354925f8f.16.2025.11.09.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:06:14 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v3 0/6] netconsole: support automatic target
 recovery
Date: Sun, 09 Nov 2025 11:05:50 +0000
Message-Id: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI51EGkC/23NQQ7CIBAF0Ks0rMUApbS48h7GBeJASSwYIKSm6
 d0lrDTp8ufPf7OhBNFBQpduQxGKSy74GvpTh/SsvAXsnjUjRthAJiqwh6yDTzhCjs5aiFhxM/D
 xYfQkRlR37wjGrc28oXpeJ2tG99rMLuUQP+1Zoa1vriTywC0UE9wrUJJwyYQ2V7so9zrrsDSts
 B+B0SOBVUERmDghgvXjn7Dv+xfnBB2y/gAAAA==
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762686373; l=2776;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=De9+MX2vBk+SbIGIUhl/ERdEJOEzL0rWaAO/AnsvYOA=;
 b=g8BeDrs1E3DrUbsmWpHWBNWzcwWTIF2Cz1mzTszz480dnFZW86hvDQRQKf6MYun6o2xBPnhsB
 bPfqtOVGXvlBfukd0ByJSfdl2LyBDevykjLYfxl8VLu3/eb2f3pmuJS
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
Andre Carvalho (4):
      netconsole: convert 'enabled' flag to enum for clearer state management
      netpoll: add wrapper around __netpoll_setup with dev reference
      netconsole: resume previously deactivated target
      selftests: netconsole: validate target resume

Breno Leitao (2):
      netconsole: add target_state enum
      netconsole: add STATE_DEACTIVATED to track targets disabled by low level

 drivers/net/netconsole.c                           | 126 ++++++++++++++++-----
 include/linux/netpoll.h                            |   1 +
 net/core/netpoll.c                                 |  20 ++++
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  30 ++++-
 .../selftests/drivers/net/netcons_resume.sh        |  92 +++++++++++++++
 6 files changed, 238 insertions(+), 32 deletions(-)
---
base-commit: a0c3aefb08cd81864b17c23c25b388dba90b9dad
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


