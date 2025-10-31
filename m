Return-Path: <netdev+bounces-234709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 63513C264A2
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F3B435054D
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964462FDC25;
	Fri, 31 Oct 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsbA4rGp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5852874FF
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930612; cv=none; b=EUlgh5gUY0xHsCEH6v9SdS0LmlfS+AjFXIABu2Qy+qlPGOHJ21gvDJC29lijPR9tZVXTaEjCnJmHf0wHt93FW1cHYeMp4nPWyVRv/EAkrWOOnpouSX9ZkoWezkilictXJypzjGYRDLz0PkGCSasqlbKncnRCoQY+mBV8MIlDJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930612; c=relaxed/simple;
	bh=sacgGx/GVrImIcs8thwdi9BCiZy6Fg/WIqig042/jW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7bxuQv0DlXY1yky+lD5k66SzDauvePBKBFgDSLFvj95KyQIvEW1AAtCVzvvHj5Pic9LrjEbGFZvgaeiwErzWgO89j/ajpzu2oVW29ukAiWfV8YuL2AIPlYiXF0NrHlODWDEC4/PIyKwkxY5zjf7YkY3EJ3PbUagAlWff8IlQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsbA4rGp; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-932bced8519so1928681241.1
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761930609; x=1762535409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jR1J7NnLKHUT4xJbBKdvua8cjhj47pqW5fVpAcpn/qc=;
        b=QsbA4rGpwL8hUrwazN44ZVYSn8GKM/Jti/obY/uLUgTl6/WhXnAYuxqGwIahJ4fQ0p
         7XzK0eL6RyYaA0Z7GErzEWJYpCO+iZ4noCxdEd1KPROBb9iQQyvNbzi2z6eT/v/robTL
         ESiNRntC2JQXP6fLlS2ULuHe2WAEdcpdoU6VH4C6J/SZeekfREMlYkfg18pU+U8bDA1X
         10KnoO/sMPA88MxvZm7hJtl/stOm1BaZudEhCNR6kI2h+p6PDqCORvhgk7d3D/vQIp8+
         sZnqucjyK3Z8Ic9+/LFa0xjVmDnjwS2uPrAkTIZW96/2SUUzRsdjoJE0Fekqb/mbLQV5
         sGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930609; x=1762535409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR1J7NnLKHUT4xJbBKdvua8cjhj47pqW5fVpAcpn/qc=;
        b=msC8Uim8OwkyjtR1gvt/ZEj2jBZ3M2KskQA8k4LW/Zmnm/btybhn6K8tOmYhye2W65
         LOZPJaP+8GJhuKkVMrqpT9wLX6nUaeNc+W+vESq2QWLB9k6JoHXvZJYz3OqlOHY4NKan
         0X5MT8AUWtvisTEkeLHqw9owwn+9KoH2JNj2U/661Zw8P6tSxgqZB4C7xeo9Yo8Vmd43
         H7I+OEbRQjTM6+I+kxF2uQG3RNAVU9xP1fuL4RwgJblAOi+3qL1XmeHTwtr+7MBa+wRG
         6ZDml9J7Wiw1UBMl0M+BPplYwTrDYCHqJ5Nufw6W8Pj1zwAgwyLdvVDKz9AbUDFO55IW
         /mlg==
X-Forwarded-Encrypted: i=1; AJvYcCVAmw+LkVPwGPoBl2yiShFnkPO5eBelgEibtUU1kymsHGRrF0AeRWq/Di3r5frpjs7H9/q2z2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNLQCDO6SVL1D2XhlxBaJrnKYVwhqAZhDTcC7Oh4YkRo+Fjr5J
	hrTIBhk7Cwpgo0P5hMh4BniRXXRpWgKSNuk/Ig67UrQdZsCRnCelOj4O
X-Gm-Gg: ASbGncus8KGjpP4o/kmdzVvphkwLKUSCju6MSz/x6oaLUq53+A2aqlVcDxGlCZ2BSex
	HUjGIFf4Y3S8XuAYoTmueV79ipUDXYKz6j4XX88S+/NVlMVnAy2xFZhTjqDvC1GM4qaU6u/UEQw
	eEcuNCllyBXEcp3cjm/ngkzs6gIZgHMLpwvyb4FIVM5r/UdyzaCc5hoFKrfbD6v2sKPFy2i4bVA
	rS+Jj+DZs07gbGu6y62W3SJFNIeJtAr7qS0a3ETDx2jorA8i9XByDD62GE8LyNSiNyeS1F9oJKT
	CgZm2x24tBMEnNhKdPV67OZBRZlJlmR3qqHOEuo9lSdBkgWKvkADMKPWeWV/TycsF7RsPUTbGY1
	bwQ7XOq3XEYxjVPLNj3fb8Nr+VyPbHqrdpFzwCL0IY40043esaxK+YhSLtyfXCp9hBqrJoX1sA4
	0CFK910UkQi/59qg==
X-Google-Smtp-Source: AGHT+IHnRm6voXZ9Ob6nAdsDZZ3Un9LS2RDQTgjeNPQITX+56VP+lvrYbqqU8DMB5s3BG4brXIRziQ==
X-Received: by 2002:a05:6102:38ca:b0:5db:3d11:c8d3 with SMTP id ada2fe7eead31-5dbb120649amr1543165137.8.1761930608720;
        Fri, 31 Oct 2025 10:10:08 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93512a32168sm779791241.2.2025.10.31.10.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:10:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-10-31
Date: Fri, 31 Oct 2025 13:09:59 -0400
Message-ID: <20251031170959.590470-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e5763491237ffee22d9b554febc2d00669f81dee:

  Merge tag 'net-6.18-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-30 18:35:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-10-31

for you to fetch changes up to 8d59fba49362c65332395789fd82771f1028d87e:

  Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern() (2025-10-31 12:43:05 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - btrtl: Fix memory leak in rtlbt_parse_firmware_v2()
 - MGMT: Fix OOB access in parse_adv_monitor_pattern()
 - hci_event: validate skb length for unknown CC opcode

----------------------------------------------------------------
Abdun Nihaal (1):
      Bluetooth: btrtl: Fix memory leak in rtlbt_parse_firmware_v2()

Ilia Gavrilov (1):
      Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: hci_event: validate skb length for unknown CC opcode

 drivers/bluetooth/btrtl.c    | 4 +++-
 include/net/bluetooth/mgmt.h | 2 +-
 net/bluetooth/hci_event.c    | 7 +++++++
 net/bluetooth/mgmt.c         | 6 +++---
 4 files changed, 14 insertions(+), 5 deletions(-)

