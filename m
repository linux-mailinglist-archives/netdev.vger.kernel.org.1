Return-Path: <netdev+bounces-75778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A83086B27D
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553B81C254C5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9E15A4A5;
	Wed, 28 Feb 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQXsno1K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CA159580;
	Wed, 28 Feb 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132209; cv=none; b=RZbWxSVbZ69n8Dt58ZDHkK3yK4zPc+1hldJXsdR0XlcKzgUlIO4TEDkOQuKAErJojLPHgT912rrhnBI1MHhoSf8MMtn0FPx00WZ29FEjD1qU6H2aWOnPBGY0tdpSvRcZthPwqUs0UgDuBzB4NAgB121CCRI3CWjP0FM6G75UFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132209; c=relaxed/simple;
	bh=LFtt6jYH550GfjfnHy2suFQlJmGNsclLpKkLfTltmdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bMxqrBSd+tTNR9cQVk4V8Yx70eYqnw52Rbe+xYzNUd4+SyuZqebFgWegrKTdSqpuMRJQkjbHxTFvG1wYpnUySnY07QG9pcE3U5jDQSVndLSSzxXSECiDG9U+XhKXXabgTIP/gNnWPQU2DxY4PA9sAv+99l8RiUO03Ue72dCkNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQXsno1K; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5bbbe57b9so2639751241.3;
        Wed, 28 Feb 2024 06:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709132206; x=1709737006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XK6G9YO0V0Qe0S9grj3xZi7Ihi03g6FojMFTZREVg04=;
        b=GQXsno1KtJZQU+n60DboSR8Wz1WlCvJ+tL8pWpvBcjThjvsif1ZqWUc3lB7lkxSiBO
         mo4YJY9k6WhwowMBPTq4PfMTnYd391sK+lRbM6f+9wsqE7/QrYahPeHe26L7tmyog/1/
         7mhPRihGf1zOHKUKFOOLJRzYr3PdtNqgdnWnd1UFKWqTHySQS1CkILjjm+NQKoLDExZ0
         Fd7HfpfcOClZBOKc4HfAbDcLSSwDL7mIHiypEld0LNO0rFHj5VZRfg8mt7ZorelqId2p
         of4RVC8eicgXm+izNYrLf3M+LV08PsHZ+58wP5PQ+tumVEXJIHOH2YrHk3FMt4gVL1+O
         GoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132206; x=1709737006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XK6G9YO0V0Qe0S9grj3xZi7Ihi03g6FojMFTZREVg04=;
        b=T1R+E12klTTFYfwNNzVl4kJQc6ucT8UIRicrXjOgVbwYxpVF1SEmQGNBJQLrBJ1kiD
         cm1s8bbuwZfAtcdpCRowksd2oqryyE/dBIHqOtPRcI8OZJ9pyX1wbwVKMFTs8Hc2CdQ8
         hu6Pi/9aRaAFIhPH1a+iCxB3RkO72MyUbMBVybEEdJZPfK5q6w3A8+Tfb+5fcLTGMWQd
         q92DrfMkzPAtxOMrWKQVmKNCVhKLMz5S3uidDmE0ih9AvP28mjBgcAvwOf4PjXrvw+/Y
         q53mRRJpWIj6no+hwDlxyPnpVQO41AN5CAaFPIXZyJsjOrspxniSz0RbRuT/5biCQUvc
         h7yw==
X-Forwarded-Encrypted: i=1; AJvYcCWmxoFRMPvCICU6SITDVZBrnIJq1QT9OrtawVf5oBnHNyjEvOm8v29zaocWJ0nFfUVioyx0u0/AKyvlm+wGtx1XmisYcSnv
X-Gm-Message-State: AOJu0Yy4lg10PTSdLpYojPTah8BuAHCbRNoDqt13ZPS8EVgiKrpQ5yCn
	3UjoIS4zgrGu9XAp+0fjNMDeeDR5A0gxS0RBsLdpLek0DkleFqon
X-Google-Smtp-Source: AGHT+IFzia7gk+Ocdm2vnl3M/Jkb3TLv9DiLZswmEV4nYrDwwVfvu3tG1QBQKhHlfd+dw54HbqC5/g==
X-Received: by 2002:a67:eada:0:b0:472:69ab:f7be with SMTP id s26-20020a67eada000000b0047269abf7bemr1981104vso.35.1709132206229;
        Wed, 28 Feb 2024 06:56:46 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id cf4-20020a056130114400b007d648972c4esm1395580uab.4.2024.02.28.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 06:56:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-02-28
Date: Wed, 28 Feb 2024 09:56:43 -0500
Message-ID: <20240228145644.2269088-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 4adfc94d4aeca1177e1188ba83c20ed581523fe1:

  Documentations: correct net_cachelines title for struct inet_sock (2024-02-28 11:25:37 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-02-28

for you to fetch changes up to 6abf9dd26bb1699c17d601b9a292577d01827c0e:

  Bluetooth: qca: Fix triggering coredump implementation (2024-02-28 09:50:51 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

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

 drivers/bluetooth/btqca.c       |  2 +-
 drivers/bluetooth/hci_bcm4377.c |  3 +--
 drivers/bluetooth/hci_qca.c     | 22 ++++++++++++++++------
 net/bluetooth/hci_core.c        |  7 ++++---
 net/bluetooth/hci_event.c       | 13 ++++++++++---
 net/bluetooth/hci_sync.c        |  7 +++++--
 net/bluetooth/l2cap_core.c      |  8 +++++++-
 net/bluetooth/mgmt.c            |  4 +++-
 net/bluetooth/rfcomm/core.c     |  2 +-
 9 files changed, 48 insertions(+), 20 deletions(-)

