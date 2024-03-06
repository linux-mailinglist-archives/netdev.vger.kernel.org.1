Return-Path: <netdev+bounces-77908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 769FA8736ED
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA772847FA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B52A12C53D;
	Wed,  6 Mar 2024 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRMsbHf8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4DA12C81D
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729518; cv=none; b=h/wDvTfZrFe3wSpAD+ugbiVmpIId+ujjWc6qJr99mJc4kiYc/QjvVurIzr5t2AVo3GaJuSZg8PYIsHixu/Of4C5wPVqyp1TRE2qhZkU3cri99CsTf5PVA/ZyG+miA6mshTGxbHJzgVjTFiYL1PADXqBNlz4mGW3nNVSvHp8jqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729518; c=relaxed/simple;
	bh=RdX+DSyimaOFGLL/X/PkNBOiu5y8vWHzGkaUio1sOK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THEJoxg1lUTSscya5LpgBe5hzxIjMW2RHqBJ+C0WuGhwHQ5e2F9GXGp8VMTjC0BoWdAU23/bnBBregIh3Ocmzbp0aZiOB64gaVnl6vVSEUKrUCG/zOEQiQNHoPtYzXJ1dkoryYFaGJ4xuaHtEiDWJVzqrvEN+rI2Uq1f6FxDHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TRMsbHf8; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so8407a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 04:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709729514; x=1710334314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ53iU6hdRTVPXgb3bO7wAZ+renq+wmZYoXZ3DzIzD0=;
        b=TRMsbHf8bi7lRPrYccur/RzoR/6TByjI8Lk5ZQOB6mkNxKWV0jt7xJUz5xZYS37Jei
         kM20drBiHkynuKBUP3iA5Xql3KNH8VgxQmP5qW9d2KBSHX6NhJwkOSZHkZt3yJtDS8jz
         WhR68MA55IQopWjDcBt/dTtKGOEDdW6Rg24eSX+PcVzro8c8JLQ7pFylkAddHhDlXCt3
         V+k6XagdGcY3oJONrUzbJ5v6iX/5QaYF78xJAPF4IbhcpJKTUWrn4TsPm5le+1vVq8GV
         ESt/bhFAL5gG3G6Idz9evRnTybfIuEMqmC5cNQ4Q6SCpOxS++5kgy2aZFlRD58IFpo4X
         uBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729514; x=1710334314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ53iU6hdRTVPXgb3bO7wAZ+renq+wmZYoXZ3DzIzD0=;
        b=dx2OacdWVr1fa2tH6qfwDjpVu/DrsKcL+CFRVjWaDwFct+y5WPWB8HptZ+afNPwtFl
         wo43guNBni8Qh1T+n3AigJ4HbzL5GAMi6LsoRHNGs8CchfPFP0OVRxlItrausTRp+r3N
         wpY1WfJ81fDhtPIkX/v4ZSxM/v6DDhITwH+PIG0D2Qmb7qo3p5eClm5wn7Uzx9omLFQh
         6xjRkJ4KYd3xVEqKllLkKpxkdrYsMP1XWrR3NdHqlKvlagMFnXLUlmTchhO4RpdmiDyv
         /XunhXsWm7tJTU1b1XgER1ksFv1LzH4jW+Q9qPtMsH6Nqs3HcX5fbFIzH9B8eXfYKl7P
         JDqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1OeAs/0nIcrLZmOkypb8zyfkd/MbkzufU7DhHXE04+l/GHDqyTLcA9sJZ8rwKFIoE8QQsJ7Ltegm79eDOgUpI0tRckntr
X-Gm-Message-State: AOJu0YywMU+F8RFXUBTXku7FSs4u5xRw2DGA34k2fD56J67uF5+wycVB
	wr48q6jva1mpDG+f0r+CzsAk8XrimayvYLb4IIQ8GKV0FFLVM2LkxS7ZSugplWKwjJtW5XWsl2O
	kOXsTG2UmGQB8d9FuPmtsvq/iADXGckNFlEEC
X-Google-Smtp-Source: AGHT+IFtvFD2ZWOokx9QBO0s8NCnSEsCvbB5F7v6PO7oH9hJmXc+UvaqBvlsIWlzux1PjlgPgyqNDGVVrunv73mxrSU=
X-Received: by 2002:a05:6402:22c4:b0:567:3840:15be with SMTP id
 dm4-20020a05640222c400b00567384015bemr312577edb.1.1709729513557; Wed, 06 Mar
 2024 04:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALkn8kLOozs5UO52SQa9PR-CiKx_mqW8VF9US94qN+ixyqnkdQ@mail.gmail.com>
 <CANn89iLH5+KryWa3GMs-Fz+sdy9Qs7kJqfBwf0229iwgW65Hxg@mail.gmail.com> <CACHbv+x5732JVEWkO14ogz48cze7_ai_D5TA9C2X6_b97rioEA@mail.gmail.com>
In-Reply-To: <CACHbv+x5732JVEWkO14ogz48cze7_ai_D5TA9C2X6_b97rioEA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Mar 2024 13:51:42 +0100
Message-ID: <CANn89i+CEHApkAO7msUPoQdMgjJsgJ=gNuHcOdYZqbwEdwVrOg@mail.gmail.com>
Subject: Re: Network performance regression in Linux kernel 6.6 for small
 socket size test cases
To: Boon Ang <boon.ang@broadcom.com>
Cc: Abdul Anshad Azeez <abdul-anshad.azeez@broadcom.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Savanyo <john.savanyo@broadcom.com>, 
	Peter Jonasson <peter.jonasson@broadcom.com>, Rajender M <rajender.m@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 1:43=E2=80=AFPM Boon Ang <boon.ang@broadcom.com> wro=
te:
>
> Hello Eric,
>
> The choice of socket buffer size is something that  an application can de=
cide and there many be reasons to keep to smaller sizes.  While high bandwi=
dth transfers obviously should use larger sizes, a change that regresses th=
e performance of existing configuration is a regression.  Is there any way =
to modify your change so that it keeps the benefits while avoiding the degr=
adation for small socket sizes?
>


The kernel limits the amount of memory used by the receive queue.

The problem is that for XXX bytes of payload (what the user application wan=
ts),
the metadata overhead is not fixed.

Kernel structures change over time, and packets are not always full
from the remote peer (that we can not control)

1000 bytes of payload might fit in 2KB, or 2MB depending on how the
bytes are spread over multiple skbs.

This issue has been there forever, the kernel can not put in stone any rule=
 :

XXXX bytes of payload  --->  YYYY bytes of kernel memory to hold XXXX
bytes of payload.

It is time that applications setting tiny SO_RCVBUF values get what they wa=
nt :

Poor TCP performance.

Thanks.

> Thanks
>   Boon
>
> On Wed, Feb 28, 2024 at 12:48=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
>>
>> On Wed, Feb 28, 2024 at 7:43=E2=80=AFAM Abdul Anshad Azeez
>> <abdul-anshad.azeez@broadcom.com> wrote:
>> >
>> > During performance regression workload execution of the Linux
>> > kernel we observed up to 30% performance decrease in a specific networ=
king
>> > workload on the 6.6 kernel compared to 6.5 (details below). The regres=
sion is
>> > reproducible in both Linux VMs running on ESXi and bare metal Linux.
>> >
>> > Workload details:
>> >
>> > Benchmark - Netperf TCP_STREAM
>> > Socket buffer size - 8K
>> > Message size - 256B
>> > MTU - 1500B
>> > Socket option - TCP_NODELAY
>> > # of STREAMs - 32
>> > Direction - Uni-Directional Receive
>> > Duration - 60 Seconds
>> > NIC - Mellanox Technologies ConnectX-6 Dx EN 100G
>> > Server Config - Intel(R) Xeon(R) Gold 6348 CPU @ 2.60GHz & 512G Memory
>> >
>> > Bisect between 6.5 and 6.6 kernel concluded that this regression origi=
nated
>> > from the below commit:
>> >
>> > commit - dfa2f0483360d4d6f2324405464c9f281156bd87 (tcp: get rid of
>> > sysctl_tcp_adv_win_scale)
>> > Author - Eric Dumazet <edumazet@google.com>
>> > Link -
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D
>> > dfa2f0483360d4d6f2324405464c9f281156bd87
>> >
>> > Performance data for (Linux VM on ESXi):
>> > Test case - TCP_STREAM_RECV Throughput in Gbps
>> > (for different socket buffer sizes and with constant message size - 25=
6B):
>> >
>> > Socket buffer size - [LK6.5 vs LK6.6]
>> > 8K - [8.4 vs 5.9 Gbps]
>> > 16K - [13.4 vs 10.6 Gbps]
>> > 32K - [19.1 vs 16.3 Gbps]
>> > 64K - [19.6 vs 19.7 Gbps]
>> > Autotune - [19.7 vs 19.6 Gbps]
>> >
>> > From the above performance data, we can infer that:
>> > * Regression is specific to lower fixed socket buffer sizes (8K, 16K &=
 32K).
>> > * Increasing the socket buffer size gradually decreases the throughput=
 impact.
>> > * Performance is equal for higher fixed socket size (64K) and Autotune=
 socket
>> > tests.
>> >
>> > We would like to know if there are any opportunities for optimization =
in
>> > the test cases with small socket sizes.
>> >
>>
>> Sure, I would suggest not setting small SO_RCVBUF values in 2024,
>> or you get what you ask for (going back to old TCP performance of year 2=
010 )
>>
>> Back in 2018, we set tcp_rmem[1] to 131072 for a good reason.
>>
>> commit a337531b942bd8a03e7052444d7e36972aac2d92
>> Author: Yuchung Cheng <ycheng@google.com>
>> Date:   Thu Sep 27 11:21:19 2018 -0700
>>
>>     tcp: up initial rmem to 128KB and SYN rwin to around 64KB
>>
>>
>> I can not enforce a minimum in SO_RCVBUF (other than the small one added=
 in
>> commit eea86af6b1e18d6fa8dc959e3ddc0100f27aff9f     ("net: sock: adapt
>> SOCK_MIN_RCVBUF and SOCK_MIN_SNDBUF"))
>> otherwise many test programs will break, expecting to set a low value.
>
>
> This electronic communication and the information and any files transmitt=
ed with it, or attached to it, are confidential and are intended solely for=
 the use of the individual or entity to whom it is addressed and may contai=
n information that is confidential, legally privileged, protected by privac=
y laws, or otherwise restricted from disclosure to anyone else. If you are =
not the intended recipient or the person responsible for delivering the e-m=
ail to the intended recipient, you are hereby notified that any use, copyin=
g, distributing, dissemination, forwarding, printing, or copying of this e-=
mail is strictly prohibited. If you received this e-mail in error, please r=
eturn the e-mail to the sender, delete it from your computer, and destroy a=
ny printed copy of it.

