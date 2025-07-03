Return-Path: <netdev+bounces-203877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F926AF7D49
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E2158287A
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC872F0C52;
	Thu,  3 Jul 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8xDFglE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4B70823;
	Thu,  3 Jul 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558656; cv=none; b=cAjJPAWjEB09qFiRMpPpFNZZ8d7RqeUKzhARHnU/Q5wgQmq1RH4jm4LDZYdN6BI21APALr3Z46AbkUhHMgHGPpaS+qRt/UMtRznAOxajeenYt5fuUOk+qrjjiMz6ackgY8KK2WTQ1L3bQsFqkZ4E0wZN+BlyuqWQG9sFkt4zlRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558656; c=relaxed/simple;
	bh=hjQ9tu4dTPOs3IWszuUygMNLcNL7KAiKMkW8RoHf2nE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gS6rvJEhVd3XlbYgQtlcLCmd91ZECAjFgNtiHVhteTXn/A+EWaHIB0vlD7oP8Q5Ia/4P3OykcFKAa/kOhJQFjvspDiI1+YGTn3cte6tQhr4GVj4N5/6iBOnhBRNQ0rwxeyhP8vekh13T6Y9pW8uHeVoY1rnC+hh/JEUYmkVzYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8xDFglE; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5315acf37b6so13574e0c.2;
        Thu, 03 Jul 2025 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751558654; x=1752163454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05CuIBBS8zDGDQ4x1E3IvGaZPa/o4nS1FWgMBoKotDw=;
        b=c8xDFglED1O9zOitJIZ+jg3HEm/1zxNbcn65o+QUeD7ZId1gfM5UT4QnDnJAYeVQQl
         m2zeM2YQuRda8bZy6dXND+PWng3F5Oe/WIQG7uXwN/dkS16ogTdfA8Uu8oLF8VevhivL
         t/24bs5wmSAI5hNPBcOcXZdjWkXr4GOyXyffkeXO+JPwumqSwqB6x7blC8fhW1GyHAB5
         LnaPjSHD/yoGDQ60I1tmdhFh/byWnf3XmU8sgqcTZ8Ekm0HXh33KIIT7F9wNYeZxj5G7
         RizNbASSzqzZjjm0L7Px3qCGKUduo9aaSgoaGSQWpsQ21FRoWRG1IPFjk/RQOmZckWnC
         hTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751558654; x=1752163454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05CuIBBS8zDGDQ4x1E3IvGaZPa/o4nS1FWgMBoKotDw=;
        b=XEZuFECfJuMl2PKZAdcGW8h4Wu1UvMtNe6M6+fEcROBSA36yPSn5x3G+YtdcwAJiv3
         fXdaEjMf3kiQkdkIYcq3izoDmHQwksQdVC6Z51TW+2BsAiAKLVm1bQ800VoqTxfBzMcL
         YxGpSECLdz1irBKQrrrutIr3INy195bF2lfSIMa8CMflcve5HFd4tc1odoZCD5XOavAI
         FozELMmsuNhSsnResfMvJkldMDGwPtYfOnfGWSePUsnFKFDaRLcBupRILOXFPbp7Qn5F
         FnIp+hQTAxn67wT2i5MjA7R6FUEGivW189Ts33B39XhMiJlBWONPVIKX3mwTdpzvrm3w
         zG2A==
X-Forwarded-Encrypted: i=1; AJvYcCVr9FOyEEyzb8rmHtjUQmbkUHrzrePA2s2UsB5texCFSsZaqCPbu8bsXpVhILFLjXZ9RiRnhxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEDCzXeagfm2dqB3CSKDiKo6SK0K4OH76S5bON8t4WFxPLHLvN
	5281JUkpFMfD6HX1SGNPU0u8N6FTjvKJsYZXuQ2o33rHisXVcfXy81Ao
X-Gm-Gg: ASbGncunt1Spqu7h6o0On/5ECaRN9SK7URma6qQ0YilrzNhgL76JEo6Qg+vB+K+8IT6
	OmJB3ea1uOSNTLMU9B16vx6ndlnYZkVy7kW5WEl2qXiVozNQlX8mhMcNQfmFv0ZgkzaNbdLjzBM
	5hOX2JXKcef3Hj2vHSXHXJ+WJ1v2f9dOq1hsPyR9QjJFZCdm0xH4prw3qtE/AF+jl13aFMHOqgX
	qtF5D9Ho7pewFcIyBiZkql2uuAShwIplbOEy6UZ02judzBKZW7jjOM1OirZPxn8HoXwvkWiRgP2
	f5UWibcu4s3pfSIv2ZhRXE6rSJgmRoq43eVZTZ0yDRrNkRr/0R7CpWGTQvraiiHIxYAIXdiE403
	ST/6yA1VciKnQA8JOtD6oCzEBsc8YFVB3ykHm4YR2wA==
X-Google-Smtp-Source: AGHT+IH0aRnscXqrxXqbElekjvgr+9LzyDv0k+cJU1R1kQvUN78XK7qzsXRhiJJMkhIQP9SteoAgVQ==
X-Received: by 2002:a05:6122:82aa:b0:531:2906:7519 with SMTP id 71dfb90a1353d-5345813a00fmr6629373e0c.5.1751558653625;
        Thu, 03 Jul 2025 09:04:13 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-533092120fdsm2555333e0c.44.2025.07.03.09.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:04:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-07-03
Date: Thu,  3 Jul 2025 12:04:09 -0400
Message-ID: <20250703160409.1791514-1-luiz.dentz@gmail.com>
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

