Return-Path: <netdev+bounces-188748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 918B3AAE75E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7244F188DF01
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA1289835;
	Wed,  7 May 2025 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/db4WhD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A844B1E4B;
	Wed,  7 May 2025 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637417; cv=none; b=WAZKCDEGo1hZWNxytQll8GAM6WyurVbvQ36tZUH4GRm1ORbRH83yu4Y6jchDMCEfFOFHeOGHDftd4oZMcZb366DkjHWtVKTeIYCVotDfOnf7GG8IpCVK3p8jB+zr++3qYQvadc5LIssXIcFJw5NaY6D9lx3QMhw2gPtcSSzLVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637417; c=relaxed/simple;
	bh=8eUVJRPyYlhkarXKPhhkTVl7YZFQjmEyWmjzc3HcvWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOKvBK/heLAIQ23hOpjEwOG3ZRAl5Z4RVb9zyHcU9eOj8ItXPMMM+JDxHcgssfOC0nHUn9ASTU2lbK2HMpXqbg3dxh7ZVIbbdvcDnMAvCTgzBq8SK6fsbz8LM/JH7b07VqTDMnOcRbGtvvwmZ3ft8QuJV5szWOu9MrwOPqeFmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/db4WhD; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47677b77725so276881cf.3;
        Wed, 07 May 2025 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746637415; x=1747242215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kj2KnxxKGpGn2up1GoK5ThFYhXkMrp+zcnAYeJ+2nGU=;
        b=L/db4WhDH6TJu4uxggV1bspVIN4xygXsgjadsNBj4bwRreKxrky4nMREYBxCFf/vca
         KesfGTk74nXImZrjGCduc2XoWQgnW1yrG9uNJIfv/0KK2y/684KVW/mWXA37ELVeNB3O
         1ocz1GghqoFCAefqCkyx3Kigl8KfITD6/cfR7gI3mLUTgaUP57lXZkaSEx3PDF/M7iSR
         XoFlju2vAz2AF9N7T77u4NIVU91/fqcKShP1wKDAqNbAVH7L9itb8+nkBgR10aZiu3oh
         2KxnrQrKepPPCI+kFXlThvrTNSIhg/5zpmMnuhRAScckdizhEEOmAaozsFBEN2HCqiPQ
         WIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746637415; x=1747242215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kj2KnxxKGpGn2up1GoK5ThFYhXkMrp+zcnAYeJ+2nGU=;
        b=dHW14zQwnnkw1rP/SSUufzHX4WmU9O11aHzMXt7OrVdb2Kaw4EPsmrOV1WUl3nMd89
         aGkNk6JS3yDNccLxoCvccBL3SNdM88ny6WFWxySHylnkWjJ6ylhvMKjsGBqh4Fa0nRfn
         5IiBVTd8lni8BDFVQAz2D7renYr32TDY82qKZXqVJ1QRyuaXifID8oHVWLZLV9tUnrq8
         mXdhVNhy3o2CmH2I6B+QlZRBXaCMkwHM35YLFaFBEYy7x048vG5X47QzJuTbMuJXAn0M
         01nD0eN0BPr482zwZ8jg1x/EIGQLF7ioUVoQiLXr8P7s5hNunXQwdrpW8CqAvTP2M4Xj
         FfBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuLWyq/H9PfmO31cyKW6ykjBq5u/bTmIsgX6ZydpUzA9iTEnxm1Q5dThTC8Bjrfls8ExRcyqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCaOANM6D8/SprXBjDn4oNmkHhm6+IN8eFRm9d57ljqLDA9G9O
	ooIUjU+JMWxv82UVQ0BntcKXzMv7XT8x3axzL6cFdeoh7xoweArzqmskDOGU
X-Gm-Gg: ASbGnctTWaRh5AF7yxvjA4rXlF3jIFp5IminhliLhheszEa/YUVZMz1k7znzyy0RS1a
	LoUSLslK7XnYSBOPRxNXVKlbLQR784O3DNhtS7xqgyjA4SD2FUz6WZngPL/1BL+6TJVvaN7pn65
	2ODkwN41wg0ZVuHrjHg0ek8YzrQCjpgQHE1ZGOP8eQLzAlX7uV6ugekp6+LLfBkcAMDZtGoe4sT
	TcKOtXCth1JK0fbdHPD9mf61bu+li2DZbueZExdTxDiCKyKuhtGZOPRNGU+FAYfPsRWvNmkovcE
	DGQyv/ej9Mdc/WvA09JAXVVUhtt7K0IxvDJrwQGClzHgPak/U22WPbWAvXcaCEMvD9vfvx0ErGN
	Ezqxb7LJqNcMgY2NCHcJQ
X-Google-Smtp-Source: AGHT+IEnx+ykFpDlLv2Bd3AZZno01eoVBxLekXZpwnm8r0RihtH/1KTPRogS0A887teFEGWJSZaTmA==
X-Received: by 2002:ac8:5809:0:b0:476:a74d:f23b with SMTP id d75a77b69052e-4944963f756mr1140991cf.48.1746637403667;
        Wed, 07 May 2025 10:03:23 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52ae419fbd3sm2429387e0c.30.2025.05.07.10.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:03:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-05-07
Date: Wed,  7 May 2025 13:03:20 -0400
Message-ID: <20250507170320.277453-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 9540984da649d46f699c47f28c68bbd3c9d99e4c:

  Merge tag 'wireless-2025-05-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-05-06 19:06:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-05-07

for you to fetch changes up to 9840f8ecc9105ba6e2355d2f792c5f6c78905101:

  Bluetooth: hci_event: Fix not using key encryption size when its known (2025-05-07 12:59:23 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags
 - hci_event: Fix not using key encryption size when its known

----------------------------------------------------------------
Luiz Augusto von Dentz (2):
      Bluetooth: MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags
      Bluetooth: hci_event: Fix not using key encryption size when its known

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 24 +++++++++++++
 net/bluetooth/hci_event.c        | 73 +++++++++++++++++++++++-----------------
 net/bluetooth/mgmt.c             |  9 +++--
 4 files changed, 73 insertions(+), 34 deletions(-)

