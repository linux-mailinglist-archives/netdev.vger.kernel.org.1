Return-Path: <netdev+bounces-200375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D15AAE4B79
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CEE18859AD
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC000279DC3;
	Mon, 23 Jun 2025 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCoVtc5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E659E545;
	Mon, 23 Jun 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750697652; cv=none; b=hCaXaXzSO940xlMetiTnxFY+wULTeYlyI1qvwpUUWfYaOBpoN/VABoPANY1japLrBFsi4w/87YBCY+gYHaKj132sBpCi2UuP8RHPpel/OpdIhMRhRvwkJBTvbxjFgvNOMyvbZh4Z02lr7Ocgg+1eCg4HUY1/8+mFVtbNekLY+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750697652; c=relaxed/simple;
	bh=QGACgowodzUAd1+BGQGmWNi47nMFBl7Bp0w2S6Ud91U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AWY/4SYpL5OX4JxJCNRuUjCpTjD2JHw5KQ+aJQi2ZFvz1zaaWz16ULzE5bD5Zn5wGunjwOAB7ou4NwoZysM0pCw0vGCqsSUqfo58Q+HDYgANIkhUrgRpfc4YJn/21ZSmGELC568iFtrVMwXxa1mf/YObffBNzJlAThqOLoS1W9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCoVtc5i; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e77d1333aeso1380639137.0;
        Mon, 23 Jun 2025 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750697649; x=1751302449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOtn28Jy3+kDMzQ8F/wSLD70bYPw/ni/DG4b9MAEBNA=;
        b=cCoVtc5inhihYaYjf9tX66Tn/p9zIWI18Rr+acoCa96L0rTmGoYzVMsnaE3rxrE7rb
         iB3PRxLZ5nzPbwPrGgIzbWLqqnKbQvn3HVZLyPin6vyAIYoxBAu3NEFwB8KINrDcx3xi
         DLQ+iykCCPtElJIm6qKzgMG/l7TUIlDjK+r0LGcxlyafh5SAB1XSaxQHC2CpQABf3xGd
         ewge5SisIEHZAz7ZX+EDqNrysLbwQXzbhVX7SkO1LvYEZH6Up/SQ9M/EjL+eqQqJrJg+
         3fu0MJJI1DMWt1KkB56GUlJybaSjFECzbK9uNMwPCu++HGc31xHL8LQfieofMl7wgXoa
         3eTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750697649; x=1751302449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOtn28Jy3+kDMzQ8F/wSLD70bYPw/ni/DG4b9MAEBNA=;
        b=J8Tav8J5ynEP8hFCpmm80VKJhsykQCVu1ETed6yR0Zsn8bYxXSM/CpuPeXn4frUc6E
         NTyCKzfff8Eqdbgqh1mbjFksFIycm3ouvRK0DbncXQ1PDbydHa6x/JMh4Tr/Cg+KKwmq
         M/rlARDnLZmyv6IibLRcgjDSKKpoF+Pu2cfLK5OdEESmVmqnc4acVDSQCfTNGD4hr63p
         NlIH5P9NgqztotmHxd1kqD8Dps3W8UHlTjb/P1L7EHm+mVKiPkB0ihdyArzHcid3Te4M
         AOjoT3JvYVqJHXHhTUBVtKDxrYjC0IQN8QtC8PkXVeLbJkFrPYicV1lJttGSNhBoHP9+
         CbIw==
X-Forwarded-Encrypted: i=1; AJvYcCVMnhrTugCYPEd4gR0nOZsu5c+jLrRuY2OWJCvnmQqeRe7zKrnyKJtsER/TY9ZOkZwVaplaSHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylt2G/vIst8PgoS+aEPuSPORknij38jDkaaYlQXXyvALJ9/jeu
	L+5D3zr4EEB0rNibuECMBiQ3KlOFkV3SQrj/m0zumZdxe8w7hiwi6J8Mb0jVRBbY224=
X-Gm-Gg: ASbGnctvZ9vwjNnm5LnNh9tJHcUQC3x/hOFVBeFUStsHVmwt7WGnwyhR/0vYJPwOJcy
	H3D7WrsbNJPtcF7J8sc8IEaKML5+Cjd3jSarguUbZ9jN5cAgsRL85aGjNodoafzncEs9Ds8PGPc
	KiqQ6E/DmGXbL36nbbZa86svReVPfKwTMaULUsdH8JyZNpSOZEzaUiRV+qcCZaCh0GcinSraYN8
	5RWBzFYBECzHelIHRDxNwNwydwr0OJa3qG1kEAVFEJkiDw4AUlYNFO/UxHLWUtDpfRXzdQrjAEy
	w1zfsG5udNMevBl1ANL2bCpHDF7NjJo6vvva8JPgCDK3GiWfCtoDraYSSSvyKoGvI+ONATA7gvm
	XTmAaSZmgKwczEsp8/9WWU3cO4f2hdXXczk/eH48u4A==
X-Google-Smtp-Source: AGHT+IHR7s//ffOovYj3ZWD+jmwbd1jKI88SBMxURaUmgQUSoblsNn1ENFs4q6OQq6aRBmZpUHmtow==
X-Received: by 2002:a05:6102:4b12:b0:4e6:da5d:2c42 with SMTP id ada2fe7eead31-4e9c2f31c43mr8583772137.19.1750697649237;
        Mon, 23 Jun 2025 09:54:09 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8811ae4f1a1sm1251679241.25.2025.06.23.09.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:54:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-06-23
Date: Mon, 23 Jun 2025 12:54:04 -0400
Message-ID: <20250623165405.227619-1-luiz.dentz@gmail.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-23

for you to fetch changes up to 1d6123102e9fbedc8d25bf4731da6d513173e49e:

  Bluetooth: hci_core: Fix use-after-free in vhci_flush() (2025-06-23 10:59:29 -0400)

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
 net/bluetooth/hci_core.c         | 34 ++++++++++++++++++++++++++++++----
 net/bluetooth/l2cap_core.c       |  9 ++++++++-
 5 files changed, 81 insertions(+), 10 deletions(-)

