Return-Path: <netdev+bounces-173518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBF3A59419
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA69A3A7DF5
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996BF14F11E;
	Mon, 10 Mar 2025 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a06li0iW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE75846C
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609256; cv=none; b=rjsH15ONmS9xZH1PDTxyLSRa0qsj97d7sDs21l5MuYUCJSzXxVNTQGcXR5VZyiysOL2VzPmWgYvosGC643EPArRcc0AZNzXnMuBib5Bl9keArk/8cIc2Qhocs8QsFHrESq2Fz/ctMqS1AxMsDSXjBWZ0dgCYc+eK+1eVpf3FOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609256; c=relaxed/simple;
	bh=GaiPvZgqEDeihXCcMSYvBlYqT1zlRVes5ePbH+78Ock=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuFLBVu5zv8s7LUPMvppewMkNDzNP5AB8f1GDhwdNl9PRZTO0wYXFP7Fts9FsR2zVgFYGdZrYmml7fq8FpaDG2wt2JHfK9FRZs6T2dPstyzbfxbWctHhP7z5DxD6ryTV+BRUkdR+9br5Jc7tCNAY4PTTuHzAVXh66q6MEy1SGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a06li0iW; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5498c5728aeso6721e87.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741609253; x=1742214053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn9y0DDaYYLNy0ClxtaJySqA2uIGeKxmb4nqVbe1vjk=;
        b=a06li0iWXMjntfQWitC3QXXdHEgv/CHGck7eR5viOCa6I1CJ0N0iVESS27R9vkSYy9
         PlqOYRHMQqI6g9Pt8LISRKIyj+zNfBxMDzkWNO1lXnH+MZ5NkeUmWG/XYGIfZCQ0hgZt
         MEd99I9ZeujFV11RIskhSIUVIbN80RvAaRkE+B1WOgdtIvir12bVSzW4JkvOW3GHFa0w
         /uJBJkRFEB7pzs1MRhBISG/zzwX6QiMzlIVy84NBlyMgNhpWB1l85qCS1U6wcluV5+XG
         fjQ/GQQ01pmdPAOvia5xJExqRefqqbUW8qclDbZxl+DoeeeaKtAbDhKGavAiBQAzlRIG
         AyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741609253; x=1742214053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn9y0DDaYYLNy0ClxtaJySqA2uIGeKxmb4nqVbe1vjk=;
        b=IsqVKK/pVBD0O1RzgdIXXyqXEW5Vw9kTxKm/yj0TgCJmWnictWjfpwy+37cTv9r+Za
         slmbxcKGg9UKJDh0TyEcxcdJ63Q+ZSAKT7wyQnZU4vxFbQ79H64TYakgKamGNLVSVC8M
         l+UPAtldhx3kUmF3Dc0adpUU2M7SSdc67vFVqkSrvMA+46vhkwaEakmoodfgyjixWvD9
         fxB9WRhSrlAM2BSR9BZL46DKdTDgmjdoPvQiwYJKX8QJC0xl85+s4AaNegMsE8IyD9LZ
         tB/2LyFIbwe2mY6kaTGA9I3QtUMeFkCgsVkwpCPm9H5tHwcJLi2MJP9cDHWDPPwzXWsD
         LpxQ==
X-Gm-Message-State: AOJu0YzoFzV/ZgBDk9pPtqQzl2p8TKCFtJY72IsMwntIkHFxsD5OnSGe
	B8aJxFFPP8SyVZgeWLvr7oE41Ad5sRqHfGZD6SDIYesAkPx//okAmJc/xgC5Jt7OllwEapdtnMd
	Cb+21LuMfuCxa0xRoVL9p3lWCb/HGaruph8bG
X-Gm-Gg: ASbGncva6fSa7tA+JAIp2G26ta3gHdTkLKg4kFsnw0F49UWAGuuH2+j0UUykyGbvmqe
	1DF5gJYHYHSyXiJzbyx5zu8cXBhnCVlzRTYbLU/pU0jH7xeBynGp1+4RE9NukdzG5G6+e3r91Jv
	B7ZTpTQ++K+lNbzPTPmxc79ftXEMcpXwW35xeBQU485nYhaBzuHUPgo0ee
X-Google-Smtp-Source: AGHT+IECjE+hBpxYv2/Mdd82xjtafghr88h3x9ZRdhnCj8eiuzXJaPDr8zpDWRK2In0LjxsELGgTOkztDgtHFN/WPJY=
X-Received: by 2002:a05:6512:519:b0:549:4bc4:d3f7 with SMTP id
 2adb3069b0e04-5499993425dmr221376e87.5.1741609251045; Mon, 10 Mar 2025
 05:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310091620.2706700-1-chiachangwang@google.com>
 <20250310091620.2706700-3-chiachangwang@google.com> <20250310115226.GD7027@unreal>
In-Reply-To: <20250310115226.GD7027@unreal>
From: Chiachang Wang <chiachangwang@google.com>
Date: Mon, 10 Mar 2025 20:20:39 +0800
X-Gm-Features: AQ5f1JoXwR4vWLR7rhpbje8KJ1pz0lrBCHXLZEUbwPcX1hmLBpy4hK0eNpNguaA
Message-ID: <CAOb+sWFi+8df32zdAL5AmkfCpFBMG6hU=_+S3U-X_Zd6386r6g@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v4 2/2] xfrm: Refactor migration setup during
 the cloning process
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	stanleyjhu@google.com, yumike@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While the xfrm_state_migrate() is the only caller for this method
currently, this check can be removed indeed.
I add this for the feasibility of other callers without performing the
validation. If you have a strong opinion on this. I can update to
remove this.
Please let me know if you prefer to do so.

Thank you!

Leon Romanovsky <leon@kernel.org> =E6=96=BC 2025=E5=B9=B43=E6=9C=8810=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Mar 10, 2025 at 09:16:20AM +0000, Chiachang Wang wrote:
> > Previously, migration related setup, such as updating family,
> > destination address, and source address, was performed after
> > the clone was created in `xfrm_state_migrate`. This change
> > moves this setup into the cloning function itself, improving
> > code locality and reducing redundancy.
> >
> > The `xfrm_state_clone_and_setup` function now conditionally
> > applies the migration parameters from struct xfrm_migrate
> > if it is provided. This allows the function to be used both
> > for simple cloning and for cloning with migration setup.
> >
> > Test: Tested with kernel test in the Android tree located
> >       in https://android.googlesource.com/kernel/tests/
> >       The xfrm_tunnel_test.py under the tests folder in
> >       particular.
> > Signed-off-by: Chiachang Wang <chiachangwang@google.com>
> > ---
> >  net/xfrm/xfrm_state.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 9cd707362767..0365daedea32 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -1958,8 +1958,9 @@ static inline int clone_security(struct xfrm_stat=
e *x, struct xfrm_sec_ctx *secu
> >       return 0;
> >  }
> >
> > -static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
> > -                                        struct xfrm_encap_tmpl *encap)
> > +static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state=
 *orig,
> > +                                        struct xfrm_encap_tmpl *encap,
> > +                                        struct xfrm_migrate *m)
> >  {
> >       struct net *net =3D xs_net(orig);
> >       struct xfrm_state *x =3D xfrm_state_alloc(net);
> > @@ -2058,6 +2059,12 @@ static struct xfrm_state *xfrm_state_clone(struc=
t xfrm_state *orig,
> >                       goto error;
> >       }
> >
> > +     if (m) {
>
> Why do you need this "if (m)"? "m" should be valid at this stage.
>
> Thanks
>
> > +             x->props.family =3D m->new_family;
> > +             memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
> > +             memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.sa=
ddr));
> > +     }
> > +
> >       return x;

