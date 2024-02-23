Return-Path: <netdev+bounces-74384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243A4861211
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90251B2601B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5037E103;
	Fri, 23 Feb 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNqFWEER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8F11CB3
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693130; cv=none; b=D9LKbYNm9czqMHm/YDFBwQoxlJprDOYQcOi51dVzl5VtJPNAFTejmz9J5FdXfXAX2FtalP4KBJadhPnmAWmNN8BXy/qKz+XJ120GrtfB9Z+8tjHpBa6QownTyumXEkjstjrGBIkknyUQ4vMub4PXx5D1tjWBNcckebTCZkrq5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693130; c=relaxed/simple;
	bh=nSAYy2+qETkVsfK5K16TiWVtQ3PRNHBQQJQ8KGcFEfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=El6hoZFLjo0F+ZoVFroBVPF0O4RdRSlWQ7yDfLazZMwgHHP798C2QaTMmXP0AWEG+cYL9JaeWMiJy4IWajyH3SZGK+BpghHVqo0LeScz8VkQ+JC9rjrKsaIPFrwDeMTzdfjCYttxcKbSvlIGjfmiyilrJEsRIgI7OdyOeDq2LnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNqFWEER; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41298159608so144895e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 04:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708693127; x=1709297927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX+vqShChtMKdsDnzexcCdxHR+sDTB4qDQQmS3Eg6G0=;
        b=XNqFWEERBWjY7isDirCoYUcVoHujoArg1QVYdcdfNHdxkz8HXz/9ToyTK50PbFllkO
         xEYU9r6Ioo0qEcA6rZbxq5tjfb5DXU40Z8m4QAxSPsLWgQLcIwDwUYBg8odSXGuzjE88
         q6QL1XsIMZGxPQvlmL1d9snovhNo24m+MfIZ6NFan2LemA42vSnHVyDLc6YWKmYSW11n
         MiJGitpvUFmD+dlyo8SwMoNi54GzE3sAMKBAWTZxtyCbIS5iDyjZ5I80ix/a/eAyxRAb
         fj+mDweJn44Nm4AQyHmC8LGhgDFguCLT31UgzOizmBDStb6z1otIc2gchje0+LxbXQpo
         jUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693127; x=1709297927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kX+vqShChtMKdsDnzexcCdxHR+sDTB4qDQQmS3Eg6G0=;
        b=IdACO0ONKq/AYTavP4xnNHs0CQKTbAmtp5RnsjxdvS0K9gY91sufr3WwS0VLWLkD+U
         tlr5nOKGWfuPkJOMKkMZgk5x/vQHaLX6IcpRQxrWXDX9B65SnCBTsy3SghcvEhekdUwH
         dRGVkmQcINHwcFTsHafUWmZk1q5dTEiTK5LIeiUYVJ9PrjoEJojbz41d0Y5zYqcbBN7v
         FDUio+dsg7IWm7Pn3tGZTzlD3cMTIUoAgvi0NOmk20KeT6fZ+uy2jFLrbp60TlLfjKJ9
         sI5kw+xPn7t/vo9VKH+bnWJ4Jly94+h/PYUdcWhyGEAuE5lnvcwFgurFC3IcAtKC8lvE
         FXqA==
X-Forwarded-Encrypted: i=1; AJvYcCVNmai7q3TG80gxDCzsqsghPqlk+rjINJrBdzolVaM6t/Cv2S0twQ9bdV4UZ3KSZq0fpKknp77xC/lfllRh51Nl9OwB0vWx
X-Gm-Message-State: AOJu0Yx1/byE1UK2mACbeK5HphzGD5CUSb3TpvMe/Z/kJJtsYzzzsiAv
	gR3oaROzEh/HrgjQi1/MIugUmnwQ+yxgAb3B9z+lTtO3f2VGFdUa4EORrY9w9djDSycV7wTTxrj
	OkEfXTQb2kHH+jQyAdQII2zNg0Ek=
X-Google-Smtp-Source: AGHT+IE7ZHT5OnqBXBQIZOphHFPGho2h2iKKk8DidGKYd4j97qJtsCk4vijGpFA4/GDGk2iVf1netsREu60rdcvI600=
X-Received: by 2002:a05:600c:4f8d:b0:412:96e8:fc21 with SMTP id
 n13-20020a05600c4f8d00b0041296e8fc21mr784569wmq.18.1708693127090; Fri, 23 Feb
 2024 04:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1708678175.1740165-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1708678175.1740165-3-xuanzhuo@linux.alibaba.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Fri, 23 Feb 2024 07:58:34 -0500
Message-ID: <CAA93jw7G5ukKv2fM3D3YQKUcAPs7A8cW46gRt6gJnYLYaRnNWg@mail.gmail.com>
Subject: Re: virtio-net + BQL
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, hengqi@linux.alibaba.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:59=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Hi Dave,
>
> We study the BQL recently.
>
> For virtio-net, the skb orphan mode is the problem for the BQL. But now, =
we have
> netdim, maybe it is time for a change. @Heng is working for the netdim.
>
> But the performance number from https://lwn.net/Articles/469652/ has not =
appeal
> to me.
>
> The below number is good, but that just work when the nic is busy.
>
>         No BQL, tso on: 3000-3200K bytes in queue: 36 tps
>         BQL, tso on: 156-194K bytes in queue, 535 tps

That is data from 2011 against a gbit interface. Each of those BQL
queues is additive.

> Or I miss something.

What I see nowadays is 16+Mbytes vanishing into ring buffers and
affecting packet pacing, and fair queue and QoS behaviors. Certainly
my own efforts with eBPF and LibreQos are helping observability here,
but it seems to me that the virtualized stack is not getting enough
pushback from the underlying cloudy driver - be it this one, or nitro.
Most of the time the packet shaping seems to take place in the cloud
network or driver on a per-vm basis.

I know that adding BQL to virtio has been tried before, and I keep
hoping it gets tried again,
measuring latency under load.

BQL has sprouted some new latency issues since 2011 given the enormous
number of hardware queues exposed which I talked about a bit in my
netdevconf talk here:

https://www.youtube.com/watch?v=3DrWnb543Sdk8&t=3D2603s

I am also interested in how similar AI workloads are to the infamous
rrul test in a virtualized environment also.

There is also AFAP thinking mis-understood-  with a really
mind-bogglingly-wrong application of it documented over here, where
15ms of delay in the stack is considered good.

https://github.com/cilium/cilium/issues/29083#issuecomment-1824756141

So my overall concern is a bit broader than "just add bql", but in
other drivers, it was only 6 lines of code....

> Thanks.
>


--=20
https://blog.cerowrt.org/post/2024_predictions/
Dave T=C3=A4ht CSO, LibreQos

