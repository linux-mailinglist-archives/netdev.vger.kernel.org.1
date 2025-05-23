Return-Path: <netdev+bounces-192908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB83AC1994
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 03:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25F316D7AB
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AA221767D;
	Fri, 23 May 2025 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjn0PNzF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE08207A3A
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747963088; cv=none; b=W8g/Bs7JfDjaRR/x6edoWvlTYo3OjsCU8ejbNud1RVFLelxKyVxocUB0Oz8Wr16RhXlq59PhfaMaARbNuKmQ0ZBe6bB0WFwvvEw1Piw0ppSxfBq/XIcQ1KB9I6JoAUrjPRkZAr+AgErck0bxqsawE9gzU3wHWBDtPWgqCD9OY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747963088; c=relaxed/simple;
	bh=6sGa3dgT2uBNY1rfCSQXy/l9xJyuQ/jmpLR+hExcbJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrmSN6a9ZxcojkRWHTzU5KDCVSdkPnwHdMfC4TN8CYg7DFEvXZ8eheACcl1ApfmnxS5rrBsIvTtffpUzbIbYC7HJ4AFavsP/DjzKIPRJKtuLg7s9dpS+Lm2F46RGQ9g7W43Q/MPqZDNXJCLr0TUpQOxTAqlsRtm4AI1VPFc/QE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjn0PNzF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-550eaf7144cso6e87.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 18:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747963084; x=1748567884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYVm0Wz/IrzVHcR1HnROuiWFcqay2TxyWPAyn+gfIuM=;
        b=hjn0PNzFiiR6VJn2oPDTPxUVQOWs21UUxVrS0wB+wJMqz5jtqDubRnteJy+Vn9s9h1
         GD3j8ceZ7bDZAJVUccavTlyCU34VMm4gObSuLa2h7/J3gm2LTYNCsADoRven1yuVRWE9
         qNwuNeazC40bNsOva1u7PbzpnweUAyS9qrmSURdXgjwgzvn4EyrnaYIJ8U99dWr4HdOe
         /C716ioIUgD/3eLo5MWE8VC5sisKkzVXVUVL/n3Yj9i+6QscwO6TEPz2NvDAgB1OUBtc
         0ElYgT+Gx52zzf7BT94kW0xPEs+CBT44cNwfpPFIE4Gg0HxUH4Gengt5EqIh113V8ANd
         M89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747963084; x=1748567884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYVm0Wz/IrzVHcR1HnROuiWFcqay2TxyWPAyn+gfIuM=;
        b=lGoeWnmvFyxMmytosvYnKjGMKuaR8/VbFm1z03MLmlVGvGnSylvlc8z3JyyHYMGVuD
         tX1eGMxmuV/fUepfrYNM0RaLql8RCuyAmJOIk+izIU0flvCIi6bHytGkK1CaywxuM0D2
         fdD331u7w4I4pfj+5rkezXPUcjXRCXNzVZTVsFKqnsruRKLqrx16tqFancoQPoWFD36k
         d1tdikEc9Fm5FPJgmd4Tbpw0JFH9dZFsY8tyh8iyFmh0fqan6rkvoLE3nHnCAOIYwOBr
         JFd0QtNwF6zAu2/1PZDgldjXeZx1iSySK3TUmK/SnqY4niJc+TLOg7DB8f0xrKv0eQRb
         l7iw==
X-Forwarded-Encrypted: i=1; AJvYcCWfHi2IpW/htUS4IqopIaIqoHcdZSuyM0hepq16ztC+NNNeVqJcEpXljweMim+aViUNupbgNDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZIlQKic7jOu/BwM+4dd2XihLbwiYSwoobu4HWJw/EuCeeb8u
	xHaiwPmLbRy/DJHRIv8sfZdo++r7QBMhZqnlYghfgw3Kt0TDveEzwkstV0LNM3p01mzAz+54UgV
	DaipGOYNALV4FYFXj9MpwCxDyNGIGL1ei+mRSS/WM1YEtfV5C2D2XE6EVLQw=
X-Gm-Gg: ASbGncshoiMY2MYjPe9yYw1IwyD1vMcOGRMM09jD5nywJPtZzK9ILK20kxexQbTNCPv
	MBuAUjV8dOZ8HCPAr5+B5IWZrS+pVXktf1Ak5hrKoc1nmdEZqr6gbc7ig9YnZnUsvaLBShwgGHH
	wbLIFi3LL3loxaFCwanIquSSwQmqNZUk+BD/v1Al23ci0V+lSWzr7s+UghtAG2mF2OsRDQSW3c
X-Google-Smtp-Source: AGHT+IG4NBEhuVgLc1g60SsEqIvgjVS8hg/TxrkFg1ZaNJrTdqq8uwqUmNQlqDqAT+KkcvxdLuzHkprq8Jwx6MzEUCk=
X-Received: by 2002:a19:3855:0:b0:54d:6ccd:4d6b with SMTP id
 2adb3069b0e04-552184e77f2mr150e87.0.1747963082028; Thu, 22 May 2025 18:18:02
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174794271559.992.2895280719007840700.reportbug@localhost>
 <CAMw=ZnSsy3t+7uppThVVf2610iCTTSdg+YG5q9FEa=tBn_aLpw@mail.gmail.com>
 <f6475bd4-cf7e-4b96-8486-8c3d084679fc@kernel.org> <CAMw=ZnT7tcjC6z-9xuMbeC5RhDiaPRHaZB_2i_6WYNJ=cm1QVg@mail.gmail.com>
 <CADXeF1Hmuc2NoA=Dg1n_3Yi-2kzGNZQdotb4HJpE-0X9K9Qf5Q@mail.gmail.com> <CAMw=ZnTLuVjisLhD2nA094gOE2wkTLyr90Do0QidF5nHG_0k9g@mail.gmail.com>
In-Reply-To: <CAMw=ZnTLuVjisLhD2nA094gOE2wkTLyr90Do0QidF5nHG_0k9g@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 23 May 2025 10:17:23 +0900
X-Gm-Features: AX0GCFt2_Iv8NBZStmMMhAOi6Vj0N4nGJhVVTiPChdNxGMIV_bA6OeetMbIIa8I
Message-ID: <CADXeF1HXAteCQZ6aA2TKEdsSD3-zJx+DA5nKhEzT9v0N64sFiA@mail.gmail.com>
Subject: Re: Bug#1106321: iproute2: "ip monitor" fails with current trixie's
 linux kernel / iproute2 combination
To: Luca Boccassi <bluca@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	1106321@bugs.debian.org, Netdev <netdev@vger.kernel.org>, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>iproute2 is generally backward compatible with previous kernels yes,

Acked, will submit a patch ASAP.
Could you advise which branch needs the fix?
Is submitting to iproute2-next and iproute2 enough?

Thanks,

Yuyang

On Fri, May 23, 2025 at 10:10=E2=80=AFAM Luca Boccassi <bluca@debian.org> w=
rote:
>
> On Fri, 23 May 2025 at 01:58, Yuyang Huang <yuyanghuang@google.com> wrote=
:
> >
> > Backward compatibility is broken due to the exit(1) in the following ch=
anges.
> >
> > ```
> > + if (lmask & IPMON_LMADDR) {
> > + if ((!preferred_family || preferred_family =3D=3D AF_INET) &&
> > +     rtnl_add_nl_group(&rth, RTNLGRP_IPV4_MCADDR) < 0) {
> > + fprintf(stderr,
> > + "Failed to add ipv4 mcaddr group to list\n");
> > + exit(1);
> > + }
> > + if ((!preferred_family || preferred_family =3D=3D AF_INET6) &&
> > +     rtnl_add_nl_group(&rth, RTNLGRP_IPV6_MCADDR) < 0) {
> > + fprintf(stderr,
> > + "Failed to add ipv6 mcaddr group to list\n");
> > + exit(1);
> > + }
> > + }
> > +
> > + if (lmask & IPMON_LACADDR) {
> > + if ((!preferred_family || preferred_family =3D=3D AF_INET6) &&
> > +     rtnl_add_nl_group(&rth, RTNLGRP_IPV6_ACADDR) < 0) {
> > + fprintf(stderr,
> > + "Failed to add ipv6 acaddr group to list\n");
> > + exit(1);
> > + }
> > + }
> > +
> > ```
> >
> > My patches follow the existing code styles, so I also added exit(1).
> >
> > Link: https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git=
/tree/ip/ipmonitor.c#n330
> >
> > I thought iproute2 was intentionally not backward compatible, but it
> > sounds like that's not true.
> >
> > I can submit a fix patch to remove the exit(1), which should fix the
> > backward compatibility issue.
> >
> > Shall we proceed with this proposal?
>
> iproute2 is generally backward compatible with previous kernels yes,
> so it would be great to have a fix for this. Thanks!

