Return-Path: <netdev+bounces-199909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C81AE21B1
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6C416A7C0
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5DB2253FF;
	Fri, 20 Jun 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPN/hXpR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD01DC075;
	Fri, 20 Jun 2025 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442274; cv=none; b=svcjgOHJ/uCVADWGhbXW9hoNjWzuXfqPIyX+fuHDVqIjC1qKk1drdJyqdEOwR4L/8i6Hu2D7U831VG1U7Nw+kiJypMcbAb0BUxGRXrI32NrWWDUIZrnqmtd7dZWtVt9yiCgqICw2CLR6HL061QQalW1oddJrGYThLI4fwlbKyMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442274; c=relaxed/simple;
	bh=EWo+vO7NwXKOqzLI9oD+0pH2eyhzzkeu222Y4Y9iZBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S7gSHhUi7AvElOgtWNppoK5xXQ8hGGZewOu9oJrmh8y2LvWSrGiUnIgmkHyCFIOSXqAQVf+/bAgQqhErIozsAI8Pq4yu4w747WKM3tQlJlnOtGuDVXTxzM6xTcC2ZkA8/fm3HtR/gGMkQlD2hVJHTbiUrbVtRWgy/GHcwkCzMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPN/hXpR; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e79de9da3fso506973137.1;
        Fri, 20 Jun 2025 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750442271; x=1751047071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dTN6QDFSAz7JksbmwGSqIbfMsx5HS2BaC4Jv2w09ciM=;
        b=jPN/hXpR8wq0xJGcVlEQCUQxQPvbp2jbiMV/qxyCFUUq5jGZVtxEPXfYcu5RpDYTbF
         MPkw5JMkcSiGh0tfmlJYTFH3M5FL7SAqX0ecMjds8hvKdMkfwL6UpgX2mAcUzAJ0WxWF
         x47FcP0Jd9q5wg6LTuH5Fe0a6JIy3UiG2rn6SrJvmGZLHLOqmFqt8pI/SltVStVwzrs7
         fuLRRKakEYOWcPFTggYh4Jw+gmqgJ4ffhSvFxbnjivsQvwNAtZRf4IkYRyJiUp+awdo8
         kkhTI36vkkETe/XU0VEUQ3+6pJZ7il82T1JaYeFsHr2ZkHrRhaaQxR2Tz8QK2G1rF66A
         8BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750442271; x=1751047071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTN6QDFSAz7JksbmwGSqIbfMsx5HS2BaC4Jv2w09ciM=;
        b=gUOT28LV33dSsc7+uxcLojR1nNoe2/EGcfACuk4JE5TVrpgnz/M6nXvqKL83cCqc1I
         uN7mxA4lvrtAv43+3pH37HzgfTcVFda5r3CJ2rTIA2HtqgTiM9zmAliWNszks8z1X6Dp
         ts3mroLlnKZktqQoGrIcIE1q6KC9D+y4WscZY8XMzZ+7xa+SsGxzNNnTViLURgCGAA0v
         9om6G/T/lNQogQ6Q4ZXPH9n2lpa4b5NGi+xmYNI4PcPNRbVXsqMezUkVJj4tIgHAMBka
         RWMGuZMXvuyIIGxRgkgYhJ9DUQn7TUWeXVmLLB0/8sFhZSgI4L+CyxU3E9PIKVcJTsK2
         4cTg==
X-Forwarded-Encrypted: i=1; AJvYcCWo4Rba3nz27KflYTn8g4h6XYtNam1P5oznJwTLTfDp2eT+RcQU4oLpqMPMsLtd3fnNjl1FL1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz806EZ9KpoUxdvctjEAj+IyYh0oroUl8IGUNlD6HuKKgE+Wh+q
	D7NY2SE38Dgd3payw7TAOPkFlEh+xhlJKwCJKCMfvGPXMZyJG6IS35hnCJWpsR196/s=
X-Gm-Gg: ASbGnctKB1CkGsTnXOWBeCzubLl7W2SloL0xioIWJURpV5cVpvFSA9vBgYplpcF2QZJ
	LH6DodUFo05VA/Fk9Dw4mJ6wC7JPIzXKaQqZgKzELHY+F/ZKq4ItUieD7oOy6BaFSRtKs03o334
	397iX4TyDjPU9tDQD8svomX5npA6XzS1jcCcDOhlf18b7PtVI5DULuAz7+ntEO75nMkO18kEE/g
	wQLy4eE0l4YPZl7JYTPIQBELBwyx6L/fAnf3N4DxYPN1mleKfn+SiqmrFKcCNN6hHkfQASyD+Z+
	M3HO3F9Jm2lduyrcd4LOEhQxrKsyKxlL7rLkXzJz+9Bb9y0IFl+rd2fq10E3Ub8z8vTH1pZ2W5R
	H8zHZmwYuB2qMU8laVQO7RTo89hgI23uPyVc9WJ810Q==
X-Google-Smtp-Source: AGHT+IFDnm6j+e7QOuqS9u7aoJ5RULG6n5GxY0Hi//6eRRWxY9HrPcZ/qV4T1GmmcSS9kTXZr5ytwA==
X-Received: by 2002:a05:6102:5706:b0:4e7:7787:1cf8 with SMTP id ada2fe7eead31-4e9c27d2bfbmr2614584137.7.1750442271566;
        Fri, 20 Jun 2025 10:57:51 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8811ae7b043sm365279241.31.2025.06.20.10.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:57:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-06-20
Date: Fri, 20 Jun 2025 13:57:47 -0400
Message-ID: <20250620175748.185061-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit e0fca6f2cebff539e9317a15a37dcf432e3b851a:

  net: mana: Record doorbell physical address in PF mode (2025-06-19 15:55:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-20

for you to fetch changes up to 135c1294c585cf8d0d35f2fd13b8caade4aa1c61:

  Bluetooth: hci_core: Fix use-after-free in vhci_flush() (2025-06-20 11:55:16 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - L2CAP: Fix L2CAP MTU negotiation
 - hci_core: Fix use-after-free in vhci_flush()
 - btintel_pcie: Fix potential race condition in firmware download
 - hci_qca: fix unable to load the BT driver

----------------------------------------------------------------
Frédéric Danis (1):
      Bluetooth: L2CAP: Fix L2CAP MTU negotiation

Kiran K (1):
      Bluetooth: btintel_pcie: Fix potential race condition in firmware download

Kuniyuki Iwashima (1):
      Bluetooth: hci_core: Fix use-after-free in vhci_flush()

Shuai Zhang (1):
      driver: bluetooth: hci_qca:fix unable to load the BT driver

 drivers/bluetooth/btintel_pcie.c | 33 +++++++++++++++++++++++++++++++--
 drivers/bluetooth/hci_qca.c      | 13 ++++++++++---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 32 ++++++++++++++++++++++++++++----
 net/bluetooth/l2cap_core.c       |  9 ++++++++-
 5 files changed, 79 insertions(+), 10 deletions(-)

