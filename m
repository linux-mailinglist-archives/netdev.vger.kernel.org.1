Return-Path: <netdev+bounces-234350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A48FEC1F8F3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF8594EB5AF
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108F355037;
	Thu, 30 Oct 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htPn6Ax/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55845351FBF
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820138; cv=none; b=j9ODMAYJrr2FtpJsyaVya8+tuOFsl1041aaBqLzX2pjBSG9DFSxdBNHOn2SIIHhekZbm6IZGcteJm7S0cE9zDZehn0EB9G/3M+u4aZg1v0iftmaJfYXiMoUJkwvGBt+JwURy+hbjsL8QavYgx+9M4Z9MNr5yErIr0LAn8o/Y8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820138; c=relaxed/simple;
	bh=jNBoWYaJyXehjfJui6hBOb2eVdvz/N6C+xIxssWLtWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rny3tP3UNQlMKXouV2Cf2YcV3FD3sF8jvDPMXg46AEqu4ndUfDOEmYH1ysbsjk6VNluiVu//++155EExa7763EndOSKhSTZJCUsSlFX9ZLaQntE1x7Ntccn7MF5UitMQgzUOSkqAVwToFQ7EKeWRVLWTMncM0minUSQj/C1NKBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htPn6Ax/; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-430c52703b3so7998565ab.1
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 03:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761820135; x=1762424935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjigA2w1+8bqCkfLQcxmjCEh/gZYzzclBBO4UhUv1Os=;
        b=htPn6Ax/aHlm8UON0DWReBG0fj50YkfX2N6U5sMnaGza7uLZDsvpOp6uWYJm+vX5r3
         /iw3KB1o5ZlKZ4iIP4vr2g+tk4vvUVExnEMC/WWXIdnGwgV9A5d5568sNs5J2RSvzkVD
         gcuDGXgvERRqQNwaHrDzGvaNxpHcN6R/EaOn+RReMTjjTd94597vPXSRw7Qi9isCZcqR
         1tBXZ8KFPIL43gfA8WNL2eID8ekrsO2VGPIYIQsTFPTtrGpkRn/uCWY7ciA7OY7sbuhs
         r3JBOczByxBVwXXxuj/bb/QS5snENAyss3FObHDiCXzpqRhgcNPgKG2xEyqZS7Pd1P4b
         alCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761820135; x=1762424935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjigA2w1+8bqCkfLQcxmjCEh/gZYzzclBBO4UhUv1Os=;
        b=Z/gexY4oY2eIO4FhhHG14dh5LjrOORILvEbEJwMn4EqVzv/HlKzOY/BwI7joIdYrGT
         WNgHqUBr0RmKDpf3ocvbauRasS5l1QqS27t3x6A5Idzc9rfA/9IGiE+Rz/x6tRRvCzgS
         R2a61w1jHrkJy7nG6bKUi2GSgTmBzbsBlaevnOAfl06RWFc/kPz1p6Ai5gHqJhlFiG3d
         UbNicPuE17JVCUQMAI5y9h+NV9Yqi3SnVv9id6iXBfw8hb5XLYQHWutrFqP4/vmqdV80
         ghKuVif3Czq4t+38Yz3d/Rqf/pp/pKJtDoI/1twuT0SzrlcTURQVTLz24boIoe21KjPx
         EeXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUWQ1ePXTWOOLr7O5IakIMShEX4kaZDM1Gx0LOIxuMYi49JLHFPbNATRMONdOxgOJ2/dTvjI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+YC9S3/XTPJrYtqTR21co3eSNh7LxZQQvPfM67bOjzWxB+l0
	YdHTnGkfL0W4O9+MchpLqU2CcRN6hRiY3+kE+osmgUQLtwJ/FMh1YhWvUH+Ft7ui2tes6aj222D
	Eq8iAQVQM8SSnUVrZU8SjPpCfKhsG9QM=
X-Gm-Gg: ASbGncu85EnSkVbrlR0QvsDWJf4bUZXGUhDbGLeaV4gHjRQ25e3FKCOMdeKxAhxo8v9
	pCXh3MjVjMdgHUnJQXfyl5xUEne7ErEjZ2egG18CnY+urT64OWC1cjhADjEpIbY+k93OeplSSJ5
	GW68K04ftDjKf+DFiGJwDqWoM32jQqGpifTwjnzxRVxXgAtKEb+F+1YIu6xWM1mo9hgIVs/65qb
	b++w+MbCNgwq+mX4AZwC8TWnVmvyGdcZZyZFdfNlWd5eKSiVl/vRtlTsZz5h1CmOBwn2vBDVfNi
	zJh51g==
X-Google-Smtp-Source: AGHT+IECoV3waLMBGW2VDD/GhN0MHNi5SgzaN95ahLWIpxZ39GGeEd2gaiibvGhbBYXakXaddVVs0NWE+UX8+u/LWo8=
X-Received: by 2002:a05:6e02:2385:b0:42e:2c30:285b with SMTP id
 e9e14a558f8ab-432f902b4afmr77878175ab.20.1761820135381; Thu, 30 Oct 2025
 03:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026145824.81675-1-kerneljasonxing@gmail.com> <54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com>
In-Reply-To: <54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 30 Oct 2025 18:28:18 +0800
X-Gm-Features: AWmQ_bmQi8GJMMAdtPGC0goZLlXFuCJ4nTdiqFQ0gnXknrj3Q3iOMn21WQjOVi4
Message-ID: <CAL+tcoDLLqr5q-hvcu0PapnMUwjsewwQjmACG3h3SRWEfSRhYA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/26/25 3:58 PM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Since Eric proposed an idea about adding indirect call for UDP and
>
> Minor nit:                          ^^^^^^
>
> either 'remove an indirect call' or 'adding indirect call wrappers'

Oh, right!

>
> > managed to see a huge improvement[1], the same situation can also be
> > applied in xsk scenario.
> >
> > This patch adds an indirect call for xsk and helps current copy mode
> > improve the performance by around 1% stably which was observed with
> > IXGBE at 10Gb/sec loaded.
>
> If I follow the conversation correctly, Jakub's concern is mostly about
> this change affecting only the copy mode.

Copy mode is worth optimization really. Please see below.

>
> Out of sheer ignorance on my side is not clear how frequent that
> scenario is. AFAICS, applications could always do zero-copy with proper
> setup, am I correct?!?

In my env, around 2,000,000 packets are sent per second which in turn
means the destruction function gets called the same number of times.

>
> In such case I think this patch is not worth.
>
> Otherwise, please describe/explain the real-use case needing the copy mod=
e.

I gave a detailed explanation in the cover letter [1]. The real use
case from my side is to support the virtio_net and veth scenario. This
topic has been discussed in the version 1 of [1] and Jesper also
acknowledged this point. I also noticed that there remain some
physical nics that haven't supported zerocopy mode yet and some of
them[2] are still in progress.

[1]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gma=
il.com/
[2]: https://lore.kernel.org/all/20251014105613.2808674-1-m-malladi@ti.com/

Thanks,
Jason

>
> Thanks,
>
> Paolo
>

