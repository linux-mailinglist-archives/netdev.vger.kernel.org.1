Return-Path: <netdev+bounces-194408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF7AC952E
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 19:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A0D503BE2
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97966277028;
	Fri, 30 May 2025 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBEkPkI9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070AE276047;
	Fri, 30 May 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627333; cv=none; b=RwVO9sGkM5OIAYEdUke240LDvGC3JXZaROLmSNrJpONQh1hHf/AKRAR7LM9ASCUXSRm2H9rdV8k7avS1Xu4354Aa8D4b1sQECWB5cDz3/z9XVNLWiyJLc6WqZB14TpTTr2epKS5DfvI02p5sUJDPzPcFTkh6CSsgC+LYIOAvPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627333; c=relaxed/simple;
	bh=tlGvB23HgB3MCj5JcK0oieRd7G9dT/6gZYvwNM2szAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXZviRprvL21du4a63czNb7TQceUlqPS4JBb8kWEez30ygyIOrNoqJC2rFrO6Vjtop2U8FLjl392f/cQWao+AxVEevfpweY+LFPvlux5CmUFQATx16+d8VfbpU+7h39FnScHI2MghiPkBGbfsIqeYiPQcfwdxqwvEagwbpM2yEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBEkPkI9; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60d666804ebso98500eaf.1;
        Fri, 30 May 2025 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748627331; x=1749232131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/g3u25J2guT7L4VE5O92nLblx1dmECZ99EqBmpf8Vk=;
        b=UBEkPkI9wqdnwTRClvXOPxLJiCcOdKOLNk7oN5qC1BzFKyQNSo/RHVlGXzB0Xq2mkg
         GrSGCzqeT9XODLooq7uVWpHn33P9THmBCDlexuZMT+w4dPLgDC0Ks7whzbbMw9VK9AII
         pTx5P9EY8d0rytWCyERdXtkYKWv6FVcrezxq9r+wmfkZ1QbV+aR7NzUgW9l6FduVDjgJ
         4r20Cv4utA6XHIt+2jjUREDBie0LRz/BuAypLfJyKpZVOaP3X4LDfDz6DNgJGcVNYG9r
         hvBBtdoLqPWVM4ExjyPI2tV7MBgddBY8vWU4CMSUaQgWIQvbEwAR71+UP08BfkcUd0Hs
         yuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748627331; x=1749232131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/g3u25J2guT7L4VE5O92nLblx1dmECZ99EqBmpf8Vk=;
        b=Hn/Lvtrig73CRXCv4bb2KU1Ds7E3Kxq31Gqq0qCKU+HbtwuMQn3oJNCGFkOtX0Nwmn
         AjcXPAxioCzjmG2yS+uET5kFUEI+Onus8cg/1Eols97OM6siYqxpIkpBmN+5KNvwVCR4
         t+kZ9XFDdiII1ujmmXPH5BHyoxefPkjFFxVGeJZ+Lr2iJw0LYiYPpkWb+IEmJ7n1b8ib
         s5B3qfLl46KMFwa5CV0xSw43IXBqKPk+iCd/9oWUdjXgvgtVB+p84QdKytMJqTHCWhzN
         HMQ9fLCCBDri73kJ0IF8LTozIIrivqxUsQjZ44ZMadV4BRl2gqK7ifxKdmyNaDjRi0/5
         +gIg==
X-Forwarded-Encrypted: i=1; AJvYcCWaCwAfQKUKc7jv5STwR5k3BdRVloY3nM5Xowfs7zEXIZNs1pg91e5ynJ4+HV91ANqaBuqZ5O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPxY3ScdPilY0eaAxcO29qtdo7wOYKJccpE8lj54MQhgnuiKV0
	AQFKH8qA1NcdvyAc9BzY2GKxOtWcvQxiOmG/mqgBqf6pMzSx2D2+KpDdh4J7IlWX
X-Gm-Gg: ASbGncsUGexGxX1ckjBVVhKDgnOeApbj2x8sFoluGMAVGQlyXyoN9WZu5IhH6gFVWxV
	+r7IF70r0MD7fX6EJrYGuTmqr0uLvhnpZm/9zcRt0UU8YpF1IWlfZM35PkaKkkQ4a2XlBfkH2O+
	QrhV8eepzgJabblKaxVcPpFyLE733AUtIy4JDIjKfs1KMU09aP9lxBkROEvZpjH9Y88XgpY2LWn
	K5AeZzRZaB0Far+Nh+80KsZaF3rsx5b7iFwHCnllfC6D0iYcLjtnDNulP8mf/7LIDb+XeY+bYdd
	4VDCH0aREQrwFsdkJ7yjXlL07glYXMVw1FZQ3LSRCqycuJTL8ttk68BeqxK+Tyy+1mb7xz1E3I3
	lADad0HKNUvlTz3DnGmxT
X-Google-Smtp-Source: AGHT+IHYgUTy2G82ck29BsrQFIKQffkuT9AeH4iSU9j0HGs4mJWWmJ5+fgwpT53hTcBzrynbhq3ciA==
X-Received: by 2002:a05:6122:7d0:b0:530:5cf0:8187 with SMTP id 71dfb90a1353d-53070f99bf6mr9424596e0c.0.1748627319926;
        Fri, 30 May 2025 10:48:39 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a2a2f46sm2956557241.12.2025.05.30.10.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 10:48:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-05-30
Date: Fri, 30 May 2025 13:48:35 -0400
Message-ID: <20250530174835.405726-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit d3faab9b5a6a0477d69c38bd11c43aa5e936f929:

  net: usb: aqc111: debug info before sanitation (2025-05-30 12:14:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-05-30

for you to fetch changes up to 03dba9cea72f977e873e4e60e220fa596959dd8f:

  Bluetooth: L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION (2025-05-30 13:29:42 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_qca: move the SoC type check to the right place
 - MGMT: reject malformed HCI_CMD_SYNC commands
 - btnxpuart: Fix missing devm_request_irq() return value check
 - L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION

----------------------------------------------------------------
Bartosz Golaszewski (1):
      Bluetooth: hci_qca: move the SoC type check to the right place

Dmitry Antipov (1):
      Bluetooth: MGMT: reject malformed HCI_CMD_SYNC commands

Krzysztof Kozlowski (1):
      Bluetooth: btnxpuart: Fix missing devm_request_irq() return value check

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION

 drivers/bluetooth/btnxpuart.c |  2 ++
 drivers/bluetooth/hci_qca.c   | 14 +++++++-------
 net/bluetooth/l2cap_core.c    |  3 ++-
 net/bluetooth/mgmt.c          |  3 ++-
 4 files changed, 13 insertions(+), 9 deletions(-)

