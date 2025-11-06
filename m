Return-Path: <netdev+bounces-236501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95351C3D49D
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 20:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433A23AA7C0
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 19:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71D634A774;
	Thu,  6 Nov 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNxvtxiR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD01AA7BF
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459013; cv=none; b=hVa5hErylLfhgCpTO7jD49BspfRryUfAvo+vi0zDvSRFK6xmVFl5bGPlZf7L0L4BNY1sFOTZnNBxpurv+vRz2V1zkiGjLYNU8cL3znJWApjolocsVU7C7yBZRSFh9k4my9rKWBw2OPfLpyxo1gseB9+i2+tmh/cMqx/3ptlQyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459013; c=relaxed/simple;
	bh=5FI0IkQm6myrpbP8yVqdkn6nt1ygJomCbomTQtpmXjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDOj9XLN0oTqt6OIgB/yV9Te3KUYy/bfG+nbOXnAlnbiw9JqdF+KTa2+RmTkpBUuo7gmtFltSPtInrpSCyrbflisoo3ZpiR8f3NsKQGcMO7XjdUfKhpMjmsKQvwp3kUXrzOvvoz1b53wXHzZkcF7rFEEhFITljFO5Hihaj0OlVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNxvtxiR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7adc44440c6so413b3a.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762459012; x=1763063812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEtJRnrpSj/c11WcQopWj8JF0D9TZBxFZPrYbVMK014=;
        b=CNxvtxiRbno+D/wSpiPLdjJFMDAsWFPN3UZJ+51RlD02BB2vMO8AFz0HWFbhS6urJd
         3EM4Fqb4yCiV+CmzX3DuABgyj+gbB0NJFH5KJXJ9yF/XoamMXg3AqWGDavEWBBYgultv
         5H+GAT1SLIx2pFbAxtCQyCY/+e5GfbWMV6km9290J0kduzJb4oRr55w1w82w9lnU5AnY
         KTOGa2qWmRu6R7K/KzSoJVPBcbBPsSWXuy6X2NNtgYjf1wV26CDAmSSkPBjJ+wMz16b1
         hQDHEzBSLPSCg4668MyoMb1/FPSmrL826oRmG0GmCJ8K6uj/1rUbme2UdPzPdQYv8ZiV
         ESZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762459012; x=1763063812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEtJRnrpSj/c11WcQopWj8JF0D9TZBxFZPrYbVMK014=;
        b=FRmLo0idFEmGWeollpwGfef1iX012ih17X5EBaWUe9DqjaAM6JU6jL+UPDaFHbYrpD
         tWDOzCbv9CWQa/NwMe7DEVSKgZEnI/N0KB0dBzibuXqgslvv+bwx8gkXyYp8lC9+X3s+
         tPAJ6zkX0ubPO7PDkTSZLEo/Ue6dpAkRnyvgwKYl8nHtcWOisTal2tflZPzcYuSn+Mh1
         fdmAZaBwjCWN6Bq9cge8lFMOY1iXwyyxVctEQp7bC2TUM5+PDvFS8c055QqtBo87X84j
         whldFRx194hPuT/wQGMdxNvojt/ws/JuK8u90nKPkNmfMvGI9v3VWEOLyMN9cuNWJUxN
         Nz2g==
X-Forwarded-Encrypted: i=1; AJvYcCVTKzkpbcmKgJRxhbP9Me/yNtNV4mgCCDOnA+mF+25js6yerqZgGUEWgt0tD/F0l4u2HI1en7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaTXZ1RZ6pyg4aTPOX9J5uyEd6oaumif1OD1jXO75UKclTxRDk
	xCiFp5eeqIH8GJniWHLhKQ+zambusUD+5pzmzbpLaf2a7+F8VNCWvL0c
X-Gm-Gg: ASbGncv+m3U8NWeJ3Fm7d9ZGglJmSidXzQ8F496B3Hz6NdIv8NqzIjXMXPhHMYQNmvh
	6JyNsUL8mfgLeiUd/akwhKMqRfaQ/aBUh3oQoPkoCoYD0m9rn+epwYXuT/HvG2jNzbbBcEgpJ4U
	+mhbfK8TVRK7VGPAW7KwOd227Ns6Qn88/zOqn63BilKHrqrN+YLMIZVc9Xw3qMncD1eopxXtxna
	yrSJLTbu73N4kfGWt5jmXehPnIKdU02/O48IMkSKe0tVWKQbIHbmbD/cL55/2YNgbyGdXcTkDYo
	LpA+/LyhTFpX8T+sbMyLt7WgQMuy+9oG7gMAtsp3D948+i7IsCTKYCRFEAGMEY9nV9gh7CqyuSg
	rKGJ4lSt+E/IzdLUuj9WlI3v6A72dnaPMhCQ+RKzraBDyp3UyMbKcqvBikmV3s8TrenZIVTajcU
	tPUxd+9e0sHBOiGJfm2GqMLE4zoUIMWZ6VqCKgNJQe8g==
X-Google-Smtp-Source: AGHT+IEqrduIZ0k9qOO/+5rFWXw8zlvFXIdWggT09NWs7Ud6rsYKIaiKc4oRhwNumh4AN+y2araGbQ==
X-Received: by 2002:a05:6a00:22d1:b0:7a2:757f:6f6b with SMTP id d2e1a72fcca58-7b0be552630mr499468b3a.7.1762459011582;
        Thu, 06 Nov 2025 11:56:51 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:53a0:e5b3:bd3b:a747:7dbb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953cf79sm391246b3a.3.2025.11.06.11.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:56:51 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com
Cc: vnranganath.20@gmail.com,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: [PATCH v3 0/2] net: sched: initialize struct tc_ife to fix kernel-infoleak
Date: Fri,  7 Nov 2025 01:26:32 +0530
Message-ID: <20251106195635.2438-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This series addresses the uninitialization of the struct which has 
2 btes of padding. And copying this uninitialized data to userspace
can leak info from kernel memory.

This sereies ensure all members and padding are cleared prior to 
begin copied.

This change silences the KMSAN report and prevents potential information
leaks from the kernel memory.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
Changes in v3:
- updated the commit messages and subject.
- corrected the code misisng ";" in v2
- Link to v2: https://lore.kernel.org/r/20251101-infoleak-v2-0-01a501d41c09@gmail.com 

Changes in v2:
- removed memset(&t, 0, sizeof(t)) from previous patch.
- added the new patch series to address the issue.
- Link to v1: https://lore.kernel.org/r/20251031-infoleak-v1-1-9f7250ee33aa@gmail.com

Ranganath V N (2):
  net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
  net: sched: act_ife: initialize struct tc_ife to fix KMSAN
    kernel-infoleak

 net/sched/act_connmark.c | 12 +++++++-----
 net/sched/act_ife.c      | 12 +++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.43.0


