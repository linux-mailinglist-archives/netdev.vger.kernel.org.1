Return-Path: <netdev+bounces-112142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A6937218
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 03:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BC3281B74
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 01:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B42A32;
	Fri, 19 Jul 2024 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFtARIBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6015CB
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721353934; cv=none; b=L4VqrVZVxDG4ufqMQDSjtaRcMf34MlB/nQOBQztjoAiRIzH1xQNjHIvPsVgdIOfqoYZ3eAXUlG4Ya9zbYmeZ9cEJDSUssTsNK3biZTTngk1PnaHDPvKWnTb0QnungzG0nmFr1f5nf5LkzuXLf6kF9m8cwAVkrDlj8Bn5ftxyvxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721353934; c=relaxed/simple;
	bh=XUl1P733PPNfgX/NDlSNZK52UZMhUVKC0goVY2NU5dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MH0Jo0MSUk55+GJanbRpDiwMMAnVhkzR7nOCD6N2b9xj+IKRD1bgt6HkXwGJCENvs/cRRbgR1EmOF38cU/0LBFuQL5W8ORz9jcNpe3TUphCxQGCyaa7z9kvl5QDHBkxTM8LTaB1iGGd2g9rAkDrykUAxxp9LHYHPvcKoaF/2N+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFtARIBq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea879de63so1178e87.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 18:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721353931; x=1721958731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG6v2dmDXP0zBr7n4M7RscIKtOL7XXlzUCOr6fiNfxA=;
        b=vFtARIBqrfr9lgzynPYFlq0PKQkNW5Gu6+/46S6KtC9SxHZLa05nYEvdN4qB5Gr0tp
         Sr9nw2dUD586GqLXmptIuvVrvvZa7C0CN7zFzYFklyEFAclPWA7BdoZdMTg0qpOmf6+U
         SkUxvmwzwJ7do/Rae1MjtVH3zlPrFg/RA/lscFOkVL+iTBXjCcYO4fkBIE9NX8E73LI/
         2/Ay12n9os4115f2+KpegCJHOO3OS0qT9SjjAKkoxHKahDW2D2EdxAc2lQaMGGUfEK9d
         2Xw6/dVuSjWmcPSHv4tuDvI6UA2wXKEQWJZy7f1XLefu4ym766cfdeQk9MZBG8/wJhza
         AnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721353931; x=1721958731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG6v2dmDXP0zBr7n4M7RscIKtOL7XXlzUCOr6fiNfxA=;
        b=rgzIaQWlLVtCDxblPCx47Y8wtC2A2TWj0nGBC/V+vqXFrinfRyKzJw8UEKYHk3EGK9
         0V1IIemZhZ61OdfIAWQH2qIEDHbZCY5TK6H1TAxmnyLVRqRkrd0nUxKjC8LLDLYtLuVV
         wp+FyU+Oukqa9TKi66be728ofW1fcvhoQqcL2qKUHLUt9Xv/3TUinDwNt5ZKFshe80ld
         9FrFd16ZEn+1rwAgkmaVWSUnPaoEHD2Clx2q8Zh7LsARiMl7Ht1vPZ+x8cHvLCIdhvz3
         g1q6eUksJFhEVdYYrXusrDIMpJbkGF+CHzy1mP+m9vcwNoRHcHCS/e4+TZX2gA+OJErs
         hUMQ==
X-Gm-Message-State: AOJu0Yxhfj0WIxMlB6MqScrZ2wRT8kcWvW2DHDe5FVzB/bNvUVWeVOCW
	vWUjnJ/6J7RIg2sZkDCaMOEmzQjx1y2G1aWSuka4DqNkqEU0Czy5KnyWBee1XWeY4NnMUbR9EIv
	fIIEXZj9U0rOlfQAWjRwb+jYEGPcSH0CCA3e5
X-Google-Smtp-Source: AGHT+IGpSt8DWtE0/1gnZmnIXDnkRRnB7rLKdvzdfjas6V6fTRDr+gQAYFRSUf4gOFMKd/+eiezGu8Ndrdvq2PV3xl0=
X-Received: by 2002:a05:6512:3f03:b0:52c:cc9b:be20 with SMTP id
 2adb3069b0e04-52ef4ef6ecemr29785e87.1.1721353930343; Thu, 18 Jul 2024
 18:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718190221.2219835-1-pkaligineedi@google.com> <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch>
In-Reply-To: <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Thu, 18 Jul 2024 18:51:58 -0700
Message-ID: <CA+f9V1PsjukhgLDjWQvbTyhHkOWt7JDY0zPWc_G322oKmasixA@mail.gmail.com>
Subject: Re: [PATCH net] gve: Fix an edge case for TSO skb validity check
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, shailend@google.com, 
	hramamurthy@google.com, csully@google.com, jfraker@google.com, 
	stable@vger.kernel.org, Bailey Forrest <bcf@google.com>, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:07=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:

> > +                      * segment, then it will count as two descriptors=
.
> > +                      */
> > +                     if (last_frag_size > GVE_TX_MAX_BUF_SIZE_DQO) {
> > +                             int last_frag_remain =3D last_frag_size %
> > +                                     GVE_TX_MAX_BUF_SIZE_DQO;
> > +
> > +                             /* If the last frag was evenly divisible =
by
> > +                              * GVE_TX_MAX_BUF_SIZE_DQO, then it will =
not be
> > +                              * split in the current segment.
>
> Is this true even if the segment did not start at the start of the frag?
The comment probably is a bit confusing here. The current segment
we are tracking could have a portion in the previous frag. The code
assumed that the portion on the previous frag (if present) mapped to only
one descriptor. However, that portion could have been split across two
descriptors due to the restriction that each descriptor cannot exceed 16KB.
That's the case this fix is trying to address.
I will work on simplifying the logic based on your suggestion below so
that the fix is easier to follow
>
> Overall, it's not trivial to follow. Probably because the goal is to
> count max descriptors per segment, but that is not what is being
> looped over.
>
The comment
> Intuitive (perhaps buggy, a quick sketch), this is what is intended,
> right?
>
> static bool gve_can_send_tso(const struct sk_buff *skb)
> {
>         int frag_size =3D skb_headlen(skb) - header_len;
>         int gso_size_left;
>         int frag_idx =3D 0;
>         int num_desc;
>         int desc_len;
>         int off =3D 0;
>
>         while (off < skb->len) {
>                 gso_size_left =3D shinfo->gso_size;
>                 num_desc =3D 0;
>
>                 while (gso_size_left) {
>                         desc_len =3D min(gso_size_left, frag_size);
>                         gso_size_left -=3D desc_len;
>                         frag_size -=3D desc_len;
>                         num_desc++;
>
>                         if (num_desc > max_descs_per_seg)
>                                 return false;
>
>                         if (!frag_size)
>                                 frag_size =3D skb_frag_size(&shinfo->frag=
s[frag_idx++]);
>                 }
>         }
>
>         return true;
> }
>
> This however loops skb->len / gso_size. While the above modulo
> operation skips many segments that span a frag. Not sure if the more
> intuitive approach could be as performant.
>
> Else, I'll stare some more at the suggested patch to convince myself
> that it is correct and complete..

