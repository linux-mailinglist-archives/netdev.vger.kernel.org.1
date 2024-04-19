Return-Path: <netdev+bounces-89653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0668AB0F1
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 16:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF23284D37
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D88C12EBE9;
	Fri, 19 Apr 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KRATRN/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC412EBD9
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537918; cv=none; b=nc6i3g7ASTtPtN5IqW/rkRyO6Wo3w52i63U3z5joQzWEwWB2WlDEdigz3Bhxk1SN6Sr7hJFgBxQMuMw+ll7lqeKcME2okJ3NE72LcMRNH8CS5dnKxq4M+gQo9sZWZQF8wIZ3GvMbGNW1qRwowi/YIbs/9B0fueIyj1HNBMQRim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537918; c=relaxed/simple;
	bh=XDe8m3PGTtm17xos4Wvo0k72yCDO41RF5m2s5L9f6/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0JKcJg8jHm2S7Qp14+b+X+YXGNqYiJaMtKeKQr18LYCHrtM3cyFpWg46ukwxuuXtGeD025Mku5xRSR4vtX0jy+syKywHBr80cQWOUa/KiCNe9JDd405i+6nVL7W2bt5FoRqKeW6ybXeEM4abPBAEez9JQR4P0G5+pHcesZ5Vvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=KRATRN/W; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de45dba15feso2266532276.3
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713537916; x=1714142716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDe8m3PGTtm17xos4Wvo0k72yCDO41RF5m2s5L9f6/A=;
        b=KRATRN/WOJ6B9YaW+YXFCmbOf/Uob3FBvLEUjCvaN2pDcqyuw1WOvFldoa954Rz3kT
         XU5YHUURTvqsLq4oahWTbV69lLbqfaTmxAa3HPnfdyjepH3W1aP/0Lv3WbhKVzEGo1PS
         9r7nJPCspxLjeYjyQa6wAgu+VGCOapGpRHDBCj3sS5XijujIu0biOrqESigtzyf9gTQH
         XMVYaoqAdsJp4ILENOo4+wnOTfG87QQz8ncrCWmYIv7G+M4AxMmJZvUe5oGoQXaQr+wr
         aC4pFBoSIvMKAt5ScP8RDAM74dlHJYKdwTCVqiAATo5FYOz3b7abOQMKW8v7ZwWqe0u6
         vwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713537916; x=1714142716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDe8m3PGTtm17xos4Wvo0k72yCDO41RF5m2s5L9f6/A=;
        b=AmRL1Nj5Du3qYPtg5Ouy6ooEdrNtqNMEZWKHDBNRbmD5V/RMxa9ir9Ap/Qp70PypFZ
         rWN+CdVymYb3KTJ9WF5decmOoFMs1c+XwC5tP16mnDpmvJaP2RB7JdcNkQLUGU/kevcl
         xQ331DW5XiBAnjwZkBvVAV7S1SkIBDe3g5sBZonksEOOvtV1X6geoWlH+yUeVqfvcr27
         GhOi31N6GkCs/VtOrqyL3Oa9z8vbDIbdVergGKGe4J4ARnP3WTSe46bSDr34p9oawITj
         1DlqIWz4bNIzd9JD6U5TqvumBvzXxqcU80joypgSuIkr+MDn0lOiAcVaLSYAtfYP9rpc
         skXg==
X-Forwarded-Encrypted: i=1; AJvYcCXMvZdezJeds14nBCoUSpEqWmR92PmCeAd7rxsN5vfPeSVyEzELstPVMqOROggHg/OEt1yB/ujjzTohFTzJWRIt/kdXKBEV
X-Gm-Message-State: AOJu0YyR/RX7IZUGfnfyvxz/+SBHoDN0JFAhNkdBm2YYOCly/UJVPv49
	Z5wky4ZQH5nTxPBuxvgDsCteH4VHnn1wtKiDOXH1JLK3ByXodP7FPVr2fzcyi6dQxuXicyDatFS
	8se+1Zt+NZv/Vxn0RjQvRyGSryTa24lZvQsbz
X-Google-Smtp-Source: AGHT+IHuNBQk7zK69MwzsYiiT7+kSGI39PbnLaoT15m13NmD4aIn6BXO0O4vSMz17ERm9+DlX+gvQXWRy7JM/3FvquM=
X-Received: by 2002:a25:b287:0:b0:dda:d263:360 with SMTP id
 k7-20020a25b287000000b00ddad2630360mr2195890ybj.64.1713537915785; Fri, 19 Apr
 2024 07:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <CAADnVQ+-FBTQE+Mx09PHKStb5X=d1zPt_Q8QYUioUpyKC4TA7A@mail.gmail.com>
 <CAM0EoMknntbtdZY32yjA8pUHMONfZyO8gbxkm31eSKj19NBRhQ@mail.gmail.com> <CAADnVQKapK1iUrX+vED4pq4LGa8sM6V0FgYotvHOuuc+0D+K4A@mail.gmail.com>
In-Reply-To: <CAADnVQKapK1iUrX+vED4pq4LGa8sM6V0FgYotvHOuuc+0D+K4A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 19 Apr 2024 10:45:04 -0400
Message-ID: <CAM0EoMnHsxKHSqGVLWoYQGDDnY-Ew+hMvnY5_jzwfghRGe2EHA@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	khalidm@nvidia.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	victor@mojatatu.com, Pedro Tammela <pctammela@mojatatu.com>, Vipin.Jain@amd.com, 
	dan.daly@intel.com, andy.fingerhut@gmail.com, chris.sommers@keysight.com, 
	mattyk@nvidia.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 10:37=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 19, 2024 at 7:34=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Fri, Apr 19, 2024 at 10:23=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Apr 19, 2024 at 5:08=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > My view is this series should still be applied with the nacks since=
 it
> > > > sits entirely on its own silo within networking/TC (and has nothing=
 to
> > > > do with ebpf).
> > >
> > > My Nack applies to the whole set. The kernel doesn't need this anti-f=
eature
> > > for many reasons already explained.
> >
> > Can you be more explicit? What else would you add to the list i posted =
above?
>
> Since you're refusing to work with us your only option

Who is "us"? ebpf? I hope you are not speaking on behalf of the net subsyst=
em.
You are entitled to your opinion (and aggression) - and there is a lot
of that with you, but this should be based on technical merit not your
emotions.
I summarized the reasons brought up by you and Cilium. Do you have
more to add to that list? If you do, please add to it.

> is to mention my Nack in the cover letter and send it
> as a PR to Linus during the merge window.

You dont get to decide that - I was talking to the networking people.

cheers,
jamal

