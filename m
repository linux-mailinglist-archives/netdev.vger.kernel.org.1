Return-Path: <netdev+bounces-192906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1AAAC198F
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 03:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF967BFF51
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BCB21A928;
	Fri, 23 May 2025 01:10:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615B22370A
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962656; cv=none; b=FjrDpCWgYTjgknY4+XZgoU+RxTTPBXnL1aOpOrTy57g/DozYvVLuAEhs/3M2EpKNi+HucoDIPXf3UKDtYyHP4Pz2Y9Fymc89EevwshrWzKQNDkIsY7HdmNqYkgxC3CPXk2nsri4pZ67IASRVCc8/iKc8GeiV0ibBvbOAkLjhpnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962656; c=relaxed/simple;
	bh=rYJIvdy74ybWWsU+FxTWnJI55cA19PKEHOMGWo0tRfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCv2B055vv6FmEkeuuoF6O5fKDXDH+IVPXP0y2kYSphZhMgminpei3cRytPcGM6zK2NdeSAj0xuZbqTjGNvTtMTjx9lVR1ZSTwIoDmyxf6V1820NhlloUXLnCBDY0ykvA0rDnrIaLB2u58hslmfHIaEBcyVIUBIzgrGflv0XkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70825de932bso4733287b3.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 18:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962653; x=1748567453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGagkRgGCrzwcBtE9sFkO8d/etv9vx8u09F+HsV4dV4=;
        b=KBUu9id68ygyoMq2xCEboivrmjwgZcftlS6D941ApV11am+fTVE3/saV3ZKz697RyU
         RmDwyDbE3Yw58LYFH0W1h7/7peA1fAghyydrmZGRz3BaC/VAEID5GhfSei4lpcLxtstO
         PXSjpNtmhH2uoLb9Vz71+j6uE9HZBTxmfCaQQ+RochCTrwIJ7f4s+yb7wCBwmaAvL488
         ercL/0+No93hW8alb5TPPElm0CgIUmhhsHmJZTqipNThaYelPiJtgjOtHoSHkF3Q4CXe
         Rc+x8xGZMHPb/Iy0G/yU2gl2PXdsOI/pwP8lQjBmEv0STHhnzkGKOALbilR5IkT4tBTk
         Mauw==
X-Forwarded-Encrypted: i=1; AJvYcCVtp57xpYX0A1Msq9hdmfNswCmH1y/SKRSzkBQSYP6wloAOwp0lKTf96Px16UwGAbbLmauhdjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEnWpRg/2LrYe2HVc52uYJZYDplacrQrT4md+yb+zNlMRedzDt
	abAsFoAi6C++2bISGIRvUCXu3HK+Zgg/yhLj+K2+/8APE/g7XVWbgowbUOpLkpgE
X-Gm-Gg: ASbGnctVnzeQxhxIoSgFQwD1n3GKdgCoJKT3Kcyw52rzj91a6Ha0eYQ9axPuCWZ7Hxm
	HXYraFRSPfx9q17GueyqESrAX+LlJY4+/mHgM8iOLvo88QOh+EIRaTIsxgOiezQ6FLgg7tB3Qrj
	wkmi2gFP0R0rZYy3ypxgfyfuPKgQgxvV3yiNr86rDef0zi/9qCx7CiDTJvWRhvGeYUmH5PjGKi/
	7KNCtghHzHWy6ARYBjsvH+UCD6KM2+iVAtudwHDGRcQYaFRfCu1zahq0lf7AvXo1VQQcoi7ERHK
	txsZC3Hr98Ho02BlwjFTLGbdaQF/0na9YELoAmlwhAA+EMDxELh7P63HZKsgHfCBGPGrXXnpfqk
	9szMjD7lRYihHLz4mxGAb/DQ=
X-Google-Smtp-Source: AGHT+IFcN20ObO84RxafBdshiBxhII09KbStxIf5kEXqSyG6QD59JiXvKi7ljFnwZLEs1SjiQalBog==
X-Received: by 2002:a05:690c:6888:b0:70c:d977:b154 with SMTP id 00721157ae682-70e184f055dmr24986637b3.4.1747962652811;
        Thu, 22 May 2025 18:10:52 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70e17f59e82sm1954857b3.93.2025.05.22.18.10.52
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 18:10:52 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70df2e31510so3891307b3.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 18:10:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5ws2ZrMJzRw+gH3wvKZ2djpRQy8xai17zu/qUZzud7hrBeXf/qSp+qI6DwZyPsGoJVAyHv7I=@vger.kernel.org
X-Received: by 2002:a05:690c:6888:b0:70c:d977:b154 with SMTP id
 00721157ae682-70e184f055dmr24986367b3.4.1747962652313; Thu, 22 May 2025
 18:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174794271559.992.2895280719007840700.reportbug@localhost>
 <CAMw=ZnSsy3t+7uppThVVf2610iCTTSdg+YG5q9FEa=tBn_aLpw@mail.gmail.com>
 <f6475bd4-cf7e-4b96-8486-8c3d084679fc@kernel.org> <CAMw=ZnT7tcjC6z-9xuMbeC5RhDiaPRHaZB_2i_6WYNJ=cm1QVg@mail.gmail.com>
 <CADXeF1Hmuc2NoA=Dg1n_3Yi-2kzGNZQdotb4HJpE-0X9K9Qf5Q@mail.gmail.com>
In-Reply-To: <CADXeF1Hmuc2NoA=Dg1n_3Yi-2kzGNZQdotb4HJpE-0X9K9Qf5Q@mail.gmail.com>
From: Luca Boccassi <bluca@debian.org>
Date: Fri, 23 May 2025 02:10:41 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnTLuVjisLhD2nA094gOE2wkTLyr90Do0QidF5nHG_0k9g@mail.gmail.com>
X-Gm-Features: AX0GCFvW0vljPOr2pZmuaJVHNUQ8VFoDMmkeT57Tfwd8Si9XpwExe-hPbR_VO9E
Message-ID: <CAMw=ZnTLuVjisLhD2nA094gOE2wkTLyr90Do0QidF5nHG_0k9g@mail.gmail.com>
Subject: Re: Bug#1106321: iproute2: "ip monitor" fails with current trixie's
 linux kernel / iproute2 combination
To: Yuyang Huang <yuyanghuang@google.com>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	1106321@bugs.debian.org, Netdev <netdev@vger.kernel.org>, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 May 2025 at 01:58, Yuyang Huang <yuyanghuang@google.com> wrote:
>
> Backward compatibility is broken due to the exit(1) in the following changes.
>
> ```
> + if (lmask & IPMON_LMADDR) {
> + if ((!preferred_family || preferred_family == AF_INET) &&
> +     rtnl_add_nl_group(&rth, RTNLGRP_IPV4_MCADDR) < 0) {
> + fprintf(stderr,
> + "Failed to add ipv4 mcaddr group to list\n");
> + exit(1);
> + }
> + if ((!preferred_family || preferred_family == AF_INET6) &&
> +     rtnl_add_nl_group(&rth, RTNLGRP_IPV6_MCADDR) < 0) {
> + fprintf(stderr,
> + "Failed to add ipv6 mcaddr group to list\n");
> + exit(1);
> + }
> + }
> +
> + if (lmask & IPMON_LACADDR) {
> + if ((!preferred_family || preferred_family == AF_INET6) &&
> +     rtnl_add_nl_group(&rth, RTNLGRP_IPV6_ACADDR) < 0) {
> + fprintf(stderr,
> + "Failed to add ipv6 acaddr group to list\n");
> + exit(1);
> + }
> + }
> +
> ```
>
> My patches follow the existing code styles, so I also added exit(1).
>
> Link: https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/tree/ip/ipmonitor.c#n330
>
> I thought iproute2 was intentionally not backward compatible, but it
> sounds like that's not true.
>
> I can submit a fix patch to remove the exit(1), which should fix the
> backward compatibility issue.
>
> Shall we proceed with this proposal?

iproute2 is generally backward compatible with previous kernels yes,
so it would be great to have a fix for this. Thanks!

