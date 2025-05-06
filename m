Return-Path: <netdev+bounces-188388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA405AACA43
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB054A7B13
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE327933C;
	Tue,  6 May 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kks0NFe0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5DA32
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547177; cv=none; b=HvwiGt4mdJ7Xlz5GvsNfiUdDLDsmWTuwqgyOv51HHJqtr9ZxR/uTlSu4wjnNmsjrm09/9D7I3I1JkDCN1IxIkzG1ihrYHBpRGQCyCmFTfuF3oARgcEOIDuXgmzo99Y1MhFjd6dfM04omYt97uLsTG6acNwvJWAakG35tJgSyhxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547177; c=relaxed/simple;
	bh=QBghkQbrBDaW/UFxX/4OmHyAKtHUccE7z4puJ6f9qqc=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=oH4rp5JZvZ82+2hwrEnx7DuuUuOwY3dfH8gH2O4OukRgM/+KmQPbrrtCRLWvusa/4kj/TPF6dAKUkBnrMfpVKim2bWZYsy27qcuAHnM9p2jksVtHLYms0m/mOTJbZjaZRQJoncYfP7jPE97oGsNcoRYWlG01r2ZPt43phkyXvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kks0NFe0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22e4db05fe8so7549685ad.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547175; x=1747151975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=p4gmvHoI/pPR4HQeIelt8jW7uuU+NylUMoVnUiEAViI=;
        b=Kks0NFe0HK2C5aujkboD65A15faKQIFTG79wcd4/07R+x8ftmEFUJvAPGsuk5P0/0A
         9vRFlCkpqkMStyJSUnSK1Qnc1b7RvQLORBY1/OuncN2P52Tb80GAy+BuZvpVcK45Xu5l
         WqsKDFnBCTpgPCIhHW31sO2QW0mhGgdBoCrY4m77xXwovR+x6r2uNV87aHsWIMIBs0t3
         FtRm31KdiXFZmMIEeh1DAyJMtZrtC8z5EuvAn8NDvblep7AKWpVSqxqGmsbhoeLSd3TZ
         9TboehKOQyZfXGlIezgPqBf6BZlLBPy4XvEhV2pnbJlvcQJN2ju7/JTkX2Ohj1OABzle
         8I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547175; x=1747151975;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4gmvHoI/pPR4HQeIelt8jW7uuU+NylUMoVnUiEAViI=;
        b=lqR1NpB4jXLL2kSYyZQEHxQMUZUIq93fGT0vXU0vtWl3JTyLVTAwX3lKwC61a6HFgB
         EyH1E8boSqZS4ymwv+0dgtwuuNIIA1I96uTsAgEK5zQDPMZ4qHqW7oSXFFhAFJkrlm3K
         /qGCl1u1esseEzYsunZnpghI8IN9GFfmgKbbWIq7eGn81kcNoexRkCmOxtZPMStHv1Vk
         FwXxS687Q6WjxjpeCJDpPSFWDzsuNGL65WkJHkxennH0552RDvVpFVpNzIW7mD9LM0lM
         aoMkU1ecg13/PbTe0x8MrmgoiumOqp6ZjIg5/lj+pNPTeF3otk108ZlmPGnzkQ4w+Qiw
         HW1w==
X-Gm-Message-State: AOJu0YyHWvwpQ9t/5IKZB+RD7cRX9sfs9AJ8CgX2oZisNneSUmglfxdn
	Kupi6gSwb60UQIyD8L9zHG/ltgLoCYcV/PAjO3G+P4pTC928qNsa
X-Gm-Gg: ASbGncsXqpqiK08n4WqVKs3PQ731JCYrMTUucKsfupADJby9IrhbrLpzHekE5a2YSEk
	z0sVm4eGBLapUNv4lNLBqI+lfjtSQIs9C3HG2ZWeUqHSXOJTDw8YmSoln50Wt1PW98Ta3GwWFWl
	YSiNyYAHTqraMjiaADSGdQsQnIuPFSQ8m8sI9oJFEgaw15m14xpe8OmQ7NHCgeN6vYJfvelJ5eS
	Hga77H9lyIBc46JZrFCqFGD+0pxZvIr4+uGPuZYmuSckbkb7qDLHX6lmOQjho2JCxSpyIjFTMJR
	Qjd9b8gMH2YUsXv5TSd1QGma3/9aWZeteoMoMzZa5XG0GYuhV/CsHFmkIeHzSXc94TAUfqIhCrY
	=
X-Google-Smtp-Source: AGHT+IEZPVWd+PhPZOYROvOJuX/051h4780/jq1wUc8LzvvAXOJyQRXhgQpeCyOVqxbkCwMVpBjhjQ==
X-Received: by 2002:a17:902:c408:b0:223:54e5:bf4b with SMTP id d9443c01a7336-22e1ea7f87emr173852425ad.25.1746547174553;
        Tue, 06 May 2025 08:59:34 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e152290fasm75655485ad.195.2025.05.06.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:59:34 -0700 (PDT)
Subject: [net PATCH v2 0/8] fbnic: FW IPC Mailbox fixes
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 06 May 2025 08:59:33 -0700
Message-ID: 
 <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
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

v2:
Added Reviewed-by for patches 1-4
Updated patch 5 to focus on the single completion case
Updated patch 6 to split it into patches 6-8
	Split out responsiveness fixes to patch 6
	Moved fbnic_fw_xmit_cap_msg out of interrupt/polling context in patch 7
	Moved init to ready out of interrupt/polling context in patch 8
	Dropped change that was focused on verifying capabilities version

---

Alexander Duyck (8):
      fbnic: Fix initialization of mailbox descriptor rings
      fbnic: Gate AXI read/write enabling on FW mailbox
      fbnic: Add additional handling of IRQs
      fbnic: Actually flush_tx instead of stalling out
      fbnic: Cleanup handling of completions
      fbnic: Improve responsiveness of fbnic_mbx_poll_tx_ready
      fbnic: Pull fbnic_fw_xmit_cap_msg use out of interrupt context
      fbnic: Do not allow mailbox to toggle to ready outside fbnic_mbx_poll_tx_ready


 drivers/net/ethernet/meta/fbnic/fbnic.h       |   8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   2 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 197 +++++++++++-------
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   | 142 +++++++++----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |   6 -
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   5 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  14 +-
 7 files changed, 231 insertions(+), 143 deletions(-)

--


