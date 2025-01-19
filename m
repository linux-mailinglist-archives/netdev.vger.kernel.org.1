Return-Path: <netdev+bounces-159624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621DA16230
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 15:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004FC3A541C
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40CC1C5F19;
	Sun, 19 Jan 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2wizI9K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7F10F9;
	Sun, 19 Jan 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737297307; cv=none; b=sr9MMMG2EyXNqQUKuB/dhy0fHPhhqLiVJPfjO3JhxEqRYOTVuXZ1HVL1iKy29uMwXHvDfa6MtSF00M9bRgUdwPasslOBk5r2BH9ftsntzvPAm+pPFuBZvnCTOrOO0xRu6P1xy30YrbJviZlLDuISmtFFawyCtu9gm5tHjQpGdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737297307; c=relaxed/simple;
	bh=gkxyJV6jx3Sg/SizsjSnXQXPvjhlrAqF0d6n4bogXvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBE2/Cz3fjp6OvbNflw9hiYCeKoc/OK2B9/DNWVw9VtPnoh36DcPFdzGCOq6sPbWGdhkVa1aeHJSpgiguZG+m4JYi1T7y8XTcjVTNNEL6xxB5E7qZnzwiGwHMbF5CznHz70FE/VVDz5bAAvKAC4nybwkFNqMLfMhD1+THMDpO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2wizI9K; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ce915a8a25so12782015ab.1;
        Sun, 19 Jan 2025 06:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737297305; x=1737902105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0aW2B6tsYfIVPEta8Nh7uAXEmns1XLSPaN0nuLCDuk=;
        b=R2wizI9KFpxteoUXSzgxkqA+EsY+XbomVJ84buJiTtYfSBvW0l5jULgwYgpu7vKsf4
         j4ud/9Pg92QzBU18rMgcgTA219uG3wsCalxx5rWFN3R3CxSbW/BCQxMj3rkObj5OvrCp
         b1EA+evdca3Bqw80CvgxCQn4+bM4UwwlFBYOQle7bynDaTL39AQvy8HgLRxai1IX15q/
         51w86Qg6r81WQ8D38pdonMibT7PgjR1RzpiKAkUG5lNGMpiepNCIY2dDjIsCUPM9oVDd
         0Hu+GGbbP+JcG8ygBcn+bTvoWmzRHYivnRP8UH6Y8fE7Ae5Du6gmZYz3z2szf+ndipUD
         7thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737297305; x=1737902105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0aW2B6tsYfIVPEta8Nh7uAXEmns1XLSPaN0nuLCDuk=;
        b=ISe5k93Z7VMoJlNeGu43EOj3FGe87DP+vycblQQVaFRERzK8d/YUPaqgFcletszv+r
         rtHNQBePYce2a+1S4v/VegGfRmPHVUWnEMHlB8upDBs64fo2Q5nMxbjjCOKXvogJXwAP
         AEb5QfnogldVYH/hdC11H+hVwiusDtgD4FuKG18M/5iKVZZpRaD2s0S7YPhnhUTLCM5N
         +pfEhLIi6UsCWElVhVOj05bpFYqwfERRpKHGJ7FjbcpEncE3/oRhOLmENQdtnnRfPEKj
         9NSv2AU4lXfNHOLrWR6eEhFerDkQ0RE9ftytGwiHubVW52xu5rW8NqSrQx0bdikZmeFm
         1iOg==
X-Forwarded-Encrypted: i=1; AJvYcCXt+bsCsv2Kt6Zkw65CJvMxeq1YqkEd9HRf5/kERMxaKwzRAtV0UszueXygjFb/r9fZ1oPGR7EPa2KmZlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ORUXrPLf24rg6F97FJ8oSzDqFq036I7dMDEmFNbqGT3mEs4k
	L4JRLtHpViVvrlhGvQIO4/iKYi74Gn+vxEmaebHRP+/nZaTTXsIy/9yMA/BRrsu+43r6/gkwFGX
	Ibru3/dDRjYRsJ4HRrzPORoLVwlU=
X-Gm-Gg: ASbGnctN0QMJJgY676crFCeD/r6ifm0UDDjSvB5pR+JI58sUCmVOdevyPipw7g6uuQl
	3AIPlOE4WIE2xrbiy0VStqsXPD6V7w6GN0l1LUoyQJJSg6RDziVI=
X-Google-Smtp-Source: AGHT+IGGxRHZLtgBAdTGbJY1oQIARd8kTTui/Tb1qN3TY8IgjJdPCl2GinS0Fb3SPmaJ9c/FTEOYqlDA1IVw+JgnhO0=
X-Received: by 2002:a05:6e02:2149:b0:3a7:e0a5:aa98 with SMTP id
 e9e14a558f8ab-3cf74426a36mr65337695ab.13.1737297305128; Sun, 19 Jan 2025
 06:35:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119134254.19250-1-kirjanov@gmail.com>
In-Reply-To: <20250119134254.19250-1-kirjanov@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 19 Jan 2025 22:34:29 +0800
X-Gm-Features: AbW1kvYZ5-YNYo-b43CqOt7kUDYmN2hLbR4V2xJentpgPT-AevgHVipBbU0eWww
Message-ID: <CAL+tcoDVTJ8vA_6wBd6ZDh2pq__fwJ9vzm3Kx5qpMNvaxpObjA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] sysctl net: Remove macro checks for CONFIG_SYSCTL
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 9:44=E2=80=AFPM Denis Kirjanov <kirjanov@gmail.com>=
 wrote:
>
> Since dccp and llc makefiles already check sysctl code
> compilation with xxx-$(CONFIG_SYSCTL)
> we can drop the checks
>
> Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
> ---
> changelog:
> v2: fix the spelling mistake "witn" -> "with"
>
>  net/dccp/sysctl.c        | 4 ----
>  net/llc/sysctl_net_llc.c | 4 ----
>  2 files changed, 8 deletions(-)
>
> diff --git a/net/dccp/sysctl.c b/net/dccp/sysctl.c
> index 3fc474d6e57d..b15845fd6300 100644
> --- a/net/dccp/sysctl.c
> +++ b/net/dccp/sysctl.c
> @@ -11,10 +11,6 @@
>  #include "dccp.h"
>  #include "feat.h"
>
> -#ifndef CONFIG_SYSCTL
> -#error This file should not be compiled without CONFIG_SYSCTL defined
> -#endif
> -

I'd like to know if you're still using DCCP since as far as I know it
will soon be deprecated... If not, the whole code will be removed.

Please take a look at the commit:
commit b144fcaf46d43b1471ad6e4de66235b8cebb3c87
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Wed Jun 14 12:47:05 2023 -0700

    dccp: Print deprecation notice.

    DCCP was marked as Orphan in the MAINTAINERS entry 2 years ago in commi=
t
    054c4610bd05 ("MAINTAINERS: dccp: move Gerrit Renker to CREDITS").  It =
says
    we haven't heard from the maintainer for five years, so DCCP is not wel=
l
    maintained for 7 years now.

    Recently DCCP only receives updates for bugs, and major distros disable=
 it
    by default.

    Removing DCCP would allow for better organisation of TCP fields to redu=
ce
    the number of cache lines hit in the fast path.

    Let's add a deprecation notice when DCCP socket is created and schedule=
 its
    removal to 2025.

Thanks,
Jason

