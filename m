Return-Path: <netdev+bounces-146732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0607A9D550C
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9771128160C
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056AC1BE23C;
	Thu, 21 Nov 2024 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVLUpjoq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D3200A3
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225958; cv=none; b=IwUJZ9UpidBEFS3UB+r00ksMDX3mlBwhTjY9zp6BI0DTOxmbQS44lfQq4pDfjPMdIPrLgIY5h2eigilzcytrds+OM66nloQxcFXOKguq+K+TkeKtzQq0sCNa5amfr+fWiloebJ3rvvRi+zh/KcD1/wlqVu7Z0SUg3YXtSKcVtsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225958; c=relaxed/simple;
	bh=ebtwIn5+4HeiRKmyu+Uj+j8vWGRiKoETFcq1hg/r8sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfkEfhCRc6T/kpbbg9Wt7kLEuv1vfzlMF2vnZJau16TXhGRhNb59/fkfx4s7hXaCzgJfl4Gy5f4klBzZnmj1xUc2JKp1QtVOKuq0wv+o1jvXrX3o18LvhgsPQN/QlDN6S155s6HLLSCj5Z5CpEEessNuq35WInr4GdfHSKVltlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVLUpjoq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9ec86a67feso251791266b.1
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 13:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732225956; x=1732830756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60xrDiN+3e4ZSRUPHqsQG4464T4xOdTRfgXVWcCirfQ=;
        b=LVLUpjoqyp+y3v/nmBkQRQrUopF1OGkzdPivk0bpGgG/l6pB2N/SdsQCZzm+bV/TQV
         BjE70UDyeA1evSRyVH2WqEXzxK5yYhztQ4NQ1aVilxLiQFpF3BVJASXUn+90w0h4LFHj
         2ZKWqH821dKwh3Dfj0Pjact4njKV5Q+F5c2fWYoO1aDCHqgHTzWHMQokb3rOyNFEUVhm
         Gl23CJwyJhD6GHlHJv6Xk6GX6X1/E1TiovK6EnjI0CX2l4Kdr6Sp49zq6VtZ2Vt3CaLv
         yr3/oD4y172PTrzaeBJT1XZhMbI65CjmnB7iHIEHK5hUytow2HV39rvWcsVOrHXAbKy/
         zDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225956; x=1732830756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60xrDiN+3e4ZSRUPHqsQG4464T4xOdTRfgXVWcCirfQ=;
        b=ok/GgiCoS322X7ihxFyqbGJNsyAsyHhVTud4MwNiFEFv8kpGSG2WCaqU20btCFerhx
         pOH46nbeE/hyzcq0RFQHrSlm9T7DFJLXhveOPE79VwO89oe+plD59yHYmMn4cguz840h
         OoV13DJMoiHzpjzxEd2gv41OnHhD3xnp3LNiBdqZg3IaxVPjamLzMk604RF+rZYct3P/
         B+dx9wXBTn6IkzpL84lhqCP7/72K1EMAxah5zcWHBMydeiOBi1N9iCflNpi/4T3lrZo/
         lvsDIQ06wbNNNPNHnCYCWrNlUeanktEd+GwKQC3O9GpL4hFlmoETm4NYhVDZfBjEjktC
         85tQ==
X-Gm-Message-State: AOJu0YwV2804amiCvW2Og+yh2tvdV/4Pk9DJw5yvW8OfTG8vUEKTH+bT
	q/o5N0LMNcVKgy7oTrvhy0Lv2hpnxukhMJUNq4TdkRSpPrrBOJsJ5wrLHxYHZ6iXtuBSo37uNcX
	/xgDIz9u0YhaPcYW6DSv6e3uwMuTwsCOqrOYg
X-Gm-Gg: ASbGncuj2/l6ydhf3wOtDAyAUMPmdk0/f8yHP50ZXxP4yB//y9bbd8TdkrWdQocujVN
	AZXpGAtPzsx32XghFjN886d928GvY/+sm2nDqHLEg/eZvzZxhtfZ72dQKhRQc
X-Google-Smtp-Source: AGHT+IG/F7p1kHWNZYc+MGbhc/nrA820D1QLMs8o5n4GPTVNyiZ3CmiFtvl7fbsyzw0xrYKAgOSyvp6++bH5QsLl94k=
X-Received: by 2002:a17:907:1dd4:b0:a99:ff2c:78fc with SMTP id
 a640c23a62f3a-aa509d12d98mr48040866b.57.1732225955499; Thu, 21 Nov 2024
 13:52:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119220411.2961121-1-wangfe@google.com> <3d487b58-6850-499c-a131-b8169061759a@redhat.com>
In-Reply-To: <3d487b58-6850-499c-a131-b8169061759a@redhat.com>
From: Feng Wang <wangfe@google.com>
Date: Thu, 21 Nov 2024 13:52:24 -0800
Message-ID: <CADsK2K8ni4mttES0TPjV8gJAK7ge53Sstmj3Ep6PNLdxf1AOWg@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet when
 if_id is set
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, leonro@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for your comments, I will upload a new patch to address your
comments soon.

Feng

On Thu, Nov 21, 2024 at 12:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Hi,
>
> On 11/19/24 23:04, Feng Wang wrote:
> > From: wangfe <wangfe@google.com>
>
> Unneeded, since the author (you) matches the submitter email address
> (yours).
>
> BTW please include a patch revision number into the subj prefix to help
> reviewers.
>
> > @@ -240,6 +256,7 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_=
buff *skb)
> >       struct xfrm_state *xs;
> >       struct nsim_sa *tsa;
> >       u32 sa_idx;
> > +     struct xfrm_offload *xo;
>
> This is network driver code, please respect the reverse x-mas tree order
> above.
>
> > diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> > index e5722c95b8bb..59ac45f0c4ac 100644
> > --- a/net/xfrm/xfrm_output.c
> > +++ b/net/xfrm/xfrm_output.c
> > @@ -706,6 +706,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *sk=
b)
> >       struct xfrm_state *x =3D skb_dst(skb)->xfrm;
> >       int family;
> >       int err;
> > +     struct xfrm_offload *xo;
> > +     struct sec_path *sp;
>
> I see the xfrm subtree is more relaxed with the reverse x-mas tree
> order, but for consistency I would respect it even here.
>
> Cheers,
>
> Paolo
>

