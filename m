Return-Path: <netdev+bounces-149230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B617D9E4CD7
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA4B164912
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4425314884D;
	Thu,  5 Dec 2024 03:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBIogoTJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA7170A13
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370414; cv=none; b=RwX2D7vsSsFfuVoJhb4/+/hAPN2+kHde8I9UpS5xjy1BT5CWRqitEEWTDLK84ermxY1S4Zz2jp9+0mXr2q7T7xGE1RhKMmnt5e1XkoTpUsv0VLh7CBQOHdw1tfvvd731IsCEYA8BbtDUPnTyIFzIyg3R5RLllSGXq+iMdKZs9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370414; c=relaxed/simple;
	bh=vu631VYWu8qIt32EzU4pJHGIb+CbIYolPm7Qc2J9LeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDvG6TYVcU+NBVs2kbRcaZSh9JhL6tjtiEVbLuOEJ+26qh+MWOwOhxtFNjqNjeiTz5irX4XwL3TRpafiaeyWPUn6tBnFm4SDi8yW6QDwGf5vA4gkMSP9LUxrRhs9Q7bUcAmVf7akohjwDbSzzeiDGNb/9RshuM2XcI1c2N6LCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBIogoTJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53ddfc5901eso2e87.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 19:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733370410; x=1733975210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuCAerqgy58O986DuA3yz7fFQC8pdsooU4+587wlwoc=;
        b=QBIogoTJIjy1s++Jr2Y2sGOFY2clKZY9zL3BjEZrV93Bsrp5bXHEa2wDIv6/UNgXmW
         X8djQd4IFw87tzbZgE1WGbrDwdvVFw1FCs/SepZl+x8xmeWkk2AeRcOijYtSLGQkq0di
         2ufnbWbiLDn7RBeIsS1BAI0Yp2gcg6/yGYhmWMFCAeRHCBfnLOPKszEA5zcArxdmJyO0
         rPuMQ/10L+8NA5zh6v/RUPw7rImltuKRvbFXn1E50k3+d2RSKHZ+7ENd4FgL5MZznj1w
         6y+mf/S/KK56VA3I5DM8UmxM9Yfv1pnHr6lCwUOXFUCh+hO/BgLGpXf5xcXBrXZVbh8K
         201w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733370410; x=1733975210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuCAerqgy58O986DuA3yz7fFQC8pdsooU4+587wlwoc=;
        b=KdqJSCj0TnCzVrhktW2Qp20mL3OmQ080v3r8BeqCEiV484fru6w0055nIv3Rm1jPds
         XLgBo55xRAJZmiEWVo2W0JRAu+OF/HodC/V7bwefyWoyGcthJfICMb5DY6zQ+bJH7NKN
         di+nytHqpSWIM8x8fuWyBmgmkkDtdJb73pG1XRbnJrM9AS1Q59zrYElgBL2HrvvwvXNY
         hpKpR6h7FTnftgtnNKEdS+deGo2ig2T3xsEFEWjFrUzOEX6C3WOHt7NGtUE3OG7vTHu7
         WpmeMBPMtSmdCTkLu6diS6IeQMybZlCqbsXLWhhv8PN6wc10WYDvOtMokwiilnGJc1tX
         KOrA==
X-Forwarded-Encrypted: i=1; AJvYcCUMloahKUaQdVoRZxYzhmN1OGYu2TSVrxnRvCrD7Tl6skidfzz0pTN3jcv5O0DvK5JCsn485+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoq0Sx5k2Pdzoo1Yzia1FXPTSLSETwiZuccymflqcMFBIGwpBi
	LczWTpG5aJRYjSaRvt1Fi/asLD32qrUhEuB4OhqcTTwFynjaidDKSi2PLtZQprIYCsSge0lOqOF
	ydVHn7Ssm4+XJz8Rj1vr6ZlRtaQF3cwWXI76V
X-Gm-Gg: ASbGncus+gbGqAlyOo8EReECilHg9iNU719AfXwCKZzkFzf+FTycdzfOqLPVy5jiP+8
	GWynxbE6rgrbiFamhWprGfj2uUYGN7vbew9k5Veh7+94O8mQ2aUZVuUIEsI/fqA==
X-Google-Smtp-Source: AGHT+IE/zZs7n7wJH7X3NDtrTv2DvoJS6GX4uoMnWJZV1R1edhRWdsFbUbEbYhHUq0kLCE4RtpgsaC8Hs3TDgx03OPs=
X-Received: by 2002:a19:e057:0:b0:53e:23cc:203a with SMTP id
 2adb3069b0e04-53e23cc2085mr691e87.0.1733370409342; Wed, 04 Dec 2024 19:46:49
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204140208.2701268-1-yuyanghuang@google.com> <20241204082859.5da44d1e@hermes.local>
In-Reply-To: <20241204082859.5da44d1e@hermes.local>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 5 Dec 2024 12:46:10 +0900
X-Gm-Features: AZHOrDlZx2aw05uYi6xELn58IluqLXRfnMI4nnlQIXQyRHm6V2qv26PKUpD6H78
Message-ID: <CADXeF1GAorRDqyZLE=kbjD-hmuG5y8B7ufDzx0mLNiOvrfwrLQ@mail.gmail.com>
Subject: Re: [PATCH iproute2-next, v3 1/2] iproute2: expose netlink constants
 in UAPI
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This should get automatically picked up when David does header update.

Thanks for the suggestion, I need the header patch to make my patch
series build.
Based on the previous review feedback, when David merges the patch
series, this patch will be skipped.

Link: https://lore.kernel.org/netdev/c97dd18b-8f67-4d22-a088-d73268402261@k=
ernel.org/

Thanks,
Yuyang


On Thu, Dec 5, 2024 at 1:29=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed,  4 Dec 2024 23:02:07 +0900
> Yuyang Huang <yuyanghuang@google.com> wrote:
>
> > This change adds the following multicast related netlink constants to
> > the UAPI:
> >
> > * RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR: Netlink multicast
> >   groups for IPv4 and IPv6 multicast address changes.
> > * RTM_NEWMULTICAST and RTM_DELMULTICAST: Netlink message types for
> >   multicast address additions and deletions.
> >
> > Exposing these constants in the UAPI enables ip monitor to effectively
> > monitor and manage multicast group memberships.
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > ---
>
> This should get automatically picked up when David does header update.

