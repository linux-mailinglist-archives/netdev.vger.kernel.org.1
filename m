Return-Path: <netdev+bounces-86713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D34498A006C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2CC288A1D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8297B180A9F;
	Wed, 10 Apr 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWh3ApwF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC5E1802CF;
	Wed, 10 Apr 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776575; cv=none; b=B6J/Nk3NSz6Zl0oF4+JGKKRqc1PU1ff116luUV31G8JOb0rWc2IbLt0z0UQV7lWXMq7tT+bR0V+TvwGLQBQxhBiWFa9sUUhK+uUE6XZN1ACr1iOZZ23cbVYFzCQNybiMhaozkjfZeD3A6WbMHbSa+3jbp+kbWqHhlAMrobA6VYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776575; c=relaxed/simple;
	bh=N3eMWVi75+MA86c+aJe5TeWSasUakhFVRf4PZ2GV+P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OHUzyGpNBJdwnBlpR7Bmmv3f/HQlN22pszrwWCDkrGvLLlUh3Ihhbx6GRkMfayx8IuuxSopFJDdRs86HW5hjGDPfNPlmBMythrhFyDISf2UEp/xuhcAoPuUc2OFaWEuvwZ8c8belRpGcJR/gHbqttBrvSNmQURa4UxhmMMu9d9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWh3ApwF; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4da702e48e0so3033828e0c.0;
        Wed, 10 Apr 2024 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712776573; x=1713381373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BpSOzU15LzKweAegnrAsIh5K/sd1ekTGfCpD+wWSpac=;
        b=QWh3ApwFb02bdqcOF8zTKLtwoZUo/Fw93sZIPZlOwwkFFRb2L9IsPox2LqpJVqhau6
         jLyisMvW6WrZZNOzL3IJ9k1rNmaLqEZXuNBuTV8RAMgxG6caKD2/ieg/G9pVKDshMiqw
         dF7v5EXKnyltxjMJOLChBJlpna9hpMbkYR03ZywiNcCpIHkv91XJKWTJX49+xOLh0Iql
         bQCpjRbaPK27+GgL4Eenw94xhpJVhMlT2FfmEl/WiaUGHkFAsnW3WzqGaf9chrga7Wol
         3FyRAZ4v6FUnwThtrfgJ8v6+t6k8bQknjEH/GT3AFTx4dtvH29Qt8040jlsB1IdfQ0gL
         6v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712776573; x=1713381373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpSOzU15LzKweAegnrAsIh5K/sd1ekTGfCpD+wWSpac=;
        b=QpiBhwgGLvjjyzcGIEgIAc9Ze8GA199YZZRwpCKrVpKo/DLAa23WfJ6a+jVHfsjlb9
         VNcAbndxYbZmCng/wrbSFoTq/PZfAQleACAdYtj1/MlmIRASk2j3uWr3gdkVQyze5SB/
         IMc5zP2R504awKNbQ3PowTU9j4B0b4c7guNSObvH7gWM0QD3W+UzbMNS9XKrxehAYVVx
         C8fYERiUrkqEOMOCwaFWSzHLHMJPHzW9BYFc0H6/KRiEtfuaKgu5NomQUmVrJdW+I+ez
         yFweY3GdMD3z8yGf5VZY+5gbPtmH8Xn4iC6Auuv7fbObk0wEEB63Jz3OoYKw1A3FedG7
         sY7w==
X-Forwarded-Encrypted: i=1; AJvYcCX/M8KBdCpoiA2Bjo3pjmg97GXab9FIQw+trDoJFq0GkeHTBOd1hF/lE15SKKirhFlGH9umcc3YyKfUu5jL89ZvhVeiRUFb
X-Gm-Message-State: AOJu0YzPJw7Q8BCfn/T4SJ+jwE5JnKolh9DtEoleJSjmX/lbnNcdtmS3
	tzqsOutHP8UoWpSPjkpLRQdeOE5Y5kW0aKzKHp7s5GPJFaPXNLKh
X-Google-Smtp-Source: AGHT+IFHRjFkE9KByYgCvObvf3f7ksWVv9j/dH67V+lePm8YK7b2QA5nG9xG4KTV7kAEgN44mPt06g==
X-Received: by 2002:a05:6122:1795:b0:4d8:797b:94df with SMTP id o21-20020a056122179500b004d8797b94dfmr4261683vkf.2.1712776572666;
        Wed, 10 Apr 2024 12:16:12 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id eq15-20020a056122398f00b004d895c72d56sm1524223vkb.50.2024.04.10.12.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 12:16:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-04-10
Date: Wed, 10 Apr 2024 15:16:10 -0400
Message-ID: <20240410191610.4156653-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 19fa4f2a85d777a8052e869c1b892a2f7556569d:

  r8169: fix LED-related deadlock on module removal (2024-04-10 10:44:29 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-04-10

for you to fetch changes up to 600b0bbe73d3a9a264694da0e4c2c0800309141e:

  Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNECTED bit (2024-04-10 15:10:16 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

  - L2CAP: Don't double set the HCI_CONN_MGMT_CONNECTED bit
  - Fix memory leak in hci_req_sync_complete
  - hci_sync: Fix using the same interval and window for Coded PHY
  - Fix not validating setsockopt user input

----------------------------------------------------------------
Archie Pusaka (1):
      Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNECTED bit

Dmitry Antipov (1):
      Bluetooth: Fix memory leak in hci_req_sync_complete()

Luiz Augusto von Dentz (7):
      Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset
      Bluetooth: hci_sync: Fix using the same interval and window for Coded PHY
      Bluetooth: SCO: Fix not validating setsockopt user input
      Bluetooth: RFCOMM: Fix not validating setsockopt user input
      Bluetooth: L2CAP: Fix not validating setsockopt user input
      Bluetooth: ISO: Fix not validating setsockopt user input
      Bluetooth: hci_sock: Fix not validating setsockopt user input

 include/net/bluetooth/bluetooth.h |  9 +++++++
 net/bluetooth/hci_request.c       |  4 ++-
 net/bluetooth/hci_sock.c          | 21 ++++++----------
 net/bluetooth/hci_sync.c          |  6 ++---
 net/bluetooth/iso.c               | 46 +++++++++++++++-------------------
 net/bluetooth/l2cap_core.c        |  3 +--
 net/bluetooth/l2cap_sock.c        | 52 +++++++++++++++------------------------
 net/bluetooth/rfcomm/sock.c       | 14 ++++-------
 net/bluetooth/sco.c               | 23 ++++++++---------
 9 files changed, 79 insertions(+), 99 deletions(-)

