Return-Path: <netdev+bounces-196709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A33E6AD605C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C711895FB1
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291252253BA;
	Wed, 11 Jun 2025 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmaEG6Pr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86C185920;
	Wed, 11 Jun 2025 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674990; cv=none; b=iPcmGGxJRQq3irVHdRM92CA0prKbSGbCuvGNvlMPjYlMhgXvSFNqRYs9piDTOBX7LmLdXCj8ca59zmbjb8B/u7kIkvRrzjatbLK8HNAVEetCiW5zBVV1BeUNSKp5pmeWc/N7yakinT+MMtZYLpu09/Tgv0nKb2er1xjusLtjnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674990; c=relaxed/simple;
	bh=879lWa45Gxs+c1Uod6OWR0UZAINZ2KggI3MRLWxWitY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aq2XCKVTQ2gEObeG4CHxCiA6LL2e2VMC6SAp/+aklk79B0xlPYkdFlZXIx8s0X/FklnodGEZckhYPrNceUFSmronZ4/yYDp+qljdMDhLbHDTljg6g6GfMxDZqLdKfm6CvichceWvKc2Elm6+o1IECeL2PBNJmXGGhWo1PqYgpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmaEG6Pr; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e7cb3a277fso70617137.2;
        Wed, 11 Jun 2025 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749674987; x=1750279787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw4O2qIGPBbQpF99dSGo25y5I+6IYxs2uEM9DviZMJk=;
        b=PmaEG6Pr/QHR0r8CgiYnC+XHiayVMkYE1iAkJsDVdkICNpfhzFc/kk8rDwPLvO8Urm
         5gKKUfw5YOOEKTLFMsN8wnpUBAzUo9Pxh7M08KNok0y06MwLCVAir7m4tQ9xrLAYQqgO
         MSOT6SdK43JBLvCPbyvW8IjGOJxIVWlhDeZ5swNKYvjLjLjvSvRo1Z5he5/ky6CblvCQ
         mz7vcjgXCTlkn2Yl8eH1rL/PW0XtAStQxP/b/THevB0o/l+wrhwhuUh2VDiXUCLzdi2a
         DOWGohBMPKkqgUj2Ztcb6Gj7YAyy8GxtZ+uKSuWxsjuAVz3jePAbbaRhcJuGhH4NX2ud
         OYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749674987; x=1750279787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uw4O2qIGPBbQpF99dSGo25y5I+6IYxs2uEM9DviZMJk=;
        b=d8L/YxCSAvycCsg/Rsci0gsvnIyfWgA0PXPtWROHzaqRq/7MAH2FynQITF+yh89cFK
         yduADp2dYeO3c7uUO6IDhwpwP0LFTrpYHwkoeo1YF/bNyi5VxKPwt9wAEMbZPaAezMUx
         BMiySna3cSuw2vZik5u8LmIw8Ol1DoKS7VGWgNMrSbqf90cQOMG/r668UIT5RhXe55RH
         7wQBDgggfK8bT71b2qcB9ijkpIR/14CZkoZ5TRcuxyZ5ch5ThVMSYCxkoQOOHcRkMnRF
         893qkC/wqUtVb4knB9y33aF3aCPxEiARsqA7UZS1FW94ftyAQn/qA6KjPMMRoAM801pl
         tieg==
X-Forwarded-Encrypted: i=1; AJvYcCU5kHDXgWXmWWX/wCOwsY0fXL9doOeX0judDmCrls2yWpQMVEn6sUwyPFTUvg8pMTVrEu3TPhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDevERA07E8FJ2cNLikF8DfxyDIq2QmuZuYo0GgzksG3HBXsZM
	EnjCkJiBZie0QUa4ET0F3w2OSZV67PByppxK3OiIX5L3sx9IYR/Eeo6/cnlrPSNzFs8=
X-Gm-Gg: ASbGncsqjUVwfqKBIKuG/rhkzMO354HP/yq5ky483zTYqnQp5rH5Q0Z1/TbhFB939Mb
	rSQF3Lyp1kKsm1RRzovYJ2ON7NCrTCST8OTYGRfmb/Hnmy1eLdOofGysO4BKNGrFGrpaoRejTJK
	LkLpW1WuVVAnuS1lEYgcNYlUxwtpVQ2cB+kgIyCo/ZphLUKkuPXNt2euITGu5boVsPTzAGC7vCf
	fqOFdqzd+slZa4xhPn73oztwdQox1CApQov0jX1am0uHcMJOeuq5zTBeHI81ZGruXLAnxOGOOdh
	bujuNWDK+XiExGgSmD+UPczi+CpC0rx9hfkw2D2JP3TiOtSau0EopJ72PvhQARGr0OQQDobHNbW
	7nDq0iQ7gW1HQ5vkxZ1KanFVCRvrMi676yfqiUG3R9g==
X-Google-Smtp-Source: AGHT+IG4uiXvw/zPS/X5x+9L2Y6LFcey82zpdiBfbM6siv47q9IKbz79AY8RF9SUNAllu3Q0Gry3kQ==
X-Received: by 2002:a05:6102:441e:b0:4da:fc9d:f00 with SMTP id ada2fe7eead31-4e7ce96d107mr639309137.13.1749674987366;
        Wed, 11 Jun 2025 13:49:47 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87f0127330csm21846241.15.2025.06.11.13.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:49:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-06-11
Date: Wed, 11 Jun 2025 16:49:44 -0400
Message-ID: <20250611204944.1559356-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 260388f79e94fb3026c419a208ece8358bb7b555:

  net/mdiobus: Fix potential out-of-bounds clause 45 read/write access (2025-06-11 12:49:03 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-11

for you to fetch changes up to 7dd38ba4acbea9875b4ee061e20a26413e39d9f4:

  Bluetooth: MGMT: Fix sparse errors (2025-06-11 16:39:25 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - eir: Fix NULL pointer deference on eir_get_service_data
 - eir: Fix possible crashes on eir_create_adv_data
 - hci_sync: Fix broadcast/PA when using an existing instance
 - ISO: Fix using BT_SK_PA_SYNC to detect BIS sockets
 - ISO: Fix not using bc_sid as advertisement SID
 - MGMT: Fix sparse errors

----------------------------------------------------------------
Luiz Augusto von Dentz (6):
      Bluetooth: Fix NULL pointer deference on eir_get_service_data
      Bluetooth: hci_sync: Fix broadcast/PA when using an existing instance
      Bluetooth: eir: Fix possible crashes on eir_create_adv_data
      Bluetooth: ISO: Fix using BT_SK_PA_SYNC to detect BIS sockets
      Bluetooth: ISO: Fix not using bc_sid as advertisement SID
      Bluetooth: MGMT: Fix sparse errors

 include/net/bluetooth/hci_core.h |  9 +++++---
 include/net/bluetooth/hci_sync.h |  4 ++--
 net/bluetooth/eir.c              | 17 ++++++++-------
 net/bluetooth/eir.h              |  2 +-
 net/bluetooth/hci_conn.c         | 31 ++++++++++++++++++++-------
 net/bluetooth/hci_core.c         | 16 +++++++++++++-
 net/bluetooth/hci_sync.c         | 45 +++++++++++++++++++++++++++++++---------
 net/bluetooth/iso.c              | 17 ++++++++++-----
 net/bluetooth/mgmt.c             |  4 ++--
 9 files changed, 107 insertions(+), 38 deletions(-)

