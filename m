Return-Path: <netdev+bounces-189024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE620AAFEDC
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F183A7DD8
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F428033E;
	Thu,  8 May 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvc0a1qp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF3278E5D;
	Thu,  8 May 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716971; cv=none; b=UlaFGQsozAyJlhEukaMmRLO1qHqKuLfIfI4OhzH2c5AJ3Gz7n6sOWK0YAilksLXalcqA2knfPH7PdMPTlSboa1rnKNbSPgK7vIdZnIxQSefJoXo/s2Syi/prBXJxNwTn5LcvdQESHvDh2gLst+dgMLPOOWjAI35iyw1bhCd69iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716971; c=relaxed/simple;
	bh=fGB+yKjeb8ffrLoSgbQOd+z4ThQpUI2SbP9Jpn7uTy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=de1aA3prTBfhIhEik3bA5QTrf2aKktAMbKl+30veCv0Pwl19sFpZveOPy/ifOUISLd5hqzSMfxvK3orX5wDTLjAJ+/oFkPJF70UDfdEQvFpUANImPywUusV0i9zG9l7waBR9F3fIP7QoohPjz3pUBnE5Sk1ptst7n8JHocugqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tvc0a1qp; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4c4ecf86e8bso307635137.2;
        Thu, 08 May 2025 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746716969; x=1747321769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kxu3Dbeu8bOMl8aZlpHoIbkGf20M2m3lyThgL8zFGT4=;
        b=Tvc0a1qpyGR7FbCIhhdvYMxa5zkBuYHgax00uYQa7h6UfULLg/3Ke5Ba0DT2XZG0r5
         UoBiE6XofWEARch/OQfuvc0aDgIvb0Ka7/2M3hDzIqCVTDmlWyocYFrEh8H53+yrWjXu
         K5uB3Yhvkj6nYoY1a4YkizvS/LEYXXabz+UY/a3HnDimF4EcMgNHboZBQyE7S76M5tZP
         Fia9UzUkNtGrr7l2xdMBHxzFQZ1KKJW4BTtvxbhSeCnNeZr4n2o4OWdiSHeif4Bs36/x
         gGoNrJ8BXdB6H89/q4kmWctACGEyZQ2MkkKcTOmGfNKYYpyn6Cfasjn49mHhFWh9JbV+
         7gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716969; x=1747321769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kxu3Dbeu8bOMl8aZlpHoIbkGf20M2m3lyThgL8zFGT4=;
        b=OoyHNkRtxcQb8KFQZkXxB74rJk6GZE0MfUwr6vODdV0/WLR9L2KNCTE6pxStCWBPYT
         u6wnRQauOX//phOg2j83/cqU/SOnlwtaRdd5fD5M6Kf3BbxudSfDHrOOlvWw/RNzjWHn
         locnvRk/hA/sYclvYulzuYCehB1Z8pv8C1aZeYmmLozfjckFQK765l9nk+D1IKnZgtTS
         ipu58ZBHSUnyhi26qExiKIH4L1v6vvKhhH//64rglvfcl9a5H4+qHWffxiC6qSSQAQHW
         AlgtDSoDzSyslcS+oDuLhslU/2x/7SiV8DgFerwV9mX2hRuiRmuOqlkZa1O9a6XlCvnh
         Yvnw==
X-Forwarded-Encrypted: i=1; AJvYcCV7xzRYOjVMzmzbCHftbmfBY0s0EJAv+Lb6H+H8eXUQ9W2JyCKxP3x3RR7GlSZkScEmAoPKGxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4TJmGMGlDxK58PuLb75V9llR3WkhA90ohT5e4AILGgSH4Ljx
	dkdD1i/eoTm+BwdJwBCi3q71DAXrKdxOv/oW+I01gkCAoL2k/tMn
X-Gm-Gg: ASbGncvx4hkHFEMaIeoumgeHG/LXgsq8pVEfr/hRj9JkVcpeB3c6g9uSDLKokP0BN8U
	vJnGao8AslqAmVJO7jBFMXG8Dzc+oXCk9B8rHxbaGulvxa+0/udDFCaUxQ7VfAoo4Rgxz5YK1cx
	u9cj6sM9houYDSoYN6CXwMW7b8l9lgdauFg0kwfNKipBjEwoEhfmY/KMOO4fw7Lx4E0EZnadvln
	RYOf0uZLCZaiQmz/l8Ba1BZKgHAErm1gObMIkzoEd5nmtD7OoBUirjS3ks0GImaTZ5hy6tP3XpZ
	dW0JWj3wc4mUTyozLNEtrkJPv1ux5iTgfZPUFCZbztTjMEfGZgCA58BJBj39r3aTmrKoqv7ALfj
	13mzeIpHhAw==
X-Google-Smtp-Source: AGHT+IFVOPi4eO2I6Lfh/vwEPyXEM91qvBR462r8ZZAAqF48ULqi8tGqE0yaitSw3TzklYlmaCS+7w==
X-Received: by 2002:a05:6122:c96:b0:520:6773:e5bf with SMTP id 71dfb90a1353d-52c53ae30b9mr45091e0c.1.1746716968981;
        Thu, 08 May 2025 08:09:28 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c538a6f4fsm9633e0c.43.2025.05.08.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 08:09:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-05-08
Date: Thu,  8 May 2025 11:09:27 -0400
Message-ID: <20250508150927.385675-1-luiz.dentz@gmail.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-05-08

for you to fetch changes up to c82b6357a5465a3222780ac5d3edcdfb02208cc3:

  Bluetooth: hci_event: Fix not using key encryption size when its known (2025-05-08 10:24:15 -0400)

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

