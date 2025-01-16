Return-Path: <netdev+bounces-159018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1FEA1422F
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E2C16B442
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D522CA1C;
	Thu, 16 Jan 2025 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gsl+br0P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025622A7E2
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055482; cv=none; b=V0xrUewJ4u2UBhK2C0YQAGwRPrGHTdOPMJAz8VES9Cmq8W6nU+1pj9jmRL3QwQwCnS3QvXCKS21QK3uEZp9kYtoYiHVjlt2PLf02+hvbbzJsD78xSyWBm2AkOA3xW1D4lqE/a4rU0D0idAHMgbMGxlV9JQWcscK8CnF32hydMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055482; c=relaxed/simple;
	bh=KXarP7EWyEoLwaS0vNWG8V1nttK6kqT2peSjaBjn3Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHnoE1wp1pDVvebFBE70kYhvlJ+7XsQBF8opYbEcNOcJa4FeAf4+w8x5GCCgXJY9zqWosHaQ4tBrx2tfIC4CzIxSMoVmcz7M6sij5iX0+TLUwBnWxp9EaebYWzCPfcgmC/8Vx9kAByzq2cwfRAjwyG4+bftHCM6jlHJ36pVsjiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gsl+br0P; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so1852734a91.3
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737055480; x=1737660280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c63fCgs9pJnOYyl+2r1aH7gTe0CvzGo6Rb/ig9KaxqM=;
        b=Gsl+br0Py9KLos/aQeRkFbT7tBDAhQHKVEXV6lLN5mamYsLP75/yCnmCxvnCX/UsK+
         odGj/MhRjRikTsW5SU3unM4wkOcU77WVdcRNqOyfExlfx7SlABrA/HQbCLA8unBmwaFb
         Z3VVDUsGx8ahOl0HtcCyb547U4kgY0QY9QwoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055480; x=1737660280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c63fCgs9pJnOYyl+2r1aH7gTe0CvzGo6Rb/ig9KaxqM=;
        b=hoUhJAwUG+CxJ7ken7NObw5TTwTh7WnASFK/DjxiXJLMPi4s3dki01qHi/bwmfaLyy
         5PYbKFXPeRwYi2eOad7cDQh5FWmfjDkf5XLMO2Q1LtYA1aMp2jArwgNanF2+LhUw0w2+
         SOo07v89W5XZPeeKh6+ch/qCzxUBa6en/tgGUFeha2bTpXfzqEWMDmzOM6AWejwv5dl8
         fUX9NXB3OuhXnMe6JSvM0Y913rDwiSKpmEbdgqna2IOrWFas1x6wTVWccDxhUFUx8hzW
         IWOz/GcfW3XHf0PxMoKi1ezNi+/jCBZ3SJr6a+E3AFmi28XDiGibdFdIWBi7PBDm0q10
         E/8w==
X-Gm-Message-State: AOJu0YyzZjro9Zt67kDNnmi1BamFR7Z5Pex2dy1bEOVeVciwRtgimSVI
	JPKNb4fE9XhmE1E8/6YVlgVnsFAP/iNwKCMjep3R1PrgpfdJPpx9JBSiuiRHyA==
X-Gm-Gg: ASbGncvqBXlwAOmsahPEN4POcduV7xwqDkAIwj0kV5FzosE9P/kp4FfCeaXrhU8+Ypf
	9fZvY+CF/fNEZFvNtvTs0sy3coj73Bmx/ya7froOpXfn/Hi3P4kt34+jyuhApXvHlQgXwxzgrG3
	TYbK5Vs65lvZEMhhfFv+bDGRE8iGxYJV7ET3ad8+Ch9fdMwFbCIH6Io7QgTR3NtnR+0cuUQFzr7
	VhsKMPYSN3frNijRkY5ZwUg6A2PrnzQCBjvVek8WXMrunnGIjNhrM9sBQBsBaDVvcAkZSh/WNEs
	GRWXk6noDr2yY4QaGiRaF0xq+ixVd3uy
X-Google-Smtp-Source: AGHT+IHtu3Ef1YjOCNCHyZmmGqMtTctekn6C75aA5B+DiWx0InJwb+bjtXmApvKUS6Z3buANQAAnSg==
X-Received: by 2002:a17:90b:1f8b:b0:2ee:c1d2:bc67 with SMTP id 98e67ed59e1d1-2f548eb3415mr54928777a91.16.1737055479883;
        Thu, 16 Jan 2025 11:24:39 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm491017a91.19.2025.01.16.11.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:24:39 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org
Subject: [PATCH net-next v2 00/10] bnxt_en: Add NPAR 1.2 and TPH support
Date: Thu, 16 Jan 2025 11:23:33 -0800
Message-ID: <20250116192343.34535-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch adds NPAR 1.2 support.  Patches 2 to 10 add TPH
(TLP Processing Hints) support.  These TPH driver patches are new
revisions originally posted as part of the TPH PCI patch series.
Additional driver refactoring has been done so that we can free
and allocate RX completion ring and the TX rings if the channel is
a combined channel.  We also add napi_disable() and napi_enable()
during queue_stop() and queue_start() respectively, and reset for
error handling in queue_start().

v2:
Major change is error handling in patch #9.

v1: 
https://lore.kernel.org/netdev/20250113063927.4017173-1-michael.chan@broadcom.com/

Discussion about adding napi_disable()/napi_enable():

https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.uk/#t

Previous driver series fixing rtnl_lock and empty release function:

https://lore.kernel.org/netdev/20241115200412.1340286-1-wei.huang2@amd.com/

v5 of the PCI series using netdev_rx_queue_restart():

https://lore.kernel.org/netdev/20240916205103.3882081-5-wei.huang2@amd.com/

v1 of the PCI series using open/close:

https://lore.kernel.org/netdev/20240509162741.1937586-9-wei.huang2@amd.com/

Manoj Panicker (1):
  bnxt_en: Add TPH support in BNXT driver

Michael Chan (5):
  bnxt_en: Set NAPR 1.2 support when registering with firmware
  bnxt_en Refactor completion ring allocation logic for P5_PLUS chips
  bnxt_en: Refactor TX ring allocation logic
  bnxt_en: Refactor RX/RX AGG ring parameters setup for P5_PLUS
  bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings

Somnath Kotur (4):
  bnxt_en: Refactor completion ring free routine
  bnxt_en: Refactor bnxt_free_tx_rings() to free per TX ring
  bnxt_en: Reallocate RX completion ring for TPH support
  bnxt_en: Extend queue stop/start for TX rings

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 519 ++++++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   8 +
 2 files changed, 396 insertions(+), 131 deletions(-)

-- 
2.30.1


