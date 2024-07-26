Return-Path: <netdev+bounces-113257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631F093D58B
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 17:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C12E1F22D67
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC8D1CD3D;
	Fri, 26 Jul 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcaZyWa+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93CBA53;
	Fri, 26 Jul 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006307; cv=none; b=U5pSLkRvRZ6RyIQOCgZ/acx26OKgb0CMRzgueh5yCNWx+CUX1m0BBUy/AM25LXjBI/jJ0F5SDKFckAFi/uXxRKUH7XM1ZQMhIx8R0bTj8CDAXz2OQyReqROW4PxSFPm5aheVn8pFVql3Q4dsesPKyRxSW9kBovCoh7nd8oCdyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006307; c=relaxed/simple;
	bh=KQ+QVKQ67JPyWmdy372+U0rPCho3OrSUr0D1G+qLUHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdtotAka1GBrImuO22LZxcsjglRAZyxME5rkhzE8jCEXKI8vf2xY9bEyDL2nhi8wdmJWvRX9hBxr/3xlvu6m0hPqDLjtdJfVKkTINpf6S4KeuuIIkWSDm7NXhNs8+RlVlFHm6e5DaM+16A+I2I1qclameRQQfsiQiXtvnZlFm+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcaZyWa+; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-82c30468266so217705241.0;
        Fri, 26 Jul 2024 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722006305; x=1722611105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvj1Ca5nVOPovMpEJijtfF3dALD2KklkmvzpDeQp7y8=;
        b=hcaZyWa+73OKbULUZAG/HP34SqIOTfadMITneBU/lBPDGyhuBp6ialzxhA4STymT8s
         Bx4k//BjfDj2EKiKWbGyvDQeqQt0buhp+QSiOz8xzL94fd3uUvriQhF3YYYCq52aXgNv
         MO6OwooIfntLoR5FmvrQntk4fxbxL31UXw+jbO7eJqxGY+XHlp9BUPJLHWYtASk7c/aF
         ScflG/Mu+dN076USAUZq0DNT2WVpA3hHsM9jt56ztP3FHSdosEik2eo+pQmiMaigJaQB
         piqsnHiGxJDhUy3iNtvdEvxxuBoILnbaLbw98NkaRyul3WmT7hslvs+bJF+Ze6hq+b2I
         h7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722006305; x=1722611105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvj1Ca5nVOPovMpEJijtfF3dALD2KklkmvzpDeQp7y8=;
        b=pkMGWaZr9M2Q6nnM7SOOAbiht4is+3pdW/Iu9bVjUs1MqsnMAJ9zkE2tAKgZC6kx9F
         OrT5kroZprpEnvcgSQRETHvIgYM2NfxuKD3A5Evj0UEDfh95iMEyV+SFDNn2M2+HQKds
         6QibVtAVUp+oyEh1cS+EzNJb/AIgUJhEJMNoei1LenH/t18Iewf1SGswqBkpZozTEYTH
         xh+jcKgJe7+tnjaBHkiB1WqJRDgWpI8pmOAHdzENR5BMwTpBo5VhVVwAExotOE2OiiZT
         IxT6i2+uaTNro5m8WdMGoTLtReFJI+HjL4bTrJmskfqrkYohcTslxBijvxDu4u6RqxLH
         8u+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxlCihz/fD70gzY8Nc71l5eCEJ8c6zySCVaSiZbIczREiCMQtLGiLzg9z8V1L3nrrxoU3oUeK6U6IEMRwC0r+AoWUexY83
X-Gm-Message-State: AOJu0YzZA4PhhEvJCPzpEaEQbj88/7h/oZRlQ2MC2pm9nQ1x3C7zgl8o
	r2FmJSN4xYBipV0NCLCCSJuQTzZQIh8Ha8XLzRV609Yh7oX1ctY1R4SA5A==
X-Google-Smtp-Source: AGHT+IHPQZnid0m5X/U++vBLKieyuPShqbtLPr27CoSqUc8XaT1syY/6aI4EJGPZPdU4RqUrSynLyg==
X-Received: by 2002:a05:6102:3b16:b0:492:99d6:e71a with SMTP id ada2fe7eead31-493d9ae0f89mr5367863137.18.1722006304881;
        Fri, 26 Jul 2024 08:05:04 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-493d98afb56sm661051137.25.2024.07.26.08.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:05:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-07-26
Date: Fri, 26 Jul 2024 11:05:02 -0400
Message-ID: <20240726150502.3300832-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 225990c487c1023e7b3aa89beb6a68011fbc0461:

  net: phy: realtek: add support for RTL8366S Gigabit PHY (2024-07-26 14:29:06 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-07-26

for you to fetch changes up to df3d6a3e01fd82cb74b6bb309f7be71e728a3448:

  Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for passive scanning (2024-07-26 10:57:09 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - btmtk: Fix kernel crash when entering btmtk_usb_suspend
 - btmtk: Fix btmtk.c undefined reference build error
 - btintel: Fail setup on error
 - hci_sync: Fix suspending with wrong filter policy
 - hci_event: Fix setting DISCOVERY_FINDING for passive scanning

----------------------------------------------------------------
Arnd Bergmann (2):
      Bluetooth: btmtk: Fix btmtk.c undefined reference build error harder
      Bluetooth: btmtk: remove #ifdef around declarations

Chris Lu (2):
      Bluetooth: btmtk: Fix kernel crash when entering btmtk_usb_suspend
      Bluetooth: btmtk: Fix btmtk.c undefined reference build error

Kiran K (1):
      Bluetooth: btintel: Fail setup on error

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix suspending with wrong filter policy
      Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for passive scanning

 drivers/bluetooth/Kconfig   |  2 ++
 drivers/bluetooth/btintel.c |  3 +++
 drivers/bluetooth/btmtk.c   |  5 ++++-
 net/bluetooth/hci_core.c    |  7 -------
 net/bluetooth/hci_event.c   |  5 +++--
 net/bluetooth/hci_sync.c    | 21 +++++++++++++++++++++
 6 files changed, 33 insertions(+), 10 deletions(-)

