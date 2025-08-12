Return-Path: <netdev+bounces-212794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAB1B2200F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC27A1AA78FE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C8C2DECD6;
	Tue, 12 Aug 2025 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHMSv9AX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B62E0902
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985313; cv=none; b=ENMdDjdpqKQnVSQ/YpZ1JnGMmYEW0pF09jbAlYj8ztzvEjKecg1JDT3p+rcmp5L6sK2cwcBGlJSnrPSBeeokpNizKXLHUiLUCe1PPgCqQQHG0njoXqp5yCAq8fOfOTvabAk2dhOkT/m4WRZfZ8lbg6GNvBM5yuUCndHsXqXbN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985313; c=relaxed/simple;
	bh=WNoKnFlMYArIowDJYU2yOu2fPbdtPOweThRAVjkFsEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YuGIr+EHnF0Oa/OUqV2Hi0yUyWZul2TeQa02NV+i302wQZRp07BBSeZGm/PkTFjoTx9VLCk8qLf+PTfglPzkGLKiC5iP32vZH8KAqfz2DYxwixLDtWx8uL63QKHX05jZobFVsCIwvWtZPtaPWTU2i5AY+PVADNnCOWTDY+iJLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHMSv9AX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso4741531b3a.3
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754985311; x=1755590111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EstXPrrERUXhncRMs7vfL9VNUeOreUPoK6OsUT3vWZ0=;
        b=QHMSv9AXdJ1/B6QwjAWuwUNasiqbPLt0N/ZnyxaEiV+FZJooH+VIXQvUneZC0r2mvD
         z7/kFB+XoG/GVqkJ9RVa7ZUSkoQxE09TmNvzdY6ShM0yPQX8JNzhAx3uyz/cXRd/B/4U
         z3tkRBHGZgHdY089uUYm+rnKjOl0s5dkzca1fefElSOSm+y/V1JxPs64SPMn84dMftFP
         Klm2M1mYrpf6DP0U4i1PVTKgigyq0cqkt3yEWNESC4iX0VUAWuxMS5lDl1QjvIftODB/
         f/ufQyqxcjJCKwMPj8/kTQxADgIHmBig1z9tCnIhj9rpPirbi8N1+gsnq71ODqsWGg9K
         5L0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754985311; x=1755590111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EstXPrrERUXhncRMs7vfL9VNUeOreUPoK6OsUT3vWZ0=;
        b=eIg0nrUayRBGC0EjrgpYms6S5IFUM0zucAiTEc15PFZ7WEZd2cydpLYeaUARS7UTLT
         sGirOunXNwiESaKQJzwVaoJ7sZ4JQwY7bfhPqWLZKewtgC3eUQ2zC5eaqgZ5/mgHWmoL
         Rn5cdXdI2Nam/N555RqyX2dALDiWHQNurlLuvk7avbYEyvTi2U0hsieKSYkVmXnVjcfo
         FBV4dFvEww1ucbgXpfExmhsCu7xuQ0yrbG4Ccxn0JfFtIhqrKN75tHkFhhBVyySw9O2P
         iMpHy2/+U5ulNNCHE0F5Uiqg0DE0YBSfX9kxcz1801UWRAT8GrGxF/GUikYYqhHBcCTm
         dVtg==
X-Forwarded-Encrypted: i=1; AJvYcCXGOJs2+aB47cjSWIEB215UXheL5VGcEpC2OK/diX7FHdZNWSCA1F4Lej1+jSO5LbQqhVQiqws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+SqvVDLfcA3IEOCok1ClcVIayvZeiBMXwCrY67LK9iut33xX
	R6OuwnRFM9eBU6LR8ee2MHJvg+ahMVUrnooSo/qT9r8d7Ck7hXqScdh7
X-Gm-Gg: ASbGncuPe6nRoIEGiXiRqVf18lFJ1y791Sow+hM21B99WIAkETTu6L+HpUY9uwY4Zcz
	rXGHf9W24hVJhQMUbicToyiD5HZAANVsWqAGo1uwl0IRPHrJqMIgfr6WSdH72P7xgSBZI6Ojl+V
	tObwsiqgvKMp08dESuPK0WJtUCbJTbzjKdRdLttE4f4IqFt40FH1WW8oLVIJTHh1UwtOmkuCurb
	ksZnRddKLVFMpFuN3L2pfIErW2dDJS/T0joKvnLPJZ64cBDWZhjlEFYx7QWXSWSdPBYkZHeEKFB
	rD+cHyf7njDjnMz9ei8IzHVYPEHz1XCzCxzeCKHz3O/hr8UjmxLoNv3lhx9Ove0Fkydcj4W0ie/
	g4d05Gd30snAxLiJWsg8uztF6j6s/AYldyWSVi+spZXoFC/GITCpywHi5hAWuC8lzeGBA5A==
X-Google-Smtp-Source: AGHT+IEEvxfIOwJmDYTr2qxi+cu180YYS+zstj+NKAdeIK2ciZcGCc+lfoTc6bhGzHHgzTk1QUBsyg==
X-Received: by 2002:a17:903:3583:b0:240:3e73:6df with SMTP id d9443c01a7336-242c203d426mr184129105ad.14.1754985310849;
        Tue, 12 Aug 2025 00:55:10 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac12d4sm24651320a12.32.2025.08.12.00.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:55:10 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	sdf@fomichev.me,
	larysa.zaremba@intel.com,
	maciej.fijalkowski@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH iwl-net v2 0/3] ixgbe: xsk: a couple of changes for zerocopy
Date: Tue, 12 Aug 2025 15:55:01 +0800
Message-Id: <20250812075504.60498-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The series mostly follows the development of i40e/ice to improve the
performance for zerocopy mode in the tx path.

---
V2
Link: https://lore.kernel.org/intel-wired-lan/20250720091123.474-1-kerneljasonxing@gmail.com/
1. remove previous 2nd and last patch.

Jason Xing (3):
  ixgbe: xsk: remove budget from ixgbe_clean_xdp_tx_irq
  ixgbe: xsk: use ixgbe_desc_unused as the budget in ixgbe_xmit_zc
  ixgbe: xsk: support batched xsk Tx interfaces to increase performance

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +-
 .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 113 ++++++++++++------
 3 files changed, 76 insertions(+), 41 deletions(-)

-- 
2.41.3


