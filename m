Return-Path: <netdev+bounces-216120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A22AB321F2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 20:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B325FAA0AB1
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439212BE021;
	Fri, 22 Aug 2025 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADrXet7n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBF2BD016;
	Fri, 22 Aug 2025 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885762; cv=none; b=VHX5KrQXALmcYIFLutWByLWxPyLa9olbXG4YrkKbL6JppVnr8B3p25gW+P+UFKPHob5MdV/+tyofCRf3mmhkdIDNb/qJct9mu88Ddpci7XX/mqHHOo8R8C4/VymmOl+WdQH0aecjq67ggSV+CFatwrl1JpZid0nIq2vJmR0QkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885762; c=relaxed/simple;
	bh=N1e7TFsge6b+eTP7vLPJjPIiVfmr9kHRnruGzXquNrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NoSe//6FaLe4I1RXL9rnjwNYLGiEoejpz3BwA7kKJONgD184huWpeYozJca0/RgoA0wcVkrUaG3/FUu2/MGkeCPRjxOqEHhxLIG5I4iBrVEpiMJLiDAF4OgiooHG1nvFHqklR9H9ivGJrj3fQ+ih5R3JFUh/jxBQtQc9IRntZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADrXet7n; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-53b173841deso1680917e0c.1;
        Fri, 22 Aug 2025 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755885758; x=1756490558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTBMTLe7hi+B23F1c3m54W0/QTYUNzPdGq9K96F15Ko=;
        b=ADrXet7nDsj0tP36Fo+OrvdzYZwR8GTVM/n+yQ+8WKEHzxPJmK6XC82QUAYba9sw1G
         6nWRmEKndasmbZEmxzunzSdXHu0bOmPIic0VQ4scTWFD48NRtoN+kIOI/hOsNfbxu9rr
         wVK2zGE9ot84arLNPOwlDuz6WcQJzcgpVNPE9fZGoYoYXOeMlcR606sVgbHjWRndCaAC
         wKRT4yLe6cN+IfjKH2Rl/6Bph24CT3SD4FBVRh4/Y02tpsEI1Zx9MH8E0oGj/qTzIW05
         QGJq8bpxC5SWfYixJMhn0x7Gn/PV+/EkBcB22Bp4e+JVhanQ30QRS33bIUOvkuy3zf/J
         /GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885758; x=1756490558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTBMTLe7hi+B23F1c3m54W0/QTYUNzPdGq9K96F15Ko=;
        b=SOkodoBXDAXzQWhJyo0idX0oB22nCuMn0YEpu+zGDba454+CEQj9kaj2GjPth4aQg0
         L3kM06ctIP8Z1dDw7e+TJVdhdibTOM84Lpz9GulMneUHjnjWi65Ld175znrcxKudOzJW
         bg+++sgLrjSo5XlBWpAxPiOnU8RuekK3w0Trt+ORCFxJ14jCbBB2usEAdJqBwJgT071Y
         i0j5MhjlBdgyLmjxHzrFLEFbgKyT6GX48j/NpCVd3MsebuhKph08BHsZTL+/TbU9gzw+
         qbpDm1nkBT44U1uRDmZIJ6uhGVgvNGResrVQfDA1Z047UQd19K76TSAPnn4qt6u0a2RU
         UfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW2IEPlW43/h7mNroyw93EvLpUmW0/E9FGVUAItmzBsdX1ndT+rHXjJdViZJnvZpgKTpp2rRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK1BwA5n1DRALWu8NmFhkWkgisv1UiMw4VsWfnIkLQKt9ZmrZm
	7zt+czHAoNykB4GMPOiF0PM8FOkHNADTv5Zv7dsYKYb/1dHt/0LwqAJUj7NzsImm
X-Gm-Gg: ASbGncu9z1vi5n43rcw6ZT0XW5hnCHd1oXGxkFHh1l8TsEqOE7B70cCr3QN3cErXkVO
	0dd/wSYXJrzc9eZEdVO0ed+0AdfmOP0cNWCSwoEAWar6Mn3EfoL/f3D/fT3el/ZKjpVVsBcJ/On
	nDo5w9ow3Kac8q19zc343bYk7m/XQnM0ie3/WHJFCFa33Cd3jMS9dLpuP/aFTgt8/s87xk4w8Kr
	1/R3H6mRbXaU/hjRa09WDzhGiFGJJF8gedFx5P2xI5uMCVv9hBD82ziSoF6C9hwD5MuNhQd/yST
	otSAu00503MEbmw1WN8U2pZlBIBSfKLk5O/fLxU7g1OgR+XPUU5Y+Xad6ShP3YD5XFbS26DSI/i
	xa5mVSDI83u3LfqEt0WvFBWp+Q1W2gucQF1i/vxPCtvzU87FLl4Q5P0GVusuf/XH1Voi5lPOMrd
	RyWzvTE/a8x+IyDpbSXzizmY6szYn2
X-Google-Smtp-Source: AGHT+IGeu61Y5TAPc/tScHjmwG9O5oSvfqSf9m4DxY1VB4CktieBwlAIvYCDeXvMVjjSnpwRtR0eeg==
X-Received: by 2002:a05:6122:45a7:b0:534:69b3:a230 with SMTP id 71dfb90a1353d-53c8a3baf1emr1366202e0c.11.1755885758143;
        Fri, 22 Aug 2025 11:02:38 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53ed9ec0035sm108752e0c.15.2025.08.22.11.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:02:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-08-22
Date: Fri, 22 Aug 2025 14:02:30 -0400
Message-ID: <20250822180230.345979-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 01b9128c5db1b470575d07b05b67ffa3cb02ebf1:

  net: macb: fix unregister_netdev call order in macb_remove() (2025-08-21 18:38:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-08-22

for you to fetch changes up to 6bbd0d3f0c23fc53c17409dd7476f38ae0ff0cd9:

  Bluetooth: hci_sync: fix set_local_name race condition (2025-08-22 13:57:31 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_conn: Make unacked packet handling more robust
 - hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
 - hci_event: Mark connection as closed during suspend disconnect
 - hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced
 - hci_event: Disconnect device when BIG sync is lost
 - hci_sync: fix set_local_name race condition

----------------------------------------------------------------
Ludovico de Nittis (2):
      Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
      Bluetooth: hci_event: Mark connection as closed during suspend disconnect

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Make unacked packet handling more robust
      Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced

Pavel Shpakovskiy (1):
      Bluetooth: hci_sync: fix set_local_name race condition

Yang Li (1):
      Bluetooth: hci_event: Disconnect device when BIG sync is lost

 include/net/bluetooth/hci_sync.h |  2 +-
 net/bluetooth/hci_conn.c         | 58 ++++++++++++++++++++++++++++------------
 net/bluetooth/hci_event.c        | 25 +++++++++++++++--
 net/bluetooth/hci_sync.c         |  6 ++---
 net/bluetooth/mgmt.c             |  9 +++++--
 5 files changed, 75 insertions(+), 25 deletions(-)

