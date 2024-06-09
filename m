Return-Path: <netdev+bounces-102102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B9E901707
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 18:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367D72814BE
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CDD45BE7;
	Sun,  9 Jun 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xfVxmBqI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAB2C190
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717951374; cv=none; b=oJIBQE5wz5OB7pItFTv/OLgspZmErj3SZjCZya28cistPCcn1HaIhEXiRK7Eql6CU7p+w1f+pDK9jG335tQbSKy4yiYAI3deGcIzwqI95tP3b4zgAxGiDTvS/WBj5feUHvXtNvK1eGmcMu7fQ1+FB2VaK6K2m6hmMqjXtXiGDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717951374; c=relaxed/simple;
	bh=8ZcKPZhiuQKiRjTyJvF8qz7oHwi08qYOowpblAxGNm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCE2voSsxM1bxWnTFivDIfBXy4WQZcXl9hXGJaqg6BRul4MWMcRcyVWZXlMQdRB+HZVKQht0iV4AkIBKpqezZCNvcoR0OpkhLwIuTsex9WAqsdsroHbbVPapZe5ihjKNdYddLJRcK/BAzuFv12QBttd6sQGUT6Yp5AQ6H/IsGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xfVxmBqI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c6cb1a76fso5988a12.1
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717951371; x=1718556171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZcKPZhiuQKiRjTyJvF8qz7oHwi08qYOowpblAxGNm4=;
        b=xfVxmBqI0M3DuXv6wmrqRzQT21/6ZrV3qjB8P76P210dIZUQ4jIJ8FsYHY4DxKykAj
         7cRz8Q6V6DJWhGSmBfD+jqpqTiSO3tqmBWzZwE3lPVM2g+5SsxElPGm6fkOJRHitkW5V
         bUVS33OQUeD553VDswsekY1aS0r4JsOVf1mHiTsXyUrbKrNoRqnUKekCTkoUy6fYSEho
         Gvco6NbcwQCkAH4kEtK4wbJSw/PM4sU11F2q3W3sir18BFDQ0EbxCL3qxQyehBKQIWB7
         q+AYVOcqvKvfdiTKzVPDWOXYE0GXr6NhJzKxIUTdM93zXji5zV8bWhJm6RRWjoyCkaCb
         oFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717951371; x=1718556171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZcKPZhiuQKiRjTyJvF8qz7oHwi08qYOowpblAxGNm4=;
        b=t8zrGz5Bwczcbssm2s9wGZD2v7saRI2E6KLwZTGc0uqie6F2Kjqji6HCAH3WWuz701
         wV5SpGuB9F3AmTPcx4BRN5mP5DFM8RCe7Aky8i36n+J7wYkV+PfCZpWkJ7lDN9w04Xte
         CYCPkFMbmUVW6gJTyvtGJW2MzwY/h38//2puSbG5oO1m6BcGPPRLTkjeWMN47fOGz3C7
         ta/RF5rKScL7pb2AK1DBMlgOtCvraAaNtvz6oCnhbJoWrKW6f3rxzNs9tD8a6VY7qFd0
         z4kp3gZZQ/KSbB3m3LQGZ1XOWi9yK3T2szEMDYGFqprBZttAydjnJdI4pAWEVs4pZrEZ
         Ksgw==
X-Forwarded-Encrypted: i=1; AJvYcCV+qGwyjABRoMASd+TfRIuinuV+FKtDgf42aVZ8GRMYJpUkQ/4d4EdQPucYL29DB1Ti1JQcCDtqDs+92UzO80j4uscoTIgx
X-Gm-Message-State: AOJu0YxVOaBwGAVOwEhYPtd1bzLhlYhz1t6KSl+N544sIQ5aJSLsdjQt
	g50yURmStMKQgb8/djPk1FNn1YWgD8HB/mkGv+IjccVC43h1xK7uHVyGc50W1+ogSGlKAJt14lX
	vk9u7k/d151fhM5ncVYluctYONO374uB1MRBL
X-Google-Smtp-Source: AGHT+IF48Ply5VDXvVLiVZMTQ29OIvrSLbCgzVATaq4udYJL3BB/hgPJGwNtI3c3SVMlaxVXayfk4F65rAhgiWWoGnQ=
X-Received: by 2002:a05:6402:3c8:b0:57c:6187:38fe with SMTP id
 4fb4d7f45d1cf-57c6a19154fmr263373a12.0.1717951370904; Sun, 09 Jun 2024
 09:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609131732.73156-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240609131732.73156-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Jun 2024 18:42:36 +0200
Message-ID: <CANn89iK+UWubgdKYd3g7Q+UjibDqUD+Lv5kfmEpB+Rc0SxKT6w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dqs: introduce NETIF_F_NO_BQL device feature
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 3:17=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
> BQL device") limits the non-BQL driver not creating byte_queue_limits
> directory, I found there is one exception, namely, virtio-net driver,
> which should also be limited in netdev_uses_bql().
>
> I decided to introduce a NO_BQL bit in device feature because
> 1) it can help us limit virtio-net driver for now.
> 2) if we found another non-BQL driver, we can take it into account.
> 3) we can replace all the driver meeting those two statements in
> netdev_uses_bql() in future.
>
> For now, I would like to make the first step to use this new bit for dqs
> use instead of replacing/applying all the non-BQL drivers.
>
> After this patch, 1) there is no byte_queue_limits directory in virtio-ne=
t
> driver. 2) running ethtool -k eth1 shows "no-bql: on [fixed]".
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

I do not think we want to consume a precious bit from dev->features
for something like that.

dev->features should be reserved for bits we used in the fast path, for ins=
tance
netif_skb_features(). It is good to have free bits for future fast path use=
.

(I think Vladimir was trying to make some room, this was a discussion
we had last year)

I do not see the reason to report to ethtool the 'nobql bit' :
If a driver opts-out, then the bql sysfs files will not be there, user
space can see the absence of the files.

