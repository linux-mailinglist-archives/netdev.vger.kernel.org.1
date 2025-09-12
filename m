Return-Path: <netdev+bounces-222660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9486FB55493
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44780165C7E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E188B3168EA;
	Fri, 12 Sep 2025 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikem1wx1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74671D54E3
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694161; cv=none; b=MzR2fZ32qaJ2sp7LOt7Kl7VVf9Dwgj6a60QdZKeqvKfGL02dzuRbvHx8OoXR7xT1xZc4W1ZZHLlh8t5WbMBpPpuCqihc4Fi/YrTlpPTnXHOpDh2awjv1vGWC3KMAD7Z1qlnlBPGFIS2SKkTNVLOeXZMwj5ZQmZk/R47qr2HsVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694161; c=relaxed/simple;
	bh=sMrjKgRSUsJdIkwsLLzLrYOqSLoQRrH3W7j4A47vT0U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cp+VAhvYjwuV791VI2AUY3wDuPRKx/pWiWai7skTy1H9WA5xhqtc/EHGgiSsES+LFxGAvtjyjzuP3Q8sIJrGF96Xbp0rnml0mlWA2EXnzxO6v1DN2Q6X9bdKqzEEogBRnSKEHvTK37yZZUq6rrngNPAfvgBbEa1il8SQozAbRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikem1wx1; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-817f23fea68so101732385a.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757694159; x=1758298959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH6JVcoQTxeNPU5n4RXc2lldfsVNuvJjpKAZ6StXR3Q=;
        b=ikem1wx1VYV32r60sLRnm7vSM5jFarYo7SFg2xCc5C1E+FLWwX7VFIz8a0f8y9Ylx0
         ZEd3PJWQkAuXAlWDd+HoFD+OVJDdUF5nRc4GBRLmb+ay1I4YcmZ61b6jDFueF+ORJX96
         g9zk5a0LjWgpEzUfCdxEbmZDJo/zcpB6c1oV+wzmTsgyxZgyUvp2Bj3LflrGdAmhaS+L
         HtG9vbArd8SQg6UPkC6UGFrBMhj6719UAs9gK+RgoSQrOdSKB48vLHZ/qakWCI0Sv1pl
         pdEVaOeU9+D8fWqVL8c53fxcyGrwHKI5p4E9PQID6esKExPN5ai+UmJdsdd5C9WDXbF+
         aPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757694159; x=1758298959;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fH6JVcoQTxeNPU5n4RXc2lldfsVNuvJjpKAZ6StXR3Q=;
        b=IfhjS9dmKtLnGgvsmgF4seMZLSuogck/dSrd/gVdDFCWC+78TRiArQbt0x8gsK5gIh
         2OyHgtbOZw/XVK9xDhxGYuRTbI7F/4WEbjUlvMkdfNLRWJd3TkW6rhzmIhcRaWdg9/fz
         Z8NyP7qfAXGtMInrgXLLnoX/cNqKSDFNs8Y5P6+7b7BG9VrT5v8sSU16TW6VtBNNwT6M
         uLzJf3POlo4IaCj48JVXJ+DtpnWnPu6rRMWK0U5esAHSquNBWka17H5V0qJvz+pW3mmA
         FUV6ndAu5eYijtaUjVz6a6GFhtqI+2bJsckh5sGWD4lzDxgzZXn8aleSg4zj9KWw/aBo
         791A==
X-Forwarded-Encrypted: i=1; AJvYcCUetwH9YcmjP9cdex2cao2IqwGftJv/xfWOalIKnqFJ6Z2eSsZGxJMkQTmIqpbeqpv/zIrdpfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZgtlXknIjHSxpOHVCmHYBiKzT5oVyvntRyZYppCAjM68YylZY
	pHmK2v0fmIqmb297fVM85T2JuhTyIduN3zN/BJGPoaTy9anqTjfSbGcS
X-Gm-Gg: ASbGncuH7B93pzhwG5i9PhBNuwOucOjHArlaDZGrjgprdnhTnB6ae4hbqHJ/D+rFLrz
	xN2ZGYy42MwwpKdkaiIe+cyKQJ3Odzx/oC10moSkS5kmE6R5v73d2MdJLOJBDH1Kp2U/c8kxZ9Z
	8XXs3DOtFMIikppFPVdjnTZglh5BcpI9SRKWgk5V+JERd13sU/CHu/tiK7akeho/9LoalkOUWz2
	KeQ+/RMneNLBU24O5rPXlVJJb3CZOGXDoFXI4Y/6eMyYHxzsqWf0qSPsKk1yg3trhT82ZGh3n0Q
	ufDefWgTbEQ8HrK6V6UG6cOO9gXvS1lgz0ToTv2v7nKjS9DcnBTiv6TuSrfFVVGbeavHc3GNsp0
	JhxSZqZHL9GpfXHr2xm3DdW7b7mM+0EI8LG2lMuUHdsHBw6RQcJ/XttFI0c/QDj4jS/ZxNUpIft
	6CbQ==
X-Google-Smtp-Source: AGHT+IHu6ceQ54HMSODWdcEt6z9tSYZuyIcO2Py6NhwZrqx0VifNBhe27VVbSqlewC/jnaIP0TWenw==
X-Received: by 2002:a05:620a:d8c:b0:817:c961:73a3 with SMTP id af79cd13be357-823fd4190c5mr511585685a.31.1757694158500;
        Fri, 12 Sep 2025 09:22:38 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cf008f9dsm294591985a.64.2025.09.12.09.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:22:37 -0700 (PDT)
Date: Fri, 12 Sep 2025 12:22:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin Karsten <mkarsten@uwaterloo.ca>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 almasrymina@google.com, 
 willemb@google.com
Cc: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.355e9fc86e581@gmail.com>
In-Reply-To: <17e52364-1a8a-40a4-ba95-48233d49dc30@uwaterloo.ca>
References: <20250911212901.1718508-1-skhawaja@google.com>
 <17e52364-1a8a-40a4-ba95-48233d49dc30@uwaterloo.ca>
Subject: Re: [PATCH net-next v9 0/2] Add support to do threaded napi busy poll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin Karsten wrote:
> On 2025-09-11 17:28, Samiullah Khawaja wrote:
> > Extend the already existing support of threaded napi poll to do continuous
> > busy polling.
> > 
> > This is used for doing continuous polling of napi to fetch descriptors
> > from backing RX/TX queues for low latency applications. Allow enabling
> > of threaded busypoll using netlink so this can be enabled on a set of
> > dedicated napis for low latency applications.
> > 
> > Once enabled user can fetch the PID of the kthread doing NAPI polling
> > and set affinity, priority and scheduler for it depending on the
> > low-latency requirements.
> > 
> > Extend the netlink interface to allow enabling/disabling threaded
> > busypolling at individual napi level.
> > 
> > We use this for our AF_XDP based hard low-latency usecase with usecs
> > level latency requirement. For our usecase we want low jitter and stable
> > latency at P99.
> > 
> > Following is an analysis and comparison of available (and compatible)
> > busy poll interfaces for a low latency usecase with stable P99. This can
> > be suitable for applications that want very low latency at the expense
> > of cpu usage and efficiency.
> > 
> > Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NAPI
> > backing a socket, but the missing piece is a mechanism to busy poll a
> > NAPI instance in a dedicated thread while ignoring available events or
> > packets, regardless of the userspace API. Most existing mechanisms are
> > designed to work in a pattern where you poll until new packets or events
> > are received, after which userspace is expected to handle them.
> > 
> > As a result, one has to hack together a solution using a mechanism
> > intended to receive packets or events, not to simply NAPI poll. NAPI
> > threaded busy polling, on the other hand, provides this capability
> > natively, independent of any userspace API. This makes it really easy to
> > setup and manage.
> > 
> > For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
> > description of the tool and how it tries to simulate the real workload
> > is following,
> > 
> > - It sends UDP packets between 2 machines.
> > - The client machine sends packets at a fixed frequency. To maintain the
> >    frequency of the packet being sent, we use open-loop sampling. That is
> >    the packets are sent in a separate thread.
> > - The server replies to the packet inline by reading the pkt from the
> >    recv ring and replies using the tx ring.
> > - To simulate the application processing time, we use a configurable
> >    delay in usecs on the client side after a reply is received from the
> >    server.
> > 
> > The xsk_rr tool is posted separately as an RFC for tools/testing/selftest.
> > 
> > We use this tool with following napi polling configurations,
> > 
> > - Interrupts only
> > - SO_BUSYPOLL (inline in the same thread where the client receives the
> >    packet).
> > - SO_BUSYPOLL (separate thread and separate core)
> > - Threaded NAPI busypoll
> > 
> > System is configured using following script in all 4 cases,
> > 
> > ```
> > echo 0 | sudo tee /sys/class/net/eth0/threaded
> > echo 0 | sudo tee /proc/sys/kernel/timer_migration
> > echo off | sudo tee  /sys/devices/system/cpu/smt/control
> > 
> > sudo ethtool -L eth0 rx 1 tx 1
> > sudo ethtool -G eth0 rx 1024
> > 
> > echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> > echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> > 
> >   # pin IRQs on CPU 2
> > IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> > 				print arr[0]}' < /proc/interrupts)"
> > for irq in "${IRQS}"; \
> > 	do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> > 
> > echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> > 
> > for i in /sys/devices/virtual/workqueue/*/cpumask; \
> > 			do echo $i; echo 1,2,3,4,5,6 > $i; done
> > 
> > if [[ -z "$1" ]]; then
> >    echo 400 | sudo tee /proc/sys/net/core/busy_read
> >    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >    echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> > fi
> > 
> > sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-usecs 0
> > 
> > if [[ "$1" == "enable_threaded" ]]; then
> >    echo 0 | sudo tee /proc/sys/net/core/busy_poll
> >    echo 0 | sudo tee /proc/sys/net/core/busy_read
> >    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >    NAPI_ID=$(ynl --family netdev --output-json --do queue-get \
> >      --json '{"ifindex": '${IFINDEX}', "id": '0', "type": "rx"}' | jq '."napi-id"')
> > 
> >    ynl --family netdev --json '{"id": "'${NAPI_ID}'", "threaded": "busy-poll-enabled"}'
> > 
> >    NAPI_T=$(ynl --family netdev --output-json --do napi-get \
> >      --json '{"id": "'$NAPI_ID'"}' | jq '."pid"')
> > 
> >    sudo chrt -f  -p 50 $NAPI_T
> > 
> >    # pin threaded poll thread to CPU 2
> >    sudo taskset -pc 2 $NAPI_T
> > fi
> > 
> > if [[ "$1" == "enable_interrupt" ]]; then
> >    echo 0 | sudo tee /proc/sys/net/core/busy_read
> >    echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> > fi
> > ```
> > 
> > To enable various configurations, script can be run as following,
> > 
> > - Interrupt Only
> >    ```
> >    <script> enable_interrupt
> >    ```
> > 
> > - SO_BUSYPOLL (no arguments to script)
> >    ```
> >    <script>
> >    ```
> > 
> > - NAPI threaded busypoll
> >    ```
> >    <script> enable_threaded
> >    ```
> > 
> > If using idpf, the script needs to be run again after launching the
> > workload just to make sure that the configurations are not reverted. As
> > idpf reverts some configurations on software reset when AF_XDP program
> > is attached.
> > 
> > Once configured, the workload is run with various configurations using
> > following commands. Set period (1/frequency) and delay in usecs to
> > produce results for packet frequency and application processing delay.
> > 
> >   ## Interrupt Only and SO_BUSYPOLL (inline)
> > 
> > - Server
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> > 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h -v
> > ```
> > 
> > - Client
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> > 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> > 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> > ```
> > 
> >   ## SO_BUSYPOLL(done in separate core using recvfrom)
> > 
> > Argument -t spawns a seprate thread and continuously calls recvfrom.
> > 
> > - Server
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> > 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> > 	-h -v -t
> > ```
> > 
> > - Client
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> > 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> > 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> > ```
> > 
> >   ## NAPI Threaded Busy Poll
> > 
> > Argument -n skips the recvfrom call as there is no recv kick needed.
> > 
> > - Server
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> > 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> > 	-h -v -n
> > ```
> > 
> > - Client
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> > 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> > 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> > ```
> > 
> > | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
> > |---|---|---|---|---|
> > | 12 Kpkt/s + 0us delay | | | | |
> > |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> > |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> > |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> > |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> > | 32 Kpkt/s + 30us delay | | | | |
> > |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> > |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> > |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> > |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> > | 125 Kpkt/s + 6us delay | | | | |
> > |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> > |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> > |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> > |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> > | 12 Kpkt/s + 78us delay | | | | |
> > |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> > |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> > |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> > |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> > | 25 Kpkt/s + 38us delay | | | | |
> > |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> > |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> > |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> > |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> > 
> >   ## Observations
> > 
> > - Here without application processing all the approaches give the same
> >    latency within 1usecs range and NAPI threaded gives minimum latency.
> > - With application processing the latency increases by 3-4usecs when
> >    doing inline polling.
> > - Using a dedicated core to drive napi polling keeps the latency same
> >    even with application processing. This is observed both in userspace
> >    and threaded napi (in kernel).
> > - Using napi threaded polling in kernel gives lower latency by
> >    1-2usecs as compared to userspace driven polling in separate core.
> > - Even on a dedicated core, SO_BUSYPOLL adds around 1-2usecs of latency.
> >    This is because it doesn't continuously busy poll until events are
> >    ready. Instead, it returns after polling only once, requiring the
> >    process to re-invoke the syscall for each poll, which requires a new
> >    enter/leave kernel cycle and the setup/teardown of the busy poll for
> >    every single poll attempt.
> > - With application processing userspace will get the packet from recv
> >    ring and spend some time doing application processing and then do napi
> >    polling. While application processing is happening a dedicated core
> >    doing napi polling can pull the packet of the NAPI RX queue and
> >    populate the AF_XDP recv ring. This means that when the application
> >    thread is done with application processing it has new packets ready to
> >    recv and process in recv ring.
> > - Napi threaded busy polling in the kernel with a dedicated core gives
> >    the consistent P5-P99 latency.
> 
> We have been through this several times, but I want to repeat & 
> summarize my concerns:
> 
> While the proposed mechanism has some (limited) merit in specific 
> circumstances, it also has negative side effects in others. I believe 
> the cover letter for such a new feature should provide a balanced 
> description of pros and cons, along with a reproducible and sufficiently 
> comprehensive evaluation. Otherwise I worry that developers & 
> practitioners will look at this mechanism in the future and be tempted 
> to use it in scenarios where it does not help, but only wastes 
> resources. It does not seem hard to do this 

Your feedback has been heard.

This warning/limitation was intended to be covered in the
Documentation, but on rereading that can be made stronger.
I think the Documentation will be more valuable to users for this than
the cover letter. We'll revise.

Side-note: removing the device-wide enablement also greatly reduces
the odds that uniformed users blindly enable this because they think
busypolling is a strict good.

> and also provide experiment 
> setup, scripts, and benchmarks in a coherent repo that is easy to use, 
> instead of the current piecewise presentation.
 
With xsk_rr the series shares a reproducible benchmark, with detailed
setup instructions in the cover letter. This is not an academic
publication. That is a level of measurement of new kernel features
exceeding most. So here I disagree.


