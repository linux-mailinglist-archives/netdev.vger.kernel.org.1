Return-Path: <netdev+bounces-85653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79E89BC36
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D567B2840BB
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4A48CFC;
	Mon,  8 Apr 2024 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jS8yVjUd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505F48CF2
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569610; cv=none; b=PAGASBUsi1S/JIMTK0rAYnIQvq7GgBgOmXu9qZClMPvAIVyiAAfqWyVSov4nP2WaiTj7JKgWIWZ+AZv32ci+xYOkwU9mHUzE4Cb0LPf/6JH/9YNUN1aLYaLjDNYQlYueNopr3Y9UQCHtXd9OyIeprOggHbWt4TMmvxxuo9iRBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569610; c=relaxed/simple;
	bh=eCg0gkl0GdhVG586qosyhZ0zFoNThhX99gimdxogFCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNgyPx4bCPiL+2Gks/nKJLiz4eWgp8AtnsXYlR5bSUIb60FeGc+pElZTVbZQ9+Hf6/4PMB0wVRQqOBEPnqj3PzlwM48P4U0WUkb8gH5a3lFGCaNk3QIdxT3MlgW2SS3M9ziL1IJ3vSnsQWevzbBlZBDhkGa59vK3uzwGBQWyN2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jS8yVjUd; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e67402a3fso4061a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 02:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712569607; x=1713174407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGP2IU75M5nh28mXSV6VjeFJCN3D3Th2NbgMlVoU5vw=;
        b=jS8yVjUdr1Bj/l4DPmdg9XgoylaUL3whG3RYKgzE9cz9X12Iv/kQ/lUHmJ07XwEsix
         +IHpc/aN346DGxvvNDQiZ5VtJQis/iLCLeu0Q/BYGuCsF9s5vNEhCjm7RKWdJabyCwLN
         zAl6CJeXp3OdUQ0YwnUbMLdFh2Xs5F0q2v3qFQkszdneXhAKHwAYYssI/h7bCZXdvMEW
         KQrkQlKRoafPbNAMRHVQN3KHwWThw5E+f7C3/X4uQUhFEM63hDV0hRQIrr3jPgqqbG3+
         jeXV5Xj5f9Jhdd6+oA450aXSWx0B1JVbX/Hioz4KWA6kVsJrcYCbBFLA5JzGG5u2rFVr
         5VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712569607; x=1713174407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGP2IU75M5nh28mXSV6VjeFJCN3D3Th2NbgMlVoU5vw=;
        b=ItNSTSdw9s15CMojm1BYUCuS6Nue0m7vA4th9fZoaRrP3WiP+B0c0tHwTAXSkJf+n7
         e6dJGQnjYK+FZ3jIuWrUt2/9ssajukll7Rhth11yxStm7LZ3qFh4Kh8JOVfDADFNuQAH
         ZTn1aWZpLaZfLNEWSYCDC8KnCChxO4dUjsaGmBEdSE6Bptv4/y2QKfoRTfpn5wS5tBOY
         SFZRzoRu81vZ2JElML5qp4kvx1QtvyRAvxdt3eAk6gWaXE55hCF5FgQ5H1UyzowSAV4E
         ABvD1aThxWyuKkuFsyCrlGWPPZWpbu2nru0wubyd8p96gRaLMiX7nVA4cNcgHcMTyV4c
         0f1Q==
X-Gm-Message-State: AOJu0Yzd42+vKkPZ8oTCnAwRLnb1TPiW3ZG32aIYfHC1jPWhuV2iSASJ
	ztTioCxX3cTLsylCvIr7dcKAfBdJeX6iCFkwsHZL9UyYfF2ca2CH15lVJGr1RqAJjoDBx791H4n
	LntfIpamIlg9+ICgyxxggsJmYQ3cbe4dli/Tv
X-Google-Smtp-Source: AGHT+IGI65Q43I6NQGvN3ryNNw/lkUDBMTa2P9MveH73rk9cCc4d23jlyFCiYaTbqiLSIFs7jGPfAcmA03t5opYlgZ4=
X-Received: by 2002:a05:6402:3591:b0:56e:5c0a:8711 with SMTP id
 y17-20020a056402359100b0056e5c0a8711mr106850edc.3.1712569606856; Mon, 08 Apr
 2024 02:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406182107.261472-1-jmaloy@redhat.com> <20240406182107.261472-2-jmaloy@redhat.com>
In-Reply-To: <20240406182107.261472-2-jmaloy@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Apr 2024 11:46:34 +0200
Message-ID: <CANn89i+nmkrXRzmHjO=2ioK-PsKMuhKGLbbV9QWSXw=hJ1EY6w@mail.gmail.com>
Subject: Re: [net-next 1/2] tcp: add support for SO_PEEK_OFF socket option
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 8:21=E2=80=AFPM <jmaloy@redhat.com> wrote:
>
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
> j
> -----------------------------------------------------------
> Server listening on 5201 (test #1)
> -----------------------------------------------------------
> Accepted connection from 192.168.122.1, port 52084
> [  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 520=
98
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
> jmaloy@freyr:~/passt$ perf report -q --symbol-filter=3Ddo_syscall_64 \
>                        -p ____sys_recvmsg -x --stdio -i  perf.data | head=
 -1
> 46.32%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sy=
s_recvmsg
>
> With offset support:
> ----------------------
> jmaloy@freyr:~/passt$ perf report -q --symbol-filter=3Ddo_syscall_64 \
>                        -p ____sys_recvmsg -x --stdio -i  perf.data | head=
 -1
> 28.12%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sy=
s_recvmsg
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
>
> ---
> v3: - Applied changes suggested by Stefano Brivio and Paolo Abeni
> v4: - Same as v3. Posting was delayed because I first had to debug
>       an issue that turned out to not be directly related to this
>       change. See next commit in this series.

This other issue is orthogonal, and might take more time.
SO_RCVLOWAT had a similar issue, please take a look at what we did there.

If you need SO_PEEK_OFF support, I would suggest you submit this patch
as a standalone one.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

