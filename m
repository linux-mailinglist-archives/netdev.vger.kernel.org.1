Return-Path: <netdev+bounces-187335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF0CAA676C
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AF31B6327E
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 23:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65945263C73;
	Thu,  1 May 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul8quSHT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC091E487
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142194; cv=none; b=AC9KqKQZnBq/I4ku4b/XtQHMENUDvB4eGFiJLOZ7D+VhtNzeAFI2656tqXfU7fd6zEu3fGjt4z8GftDDiGSVQYn0ixXnVFk8Zj3uMiwNZ/Af5CCzToAtHliqD2XqKVNOf/7vDkzDAISuMekDC21XBNkScqVfAVRsrr1jesL47Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142194; c=relaxed/simple;
	bh=bHZ6elJ1BrF85tPXT8sQ0P9YdT1E8P0CxsccdVgap/Y=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=KezS3zfpP98n4cvFWRqzuCWGgyXcOsEESUtQFrtFCODE8fYZsaTvGiNwjDU5ahbnIAKKaDjbStdIhkJfdTDw+oqZu6gefVPXzm289VCAb7svwHooawNwJpV1lbVppH3RWimaIReAhiTMDrRqdL4BNwqHrfZ22WH1YVn2IbFhE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ul8quSHT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22928d629faso14772565ad.3
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746142192; x=1746746992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=tnGLCmkJ4nKnreKBjZc/AclN56nzhFqDS2jfFycu+7g=;
        b=Ul8quSHTXCOEqlqRU3GvXfCu7fqf7nLrdW5thKYe3Hqwek7vZZAahtOVvnHrsPBRc2
         myv1Tt+I28ypdiD05bAQOVmkU5I74PGoMuEj7NLDoAOBTd0N4puyQFQRk/7F66W+j54F
         uJULt37JDTF8nRTEBv529D8XSiU2U8BQNqyBiPA7XbB6xVnwrNDnSLs+4OZlnljs3I2V
         Z/Ikgv1uT0ID0Df+U0aZIVON6SC2nJQut4HQloAHd6xePc0PBwwU+W83AO2nJxdDm+4C
         WOQbaEE7F5sq6ZrFnbNMuGn7jxMehmmOC3/QiyXDW1wQVXa4mnen8pUX9tca7XAWa4Z8
         YR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746142192; x=1746746992;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnGLCmkJ4nKnreKBjZc/AclN56nzhFqDS2jfFycu+7g=;
        b=K7aQsMrWl/z1h9fzTTmo4BxofghBJa50xNDpn1xXAUlM9mN1zAaK9KEfHpxkvWczkS
         vT+uOlCSNU35b6S3qRHMJYyNutry1eqUAv9+OVgJsQGrg5j56an4gPqYPh2UHnk/JTZ0
         ErmZzW0Z0xeKYUckFHC1177Ktvm11nm8a60ruaNxEb0wkzngEL5dWDVchA7tv9SMuqsM
         DFKJ+wLyOdl24Y2aJdeE0U1/7+OOSTLhBQDubGCCvT2CnC82VgFmorCoMS2Je1jIUjIU
         xY6dY3uvzhOssc19aKis1RCcm0a/2gctKJB8PNcw4jg2dfY5OY4wcVMMXUzb83GBh9bX
         sfVg==
X-Gm-Message-State: AOJu0Ywp0h3EOSO4MNXL0jeT1RbYiwS+UhelhxYnuP5CtGM9GoeFBZST
	G6PqEwz91TiXSAHRtkX0oXcW7qc9He1pWo0i5Umh1zIVS+aSAZfc1CW/jg==
X-Gm-Gg: ASbGncvSNWpVtW5UKUbsgg8wThDmwu237rr2iqkybofJIc0Q+jWynI0uSgc5iwUkk/K
	SEoD0ojsjPNw1HSfaRzCfQKe5boCALxhKSMztAsQirbsY25GApgLkikbU2Tj+QD+UrbNQKuf8T0
	rBE8nCbAEhfUTHIKS4jskGQWue+c25aIiJFJwaWyzxHTs6S+O6fgL/tW3lP52oLwL+xvrHSfrTL
	XNkDdIOhX7XkNCLgmjn9hIFsi0HCrzTS1FNQwZOcv0JWGaA9dwVgFfNE+h5x90WbPYQ369gECjX
	362p5TAhlYklBxyXvFw/fGsxasRmlldDwBSD8rf9yEHQXPqHoE4yPlRhXbjaBwLPeNYC6yAl/bw
	=
X-Google-Smtp-Source: AGHT+IE9PueghS1sqyENeTQvXgL6hIYbMEqdWhxkjWtzGTo4cvVa44A1KA/Wrw3D6fcG/tnrc/HGGA==
X-Received: by 2002:a17:90b:582e:b0:309:ffa5:d526 with SMTP id 98e67ed59e1d1-30a4e5cdcbbmr1669358a91.16.1746142192014;
        Thu, 01 May 2025 16:29:52 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34721015sm4264673a91.6.2025.05.01.16.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 16:29:51 -0700 (PDT)
Subject: [net PATCH 0/6] fbnic: FW IPC Mailbox fixes
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 01 May 2025 16:29:50 -0700
Message-ID: 
 <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series is meant to address a number of issues that have been found in
the FW IPC mailbox over the past several months.

The main issues addressed are:
1. Resolve a potential race between host and FW during initialization that
can cause the FW to only have the lower 32b of an address.
2. Block the FW from issuing DMA requests after we have closed the mailbox
and before we have started issuing requests on it.
3. Fix races in the IRQ handlers that can cause the IRQ to unmask itself if
it is being processed while we are trying to disable it.
4. Cleanup the Tx flush logic so that we actually lock down the Tx path
before we start flushing it instead of letting it free run while we are
shutting it down.
5. Fix several memory leaks that could occur if we failed initialization.
6. Cleanup the mailbox completion if we are flushing Tx since we are no
longer processing Rx.
7. Move several allocations out of a potential IRQ/atomic context.

There have been a few optimizations we also picked up since then. Rather
than split them out I just folded them into these diffs. They mostly
address minor issues such as how long it takes to initialize and/or fail so
I thought they could probably go in with the rest of the patches. They
consist of:
1. Do not sleep more than 20ms waiting on FW to respond as the 200ms value
likely originated from simulation/emulation testing.
2. Use jiffies to determine timeout instead of sleep * attempts for better
accuracy.

---

Alexander Duyck (6):
      fbnic: Fix initialization of mailbox descriptor rings
      fbnic: Gate AXI read/write enabling on FW mailbox
      fbnic: Add additional handling of IRQs
      fbnic: Actually flush_tx instead of stalling out
      fbnic: Cleanup handling of completions
      fbnic: Pull fbnic_fw_xmit_cap_msg use out of interrupt context


 drivers/net/ethernet/meta/fbnic/fbnic.h       |   8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   2 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 217 +++++++++++-------
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   | 142 ++++++++----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |   8 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   5 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  14 +-
 8 files changed, 254 insertions(+), 144 deletions(-)

--


