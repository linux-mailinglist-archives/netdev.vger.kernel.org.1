Return-Path: <netdev+bounces-216596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97060B34AFB
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B5217BAA0
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADE228466C;
	Mon, 25 Aug 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCG/5y/C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487A169AE6
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150657; cv=none; b=DFUnLh6dnabhWGQt8qzlHNY/oJOH4E1vWyJd3/ONBwFMx150VcDalteMUQJz9Ms+tdBEgbH9a/s59nYExOaoUCX3s9t9a2gqM9KtzbRsgYd048YSmPnHCFf9aMrYPczceO3w0jmb5CuXh+o1Sxl8H0pjwQbKt5oy+1erYm+A+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150657; c=relaxed/simple;
	bh=K10h3M9KbOE5hMC4c+vdDyM6WXJwS/HGxhRInopiXV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0Hb1QyU0cBHwhQJz2MOwahKnPMBHJJExXDBq9uiEzUsIkLSOh3pfUbR0atq+wnCQEXmpmuSH2sTCCg3S/RBHvMWFECyVSrF80rLitQWGMFFst1SrkhbGBAlUy1O5cnCc2odfYQwVuCKBZ45FCcEEDe7w4iXRwWls1wm1mMunyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCG/5y/C; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so4207012b3a.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150655; x=1756755455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JspAce57i6qHqxwzi6a3rYAAXGsJT3LXkyDZDvwF1lw=;
        b=cCG/5y/C1U+VlnwpN6UqfGInU7CWbbuiOEzO2UWsfs2iKIZJoPLRgIETEHQtscGDfx
         M+V/0y683330tXvADM9dph1vaLYJARxKf+akegh3++bxwj5Cd1c0FWfmhTz+VSyMlkyZ
         WjjeUyfqNsWf8BPkPF31V4jolEj+6kXvsPdyoPNaQySvc6CmiqHO6q5MUtG7rNsrtDvy
         2e0KtInIAldAYtBtzwyDNYmWT8z6t0V8ULfVz31uRWYdMG8U0Tz0+JWML/vS7V0wu62Z
         G0q9s6R0+R5LssTdJkuOM6JFthoMvDqouTZbRGwRl7xPJ5IChWuGKH2DIOCqQymiClkD
         l+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150655; x=1756755455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JspAce57i6qHqxwzi6a3rYAAXGsJT3LXkyDZDvwF1lw=;
        b=AoDWFPOe1kGyZyprIUG1mK4bOQm1QZlgqCUeA36Fr63pFPklCze5wyIA7LHOv1eqHy
         a4BTskZuWZcHfj7FE3uUThHuvlRvs59u6PpYmz6htbYNG20XfIjEn1o76mrf+rQJuN0t
         biuOhWfHjL/a5cqR9EYCyGYcRNnY59kWyZ5lDw+sHuanHSf10foadhAVH83jjEqppPQs
         l812Q5PVeF/m6Hve2yxMNKQAbx012YwPE9NjFQGW0VywFhiiKF7IHr588vWxLX0NawnT
         l8R5polbaOpXoKwIB1n9q6RaJiUh+GzsoTBeNtQVrQ6YwlD/ADRdepQ8Ql+gZx5av00/
         2W3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWHVovWY1qQNahHJiWr9sC4a2Gk2CUaxlTqkdkLhbl7NsLUiIc1pyN61XEtm4pz8RrExChAPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZGbZlXPPB4SVxspv2in1VE1w8vG2xE6CwLdBnRRtp2HBBJlH
	OyoNlTQY2MVRgFHddBxK8UB5VtTKgtK9IKLmf18Tcf5bPclECis9sKc=
X-Gm-Gg: ASbGncv4jkrmSKuRTC1r5Q2lox0uR1jUxETsuHbwbb5Uciyfud1pu3PnfRssv4uH/Nl
	ykoDMZa5yZvLBPASeZP5Suo3RC3c7UheFhtRW01H7FOs4slSi1Pxw1BI8Gs5dFLzyDwyVKLaAOk
	kk1pRF2oB212uV3L9Gk8V0eNDleJIDbJBMbHj/35WcQoGAKA6rZbLpBJlUVLYf+QGx62n1QmmTV
	wtSZLq2uB3DjA59kECFqU3n4LYDp8ugi96+mijzewsHa4HXprYW1nBCq3+2fkMb8pBeaX6KQ9vc
	TmuxDkEisR28MxqvIzCOyJxZPdpOKT+o3LdTAdFTealKppvSycmSYFTvJ0pF7qVk5BkITVEOHb0
	cO9CnGCbN8aOwNX6bAIDHP3qIHF+UVX3ZcBGxywh6fvyhrCGsm0CjrIp3bEkDgf0Q6jwQ2XEgNK
	wxn3QiUVKHl1+LTxa64wF1x8pUIOaMxl4pLLtvTNN2WOPThl/SZS4p1zhcpYc5py2JH8hURbFPS
	HW7
X-Google-Smtp-Source: AGHT+IEzou8X8pz2beNTkpAR6bLvAktH1PlEXDIMYf0PhcVCPQ/4h6wR79IX35VLPhRCMXJXY3pJkg==
X-Received: by 2002:a05:6a00:b45:b0:770:556d:32e8 with SMTP id d2e1a72fcca58-770556d5e86mr7829473b3a.24.1756150655285;
        Mon, 25 Aug 2025 12:37:35 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-771e6535272sm2962471b3a.24.2025.08.25.12.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:37:35 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:37:34 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/2] Add support to do threaded napi busy poll
Message-ID: <aKy7fmowmZ8g9ZhH@mini-arch>
References: <20250824215418.257588-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250824215418.257588-1-skhawaja@google.com>

On 08/24, Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busy polling.
> 
> This is used for doing continuous polling of napi to fetch descriptors
> from backing RX/TX queues for low latency applications. Allow enabling
> of threaded busypoll using netlink so this can be enabled on a set of
> dedicated napis for low latency applications.
> 
> Once enabled user can fetch the PID of the kthread doing NAPI polling
> and set affinity, priority and scheduler for it depending on the
> low-latency requirements.
> 
> Currently threaded napi is only enabled at device level using sysfs. Add
> support to enable/disable threaded mode for a napi individually. This
> can be done using the netlink interface. Extend `napi-set` op in netlink
> spec that allows setting the `threaded` attribute of a napi.
> 
> Extend the threaded attribute in napi struct to add an option to enable
> continuous busy polling. Extend the netlink and sysfs interface to allow
> enabling/disabling threaded busypolling at device or individual napi
> level.
> 
> We use this for our AF_XDP based hard low-latency usecase with usecs
> level latency requirement. For our usecase we want low jitter and stable
> latency at P99.
> 
> Following is an analysis and comparison of available (and compatible)
> busy poll interfaces for a low latency usecase with stable P99. Please
> note that the throughput and cpu efficiency is a non-goal.
> 
> For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
> description of the tool and how it tries to simulate the real workload
> is following,
> 
> - It sends UDP packets between 2 machines.
> - The client machine sends packets at a fixed frequency. To maintain the
>   frequency of the packet being sent, we use open-loop sampling. That is
>   the packets are sent in a separate thread.
> - The server replies to the packet inline by reading the pkt from the
>   recv ring and replies using the tx ring.
> - To simulate the application processing time, we use a configurable
>   delay in usecs on the client side after a reply is received from the
>   server.
> 
> The xdp_rr tool is posted separately as an RFC for tools/testing/selftest.
> 
> We use this tool with following napi polling configurations,
> 
> - Interrupts only
> - SO_BUSYPOLL (inline in the same thread where the client receives the
>   packet).
> - SO_BUSYPOLL (separate thread and separate core)
> - Threaded NAPI busypoll
> 
> System is configured using following script in all 4 cases,
> 
> ```
> echo 0 | sudo tee /sys/class/net/eth0/threaded
> echo 0 | sudo tee /proc/sys/kernel/timer_migration
> echo off | sudo tee  /sys/devices/system/cpu/smt/control
> 
> sudo ethtool -L eth0 rx 1 tx 1
> sudo ethtool -G eth0 rx 1024
> 
> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> 
>  # pin IRQs on CPU 2
> IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> 				print arr[0]}' < /proc/interrupts)"
> for irq in "${IRQS}"; \
> 	do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> 
> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> 
> for i in /sys/devices/virtual/workqueue/*/cpumask; \
> 			do echo $i; echo 1,2,3,4,5,6 > $i; done
> 
> if [[ -z "$1" ]]; then
>   echo 400 | sudo tee /proc/sys/net/core/busy_read
>   echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>   echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> fi
> 
> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-usecs 0
> 
> if [[ "$1" == "enable_threaded" ]]; then
>   echo 0 | sudo tee /proc/sys/net/core/busy_poll
>   echo 0 | sudo tee /proc/sys/net/core/busy_read
>   echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>   echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>   echo 2 | sudo tee /sys/class/net/eth0/threaded
>   NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
>   sudo chrt -f  -p 50 $NAPI_T
> 
>   # pin threaded poll thread to CPU 2
>   sudo taskset -pc 2 $NAPI_T
> fi
> 
> if [[ "$1" == "enable_interrupt" ]]; then
>   echo 0 | sudo tee /proc/sys/net/core/busy_read
>   echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>   echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> fi
> ```
> 
> To enable various configurations, script can be run as following,
> 
> - Interrupt Only
>   ```
>   <script> enable_interrupt
>   ```
> 
> - SO_BUSYPOLL (no arguments to script)
>   ```
>   <script>
>   ```
> 
> - NAPI threaded busypoll
>   ```
>   <script> enable_threaded
>   ```
> 
> If using idpf, the script needs to be run again after launching the
> workload just to make sure that the configurations are not reverted. As
> idpf reverts some configurations on software reset when AF_XDP program
> is attached.
> 
> Once configured, the workload is run with various configurations using
> following commands. Set period (1/frequency) and delay in usecs to
> produce results for packet frequency and application processing delay.
> 
>  ## Interrupt Only and SO_BUSY_POLL (inline)
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h -v
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> ```
> 
>  ## SO_BUSY_POLL(done in separate core using recvfrom)
> 
> Argument -t spawns a seprate thread and continuously calls recvfrom.
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> 	-h -v -t
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> ```
> 
>  ## NAPI Threaded Busy Poll
> 
> Argument -n skips the recvfrom call as there is no recv kick needed.
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> 	-h -v -n
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> ```
> 
> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
> |---|---|---|---|---|
> | 12 Kpkt/s + 0us delay | | | | |
> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> | 32 Kpkt/s + 30us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> | 125 Kpkt/s + 6us delay | | | | |
> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> | 12 Kpkt/s + 78us delay | | | | |
> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> | 25 Kpkt/s + 38us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> 
>  ## Observations
> 
> - Here without application processing all the approaches give the same
>   latency within 1usecs range and NAPI threaded gives minimum latency.
> - With application processing the latency increases by 3-4usecs when
>   doing inline polling.
> - Using a dedicated core to drive napi polling keeps the latency same
>   even with application processing. This is observed both in userspace
>   and threaded napi (in kernel).
> - Using napi threaded polling in kernel gives lower latency by
>   1-1.5usecs as compared to userspace driven polling in separate core.
> - With application processing userspace will get the packet from recv
>   ring and spend some time doing application processing and then do napi
>   polling. While application processing is happening a dedicated core
>   doing napi polling can pull the packet of the NAPI RX queue and
>   populate the AF_XDP recv ring. This means that when the application
>   thread is done with application processing it has new packets ready to
>   recv and process in recv ring.
> - Napi threaded busy polling in the kernel with a dedicated core gives
>   the consistent P5-P99 latency.

The real take away for me is ~1us difference between SO_BUSYPOLL in a
thread and NAPI threaded. Presumably mostly because of the non-blocking calls
to sk_busy_loop in the former? So it takes 1us extra to enter/leave the kernel
and setup/teardown the busy polling?

And you haven't tried epoll based busy polling? I'd expect to see
results similar to your NAPI threaded (if it works correctly).

(have nothing against the busy polling thread, mostly trying to
understand what we are missing from the existing setup)

