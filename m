Return-Path: <netdev+bounces-238815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16016C5FDC3
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E668E4E16C3
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F14E1DF273;
	Sat, 15 Nov 2025 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x9f8ZWD0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C48F49
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172581; cv=none; b=TbEoOZ9D2POStD9qqeob/SNW/go7d+MTvVgNNEKE44fDuG1Hw1uiT4CX74Uo67K3OFGyYxjAwou5AaFTMMWgqUtJEIE/Zz0wZnYZhdBDWzKo8GygwQRQPVj9di0f9QBb0Yez4N1pdHB9FwPcsT/VbVW2d++ao+DyKKVjyouGCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172581; c=relaxed/simple;
	bh=TbndgRFIl3gBbPWFT354yj2nwBU7eXF7pNjRkDHPjPk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hDCUZtDFXCRj3BDaIpfioH13ydaZwa6sfnm06q+VrncJcppwcFUYbsuaDD0ieo+UHkF6fQzGXtmicPmHLWS9Cr+7Ec1N//hY5X2DGEdxtd+Djunawr3pUiYBZv5SDl4cvfezJ21F/igruDELaaF6NFkabZKCVeNEs45nyYGie9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x9f8ZWD0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340c07119bfso6729165a91.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763172579; x=1763777379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SB14AuEK06qo7HrTo5zXURHvWbkCXuTMLkTrj+VRjks=;
        b=x9f8ZWD0RBvYYSI5CQkHS4ims4WJoLUOzRAET2fD7a5Rz0XaylHxY+0BgBVDglixem
         8FR1E7MovXlxfaKFWf/WtfFpZflzCykeiKRo9BP0pmXU/nqS2PzndL7/SoNBepuKuxjC
         bAjP2I+InBj80kpYRCQbd00EEdo7U1S4C4DXuGKKM04oDAfnkR2WWCgzXKN/BBuLdqqe
         n8XAkBAuaoFO2RD4nD1s/Mz5Ggo2PhztIHVTqYySN43giPiZuDd2B/Ok0fRJyknWaTXL
         IG1fLb5U8AeLpHIXrNxmba2iEyA4J2DFnwA7bEP2UPR3TE60TYqwotAw+MPSSNMnVk9R
         ptag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172579; x=1763777379;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SB14AuEK06qo7HrTo5zXURHvWbkCXuTMLkTrj+VRjks=;
        b=R9wGaYuUhNPh2LcZMxi7FOqTFCUAc3xlsgueSERvTVrdV+mSXIH0dXqQRW9P+1uv05
         h3tVPRx6Ty+/ZgEbjQHWEFppCF+SsLhesV78gM7/mM97hCP7fuj19nTxzWyaSeYBm4V1
         kQhml/rBvkJcHFJX8EQswAC5sPDE+VgcJGfYfyboswx/zz5/hPzNZLXM3K34P5T3zXSF
         ls2rtcI+0No1jeifaOMlO0WDVxbhA6eBLaX02nxGmowW73NSXcYu3FawpSwoCvPOUPsX
         c1Ss9sdbqXRQtWysK1A/+2fYyXEBXsHW+rwqlAsi38OTL/R4SOHToY8CVFNyhoBDmuFT
         4ilQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7zGjwwsY1MQQDT7emiAlLGSyOfHojFVLBcfFbBknxs7HpkIgwFdhcwJyqTzIii+BoV0UQmGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza0JXI0/A3t7p3ezM+jQLfY2t8u/XMYF3HUZ8P3sIonq1Jzrrv
	TMUCa6Ul9lfgJe/Wk+Kao6aQFJ99yJdUSk1H+UVT9Vyvx0WuDDL+7+YEvLk3D5c30KXas1GvL5G
	r823ybA==
X-Google-Smtp-Source: AGHT+IGiO+qZoEXVp+q9ud+Rw1ogoTiF0dZvQ5uLZeH2ddfPnMtgknWImaaZgW1V+hodje3cuS4+TmNvGpQ=
X-Received: from pjsc10.prod.google.com ([2002:a17:90a:bf0a:b0:340:c015:8e31])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b49:b0:340:f009:ca89
 with SMTP id 98e67ed59e1d1-343fa62fabemr5584851a91.22.1763172579302; Fri, 14
 Nov 2025 18:09:39 -0800 (PST)
Date: Sat, 15 Nov 2025 02:08:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251115020935.2643121-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/7] af_unix: GC cleanup and optimisation.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, AF_UNIX GC is triggered from close() and sendmsg()
based on the number of inflight AF_UNIX sockets.

This is because the old GC implementation had no idea of the
shape of the graph formed by SCM_RIGHTS references.

The new GC knows whether cyclic references (could) exist.

This series refines such conditions not to trigger GC unless
really needed.


Kuniyuki Iwashima (7):
  af_unix: Count cyclic SCC.
  af_unix: Simplify GC state.
  af_unix: Don't trigger GC from close() if unnecessary.
  af_unix: Don't call wait_for_unix_gc() on every sendmsg().
  af_unix: Refine wait_for_unix_gc().
  af_unix: Remove unix_tot_inflight.
  af_unix: Consolidate unix_schedule_gc() and wait_for_unix_gc().

 net/unix/af_unix.c |  7 +---
 net/unix/af_unix.h |  4 +-
 net/unix/garbage.c | 92 ++++++++++++++++++++++++----------------------
 3 files changed, 51 insertions(+), 52 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


