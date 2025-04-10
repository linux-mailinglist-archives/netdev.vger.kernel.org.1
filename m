Return-Path: <netdev+bounces-181374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A785A84B19
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F015460C5C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF71EF377;
	Thu, 10 Apr 2025 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDKXEyKs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C31EEA28;
	Thu, 10 Apr 2025 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306548; cv=none; b=ez/aOlVkI+6mKFPJZidPeAzQ2oJL8spYS4TQOwo7MvZf9QGrXmFH+pcD5I8d38v5FjcqljhpZG79IlzBYE9/hUB3eVZWCE5dZoiv9hxjir8RmZo5hqitPeH59j/oYDlcLaTJpZWXC/CIiqGW0WnZ9zI05k9BaEU7AC4zRLnCNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306548; c=relaxed/simple;
	bh=DkvZtxqK/ko1iBOddXha7p3yDM2/bDTBueVuuuyMtSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rz57bFJSoRcvishfdgSHCDb07NnDHOSmnLWHdCXV1YpjOfaaCwJfVjdReXUvLhE2rE4dlOVO/G4p9zP6l44PAX+uUZ20nOoYMSBETQRcUvyvyIW15ZXO5STP/NRwLPUS4lZiY7ZWpuavV3rgVk7myUBJZ8Z0C1A4X1c+PURHZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDKXEyKs; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523ee30e0d4so578225e0c.2;
        Thu, 10 Apr 2025 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744306545; x=1744911345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOYAwfs22Vesz6HH9+A8uCIAd57AWRwiituCt3z+RMo=;
        b=EDKXEyKsiH009XeId1a7/vTCE/BG0iAkQme5jdzADgJUVFa6hM7xl6Oci5hsENxgBC
         T+wg+hjACHVXDoSiKb+sXuQj0ntcRLrk/4XY2MoSoZ1vvKObrL6yPh3r40CV8Rqrk5zf
         1acIQZP0QI9M7zV6qAFmmpfqstuYMDlppF8dUpBjizSQgQLke2Q1g/MbavC/5y0qHe8u
         SUC/gevdz2FgR74JtKGvD+XhUJnneUVyydhIEo+wSJA5KChMfRmhpnfGaShseEpRZSLp
         s6hZyryd8IcrNhf82QueRiW1kGeQsd6jFfK2SvKPixgFmhXA2tR4BjV/loozpNGYeeTU
         kqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306545; x=1744911345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOYAwfs22Vesz6HH9+A8uCIAd57AWRwiituCt3z+RMo=;
        b=fVdBEnvsDSrcLmYxiHHdzeDvR/SdKYBBlJrLVjE7aRYLnqWN48RrO4TFqgEHAR6cWG
         k16oSwFKrujt4jGw86sVL3Jk3wxpRt+ELofkLW+NcI8YycTQEqVhUDNRVLoXoNWrjZe6
         K1KbecBeUJyWuGm9UL1/Y4SLh8vzQRTXYHLj4H8wtmi1z0ERDFw2JOKYRtHodSIrYJxj
         OTsuiwQy/ikjcEhGSI85v/8edobU+eDvjSureTFFZW9WoY1oLLfdIkF/a/Wmtk2NStbo
         iIe6LbmVknH/dmlH7pltC5r1uTmmYbtO6zUpU/geGJs/eAR16NZA1zn769WW3IKpytI7
         0V6A==
X-Forwarded-Encrypted: i=1; AJvYcCUh5QQUxqNw1T75i3U46XeO+use+7CfeVhn38OOmLAy62NAvj8FlA5YT/hUDCwmO5fZE9VFFEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPb7RnTgYQ7tSs400ZhD4bZRCWOosXp/V8EJHYPVZg73x7nLQz
	qW0jisbaUTTQxRuV7YfFbdU2ass1EVOlTAwEIWe9oIr4KxUT4XQsFAHmKvB1
X-Gm-Gg: ASbGnctyB9ToRr2fpsZQnTfV2cGLAn4IWk+unroNXmUO5eujDts1n8uoiBZu0sWuQf7
	//ELbgDAF4SStGEWUyFgQoKSuM8TBS9brRlTzZ1KRenFCbIKN64cBKGknNOC7byKHVI9uL7Ce78
	1g725uhj9lbGWeVCAzs75S6qGBFkOQ6WYLWATtW5/FvOOlg8R7t57LlH+niWYCXRiE6n3VC6kt4
	CaHfXTULZzTvOHra6h10DETlTZoLrR6mKqCzPAX3WyL8FjbnJfNj01DL5pHZzRVSLSqP2ByoMDI
	oh4MOagfRaY8HwWr2IBt06MNqbdfvVDYJeW03gO+kQA1RAQAvF50/h0tSL2BYScOlZXOz+jqJDf
	KeitTLwkZEZwQ9dJRnf89
X-Google-Smtp-Source: AGHT+IETO787kAzY8NTDDKxzXu2dSc81uSqbn9M+1iHr+Lxyih36p9Pp5n1sBYmXQblPv4kM/Gvkig==
X-Received: by 2002:a05:6122:3291:b0:50b:e9a5:cd7b with SMTP id 71dfb90a1353d-527b509a141mr3526881e0c.9.1744306545328;
        Thu, 10 Apr 2025 10:35:45 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abd4b121sm739303e0c.7.2025.04.10.10.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 10:35:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-04-10
Date: Thu, 10 Apr 2025 13:35:41 -0400
Message-ID: <20250410173542.625232-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit eaa517b77e63442260640d875f824d1111ca6569:

  ethtool: cmis_cdb: Fix incorrect read / write length extension (2025-04-10 14:32:43 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-04-10

for you to fetch changes up to 522e9ed157e3c21b4dd623c79967f72c21e45b78:

  Bluetooth: l2cap: Check encryption key size on incoming connection (2025-04-10 13:09:42 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - btrtl: Prevent potential NULL dereference
 - qca: fix NV variant for one of WCN3950 SoCs
 - l2cap: Check encryption key size on incoming connection
 - hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address
 - btnxpuart: Revert baudrate change in nxp_shutdown
 - btnxpuart: Add an error message if FW dump trigger fails
 - increment TX timestamping tskey always for stream sockets

----------------------------------------------------------------
Dan Carpenter (1):
      Bluetooth: btrtl: Prevent potential NULL dereference

Dmitry Baryshkov (1):
      Bluetooth: qca: fix NV variant for one of WCN3950 SoCs

Frédéric Danis (1):
      Bluetooth: l2cap: Check encryption key size on incoming connection

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address

Neeraj Sanjay Kale (2):
      Bluetooth: btnxpuart: Revert baudrate change in nxp_shutdown
      Bluetooth: btnxpuart: Add an error message if FW dump trigger fails

Pauli Virtanen (1):
      Bluetooth: increment TX timestamping tskey always for stream sockets

 drivers/bluetooth/btnxpuart.c | 21 +++++++++++----------
 drivers/bluetooth/btqca.c     |  2 +-
 drivers/bluetooth/btrtl.c     |  2 ++
 net/bluetooth/hci_conn.c      |  8 ++++++--
 net/bluetooth/hci_event.c     |  5 +++--
 net/bluetooth/l2cap_core.c    |  3 ++-
 6 files changed, 25 insertions(+), 16 deletions(-)

