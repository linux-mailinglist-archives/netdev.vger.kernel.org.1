Return-Path: <netdev+bounces-132337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35699145F
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 07:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C4F1F22D56
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 05:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2228B3A8F0;
	Sat,  5 Oct 2024 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKbmcDjY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E4D482DD;
	Sat,  5 Oct 2024 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728104403; cv=none; b=Jh/utUL8EbkWtaVQOQUTEt3NqzW/XtkdrNMxDG7v5uHH3oDlpAsY0HW63QDgD3obqCAnq01kK/Z3rZU7EYr6ufrEd+UuDBpiNTGNi9uATjXxSt29By1Wdnm6tFsn53N4UmrC3QPsDqL23Wi2esUrJihVR5Qcyz3dQ+p6gtfb+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728104403; c=relaxed/simple;
	bh=lIOE/yRfQp/Rn8/qsEKgHzqsUbQ0OcTNR8yMD3zE2b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLeoxKSfltwupiOzaGfdLJMfPZS1HK5u0Bdm7IdimloZydQYsVgaiYj4m0q54fmmcxq/p/6VuaI9o6g1jeCcQcv2MD3NvRcKa1UmloIpgeXhO1jYG7NL2WNFuZeiPY0SKhul0SnD5tDQXv8aWSCZgKHs7k+xL6KsWphavHvYd6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKbmcDjY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e232e260c2so24019997b3.0;
        Fri, 04 Oct 2024 21:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728104399; x=1728709199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMpsL1cnzxmXFIA6ll85qqVqaSDBnUMH2E0nz8ladkE=;
        b=EKbmcDjY74kS8eRl7WegNyUTllCagDLppeDogaX/ANp0qk9KPa1vEgwgkE24xXNM1D
         +ARz8/fw/9qIqhSniAWLM1yTQzcpb3tmT1b+XWW5GkkCxP7Z9Mdy68bQrjwf6JJPeJaC
         dHe5NGnVcPTvrLe7HcDsxW9EJBhSG8jS0J9V5nyvW71gW6Hibwkchd6+oCBJpQ3rUvO8
         06YDBC7tApYYi4jc1LwplAlXVSq4w5rah0G4WNfCqvkXZhEBDPP1ZLkNKE0KxIMcQJGT
         2cIcW5n4iYpIFnFXTX8HTYLbvMRk2CiIdHZ5mrM0pPuCZ8IzJSvs5A/+Ud7Wqu9528B3
         MJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728104399; x=1728709199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMpsL1cnzxmXFIA6ll85qqVqaSDBnUMH2E0nz8ladkE=;
        b=AaCNfbpZYHQiSbbf12GhD01JswAMFZ5dv4I+Mj0GRLQWmeSH+9Z0LnzXI0b8KkDOqb
         146jEUSeUFDxzuoJDogymHS0UrgvxyE+2EDEnl/L+H0WVig/ZxN44OTWSckwEhEi9/Oj
         tmQ/ImDSBXnwCrsbfoHS+NuLKDG9RJiICf2zOwufMy/uggX0+Tl6lh/mnbnHL0TvFlpm
         VbDQObOnDTa4iZztD9heTKKyCby/QRywNrrVP/RGUrpqRWJOdXYN1kHoVscGnddbwdcd
         0cg8tetjdAeeBjS1/CkkhK57O+mob4H4Ff8DzysO9/1eORuubAVWnAdkuPOmJTmxpq1J
         18AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbbBfq2DsMVsUZJRrvA8EkgGrItZMtBHbyrXOJbWW7sKjf/C3tPIeww9mYnDt3Ubss1q7K8tI2@vger.kernel.org, AJvYcCXepO0q86jD64RGUr4IiSnn0PuYX121MRCUWR5SR9koELxjSSpTh2UEp3d1sFUbm75nUFxvwbKkImxkTrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gDWbhFsgq55tw97kfc5tjhHMTL18p17ooqY8OBipyV40/5mv
	G238br6fdPOD1L9pk1oerk8feimnQfwXs6+a9UGsD41N1XZ/+u2iL3EYr2eQ9LBN3CDU9yyb2tY
	ILcT2DrJVtqouJwm6s51a7i87+FY=
X-Google-Smtp-Source: AGHT+IG+K1H6MIwPFK23MPAWTkPxiLXXn6+MP1Q9aaSR1Fn20scv3QHwNqJLgnIOdQYc/xAZ2S5Ymx9CkFSZQv4MI94=
X-Received: by 2002:a05:690c:fc2:b0:6e2:1864:cf14 with SMTP id
 00721157ae682-6e2c6fc6828mr50272027b3.8.1728104398939; Fri, 04 Oct 2024
 21:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002053844.130553-1-danielyangkang@gmail.com>
 <CANn89i+y77-1skcxeq+OAeOVBDXhgZb75yZCq8+NBpHtZGySmw@mail.gmail.com>
 <ff22de41-07a5-4d16-9453-183b0c6a2872@iogearbox.net> <CAGiJo8TaC70QNAtFCziRUAzN1hH9zjnMAuMMToAts0yFcRqPWw@mail.gmail.com>
 <CANn89iK7W1CeQS-VZqakArdZqZY6UQi2kCDcpUmL4dGjAQwbCw@mail.gmail.com>
In-Reply-To: <CANn89iK7W1CeQS-VZqakArdZqZY6UQi2kCDcpUmL4dGjAQwbCw@mail.gmail.com>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Fri, 4 Oct 2024 21:59:23 -0700
Message-ID: <CAGiJo8QU81+oLG+s-c2dUsQ_+4csaKEv6xmt=yJrA2gZ22ZWXw@mail.gmail.com>
Subject: Re: [PATCH] Fix KMSAN infoleak, initialize unused data in pskb_expand_head
To: Eric Dumazet <edumazet@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:56=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Oct 3, 2024 at 6:42=E2=80=AFAM Daniel Yang <danielyangkang@gmail.=
com> wrote:
> >
> > I took a look at https://www.spinics.net/lists/netdev/msg982652.html
> > and am a little confused since the patch adds a check instead of
> > initializing the memory segment.
> > Is the general assumption that any packet with uninitialized memory is
> > ill formed and we need to drop? Also is there any documentation for
> > internal macros/function calls for BPF because I was trying to look
> > and couldn't find any.
>
> Callers wanting allocated memory to be cleared use __GFP_ZERO
> If we were forcing  __GFP_ZERO all the time, network performance would
> be reduced by 30% at least.
>
> You are working around the real bug, just to silence a useful warning.
>
> As I explained earlier, the real bug is that some layers think the
> ethernet header (14 bytes) is present in the packet.
>
> Providing 14 zero bytes (instead of random bytes) would still be a bug.
>
> The real fix is to drop malicious packets when they are too small, like a=
 NIC.

Interesting. Thank you for the clarification.

