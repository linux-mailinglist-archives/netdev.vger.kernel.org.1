Return-Path: <netdev+bounces-246456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCB0CEC74B
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 19:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2EE2300996B
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 18:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098812FF172;
	Wed, 31 Dec 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYs6QRd5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905522FF15B
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767205041; cv=none; b=Yhi5Y80hW4JkfByynAooZMJZqbNKlMWkVmf5slB27cRl/KzzRcoR7/7RwHJHgv4pq+QyKQ+9DOVCN7Trc/QUiQsl45QPzjc0MlWt61j++TqvlOdm8uT7YC/jSyZuAf+IYln2PqJ5iBT1U2cFfRAVZAv0LVx3nZ0HJr3+fhZRf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767205041; c=relaxed/simple;
	bh=DtW9jydX6kRSz+VzrOTs9HRP1q8pSatXePBnRhDvGcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SvEd3N7eKlZ5RbG47A+vD7dbqJEc9t2gSHaaOdIHUA4D3gOTwCXK4kZJMKQdQcIR+QcsmiZFsj7WtJyjKKmi8DfF23+AhhCn/ueZvJl+vddPEYlX8Oj1dAgD1dMe6ZoSuTkZx0FDCJj9m8qsulpmCnB2n0/s7kTJ+6OTnwupX4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYs6QRd5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a09d981507so80740685ad.1
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767205040; x=1767809840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXoQb1Iho9s/aJU4/V83jmA8EbXo7twbK1X6eOXoFDE=;
        b=cYs6QRd54KTn7COi8TcmhfReUlgtg00ULE4Q4t3IoGT/xUALXfkF/OKgh7lzTOtdkQ
         qhYvgkXY6DD+znP7OO7SfBMBIyPj4T6LRbnMvC129+5NoPHUJpHzs93EVshJ7T6woIGg
         4n9XFkg6WBuyDK4IPXKpVquOUUmm/YFCUnSkZNvNSr8Oh0aeYnouA5iH09kMiR+sX7CB
         IjExd+zO3nwBgUR90wuEkSZOpvilM61HcP4+e3NsXBc9/IWLLTiL/hWakn/Nwn/bDbK1
         2CWu1Yn8MsPud0bBQds7u0B81ICEf2OhnluR5vXovSV4rRxgjOVlvujiDPRMCKTgYYvx
         09cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767205040; x=1767809840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXoQb1Iho9s/aJU4/V83jmA8EbXo7twbK1X6eOXoFDE=;
        b=RqZhFF2bz9TuLgej1d7nShbhdYZ2W9aepupMfgEUJFXLeWlQJ3S4JaC7lW7BurCxqp
         aJcg46y0qBz/RYenInp2pkfPI6pCdVRpIqv/AOI1iZZBeNG84Zatv4BzhufRY4BSGonS
         WjZ0x5cJkUDK8TQYGJaCl4F9JfUFDLTDILnSzl5wtef4HoRCwrTQMTyvzmVbPSv88q5d
         s4jfg4ipwpzV8zKmdirzUJKTlTIMCKNq65sHP0YJljnddT2Ta7DPWhHZjMWlxSPXlB0Y
         geOUjyXhCXJFnTwkFMwuzrzoukqjbkI+IGT8oNLQzJb0jUte05uEpcTrFLwXKfX6UY9L
         XODg==
X-Forwarded-Encrypted: i=1; AJvYcCXj0H9lzShV6f+vXtE2xzF1POr77xcjcsQddk84Xkgyepkg7WvQEcYdibyNAGR2oY8uwLHFYyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4mAhSCZi+5AN7G+wO5R7MkNPmituYtOn+SXqYjUAoU1QKDBj
	Oo5MajRbOGNBk5OyaSrMZcNUIi0ZnZDrqcYlCxcvEyZIXCoogmMsfVQH
X-Gm-Gg: AY/fxX4zz1BlOe4vP4hK4iS0c8hNketQrFD/drv3FTUtSPfGrYZk/bpkFS27MhxJBma
	VU10smE3dSJb9S28m7cbJgleMeuvm9voyT0pBxQkruiGa6mLCLjDDInbDPNJJlD2CJS0exTrA3O
	7MK2Y/HQzwe73rbP8YcvNOP/JuE3pUzz4EKxQTQErrhkhP0GPJTsEvBTA1cOHKOv34usGJSQDdF
	kH/qfuwsXVL25nHvZcIc+CwHGARZ88hYc9n0vwG2dJ/FEVpDEeSHzNWliAlD6G7hWJz4EYJTO1j
	6zFJHyKjaac3FBynps6HVGMZC6FusQKH5uz013zgCC7h3KXKJJzdjPhoNtrsod8Ie65zat4kDcp
	vsnWiUmHBgYNrlPLEz+3zKjY4JeURHye5a6zW+hwPjNavsr/OKK012/jkH8HcT8GA/d9NJ/rjwn
	olrPTf1dmeUl16T2FE
X-Google-Smtp-Source: AGHT+IFt+YYUuQnJIjJqsNxOfFi0ONI4ZVIqnGrLeLLNJzP5CtQl3rVTd4nmjmgrcpUv1MsNBMmBaA==
X-Received: by 2002:a17:903:41c7:b0:294:8c99:f318 with SMTP id d9443c01a7336-2a2f0caa8eemr448221945ad.3.1767205039865;
        Wed, 31 Dec 2025 10:17:19 -0800 (PST)
Received: from rakuram-MSI ([2401:4900:93ef:93d6:a0f7:dedb:d261:86b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66473sm310787225ad.13.2025.12.31.10.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 10:17:19 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: rakuram.e96@gmail.com,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/2] can: add dummy_can termination and update SocketCAN docs
Date: Wed, 31 Dec 2025 23:43:14 +0530
Message-ID: <20251231-can_doc_update_v1-v1-0-97aac5c20a35@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251228-can_doc_update_v1-33b15a48aff7
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767203695; l=1574; i=rakuram.e96@gmail.com; s=20251022; h=from:subject:message-id; bh=c2Ukyvmu3x+ZNm/g42TZwi6hwotnurZ3OlsKNTQ8zxQ=; b=4+zCI5bRXSp0OszcugSJ5zY1CIOEsIwO5aVMoNPNxZeR7cbFHZ23mqJw9rOT5QeZSyqBic/dV WUaTO54DYpPAnwr4U3ONOj7FQWwsNBr0fDhkzuBKah6Dfx9O5frez/I
X-Developer-Key: i=rakuram.e96@gmail.com; a=ed25519; pk=swrXGNLB3jH+d6pqdVOCwq0slsYH5rn9IkMak1fIfgA=
Content-Transfer-Encoding: 8bit

This patch series introduces two changes related to CAN XL support:

  1. Add termination configuration support to the dummy_can driver,
     enabling termination testing with iproute2.

  2. Update the SocketCAN documentation to describe CAN XL operation,
     including MTU changes, bittiming/XBTR settings, mixed-mode
     behaviour, error signalling, and example iproute2 usage.

The goal of this patch series is to improve dummy_can support for termination and
update documentation to match the recent addition of CAN XL upstream support.
Feedback from the maintainers is highly appreciated.

Base commit: 
commit d26143bb38e2 ("Merge tag 'spi-fix-v6.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi")

Testing was performed using the iproute2 master tree, which contains the
required CAN XL netlink support for validating these changes.

---
Changes since RFC:
1. Maintain dummy_can structures assignment as is
2. Update the examples with latest iproute2 tool (v6.18.0) 

---
Rakuram Eswaran (2):
      can: dummy_can: add CAN termination support
      docs: can: update SocketCAN documentation for CAN XL

 Documentation/networking/can.rst | 615 +++++++++++++++++++++++++++++++++------
 drivers/net/can/dummy_can.c      |  25 +-
 2 files changed, 541 insertions(+), 99 deletions(-)
---
base-commit: d26143bb38e2546fe6f8c9860c13a88146ce5dd6
change-id: 20251228-can_doc_update_v1-33b15a48aff7

Best regards,
-- 
Rakuram Eswaran <rakuram.e96@gmail.com>


