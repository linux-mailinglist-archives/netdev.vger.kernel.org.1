Return-Path: <netdev+bounces-239860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B73C6D3C7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 319AD3497EC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471C73203B6;
	Wed, 19 Nov 2025 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he/9mJoi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ABD313267
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538572; cv=none; b=ZCEJj2pfthKgoAErPVqhJOxvoW7CaHd5JIKyoutwIA8WfTV5lYfAKL9cqKRzMeQ/yJWXLIDBqNRYc/9KFzhzu8m2BJnKYZz46LjyA8nhzrUcL0+Wqmx0AMhOm5REUxZDhNqLMxmi2lP7VciTK6JbB6pqueBFidYcJQ8QrEFE3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538572; c=relaxed/simple;
	bh=opOkTKn6ORwriqO6kn1tWrJThvcbKhHAemrAcyV1Cwk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JolrO9AaJOWWnfYWQyGCBiRyjui69BwhO6LYnWIcC2sV/VmKql2wcz2no+OVlGfaI95YoXqETkknu+K/tXbHbOO8M+9ex/2/KBNEg5ZOTp36zdDVFYpOhhB1eZD59zKGfRAN0L49yPWQhuPzAETUPwtSvrkky6iFHoyGGvF7zA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he/9mJoi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b31c610fcso5440902f8f.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763538568; x=1764143368; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIuQqZRadnavbcOLO6rl23QAMdQFOy9Z8c7jjTJnyNk=;
        b=he/9mJoiLF5oAyQAIG5yEeGSnmWSzNA2JPbTk2FqalhdSaaWcIxOV6a3Yh8yETMKPd
         RgN9QFMv3Wapwk8KlMQPuivN9LvIcxZQkHG/u24iYX75fYpka0kAuorVT32xbAABfzy5
         h++rP+FsdKBtLtamZ+5D7UTJVqIdSwTtQKpETCuNoHzpIrOdjklBQzhnR6pH7Q1tNjdo
         bf3zA5QVOMoiHRmxl/I3En9ydh/0nIRim8KJYk94oR6x1eWF07A1IpPsgL+e+YvaieEJ
         nObDY6dG+NGpuw8h7DrxevGrAkPPO7ZJ0qxtAusGjMpQOY4xj6vcVklim8yWmk4h6apH
         4lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538568; x=1764143368;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIuQqZRadnavbcOLO6rl23QAMdQFOy9Z8c7jjTJnyNk=;
        b=A3SLDe/Wne2OIgwmPDDuCcUF3eDf4SP9dJojmCY4AYht8U68JRJe2KGSAMo6QCuLt+
         0T1O9YhO1T4Pl6EupaydN+1QbDiLQU7KgJf9ImfJlLnkRCCglDPu4fV+zOd4QyguwQ5J
         1LI6lsAYJb9zPH0hvmRh+/nTmFbMB/Gf6B0G8CpxPcD5knZitmYPSG6FyVCjvmGQn2o8
         2bhUY6KD4IUQOvgiN3DXTbeSu/41p2tDGpgxrNLwuX3chDKxabs02bc5mx17be0O14oa
         X9MeeT5RTsEo/gg795AdDpGyFUYJpwwFScEHLNERD7QloYokyZCJDlU9Rm7cWFZP6NRC
         JmCA==
X-Gm-Message-State: AOJu0YxcJSQ8c2D59vOuRvHQRF+kF019r2LeeiQWTPSqMTJbT+r2djcZ
	RuUHVZ05xrKm9gN9QPdWKrrfKxNQvn9elE/fKW6CYxpdhdzTBYibBboA
X-Gm-Gg: ASbGncvSEYg67Et6OJD6eRjqBX3hmAjYrbKIdR6YWw3Dy1BncD3z5QeKAUdJMclTy8J
	JJzve5P+rLvOgLB/MKhrU/ibD8Ky/+ceeDMAdUf0jRJH5bjdl/UZTwSSPDqFIp+A9RiL6L9L8M+
	z7lDdcMbb4Y5wF2F1RLl+MnZc1xCoACKtZhpH8W5QIUuHsN2ZQt8pgph248wrly+oHFCk/5ViNu
	FK6F7eve1DcdebJZM4XnQxe0gfEqDfMbQiLQrhXWlU+5JAupNiC+pDAYljO35ete0OUZJHvMsnp
	26oF2ZCLPtHhCHG4xn0EVzAF76pMJl6nmyOXdcni4dEmDe/w+P9uk6Az3GgRf390u502FanhLor
	/xga1S1MLIohtqYsHY173pLq3/LxyJncEyCsrOSPSVKt+Vcg1ctTvWzadl/TGtp5avTCjTFJvGj
	YPemYEZtFIt0MVe8qVyjMLyX9vtg==
X-Google-Smtp-Source: AGHT+IHAVxC4q5FzOVYKsvXozzYgbW4vksvPBg9sojZ5ygQr+g8mJtC8hQaxXCtBPM8szGmEshmWLA==
X-Received: by 2002:a05:6000:1848:b0:42b:5603:3d03 with SMTP id ffacd0b85a97d-42b5934dea3mr20229708f8f.25.1763538568043;
        Tue, 18 Nov 2025 23:49:28 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm37461146f8f.19.2025.11.18.23.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:49:27 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v5 0/5] netconsole: support automatic target
 recovery
Date: Wed, 19 Nov 2025 07:49:18 +0000
Message-Id: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH52HWkC/23QwWrDMAwG4FcpPs9DVmwn3qnvUXZwXDk1rMmwg
 +koefcJH0bochS/9EnoKQrlREV8nJ4iU00lLTMX5u0kws3PE8l05VogoIFBWTnTGpa5yExrTtN
 EWXodje7HGAbbC577zhTTo5kXwe088ljFJye3VNYl/7RlVbW8uQ7cgVuVBNl58g60Qxviebr79
 PUelnvTKu4EVEcCsuCBBg1gsev/Cd2foNTxDR0LyhodcIBxJPsq6J1w+J2qWTDoYDRRaQi4F7Z
 t+wUXO2XeggEAAA==
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763538567; l=3381;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=opOkTKn6ORwriqO6kn1tWrJThvcbKhHAemrAcyV1Cwk=;
 b=ncaXc87VvlMerGj01P/l/ztTX4sAbX2vCjMPpqStYxWAyZHflxZY5gRHQ6e2JZVdIxxw3IIk7
 UPJlaYAtAyMB0xRQM8b4wtJZdcwtYUGefmelMhZnBEkIuANk2zwB8C6
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
base-commit: a057e8e4ac5b1ddd12be590e2e039fa08d0c8aa4
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


