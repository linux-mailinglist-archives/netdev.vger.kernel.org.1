Return-Path: <netdev+bounces-151089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB23B9ECD14
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3273167B54
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F019F229151;
	Wed, 11 Dec 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJBp+A2S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321323FD18
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923231; cv=none; b=Wd0vEXSIx2D1JlanFBA04w2CJr16r4X53BG6zHK5/34umXr4uKrZ1crUPMGmGnEuuQ40IDf+J2w53U6qTIuhA+7ZEQ+P5J/Ty0QTF98VpFT1qzzxQ/cW9vpFoIiqfAqQQePfHqnP56rMYx9tCDWkvwB8FIkXDXjYX+xHAsoFXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923231; c=relaxed/simple;
	bh=czuEY77JCZPstMaLM63oJZzbj6XrhHUBcn36oBhySws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7/FpLzEBROKarTKL3ClHipvB8EPQq9IRHp/1EKZd/VgpEIAYDK2wfRIyvP+AsDqhwm6LRYa3/FzIqs36x96ex2EZJCONuoKvMk+WyQjqf8Odk4qkjRHD9bru+Ig62Rk1ldhkYjJcxYhRtN8+RO7YtwdZ9BEPH/BBsGpaD/IVXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJBp+A2S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733923229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czuEY77JCZPstMaLM63oJZzbj6XrhHUBcn36oBhySws=;
	b=YJBp+A2SAUSZwiciD1tXWKljLXay2B6Glra0sKk4lULEQN/fVtUMtIS/DcR4CqQIi6Kxmm
	u+jsAY4wWOS5qe/EvF2FmzO1Hb+K+FmfGzmD2sYApEz1efQUdKBKJ7yWuw7akWiWdrzJ3x
	m2nEeTDNwH6vwW166F56lj3HgB/ShEU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-flcavVW3PAaIjMR4Evm7oA-1; Wed, 11 Dec 2024 08:20:26 -0500
X-MC-Unique: flcavVW3PAaIjMR4Evm7oA-1
X-Mimecast-MFC-AGG-ID: flcavVW3PAaIjMR4Evm7oA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d87d6c09baso119200136d6.3
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 05:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923225; x=1734528025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czuEY77JCZPstMaLM63oJZzbj6XrhHUBcn36oBhySws=;
        b=Gbo/CRYkE/qa5yRqwmdBqQZlyrUwqqWTcJn9Qo0sMadg7c1PuBqR+YZn8rNlOKdkzi
         xW7RZPG/Hg9J2L89du3i+Rlz3umZ0G2im4bHS6nMxnsMIrgTfCLSBqK5Pr4jDDl7Sl3/
         UiU7Scasno/QyZ9rsjc9InqWcE5feZ7MNnoTb8kT3X67Gst4kTtQ/Lnvf0xRsuqPPlSO
         Bgsuqj9ClqgsJGXIziHsmoLou7DpuoQoAujdg3mqd//vI3ZRe3mhIb/j2LyEreK1700z
         dh7wcwLFIU2+PhDJFWLuGkdFT1wJUQ0jDOxIbqKQSbQ2DbaiOptw3GRHy9FcqUVyPWC2
         MzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4546jlUpFvLG9/XPv2DMG1bbuzJfP+l/yRTdUlLaXI1OrDcdLnV7+ZTbdIEtqRUIccVF/tCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZQbiAdLiql4D9rF7bKdLcnKV6JKSzIwaiVlBe29ExrGOAbcD
	U6/OV3uXMo8GdYgLqNgjnrlbmmquvNBAJ+h5BzMEaokuqVecrWGbTWNaBDW3GexalP7iP7tSCX2
	Qc55RfYa1bPyr8H+O8qlAXp/7/HE+3fkRgAuj/9xBHZ4oLv4r546Ogd0ZvUW+lCOGcYAkD7ixnT
	yKF90jaYFEnIYtFAO4UeIjLP9Iwytk
X-Gm-Gg: ASbGnctKvZjMa9COiip2wX3us5swB0CyiLX/Kdqv5wpWDOOFTeOJZygpMrgMHz7rgZp
	rTm0ekxrXQv7ikZq0NtPVDSXsu02jAgVGg54WSDcNOtrMu/JXVAD8ulWEoIlfERo1OUGemQ==
X-Received: by 2002:a05:6214:ca5:b0:6d8:aa04:9a5d with SMTP id 6a1803df08f44-6d9348d2142mr46799306d6.4.1733923225598;
        Wed, 11 Dec 2024 05:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG883jmPVlNDMql0MfElEuVFNmIdnEfS+mjFs8E85duJCJ5UK2bNaU7F3/+T5MmFm/rBUpyG4I3beqd4Jy2Wno=
X-Received: by 2002:a05:6214:ca5:b0:6d8:aa04:9a5d with SMTP id
 6a1803df08f44-6d9348d2142mr46798926d6.4.1733923225372; Wed, 11 Dec 2024
 05:20:25 -0800 (PST)
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
 <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com> <03c24731-e56f-44b2-b0a3-6afd7f14f77b@redhat.com>
In-Reply-To: <03c24731-e56f-44b2-b0a3-6afd7f14f77b@redhat.com>
From: Samuel Dobron <sdobron@redhat.com>
Date: Wed, 11 Dec 2024 14:20:14 +0100
Message-ID: <CA+h3auPydMVmWRKPKQJ75Gg5c8uhttVik4seCtmPXduQxQSjMQ@mail.gmail.com>
Subject: Re: XDP Performance Regression in recent kernel versions
To: Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"hawk@kernel.org" <hawk@kernel.org>, "mianosebastiano@gmail.com" <mianosebastiano@gmail.com>
Cc: "toke@redhat.com" <toke@redhat.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, Benjamin Poirier <bpoirier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey all,

We recently enabled tests for XDP TX, so I was able to test
xdp tx as well.

XDP_DROP performance regression is the same as I reported
a while ago. There is about 20% regression in
kernel-6.4.0-0.rc6.20230616git40f71e7cd3c6.50.eln126 (baseline)
compared to previous kernel
kernel-6.4.0-0.rc6.20230614gitb6dad5178cea.49.eln126 (broken).
We don't see such regression for other drivers.

The regression was partially fixed somewhere between eln126 and
kernel-6.10.0-0.rc2.20240606git2df0193e62cf.27.eln137 (partially
fixed) and the performance since then is -7 to -15% compared to
baseline. So, nothing new.

XDP_TX is however, more interesting.
When comparing baseline with broken kernel there is 20 - 25%
performance drop (cpu utilizations remains the same) on mlx driver.
There is also 10% drop on other drivers as well. HOWEVER, it got
fixed somewhere between broken and partially fixed kernel. On most
recent kernels, we don't see that regressions on other drivers. But
2-10% (depends if using dpa/load-bytes) regression remains on mlx5.

The numbers look a bit similar to regression with enabled spectre/meltdown
mitigations but based on my experiments, there is no difference with
enabled/disabled mitigations.

Hope this will help,
Sam.

On Tue, Jul 30, 2024 at 1:04=E2=80=AFPM Samuel Dobron <sdobron@redhat.com> =
wrote:
>
> > Could you try adding the mentioned parameters to your kernel arguments
> > and check if you still see the degradation?
>
> Hey,
> So i tried multiple kernels around v5.15 as well as couple of previous
> v6.xx and there is no difference with spectre v2 mitigations enabled
> or disabled.
>
> No difference on other drivers as well.
>
>
> Sam.
>


