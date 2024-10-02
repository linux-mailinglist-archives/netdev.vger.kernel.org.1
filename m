Return-Path: <netdev+bounces-131136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44798CDE3
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 449C2B20A12
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD6155735;
	Wed,  2 Oct 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTlJT+I3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E337F484
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854912; cv=none; b=HdBi6sJr+pcqsRUNTUUbHeN9PVjCMykUp8fjzmkBU7zWunu9gWaBtlc021ack6+2Z/+xVItpz79St+1q2ip5xB+9qrRmTjffdlW8AzvJ6w8kZc5qDu1vqqD+oEUZHLTONnoCbrkX2eHu7MjH+XFpqf4hU7nvrN9pDk2kfhmNBFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854912; c=relaxed/simple;
	bh=xjyCU2SGnOjmA/lapxZ9rPT22fHfG1UM1l2gx7MXLJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7l+d04vSPFt8sdAQHWqwseKEOAtC4Smh55ox7MCLhFjgs5W/4W0AK84zTOYP3gjt7zqFT5nJPjTDGN22FeDHJfBQURzDdy5pxsZR1VNU8Vyw/Aavg3mXCzAARolK815PLyOPZMHBMFIJou70HtVhBGLXZfLlsEl7hlMRgi2iPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTlJT+I3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso1222616a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 00:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727854909; x=1728459709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNoAy+ad5EbGGJuz8cYM8mdPSgQIHfep8UZ15oOnw/E=;
        b=TTlJT+I3/kvnuG1jHV3RLANyKYq38YQPlXECsbgae3aqxSSNucKi+Vx1fTY2sYeIRj
         eyVuy3NfLJZyoiJW1LownvAfB3+oppOevD01GJIOvccKLD4AG3nHqdQvqQFhCNK8jOMA
         /OM/5tiL6aUXkQL+tdf+MVNN6k4QQQmy4VfLocV1+QN89dUT+Jq9xYwBbyIHcUCMJT55
         UIQ1U0VByCTfFpxW5kFbwcpIkkyZ5NeCFGvl6fCFhz6PwWvGQXMv96PEyJ0/A5X24ENc
         sfm5temjnXXGUNN7b+QSGe7AUuHSKGRQzGWxKh06SKk+LHYo1WglUqLSGYdslShPn2KS
         92lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727854909; x=1728459709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNoAy+ad5EbGGJuz8cYM8mdPSgQIHfep8UZ15oOnw/E=;
        b=Y3x/l3aD09IbdPH/P5skzWDHDzXFY7YW2cf9KYhM28gve/OrC9nZzF/ljUm13q0sy5
         ficXawweSwB0lPviyuPodHcZEWfhiYWTcTqxXbXdGw/FsFnGGU5JaOXq7lMGWc+Htx4J
         /bdLle/HaUa3uLiWIek7nb26R5IdY8A3FlUSKOsK39jvjzAwBymjBo2KicSM90aN0PUc
         aqAOXENx2QukzUZFnqa+8qHYIDr58I3u4SITCLhsvSjJXCiE1qlBEbExhbXDVQYGYbIT
         NAI/P0Df13hFlQVYiziQzWv2j8wiliETnH/Z1Ag7hlck/xHQbIXauwHC2664BY8u+dB9
         rXwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIw+nOi4tW1+zyqgftHWguxv8SiUJkwnbUIykSF8wb5iZ6JyecgvCQO4HRdFuPkzW4NKpN/Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6MaFlnB4l65cVQ8rwLcWPUYzVibM2Jr+7n4XR8yU2bPlgGKC
	GF9krMjC/kIWB5fQIUqeXUvOR0KGpVtDd13hnWJD6HqQy0fcu2GzRhGc5+eKKOGYsBn8N7x1f9Q
	Dg//Z4zN77o698LKh20qGpWfovkjQnLAduyeN
X-Google-Smtp-Source: AGHT+IETeEV/dAGMTyt9w3CwVqmLGgFv2H24NXLVYIJ8CRxZ5ndz8CAExfL+f8B8EXmjj+HXpdytHEl8C0O0ScS4clI=
X-Received: by 2002:a05:6402:1d4e:b0:5c5:cf1f:4433 with SMTP id
 4fb4d7f45d1cf-5c8b1b840d0mr1433978a12.32.1727854908354; Wed, 02 Oct 2024
 00:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002041844.8243-1-kerneljasonxing@gmail.com>
In-Reply-To: <20241002041844.8243-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 09:41:35 +0200
Message-ID: <CANn89iLVRPHQ0TzWWOs8S1hA5Uwck_j=tPAQquv+qDf8bMkmYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net-timestamp: namespacify the sysctl_tstamp_allow_data
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 6:18=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Let it be tuned in per netns by admins.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> Link: https://lore.kernel.org/all/66fa81b2ddf10_17948d294bb@willemb.c.goo=
glers.com.notmuch/
> 1. remove the static global from sock.c
> 2. reorder the tests
> 3. I removed the patch [1/3] because I made one mistake
> 4. I also removed the patch [2/3] because Willem soon will propose a
> packetdrill test that is better.
> Now, I only need to write this standalone patch.
> ---
>  include/net/netns/core.h   |  1 +
>  include/net/sock.h         |  2 --
>  net/core/net_namespace.c   |  1 +
>  net/core/skbuff.c          |  2 +-
>  net/core/sock.c            |  2 --
>  net/core/sysctl_net_core.c | 18 +++++++++---------
>  6 files changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> index 78214f1b43a2..ef8b3105c632 100644
> --- a/include/net/netns/core.h
> +++ b/include/net/netns/core.h
> @@ -23,6 +23,7 @@ struct netns_core {
>  #if IS_ENABLED(CONFIG_RPS) && IS_ENABLED(CONFIG_SYSCTL)
>         struct cpumask *rps_default_mask;
>  #endif
> +       int     sysctl_tstamp_allow_data;
>  };

This adds another hole for no good reason.
Please put this after sysctl_txrehash.

