Return-Path: <netdev+bounces-133427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8233995DCC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863891F25A44
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CF016EB4C;
	Wed,  9 Oct 2024 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoCfIH2N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86D145A0B;
	Wed,  9 Oct 2024 02:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440983; cv=none; b=jQ53AFtw3WDWM41+OS5/+yy33/PfWv5ot+ijoxaB7brmwVNce+QZQdf2Qv0UW+4Jz3JHu6NRyILeC/H2GevAsrey+EkVDCXlJ3a5s7NgrfZ58J/Xxr9P4IpBfJAAfCXVe+u7fY/CpHNJAERktKzeU0gv32C4cyLNtcfGK0Uoqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440983; c=relaxed/simple;
	bh=AW4G+vACFbGgoa2yybZnblrmkAF2Tgw4I1nnodDBDvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECTl+npgwAe0O3GOlsETTwiLCjdr0kAIzho3yCv8uXQVqiSjJ/yCDR9eMzzTjnOlQ+dXxOtFeWCZHehhygSYx6psLWTd8qK5h4+bNFEQynAA5UvU4xixeA7asUEOH3DqMPbFVTbzVeWajBDXrPOSPCu9Bi7kjb1Si9Xc+DMjkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoCfIH2N; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a0c9ff90b1so22179135ab.0;
        Tue, 08 Oct 2024 19:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440980; x=1729045780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5Tej+qg/UeZ1aHpRcx5GHVmFJVifeV+NwGoY1LFZtE=;
        b=KoCfIH2NeMRvU4fzGPPoL2sGS20lbYWwjunN3r3mPxqw14UzJ5P8el+aLoBoN4uY7G
         Ofxjc2WFFSQMwLBN1RSslSM6+fy2BfWjaSNQqgLf7s3r1NbtuFkzbk+R7pF5mbjjJE1h
         26vDDL/kdeWNvaRtaHG4YAE2TSi2r+3DUQ74M77mT+27VxapAmgR53wpZCwXOoa0LSNc
         xgaXm2DZOoiTXfV5fOAjQbvUGF2pRe4NjhajEMRzu308pbmZAU+bgN0DYdMuZvWKjz3H
         X8mTwpN9SI4qV7yAooTdhkfNIsKbbm73F9E1AtxyctUd6W0jv62zrDPfCfrh/CeyowGM
         RYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440980; x=1729045780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5Tej+qg/UeZ1aHpRcx5GHVmFJVifeV+NwGoY1LFZtE=;
        b=dqlbqOt2oK3cULNW8e4A6HFrb/l1Nw/z3MGyzX3dn4KCkBVlbueS9lycPPhTzu3YEG
         mAR02zS6vdZjVbW26WlmcHuE16TJzdIViFxu8VozxZ2/+s/cCnFfUtHTVwHDGVPjBYYX
         DjoQrIdvpGPKbNP/cEvUK/kocJkV1lhYSkCaqGRqhXPiStda9E4TOdCWk+1NK64KuGoY
         l5+z1QWbsAZx8vD/QVrWSCaTMB9sbfPjLCNVx38T8fSmNQkmnVntwqi/VGW3vK0TdUVt
         Mb7NAS09aade/4a+Af8WVzM5IS61nnwf2O4BNvDqiYLHzlasW4X3nWY/xZU2jhOUQ2QV
         bKFA==
X-Forwarded-Encrypted: i=1; AJvYcCUpwlwTqnGzjLqJ0BznXVx7tL8qW7NvpoTobR6GqY2z00Vp9tebYaU/RRK/VN+C8gQviYpsAD3KWEEL5mw=@vger.kernel.org, AJvYcCVE7iD60ZRaTETpW6dLaKULA4LkwBWtJRlj8XQsjbf0NpPbKiigJf+zE+l9bGW4tGkrnwQwBMJ+@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEq2B9Wc7JBvvduTGByP9csgbyT5Y8hrbm6J3oCyOLWF8jpkf
	MsbkwgS09/a5vUDxvFFoy0FDNlzsg2HxUbjOqQwtfW0MZ7By4tgE+d5ZL4P2bph1e3lJXf5oJS8
	ixU1QhZZblSo1m2esAE7HrxiEsAM=
X-Google-Smtp-Source: AGHT+IFyVfOjGkn/5tVznIdEL2GkwGFHkFgwBEm8yVPOCN/v1VeMzC41TEUGbLrFp3WDUDTg7y7pZMn4bhaLPFxsfkk=
X-Received: by 2002:a05:6e02:1a07:b0:3a3:449b:597b with SMTP id
 e9e14a558f8ab-3a397d0fc49mr9239115ab.18.1728440980445; Tue, 08 Oct 2024
 19:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
 <20241008142300.236781-9-dongml2@chinatelecom.cn> <ZwV0cjdg2x67URMx@debian> <CADxym3ZDkjuu9TJQ_vmbky75T+bn32XMrMhQRi=rVtxgRXC_Zw@mail.gmail.com>
In-Reply-To: <CADxym3ZDkjuu9TJQ_vmbky75T+bn32XMrMhQRi=rVtxgRXC_Zw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 10:29:04 +0800
Message-ID: <CAL+tcoAwJCsACt=Cc6HtzCFgBq_TUhmJq7dSuYnbFF5XGETQ_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Guillaume Nault <gnault@redhat.com>, idosch@nvidia.com, kuba@kernel.org, 
	aleksander.lobakin@intel.com, horms@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	dongml2@chinatelecom.cn, amcohen@nvidia.com, bpoirier@nvidia.com, 
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 9:37=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> On Wed, Oct 9, 2024 at 2:05=E2=80=AFAM Guillaume Nault <gnault@redhat.com=
> wrote:
> >
> > On Tue, Oct 08, 2024 at 10:22:56PM +0800, Menglong Dong wrote:
> > > Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Followin=
g
> > > new skb drop reasons are introduced for vxlan:
> > >
> > > /* no remote found for xmit */
> > > SKB_DROP_REASON_VXLAN_NO_REMOTE
> > > /* packet without necessary metadata reached a device which is in
> > >  * "eternal" mode
> >
> > That should be "external" mode (with an "x").
> >
> > > +     /**
> > > +      * @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary met=
adata
> > > +      * reached a device which is in "eternal" mode.
> >
> > Here too.
> >
>
> Oh, my eyes!
>
> I checked this document one by one, and I'm sure there
> are no more typos besides this one.
>

You can try "codespell xxx.patch" to avoid typos easily before
submitting patches.

