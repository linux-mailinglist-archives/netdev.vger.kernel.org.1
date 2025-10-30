Return-Path: <netdev+bounces-234482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A4EC215FB
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 18:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83DBA4F117D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805432C93D;
	Thu, 30 Oct 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Id6Po+8H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA132B99E
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843708; cv=none; b=UVwww5EVqpfqkfo6VD2OSIuqKWZPbPyYAKk6uRORzS5nypaD88lQHdlug+rFotU74+Ku9FfWwHJaoq6+Kz7KwRJ8LaWrg1VDit0mVDW0GBG/GgNfY/zJ/cQSOmYFx3U0l7e15hwoFUmOGlKL0vx2XBrRvn8itG8QDPoxR+602BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843708; c=relaxed/simple;
	bh=sooSORsPeZ3LygJqT5OoURzlI5Ieddf28x98E/UvMx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2Bre10piXdvfTTgxmh9F+lM3jnqO5MNjVE2Eqwrw47xFTOka3l3E+j3z34BIhPYCCWuyWpq1xVMh7fpjPYrGMLyKY0BduLPVxFZk6OUCTeER9X0FZvcVpzdxAoMxQpZ+jD0iXkJm5JwCEnOpJ7RPpK/3u1XmYYdAulT9eRbBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Id6Po+8H; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4eccff716f4so10471cf.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761843703; x=1762448503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1iMEFORPqMQ+iho8BLiV6S+XB4wtm9heoss738r53U=;
        b=Id6Po+8Hbkjo7uuCeYLGk45eOg2dcbILg8rKzMbvzEqY8Mb2TAHb1DShwbUCdFS16F
         BU+/TEP8KEFoZvwkpi2Qx1zfAC/EExNmwAzAwko/6ZbrDdD5BwYcGKudmUW8zLU2GK2a
         AxyOf6u+Hp4hbPYVFhdaAsL3YqWH+37IBIls//MOBcdKCQ6zKKaHVzO5+swtaHVu6tEV
         NARpEG/qZXeH3jzz8tCCRrYbYjrAYPrM//zZmni7mdbngsTjkkzKHIxaeRI5CSlQe6th
         /ZmiUQ7gwzyELaLqe06Bg/pClmNMJ2mjhP6z9g8t93UNyxzdhegmb/2XePqh0VtDt3y5
         ypkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843703; x=1762448503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1iMEFORPqMQ+iho8BLiV6S+XB4wtm9heoss738r53U=;
        b=bBCLEGQESiqaaGoHfTZAj1BPU5uaGjCnO/rN032RiFF3TdaAVolplRRscfpH/BPFQO
         kpd17t3p8pE/O8kld348mE2FrTHtifhDw1FRNko/vWqs9o+EjV4IDhBaGlSFsObgGAAL
         YNPq9f8A+mcLgQyuoSYAjgyXY08YJM16+PGG4KqNMF+zb2cxOeQg9SekrhnM7Vg/DeoN
         jKtjQHFaczakJwAiGikHpiKqY6AuKd13Ri0c57TSmcrNOA8x9d6K4pVK9XH6RqEG354U
         jCxx4dHcUsuUKJZnxnL1YTZGzAjE6kFEaZpZZYX+ggsdCNumafXkZgyLmOr9aU3mIZfY
         Uxzg==
X-Forwarded-Encrypted: i=1; AJvYcCUcXy5xrEYMyV0kvl7OrmoQNbkg7OkYP79U8y/9S8TNNbBJi8UV8F4QfpH6+Vfbk2B7ll+SsrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbCP0qkla8lC6WPi65GmnjoL6vvyNK2dO6Go7+eNps9ERRNmWu
	rWRBNe7neoCle76lgzQJLMbXgTQy/ihnwdihQghGxPaQg6VrblT0XaYX1yCsCs6SpXr3995/ZC9
	6xxLfHhwua07xYwmZtru9+fZ6+eUcnOXH604wzquv
X-Gm-Gg: ASbGncuWAyZd9he0Nq1jhuSdOcgIZgqVMSlAsuWY2W+ZrBUNic1L4NwPX3RUhRl8vqW
	c1t7L+XEmAGPRHIRGES/YGMZQ4WSqNnU7/vUn6Q+BIDxuutj9AH0KS0m30R26XrjMxJpoK4Wo/x
	ADiD3X5JJ9vhZE73tQ3JmdiIWpvX0DcjDSnTRdaSynGCydchVh4+NEIqmP+AoUeWtqMyAV7nOtx
	RQuMMd4FoweU3KY60aqK+6O0MdJjt0ClajF6GJXayoTze3U1r07SwNmKCU00VIYHJHd4hnM1lBX
	smMsVaWZoBRdWYk=
X-Google-Smtp-Source: AGHT+IGbG4+JAXpeJAmQffn7xWMZ9l7FqDYhPXtR/Bl29uXQjOOthQu/w+R0T5LEuNPACks8hR5w566lrqYHX864Wdo=
X-Received: by 2002:ac8:5c93:0:b0:4e5:7827:f4b9 with SMTP id
 d75a77b69052e-4ed23b7ca8emr7250611cf.3.1761843702284; Thu, 30 Oct 2025
 10:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029184555.3852952-1-joshwash@google.com> <aQMzWoIQvSa9ywe4@horms.kernel.org>
 <aQM0eqE2klsOq6A0@horms.kernel.org>
In-Reply-To: <aQM0eqE2klsOq6A0@horms.kernel.org>
From: Tim Hostetler <thostet@google.com>
Date: Thu, 30 Oct 2025 10:01:28 -0700
X-Gm-Features: AWmQ_bkWK5DKVnu-rjTZf6RGexQ8qogsXqxUgk0Pfahr11VmaBz_miV-42qS7t4
Message-ID: <CAByH8UuzrzJ4h1dbOKbAf8oCi-_PAcX_Z-aGp=+EDJnkBPvpOA@mail.gmail.com>
Subject: Re: [PATCH net 0/2] gve: Fix NULL dereferencing with PTP clock
To: Simon Horman <horms@kernel.org>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 2:48=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Oct 30, 2025 at 09:43:57AM +0000, Simon Horman wrote:
> > On Wed, Oct 29, 2025 at 11:45:38AM -0700, Joshua Washington wrote:
> > > From: Tim Hostetler <thostet@google.com>
> > >
> > > This patch series fixes NULL dereferences that are possible with gve'=
s
> > > PTP clock due to not stubbing certain ptp_clock_info callbacks.
> > >
> > > Tim Hostetler (2):
> > >   gve: Implement gettimex64 with -EOPNOTSUPP
> > >   gve: Implement settime64 with -EOPNOTSUPP
> > >
> > >  drivers/net/ethernet/google/gve/gve_ptp.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> >
> > Hi Joshua and Tim,
> >
> > I think that the approach of enhancing the caller to only
> > call these callbacks if they are non NULL, as per the patch below,
> > seems more robust. It would fix all drivers in one go.
> >
> > - [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
> >   https://lore.kernel.org/all/20251028095143.396385-1-junjie.cao@intel.=
com/
>
> Oops, I see that I should have read to the end of that thread
> where Tim joins the discussion.
>
> It seems that this patchset is appropriate as it's expected
> that drivers expect an implementation of a variant of these callbacks.

Right, one of the gettime64 variants and settime64 are required
(whereas the other function callbacks aren't required from my
inspection). I actually have a patch I'll be sending out pretty soon
that will prevent the registration of a ptp_clock that doesn't
implement the required callbacks to prevent a bug like this from
happening again.

