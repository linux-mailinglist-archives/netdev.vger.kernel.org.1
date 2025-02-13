Return-Path: <netdev+bounces-166119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033D7A34A4A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09815177DCC
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387EF200BB7;
	Thu, 13 Feb 2025 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIj7cdja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C52142903;
	Thu, 13 Feb 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463891; cv=none; b=uByUGHuhR1My1WPb08XrxaHhSeCj4E/TeMMiIuotHnI43igIBwKirYVruLFksxz0EbUb6r/gkTH/jxjY6QPEZzKgWKe3ggO0FKrInnfsDerr6et2dC5LVZFWz2X7P+9qQT7POSy8RDcehBMC9k4xPCVYYezYzPoucZ5UubBzCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463891; c=relaxed/simple;
	bh=hCLaSpRrZNAM+Qdl0uGypkFPjefcYkJglUCk1mcRnZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDBGJo61BhrxI4VFAXOMW+AzFaWc2MzrmDFYEFDIF/NcxMQZtygXhCxFg7+DbYIv2UoGcpxWDhuADp1fF66OvD4R9wJbuCiymlV2pDsGuexHDhQnemGEExY7fL1z6P2A1yEck1I+d5cvqxjyb1qd+1X9f7bCIkJqcn0jjqn/sSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIj7cdja; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so1132171276.1;
        Thu, 13 Feb 2025 08:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739463888; x=1740068688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DLKNZeQ3LH1NFu616uvDBTZfSlpWUGaGhAaTt3QR6Ww=;
        b=FIj7cdjafc4Z54GaDJjLOS+NwKAU73Wwgtbwb/+Vf0Ql1LDHM5md0zVKQPF8xiE9ZZ
         u/JIx7ieBAjibP5AksOqQv7Puvk8KO74AatFa97Cy05OehWsOo/ioBzYuTy8YPeLuzyg
         dp//xJNZiEUefn0Ac7HoP3RlDXNJ6nnKI/u42tQ8tsDPJhMsEb/sDva16tWzTNGz82WO
         V25hUPWj5W79/JTp1rAA2OQEYBxmKMK3ZF3Xa/fAOEjA0GNgcIANCzznR8r694b7jh17
         wxZCDvOlmvRdDqJ88omPxITC9nFNhBb5btxBmk0x64oY+cIkcptPR6BOWmVQU00IyAwS
         6tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463888; x=1740068688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLKNZeQ3LH1NFu616uvDBTZfSlpWUGaGhAaTt3QR6Ww=;
        b=a1oR70iyuEDH/+8duAor656w4xeuTcfyQYKKIJESXLNobSXYdAtaMqyson+v7vZVwd
         XAaNPdg2/I78Xe/5+VplXwi7rhaAjP/Qg586/pW7nncp7Fl7mOP+HEQcMNXLY6nD86nu
         b6CSkfWjKBKDBd5kplHtk321ao6Qg1JV+5aG0Jd/8IBxQIW6oR1ymT0+RUpprwNWbKZS
         OQKT26H+lkRWK4PA1q7VQ1le6S5FpGOGQW+ByZzm+1flvEFP7tXzYisUGGK7w4iNmDzB
         rs719rkT8aW6dZBzGuM52C76k/WfHcgECxmGQ5VYK7sDDwTcOPY3RijahYb5/TCWu0vA
         kkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqUE0IBHbNK4LnTqKB/tRDMXDs4CUqdh8KIBi/vJGwbdekgb6FBZwTIMlkyh4U+K0DBDgrYJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnqo6RWc8rED2lBOEFrO4JEHypBWRw6qxK5TDgNXB4uCXjds0
	EouIoV7BH+OosyhsxebhH/+o0LhilCrnWsYHufvrUd5yg4/yMgmvQs8mGlUL6rM=
X-Gm-Gg: ASbGncvDec6SpKgPzd92y6YZe5OWdEYb2BcdKUtPWXVO/YpPw7jtLqirtjGoYSGS5DN
	QFIbnzCRwUab5zwgAtgrBvGTIPCbFslYvB70+AADLTWYuXVxZLmXMGGXNAymnqChgypXj785yEy
	bHS7Iq2lV7x6mfURJvM6AOX2q/YCO+5bD+t6ndwX3yJT8m0CWVHyCE0T63HCQreivHgSRURfEFn
	U6C7BQRgyfv1A+K/A6NmkunsL+JQKNDFRrfQpUc2VDyKclnQc2CTVlEKExT4WZGtMaCOtV2yTPh
	RWN2QYEykN4MrjpdQW4rm2nlkFVff5ygTxtMiICfwxB1A8HePlu6nI/ssu7ybhc=
X-Google-Smtp-Source: AGHT+IE42JvzsphUxmTZF2aJApQSUmf/ILuJJXUvRmKVzR8RKpO/V0mx9qCg7J9rFs9L3mvFCMcLMw==
X-Received: by 2002:a05:6902:1aca:b0:e5b:225b:19ab with SMTP id 3f1490d57ef6-e5da7cfc5a7mr3657695276.0.1739463888389;
        Thu, 13 Feb 2025 08:24:48 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dae0da0e5sm456937276.39.2025.02.13.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:24:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-02-13
Date: Thu, 13 Feb 2025 11:24:46 -0500
Message-ID: <20250213162446.617632-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 0469b410c888414c3505d8d2b5814eb372404638:

  Merge branch 'net-ethernet-ti-am65-cpsw-xdp-fixes' (2025-02-12 20:12:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-02-13

for you to fetch changes up to ab4eedb790cae44313759b50fe47da285e2519d5:

  Bluetooth: L2CAP: Fix corrupted list in hci_chan_del (2025-02-13 11:15:37 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - btintel_pcie: Fix a potential race condition
 - L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
 - L2CAP: Fix corrupted list in hci_chan_del

----------------------------------------------------------------
Kiran K (1):
      Bluetooth: btintel_pcie: Fix a potential race condition

Luiz Augusto von Dentz (2):
      Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
      Bluetooth: L2CAP: Fix corrupted list in hci_chan_del

 drivers/bluetooth/btintel_pcie.c |   5 +-
 include/net/bluetooth/l2cap.h    |   3 +-
 net/bluetooth/l2cap_core.c       | 169 ++++++++++++++++++---------------------
 net/bluetooth/l2cap_sock.c       |  15 ++--
 4 files changed, 92 insertions(+), 100 deletions(-)

