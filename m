Return-Path: <netdev+bounces-81898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C768388B95E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 05:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5251AB233D7
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDE4129E88;
	Tue, 26 Mar 2024 04:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXvDnNDG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1212A17D;
	Tue, 26 Mar 2024 04:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426533; cv=none; b=nNkhJVpoO5Ho3DMPD0AESLuPBbG2S3kqliVYArMLrCRXopYS/x71l1ERn7DjcrmZd9VjGQs8clMsALDdHhDghANiWqGYUHddLM5XnCR9m8v9Xv18yhCRopxsy2evUmj3FEDtoYZtenpW7rJJdidGkTr7wrQ8y4ns36zMrO2SulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426533; c=relaxed/simple;
	bh=S3UxgrA81oUdcmCxzKTVW3R+vILn/7+8GYxjxDbd2x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pv6S5aktlt/AM8Isv1Sjsdw0FS8VDBlBJh/eYpcwEfmqX9wXgghMc4R+2E2OkFH55zPg0ESKTgeVUWpjLhoCVLzuNe0BWrVtx482xeme3xE1Z0utMUSxEsW2m4kSPoqY2fS2LqmnCRJ2k30AukZAA4vUglIlSB1Oxc7/cI1k1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXvDnNDG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4a34516955so228690866b.0;
        Mon, 25 Mar 2024 21:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711426528; x=1712031328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJgrIPcLEfbb+GlYQP2saDUSVzKQCmvfK/XE9xkFkVs=;
        b=iXvDnNDG+NoQP6IieAfLRzxBWgHJM6MJJldjLBObo6P847uR5uYZT1miA9LHY4S56q
         d1XmCB0M2TzbB7JCY1NT0zjLYM6RivsLRFbmyx00+d4s4bniThIp6QrGF1soyXBVt3+g
         +szgvcTePVsDYNJ7zhOO0GV/3gyaGqQpgqNCTjti26i8ybK17WbMTRur8a4W1zMWe3SU
         rGhz7LZRKK0L7IaLndb7xmrqJ7Tj92/JztTsEbByvW1iPvE9B//yMyg9dLdnL4JEHrxT
         GksL65VcRpRP/C84z6ZOqXjvJ5tVu/OVxRzLNJnQcgU1+8Qr570rFGjKY8LQHaz52ePc
         E7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711426528; x=1712031328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJgrIPcLEfbb+GlYQP2saDUSVzKQCmvfK/XE9xkFkVs=;
        b=DVXUq93zjnCH5WQSAuRtheZRgZ9tmFBeh3BB/bJsiBFulmbKEqDIQ/qWn1pyBE9HTg
         q+f+5dTgo4OXxcsw9LbCyQvTp66M+Y64RC4V23sX4RyQJL7zTw2XczU/5pgCYq9yWnQK
         Bb+T9fknfeWIGfScxf+F+DYhSl9xiehGkenhtv4SG+aF3HF42pGRGZYr+EmIwSGQmvvD
         la6kEZUJa+eEdwkVQPvOUCffoUkwDoPS1/nph4NfYRtr7IWhM+5lRtmhSjQDjUn7JwLl
         qvLHlxroJvj0CGhvds8ovz1ApN18Le001p3vzlG5XjtXDgj5dhy+Vn0TlgnNw7iHIrfN
         J5JA==
X-Forwarded-Encrypted: i=1; AJvYcCWuM7sR6ikqQjzZU2OqwGOVrswo5X+hVEN5gH1qzJRWOBC57FWDLAdnVQ4/cl2XvrjT1lrmHjE49zt3mfXakUV4miNhZqKtzLzA2gp2kSoZlceJ
X-Gm-Message-State: AOJu0YxIShYf+pCNcv1ev1eRT6iwksNOAyjrizcxa9WaiTuOzgnr7P3s
	/MYMtsdpOgPV9pN72kzXJ1fwZf3Pru+QNGYJ+DjEyexHJHpP1zc4ZwLYyomG07022b8mMcpis1f
	yL3/fXfsxqO4iDIzARq944VrbnF2fEXpRDLPtfg==
X-Google-Smtp-Source: AGHT+IGsrs7V1GZQSR49QHGVJ6O0cdWl5PXgnjYtcRoFYGmHb3j/lhqfeaseza/N45bVBjKESJe47yNs9exdxgeqT0s=
X-Received: by 2002:a17:906:2816:b0:a47:2f8c:7618 with SMTP id
 r22-20020a170906281600b00a472f8c7618mr5645398ejc.59.1711426527554; Mon, 25
 Mar 2024 21:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325034347.19522-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240325034347.19522-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Mar 2024 12:14:51 +0800
Message-ID: <CAL+tcoAb3Q13hXnEhukCUwBL0Q1W9qC7LuWyzXYGcDzEM56LqA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] trace: use TP_STORE_ADDRS macro
To: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 11:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Using the macro for other tracepoints use to be more concise.
> No functional change.
>
> Jason Xing (3):
>   trace: move to TP_STORE_ADDRS related macro to net_probe_common.h
>   trace: use TP_STORE_ADDRS() macro in inet_sk_error_report()
>   trace: use TP_STORE_ADDRS() macro in inet_sock_set_state()
>
>  include/trace/events/net_probe_common.h | 29 ++++++++++++++++++++
>  include/trace/events/sock.h             | 35 ++++---------------------

I just noticed that some trace files in include/trace directory (like
net_probe_common.h, sock.h, skb.h, net.h, sock.h, udp.h, sctp.h,
qdisc.h, neigh.h, napi.h, icmp.h, ...) are not owned by networking
folks while some files (like tcp.h) have been maintained by specific
maintainers/experts (like Eric) because they belong to one specific
area. I wonder if we can get more networking guys involved in net
tracing.

I'm not sure if 1) we can put those files into the "NETWORKING
[GENERAL]" category, or 2) we can create a new category to include
them all.

I know people start using BPF to trace them all instead, but I can see
some good advantages of those hooks implemented in the kernel, say:
1) help those machines which are not easy to use BPF tools.
2) insert the tracepoint in the middle of some functions which cannot
be replaced by bpf kprobe.
3) if we have enough tracepoints, we can generate a timeline to
know/detect which flow/skb spends unexpected time at which point.
...
We can do many things in this area, I think :)

What do you think about this, Jakub, Paolo, Eric ?

Thanks,
Jason

>  include/trace/events/tcp.h              | 29 --------------------
>  3 files changed, 34 insertions(+), 59 deletions(-)
>
> --
> 2.37.3
>

