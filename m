Return-Path: <netdev+bounces-181084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4737CA83A6F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E6E8C151D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44AF202C26;
	Thu, 10 Apr 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9kdnvc+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997720468B
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268972; cv=none; b=WnPuzYu0Hk5rhPDKXEq4gMY/LdiaLoGFsi9gu72sCOdMRsCy45Tqftq5TmZGR2tOgmQVIXhxjKSthYZQAHs8SNFVYX+k0qpuu+Y0RIEiQeZivHkU6QUa0yV96YqIoXqLRgCrx84CUaWM2iq0SUeQE+HK14i1B7S1K0V0uiqNZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268972; c=relaxed/simple;
	bh=bTp8SFtPOYALUJT8e3aZt8iIFaYn1RadyxcZjeVHTM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUJ9/1BR0srOvFQS/fRNWumKJb4uq1NFlbj7T8xyJF01QDhomMiS/YA97qqIbYv9ijFNkVXcnuzvOnIEk961We9wZmljfLRsVsoiICQpm3/ZvIlBSTn/gLg/4DtT5gU/GNN2N0Xe0nGBKMjvTiJaBcGRl1vm83bwV51pn31w/GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9kdnvc+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso3212885e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 00:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268969; x=1744873769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TfXwJjFvHyRKwcnAWMpGYe2tOn8Dyt6mMwqEaHwyecM=;
        b=E9kdnvc+AUzTCsqZNd00KB8HtvcwMEoeKUXDhWDx6T+mWmBpZELtr+jb9fdQAhouh+
         3g7zRUcGHX3I1AzHjDOKLiZKKjwR/YZMhj7M8Frm/It73MEZycylZ4JvTuZRVUfdcWrZ
         9i4pAOdXMiSDYTwVfHMRyADXCcYUBSK5G08hjoe5kyi5AlIE7tn8PvyTkTv4dYzQDyv8
         wRtzUG5XpjfRPbrq0Gnk+uJ4/m1Cs1zMUcoG2w7PjFseb1F6l54FM7bHEdNVYHx03JBE
         gVGARpx9umsdNj1M15QtfWfkKjB5qUnz9J9FALoCISM4nV6FFlFTsbWpa27rjXdCOWHJ
         5smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268969; x=1744873769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfXwJjFvHyRKwcnAWMpGYe2tOn8Dyt6mMwqEaHwyecM=;
        b=jNHpcjG4Iv1qcZerVt5DBpuAaWIIvHeLR1Nb8d2R9DToPHgvn6PnIOamKfh1q6t0VW
         kLRKAvTskmWlMmYwmsptjW8wh07PDpnwdnBh2Sai9GL8RlbD+IriCA0rxeQ8BWwfvrwx
         nzzAMhP9xPe60kNqS3JyWcd2W9ACIt3RTkAula0dJZNKW3fps8gHGvdEyc4sNOGVcZ1i
         j53nQ7fx6jWUOp32FaeJx8S9IdEsdl3WxMAcPy+XzbC4oZHBv52yBhYD4en5aOH09MSI
         ITEpIab0zSLBWCKRide14z6nLXt4t/ZZ0O19Kj3T/csG+9Gm8T9SGj6FYXd00sZFRhFm
         2omg==
X-Gm-Message-State: AOJu0Yzl0O+q/GfUxPZnaD7D4a9/nCYO64OJwus3SVDqGCpKdsV5bCH+
	tFTVZWxW1l0+z8gc3eJ97RDl3mp6ZomiC31MoeV25OeyDwEkd0rfHhdW43Zv
X-Gm-Gg: ASbGncvluc5x6iJyNNIUfBh8RLLSFPYTjp82IIQ+7x0eO0BKsRe47K8tUsQZQEQXYdZ
	V7fQqfdja4VTdL17anutXdm3BlpUGG7V0fD2wLreNf6z0Mul9Wq8vqtMmxpfnNdEmbZyIY4db7n
	8FhIYf6MblNmkIuxl5uwORWz1jv0rvVc2mvJVjzMoSZhf9g85BA8xdSmQPWxvvxMBqDlVD6gDX2
	1eyZL8Xf+tfvv84aMUhr9jNiXngKJgoqbriQqN8eSvyyenbrBl514+/AYnHiFL1mr9FelFbs1Ok
	uEbTrf0qy6xTyX+FSf6lw3Oxj8CHyMat7OCjvA==
X-Google-Smtp-Source: AGHT+IEOnwRWDBFL36RTmYWqXwsxPAxtfcC/cyfRI4pbDcOZTImP7yvTq88TZPUZIdTlnS1THtJgew==
X-Received: by 2002:a05:600c:214c:b0:43c:eec7:eabb with SMTP id 5b1f17b1804b1-43f33793f5emr2679675e9.8.1744268968595;
        Thu, 10 Apr 2025 00:09:28 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:9::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20625eeesm44377335e9.11.2025.04.10.00.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:09:27 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jdamato@fastly.com,
	kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	sanman.p211993@gmail.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next 0/5 V2] eth: fbnic: extend hardware stats coverage
Date: Thu, 10 Apr 2025 00:08:54 -0700
Message-ID: <20250410070859.4160768-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series extends the coverage for hardware stats reported via
`ethtool -S`, queue API, and rtnl link stats. The patchset is organized
as follow:

- The first patch adds locking support to protect hardware stats.
- The second patch provides coverage to the hardware queue stats.
- The third patch covers the RX buffer related stats.
- The fourth patch covers the TMI (TX MAC Interface) stats.
- The last patch cover the TTI (TX TEI Interface) stats.

V2: All updates are in commit 2

Mohsin Bashir (5):
  eth: fbnic: add locking support for hw stats
  eth: fbnic: add coverage for hw queue stats
  eth: fbnic: add coverage for RXB stats
  eth: fbnic: add support for TMI stats
  eth: fbnic: add support for TTI HW stats

 .../device_drivers/ethernet/meta/fbnic.rst    |  49 +++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  34 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 178 +++++++++-
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 335 +++++++++++++++++-
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  48 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  47 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   1 +
 8 files changed, 685 insertions(+), 10 deletions(-)

-- 
2.47.1


