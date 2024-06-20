Return-Path: <netdev+bounces-105438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F920911280
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77BB1F22A4A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8CF47A7C;
	Thu, 20 Jun 2024 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1ccJKNO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D15433C4
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912876; cv=none; b=POM4kCMdvS+WU/HC4u3Hqsu31msm4MvjpNLY8sh6zP2LGRZdmAHTxxiDuq3KHuNfid6JvXhCM8nzAVghUkiwBOWRjyrsuw5Vv1SlUm3mk/w88UZu9+gCkSnL51s3HO7LvakZmSosr8ucR1pMRZ5bByekjqu7BYtmIDTzX3YHqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912876; c=relaxed/simple;
	bh=862VnKCkNLOQBFx4YiOtMqgmmlHiFEVEMCgVVYka2b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/rH1Yv+sI/N/Ms0MTT14++NKK+V4EtL3Cw+kPw/3u6bqlQ5K/HhDHLtXigsL3u7EnIeVt6rrrKd1lyHoVyPV8XLYouTN67hpLW0y49W1BEWipqOJNtgljzdK4GeiTcfFCi2Q3FgJOiZ7YaPWac3fRXqxgQm9dqm5wJLnJJgMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1ccJKNO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3653ed8907aso529175f8f.2
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718912873; x=1719517673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNc529DGB2kuH106Zk8B0JpwUGAF1N0DtZphSOYR/oA=;
        b=e1ccJKNOJt2tzyXSUx2TkoB/EjTqYkTSxTzqaVWiqO5gYrGz3zyzsnNHOAxycDlxJH
         Oqowd+uu2DIZW5haxf7TvLOLuu0AD0sZU/F19P0eZ26CppDnmWQBoOC4ljir8Dy1h+la
         23WiafSbHkMiet7XTD3QrGDqHM8lq+RN3pyHZqWRGoQExFPQpkd5IkqKuZTsaO4ToMAP
         XpExof24tzYUjLGlTG9R/SXVCb00TfY+o8uIiug814DBxGcjlz+EOyHh9aVCCeqQ4obF
         kuntbGzTyt2+7VL6NQY8V9BbEdLtDpgWiIgq/TWU8IvUTXnNSzyPTnr0GPc9KLFyycY9
         D2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718912873; x=1719517673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNc529DGB2kuH106Zk8B0JpwUGAF1N0DtZphSOYR/oA=;
        b=nayL66J5VdBVAUrfG5h+AxQ7X/X2BNf/TEArOYXc2E6+sJM1MdOmFLQw3amaOVX8Qg
         LWNJRMI2HGluITLBdCmdfPOfpKbeQYhnBAWNgl5GWfElHk69ueuCiJixW3Pd/s8lvZzU
         MuOOO3K7e52Pr+aVdvWpS4jLyYHUa3cqkcBDDPa03qVrr3ULF3pL/B8j3wtoLhpFclJf
         xfU3BVKXWIuwk9Ll/+Tk07AlEO5ducyec//l73d6cWe1HLvxsZQEXuN7PGZkZigLu8G/
         ds4pWfnCrF6XTUVe1EqGvLcGjzE8iFUJtxrCxLCAwOJ8Ygo1A6MN/AyF5hRiQSTaOAiE
         Xk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/LZklisosw8Ej6TRL26c8hGxCEGpAGko136WozSTTpaIgWbqgKi/yXhjsK0Vai4rNSbG265OzLfeSeHu4nxijxLvKUmf+
X-Gm-Message-State: AOJu0YxNsj1A8dzt7NTTrO2/SEDNA7Bb9usbo1/sNeEDkDXJEhJLvEdS
	mqFuKmiHFTHA7/FE/Rq670URSIIwsiDLfo1jW1P7jxGuiT6F9PuoxJuGqttXKaFkH7rOi6q/WM4
	5w7DV4/3dBfbm8BEMzifJA3JFLbHkwd3Bj2tc
X-Google-Smtp-Source: AGHT+IGrPdVcwRWI9jIOBc7bAbM6sVLQ+zmTwl426aeO1W5z9G541aNdbPXNTDAPA+cczAeOT5b6A7edctQRuwcrJCE=
X-Received: by 2002:a05:6000:1fa4:b0:365:862f:21c8 with SMTP id
 ffacd0b85a97d-365862f260bmr1468996f8f.53.1718912872814; Thu, 20 Jun 2024
 12:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620181736.1270455-1-yabinc@google.com> <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
In-Reply-To: <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 20 Jun 2024 12:47:42 -0700
Message-ID: <CAKwvOd=DkqejWW=CTmaSi8gqopvCsVtj+63ppuR0nw==M26imA@mail.gmail.com>
Subject: Re: [PATCH] Fix initializing a static union variable
To: Yabin Cui <yabinc@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	"Ballman, Aaron" <aaron.ballman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:31=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jun 20, 2024 at 11:17=E2=80=AFAM Yabin Cui <yabinc@google.com> wr=
ote:
> >
> > saddr_wildcard is a static union variable initialized with {}.
> > But c11 standard doesn't guarantee initializing all fields as
> > zero for this case. As in https://godbolt.org/z/rWvdv6aEx,
>
> Specifically, it sounds like C99+ is just the first member of the
> union, which is dumb since that may not necessarily be the largest
> variant.  Can you find the specific relevant wording from a pre-c23
> spec?
>
> > clang only initializes the first field as zero, but the bits
> > corresponding to other (larger) members are undefined.
>
> Oh, that sucks!
>
> Reading through the internal report on this is fascinating!  Nice job
> tracking down the issue!  It sounds like if we can aggressively inline
> the users of this partially initialized value, then the UB from
> control flow on the partially initialized value can result in
> Android's kernel network tests failing.  It might be good to include
> more info on "why this is a problem" in the commit message.
>
> https://godbolt.org/z/hxnT1PTWo more clearly demonstrates the issue, IMO.
>
> TIL that C23 clarifies this, but clang still doesn't have the correct
> codegen then for -std=3Dc23.  Can you please find or file a bug about
> this, then add a link to it in the commit message?
>
> It might be interesting to link to the specific section of n3096 that
> clarifies this, or if there was a corresponding defect report sent to
> ISO about this.  Maybe something from
> https://www.open-std.org/jtc1/sc22/wg14/www/wg14_document_log.htm
> discusses this?

https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3011.htm

https://clang.llvm.org/c_status.html mentions that n3011 was addressed
by clang-17, but based on my godbolt link above, it seems perhaps not?

6.7.10.2 of n3096 (c23) defines "empty initialization" (which wasn't
defined in older standards).

Ah, reading

n2310 (c17) 6.7.9.10:

```
If an object that has static or thread storage duration is not
initialized explicitly, then:
...
=E2=80=94 if it is a union, the first named member is initialized
(recursively) according to these rules, and
any padding is initialized to zero bits;
```

Specifically, "the first named member" was a terrible mistake in the langua=
ge.

Yikes! Might want to quote that in the commit message.

>
> Can you also please (find or) file a bug against clang about this? A
> compiler diagnostic would be very very helpful here, since `=3D {};` is
> such a common idiom.
>
> Patch LGTM, but I think more context can be provided in the commit
> message in a v2 that helps reviewers follow along with what's going on
> here.
>
> >
> > Signed-off-by: Yabin Cui <yabinc@google.com>
> > ---
> >  net/xfrm/xfrm_state.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 649bb739df0d..9bc69d703e5c 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -1139,7 +1139,7 @@ xfrm_state_find(const xfrm_address_t *daddr, cons=
t xfrm_address_t *saddr,
> >                 struct xfrm_policy *pol, int *err,
> >                 unsigned short family, u32 if_id)
> >  {
> > -       static xfrm_address_t saddr_wildcard =3D { };
> > +       static const xfrm_address_t saddr_wildcard;
> >         struct net *net =3D xp_net(pol);
> >         unsigned int h, h_wildcard;
> >         struct xfrm_state *x, *x0, *to_put;
> > --
> > 2.45.2.741.gdbec12cfda-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers

