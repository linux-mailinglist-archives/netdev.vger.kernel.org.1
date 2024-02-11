Return-Path: <netdev+bounces-70845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A9850C53
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 00:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183FB281CF0
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC5618E01;
	Sun, 11 Feb 2024 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VC4e3l2V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094818AEA
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693499; cv=none; b=tVAN3j9hvw4bKsLWNqVr9NUtDbvNr68Xyx/zbsvhty5AFBrHjdBsePV2Lxt9h3ldX9o9HsdQi4OynR+ZCVeqDPRzm6lxmZNKuXjl78iS7Q7S/Jq5WW+RgYaHXy1xdoxWe1bk8QXPT2D7y6g/nnCX1DiHp4c09e1inMfhxQlQF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693499; c=relaxed/simple;
	bh=NKqXIwj+6Eg4OvTqCOqnpO6eupChZFMmWeT61V/PeXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeAkrnMMIuRi5iNl+navLuX9kuDSTTegjw5eZqwlCCy9y8teTTf2BLibi6Yfm+Y+RvEHNtYyG57iwplDlpMOPmYUZbp2jsnSG07RiB3/2xn8it+Sg010x3QWD26F+i78TMbJz/oE0HTA9miAaW3WxD1moRgQAGrjJTgbWLajvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VC4e3l2V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707693495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCHjDOobnmN9GPD6LbM4ksvjDEWsx05V43xu8tWAYxs=;
	b=VC4e3l2V1Co4ALAgeoX9mgbdwV3zeYEppi+h5jwOMuARye0UNG4LgM8V8Q6pQbdDA1DlV7
	RZfNDfdc3CUz9C+04zHKbwjmdth37NKrBC8x5S95M778ozI2znZsZoJ0u4+27qcPV4S5rg
	eJZTZ8HHAojy/LBuf3/dPl2ZMcLw3cw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-LlLok1jkM6uPQeGsyBq41w-1; Sun, 11 Feb 2024 18:18:14 -0500
X-MC-Unique: LlLok1jkM6uPQeGsyBq41w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2b068401b4so320939666b.1
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 15:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693493; x=1708298293;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCHjDOobnmN9GPD6LbM4ksvjDEWsx05V43xu8tWAYxs=;
        b=TpTXIw9lNBrUdRYjYUazWM7y8omrVv6SjCX2W52R+oST52h6TRP+gbsTtK8nEfOksk
         d9bv4nz9UG8N+Ris5w7rbvIztCfHwEAAdTRR7fw3in6hgg9XoYS4Rzf+8JTkZdrvxExH
         TL8WUkHabl40hM9KUvxL9E8yg0gfPvZqRRlqbH8q99MhXwg8cXiIdcE7FJ9Dct1tzRhX
         zYegrHagdydcIz6fa4petNHLWIIl3YHuR0dyLVlVW4D7SrYrWb2WhziafoG4M0aLZ2Qf
         hsdqoaOGLTOaKjblD+Ks18qNJs3sQQQyWm5OPDELs1lDh8H4YZv98cPcjyKmSEwzM7I4
         A2fA==
X-Gm-Message-State: AOJu0YznhN05c1U3/miTtQiWqgEVpz9QpY2d/F9I6Ff2pRvWXqv0bdtN
	b5NcMRZJzApgQuYZBYIx40XxtrvbsezEvbGLf/pDEwLSgNmc1akkQgKSdzbqs0qvhl2G0qWrqWT
	Z7lR2/jUq+/v8XM1rtlHhvpVmptSTgLCgTrKenrgWXe/x/FTfUPcOnw==
X-Received: by 2002:a17:906:27da:b0:a3c:55e4:eed7 with SMTP id k26-20020a17090627da00b00a3c55e4eed7mr2731128ejc.21.1707693492861;
        Sun, 11 Feb 2024 15:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbKY00r3KqZjXtsp0FCGxH1Eg2G1epjTSsD5m5Tg6lVH4KumDpIAmXB2kGGRXCI2WO4dCoYw==
X-Received: by 2002:a17:906:27da:b0:a3c:55e4:eed7 with SMTP id k26-20020a17090627da00b00a3c55e4eed7mr2731125ejc.21.1707693492653;
        Sun, 11 Feb 2024 15:18:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLrNeHq94ZwKYiRfZawGu8Av7hOFeJGNsg8unbPrcC6JYlVrT3Y4kUAJMNDGlsYI4ZXLK8f1woQjz2JJWVcsuZg4e0UOFfAMhp0guR1or3VRsWamnjL30cp3AXjVDFgkrT47LLxzsiX+etGsNlHSfzwk1FAaZsJWnGe5IbOmaSvqVhU+/1QqcWUuysotDiZq5OY3E7X7oJs33sUOd5EOMtb/1iuA==
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id tx13-20020a1709078e8d00b00a3ca40f5045sm326552ejc.72.2024.02.11.15.18.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Feb 2024 15:18:11 -0800 (PST)
Date: Mon, 12 Feb 2024 00:17:38 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, lvivier@redhat.com, dgibson@redhat.com, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
Message-ID: <20240212001738.08d3a857@elisabeth>
In-Reply-To: <20240209221233.3150253-1-jmaloy@redhat.com>
References: <20240209221233.3150253-1-jmaloy@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 17:12:33 -0500
jmaloy@redhat.com wrote:

> From: Jon Maloy <jmaloy@redhat.com>
> 
> When reading received messages from a socket with MSG_PEEK, we may want
> to read the contents with an offset, like we can do with pread/preadv()
> when reading files. Currently, it is not possible to do that.
> 
> In this commit, we add support for the SO_PEEK_OFF socket option for TCP,
> in a similar way it is done for Unix Domain sockets.
> 
> In the iperf3 log examples shown below, we can observe a throughput
> improvement of 15-20 % in the direction host->namespace when using the
> protocol splicer 'pasta' (https://passt.top).
> This is a consistent result.
> 
> pasta(1) and passt(1) implement user-mode networking for network
> namespaces (containers) and virtual machines by means of a translation
> layer between Layer-2 network interface and native Layer-4 sockets
> (TCP, UDP, ICMP/ICMPv6 echo).
> 
> Received, pending TCP data to the container/guest is kept in kernel
> buffers until acknowledged, so the tool routinely needs to fetch new
> data from socket, skipping data that was already sent.
> 
> At the moment this is implemented using a dummy buffer passed to
> recvmsg(). With this change, we don't need a dummy buffer and the
> related buffer copy (copy_to_user()) anymore.
> 
> passt and pasta are supported in KubeVirt and libvirt/qemu.
> 
> jmaloy@freyr:~/passt$ perf record -g ./pasta --config-net -f
> SO_PEEK_OFF not supported by kernel.
> 
> jmaloy@freyr:~/passt# iperf3 -s
> -----------------------------------------------------------
> Server listening on 5201 (test #1)
> -----------------------------------------------------------
> Accepted connection from 192.168.122.1, port 44822
> [  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 44832
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  1.02 GBytes  8.78 Gbits/sec
> [  5]   1.00-2.00   sec  1.06 GBytes  9.08 Gbits/sec
> [  5]   2.00-3.00   sec  1.07 GBytes  9.15 Gbits/sec
> [  5]   3.00-4.00   sec  1.10 GBytes  9.46 Gbits/sec
> [  5]   4.00-5.00   sec  1.03 GBytes  8.85 Gbits/sec
> [  5]   5.00-6.00   sec  1.10 GBytes  9.44 Gbits/sec
> [  5]   6.00-7.00   sec  1.11 GBytes  9.56 Gbits/sec
> [  5]   7.00-8.00   sec  1.07 GBytes  9.20 Gbits/sec
> [  5]   8.00-9.00   sec   667 MBytes  5.59 Gbits/sec
> [  5]   9.00-10.00  sec  1.03 GBytes  8.83 Gbits/sec
> [  5]  10.00-10.04  sec  30.1 MBytes  6.36 Gbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.04  sec  10.3 GBytes  8.78 Gbits/sec   receiver
> -----------------------------------------------------------
> Server listening on 5201 (test #2)
> -----------------------------------------------------------
> ^Ciperf3: interrupt - the server has terminated
> jmaloy@freyr:~/passt#
> logout
> [ perf record: Woken up 23 times to write data ]
> [ perf record: Captured and wrote 5.696 MB perf.data (35580 samples) ]
> jmaloy@freyr:~/passt$
> 
> jmaloy@freyr:~/passt$ perf record -g ./pasta --config-net -f
> SO_PEEK_OFF supported by kernel.
> 
> jmaloy@freyr:~/passt# iperf3 -s
> -----------------------------------------------------------
> Server listening on 5201 (test #1)
> -----------------------------------------------------------
> Accepted connection from 192.168.122.1, port 52084
> [  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 52098
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  1.32 GBytes  11.3 Gbits/sec
> [  5]   1.00-2.00   sec  1.19 GBytes  10.2 Gbits/sec
> [  5]   2.00-3.00   sec  1.26 GBytes  10.8 Gbits/sec
> [  5]   3.00-4.00   sec  1.36 GBytes  11.7 Gbits/sec
> [  5]   4.00-5.00   sec  1.33 GBytes  11.4 Gbits/sec
> [  5]   5.00-6.00   sec  1.21 GBytes  10.4 Gbits/sec
> [  5]   6.00-7.00   sec  1.31 GBytes  11.2 Gbits/sec
> [  5]   7.00-8.00   sec  1.25 GBytes  10.7 Gbits/sec
> [  5]   8.00-9.00   sec  1.33 GBytes  11.5 Gbits/sec
> [  5]   9.00-10.00  sec  1.24 GBytes  10.7 Gbits/sec
> [  5]  10.00-10.04  sec  56.0 MBytes  12.1 Gbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.04  sec  12.9 GBytes  11.0 Gbits/sec  receiver
> -----------------------------------------------------------
> Server listening on 5201 (test #2)
> -----------------------------------------------------------
> ^Ciperf3: interrupt - the server has terminated
> logout
> [ perf record: Woken up 20 times to write data ]
> [ perf record: Captured and wrote 5.040 MB perf.data (33411 samples) ]
> jmaloy@freyr:~/passt$
> 
> The perf record confirms this result. Below, we can observe that the
> CPU spends significantly less time in the function ____sys_recvmsg()
> when we have offset support.
> 
> Without offset support:
> ----------------------
> jmaloy@freyr:~/passt$ perf report -q --symbol-filter=do_syscall_64 \
>                        -p ____sys_recvmsg -x --stdio -i  perf.data | head -1
> 46.32%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sys_recvmsg
> 
> With offset support:
> ----------------------
> jmaloy@freyr:~/passt$ perf report -q --symbol-filter=do_syscall_64 \
>                        -p ____sys_recvmsg -x --stdio -i  perf.data | head -1
> 28.12%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sys_recvmsg
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano


