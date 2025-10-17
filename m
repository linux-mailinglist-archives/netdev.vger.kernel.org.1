Return-Path: <netdev+bounces-230521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E08EBE9BAA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653CF1890DF0
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A322F12D4;
	Fri, 17 Oct 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQihjODK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C42F12BE
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714336; cv=none; b=DcYPUA+dAKxTT8PM4meRcQGDw5M1XoJ46zRAQNRi7YWqZhFp5VZfDPWHyeWpjqj5tmTgW61ZoBAVv60O12PB5KH8bA3IaHJuI3TnquQUaM7AUB1lTnc6AejpDzgvTv6X1NR+dfTdYFONddWgS7ubKeAmFAE5S+GLF8iFZh98OxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714336; c=relaxed/simple;
	bh=CZLi+sXLLQWJ1szeixL4fKYphUAlCf2Ajj9YbKRav30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u4/iK8LcyS91C5EH8SO4d2q9tQff6Q7eaybTLCLKn4OrPcQ5giVK3XLKfFwJOIKqmrmFd98IRAi0jVTr7dZ5fceH5dAgV6c1buwwMjQcaVYzTUe3x3ph8dMb48MdtPxqR1a7QyMAMelnUN359ey3MC0nZvOgigWiJv1tM0oDD9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQihjODK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d3540a43fso21998675ad.3
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760714333; x=1761319133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aky7O16wp7MCKRn7P+HfqmW9xe7HTb5Qd8ARsCmuj+Y=;
        b=IQihjODKFDhO4uKpBjb8YYadD7C3UXztk0gWiXd9tErycbns//00PuTNCpryz6fcRi
         xpszTuHsU56UZy76t5fqLOr+scnOQUvN3EjM/bX6dotEkKrNpXOqb3R6jnqHHNBxn6cr
         tKVW1p80jRdppKubYJFwXUWxt5ENHdn60h0HXlWfZZzKe1XjAPd80yUUr3FXyWF5fEeg
         Rq+qIcj0skdnc4Aj/8CS1wwkTi8fxOCZ1HVqr8EvbWpvxnsG+JTqxiLpLNKWJTL1AkPo
         MoKpgt7E1nrFBy8wgvc/xV2eMdBPTPdkfIv9N8VAMhIHFID8yiYVEumfaqVVGAM71ltS
         TDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714333; x=1761319133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aky7O16wp7MCKRn7P+HfqmW9xe7HTb5Qd8ARsCmuj+Y=;
        b=Khs2iIzVdeLh7Yof/CuzRLIctTmXvETvXIvzPgwL9QQ7tEJRTDO/DBlxS7ncJRBqwk
         duA4Tt+lO9fcuaZ8+tjW6Y7+KGovMMO9iRSgk8mNNrygbDJfYD+UeHYrfx4BGdUsaN09
         BTFKmQvk+s0e6GXgb9V3hAlvpyvjY8g/Z70hWheyphEYDxFItTrui9lr41LbDw/igf+j
         wBU73fiif+sbCVgfE3H/TWz7Ai27DwtvG5VvXcCjczCPB8UfdhlHeoIJe2GR9zSfRYab
         1RDEvZdCK9eqCxtDzBjwd2/peBvNShhfeIGEa7mRz2aSRcjH2gcPFWaFOcdHpWPyR3Cp
         8LQQ==
X-Gm-Message-State: AOJu0Yyki8c/tX1ZO0ksKnhbFqWR7Hr33MkbqsWBp1NiyeB7DGBqy6/p
	FWoYaeHl6RU2EKE4DDEuCkfbtH0UmX+Z/mm7bgakL8o4z7JkWEdVFf4M
X-Gm-Gg: ASbGncvQpeISwRXXJ3diw2Br+JS2gFtlAUHWbDeOdHoNKaPlQDGnbYExVsoWUXU16If
	lwN2gOmEWpTONKxX01AFGfhQ4UZhbvqKclAaov8IufDaGVtbUttlwmsodff7jeRKr3Q6jIMHlQh
	fOoJtN86G2A047ofyGBliVHKxJSaIyDrhif6BT4eBswnK1+2QPuXvfLcVOK4VqusB71goa/eo3f
	HMd+sACIF3xuP7A/L9+w4bG19NaQhlbiXH0xJd9GGwwDd32XjIAs7jVUM0Rz0FtuDQcz1Dkc8cP
	mmpWPT8LqTSiVZ4gGgkcrjrKUvxt/Bf8ccyO7smWTUbPmYQk8nSPkNz/9UMIfieY1Wjsf1BCu7O
	WFxrqsOhxiy5EVcSMsELZw6wUnaFq7zMQO3tX+0wTJmpl2mstGqmJY1gIn5+kILq+BEsDBiBkwY
	ofJ4v8SCmNu/ZEx7hjPanDR3/plMmjF64ZJA3lxjyQLbM=
X-Google-Smtp-Source: AGHT+IErUrkf0E6Co1oQ9IYvwro69w/l75nuO5GilwN7XkDgpAP+XCdmvjp8T0T5H471WqUuqlgsOg==
X-Received: by 2002:a17:903:32c9:b0:249:3efa:3c99 with SMTP id d9443c01a7336-290cba4e6cdmr51489385ad.61.1760714332790;
        Fri, 17 Oct 2025 08:18:52 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:fdc9:5e8f:28db:7f80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a756sm67193955ad.14.2025.10.17.08.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:18:52 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/4] net: ravb: Fix SoC-specific configuration and descriptor handling issues
Date: Fri, 17 Oct 2025 16:18:26 +0100
Message-ID: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This series addresses several issues in the Renesas Ethernet AVB (ravb)
driver related to SoC-specific resource configuration and descriptor
ordering.

Different Renesas SoCs implement varying numbers of descriptor entries and
queue capabilities, which were previously hardcoded or misconfigured.
Additionally, a potential ordering hazard in descriptor setup could cause
the DMA engine to start prematurely, leading to TX stalls on some
platforms.

The series includes the following changes:

Make DBAT entry count configurable per SoC
The number of descriptor base address table (DBAT) entries is not uniform
across all SoCs. Pass this information via the hardware info structure and
allocate resources accordingly.

Allocate correct number of queues based on SoC support
Use the per-SoC configuration to determine whether a network control queue
is available, and allocate queues dynamically to match the SoC's
capability.

Enforce descriptor type ordering to prevent early DMA start
Ensure proper write ordering of TX descriptor type fields to prevent the
DMA engine from observing an incomplete descriptor chain. This fixes
observed TX stalls on RZ/G2L platforms running RT kernels.

All four patches include Fixes tags and should be considered for stable
backporting.

Tested on R/G1x Gen2, RZ/G2x Gen3 and RZ/G2L family hardware.

Note, I've not added net-next in the subject as these are bug fixes for
existing functionality.

v1->v2:
- Split up patch 3/3 from v1 into two separate patches for clarity
  of using dma_wmb() for enforcing ordering.
- Updated commit message for patch 3/4
- Added Reviewed-by tag from Niklas for patches 1 and 2.
Cheers,
Prabhakar

Lad Prabhakar (4):
  net: ravb: Make DBAT entry count configurable per-SoC
  net: ravb: Allocate correct number of queues based on SoC support
  net: ravb: Enforce descriptor type ordering
  net: ravb: Ensure memory write completes before ringing TX doorbell

 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 40 +++++++++++++++++++-----
 2 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.43.0


