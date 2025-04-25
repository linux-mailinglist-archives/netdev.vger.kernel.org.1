Return-Path: <netdev+bounces-186094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50CAA9D16C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D324674AA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F221ABA3;
	Fri, 25 Apr 2025 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKmU7NMk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D22192E4;
	Fri, 25 Apr 2025 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609060; cv=none; b=LScuwZmyomVrQB2izcoVsyRTlOjFQp9s/+sPklCKKAnyZE5eaYtMn1tLfHBtH/AF7+5L7fj67V/23shnlOMJB5FXc6Z4rlFax9zAi58GtEpaoTnvF8xzXuAGG3wf2xUSkYFCZL6ueNkR+RBuBx7CVlSScwwY99UIiedaP0NfL60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609060; c=relaxed/simple;
	bh=bHam3Q3+jElp8fCkLomlcfEPt3kJAMIJOK2axlN3350=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bURoGI4m2MuXCB6NwJRVBOVKdXvkvHfF6BLTieYJ6xgbXPp8qUf6bxy7WZUkBym2Yj50+bA6e8HSL4FbETeURnLYMfmn72CZq69YaOXqjZoOQboN/e6BaQ2rA0mzOSlpWUP4Q00zzdvQliwNGswyXe7DDopIVlys7wTFgZchq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKmU7NMk; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso1120736241.3;
        Fri, 25 Apr 2025 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745609056; x=1746213856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lIDuHC8h9cMc7qwARTO7Z+Zuc2xY4Zk+wLulRs/SGVs=;
        b=MKmU7NMkH6GycbZyydIan8GAK5WIqTHHdOiEunGjT4RxhfhnNZqrfk14gL4JF+5d97
         8lVLkXX3iK3sAnhhKYwjiX7+dUjSVJHecEccqcxJTZhD17h/sv0DR9+ez4hsdu/Jv7a4
         /nQpuKH2vUIfkJPWaNxPnYBfVjqpvVCAGyYMeVX+v6DmU4QCwYxIraruQCiolPB7LBtK
         c3V8Rgp1cnLvqsH43hBsKEwDtX/iz+kCqW+cOCCdSnnlbx84OrshhNh6lcTwoU4427zM
         VPUmmuVntYBsVwAWsQBMiCRTTB73cKIrIVCbzZ2UthUgELTONeZwnquLpu0ABTkuZ+5p
         olmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745609056; x=1746213856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIDuHC8h9cMc7qwARTO7Z+Zuc2xY4Zk+wLulRs/SGVs=;
        b=QQrRgc6ur1i4jBu/eMYfnKRGak+DPQqiUq6gv4ullNxAjnkcyNzoR9JGI9NKwaOCqF
         3ni4yVQX2uXaY8VPWyEzq9DKsNNQF5DhIsEPXCbtNT3+b9NZWyTy4cwYV0OzRRe2mhH8
         1M4dapeZB1aPRX3YLg+4MudQxgXK6VW4Dh6gf9z040z9jCTnFuGGdOnh+lpI4AeoT4qm
         8YrjIVyCVbzQ+YOZ1W5Vk5A60YpqDkGw9CX3vhZW8pPjsANLXIZS+wtbJHbB+Zj8tONf
         /BU2DggL3CyTaB8RUNGIZTs/f+aQMxRcsWtw7qmh7FVCdpzfg8bBZZWMlfnt7Lw0jM1l
         OzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuQdGfpFIaXMSM5IF5t2uk5aGvdDyh/Hcmvi0MDrP1vx16x6Ipc1QEGIqJ/TGru4vaDaS+Z8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53vwoK1rlaNjT2SLomKfC2U2w9YVvmzw2AlAM9IInUor1n13/
	tqYWvkYauEnbmPb+goQ7rGVbMPifti/xI6gTkuZtFzvege0P5wWi
X-Gm-Gg: ASbGnct8fhpE5juBONr/GGK4Am21nhRc0Vv1m6y9T2ZUTnaqJFZsYTkPkrfleeo8uEF
	2Twt2iDNuAV2li1GAmMpDsRZX8EGS9uyK49pUPh/6fc837cBNJvQXo416RMohbaKRllnfsjXqKq
	dnjy+uIXMuKcyt020h25MR8ESrzXT66PuthWk3irBxxf0oaJ5pZI+qIj4ev1yXKOr6d3gY7e0rh
	hpOYOxs45nHUwBs3DGvUoCGtQjf/ZztW0nue+Xgq9c/hQL4Oug5l11ju6JOwQkCxzlYTtGtzUO7
	doSV77XtVuDo3483WrfP0458IUY4Ui1aR/r8u3mHF9b3CMe7JbrB9Izizro2v9Zv2CYEvqmU44/
	0P+DwZzlDCQ==
X-Google-Smtp-Source: AGHT+IFyxNv0h5CaymwCR9WHhIQJ9RtWTCTlxDc+ydIeNed4hO70diU6NTWSfnpq56vm/85NsT+xgQ==
X-Received: by 2002:a05:6102:3e8b:b0:4c4:df5b:330f with SMTP id ada2fe7eead31-4d641f652damr892990137.17.1745609056251;
        Fri, 25 Apr 2025 12:24:16 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-877aef5ffe0sm810413241.28.2025.04.25.12.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:24:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-04-25
Date: Fri, 25 Apr 2025 15:24:12 -0400
Message-ID: <20250425192412.1578759-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 49ba1ca2e0cc6d2eb0667172f1144c8b85907971:

  Merge branch 'mlx5-misc-fixes-2025-04-23' (2025-04-24 18:20:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-04-25

for you to fetch changes up to 3908feb1bd7f319a10e18d84369a48163264cc7d:

  Bluetooth: L2CAP: copy RX timestamp to new fragments (2025-04-25 15:03:19 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - btmtksdio: Check function enabled before doing close
 - btmtksdio: Do close if SDIO card removed without close
 - btusb: avoid NULL pointer dereference in skb_dequeue()
 - btintel_pcie: Avoid redundant buffer allocation
 - btintel_pcie: Add additional to checks to clear TX/RX paths
 - hci_conn: Fix not setting conn_timeout for Broadcast Receiver
 - hci_conn: Fix not setting timeout for BIG Create Sync

----------------------------------------------------------------
Chris Lu (2):
      Bluetooth: btmtksdio: Check function enabled before doing close
      Bluetooth: btmtksdio: Do close if SDIO card removed without close

En-Wei Wu (1):
      Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()

Kiran K (2):
      Bluetooth: btintel_pcie: Avoid redundant buffer allocation
      Bluetooth: btintel_pcie: Add additional to checks to clear TX/RX paths

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
      Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync

Pauli Virtanen (1):
      Bluetooth: L2CAP: copy RX timestamp to new fragments

 drivers/bluetooth/btintel_pcie.c |  57 ++++++------
 drivers/bluetooth/btmtksdio.c    |  12 ++-
 drivers/bluetooth/btusb.c        | 101 ++++++++++++++++------
 include/net/bluetooth/hci.h      |   4 +-
 include/net/bluetooth/hci_core.h |  20 ++---
 include/net/bluetooth/hci_sync.h |   3 +
 net/bluetooth/hci_conn.c         | 181 ++-------------------------------------
 net/bluetooth/hci_event.c        |  15 +---
 net/bluetooth/hci_sync.c         | 150 ++++++++++++++++++++++++++++++--
 net/bluetooth/iso.c              |  26 +++---
 net/bluetooth/l2cap_core.c       |   3 +
 11 files changed, 300 insertions(+), 272 deletions(-)

