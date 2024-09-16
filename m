Return-Path: <netdev+bounces-128467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE0E979A6A
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 06:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3AE283944
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 04:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050DF1F61C;
	Mon, 16 Sep 2024 04:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGS5Khtm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575C6FDC;
	Mon, 16 Sep 2024 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726461562; cv=none; b=ZTkxZS6q6wJWzGmRzArlfcpOldlhq/w3fNiWqtY110M5bb27Mv5RUcGOROR1Y6Go9E5jV4H6SROe6claKKc0NuP9dleAqV+xFZvlFBXoLiUuYJae6d+KUgc7chT2KCKiIVAnk0gihlmiVIM8x3cK2Et2nCQbnfn0colo56oC3Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726461562; c=relaxed/simple;
	bh=ccNWS0CXQYGCbAt+XfNVzaqWXKAJfMEIRtcTqorzicY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzMRYOUr6nE7CRzmKl+o1jMuqiXHSXmPMIAMR9JQ5dN6YbvTPIeFS5wnPs3uwFTLNa7bGk2yVO59EFJrnRw0xiw6uWqkULQBAYmbJruevpbm3Nm3h7rWYHduzvoBj8OA7uMKhe/R+6g9vIpYwrAZn43j/gLkH9OpITCfB6T3T3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGS5Khtm; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e1a9dc3f0a3so3677699276.0;
        Sun, 15 Sep 2024 21:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726461560; x=1727066360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywNuoRzlxy5MLU9hplsYT9vS6S5KYWVvwVTqM6IrrdY=;
        b=nGS5KhtmGvGAQXais8LAkldASLIcIqfGS8x6qzDP8xaU4Or9VAWdTfk0kBDSo34jOp
         QNgeUrG2hWBem51UInXV5vFvRQ9wpGSzDS5hkhVMUfFUETvpe1n70y9O5a3SmJduXQX1
         m46ls8tI+Lr2/fGdcI3rzQ0Mi1nHw24KLpsBmhbNj0jRu3mtzKtBL850jz6PeQjUELEy
         XeV82g/C/GgNHMDUuzMxQcTrmppBOiNmz9qje6MXyvt9hfwikRJUcT2T+HRJhfwuQFBs
         qNNp1DUD9gSOYpPSVAIsNi5XFjX2mzU3qoTO6QE6jVoHCCN3Ep2ciXWxm3X+JlPdyvXh
         7oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726461560; x=1727066360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywNuoRzlxy5MLU9hplsYT9vS6S5KYWVvwVTqM6IrrdY=;
        b=AzHC1jl6xOYJZzrnfmGLnFlI1CGJLrRld90b8bk8K5fojx4mv8h0ZKgk7pzeKYEg+5
         NbnxgfKrEKh8BT3+kY1zE4hf0TknaQx/LJR+PIpLhkP9XE0dfHw6TI2/uDH54Bi60IYn
         gNkxfMEigNXIPLwFTv/LmtGQRMgyUU23o/nutIkIK2fWhpO8c1F6aeZfNa8ySKOzxddH
         gf/b/TIcDAaTiGA8PMNtim7kzakElxjlU19rpN3ZH6LyiITA92yJg9o0KEQplVT13i4i
         x+puXa8GccSycXYPWCcCW66/C+tbw7NWrPN9VfKp+w2tibs5etNq7fW+u73Z21HAO2Tm
         7ZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ98DnTmPi4vc4d9Czh3cl5UbGwdTw300OJCjIUZGYMDuXIOVkXWlOdA8O+Pa0IFi1+y6VBSW0@vger.kernel.org, AJvYcCVb4aupBLkqtiaylvc7H0Kx5PSytpGxIHEGpw2MiKvPuXPtME2pARmkcd3g68iGlGkICBCOH/qxoBWber8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfstMfLJs6DrZ0r5wu0T2lizHAkYNjBmHj3HqiYuCQNJU4ZbF7
	Zig83/ud9YcDge7pSWSRPG7u9zGDXNkMCo5HCiLYPps8uKA8/dg4tMtz+dPp2mesFV++ESmcrOt
	D8HeolP9tOsQni/bCH/EWKiW36lw=
X-Google-Smtp-Source: AGHT+IFn6n3Qt9oQdfguBfTdk/UTyT+FAeZHiiTBUf8xboxZpD1ZlVKYszNbaAJH5t+5TqXkHHVojJqAj6FWOOoQdko=
X-Received: by 2002:a05:6902:15c2:b0:e11:6348:5d95 with SMTP id
 3f1490d57ef6-e1d9db92469mr11244453276.7.1726461560143; Sun, 15 Sep 2024
 21:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
 <20240909071652.3349294-7-dongml2@chinatelecom.cn> <ZuFP9EAu4MxlY7k0@shredder.lan>
 <CADxym3ZUx7v38YU6DpAxLU_PSOqHTpvz3qyvE4B3UhSHR2K67w@mail.gmail.com>
 <CADxym3ZriQCvHcJjCniJHxXFRo_VnVXg-dheym9UYSM-S=euBg@mail.gmail.com> <20240914093332.GF12935@kernel.org>
In-Reply-To: <20240914093332.GF12935@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 16 Sep 2024 12:39:32 +0800
Message-ID: <CADxym3Y3yH_fdyh7tvm-BXdV7YLny3hhFtBSbK+OjJvaBB8BvA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/12] net: vxlan: make vxlan_snoop() return
 drop reasons
To: Simon Horman <horms@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn, 
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com, 
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 5:33=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Sep 13, 2024 at 05:13:41PM +0800, Menglong Dong wrote:
> > On Thu, Sep 12, 2024 at 10:30=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > >
> > > On Wed, Sep 11, 2024 at 4:08=E2=80=AFPM Ido Schimmel <idosch@nvidia.c=
om> wrote:
> > > >
> > > > On Mon, Sep 09, 2024 at 03:16:46PM +0800, Menglong Dong wrote:
> > > > > @@ -1447,7 +1448,7 @@ static bool vxlan_snoop(struct net_device *=
dev,
> > > > >
> > > > >       /* Ignore packets from invalid src-address */
> > > > >       if (!is_valid_ether_addr(src_mac))
> > > > > -             return true;
> > > > > +             return SKB_DROP_REASON_VXLAN_INVALID_SMAC;
> > > >
> > > > [...]
> > > >
> > > > > diff --git a/include/net/dropreason-core.h b/include/net/dropreas=
on-core.h
> > > > > index 98259d2b3e92..1b9ec4a49c38 100644
> > > > > --- a/include/net/dropreason-core.h
> > > > > +++ b/include/net/dropreason-core.h
> > > > > @@ -94,6 +94,8 @@
> > > > >       FN(TC_RECLASSIFY_LOOP)          \
> > > > >       FN(VXLAN_INVALID_HDR)           \
> > > > >       FN(VXLAN_VNI_NOT_FOUND)         \
> > > > > +     FN(VXLAN_INVALID_SMAC)          \
> > > >
> > > > Since this is now part of the core reasons, why not name it
> > > > "INVALID_SMAC" so that it could be reused outside of the VXLAN driv=
er?
> > > > For example, the bridge driver has the exact same check in its rece=
ive
> > > > path (see br_handle_frame()).
> > > >
> > >
> > > Yeah, I checked the br_handle_frame() and it indeed does
> > > the same check.
> > >
> > > I'll rename it to INVALID_SMAC for general usage.
> > >
> >
> > Hello, does anyone have more comments on this series before I
> > send the next version?
>
> Hi,
>
> As you may have noted after posting the above,
> net-next is now closed until after v6.12-rc1 has been released.
> So, most likely, you will need to hold of on posting v4 until then.

Thanks for reminding me that, I'll send the v4 after the net-next
opens.

