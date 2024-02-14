Return-Path: <netdev+bounces-71606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860648541D7
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 04:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6671F24030
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2BAB645;
	Wed, 14 Feb 2024 03:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMF0SIoF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D481B642
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707882091; cv=none; b=Wag1BSHfZfzqEHToZjGh7mToF8PSY7lg8sPFkoQ1/Gl2hDOqZv9giaN5hxIMBKtWbnOZzy49o1lEfMne0HbbLnqlS3LPOEpFQ1WWbax9+kTYEuP+YmR2LqymswsxESIYwOjLb7SWwnGOcDbNMeYZ1bo0aYqLCF5TAu5fFD+q3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707882091; c=relaxed/simple;
	bh=uSCxRkMZscLYb60DgjSeUWkeay3DIai3KBtgtZMnFg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAG5cVDDRMSUycLVGuYUosdmT5G3sE3wnl5xclP9J1meyxn0MS5IH6qv/Jgd+VmYp1ymsJ1lTqsBduUYpg9vQJoTOnONSAnVdBnAh5wrVyA2U4oyJKOvRPIpfCat7GB/yasTib3TY/gHdzZrVLmSx6RhN7sFItHQaCpLFTb4Bgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMF0SIoF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so19675a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 19:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707882087; x=1708486887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSCxRkMZscLYb60DgjSeUWkeay3DIai3KBtgtZMnFg8=;
        b=GMF0SIoFwPLyC05NnqMNeXiGId3ApYcUHGvUkugDYiWOia7+arl5gISbSsSXdalACb
         eT4dg67Vl7UYrFNGkMmSHWUcalfwsWtymTwkIfCyEJ4FyVWwGzAEDQW5dZlKLWscU85Z
         ZGJHNiS5WoA6/BSSIm3P1e1a/278J3H3isaKAqWhLaqQg56SzUlQkhoZR4EIExD/iLje
         4dbIg2Okr4iRgkN5Nj2Lzk1o+F+uF5+uIleAOUdokXtNhHWGi7BWL6mupjs6ol5JuE36
         cjJXaIWfqjOJrO2fqwwyF+3+ypTYCOeRGCFNo8/nDldXKAr/JID9k0MsdhhoAmb0/Ieb
         u3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707882087; x=1708486887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSCxRkMZscLYb60DgjSeUWkeay3DIai3KBtgtZMnFg8=;
        b=dLLONiaZIfbK1ZbnihbC+kGY7ApYuexbeo9ZtsMlVGTWl+lkuVcAiPtDZoqNb6h237
         A0vifqrWfDmvmBVXorWmbFKtYLzx6IlOXBvJgchmLUnUlLzj04C/eFXaSyt+v4+r6vLO
         ISlclrmXcZE2fR0OJ9YrWW5RTRBUxJmflmERYiwL7UV6DlZBje7UYFUzpZjlyFqR7q1y
         24ScWZlk4GrRxwM7d9m9I2SB5mFPXKagUNDGprSr41wNi4dILEe9xOSyeZzCYhXbv/2o
         zfs8j5eyM6HqDfe3kuKp4HxVxMG4Czp7N/Yv0983dhm6KyUDc+l0o5NPJfEv9TF3BGZk
         FR9g==
X-Forwarded-Encrypted: i=1; AJvYcCXCnUVW8MYYNBZ0ePe4KFoJ54iKCvYM+woDrUq623vIJY9cIISxPuZeqDwLPFwL7mYoTlgkbbxngq1+t3j5DVrSxxRnVBzb
X-Gm-Message-State: AOJu0Yzp+gvkXbt6cQgbrqHlBpk3CASUKYEQq1gkGNpMb96++m8vsi31
	mEuMbzEW5tCwFEXsT8+cj8f3xTnSqX6E8zHvqG7/rS8Jbeutht2XTpmL5Qjs8LaepDNVpPkM6aV
	Eg6qiaBLh6oCiwdbbHM3tJ251iTbicseDSe+Y
X-Google-Smtp-Source: AGHT+IGsEKlPLsNOyJbYLcC9qX0sgjS9sLsA+njZqcIEzpRVowvdw5tiCuoC7NRqVEGNLgMfW/zqz0wuQ0CWEcwpZ4k=
X-Received: by 2002:a50:9997:0:b0:560:4895:6f38 with SMTP id
 m23-20020a509997000000b0056048956f38mr86910edb.1.1707882087442; Tue, 13 Feb
 2024 19:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209221233.3150253-1-jmaloy@redhat.com> <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com> <Zcv8mjlWE7F9Of93@zatzit>
In-Reply-To: <Zcv8mjlWE7F9Of93@zatzit>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Feb 2024 04:41:14 +0100
Message-ID: <CANn89iL4L_J4G4+3qoetv2n9m8xaE6KK0jASmOnJsjYR_DefeA@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, passt-dev@passt.top, 
	sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com, jmaloy@redhat.com, 
	netdev@vger.kernel.org, davem@davemloft.net, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 12:34=E2=80=AFAM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
>
> > BTW I see the man pages say SO_PEEK_OFF is "is currently supported
> > only for unix(7) sockets"
>
> Yes, this patch is explicitly aiming to change that.

I was pointing out that UDP is supposed to support it already, since 2016,
the manpage should mention UDP already.

Thanks.

