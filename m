Return-Path: <netdev+bounces-162808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D5A27FFC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 01:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A700D188785E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384717E;
	Wed,  5 Feb 2025 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AOdE4gUH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB7163
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714256; cv=none; b=cfdgaQqrlR7v6543QOHepVbPFzjNiCf0C75z5axLqNqSRKZbDs0ptRzOYoUSy79g+CbKmqsMLzldTXon7+B1mZrPf20qpzjMq5miWITfPcxKSx0qgAoYKlOTzoSPMU4cdUNY67pPQXUFJ2WwyeN/9e1+0itJU1lJ4GdnPH0x+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714256; c=relaxed/simple;
	bh=P67J+o0dUvFrAftXGM3eI2FIBpyFumR+6r0E8tVhVv8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qRQ/cEp0kGXy7Q6I8dw0eSIDUc036kOyUS9u1FMe4CdVcfmWXwbr0fYBQ12M9EXgvMc13KsQ+PpyNFWAEaMHWBeqfmulYMi/HBOMtGpRolWBJvqbzliIHWDOVRny8REH744QYYGDGoyneboyfri7RR/FDogLyMk50KzDEVeqfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AOdE4gUH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f550d28f7dso11417266a91.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 16:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738714254; x=1739319054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=99owKJMXXPohLPpPqkbFc5/lnyoU+wH/eLDU3gYl2Bk=;
        b=AOdE4gUHzGVG5gnh16+DExNEj88LaE+bRGvPgMdBXtp7c9KEpGuUxYffIO78JeRg1z
         QW3s23A4mYZbCrtEAAMwvXfrTQ/apGDe+8+rq6P4kNyaPDJ8CxPpZm54zPj63Cp3I4u+
         yQPn5nmZjtlfwiGca+OfuR45mYRrKHnp70HaI2t7V8AOiJr0Qp40CKaMntUyQBNT6Xc5
         MszOLxtkae7nkpc1efDwsXv5gGfr0VO8jIqpbLVgalucPJEXEPzeKr6Ff7UIp0oWAwuZ
         s8fdfDwpFapDtwxM/BhzBPe7SNFXa/fCOYnostE8RPZoUOed+zneI84UGOwXN3gn7cS3
         Pqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714254; x=1739319054;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99owKJMXXPohLPpPqkbFc5/lnyoU+wH/eLDU3gYl2Bk=;
        b=mSryHiGDeuLq4TIxmt1ZZ2+hHAEqbbvEo1lGYtyM9HUEOoDPuqSNZ9sMCIbE3EDPfc
         xhJiiI5WB8udvonl12Indp7j9qosB0aTWKoC0ceyCXFpr8TC9DVulQNaR/XE4Zi2plEJ
         3/Z/b8M1O2RhxLECAIoAxbjQAbVuZ/MmOG4HDuBUMvMpbmAGip19496GyDhDtbECoyxb
         Dr77AawgHaB2TRdWdnAmhlnsJF7dQKnAg3PYoAkMdhvmSSS4DjrPuRBAB4v3QxGwfm9D
         uGHgK81JCfqdZk1EcK1X+FJ+LzKv+bioQtHegUWohNUEl9D8OPkqGqfLI3XisxdDE07/
         hhRg==
X-Gm-Message-State: AOJu0YxW+eY2HlSP6CZNJEqGrvDRNPFNJ8+oqvsB/uAoHlTKyz1mtiwI
	PFEyE1fdOaLrQsHOB5sDRDNWRxmrGBrR9QpMdCFNO3hHpXP9KAMd2YAvpY7ltabvKNCy9EtYfO0
	afwPkyg1Z3A==
X-Google-Smtp-Source: AGHT+IGiDJVMyBVqnNaC8Rtmuo8GXRBP3fCEHNRgFYVYRaZ4Ffi4ig4R8oPwCKdKbsY7j78BRCSxeDDqka8eoA==
X-Received: from pjbee7.prod.google.com ([2002:a17:90a:fc47:b0:2ea:9d23:79a0])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d04:b0:2f7:7680:51a6 with SMTP id 98e67ed59e1d1-2f9e0753d2emr1071380a91.6.1738714254331;
 Tue, 04 Feb 2025 16:10:54 -0800 (PST)
Date: Wed,  5 Feb 2025 00:10:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205001052.2590140-1-skhawaja@google.com>
Subject: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Extend the already existing support of threaded napi poll to do continuous
busy polling.

This is used for doing continuous polling of napi to fetch descriptors
from backing RX/TX queues for low latency applications. Allow enabling
of threaded busypoll using netlink so this can be enabled on a set of
dedicated napis for low latency applications.

It allows enabling NAPI busy poll for any userspace application
indepdendent of userspace API being used for packet and event processing
(epoll, io_uring, raw socket APIs). Once enabled user can fetch the PID
of the kthread doing NAPI polling and set affinity, priority and
scheduler for it depending on the low-latency requirements.

Currently threaded napi is only enabled at device level using sysfs. Add
support to enable/disable threaded mode for a napi individually. This
can be done using the netlink interface. Extend `napi-set` op in netlink
spec that allows setting the `threaded` attribute of a napi.

Extend the threaded attribute in napi struct to add an option to enable
continuous busy polling. Extend the netlink and sysfs interface to allow
enabled/disabling threaded busypolling at device or individual napi
level.

We use this for our AF_XDP based hard low-latency usecase using onload
stack (https://github.com/Xilinx-CNS/onload) that runs in userspace. Our
usecase is a fixed frequency RPC style traffic with fixed
request/response size. We simulated this using neper by only starting
next transaction when last one has completed. The experiment results are
listed below,

Setup:

- Running on Google C3 VMs with idpf driver with following configurations.
- IRQ affinity and coalascing is common for both experiments.
- There is only 1 RX/TX queue configured.
- First experiment enables busy poll using sysctl for both epoll and
  socket APIs.
- Second experiment enables NAPI threaded busy poll for the full device
  using sysctl.

Non threaded NAPI busy poll enabled using sysctl.
```
echo 400 | sudo tee /proc/sys/net/core/busy_poll
echo 400 | sudo tee /proc/sys/net/core/busy_read
echo 2 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
echo 15000  | sudo tee /sys/class/net/eth0/gro_flush_timeout
```

Results using following command,
```
sudo EF_NO_FAIL=0 EF_POLL_USEC=100000 taskset -c 3-10 onload -v \
		--profile=latency ./neper/tcp_rr -Q 200 -R 400 -T 1 -F 50 \
		-p 50,90,99,999 -H <IP> -l 10

...
...

num_transactions=2835
latency_min=0.000018976
latency_max=0.049642100
latency_mean=0.003243618
latency_stddev=0.010636847
latency_p50=0.000025270
latency_p90=0.005406710
latency_p99=0.049807350
latency_p99.9=0.049807350
```

Results with napi threaded busy poll using following command,
```
sudo EF_NO_FAIL=0 EF_POLL_USEC=100000 taskset -c 3-10 onload -v \
                --profile=latency ./neper/tcp_rr -Q 200 -R 400 -T 1 -F 50 \
                -p 50,90,99,999 -H <IP> -l 10

...
...

num_transactions=460163
latency_min=0.000015707
latency_max=0.200182942
latency_mean=0.000019453
latency_stddev=0.000720727
latency_p50=0.000016950
latency_p90=0.000017270
latency_p99=0.000018710
latency_p99.9=0.000020150
```

Here with NAPI threaded busy poll in a separate core, we are able to
consistently poll the NAPI to keep latency to absolute minimum. And also
we are able to do this without any major changes to the onload stack and
threading model.

v3:
 - Fixed calls to dev_set_threaded in drivers

v2:
 - Add documentation in napi.rst.
 - Provide experiment data and usecase details.
 - Update busy_poller selftest to include napi threaded poll testcase.
 - Define threaded mode enum in netlink interface.
 - Included NAPI threaded state in napi config to save/restore.

Samiullah Khawaja (4):
  Add support to set napi threaded for individual napi
  net: Create separate gro_flush helper function
  Extend napi threaded polling to allow kthread based busy polling
  selftests: Add napi threaded busy poll test in `busy_poller`

 Documentation/ABI/testing/sysfs-class-net     |   3 +-
 Documentation/netlink/specs/netdev.yaml       |  14 ++
 Documentation/networking/napi.rst             |  80 ++++++++++-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |   2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |   2 +-
 include/linux/netdevice.h                     |  24 +++-
 include/uapi/linux/netdev.h                   |   7 +
 net/core/dev.c                                | 127 ++++++++++++++----
 net/core/net-sysfs.c                          |   2 +-
 net/core/netdev-genl-gen.c                    |   5 +-
 net/core/netdev-genl.c                        |   9 ++
 tools/include/uapi/linux/netdev.h             |   7 +
 tools/testing/selftests/net/busy_poll_test.sh |  25 +++-
 tools/testing/selftests/net/busy_poller.c     |  14 +-
 16 files changed, 285 insertions(+), 40 deletions(-)

-- 
2.48.1.362.g079036d154-goog


