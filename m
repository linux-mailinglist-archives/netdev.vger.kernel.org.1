Return-Path: <netdev+bounces-203871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55BEAF7CE1
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A24C5644ED
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AD822F757;
	Thu,  3 Jul 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7PJ3HA9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C51FFC46;
	Thu,  3 Jul 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557937; cv=none; b=KuPx+lManML9rWXZ1pzwK4zT+4Wx33Ct+ITZe1YLbosFJNBttJ9M9hzYWcpfXsb1XdlmBZBtrA+Q+hvfdvKZ2g2BG+xINzfc8W2zQZKjpsSbi6qd/RnnK0PPC5C48JSk8WYrLI9qAssO/F+87RFgL8abAN/mdzvdEcLhHMgahNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557937; c=relaxed/simple;
	bh=hjQ9tu4dTPOs3IWszuUygMNLcNL7KAiKMkW8RoHf2nE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qbRJBTsdfqsO5e0AK7L5Kkpx1LZtR3woInGh8sHxOksEjBmLN9eJLMmHYx7eeEZbLMjhzoCj4Mjt7qOiU9HwM8iuLTiStpkoozXugY+l6pZVLf/YxRgMumt1DiAefA99VIy3JDLVWK9p+7W4BIAYyL32DgUEMDAZUdt28jz3YcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7PJ3HA9; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-531acaddd5eso8238e0c.2;
        Thu, 03 Jul 2025 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751557935; x=1752162735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05CuIBBS8zDGDQ4x1E3IvGaZPa/o4nS1FWgMBoKotDw=;
        b=j7PJ3HA96MfqPz5zq9biQf2ThPYmo0lItzkmTpOQJ9AUg0urMYaR55t7aQz7f1Di3W
         TakCxYIl3OMz1HWftkPkeGRVUUWZhZzsQfQv+VDqX/bT5K3e8pQ9bJLMEmCJmKcsn2L7
         keYt8I9pkegsv7GzREl/yQejwVpEjJ51QSHXc3cx7l/hBguxKQeLQXIybZoAVo04yKwA
         BK+GpoC5o7KPBVlzeYnNvm+15b7kKzOvqiK6IvkVi05tm8RqnmFd25iPjL1OXaWFFofv
         fdvFZ8m/+FaYeQhaptq+qFdvL6E9ezhIEHOjwdoKku4HlU35DCojoiCTof4j+/pQyHul
         IA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751557935; x=1752162735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05CuIBBS8zDGDQ4x1E3IvGaZPa/o4nS1FWgMBoKotDw=;
        b=PErqJWdnHvPm+0bi/IUMhew0+ukzyl6Feh9b7SDw2NK3SPFs1/cX9tXJtCDOvMMoCo
         /TQ6rP4icoEPl7PnOnnezmWgs5OPSHL9lGB/Zv6YtTtqLECpEp5ncDUxeuDL4Hl8N0Az
         7lflQTiffTfV6Ku6C5fCfF1nEaRZW6duv5aY688gAPks5ujf/jmgk0wuxPv9V5OSrd1S
         Jte7cme6A6l0fx2XAUj2tah+No+9PuVnaK/72xNYi1Rgqj29REq8GIL0aeceuB+i+m/X
         AgBXa0lsyV7E3mtLPHH2uuuQ2A8s4GL68nT9WHnFuKBeledy4sH2XicH0n5IFgZqPxN6
         nyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs4cBcBqAR3Bm93wVQCSrs95JoyDgVF8FcC3jEq3jWrgt8Wqy2ZoEP65nSN0uF8gXC3aHradA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysqsNbJFy3hrEaUY0PmKdZM6XZUIETNanRoroAt376DGOq5izb
	uIV/GQCZ4aZQe3Vh4gn+U//yQcbSPNUwfMlYqcfwmqrfnDvur6OxOGwwXCjt9GsYV2I=
X-Gm-Gg: ASbGncs6g91SruT79/d6T1gwAhcUX8e+mJk/ENreKULVLr7FC0/UYUTSYeM25voyj5M
	odffCJ+q433MBDgHsgXYbeTv5iJwWLVKm2RXJAGIkMcWkDQsyjrcnxJBAPNcmcdq4GNv7NnLhoS
	dkQIZyVhNQ/x6KAjMlmOzzJUYd9blhBtKgQWoGIi2gwSgtfBP4I9+IfkfWTqNxQ6iVpW4ONAi/T
	aduahef81XzzXOuyqjiR0i4TRlX0+KPB+J6uib8SeGe9ALHjRs75h2HG2El1A5Y8Fo3Qv7MBkNC
	pnjhSMPjLr9NDfCvtmMmQFsqtbaFKIZbMDv0ffZ89tBDMuh5jDEmanPHNeAC9tE3j6AKyq0mOoN
	4wvswHaWj9xTZqMa1vhIw/U52KAJl5lE=
X-Google-Smtp-Source: AGHT+IEqwviIfIL8qLJIKvCuqkYs1p6/WWdzSxyq1W7PeVDyk/k1Wn5DKFtHpalA4Uj4qVQunygjww==
X-Received: by 2002:a05:6122:2a05:b0:520:4996:7d2a with SMTP id 71dfb90a1353d-53458594ce4mr6203387e0c.10.1751557934570;
        Thu, 03 Jul 2025 08:52:14 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-533090a171bsm2558485e0c.12.2025.07.03.08.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:52:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-07-03
Date: Thu,  3 Jul 2025 11:52:11 -0400
Message-ID: <20250703155211.1789493-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 223e2288f4b8c262a864e2c03964ffac91744cd5:

  vsock/vmci: Clear the vmci transport packet properly when initializing it (2025-07-03 12:52:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-07-03

for you to fetch changes up to c7349772c268ec3c91d83cbfbbcf63f1bd7c256c:

  Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected (2025-07-03 11:37:43 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: Fix not disabling advertising instance
 - hci_core: Remove check of BDADDR_ANY in hci_conn_hash_lookup_big_state
 - hci_sync: Fix attempting to send HCI_Disconnect to BIS handle
 - hci_event: Fix not marking Broadcast Sink BIS as connected

----------------------------------------------------------------
Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix not disabling advertising instance
      Bluetooth: hci_core: Remove check of BDADDR_ANY in hci_conn_hash_lookup_big_state
      Bluetooth: hci_sync: Fix attempting to send HCI_Disconnect to BIS handle
      Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected

 include/net/bluetooth/hci_core.h | 3 +--
 net/bluetooth/hci_event.c        | 3 +++
 net/bluetooth/hci_sync.c         | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

