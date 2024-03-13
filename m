Return-Path: <netdev+bounces-79688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF78E87A901
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 15:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B304287F5C
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50A4120B;
	Wed, 13 Mar 2024 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZF4dmw2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46704652F
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338671; cv=none; b=RIJS2AAs23HMFoudH4qmk9wDkWhsEnKIRcPuOOZ7/9ZUR/LMpa8WoCh0RTA3pAYRvHaqiklmqTKD5WAbgaEPopf6A634E1+THIBm3/e9Pdb5oLxCo6OX9Tb6qfC0j30cBbtA0F9VkWBGgec/miFjbAdMKsxhOHMlloVARSy5xpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338671; c=relaxed/simple;
	bh=nVScYI2aisvI7eCeLM50SdTmcOljhCXoI1HTbyQRCrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xr+lOUgqjS9xKC/Rz/OwGnD/3hyQZ0Y88lgxqQJHMttPxgY+vqSFXmm0V6HKDmfOzeZ0RygUmEF4cimgBQEmnzz/lKxkQdG47Z8bbW7qzycB6XGRgOB5INA5qSlto52UUpyFSW8TYL2Yitgxe/PIej8OZz5ilch4gt8divw+cQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZF4dmw2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-568898e47e2so7062a12.0
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710338668; x=1710943468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVScYI2aisvI7eCeLM50SdTmcOljhCXoI1HTbyQRCrA=;
        b=IZF4dmw2SXy+lIWVxXtuWdyvuSzxMVuM1ncPSDvG5C6CEI7HtIAxpd0pf2GfYDHJA8
         GpLXSQAkE6/82GU6rM1hoTyoiCIFemhVpPMmNRNqwKXyughFC83d9YPgKzu8SM97ZhKb
         OOCUgq9/TG6y1GcgLkw+Zq3GpVfq/TVngCBKBvTq/TYy4eh1wVWZ79xTIIjCny5+jWjI
         6GOJ+UP0c6q/tm1j/nuCbHUvWC5or7gMU6+pabkcNyqnLrQTdkPzAdKdbkBw7DhaekBq
         JBSLXeAokcsc4hq86xo9fFuHfi0Ss0V+m/qBgEh0xE0yP9cU9HGNKcgrS3uuWE2sfDWy
         Ns/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338668; x=1710943468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVScYI2aisvI7eCeLM50SdTmcOljhCXoI1HTbyQRCrA=;
        b=RC3WB3mLtW9yOlncSupkaF4FOZj8Tq6er8NQB/Z7P0wuK8AclNGaMAJDJOmrmx2Znx
         533xncpCvoGWgL3IX0UnFfTHVNcJX0T4bNoQxJiXmj8GhBkyq4MTxPgDLL8BIZ3pxwpp
         99uaqAHkZNVpdjKfVJ6PeApEUFWCZygf7cyUpADBakDCC5yM8gEOtX5zhrFCNtXZvDqb
         D32POn1h6HRt37hGiQm7iNkPvcZTsFQvSs6ETP/oNf7W1XgfuNFQASB2IkpzqqYVOMnd
         9+BPBCHSDYojmF6gj7rgjEkhuKpYGhhXm2GF00Vsdh9KWYboXI1vQjALpeHCegS8hR0B
         JakA==
X-Forwarded-Encrypted: i=1; AJvYcCW4WdAnkwKl5OAXWrwKvx0O2KWTjcwbLTcDwNqMn3qY3qvVXw+oJXVv6Cj0vdlTo9mfULv7WScu1z8bc6HJJcxF63ojxMN1
X-Gm-Message-State: AOJu0YxqHuS+3624QM0MyLKR9bu/LUtKxq5sfdWRoEZHeXJtICAps44m
	UCeDFGTZ/tCfa4uooCb0F8a9i20GQVKRdZtshIwC+NtdiPU5rjqopOHQrmSS/J4MHnUVEpzK2AP
	bdudUl9cWDEOChVWv80E3Fy5sURIQKRGCgvzX
X-Google-Smtp-Source: AGHT+IE+O495OjOqR1l5YxjBInBrXK/NL09v+Jc35RgVQkiXASq4swwL/GWHeXOQxifBQaKkwDm3VymAQFNmqfzD2U4=
X-Received: by 2002:aa7:c88a:0:b0:568:551d:9e09 with SMTP id
 p10-20020aa7c88a000000b00568551d9e09mr210701eds.6.1710338667885; Wed, 13 Mar
 2024 07:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313094207.70334-1-dmantipov@yandex.ru> <CANn89iLCK10J_6=1xSDquYpToZ-YNG3TzjS60L-g5Cyng92gFw@mail.gmail.com>
 <aa191780-c625-4e13-8dc0-6ea3760b6104@yandex.ru> <CANn89iJNBHnCPNovYE9tjQT1eN4DE-OFOhE9P86xX_F0HxWfrQ@mail.gmail.com>
 <12d61b93-fd89-4557-8c0f-2a72437ded6f@yandex.ru>
In-Reply-To: <12d61b93-fd89-4557-8c0f-2a72437ded6f@yandex.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Mar 2024 15:04:12 +0100
Message-ID: <CANn89iKGayUU2cg+ibQeEqWhw-mD+b4x_k+fm7xjis52f8q82g@mail.gmail.com>
Subject: Re: [PATCH] can: gw: prefer kfree_rcu() over call_rcu() with cgw_job_free_rcu()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 3:01=E2=80=AFPM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> On 3/13/24 13:55, Eric Dumazet wrote:
>
> > kmem_cache_free(struct kmem_cache *s, void *x) has additional checks
> > to make sure the object @x was allocated
> > from the @s kmem_cache.
> >
> > Look for SLAB_CONSISTENCY_CHECKS and CONFIG_SLAB_FREELIST_HARDENED
>
> Yes. Using kfree_rcu() bypasses these (optional) debugging/consistency
> checks.
>
> > Your patch is not 'trivial' as you think.
>
> You're shifting from "not going to work" to "not trivial" so nicely.

You used the word "trivial" in the changelog, not me.

>
> > Otherwise, we will soon have dozen of patches submissions replacing
> > kmem_cache_free() with kfree()
>
> No. The question is about freeing on some (where the freeing callback
> function is trivial) RCU-protected paths only.
>

I am saying no to this patch.

