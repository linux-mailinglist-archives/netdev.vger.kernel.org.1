Return-Path: <netdev+bounces-178740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2B0A789A7
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C57B3AD4CC
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B727A233D7B;
	Wed,  2 Apr 2025 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5q7HT1S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DAB20C485;
	Wed,  2 Apr 2025 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581868; cv=none; b=POIYFnPw/ndWGQywl3alywFiwDEsH725mZZ2WziwAgkIm27/a4zCKyBoOfnfjG2HOOqcpBBNUjMw1DE1HomzmFCb1q8qTEARvLYMmhy/gUEMEeP/wwg0lJleW54V0yPQMHp4p0IIeGngzohBMJI4rjqw34pX79yn9XNS+UxTmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581868; c=relaxed/simple;
	bh=HXVWXQjZBHgemZIstJDUf3tOUVVLt7xyNaadY5xfUlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjIqU0MSRZJ1MS3mTozYUc3TEKs63sMPHG1jy8+ktlUGJDWnVBKFwBmmh2hGhBylPO4wVDuWMHwQiDVUrWXPAe2hyZfAJC22+5DSnSjmHz5opHWsgN8Lr1ZEDE8MDYCTtsXyksGIonz2otEFDfp2LHsD3d3MoX+XchbvoNFKdXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5q7HT1S; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso3602603fac.0;
        Wed, 02 Apr 2025 01:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743581866; x=1744186666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scXv72Bahse5Ld8quQ31fuwQGCjaKYynLIZEvxwhnnM=;
        b=G5q7HT1Svh/iqZtzJkZ6ae7GXL6T9d6kB1P8G4omOKoomwHjPIcOk5ShScMx48t9zV
         UN+nNo0yxp8Q64W09fSYI1fCZhfuAcVG75Zet6iTSXVewtb8hGpRKBaG0hASzdpx9P0L
         3QYBpCsEs7NdxcxN0z5qIaxmMgGAG/sEbBfHGKq/GX6BeW4Va+yim12ehqW9LoYpPGVT
         DOIVXzpYxa8YECD1Qb6/Z42g9ilpML2FecV0f7fBGmT85mJWLqsdYW5IpwFXezZNFYnG
         f0wDH8XIy2Lt/yjDwH3+vYIM/o4kt4lfqoQJY4NISER70q/5gpltpOikCf0inG9d/gbq
         ZDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743581866; x=1744186666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scXv72Bahse5Ld8quQ31fuwQGCjaKYynLIZEvxwhnnM=;
        b=dW5w28KPntqmOxEtEpQEAUuDxsltgOAe3XSSoUJGza958uvdoi4QpPnLcLJ29MdNn1
         SWhTpFwDw2rlPRst2XqeCqrb8cSNrVrt/kYVvtrb68qhu5jaeEa1ukdSvc9kTmkpLh4e
         uLhf6XkwjhE+bfizY5sAkhYAmnD3vrosT3dAmp9xwbcKfNneLg1uEdS3JEZ48GzyfAZH
         gppywjzLjQeQ30PFnU4QrWkwgbmlRyerM7YyVLWdpl5wSjYmpoYAZsp5nHx1ttTB7zZs
         8yWfSumMtLRy+ODLn91Etdn+/VPQUMkOuBMJ8jiXkLiIdrbP8aLmiCVpkIDsVNv5F+HK
         dVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTPuKK6ULMBaJUhwKkutqvMZAV61CHlSoVZ72ZESqbcXV9YDeAdJtS76Blfh9eq+QqxK+21s9l@vger.kernel.org, AJvYcCWmv4ldkaEv6SHWcXqXAHmMWZmZIZMGMtcVjI4Fbho9npmTkxcH+y5/DGAKNe3wwHAIbgHVftjZlSy+@vger.kernel.org, AJvYcCXmGIETxpHuRbm4b2+GNW8x8ixPnuXB4KQqc2LvumGT4y+7Hg96DsQ+b4fNx78+cgVRORrzo0CyBnkYMm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBkzXNinLo71CULtRIqutgw9Ikj70r5XaahHkBSsYo2sVpvOLw
	w3WuU+mG5fagR39q9+m1J7RCXsG+WkFqGT7y7+UVQzo2w04lTEQsBgwb1Ozhpwl/Wex7Oot4qaS
	+frumSwSccLdHzf0iVkT/zP2XINM=
X-Gm-Gg: ASbGncvTViBSIvgKrLXFw9/OLCtMvsO380baFr09klHypxsiXaVsDkM3ZvdN/wSMXBA
	Rm0u4cjNzjxJti/0SyWlTZH5vRJ3tknF3j4CLZGMlJtz8GnzgfmmfVupz1tNwKCfl2jV25LBJhr
	TFeXKNgYNTOfJ05gUGsAAQ4KLzWJQ=
X-Google-Smtp-Source: AGHT+IHnWOrb0SQAM9qeTR3XznNyfvNQpkps5XgOACrUXiIN2RbZ1nz5GKAlnHeRW4ijLKsnV92MvcmQrgOqdxQHrGY=
X-Received: by 2002:a05:6870:8092:b0:2c2:5369:f3b with SMTP id
 586e51a60fabf-2cc60b0597bmr958285fac.14.1743581866041; Wed, 02 Apr 2025
 01:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743497376.git.luying1@xiaomi.com> <e3646459ea67f10135ab821f90f66d8b6e74456c.1743497376.git.luying1@xiaomi.com>
 <2025040110-unknowing-siding-c7d2@gregkh> <CAGo_G-f_8w9E388GOunNJ329W8UqOQ0y2amx_gMvbbstw4=H2A@mail.gmail.com>
 <2025040121-compactor-lumpiness-e615@gregkh> <CAGo_G-fiR5webo04uoVKTFh3UZaVTzkUgF2OcD8+fY-HzWCO6g@mail.gmail.com>
 <2025040228-mobile-busybody-e5c4@gregkh>
In-Reply-To: <2025040228-mobile-busybody-e5c4@gregkh>
From: Ying Lu <luying526@gmail.com>
Date: Wed, 2 Apr 2025 16:17:35 +0800
X-Gm-Features: AQ5f1Jquh1nJnLrgwYJjGFcAamZNu8xNGhAjeJoDqCgf_Ak9OFRUYZgaxk4j2Z4
Message-ID: <CAGo_G-eptB4ui3UBf2Ey42iFUTnRvLO5dDBVf2drkLQXdMVbzQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usbnet:fix NPE during rx_complete
To: Greg KH <gregkh@linuxfoundation.org>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luying1 <luying1@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 3:12=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Apr 02, 2025 at 08:12:06AM +0800, Ying Lu wrote:
> > On Tue, Apr 1, 2025 at 9:48=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Tue, Apr 01, 2025 at 08:48:01PM +0800, Ying Lu wrote:
> > > > On Tue, Apr 1, 2025 at 6:31=E2=80=AFPM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > > >
> > > > > On Tue, Apr 01, 2025 at 06:18:01PM +0800, Ying Lu wrote:
> > > > > > From: luying1 <luying1@xiaomi.com>
> > > > > >
> > > > > > Missing usbnet_going_away Check in Critical Path.
> > > > > > The usb_submit_urb function lacks a usbnet_going_away
> > > > > > validation, whereas __usbnet_queue_skb includes this check.
> > > > > >
> > > > > > This inconsistency creates a race condition where:
> > > > > > A URB request may succeed, but the corresponding SKB data
> > > > > > fails to be queued.
> > > > > >
> > > > > > Subsequent processes:
> > > > > > (e.g., rx_complete =E2=86=92 defer_bh =E2=86=92 __skb_unlink(sk=
b, list))
> > > > > > attempt to access skb->next, triggering a NULL pointer
> > > > > > dereference (Kernel Panic).
> > > > > >
> > > > > > Signed-off-by: luying1 <luying1@xiaomi.com>
> > > > >
> > > > > Please use your name, not an email alias.
> > > > >
> > > > OK, I have updated. please check the Patch v2
> > > >
> > > > > Also, what commit id does this fix?  Should it be applied to stab=
le
> > > > > kernels?
> > > > The commit  id is 04e906839a053f092ef53f4fb2d610983412b904
> > > > (usbnet: fix cyclical race on disconnect with work queue)
> > > > Should it be applied to stable kernels?  -- Yes
> > >
> > > Please mark the commit with that information, you seem to have not do=
ne
> > > so for the v2 version :(
> > Thank you for your response. Could you please confirm if I understand c=
orrectly:
> > Should we include in our commit message which commit id we're fixing?
>
> No, use the correct "Fixes:" tag format as described in the
> documentation.
>
> thanks,
>
> greg k-h

Oh, I see. Thank you very much for the reminder!
I've already fixed it in the PATCH v3. Could you please take another look?

Thanks,

Ying Lu

