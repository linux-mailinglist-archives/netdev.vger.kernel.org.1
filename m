Return-Path: <netdev+bounces-227730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 008ACBB6493
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 11:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0E70344B2D
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E1927F4D5;
	Fri,  3 Oct 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcNAhzBY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E7C27B33E
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482135; cv=none; b=Tq7ia6K/3RXf4GTNh1YLfR6494YxI/0GhDlGVDPlZns/qjNP5GvpVwBQ8rPF48Q0sKVk1P27lBm+NcKDVdOvz8csjudO31a/fdzIAN1DjxoA9qqcEQ9Lr3CfLbUx72YnWWqVxSIjkVcWh/WOnnK4pvUew7mQgdX5p4Tdkg29cRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482135; c=relaxed/simple;
	bh=AoJlu/aMSVaAZ99yWts3jw8DSv4BPd3kziHUYPKMSy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buzBcd+QjWcp4t4UN4XOXPSRCsVsVG1aR43Ds0C7lJL1AVOZT3CT8edHdZ/cXfKHFitAZ5q/YMW5supvRCf+8tR6T7owRWWogSdFOzlLWMo9jO6UUw2+WHXBJmO4XJNU4vcECpRps7yPRwrMGnBBtJb/g+xE4GW8pUOUPfLIgt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcNAhzBY; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b57bf560703so1473445a12.2
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 02:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482133; x=1760086933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxqa+yDgpnoAEXzNRro9y4z3jhhmxVoLzlhoWTC4v1g=;
        b=fcNAhzBYGprF+w7OrvPgpI6+3AHoVTOujVRnua+vOHxFya+cMqyXUN9VYEjzpEYGND
         a3uv6hKTg01ezVLPbE0IluL45Xs+BhWRdIXGMN+ThBRsEtT8smHcMJ9T7E7WXs+aDBeI
         u5hND0PTPGyCoOEByaenbmQQlIhfVqcMKAeC3h2QeAuspyqQytAmkWWtX3RH9wKLR9+O
         ji8l5zRI3I+aurRLPTg+9NLEEy3CRDxP+AFisfRPRS7Y6xg6uk4qQmpNYUtL11XVWvmr
         axUH4OSxnIHkjULZrLNQUKFkgGWEg2BbIkD+NIAmnMYu4r2m+H4u8U7JSzfvYul9z8Or
         oZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482133; x=1760086933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxqa+yDgpnoAEXzNRro9y4z3jhhmxVoLzlhoWTC4v1g=;
        b=f/dG1sGo2RSXss6navz09JTn21twxNfiJS3qLcPBePSfL81eu1oWLoun6FIdZWnAEh
         XMBkCyZnhrh6CUlKWQvYtd8JBkkN8NpKotyoD57Uj8XILNJGyqLW3Py6tYQKzxIwJIRC
         H4jMeRgm4FGnftJfv6z6rp9bimzT9EAkc5JOWnlgl2aeKwnRX/e0lpGnNm+38BaJMEmy
         x9zqYaUV+zmbnO72xcsTIioP26mCOYKNY0BM0+QkRTcfvBVKLnpew3mAQZZtO0K8i3oJ
         IKrWKY7/TKLBcgIfgBTv2CgZizKAjvJ5ANoInT8bFgxD1UcWmTqYz/0rTmtV05490xL3
         Uu5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFHmBXf2kfR/15769/Yt2VeReE6BQZ7zilIhVAytB0PFKPnwBcUxGI+Nbl/1ksb1OB8Cha7V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXh2pXD0BleR3uSh05znE5l1K36hMFuvYVkxu039qkRTjmEs4
	rE6GzsaRQlOIUGbMqDnVZ+5cP4OMg6KogEJNoYocuNsEs8++NrvltMUguQW6/u31wwyGqi+dckf
	7M2pYhIfiGrzRCUQJJqGgkzMG3VE8dr4=
X-Gm-Gg: ASbGncs0bR9V3LoDwFPBRZ9Mul6622HYbqINH0oNYlAygS7iCft9WAnuSsL1h63pcmd
	zGKitZAeeBltyR2sD6BTVunvUcYnAutN4fGoVWrmxU78/eYoKf/z6m7WpJmByk3YkDEl0pWo8DB
	QuHjhoQH4Jd8ziLAr5kATv8Gc4aRdoUaRQAAic8qO7mXPo3I4izrVSIxrMPaQKSatnxxK//rlN8
	CQ/PY0GVlF3AVnLHXDZctSvErqh91ojz9mIU/5Ia9AFQLeqoGiktjnU+4p0bj+OCC2Tgq4FNV3T
	byEr2oYI5V1TXRSI
X-Google-Smtp-Source: AGHT+IF+VuyebhfbDmuKwaQz9VO+LNpTaCKzPPtkSI3ZEy/4ghCU+AOuEMJ/tznlAQcxgIL+aISACabvQO9QzaBnXr4=
X-Received: by 2002:a17:903:1ad0:b0:25e:78db:4a0d with SMTP id
 d9443c01a7336-28e9a5ff449mr32573585ad.36.1759482133330; Fri, 03 Oct 2025
 02:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com> <20251003083312.GC2878334@horms.kernel.org>
In-Reply-To: <20251003083312.GC2878334@horms.kernel.org>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 3 Oct 2025 14:32:02 +0530
X-Gm-Features: AS18NWDDuPPIIeehTgoFw-nQ8yC7s8iWiZZdHg0YLrQUfA3dlujVeUboCKThj8Q
Message-ID: <CAL4kbRN=ktZc8fkcjo90GM2EBgCVt_xVmSGVQuM8gE2qV3ZJKw@mail.gmail.com>
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: Simon Horman <horms@kernel.org>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Thanks for the review and guidance.
I=E2=80=99ll prepare a v2 targeting the net tree, updating the patch subjec=
t
and incorporating the suggested changes.

On Fri, Oct 3, 2025 at 2:03=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Thu, Oct 02, 2025 at 06:05:41PM +0000, Kriish Sharma wrote:
> > Fixes warnings observed during compilation with -Wformat-overflow:
> >
> > drivers/net/wan/hdlc_ppp.c: In function =E2=80=98ppp_cp_event=E2=80=99:
> > drivers/net/wan/hdlc_ppp.c:353:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/wan/hdlc_ppp.c:342:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Introduce local variable `pname` and fallback to "unknown" if proto_nam=
e(pid)
> > returns NULL.
> >
> > Fixes: 262858079afd ("Add linux-next specific files for 20250926")
> > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
>
> Hi Kriish,
>
> As it looks like there will be another revision of this patch,
> I have a few minor points on process for your consideration.
>
> As a fix for Networking code present in the net tree this should probably
> be targeted at the net tree. That means it should apply cleanly to that
> tree (I assume it does). And the target tree should be denoted in the
> subject.  Like this:
>
> Subject: [PATCh net] ...
>
> This is as opposed to non-fix patches which, generally, are targeted
> at the net-nex tree.
>
> Specifying the target tree helps land patches in the right place
> for CI. And helps the maintainers too.
>
> Also, git history isn't consistent here, but I would suggest
> that a more succinct prefix is appropriate for this patch.
> Perhaps 'hdlc_ppp:'
>
> I.e.: Subject: [PATCH net] hdlc_ppp: ...
>
> For more in process for networking patches please see:
> https://docs.kernel.org/process/maintainer-netdev.html
>
> Thanks!
>
> ...

