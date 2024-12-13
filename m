Return-Path: <netdev+bounces-151849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DBC9F14CB
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9661C28287F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D979A1E25F6;
	Fri, 13 Dec 2024 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IV92xMl3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C4184523
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113923; cv=none; b=MHBFlM/Hcz4ikBJIWKrRI/W/tuCwbvl5+oawea1YJc3tvZuoUHK67qA7icPxkcVGGAGTjtWMruu68buJQG3whI8NyahtcEB+pzH5yB74h2Pf1IyYfHzrqFe4mIPByUJeuuAS6lQWXBOOhj538Xa2jJxS5l2TNRLlxW3/NEh7+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113923; c=relaxed/simple;
	bh=QoJ9wIT0tNSk422O5280znHoGwGjmCOoIxPRadNja2U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iB5waDHhvIKRY2NjVt+HatKYWRWWbF7/aQfNbW2EEVDRsOqpmWczmmMVVsRd7e1eFl3qT+z8j5+Uw9rPgGCCBBx5ByKhzQkNuObT9gSVafNk40PBKjeck6zhEU5vcL2MHFuCq3mt4lzitP9dhcwHytJCLcE+nPx9SAfCr/wqJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IV92xMl3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725eff44ba5so157531b3a.2
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 10:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1734113921; x=1734718721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QoJ9wIT0tNSk422O5280znHoGwGjmCOoIxPRadNja2U=;
        b=IV92xMl30p6RGUGPAEGCNC0rxriN/rhL6rJVTX60i+BsYigQhqS0MXGcFHBfCeEu9l
         ULzYs53eL3oaGSDhGy0le6Sb19+5uBht1GNG3GNnKOW6aBQyNhFh8EsD8jkIh4Ghoo3H
         fHNEvEX2o3aBmrtahWQznGiulLijqkxRY+QQ+ZA8Z7FJoYxxI5duR7CcDKcvJNYxQVWO
         H5e7fl0VtzqMCJTgru959840/QfOYCdBu8YZgDslUmEi59zpeXgO1CVjmj2ihuDUW7RI
         dO9Q2gjN0PjqkHHzQjpeBoDO9lRvqncyNkdYAYKcv352fVw3O9dgRxwc+R30ADt+XsUa
         WUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113921; x=1734718721;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QoJ9wIT0tNSk422O5280znHoGwGjmCOoIxPRadNja2U=;
        b=c08YNfrtdfsJWPxnWyMIJNNg/PKlyU6mQpjyETgqCPpwWov7HTeSBk8zgSQsH5Su6U
         2mq7yrFO2nSzZwH3cDSncCv4jz2S5+ORZLrUSkoMPdLD3xVoNQ50ZWpT7stvSDLUAV7K
         pLNkLcIXlpV0sxM3jlvnoF7acxhOvoHARkvhCjvGMckc+TTSWHUjDLpxXUpzUPUz9Q3Q
         7/kjLxTiAns5tHMLSUxLNKpyNC/DiE+vZrghB+Q9nXo7SilvjKD9Xcu/rKCWxWobpvYZ
         5LdYj+Rd/6lXgPzOdvcF4QSD7CTUNj6PAOv13bLRFSGcPhY2ghS+CR49e3kXvVNfdVJY
         a1BQ==
X-Gm-Message-State: AOJu0Yz2e3x6K9UPN9DjQnHbes/2X3p4Bnjm9mPOOBaz04F9zi/VIHB8
	LSSIiYMfCjl0tM0nPEQEv8i5cN1vwN7Rf+a/ptegM5NAAiZqhZ9bTR6ZxG8llrK3vXZEiqXgMi8
	n38GPlxx2yDUrccAvkOD3R2ZkMOlsYYq2CN7a0g==
X-Gm-Gg: ASbGncsfsJ9vFGapASCS4eaM67hDtvex9K6MvGBnYkHpsgtXUlJfzQOTvEkAgNvyHVx
	8TNIOIpLM8Z4q65Jbn2Ex8BlCeANtkLz99kgUAA==
X-Google-Smtp-Source: AGHT+IEDENRWkWaHA4dEUSjEVRyRrWfcUmiuJJNTHexoh5D/osvBWi3qb63Ace4xyAH0nPQH+O2iUSMAqU1y5jREJYY=
X-Received: by 2002:a17:90b:4d08:b0:2ee:f64b:9aab with SMTP id
 98e67ed59e1d1-2f2901a8b82mr1988210a91.6.1734113921292; Fri, 13 Dec 2024
 10:18:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Caleb Sander <csander@purestorage.com>
Date: Fri, 13 Dec 2024 10:18:30 -0800
Message-ID: <CADUfDZpUFmBCJPX+u3GYeyFUbQ3RgqevvCpL=ZE48E4_p_BpPA@mail.gmail.com>
Subject: cpu_rmap maps CPUs to wrong interrupts after reprogramming affinities
To: David Miller <davem@davemloft.net>, Tom Herbert <therbert@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Eli Cohen <elic@nvidia.com>, 
	Ben Hutchings <ben@decadent.org.uk>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi netdev,
While testing ARFS, we found set_rps_cpu() was calling
ndo_rx_flow_steer() with an RX queue that was not affinitized to the
desired CPU. The issue occurred only after modifying interrupt
affinities. It looks to be a bug in cpu_rmap, where cpu_rmap_update()
can leave CPUs mapped to interrupts which are no longer the most
closely affinitized to them.

Here is the simplest scenario:
1. A network device has 2 IRQs, 1 and 2. Initially only CPU A is
available to process the network device. So both IRQs 1 and 2 are
affinitized to CPU A.
rx_cpu_rmap maps CPU A to IRQ 2 (assuming the affinity of IRQ 2 was
set after IRQ 1)
2. CPU B becomes available to process the network device. So IRQ 2's
affinity is changed from CPU A to CPU B.
cpu_rmap_update() is called for IRQ 2 with its new affinity (CPU B).
It maps CPU B to IRQ 2. CPU A remains mapped to IRQ 2, though with a
higher distance.
rx_cpu_rmap now maps both CPUs A and B to IRQ 2. Any traffic meant to
be steered to CPU A will end up being processed in IRQ 2 on CPU B
instead, even though there is still an IRQ (1) affinitized to CPU A.

If IRQ 1 had been affinitized to CPU A and IRQ 2 to CPU B initially,
the cpu_rmap would have correctly mapped CPU A to IRQ 1 and CPU B to
IRQ 2. So the state of the cpu_rmap depends on the history of the IRQ
affinities, not just the current IRQ affinities.

This behavior was surprising to me, but perhaps it's working as
intended. It seems to be a limitation of struct cpu_rmap: it stores
only one IRQ with the lowest "distance" for each CPU, even if there
are other IRQs of equivalent or higher distance. When an IRQ's
affinity changes, each CPU currently affinitized to it has its
distance invalidated, but its new closest IRQ is selected based on
other CPUs' closest IRQs, ignoring existing IRQs that may be
affinitized to that CPU.

I can see a few possible ways to address this:
- Store the current affinity masks for all the IRQs in struct cpu_rmap
so the next closest IRQ can be computed when a CPU's closest IRQ is
invalidated. This would significantly increase the size of struct
cpu_rmap.
- Store all candidate IRQs and their distances for each CPU in struct
cpu_rmap so the next closest IRQ can be computed when a CPU's closest
IRQ is invalidated. Again, this would significantly increase the size
of struct cpu_rmap.
- Re-fetch the affinity masks of all the IRQs from the irq layer
whenever one IRQ's affinity changes so the next closest IRQ can be
computed for each invalidated CPU. This would avoid using any
additional memory, but would add a lot of calls into the irq layer.
- Work around the cpu_rmap behavior by having userspace always write
to all IRQs' affinity masks when changing the affinity of any one.
This is probably the simplest solution, but I worry that other
userspace applications would hit the same unexpected behavior.

Let me know whether you see this behavior as a bug in cpu_rmap or
something that userspace should work around. If you do think it's a
cpu_rmap bug, how would you like to fix it?

Thanks,
Caleb

