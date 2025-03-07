Return-Path: <netdev+bounces-173051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC909A57053
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229C6173A86
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2E19ABC2;
	Fri,  7 Mar 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCNvRQvh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8B23C392;
	Fri,  7 Mar 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371541; cv=none; b=H6Ie8zdoCh0PEqOha9gUyjjITCMAt8RD3xl5pIDsec5JsElHfd4wzV9YyV/RGb4WKeNERfaWqwZQjMUBCmP8HuImXo+49XMMWWzT4MBV+jiU5DMzoyOMvhYiCI6faaK532ar6GpPD1KllDnt4Uf/ZNOMMk/OlkZ3mvs+v4kF9fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371541; c=relaxed/simple;
	bh=aq8Wo/8aCbFK4rxRqAt07pPQLjsTUxSY+RTbLI6p1P4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2I7wwzjhrBamV1GVWpMNmkLKELhuJSyKgqFitb4KLWLPi211zsvVhdA+NZ8hoMBaKynImCoD6ZfxYD0rClzrfJKXNcM1F3kogfM+H6uxDDIewnLi+ja5vMIogzolQBYVWRWMlGMS66nGlO4mCdp9+jSPOBritfZvBBhWfxLTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCNvRQvh; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-523cbce071bso849990e0c.0;
        Fri, 07 Mar 2025 10:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741371539; x=1741976339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maGk7Q8fBbZb2d3H7OPJe6h/vgdCD27yZ0lAu/GNzy0=;
        b=hCNvRQvhqQxhmXku5vKeOqVIL+YEPSJ2xsMdG8y9hZSViKkFZPEk8J9ffYwrlEKg40
         kUNcg5t34fHhxKM47+B9RSaw4BY4HSGMUnK98CpceeOQFDEA9nkpXxLC8sBBH2NGt+za
         ePwB08SqoPQL+JEJmb7CXwI0UyOEotFA1Hpi2GQ3SPRnP1l99Zd6nPDpcOUDFAvv7R2i
         h5zFEDuIUifgyIZVcFEB00g7pdFksgkffdKigIuaxaY5ne2N91Eo3ldPNQKH/HYk+RsO
         tcg2bfTtux48oYW7xfcTC7Ie/HlD2pANMchp/mDmP4HdHCXJqo04vQEZ/kenZRT7i/VW
         sVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741371539; x=1741976339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maGk7Q8fBbZb2d3H7OPJe6h/vgdCD27yZ0lAu/GNzy0=;
        b=HSuKKTH71FkeOHONZP5OGsEdIZk4h5Lf8lOPZwsbFepRH4WkqBahTNt78aVsvSO8ED
         DPWUFlAyi+dywhEsIiSQ5ijFHDPkQDBzX0YH8jAVqsv0KaPb5AFMKq8FSy4HprxIwtnx
         Q/KNFp4ZOWTWSgQNlBxNTIJeO16x7Zs2ywVEaMmExR5CLGnObrXeJq9cJe0d1cnUGBNB
         p4a8+AkCI/UT+4ykgl553hOw1B67+rywCH/13aSFntjar2FAERCwfC5uu/9g+wHSORY9
         Om9JTdlA6iWRintOi1EyUKCjHFjIu85bcuzICVD6vDLShJBKlaBMFjBT72zlCN/Pblef
         1SOA==
X-Forwarded-Encrypted: i=1; AJvYcCXfHYMtPzTA6+S9pmPiM780xQIlvzzmJy/bj8zhr4j+ADeQWYGSj77h7C4w9aJCki9ujqSVHkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUkp+smI55BnljMTAUwF5lbmRj+nXad4SRyYxz1KpZvbJ0L4pL
	OfPyvZETpM6/6oO/ZZ6lZHE9PYCRpOLSwp/fA45EUoSKjf43bWwn/bv9XMGY
X-Gm-Gg: ASbGncvFQ/x9hOX+MDzsetQv4gcQM53exw9jAq1io/Yr51cEjKrXF1wYx90Ro+HiDp4
	/5qQwqNhSC1gBnnkF2NGUkMDVNw786Xyh27QDr69GUSDh09lUSjR+TS4/tgN1hrWl1a1Z/Kh0Mg
	kMhXqfV4r3YhXYTIHfzpLVbtCXpq1QhT01C1exAomM+Rj8UWBb0Ptbkk5niQtjuM+BK+FG4zh56
	vOvSEek7CNfhu/Efxu+rqS5oD4mjlZ9cC759AQmabQbuPN2RCicx4TauKOWNGYx9YR9+ZGcnF0Y
	vdqufdTWnaY1mclJU5weCbZMKI7CbM7K8FVHKoHJtZfDZlO7PRKe8j695I8ofrlvnQF1BGQjxlE
	/D2uI6O6aDNhjew==
X-Google-Smtp-Source: AGHT+IE2ZaqgQosJyZ/JwBXFGrmdu97ZLU+QQoPp/Ch/Vp4gFrY5nWAkip9FleREFNx6VFFBJDXEPA==
X-Received: by 2002:a05:6122:7ce:b0:523:9ee7:7f8e with SMTP id 71dfb90a1353d-523e414a989mr3852102e0c.4.1741371538784;
        Fri, 07 Mar 2025 10:18:58 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bbe52esm787345241.7.2025.03.07.10.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 10:18:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-03-07
Date: Fri,  7 Mar 2025 13:18:54 -0500
Message-ID: <20250307181854.99433-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit fc14f9c02639dfbfe3529850eae23aef077939a6:

  Merge tag 'nf-25-03-06' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2025-03-06 17:58:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-03-07

for you to fetch changes up to ab6ab707a4d060a51c45fc13e3b2228d5f7c0b87:

  Revert "Bluetooth: hci_core: Fix sleeping function called from invalid context" (2025-03-07 13:03:05 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - btusb: Configure altsetting for HCI_USER_CHANNEL
 - hci_event: Fix enabling passive scanning
 - revert: "hci_core: Fix sleeping function called from invalid context"
 - SCO: fix sco_conn refcounting on sco_conn_ready

----------------------------------------------------------------
Hsin-chen Chuang (1):
      Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix enabling passive scanning
      Revert "Bluetooth: hci_core: Fix sleeping function called from invalid context"

Pauli Virtanen (1):
      Bluetooth: SCO: fix sco_conn refcounting on sco_conn_ready

 drivers/bluetooth/Kconfig        |  12 +++++
 drivers/bluetooth/btusb.c        |  41 +++++++++++++++
 include/net/bluetooth/hci_core.h | 108 ++++++++++++++-------------------------
 net/bluetooth/hci_core.c         |  10 ++--
 net/bluetooth/hci_event.c        |  37 ++++++++------
 net/bluetooth/iso.c              |   6 ---
 net/bluetooth/l2cap_core.c       |  12 ++---
 net/bluetooth/rfcomm/core.c      |   6 ---
 net/bluetooth/sco.c              |  25 ++++++---
 9 files changed, 144 insertions(+), 113 deletions(-)

