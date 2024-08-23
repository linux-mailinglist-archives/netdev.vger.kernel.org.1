Return-Path: <netdev+bounces-121498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C337395D652
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B73E283946
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A49374F6;
	Fri, 23 Aug 2024 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGhyWwLy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B228DB3;
	Fri, 23 Aug 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443213; cv=none; b=ljS8jmUhoCjfB8MSzCSUqmFuZw2lMkUOiKd7ByI//j5La6eqcmkZdkj8CKW5DcvTj5N7DBn2qblNJ9XlReqya+fpfHRPwXqU2wHe7NGPC1DM1AW29pLrBpWNUdXq9sL6h77qCLkOzyJRxaLi/5xaO1JgPoxdxL3EJKLZIrUY2P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443213; c=relaxed/simple;
	bh=pt2286SsLYl7D961G5nQNv856t2p9tWt6UaSEv9SZKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptjABJ3I2vt44xZNXjiRRCCrLCepx8tDkd23aPjRt4Hww+RTgcc7TH92vBhq30rEqfNqyqsV7F6J6PtR4z08e0lOWk76ZyHAmHG15LGe215y+3+Aqm1zAD2meN/hQEsnl22/redJHx7Kc8BGi+nZhHjM7VyaW1ORmUDhBtYKbYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGhyWwLy; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4fcf60f4653so772900e0c.0;
        Fri, 23 Aug 2024 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724443211; x=1725048011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UmolwQ3BAKjM0YC0qmBFagWpexFUmi8Nic/1Jv0/DfY=;
        b=HGhyWwLySMT9NctO7YFAn+VYaj2BYeK3cQEy2MiYPA9aDnXM3B70ZSTEqxzW9x61pS
         3z4Sarkdmf24KDjrzN3GjCLjoRd58v3suWoapzUUDjPUtuEs9GLKbVDpghAAz8ONL1HB
         jUssviwRSoZOIiPO80byj0EGU4cCs3p5DWjfCFy7V9Bc71DKi00jQxhnAM2SVuU7Rmad
         6uhMZ7JMIjAzayH52aEPl34Xy37lgPn6UlKZb2GBRdvfj4usX1Q+cVg6Pc7PXb88IXBI
         Ty/djptFMoIxf8QM1qzsczTkEkk2KUaj8K88ghSkGy3o3Nqp9Jrfu8pQ8pKg5wSH69U1
         9nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443211; x=1725048011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmolwQ3BAKjM0YC0qmBFagWpexFUmi8Nic/1Jv0/DfY=;
        b=iG541uweQe25c7iGbNYa7CaEi/xqBiHdgdTjNEd3fvXXx8bK1hlkP7vBnsx5GrvzYp
         b3nIG1Kx8XQ4QmbISxrcvzf80n9OL9ER9c2vPQJgBmBQkiwAeGm8E2i3durpD1nMfJID
         sCHN68BlHX0o1d32vLypyJ6MNTg4Hg1s/+4t9rnS8jyett8FdqaNITqMNPy6DvymNQUV
         TwOHAFbQZ+Lc9JWNt49qb+580+aq95gseQQLg/vRwxJJvQJsj9TzugWSu1q5dWhx9l8Z
         da5QkyoTg5z3ijdx+eY2vx9hWWWU60X863BAIIcqw5y2/dDLZVlXY2dezkFYmDZ9V30v
         ZLyA==
X-Forwarded-Encrypted: i=1; AJvYcCWfyl08GnSSxjJ1BKUrfE05DnsCQCd55HKlm5YDLyw7cCfRthQqNiOEgO7Mq2s44Lw4VYYyAR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxKUY9H6CHrjdKZHLSkf046w02KyiYFXJCkqW3fjUCOSAfs4St
	uDUo9IQKHbx4K5zSJYrtwTzK9ILkT+XTLjbyO3fig5VIwk6nEFUff6Nuzg==
X-Google-Smtp-Source: AGHT+IFefXvfaI5KqdKO+KKzwsnevV0bRcc8Rr659GorQXLiNCpe3EkDRpMshcdirG1S8Te728xWgg==
X-Received: by 2002:a05:6122:2a15:b0:4ef:280f:96ea with SMTP id 71dfb90a1353d-4fd1acb12d9mr4260159e0c.4.1724443210937;
        Fri, 23 Aug 2024 13:00:10 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fd0825989csm465336e0c.20.2024.08.23.13.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:00:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-08-23
Date: Fri, 23 Aug 2024 16:00:08 -0400
Message-ID: <20240823200008.65241-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8af174ea863c72f25ce31cee3baad8a301c0cf0f:

  net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc response (2024-08-23 14:24:24 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-23

for you to fetch changes up to 18b3256db76bd1130965acd99fbd38f87c3e6950:

  Bluetooth: hci_core: Fix not handling hibernation actions (2024-08-23 15:56:04 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - btintel: Allow configuring drive strength of BRI
 - hci_core: Fix not handling hibernation actions
 - btnxpuart: Fix random crash seen while removing driver

----------------------------------------------------------------
Kiran K (1):
      Bluetooth: btintel: Allow configuring drive strength of BRI

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix not handling hibernation actions

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix random crash seen while removing driver

 drivers/bluetooth/btintel.c   | 124 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btnxpuart.c |  20 ++++++-
 net/bluetooth/hci_core.c      |  10 +++-
 3 files changed, 150 insertions(+), 4 deletions(-)

