Return-Path: <netdev+bounces-105809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D518C912ED2
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 22:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACF628222C
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD7155329;
	Fri, 21 Jun 2024 20:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buhkLp3p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BE16D4CE
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003001; cv=none; b=LNMOk3+3YMeDaxOT0vBfa9UdNklNEE7m0/cJp/GTFCNgJRiitn9TqJuUk5aFlKAlmIEJHAqx09aabSFWcpzOUEwRiwlwjNRhy30qchuMO1AH9YHUvOoYVjP2u7N/J83bbO8GGuIZNTSqo2jWUVqeclFqXBqM7jgh6ld10jqFwgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003001; c=relaxed/simple;
	bh=oS5q7J8IQDOESLzahwwmI6CZ48RzdtStlil8qNQdKYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJ+Y3bCIL+qM73AAnaJAHSMFwnEEdCHg7+wMDZkBC3au3xOcDTYsnB0VnnwgB3X9MTxYh7aMPExZmMqDKCCp+HKV0tnGlIxtFiqj4MiatutuW2VX/10zoYbZTas1n7sqM/QP8uB5n3UN3qxQ+K9CSYVZS+sls6eRBBTlt435KrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=buhkLp3p; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d00a51b71so8854a12.0
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719002998; x=1719607798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btQNo/jIeFme4ijFL164rincWC3kOSPjK8Ryfdoj6D8=;
        b=buhkLp3p9RyXb6qqA+UBNQPZHUv+Hd9/VUrtaqQhLMcG+/OwbaVW17ltKAaiaqVCGm
         91CXLgP93ZqU5/x6gNL6kyEIwUwvoosLD1alFfY+XepO0dNmXA4Diji70prLx+qCEmyh
         8cBuHk7AIP8iAbO5sCNbOrA7YBx5tfXI6HCiSd4FFydX7KWW9y9ppDizt8e9kirq3In7
         kH5X858RkQ8VIMBbjjIJWW9kyjQNRXHLgQNNqbOC7QfXayKIjDfvp36TwBBtw8OpDl7e
         mdRAS5GnBCXr4FsdR5C24nkprLl+nBVd/X5BF50id4WprTRSq0TmyQScyuZqCkAJypyX
         LWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719002998; x=1719607798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btQNo/jIeFme4ijFL164rincWC3kOSPjK8Ryfdoj6D8=;
        b=K/vhdIF647z8xFA/ruQq68D7rgJvlVoDJvo/wqGh1MyCYv/9wahzgDHcA2xucOdKUg
         FDy9KlvaE75auxpy0UvOykjIvswtjjThNlovvbQVeRv+ICXL3uGH6bagudNsCi+r9wNm
         ztAq5j7CvkBHxwEXg6JRMWJbviBVA5P85wTEGeb/Bp6WWVBaLNUdCK+TYdyYByIDvlQk
         NkZn/DMqBXJdmFTWBSpTpvdhg4CPNs5P2DbY6w5uooI96JhuBFkfrhWcyUSvCce2dh4J
         X2QC2GsJifcE5J9I0TP6BUa3/fYnnTVZT0Vyi9xC8Mj9zQ1WgKD8WJK5yH73aW4yI0kI
         zF7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4L2iVYR521plE7Kw61N9TV8gxYNbjDo+n501dUhrtyddkW6XOE2Mjv/scG+0IfGbovohglLkAwU1hYC9XunqX1JseKOet
X-Gm-Message-State: AOJu0YxhKHI7TIo/j025Jh1maZJjduAiDsBoN06QV6mTmRSGcKOvCAVo
	s1Gzgp9VEaprw4ttJDJEfd0rsQsmJ2l2exhNgNWa8wzSUjq5QAW5Ih5OPPMoWS+p+yQm8QUtxqM
	9HkFZtdccg6aqdDn8o6r/MS02ufqzCRF91E8=
X-Google-Smtp-Source: AGHT+IEdVkpp6kfUYZmH8Bgx8yCL7HmRbIRa/IRT5c/6kNfDhfKKlyeBsp35Lx80IesOdn2x0lA0Ys7caGTR/Z9sLH8=
X-Received: by 2002:a05:6402:268d:b0:57c:cfa9:837b with SMTP id
 4fb4d7f45d1cf-57d40ee6696mr40817a12.0.1719002997483; Fri, 21 Jun 2024
 13:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620181736.1270455-1-yabinc@google.com> <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
 <CAKwvOd=DkqejWW=CTmaSi8gqopvCsVtj+63ppuR0nw==M26imA@mail.gmail.com>
 <CAKwvOdm+uudyu_JrHUBBJnU_R4GYprym6HWmcYYyHoCspbcL3Q@mail.gmail.com> <CH3PR11MB8751EEEAD1E6C970F68FF2CBF3C92@CH3PR11MB8751.namprd11.prod.outlook.com>
In-Reply-To: <CH3PR11MB8751EEEAD1E6C970F68FF2CBF3C92@CH3PR11MB8751.namprd11.prod.outlook.com>
From: Yabin Cui <yabinc@google.com>
Date: Fri, 21 Jun 2024 13:49:44 -0700
Message-ID: <CALJ9ZPN-PdYOymzxrWve2X9=dwN=SQemd=wnhv=pee6K7p0QXQ@mail.gmail.com>
Subject: Re: [PATCH] Fix initializing a static union variable
To: "Ballman, Aaron" <aaron.ballman@intel.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> You have to add a Fixes tag, perhaps:
> Fixes: 08ec9af1c062 ("xfrm: Fix xfrm_state_find() wrt. wildcard source
address.")

Thanks! I will add it in the v2 patch.

> And the other thing is that I would change the order in the union, to
> have largest element as the first. Would be best to also add such check
> into static analysis tool/s.

xfrm_address_t is defined in include/uapi. So I am a little hesitant
to change it now.
Currently clang doesn't even have a check/warning to detect this.
I am not sure how clang will fix it in the future, in
https://github.com/llvm/llvm-project/issues/78034.

> This idiom is used throughout the kernel.  If we decide that it
> isn't safe to use then we should change the kernel as a whole rather
> than the one spot that happens to have been identified.

> Alternatively the buggy compiler should be banned until it's fixed.

The problem probably happens in all clang versions, depending on the
optimization flags and inline attributes
used. I found this problem when trying to add
-fdebug-info-for-profiling flag when compiling the code.
This patch is to fix kernel code where the problem happens, before
clang can give a better
solution in https://github.com/llvm/llvm-project/issues/78034.


On Fri, Jun 21, 2024 at 4:25=E2=80=AFAM Ballman, Aaron <aaron.ballman@intel=
.com> wrote:
>
> Sadly, this is not a bug in Clang but is the terrible way C still works i=
n C23. =E2=98=B9 See C23 6.7.11p11, the last bullet:
>
> if it is a union, the first named member is initialized (recursively) acc=
ording to these rules, and any padding is initialized to zero bits.
>
> So the padding gets initialized as does the first member, but if the firs=
t member is not the largest member in the union, that leaves other bits uni=
nitialized. This happened late during NB comment stages, which is why N2900=
 and N3011 give the impression that the largest union member should be init=
ialized.
>
> That said, maybe there's appetite within the community to initialize the =
largest member as a conforming extension. The downside is that people not p=
laying tricks with their unions may end up paying additional initialization=
 cost that's useless, in pathological cases. e.g.,
>
> int main() {
>   union U {
>     int i;
>     struct {
>       long double huge[1000];
>     } s;
>   } u =3D {}; // This is not a brilliant use of unions
>   return u.i;
> }
>
> But how often does this matter for performance -- I have to imagine that =
most unions make use of most of the memory needed for their members instead=
 of being lopsided like that. If we find some important use case that has s=
ignificantly worse performance, we could always add a driver flag to contro=
l the behavior to let people opt into/out of the extension.

I guess if people don't want the cost of zero initializing a union
variable, they will not use "=3D {}". And the situation that using "=3D
{}" only zero initializes the first member of a union variable isn't
very intuitive.

>
> ~Aaron
>
> -----Original Message-----
> From: Nick Desaulniers <ndesaulniers@google.com>
> Sent: Thursday, June 20, 2024 3:54 PM
> To: Yabin Cui <yabinc@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>; Herbert Xu <herbert@=
gondor.apana.org.au>; David S. Miller <davem@davemloft.net>; Eric Dumazet <=
edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni=
@redhat.com>; Nathan Chancellor <nathan@kernel.org>; Bill Wendling <morbo@g=
oogle.com>; Justin Stitt <justinstitt@google.com>; netdev@vger.kernel.org; =
linux-kernel@vger.kernel.org; llvm@lists.linux.dev; Ballman, Aaron <aaron.b=
allman@intel.com>
> Subject: Re: [PATCH] Fix initializing a static union variable
>
> On Thu, Jun 20, 2024 at 12:47=E2=80=AFPM Nick Desaulniers <ndesaulniers@g=
oogle.com> wrote:
> >
> > On Thu, Jun 20, 2024 at 12:31=E2=80=AFPM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Thu, Jun 20, 2024 at 11:17=E2=80=AFAM Yabin Cui <yabinc@google.com=
> wrote:
> > > >
> > > > saddr_wildcard is a static union variable initialized with {}.
> > > > But c11 standard doesn't guarantee initializing all fields as zero
> > > > for this case. As in https://godbolt.org/z/rWvdv6aEx,
> > >
> > > Specifically, it sounds like C99+ is just the first member of the
> > > union, which is dumb since that may not necessarily be the largest
> > > variant.  Can you find the specific relevant wording from a pre-c23
> > > spec?
> > >

I feel it's unspecified in pre-c23 spec.
From https://en.cppreference.com/w/c/language/struct_initialization,
When initializing an object of struct or union type, the initializer
must be a non-empty,(until C23).

> > > > clang only initializes the first field as zero, but the bits
> > > > corresponding to other (larger) members are undefined.
> > >
> > > Oh, that sucks!
> > >
> > > Reading through the internal report on this is fascinating!  Nice
> > > job tracking down the issue!  It sounds like if we can aggressively
> > > inline the users of this partially initialized value, then the UB
> > > from control flow on the partially initialized value can result in
> > > Android's kernel network tests failing.  It might be good to include
> > > more info on "why this is a problem" in the commit message.
> > >
> > > https://godbolt.org/z/hxnT1PTWo more clearly demonstrates the issue, =
IMO.

Great, I will use it in the v2 patch.

> > >
> > > TIL that C23 clarifies this, but clang still doesn't have the
> > > correct codegen then for -std=3Dc23.  Can you please find or file a
> > > bug about this, then add a link to it in the commit message?
> > >
> > > It might be interesting to link to the specific section of n3096
> > > that clarifies this, or if there was a corresponding defect report
> > > sent to ISO about this.  Maybe something from
> > > https://www.open-std.org/jtc1/sc22/wg14/www/wg14_document_log.htm
> > > discusses this?
> >
> > https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3011.htm
> >
> > https://clang.llvm.org/c_status.html mentions that n3011 was addressed
> > by clang-17, but based on my godbolt link above, it seems perhaps not?
>
> Sorry, n3011 was a minor revision to
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2900.htm
> which is a better citation for this bug, IMO.  I still think the clang st=
atus page is wrong (for n2900) and that is a bug against clang that should =
be fixed (for c23), but this kernel patch still has merit (since the issue =
I'm referring to in clang is not what's leading to the test case failures).
>

I totally agree with you. And if clang fixes the support, I guess it
will not be limited to c23.

> >
> > 6.7.10.2 of n3096 (c23) defines "empty initialization" (which wasn't
> > defined in older standards).
> >
> > Ah, reading
> >
> > n2310 (c17) 6.7.9.10:
> >
> > ```
> > If an object that has static or thread storage duration is not
> > initialized explicitly, then:
> > ...
> > =E2=80=94 if it is a union, the first named member is initialized
> > (recursively) according to these rules, and any padding is initialized
> > to zero bits; ```
> >
> > Specifically, "the first named member" was a terrible mistake in the la=
nguage.
> >
> > Yikes! Might want to quote that in the commit message.
> >
> > >
> > > Can you also please (find or) file a bug against clang about this? A
> > > compiler diagnostic would be very very helpful here, since `=3D {};`
> > > is such a common idiom.
> > >

Reported to clang upstream in
https://github.com/llvm/llvm-project/issues/78034#issuecomment-2183233517.
It's a problem that still happens in the c23 standard.


> > > Patch LGTM, but I think more context can be provided in the commit
> > > message in a v2 that helps reviewers follow along with what's going
> > > on here.
> > >
> > > >
> > > > Signed-off-by: Yabin Cui <yabinc@google.com>
> > > > ---
> > > >  net/xfrm/xfrm_state.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c index
> > > > 649bb739df0d..9bc69d703e5c 100644
> > > > --- a/net/xfrm/xfrm_state.c
> > > > +++ b/net/xfrm/xfrm_state.c
> > > > @@ -1139,7 +1139,7 @@ xfrm_state_find(const xfrm_address_t *daddr, =
const xfrm_address_t *saddr,
> > > >                 struct xfrm_policy *pol, int *err,
> > > >                 unsigned short family, u32 if_id)  {
> > > > -       static xfrm_address_t saddr_wildcard =3D { };
> > > > +       static const xfrm_address_t saddr_wildcard;
> > > >         struct net *net =3D xp_net(pol);
> > > >         unsigned int h, h_wildcard;
> > > >         struct xfrm_state *x, *x0, *to_put;
> > > > --
> > > > 2.45.2.741.gdbec12cfda-goog
> > > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers

