Return-Path: <netdev+bounces-113124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D193CAFC
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 01:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565AC1C20F34
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 23:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A734E13E05F;
	Thu, 25 Jul 2024 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz5xsFLt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022C131E38
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721948650; cv=none; b=SWiz0fr5YMqstxRmrGAKuZrnEsaOqYKp5GGzc8EXVq99ST2cwu3vinwk2lLEAbXYFOYJ954uESNfAxJPOsJQm+NLtkfK1D2G80iROMMTjMAJGg/mnbwHAVwA1ZT1+Z8OCNVAYr8Bun/f5XzV4qp9q+uk1uYoweI2eV5ySlh+p1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721948650; c=relaxed/simple;
	bh=DTCe8q/PokuRY2SzyaMN/o9jKKAuVjNiJbnHDqlsgAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GxYHkNnBjZ/A3+b9SyJzSlI2oyC+Q3hvAgShhGbd7sFSyeaV3oP29Iqk6y1lre5c19ZVDEYv9GausNOw/heQ+ne6jIAGoBqzQYG9dNt12aPKpvQn4K3AjgJbOSier7KwQR3IyA8nhGGNLQypkcXN37LY4kJUtvhxHi9dasBUZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zz5xsFLt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3687fd09251so856464f8f.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 16:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721948647; x=1722553447; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTCe8q/PokuRY2SzyaMN/o9jKKAuVjNiJbnHDqlsgAg=;
        b=Zz5xsFLtWZ7mbB9pYaGr5fkOWCuwo4tfVA2sCwUniLLyQBIqDMZvOtfYF9BwVYyKLc
         B4IyjquRQkns5chlkv0gipn0MzaYVfrLg17fUbLFGTDhjogaC19VKuGV14lV1sZOwPPV
         ZvJXalS5HBY1ofZlqGIY5phvODjAbkz5VMauGOViyInCBzvRI3UjsTyjlEPdZtDgMZMi
         F0NuPskLc2NwvsAgIqdZO1L7qLF1XkkgDtgXcHB44LWO9+H3/AcjFZHUiCbLKE5YbfqV
         tgNCB7hwFIozzJFgdSqh/0rg+4xFHCmNTq6mMo58Gu6s4q1yBKRQr68I0jWoO0s6FsjT
         2wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721948647; x=1722553447;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTCe8q/PokuRY2SzyaMN/o9jKKAuVjNiJbnHDqlsgAg=;
        b=MdsClcSIbIgPv3Ov3WzZTlegZVRj9IlWEGgqMLZOvrw2ZqN2nHG8ZwoRF0Ke+mL/S+
         LB/T6cmQcYNk8bIIA+NsfsifFTnyGvD0SD8gaPmiR0gUc8bXW1lS79dcJ9+csOPrDuvw
         3QHQnQ52AMQup4b9CGgteBnHQxxFoxLFbpdFtfjo94JGQtPHje0fUV4IPDNaq0WFcgSo
         qTbI6T7UUjP2KmJP68rfdDr5ByccoSsXwi256K+FNsA09zBBlTcGlEmGE45booN8I8bK
         PQtTRF/rC9IdRL9BVqvhxpb8bSNKyKiwJCP3xL1LX5V/TGNZEUV08zrnvnBWGCK+ujn0
         xHxA==
X-Forwarded-Encrypted: i=1; AJvYcCUBUzvOBN4N0ESWpo58x5SxtQ5LrcBq7ODDfqJSRc7YS14GGIs8GEvTyNXTdRZvwsyYFanRbGqV+usNXhfDsWjwt5ylgmn4
X-Gm-Message-State: AOJu0YyPPRataQscQsC8BtVfbqcR1Xg/BJANg2C6jLyFIG+hLJVcXyAu
	vClx+DfB2dLn7DcZl8zk0DkKvzydmYr9Lx4kzJnpWCnk0N+sCmMixNkOlX2Mi6tNDDNstXFaAyP
	cOcYzpg0M1+Ch5GKyzm6h0EtSVPs=
X-Google-Smtp-Source: AGHT+IHWKWck4AliTIgUSUdzSblOwLylYiSNaS8BloNvXR1lY44iqGlBM4c90Mwhl+niO4AAV6j3uQXEvMKRmpEjVwg=
X-Received: by 2002:adf:fa06:0:b0:367:9088:fecd with SMTP id
 ffacd0b85a97d-36b3637ef57mr2311202f8f.7.1721948646938; Thu, 25 Jul 2024
 16:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172192698293.1903337.4255690118685300353.stgit@ahduyck-xeon-server.home.arpa>
 <ZqKIvuKvbsucyd2m@LQ3V64L9R2>
In-Reply-To: <ZqKIvuKvbsucyd2m@LQ3V64L9R2>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 25 Jul 2024 16:03:30 -0700
Message-ID: <CAKgT0UdyHu3jT1qutVjuGRx97OSf+YGMuniuc2v6zeOvBJDsYA@mail.gmail.com>
Subject: Re: [net PATCH] fbnic: Change kconfig prompt from S390=n to !S390
To: Joe Damato <jdamato@fastly.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 10:17=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> On Thu, Jul 25, 2024 at 10:03:54AM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > In testing the recent kernel I found that the fbnic driver couldn't be
> > enabled on x86_64 builds. A bit of digging showed that the fbnic driver=
 was
> > the only one to check for S390 to be n, all others had checked for !S39=
0.
> > Since it is a boolean and not a tristate I am not sure it will be N. So
> > just update it to use the !S390 flag.
> >
> > A quick check via "make menuconfig" verified that after making this cha=
nge
> > there was an option to select the fbnic driver.
> >
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
>
> [...]
>
> This seems fine to me (and matches other drivers as you mentioned),
> but does it need:
>
> Fixes 0e03c643dc93 ("eth: fbnic: fix s390 build.")
>
> for it be applied to net?
>
> In either case:
>
> Reviewed-by: Joe Damato <jdamato@fastly.com>

I will add it and resubmit if/when the patch is dropped from the
patchwork queue.

It has been a while since I submitted anything to the net queue and
previously I don't recall needing to bother with that unless it
required backports to stable kernels which then also required Ccing
stable.

Thanks,

- Alex

