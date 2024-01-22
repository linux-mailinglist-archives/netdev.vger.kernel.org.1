Return-Path: <netdev+bounces-64770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA8C83714B
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2EA28F2BF
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC82D3FB0B;
	Mon, 22 Jan 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mA53XKQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076B4D584
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948016; cv=none; b=hQyatC1j1jjOY4mO3ysHQOzo6jx10nSYO/0bxwPI5RAJ7ClESBTh/c4CsxhiULzVxTVu6TQ0yHG9gwQxmkcOAhy0yGX8VHNvRV/RFrFe5O4Ltoa/PMrsUVRiRiXr1hFqpjyMu9D7/PZMXR52PgK/m0eJZeyWxl1OxqrgsSRb6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948016; c=relaxed/simple;
	bh=ybV6z2hqQPDQw1ABNz790esl7SAeUvQauxtQGZK/voo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gjZbqcqtx5hiwvFAZQL8h4qexpa1HyoqU2xDUZXSXJW69bAin1SV2+xLjoSc+6vTe0nR50iTyVR6xhgTe5e0ZrD8vbgVSmGE8eTt5xawRVRWpSC97rgUNz58SuaZhQ10y91DjCZ/eVNzhBzRpYGiAfttNZHDeAELfUE4Mqb5AQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mA53XKQO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6dbd3fe3f20so1220065b3a.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 10:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705948015; x=1706552815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QtaVgRSr8CXNQauRQsB6MslOP1fBwoXGTMNcUwZpLVE=;
        b=mA53XKQO5+X0GZo7YDNWHdRhNx7v/UDeMuWtYcpIHN+ve1NDGSwbl9CvAbiA4F3k4P
         dDezoOn+xOnBjNcQt/CgMU09AzYH2o3sDKW1WLe7DeZqxgzcrypUxZJX6LCYuOGBZnXC
         amd5p992m+Ov15yNDLaFYx0wht9fieQeH5xLSboZPgb0G8e5XWZu+g40fzg6W7dxbUFC
         GQmw5lIM+hH+LyC8sLKgLSnt9wPV+LdQN9DqYNNcmUKem9UmhgrBIjpEg5HueE3ECapd
         Ob22mPl5klNzepzDQtH4HLudHtDP7uVfIKFOMBZY3O8g2vOUoCoxA8U/8XFu6MzwRHSp
         xwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948015; x=1706552815;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QtaVgRSr8CXNQauRQsB6MslOP1fBwoXGTMNcUwZpLVE=;
        b=uEwJYWmYQIB4YlacmnAgj5onRQwUteiKwqeiPqj12DunN2FXqZLSO0RbJFD8IgkUPP
         aayR/d7FL04tsYFc/5oedSeqF70UoaX2hDom6mKZEgnq6BE7i14Xa66xrTgDdMgANst4
         4yfgj1aPVEzTygHF2Bco/j80mWcxn13BjSrj1w0r/Pqupa1UAUd8kcYrQkSdEWAmhGSf
         koYM83mRm1WEfaafLgPyle8yPr7Mb2E5BWEmSu3ytlv+5BiC/+qFURDbN3YbB6SUt0Hs
         ZnkVTG4x5rBgV34xnnR5ezPZ1RRKOwTGgQQg8tqVtUqhPhW5xWoNP4d9r+L6xWB09W7r
         DjOg==
X-Gm-Message-State: AOJu0YxnQM3leD6w+dYFolnmmER5VV3M06d1FRsa9lkm6pS3KPI89gpm
	gzsqxq10s1ntgvSBOZ49PyhtTXbPUjFGYWcCtHy3t7gm7GtDWqjMUWV7Tjuvl2R99mGFz/LHVlH
	1rUChp8WqlzJZgCpIgcIJI//HJYwgznIXpAXKvLo0T3k9pqjtOyYarknu+LRoEpuUu3IL1vzzZz
	+XnXzTQwfkyvdaDciz2aOtYddKv61rBLg4z6EeM8OKVRg=
X-Google-Smtp-Source: AGHT+IE5rBbprIlJ5GNjusCYwbJj55UAt/2XRJDP/gqaLxpr+BQcz9pEfEzdgXMLXZ9IO5X9/oS/XEFMchifQA==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:aa7:8893:0:b0:6d9:a32b:a281 with SMTP id
 z19-20020aa78893000000b006d9a32ba281mr537397pfe.5.1705948014657; Mon, 22 Jan
 2024 10:26:54 -0800 (PST)
Date: Mon, 22 Jan 2024 18:26:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122182632.1102721-1-shailend@google.com>
Subject: [PATCH net-next 0/6] gve: Alloc before freeing when changing config
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

Functions allocating resources did so directly into priv thus far. The
assumption doing that was that priv was not already holding references
to live resources.

When ring configuration is changed in any way from userspace, thus far
we relied on calling the ndo_stop and ndo_open callbacks in succession.
This meant that we teardown existing resources and rob the OS of
networking before we have successfully allocated resources for the new
config.

Correcting this requires us to perform allocations without editing priv.
That is what the "gve: Switch to config-aware..." patch does: it modifies
all the allocation paths so that they take a new configuration as input
and return references to newly allocated resources without modifying
priv or interfering with live resources in any way.

Having corrected the allocation paths so, the ndo open and close
callbacks are refactored to make available distinct functions for
allocating queue resources and starting or stopping them. This is then
put to use in the set_channels and set_features hooks in the last two
patches.

These changes have been tested by verifying the integrity of a stream of
integers while the driver is continuously reconfigured with ethtool.

Shailend Chand (6):
  gve: Define config structs for queue allocation
  gve: Refactor napi add and remove functions
  gve: Switch to config-aware queue allocation
  gve: Refactor gve_open and gve_close
  gve: Alloc before freeing when adjusting queues
  gve: Alloc before freeing when changing features

 drivers/net/ethernet/google/gve/gve.h        | 144 +++-
 drivers/net/ethernet/google/gve/gve_dqo.h    |  18 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 854 ++++++++++++-------
 drivers/net/ethernet/google/gve/gve_rx.c     | 116 ++-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |  91 +-
 drivers/net/ethernet/google/gve/gve_tx.c     | 128 ++-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 108 ++-
 drivers/net/ethernet/google/gve/gve_utils.c  |  31 +
 drivers/net/ethernet/google/gve/gve_utils.h  |   5 +
 9 files changed, 999 insertions(+), 496 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


