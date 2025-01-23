Return-Path: <netdev+bounces-160677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED6CA1AD1E
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 00:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B6A188A264
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 23:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D551D222B;
	Thu, 23 Jan 2025 23:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VIyVEHuI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38441139CEF
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673959; cv=none; b=ozyXYdbHCG63peOk3XDGEv5ZMcx8ChiAIu+CPHqlJN43qWYxFWjYmmQfj5kM+7XjOKVawdyjMuevOjc4dh/g/eZx2JCFPWBhlffSt+/mwT0I1sLGTK+KT8GLPy45ZN/Z28/7G8TKgxOlX9EOpu6vb9OfzATXi7st24JxNRlUmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673959; c=relaxed/simple;
	bh=JQHRcENH+j6qiC6qeChHNpAzTsg0urhF7CpKb9v+rss=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M0D6nS5cMIAAFDrzQh9NxHfGs5XNPJuF0PqPojOy3a3sWGqAMsimCVSaUjxLgKfvCwe7d/a0C0a/rl+qRMP2N1Ttx7sKKGlWtUiRkLMMxliRNNWuTZwkqCeDTNwk5Z3B0rW62tIPfovCccj/b9xD80r1ATp6Zm0rfnBn0oq+OTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VIyVEHuI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so3053461a91.2
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 15:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737673957; x=1738278757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HF4G1xyVJrDcJpcFoHM4c0Y75qeijYE/HkmrsCL2B8o=;
        b=VIyVEHuIdqOsb64X3TEmRvgAAIewfN9EChTJ5IWuQvYgtRk0mG3fnmEp+HKZ07YSpb
         UBI53FGZdxt7qwiWbZ2ylqTZBKMChTY4nYr/PmLI/J1Hutq1nHDVv6riEdC2arY6tjs1
         oqzcyF+rOSsZsaLaFFhVqYl172EIHdvPDSq4WH4q4ccrIICzf5YdwN9j6dA1qQdig9Ok
         BKBVYgSZme9rvwuSdFWbGbZttmM2HaZytLEBq9IHrxlb3lV9G71+M9c2PHHmxkCek72u
         qtO5Xf9MnFi6wYV2N+t5TA1PjFKr1H8wkuixDzTZqakZxFz3ElmeJjBPHY9Z6lw+x7oF
         Nsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737673957; x=1738278757;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HF4G1xyVJrDcJpcFoHM4c0Y75qeijYE/HkmrsCL2B8o=;
        b=kwt4xT6xEWqcV3u854v9Tg8aPugYMYnfdBbf8dM3hkBQvdEdpIo1xqkJKcUAlwZ3gs
         wlwYjVzauVMLqj3fzySoG9UKWOjZImnHGufhOGWo7J800kH07PjpuyssgFN4+KI0kknX
         xpY3DdkLLydyF6GmS4CrCBuytV99b/Qi3L0Y8/Qcl4DuRAYgzZUc0dxm/51rAVBFc43O
         nMuN1g0jcjWRVNoAlTFChGQjO6almUIi7ar43DtGPlrgY0stKrrGjztvgw1dgiBLQtTL
         XIE5uBngDxP79SqaNGJqhmlYgDZ8UMuRuz8usS1EiA0TH9rAomL2bFgNrjUp6MRqG2MV
         Wsbg==
X-Gm-Message-State: AOJu0YzjS5oCUCwwCRF4ZusaohcAA2pB5ERWcWINzBr0+6CpTSg1xOwN
	AxAN3i1wzJivevajeDINe73ggiFdEA2cxnK1Z1xLiUULsP3vMTc9i7hgtmaUZ4ZDKrEwsVssQEE
	uKDqnz6tAtg==
X-Google-Smtp-Source: AGHT+IFyx+vpmFG7adIVWGvCGFeo+Yj/ZyWwb0ZYs0VF1yzGrWuDgvJ3dNchuJBFa0CFzOM6TleblCrdm8LwQw==
X-Received: from pjbdy8.prod.google.com ([2002:a17:90b:6c8:b0:2ef:9239:aab1])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:56c7:b0:2ee:9b09:7d3d with SMTP id 98e67ed59e1d1-2f782c9a73emr37805987a91.19.1737673957421;
 Thu, 23 Jan 2025 15:12:37 -0800 (PST)
Date: Thu, 23 Jan 2025 23:12:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250123231236.2657321-1-skhawaja@google.com>
Subject: [PATCH net-next v2 0/4] Add support to do threaded napi busy poll
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Extend the already existing support of threaded napi poll to do continuous
busy polling.

This is used for doing continuous polling of napi to fetch descriptors from
backing RX/TX queues for low latency applications. Allow enabling of threaded
busypoll using netlink so this can be enabled on a set of dedicated napis for
low latency applications.

It allows enabling NAPI busy poll for any userspace application
indepdendent of userspace API being used for packet and event processing
(epoll, io_uring, raw socket APIs). Once enabled user can fetch the PID
of the kthread doing NAPI polling and set affinity, priority and
scheduler for it depending on the low-latency requirements.

Currently threaded napi is only enabled at device level using sysfs. Add
support to enable/disable threaded mode for a napi individually. This can be
done using the netlink interface. Extend `napi-set` op in netlink spec that
allows setting the `threaded` attribute of a napi.

Extend the threaded attribute in napi struct to add an option to enable
continuous busy polling. Extend the netlink and sysfs interface to allow
enabled/disabling threaded busypolling at device or individual napi level.

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
 include/linux/netdevice.h                     |  24 +++-
 include/uapi/linux/netdev.h                   |   7 +
 net/core/dev.c                                | 127 ++++++++++++++----
 net/core/net-sysfs.c                          |   2 +-
 net/core/netdev-genl-gen.c                    |   5 +-
 net/core/netdev-genl.c                        |   9 ++
 tools/include/uapi/linux/netdev.h             |   7 +
 tools/testing/selftests/net/busy_poll_test.sh |  25 +++-
 tools/testing/selftests/net/busy_poller.c     |  14 +-
 13 files changed, 282 insertions(+), 37 deletions(-)

-- 
2.48.1.262.g85cc9f2d1e-goog


