Return-Path: <netdev+bounces-162814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 859EAA28009
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 01:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA2F3A0677
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72969163;
	Wed,  5 Feb 2025 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i91vReRL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A710E3
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714496; cv=none; b=UlYk16Z1YmUyKNIN4bJDlHX4NzqYU+r8Gp0EyjeBU7BjbVcEgQUNhjRpX/Ho2vgwfuoITgYpJUn+1xX09Fvgu99J8TMaN9GxbkUcf1ESPogZx9KC2R6Ygg3/ThtRfn49MNAKb5AjpLrQJx5+5byzjYdG9D0FWhtlHDDOWeyRTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714496; c=relaxed/simple;
	bh=5ohN7qNU0Gz54tyhjly9LZTyiMzstKdMUjuh7YfKIas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSjWH/6xOuz9SYZ+IQpUdh/MWgwSNMvjhYE/FXzYGPDq/3SZlT3AiA9yUp2NWgJucUAftxg4VrpQKFl+ksW9YTqVqgRWFXNOZMx833rnsH7gwYim+7TkZlx/4vNgRHUln2IQofeYsmo8kI8ntpp2OxvvNlPgUmDcJG5FHLXk9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i91vReRL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso91835e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738714493; x=1739319293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjBUSgWbZKwpdnR8hSWMUwkZ0R7eozBzf220bdTjfvU=;
        b=i91vReRLzTDzDXmeCONYk5eNS/PiYmJZ5+qfoF0DNiIPWoALMvgUuxY1q7wc/qIR5t
         52sVf/cNX2EHMUsVtHF7zM2hSXDZvHXR86fftfOfDJq/LMivo8olKxjRBiV5qLqh6+kO
         0asvnr3NyyYcMg17Lxz2AwrFbsqv4S0kzduppkjnisHoG1AlUzK6bTtLr7aneBWQNIwu
         c6tmUSCg32w6rzlBzwbZZOP11l+xp5WlVWuxnavhIefuPehTvKmYHYImHeighlrCbZhl
         Q2hej2BXGOAYYswRRMLHWhXhN56qKamCik9li9wEosw28eUTPkzGOW3zUj8p7xzGSqPF
         MegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714493; x=1739319293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjBUSgWbZKwpdnR8hSWMUwkZ0R7eozBzf220bdTjfvU=;
        b=bLuOT9V2vxjbIrn6US1/hMgaMF/g75UNGTJpiMGZ4VMZr405xy0CzbEvg14S4vqvtx
         ++xZY4jYfVBggiW2Ey4FyqGAVvvlviP/es7EHXnwARfAHNN2X6OcMhvfqICJ6Sv4W+g3
         Mx/A7ZW1G2j97UUZ85jrGgazeF9Y/df+cg+IxXN+YVfm2W2fmUIwPvlJF6yZY8Gjy5l5
         qLItror5jBmJNPssSgaQAyZMfqBOpvAmo7NNl2b5Umjm0+1xbK0iQR9vexC4vwcl8kjN
         q8nW/GrmJijm/iP8whEU8n3ssJQQCc/3/k5S5KEAQ43vaVy9gwhlPSB+7H4gcz2AATf9
         GxTw==
X-Gm-Message-State: AOJu0YzzNClocwhn8OF6GKonqTq7N4JmBg1zw0P5VhKBcnFhoOu/Sp1Z
	fY2wVB/WwG5XlhZ32FkhEGREG0URUA4IYxDVZ5bAf8xT7rXuCNoz37KL3vTqAuXaiEMdRShMctE
	cNaVPPhUlehvBnYtS7yBdubDDWot2OMDG9mSTmUUy2+soxzfBTQ==
X-Gm-Gg: ASbGncvkDaMfDx9IyE4dSkiyZciuM+dVrE/VuIpNxMldljl89ug5V0bKN2cnwm8wbXA
	2W7MQNaOagw6DaYUzBq6dI5eWEdYZsLvH4nV1ZCTTxU2ghb/hsOHBLkOUpB3zeMYUCmvcbYh9B7
	Ah+Y/9dr1lF1wi+P91IPNjPInQV38=
X-Google-Smtp-Source: AGHT+IGn3rsUVeWQ8UTsDyXx2is0rVT/fpIp1FoiEMoPWxqVcmkgkoipXdpMZTue7tac5GEnlB75KAmL0qizhYv7Owc=
X-Received: by 2002:a05:600c:1f86:b0:434:c967:e4b5 with SMTP id
 5b1f17b1804b1-43907572b24mr1692205e9.1.1738714492458; Tue, 04 Feb 2025
 16:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com>
In-Reply-To: <20250205001052.2590140-1-skhawaja@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 4 Feb 2025 16:14:41 -0800
X-Gm-Features: AWEUYZkBlvMg_S5dz14Y6JNwRw1lFrit4S3xG50BJ5yjf0VFRUNmy3FYs8JXLMQ
Message-ID: <CAAywjhT6p9hGNC+VurGvi=jHq+7saKeEMpdxVuQvpFAUosx4=A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com
Cc: netdev@vger.kernel.org, Joe Damato <jdamato@fastly.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 4:10=E2=80=AFPM Samiullah Khawaja <skhawaja@google.c=
om> wrote:
>
> Extend the already existing support of threaded napi poll to do continuou=
s
> busy polling.
>
> This is used for doing continuous polling of napi to fetch descriptors
> from backing RX/TX queues for low latency applications. Allow enabling
> of threaded busypoll using netlink so this can be enabled on a set of
> dedicated napis for low latency applications.
>
> It allows enabling NAPI busy poll for any userspace application
> indepdendent of userspace API being used for packet and event processing
> (epoll, io_uring, raw socket APIs). Once enabled user can fetch the PID
> of the kthread doing NAPI polling and set affinity, priority and
> scheduler for it depending on the low-latency requirements.
>
> Currently threaded napi is only enabled at device level using sysfs. Add
> support to enable/disable threaded mode for a napi individually. This
> can be done using the netlink interface. Extend `napi-set` op in netlink
> spec that allows setting the `threaded` attribute of a napi.
>
> Extend the threaded attribute in napi struct to add an option to enable
> continuous busy polling. Extend the netlink and sysfs interface to allow
> enabled/disabling threaded busypolling at device or individual napi
> level.
>
> We use this for our AF_XDP based hard low-latency usecase using onload
> stack (https://github.com/Xilinx-CNS/onload) that runs in userspace. Our
> usecase is a fixed frequency RPC style traffic with fixed
> request/response size. We simulated this using neper by only starting
> next transaction when last one has completed. The experiment results are
> listed below,
>
> Setup:
>
> - Running on Google C3 VMs with idpf driver with following configurations=
.
> - IRQ affinity and coalascing is common for both experiments.
> - There is only 1 RX/TX queue configured.
> - First experiment enables busy poll using sysctl for both epoll and
>   socket APIs.
> - Second experiment enables NAPI threaded busy poll for the full device
>   using sysctl.
>
> Non threaded NAPI busy poll enabled using sysctl.
> ```
> echo 400 | sudo tee /proc/sys/net/core/busy_poll
> echo 400 | sudo tee /proc/sys/net/core/busy_read
> echo 2 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> echo 15000  | sudo tee /sys/class/net/eth0/gro_flush_timeout
> ```
>
> Results using following command,
> ```
> sudo EF_NO_FAIL=3D0 EF_POLL_USEC=3D100000 taskset -c 3-10 onload -v \
>                 --profile=3Dlatency ./neper/tcp_rr -Q 200 -R 400 -T 1 -F =
50 \
>                 -p 50,90,99,999 -H <IP> -l 10
>
> ...
> ...
>
> num_transactions=3D2835
> latency_min=3D0.000018976
> latency_max=3D0.049642100
> latency_mean=3D0.003243618
> latency_stddev=3D0.010636847
> latency_p50=3D0.000025270
> latency_p90=3D0.005406710
> latency_p99=3D0.049807350
> latency_p99.9=3D0.049807350
> ```
>
> Results with napi threaded busy poll using following command,
> ```
> sudo EF_NO_FAIL=3D0 EF_POLL_USEC=3D100000 taskset -c 3-10 onload -v \
>                 --profile=3Dlatency ./neper/tcp_rr -Q 200 -R 400 -T 1 -F =
50 \
>                 -p 50,90,99,999 -H <IP> -l 10
>
> ...
> ...
>
> num_transactions=3D460163
> latency_min=3D0.000015707
> latency_max=3D0.200182942
> latency_mean=3D0.000019453
> latency_stddev=3D0.000720727
> latency_p50=3D0.000016950
> latency_p90=3D0.000017270
> latency_p99=3D0.000018710
> latency_p99.9=3D0.000020150
> ```
>
> Here with NAPI threaded busy poll in a separate core, we are able to
> consistently poll the NAPI to keep latency to absolute minimum. And also
> we are able to do this without any major changes to the onload stack and
> threading model.
>
> v3:
>  - Fixed calls to dev_set_threaded in drivers
>
> v2:
>  - Add documentation in napi.rst.
>  - Provide experiment data and usecase details.
>  - Update busy_poller selftest to include napi threaded poll testcase.
>  - Define threaded mode enum in netlink interface.
>  - Included NAPI threaded state in napi config to save/restore.
>
> Samiullah Khawaja (4):
>   Add support to set napi threaded for individual napi
>   net: Create separate gro_flush helper function
>   Extend napi threaded polling to allow kthread based busy polling
>   selftests: Add napi threaded busy poll test in `busy_poller`
>
>  Documentation/ABI/testing/sysfs-class-net     |   3 +-
>  Documentation/netlink/specs/netdev.yaml       |  14 ++
>  Documentation/networking/napi.rst             |  80 ++++++++++-
>  .../net/ethernet/atheros/atl1c/atl1c_main.c   |   2 +-
>  drivers/net/ethernet/mellanox/mlxsw/pci.c     |   2 +-
>  drivers/net/ethernet/renesas/ravb_main.c      |   2 +-
>  drivers/net/wireless/ath/ath10k/snoc.c        |   2 +-
>  include/linux/netdevice.h                     |  24 +++-
>  include/uapi/linux/netdev.h                   |   7 +
>  net/core/dev.c                                | 127 ++++++++++++++----
>  net/core/net-sysfs.c                          |   2 +-
>  net/core/netdev-genl-gen.c                    |   5 +-
>  net/core/netdev-genl.c                        |   9 ++
>  tools/include/uapi/linux/netdev.h             |   7 +
>  tools/testing/selftests/net/busy_poll_test.sh |  25 +++-
>  tools/testing/selftests/net/busy_poller.c     |  14 +-
>  16 files changed, 285 insertions(+), 40 deletions(-)
>
> --
> 2.48.1.362.g079036d154-goog
>
Adding Joe and Martin as they requested to be CC'd in the next
revision. It seems I missed them when sending this out :(.

