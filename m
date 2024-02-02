Return-Path: <netdev+bounces-68730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D2847BB7
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 22:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BDF1F282EF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 21:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212F839E5;
	Fri,  2 Feb 2024 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0wRh0ez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF9839EE;
	Fri,  2 Feb 2024 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909931; cv=none; b=Sx+jFbKskB48E8+RXVrXE8CC91ZsLPBO7KhdvUImx92dLEGyu2FhPTkBy3jMBnxDfF8Ih/u85VrOaz++W5PRmen8ZaTIljIYoBkTS9nO+g71jszmR6K6zE6eTIWZmvVWSf7JlMMhZ4wU33ohdJGk7jaWmBF/I/Br9+95eWR4j08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909931; c=relaxed/simple;
	bh=F6VquZN2wtXDcdORlyKdNN7aLm3JSWls/Qx7ZNJpgk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bCLCwvhKl9ZPbPI/4rL5SBXX98v1VWdYiCincd0kCaHQXfuMIwuCIvJVnkQ5KBp3NcgC+lIDa1RwKib6VzxRRbsxMt+bzkND9DSVvrvgVtrVc5nBs7r18HO48JJ22GB0xpv3aWacCP1RUNsLpkGQi6O6haA7VuzkT8TlyA//jUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0wRh0ez; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6c0dc50dcso2197579276.2;
        Fri, 02 Feb 2024 13:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706909928; x=1707514728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gsmzFnQIcz/cfdKoMIxMibTLWaipEjSMwVTmlwFeBfY=;
        b=E0wRh0ezVmEKg0O51crq4+Z5uvhBFLLDfwLCQ1MbTQk6NzqVQXMjErfj5lOTs6o/yM
         KXlJBCDxUGNfbE+t/zz6//51m81gqDzTBG0WCRigC5F6JUiuXDYbzbxfEEP23Bu1AX9Y
         KjBSJGC8zhkGqaODDAExJT9aNwF49KQDWLmkiNktmsNEnIMek3djleJBM4TA0/rzbaTB
         LS+dOCMz6Nr/tPr0Uask5DcfpvlpE1qpgb7NQUmkwuhDbHxUEOSIFmFW1jwiKqiG8p1U
         WPqnRk7ZtzoxJDXHY5iUqTzUZpvMyGXDddIZbYz7MxnFiOkWF5cPRb9igiFvcm28zL7Z
         z1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706909928; x=1707514728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsmzFnQIcz/cfdKoMIxMibTLWaipEjSMwVTmlwFeBfY=;
        b=s8+e8veYBgANgmlGsUZcz1+Quv+2yTTh7y6D6BSgF0335O/9lUQ45ITKy9c1jIb7g+
         ZyLG9fmhbM96iCd42sE62tFIRtyNVIO9F6NgxhKzELqig3RZcszMX0NBCe+c2FJGdORl
         xS4zEU/5Tb9XrQ1zIMhRF4H+6585FTd3euVUF4GiE0XKMQVDInFN++xdD0/IQoxvfLVZ
         gkFdhlRqRI33R1a2mNZDXrFaQag79iCSPUJ6mWSRqcJN9wktqlDCsTSg9AoNyuziG7pz
         Sb2EtpwhSe18BTbEGdncD5W0InB8tLzSmqEsIG4CmOxYOqnsD1B44qv/ggiFNiuiZsaQ
         3WMw==
X-Gm-Message-State: AOJu0Yy6e62SCaLCqvSLSSfIxHsXWgrCGwjQnXVgIcb0BNc6CXOIEVmi
	iH1PLl4Jv9+jdaA3r5uKkSil9NtN9owRnVNy27PNUY7fcMzePezhUw8+uYZM
X-Google-Smtp-Source: AGHT+IGYOWp42Mtocorzjb0cxbAYRMA2vVWpDYIkLbO4o9w9ExzIiJfKpJ5weBm3niBtrlOEcbzm3g==
X-Received: by 2002:a25:6d46:0:b0:dc2:234d:214d with SMTP id i67-20020a256d46000000b00dc2234d214dmr9479422ybc.40.1706909928231;
        Fri, 02 Feb 2024 13:38:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWChupyp0Mz+dMNPd4Y8znsIZpNFhcPVRIRQm6YdOde7BY6Jilnu9sSnU9gwSZuDhSXAoJvuY6HDZa5BaUxEuDcp+S7Qve1n+iMakN+XBQkp0wUeBJ+KsQ=
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id t2-20020a259082000000b00dc22fa579c5sm605591ybl.45.2024.02.02.13.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 13:38:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-02-02
Date: Fri,  2 Feb 2024 16:38:43 -0500
Message-ID: <20240202213846.1775983-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit ba5e1272142d051dcc57ca1d3225ad8a089f9858:

  netdevsim: avoid potential loop in nsim_dev_trap_report_work() (2024-02-02 11:00:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-02-02

for you to fetch changes up to 96d874780bf5b6352e45b4c07c247e37d50263c3:

  Bluetooth: qca: Fix triggering coredump implementation (2024-02-02 16:13:56 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - btintel: Fix null ptr deref in btintel_read_version
 - mgmt: Fix limited discoverable off timeout
 - hci_qca: Set BDA quirk bit if fwnode exists in DT
 - hci_bcm4377: do not mark valid bd_addr as invalid
 - hci_sync: Check the correct flag before starting a scan
 - Enforce validation on max value of connection interval
 - hci_sync: Fix accept_list when attempting to suspend
 - hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST
 - Avoid potential use-after-free in hci_error_reset
 - rfcomm: Fix null-ptr-deref in rfcomm_check_security
 - hci_event: Fix wrongly recorded wakeup BD_ADDR
 - qca: Fix wrong event type for patch config command
 - qca: Fix triggering coredump implementation

----------------------------------------------------------------
Edward Adam Davis (1):
      Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Frédéric Danis (1):
      Bluetooth: mgmt: Fix limited discoverable off timeout

Janaki Ramaiah Thota (1):
      Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT

Johan Hovold (1):
      Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid

Jonas Dreßler (1):
      Bluetooth: hci_sync: Check the correct flag before starting a scan

Kai-Heng Feng (1):
      Bluetooth: Enforce validation on max value of connection interval

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix accept_list when attempting to suspend
      Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Ying Hsu (1):
      Bluetooth: Avoid potential use-after-free in hci_error_reset

Yuxuan Hu (1):
      Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security

Zijun Hu (3):
      Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR
      Bluetooth: qca: Fix wrong event type for patch config command
      Bluetooth: qca: Fix triggering coredump implementation

 drivers/bluetooth/btintel.c     |  2 +-
 drivers/bluetooth/btqca.c       |  2 +-
 drivers/bluetooth/hci_bcm4377.c |  3 +--
 drivers/bluetooth/hci_qca.c     | 22 ++++++++++++++++------
 net/bluetooth/hci_core.c        |  7 ++++---
 net/bluetooth/hci_event.c       | 13 ++++++++++---
 net/bluetooth/hci_sync.c        |  7 +++++--
 net/bluetooth/l2cap_core.c      |  8 +++++++-
 net/bluetooth/mgmt.c            |  4 +++-
 net/bluetooth/rfcomm/core.c     |  2 +-
 10 files changed, 49 insertions(+), 21 deletions(-)

