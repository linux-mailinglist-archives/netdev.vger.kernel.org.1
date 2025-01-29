Return-Path: <netdev+bounces-161561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B611A22567
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 22:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6131886E4A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 21:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EAE1B040B;
	Wed, 29 Jan 2025 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvLf88tf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5381E9B26;
	Wed, 29 Jan 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184463; cv=none; b=YAnvIDNjPp5jaZ/NdQHZrKa6kniWXdcLalfh0ZHXQdfh8tPxGfgc1Xb9TrFkC1K25xdd2i1gsgf1bP2hfMepySHA78zZ7z3RTbr0k50E2qFG22sJU8u3rBDRti4F5opGmczkwpy5ZItoQq4dCxzj7B0wLf0MUBMbLSG0muQZ/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184463; c=relaxed/simple;
	bh=3918yyY/rmiIB8dZr2zN4aDK7nWlHPADetn5LSMjFQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGhiHJEk4SaryvdDirXz/tA5oeBdBVq4/LWDAjjop7q3cySsU8hxQQJ0v/eIEepsYxzRLVR6VvfS163aJ/pC/C6dEsYXrHWQq0Z5CIc2lXPBtyROJ0/E+Zl+E8SWSr+2H6h9BQMnvDDTRTl+6pwV46QllDWVf67ZLFH9UiATPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvLf88tf; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85ba8b1c7b9so21165241.1;
        Wed, 29 Jan 2025 13:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738184461; x=1738789261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ochc5UOkCdW3bUFvqMywnHFt76blntsb/2IqZqQT3fc=;
        b=WvLf88tfjxCvNuFU6WYmqHxlHSPn5v5UxCdObpKtHzbfkR2oHTglCOTUFfdLeCuy52
         937elKQ5vbniGj/M3xiu/l1TAddGy+wkhZlRhn2zyuSPor0w0urk/fbkkAbsu44Pt27T
         pZQ6+bGoMUmxctpuVA9s3QlV7OI9NfPjmsusgxpK6bNATaxL+I5yc3boDbTpmf57PDgj
         4R2vdz9hRLICuGGul1GCUkeggLQFElhLyUyvw/uSvurrreEnpU7ixsqXgl9rduXD9Nkp
         FgpXZf+alqANQcbFyys5dbmv1B8eRPkGthBmRyfJripzlvf4XOXYPG+ufFI/SiwhQjgH
         l4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738184461; x=1738789261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ochc5UOkCdW3bUFvqMywnHFt76blntsb/2IqZqQT3fc=;
        b=jtxpUAxKuezWeMgfCDIG7u3z3G66GHNXqZPygUsTY1GDTB4wvKz0GDVV93hHBxrb0+
         phXj7BJnnAZI7SdTHQegzr04cWHn3oGNT1EC17c7gIFPE7h3dQi7l3uHP3ImJiuNezRw
         wcC4/FYKW48QRD6D0zGRhAArnKHlFUn8HPTZ86XdI0mq57iGJ/48769c3K7lcd3SOlZr
         DFQZIM9YRSfaifEvYw7wzSm7lqM0c7zZVI+4uw54uzl+ShhbKD8Bx7jIFTUfPNziX4cK
         5taV0yKtI1/9Evoxu5+ZewncSbmvaRmBBiUvAWm/YwFaskojd9gNXzjAxepJjXV6hVDs
         81Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWY959gUK9RqweLO0++XMaXHl6/nxUikRp3nWh+K1sj4hCvVDJoIXi5OWuIqr8L0S8mR4C1UMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOyVNJskX7yBW+zbdo25WY0q3Wz89NVUNO859UDaWHjdoAZKW
	StpIdNkQdva4HiPLGib++OsT+7h5MiWTDmnWWWL3sPDGXa28XB/l
X-Gm-Gg: ASbGncuBz4RKh/TujXXgeoVOXJWIo64W3S2eST8tVzukar8qNbcw6f3GdziVP3u2M1+
	T8GfkIeCOvWwESQUpgpVz/+FeY2A4qf7dSZgrDK2wuyZX7F97xLL9ypy4vfebcsDBmWMmHrDb/h
	s69zHXU28fc8fodIS+0yQ1WheYQc6Y7gxvjMCvSeaZaZEU9OBWl/XMhChN1LOWHJx4/EVM0M6lG
	jhdIUXYLxmPDx2XRpce830q5y00G4hegTL0oIvetcdXCL+QQOpyaqrJJLwFSapl915xZDkveNMg
	Q/5W7AwjwKiKvYQpR5jqahK1avgQeuuAIVOsBQ2XNStPZgMEdwnVLUfxipZfyNg=
X-Google-Smtp-Source: AGHT+IG7o4TSaXqi/NhAyLNQgLpFwufuG91cYViGvbIoStH86vNB0GmJuKk4cDOM7gYh4by7dj1TNw==
X-Received: by 2002:a05:6102:4647:b0:4b6:8cf4:9a23 with SMTP id ada2fe7eead31-4b9b6e55634mr1052977137.0.1738184460800;
        Wed, 29 Jan 2025 13:01:00 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b7097ab10csm2857516137.7.2025.01.29.13.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 13:00:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2025-01-29
Date: Wed, 29 Jan 2025 16:00:57 -0500
Message-ID: <20250129210057.1318963-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 9e6c4e6b605c1fa3e24f74ee0b641e95f090188a:

  bonding: Correctly support GSO ESP offload (2025-01-28 13:20:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-01-29

for you to fetch changes up to 5c61419e02033eaf01733d66e2fcd4044808f482:

  Bluetooth: L2CAP: accept zero as a special value for MTU auto-selection (2025-01-29 15:29:41 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - btusb: mediatek: Add locks for usb_driver_claim_interface()
 - L2CAP: accept zero as a special value for MTU auto-selection
 - btusb: Fix possible infinite recursion of btusb_reset
 - Add ABI doc for sysfs reset
 - btnxpuart: Fix glitches seen in dual A2DP streaming

----------------------------------------------------------------
Douglas Anderson (1):
      Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()

Fedor Pchelkin (1):
      Bluetooth: L2CAP: accept zero as a special value for MTU auto-selection

Hsin-chen Chuang (2):
      Bluetooth: Fix possible infinite recursion of btusb_reset
      Bluetooth: Add ABI doc for sysfs reset

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix glitches seen in dual A2DP streaming

 Documentation/ABI/stable/sysfs-class-bluetooth |  9 +++++++++
 MAINTAINERS                                    |  1 +
 drivers/bluetooth/btnxpuart.c                  |  3 +--
 drivers/bluetooth/btusb.c                      | 12 +++++++-----
 net/bluetooth/l2cap_sock.c                     |  4 ++--
 5 files changed, 20 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-class-bluetooth

