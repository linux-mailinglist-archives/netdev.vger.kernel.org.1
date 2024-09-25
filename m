Return-Path: <netdev+bounces-129844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D154B986774
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C8128419F
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B885146593;
	Wed, 25 Sep 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/MK+7Gp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDCA5C603
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295144; cv=none; b=GnUzzTfeSYlMgOEeoE4bqtdcPTRsnzYZbg1vcFN/THP9u8n4dBV5Gxz38Tvt1qhk9NC8Rs4s8Vgu0TDH8fYiOfEBZ+tNU++FO/AHAK/NV1QrdLiyki4ElOxLJjkNC0pjuXjPRR8xaphc/Nra5URRkH+TNcslx4PJ2pxtwqXNjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295144; c=relaxed/simple;
	bh=sSbXYfPSG8BUHUde4HNMFCJNTlpF5Q4DvPe32tjjbNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ER60csCDQz9tjBQVfE8G78vsJ0NXMgBgFjLnqCMowOf4VHbIncCS+gMigT9uCMZggW/jq8xCy6ai7pzPszKcHNjpV0/U2cx6L5cP038g4YKMQUKuc4aUtSbPIT+pSLagwPBsNCtMeQTvgC1pJT/O+1eYnDH16TkpPHvDMHYBh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/MK+7Gp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d3e662791so15771666b.1
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727295141; x=1727899941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSbXYfPSG8BUHUde4HNMFCJNTlpF5Q4DvPe32tjjbNg=;
        b=I/MK+7GpRemsVbpJrPlDIb3Dvqe9GyJaYgvIr3pGGb33NW+yuUHfH4PfND+jwruJF8
         SvDKNhqAaS5jDEVE8AJhUYiSj9te97UejWSRU58UgIvkE1Q6WdRUIyyr3NfQR1VzKPYH
         zAwi78mMr33ASwlN9jai4W2v94sBu4o2hm90w59QtcfZn9bi5vsiBbV3evJ22hgrwNi0
         3gH22hQRBqaFHI31XtnG1f326Ebdj9FLs2BZNvDghlXezPRw4UaRq8z1tmOmdhxJq/Yo
         Ua5S7DuATub627GYtpG2nHrhob6NvbPPl84/7r6FN4qw3KFCnIUOH0wgl7paNCzAccfM
         cCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727295141; x=1727899941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSbXYfPSG8BUHUde4HNMFCJNTlpF5Q4DvPe32tjjbNg=;
        b=HZSI+qx+eBDVdtBAyxbn9HZfuDdednKQH59ZUcyksI7Uk63AI8zYzIkTA52KbHc0ro
         JpN6VR1qh8nhpbZHzUaqHd4DsL3+JbLOP75CChODesPLvP+ZnC8elGeCmPs9/BRq4+Hk
         /4v80s7Z4aD87orPW1tcXy/NF5cw2JWbNq5YZBG7rWpzU+AHaiLHf2o2FIzNYnet1tHG
         uLqmz51o/YA9ZrTyv064dhFEIwqaziQybOSm2jsniYQ/crwmE6I0bc9F+JQpMg9C2c3J
         X9RkALFzQZGNMhw0ePU8NZsNkhNcxUH9k8+xykl9V0D5RR6DixQoRtrnfm+CM1rYCe6y
         dGng==
X-Forwarded-Encrypted: i=1; AJvYcCXVHXkNZq881YpzAbhM7jwweG1JG0EImm5qLtK2UxoFlPUBpNkF1uBL8aKapR745nCsIksb3RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUsdMCU0mM3xvlM9UrHUlvvDfZAnWtNTjTiF84PNHtGU9/UW3
	Je7AefOWEObttDx/bN8WWOI1bjCnUe7Y6rKtnCv3gw7yXhJ+4TBw5AlXgdddSEF48xEx6bmgxwV
	ipmdF5cAh2NwPRvCYRoPKEkHzsxcLU5IysQYj
X-Google-Smtp-Source: AGHT+IHu/XA80bDzACiWANGIuDdx9mCDbMVNXVnJHAVgnpJyVZUBSQiBA9V9UfQdnkkuXQlzADsxf/S+HJUNapnM0I0=
X-Received: by 2002:a05:6402:1e94:b0:5c0:8eb1:2800 with SMTP id
 4fb4d7f45d1cf-5c720620507mr4067679a12.11.1727295140414; Wed, 25 Sep 2024
 13:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com> <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com> <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
 <c739f928-86a2-46f8-b92e-86366758bb82@orange.com> <CANn89i+nMyTsY8+KcoYXZPor8Y3r+rbt5LvZe1sC3yZq1wqGeQ@mail.gmail.com>
 <290f16f7-8f31-46c9-907d-ce298a9b8630@orange.com> <d1d6fd2c-c631-44a0-9962-c482540b3847@orange.com>
 <CANn89iL0Cy0sEiYZnFbHFAJpj1dUD-Z93wLyHJyr=f-xuLzZtQ@mail.gmail.com> <8e3fcb81-0b3f-4871-b613-0f1d2ed321a3@orange.com>
In-Reply-To: <8e3fcb81-0b3f-4871-b613-0f1d2ed321a3@orange.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Sep 2024 22:12:06 +0200
Message-ID: <CANn89iL5XEZ0S6c-amu_Q_k8fXYqDKLVh1bPv8kPhc4eKR6UYw@mail.gmail.com>
Subject: Re: Massive hash collisions on FIB
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	nicolas.dichtel@6wind.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 9:46=E2=80=AFPM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> On 25/09/2024 21:25, Eric Dumazet wrote:
> > On Wed, Sep 25, 2024 at 9:06=E2=80=AFPM Alexandre Ferrieux
> >
> >> [...] why are
> >> the IPv4 and IPv6 FIB-exact-lookup implementations different/duplicate=
d ?
> >
> > You know we make these kinds of changes whenever they are needed for
> > our workload.
> >
> > Just submit a patch, stop wondering why it was not already done.
>
> Sure, will do shortly.
>
> However, I was not wondering about the history behind net_hash_mix(), but=
 more
> generally why there are two parallel implementations of FIB insertion.

ipv6 has been done after ipv4, and by different contributors.

BTW, inet6_addr_hash() does not really need the net_hash_mix() because ipv6=
 uses
a per-netns hashtable (net->ipv6.inet6_addr_lst[]), with pros and cons
(vs IPv4 resizable hashtable)

