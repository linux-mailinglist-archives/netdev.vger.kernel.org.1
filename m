Return-Path: <netdev+bounces-112989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D2093C201
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21741C20BD1
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7A2199EB7;
	Thu, 25 Jul 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/xdkgA3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856A1428E5
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910480; cv=none; b=u3OwMcEI4/rI4JpB1+UcjZAC86xMUUkhgS+NUq2rSfUTncDGKR5rbS11TvkIRrgqFIdtJ7hdQ7BrH5fG6JLajdIcuZtafsV2Dnz/FsTrN/bDWEmFM9aSbG77GNdaug3qh7Oi/PebANFRM5zQ7kI/SNcsQIuBxdc3GeibVTLyS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910480; c=relaxed/simple;
	bh=bYfTJU5J3Xf7irM5LsWIHFhtBBuZJjmB0SNRjxdSLBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlPOOl7LmcCHX6O2Pxmc1BlJGtd2B5YhwfwZohUTGGCiG8GY1zXZMmfZXDBYQ8H1uiHpPU/fd1SZCsBYKSH60l3hfam0uGVaRQJRI82caS8m2mParvfoI/HIqQZ1OTO3ArXZOmbU8IHbqwEBTdKpBybeONP9uKsRowv4HuI0NVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/xdkgA3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721910477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=valU9uUKvIoSYUW1dOd+x8hjHVmEom8zV+x/SaQos/c=;
	b=b/xdkgA3XRsvqH0hcapJdejqdmoQKxFZxTaRL6kRwXtj1x5h5oNubNxi2KDkwUr+OHAJW3
	HqcxVwWdwxA5Zo06O+6Ly5uv50v5jhBnprEGL80I8S5aTPUEPp/l/XbKvSf4s981naBmC0
	ViTubqTyVWE8/yN8s6TesMbgXq5OZqo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-D6wtxDMdORu8tJIDJOmSMQ-1; Thu, 25 Jul 2024 08:27:54 -0400
X-MC-Unique: D6wtxDMdORu8tJIDJOmSMQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-66af35f84a3so25682627b3.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 05:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721910474; x=1722515274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=valU9uUKvIoSYUW1dOd+x8hjHVmEom8zV+x/SaQos/c=;
        b=pH/X1FbAuXIk8ilheF9yFCFuuS4LnpzMpmFAQh6l25SOCh3M/zzHB19mJtqq6YfpxS
         mw6Vwf37efAa8/sxsZtp1TMW9mOMYYV8w9gXBuzGE0gZa5JRTLi2YyMpBRMwiIeCMVv8
         5wAboRgOB0Yamayst4IDNzg4sKyOONvtbEMkJA+CmL5TsVkr2vLQ3u8/d6siqtzIKXCn
         83LhXeCC5Vt7wqriW80D+4EAa5/MGgzMa3VyhWvp6uLnIwTGDs0PVoW5UneT66H/AdN9
         hhFCQ9jGF5agd9A9gzieAGclOYZ2wz5N5OOZq97Qw4BukFC5R7vZ1UFs80GaLvI2tqnZ
         p0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp/5sSvKbPv2/LBdTkTTUvjTG+pXkynCfYmNNxBKMQq0xPdjTtsYGoDUpE61J9m4Fe5dhSzv70PxJmQ/WI4zck61Kc94yR
X-Gm-Message-State: AOJu0YwDmOA333RN0DplMt4rQuUuli0gXdlq7dwq5XCt4BIQwMficV7Z
	RdhnRrAQfkcVuS4J/iJZhHGaLC55C3tLbp0qf1ev95B3yMh1B+Njc0CEn+zcIcHD0Dlapur1Hpv
	65afSqTyo0J5rhmuNIrwQrTWCnALZxGEeTZmN0P3JrOcq9X07uS6cwFvq+bfjPy+LVdRmNMsnNd
	PMh+Tn1dEF0aYz6c80WPf46uSeEtoy
X-Received: by 2002:a05:690c:660e:b0:65f:cd49:44a1 with SMTP id 00721157ae682-675b9e4fed9mr20001277b3.22.1721910474143;
        Thu, 25 Jul 2024 05:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwfhOFKdYQHB23Bh2erfYZQ8hsK7ZBQwiqtto4T1nCTiJ2mBqudhVqOYcqhJlMSXSROfevyjivclJTD+EgSgc=
X-Received: by 2002:a05:690c:660e:b0:65f:cd49:44a1 with SMTP id
 00721157ae682-675b9e4fed9mr20001097b3.22.1721910473811; Thu, 25 Jul 2024
 05:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net> <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
 <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com> <2f8dfd0a25279f18f8f86867233f6d3ba0921f47.camel@nvidia.com>
 <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com> <87v80uol97.fsf@toke.dk>
In-Reply-To: <87v80uol97.fsf@toke.dk>
From: Samuel Dobron <sdobron@redhat.com>
Date: Thu, 25 Jul 2024 14:27:43 +0200
Message-ID: <CA+h3auNx4jTALyhYAm9w6xaObnTvyCAMp7pNTOym5jcX5rJz=A@mail.gmail.com>
Subject: Re: XDP Performance Regression in recent kernel versions
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"hawk@kernel.org" <hawk@kernel.org>, "mianosebastiano@gmail.com" <mianosebastiano@gmail.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Confirming that this is just mlx5 issue, intel is fine.

I just did a quick test with disabled[0] Spectre v2 mitigations.
The performance remains the same, no difference at all.

Sam.

[0]:
$ cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
Vulnerable; IBPB: disabled; STIBP: disabled; PBRSB-eIBRS: Vulnerable;
BHI: Vulnerable

On Wed, Jul 24, 2024 at 5:48=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Carolina Jubran <cjubran@nvidia.com> writes:
>
> > On 22/07/2024 12:26, Dragos Tatulea wrote:
> >> On Sun, 2024-06-30 at 14:43 +0300, Tariq Toukan wrote:
> >>>
> >>> On 21/06/2024 15:35, Samuel Dobron wrote:
> >>>> Hey all,
> >>>>
> >>>> Yeah, we do tests for ELN kernels [1] on a regular basis. Since
> >>>> ~January of this year.
> >>>>
> >>>> As already mentioned, mlx5 is the only driver affected by this regre=
ssion.
> >>>> Unfortunately, I think Jesper is actually hitting 2 regressions we n=
oticed,
> >>>> the one already mentioned by Toke, another one [0] has been reported
> >>>> in early February.
> >>>> Btw. issue mentioned by Toke has been moved to Jira, see [5].
> >>>>
> >>>> Not sure all of you are able to see the content of [0], Jira says it=
's
> >>>> RH-confidental.
> >>>> So, I am not sure how much I can share without being fired :D. Anywa=
y,
> >>>> affected kernels have been released a while ago, so anyone can find =
it
> >>>> on its own.
> >>>> Basically, we detected 5% regression on XDP_DROP+mlx5 (currently, we
> >>>> don't have data for any other XDP mode) in kernel-5.14 compared to
> >>>> previous builds.
> >>>>
> >>>>   From tests history, I can see (most likely) the same improvement
> >>>> on 6.10rc2 (from 15Mpps to 17-18Mpps), so I'd say 20% drop has been
> >>>> (partially) fixed?
> >>>>
> >>>> For earlier 6.10. kernels we don't have data due to [3] (there is re=
gression on
> >>>> XDP_DROP as well, but I believe it's turbo-boost issue, as I mention=
ed
> >>>> in issue).
> >>>> So if you want to run tests on 6.10. please see [3].
> >>>>
> >>>> Summary XDP_DROP+mlx5@25G:
> >>>> kernel       pps
> >>>> <5.14        20.5M        baseline
> >>>>> =3D5.14      19M           [0]
> >>>> <6.4          19-20M      baseline for ELN kernels
> >>>>> =3D6.4        15M           [4 and 5] (mentioned by Toke)
> >>>
> >>> + @Dragos
> >>>
> >>> That's about when we added several changes to the RX datapath.
> >>> Most relevant are:
> >>> - Fully removing the in-driver RX page-cache.
> >>> - Refactoring to support XDP multi-buffer.
> >>>
> >>> We tested XDP performance before submission, I don't recall we notice=
d
> >>> such a degradation.
> >>
> >> Adding Carolina to post her analysis on this.
> >
> > Hey everyone,
> >
> > After investigating the issue, it seems the performance degradation is
> > linked to the commit "x86/bugs: Report Intel retbleed vulnerability"
> > (6ad0ad2bf8a67).
>
> Hmm, that commit is from June 2022, and according to Samuel's tests,
> this issue was introduced sometime between commits b6dad5178cea and
> 40f71e7cd3c6 (both of which are dated in June 2023). Besides, if it was
> a retbleed mitigation issue, that would affect other drivers as well,
> no? Our testing only shows this regression on mlx5, not on the intel
> drivers.
>
>
> >>> I'll check with Dragos as he probably has these reports.
> >>>
> >> We only noticed a 6% degradation for XDP_XDROP.
> >>
> >> https://lore.kernel.org/netdev/b6fcfa8b-c2b3-8a92-fb6e-0760d5f6f5ff@re=
dhat.com/T/
>
> That message mentions that "This will be handled in a different patch
> series by adding support for multi-packet per page." - did that ever go
> in?
>
> -Toke
>


