Return-Path: <netdev+bounces-234207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0F6C1DDA4
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8803A5043
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F22E40E;
	Thu, 30 Oct 2025 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RArflTXl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BF1C695
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782816; cv=none; b=m/XeUqgthpa/RFelWYjhazJpJg0g8RbN0b4dFmasaaKAkxhy2G6yQ1sOHzsUQQDLBZkja5HSaT3Nv5tTj4raFQ1HPahf9NyPyFBPB+hEN836mXubu9nJk9zBE9Nns/6DDNqZZyRN2W/x4atFptpwookxb63caGvsXJ/nRTTgK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782816; c=relaxed/simple;
	bh=SCfiGPiies82z9ioXueR/N43iveSe0WK/6Zp/t3WuJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fwjcqbw1KitRCq7HiBfcOHG4KyCcFJ5VsyC1HHasO6rhTJfniQtIXuiClE5e2Rbaee5PDAUW3M4rONihvNQFsi9vH8B6OiyWm4BiEJ8AMd6f/hAdrbNy8b5CV9JCvXRUOqWl3uzEP1kULnZ9XOknlsFekcQ+PhGpi/RqUMjF368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RArflTXl; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso1146194a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782814; x=1762387614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b1hNkDtSx9btv+ppu5ID3Ac1b4Cfy+TXF5aN1lbNAbM=;
        b=RArflTXldx+BCchY47tZpx3SEKLsamNWujxbyI9akTbo/dVPquTJYrsQbUiDwXU05H
         vk2cP56+YXSmUTRgSlxt9Ay0oyf49vyxHptfR1jLBrkxalFZfkDitjL7Z430vrKHlxAx
         fMpZ+ibiqsbqC0uKB23y/dJqdkNl2/6hE+LM54dZDWD1KLczLrH8p2qjD7KGrvCJMyOB
         VTjlhQ/IbNaGjjyVtnpE7/EAsAtnZq9hFQrnnJwtU2kPnQBmTCNYFInCrikamCmYRyZj
         /qsK3BkEJaAMMPtqgL3WNSLNm7XfNT4KfvbaqTPry0/nbltiXFdZsOF5sZtlyQMnY0hm
         JOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782814; x=1762387614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1hNkDtSx9btv+ppu5ID3Ac1b4Cfy+TXF5aN1lbNAbM=;
        b=a66LlfFiLk8pzj98IQ4X2eJGA9HGOOWe+W7bXOrOLdWm4XN3EFw4VbMtsEFq+cBGCG
         0zawu3QG7JYXqQPkAbyvYdz2fH3GvgO5dqEM/rXwFgwI4tVdcyUk4ix6PsXu7LMg63SO
         mxP/JRQZIi8m7VMkR9TQN94eldtqlvDODdRUQ9uyVo4MNViw+UuWtfNw2WtzcKwbkoMl
         xZ467Pl5nd2WK6k1l4MaXklX98K4WkNsXRZZfLukYqT0kTkn7EdmPpndyHBfSbwHRs6B
         x9iNRNowKmvftlwa1a5bWjXD4YH2A5U1c+eRH/5my2wUxeDQcpEM2okSjvl9YzZBVTes
         Mhjg==
X-Forwarded-Encrypted: i=1; AJvYcCUd8f0lcSEUDHtKgVhgUN3yQMCw3Eh0jO6be/z3dl+B0oJfLGWiRWIpkowNFCkNylPvMiVAemg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwh3kSEm3cAKU9XJJkhTGP/tNMTDfuZvTsI3fbQkeDlUJVakyg
	dLsLpD/JsFb0Vpm1yJX62Zd5MLHAd+zyqUGKJoV38TDLalyQwHGXRrWB
X-Gm-Gg: ASbGncuXiYOuIxNm2n4CWaJmDjBVKoPnCNrkBeWdGGncYhuCKGzmmGgDzWUMCllJ4Uz
	JZPzfnsambUugWhrnR3FkLUhTwLml+ErTpeuknznjTOYQPHEDmEDo2/mOhZ/XufHENIAtXHt/Lf
	9Aza3IB6rt5MxqoHPPuk+d7VwCUzz+jLBU5VDLC4GMgJ1fdwuCZS+PFj4g5PTyuvQqTnmjZWdRb
	TJIlU/6n0PRoDPrwevtV8pE5olYFgIjgTMv4okW8tabUKyToJfRG9xr2kbD3BfMPHiIWYIl2ytz
	vHzfMSNlaj9KRMMrrFLftmniqVWCTqoz5kXUPEpFWQPRbKhcHo/KMt/he/Kva4HldHkomilnvuZ
	3ZWBbIxZDV+PjJ0adP10I7bRf2l3ICF9DU8LfUJE+FX8to6JRVCNtX+8cwmU2VQNf4JaKf/GPMl
	OHxamQs9hAebmpK2DddYk2+SLLxn5r71mO8CPH5Q==
X-Google-Smtp-Source: AGHT+IHKfChxSwIqjz2zTw55zM4v/EfZMYy1z92r/U9l+CG4n+pE324MshyKfd1xIDlI+/dsB4MahQ==
X-Received: by 2002:a17:902:ea0e:b0:265:62b6:c51a with SMTP id d9443c01a7336-294ed2a1377mr12476935ad.23.1761782814185;
        Wed, 29 Oct 2025 17:06:54 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4117esm162900155ad.93.2025.10.29.17.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:06:53 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/2] xsk: minor optimizations around locks
Date: Thu, 30 Oct 2025 08:06:44 +0800
Message-Id: <20251030000646.18859-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Two optimizations regarding xsk_tx_list_lock and cq_lock can yield a
performance increase because of avoiding disabling and enabling
interrupts frequently.

---
V2
Link: https://lore.kernel.org/all/20251025065310.5676-1-kerneljasonxing@gmail.com/
1. abandon applying lockless idea around cached_prod because the case as
Jakub pointed out can cause the pool messy.
2. add a new patch to handle xsk_tx_list_lock.

Jason Xing (2):
  xsk: do not enable/disable irq when grabbing/releasing
    xsk_tx_list_lock
  xsk: use a smaller new lock for shared pool case

 include/net/xsk_buff_pool.h | 13 +++++++++----
 net/xdp/xsk.c               | 15 ++++++---------
 net/xdp/xsk_buff_pool.c     | 15 ++++++---------
 3 files changed, 21 insertions(+), 22 deletions(-)

-- 
2.41.3


