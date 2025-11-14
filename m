Return-Path: <netdev+bounces-238745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D0C5EF40
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0AA4134EEC3
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A932DCF5B;
	Fri, 14 Nov 2025 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5qB1pnu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263C2571D8
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146073; cv=none; b=TQgRUNycBbFXDhKyogZCAbupxojzxqMEqisYRYooM64UxAgWV8houw6TaHmFDqJIN5+Y5sWYhb9JZTYzs7Bz29QuQe7AYeNfGuhCqJcMdjYtRAPWsSgqNDmfoIO01FrthxZtuhPyd/lDR6ByLpj0cqx3PReFQEoSbx6cEjoLCys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146073; c=relaxed/simple;
	bh=PwkbzPURFgpzPlHjsrGFOlZMJ7j+Hlg3i1dW7v645Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+AVIa5axTF2yVbDHluSJfw8G/euOMfpOZ9bJ6Np0XcL3NLbbVxLPLWTHj0dD8AAjEMFTkS6KBHrF7VvDsPHV/pIrvzKOmZDvitUrpUArwBeULY5ze9Zl6fjwun/0pcZ1JDVzPWWrjfVu3h82F4nfW9ZzaHfnwCRiZCIAwED/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5qB1pnu; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eda6a8cc12so21878431cf.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 10:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763146067; x=1763750867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gmaZK9lm/BxuX/CeN/n0FQhTSvfGjEN1cjS/HnxR1w=;
        b=X5qB1pnuq8Fe4CpdwGJqFIFXBZjt9lsT6ZVpZX+eSxova6HqA2KRiIfJdvg79bv/d2
         ZhlorW1PKIijW0R/NQkupyJuK2Hri/HDrUKXfM/PibCLI99+gfpCioQXcl21oDLhBo61
         I4WNFr8WItFsncdsx7t+kvgwM/skymQ7tF36YUiTdXTJqe9dg7G8NKL5MbLcoQNyRQHc
         JBE58+edJ58Xa5yA27z6O5oHC21DvinHOwR8ixcYGPGniKBWpi/AYehVvFv2asVhkaAB
         vYrAngQEdI0YcZDAXFmSf+A2y9d/vlkfdZwVxMEHLumm7XAriuyjMpsbdzin5Eq2FTrp
         S6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146067; x=1763750867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3gmaZK9lm/BxuX/CeN/n0FQhTSvfGjEN1cjS/HnxR1w=;
        b=E8UIkAd777ZpDe+50a2hoAv5ib7tBEV/Bjw+n8L2TDscz+NpUHxvc8JgYj/OeY0r5Y
         Dkvx4JjnaPEdgcVowbSMs8e/4zbXM9JQgzXJOAPQxY71NR0GRlCFArbMGU1j02XYX8gA
         EPAUSNlv5UnAkJ12mh2oJZiACGI4Ubwoq86oFfs574qJyvi60l7cbsYS5Z9AB/vT6kdq
         JM7+mdV7obxoQ4adD08n4tgE6yzBOLSEiUkfXWRFQ3tALtp/vlqlE+CULmzSru5iAQmC
         HCx5iDvvQw+/OOxRL73/KaohXxv07LHxXCSPubTqFRRK8G5Yux/gPhtgyAEKcYbi5F6S
         I42g==
X-Forwarded-Encrypted: i=1; AJvYcCV6D8+BX8vRlxl7trCThc4OZEucG1Nl9IkrMIpVVIWWFSpenWraBAXjvBtLK5DE2UlBbkTYjSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4h5mGFu6SfGrr/BneAt4Rg6hYKy5IB+3wr6O8eza/5UIXlVHi
	a8obenr3HSU6mdmxdiTU7AMsVF792bd7vp1kFhDWhqb8f1oc7YB+Vn8LVnZEpwtH7d7KzZCJ9YO
	zbzu+s4Ggi917YMWHgEjoIFUASp5hed8KAiGp4RNE
X-Gm-Gg: ASbGnct9ZrhaNoOSDPzJNBZdFG7u5gACKvu3JnAHPNIK/g0WQKxA1Esf26L3Y6qSEXD
	rBUHtuVEI3SRT1Y7ctngxEYOCqZFwhyUAAjHYFcTJndcHmmKpVgnJRNzJQ+n8pDKRAts8wcPlyH
	LU9hmLa4kxe0hI/P+jQZ/NwDGqFZT5XLFMUBF1kf/gTrgRBg/GPd2xTL5Adp+uONOwUAeCFAC4s
	FsmsLzyWsscDFWI1au54TbJgsnLgxE4P3dZ0gPMQAUbmEJ9b96gk2j7Vd9TlmXMA/dOdg==
X-Google-Smtp-Source: AGHT+IHpeGTjJsCKJ8XgJEFtogzfhEHRMdx478AC6KNyDq5QPm0GAUDCUF5SMHBeBfGH3zYqdh0M2A3txIRZsrm3edw=
X-Received: by 2002:a05:622a:38e:b0:4ed:dc14:b751 with SMTP id
 d75a77b69052e-4edf212fda4mr67351271cf.53.1763146066355; Fri, 14 Nov 2025
 10:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113140358.58242-1-edumazet@google.com> <7da3a15b-c1fc-4a65-bdfc-1cb25659c4db@intel.com>
 <CANn89iJejn+MEBqrXDKxgwPZydU7mMrk2HYZqN+CF9Npyjx7pA@mail.gmail.com> <a9d3ac94-e418-4e5f-a3f1-5cc05cb7c865@intel.com>
In-Reply-To: <a9d3ac94-e418-4e5f-a3f1-5cc05cb7c865@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Nov 2025 10:47:35 -0800
X-Gm-Features: AWmQ_bl3T4eDltBaR4BnThtadOVN58d7iooZlWq1kprHhUJ3RVaoKmgRSRCnwv8
Message-ID: <CANn89iLhp47dfpFc_Ldks6nUtv497TmiBK55o-W7ESW+kj0kHQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: gro: inline tcp_gro_pull_header()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 8:39=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Fri, 14 Nov 2025 08:09:31 -0800
>
> > On Fri, Nov 14, 2025 at 7:56=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Eric Dumazet <edumazet@google.com>
> >> Date: Thu, 13 Nov 2025 14:03:57 +0000
> >>
> >>> tcp_gro_pull_header() is used in GRO fast path, inline it.
> >>
> >> Looks reasonable, but... any perf numbers? bloat-o-meter stats?
> >
> > This is used two times, one from IPv4, one from IPv6.
> >
> > FDO usually embeds this function in the two callers, this patch
> > reduces the gap between FDO and non FDO kernels.
> > Non FDO builds get a ~0.5 % performance increase with this patch, for
> > a cost of less than 192 bytes on x86_64.
>
> I asked for these as you usually provide detailed stats with `perf top`
> output etc, but not this time.

Because I am currently chasing many small optimizations, and they hit
various subsystems.

>
> (although you always require to provide perf stats when someone else
>  sends an optimization patch)
>
> >
> > It might sound small, but adding all these changes together is not smal=
l.
>
> A couple weeks ago you wrote that 1% of perf improvement is "a noise".
>
> I'm not against this patch (if you add everything from the above to the
> commit message + maybe your usual detailed stats).
> +0.5% for 192 bytes sounds good to me (I don't call it "a noise").
>
> But from my PoV this just feels like "my 0.5% is bigger than your 1%"
> and "you have to show me the numbers, and I don't".
>
> The rules are the same for everyone.

Sure, thank you so much !

