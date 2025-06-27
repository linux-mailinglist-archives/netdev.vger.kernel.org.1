Return-Path: <netdev+bounces-202011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA20AEBEEF
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E019D1C4020A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E992171092;
	Fri, 27 Jun 2025 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALXY9nNw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33F2F1FF8;
	Fri, 27 Jun 2025 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751048166; cv=none; b=W5SiClMUrTuxkQ7mlSZfELNF+Pi3Rv72mKPWe10NeXJIovpUDLr3cDhujXD+mPkB7/Imq+tT7O7Odlck8zUWXXlsQKB5Ew5nPVpdgweNPurgWvGf50Vh8Uhil+Yj19xWNgMSH+FHDSqYa8VbbHsdLbUZWOa0lMdMryEG8925Jyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751048166; c=relaxed/simple;
	bh=cWfp2bVZlb5/JYVLvEWhQVG2ghTf0X5peEWW2OHHyNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ElAJQEQVQT5TEh2k6BvJzb8zlXKybQ9vKF+Wguv8rcpMbJSqdbnEvEPyXqcCovNAlulcptbBzmIadz25SEZmik+A9cSl74Iw+jS3u2OFrYX+2MLGfPV4A73xzTYVfsH+xmC+qaTqdC5uVR7hm5YWirvz9/OHsDpL6kqy9yck7hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALXY9nNw; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87ec9a4c86cso675900241.1;
        Fri, 27 Jun 2025 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751048164; x=1751652964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OREOvp6OrkVWubltBXib1I/xwDpMOns70Qw+MvbSJy8=;
        b=ALXY9nNwCv9ViRL/qLXXJWqN0Al7XZ9nL8vG135vnEFxTKKPnf9gfkCQKEVEirO9TZ
         PP5SfiVkecQ6K6sSgeoODFYUX2O2wwv0DzqkNheidxjsNSmymdangYJx/YFZ62tCS956
         RPEg+oO3g3a1mCH1HOPk47r7VTHQ4dfd7wZlfApoPVlWGjp4MC2jNCV6KA6uRCfhAZBQ
         GA79bg80CmsT0YWI7ydZ21TA3Y/GBjof1oDxJ7FERq2qbdLS7+HAzT0Roy9cFKLhuxCG
         Mf9oMCBPKVXdX5SQgjdIxigzHSTAeD5KP6uyl9ROgh7g8Jpf64Oydh8shURCQIsVBvT8
         Xj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751048164; x=1751652964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OREOvp6OrkVWubltBXib1I/xwDpMOns70Qw+MvbSJy8=;
        b=eOXmhXC7sN0Q/84c3dqPCfl+bH0E22Vp5NduHwchdVhQoHxAvRZy+WgmbMHT91kPML
         5E0CokbXcsW/9rkEAfpNp0oCMh+BasfcXlP3xhVsZPSJgVMeP0lLuas/wTM1aewXl/GX
         wdyqXBi8a3tv9DVtkB+lB5LzF3uyeJOy8ucb7/6DRlF2VkcrfctfjE15CLREXbic5MsJ
         d/6fYBHivW21uL2eniHHA9defg4e450HDysHX7Fqj7JInJogHk0Fwy0xMEpdxga/r/oB
         SfPtyYYsGS/uOZOGkThr92/WrdI1vQ6pQImA5BXUTGpOBzTE4ToQ45XISVu37dtQPObd
         JmeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsgb+dEU0MuySjPhVHuiKx9bnalRqpNz2sR7dItiBGSQsfERauIDru4XuwFZZ8mC7dw9OxtlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZ4Fwwf7olSwWKl7eHsjNcGMbvcrvUFkkq9L6he3nLxAeB6Ir
	NPrkCkRQPwbgH4ASmxaTV0Ran8F8XgLkP44hI0cDaGT41kDneCvrbGEguKQF8KcQ
X-Gm-Gg: ASbGnctXwvWkHqsZk3IIPpubgCQh3ctSydOHdbRWoBmpiyVRL5lkitgysTyFzjCdfW4
	3gVYUq5QH+7ufP7he/wiMXuedgHRqhvN5LWt97LPk5Ia3cd+LXRCpJNKrnHL+CN4H1ciK9JkWKh
	v3lxUzNL4HZ0Sow7qq/GHfRxxSGJyY2CcDIxvd05JUP0KA5myEw1ZaDRUyS08UeyQV1dogzRoVF
	8eHzamYUOeuvcG71cqKK/RwC/vFbcgZymsSTgqAVRbGKv5e/hDi0xYC7+/p/ysc99BaaR779sDT
	50CYAVLSPmw6/utAJEXjl9JxFseiAEKo9EVzW+ao+5LH3K+lGzHP33ccQFi8Kf6N14hZ/BxxIP5
	e426LCuVuMlpT1WmLfz28Y6aqHIDN++CsLSYsEtETUQ==
X-Google-Smtp-Source: AGHT+IGuHJICDu9mHHzGHdyjQX4ngPApiw/JgpiHVRHDGZjOESn1dKwpw7fJQDy9cr9ZANnPUd/QWw==
X-Received: by 2002:a05:6102:e08:b0:4bb:eb4a:f9ec with SMTP id ada2fe7eead31-4ee4f78fcd8mr3126961137.16.1751048163625;
        Fri, 27 Jun 2025 11:16:03 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-884d1d87dfcsm638021241.17.2025.06.27.11.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:16:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-06-27
Date: Fri, 27 Jun 2025 14:16:01 -0400
Message-ID: <20250627181601.520435-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e34a79b96ab9d49ed8b605fee11099cf3efbb428:

  Merge tag 'net-6.16-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-26 09:13:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-27

for you to fetch changes up to 89fb8acc38852116d38d721ad394aad7f2871670:

  Bluetooth: HCI: Set extended advertising data synchronously (2025-06-27 14:01:20 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - MGMT: set_mesh: update LE scan interval and window
 - MGMT: mesh_send: check instances prior disabling advertising
 - hci_sync: revert some mesh modifications
 - hci_sync: Set extended advertising data synchronously
 - hci_sync: Prevent unintended pause by checking if advertising is active

----------------------------------------------------------------
Christian Eggers (4):
      Bluetooth: hci_sync: revert some mesh modifications
      Bluetooth: MGMT: set_mesh: update LE scan interval and window
      Bluetooth: MGMT: mesh_send: check instances prior disabling advertising
      Bluetooth: HCI: Set extended advertising data synchronously

Yang Li (1):
      Bluetooth: Prevent unintended pause by checking if advertising is active

 net/bluetooth/hci_event.c |  36 --------
 net/bluetooth/hci_sync.c  | 227 ++++++++++++++++++++++++++++------------------
 net/bluetooth/mgmt.c      |  25 ++++-
 3 files changed, 162 insertions(+), 126 deletions(-)

