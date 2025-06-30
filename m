Return-Path: <netdev+bounces-202371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50188AED95F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2EF3ABC43
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3562505BB;
	Mon, 30 Jun 2025 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZL2k1fMk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A439246BCC
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278088; cv=none; b=EzqdVsbdHlRmmrZqD4YVEiULFgpaTbbRAtxsVrbXD/Yyh8stueFwrx82EStus4cVLZp75CT6xPAV6odiHSpGag0fNeXCsYrpgvftrR6VvTlILMB5ffHSaeq7nqrwzzYjXvsa02loMS73upwB/JzB6ohSihF20nDwmBmdZBUk8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278088; c=relaxed/simple;
	bh=Io7laP75VYb4GRp22Fre3nIbtOhys0hwfpZK4347Dy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV2jHNZVm/NsUnpRYOtIFWDiH7NQO28W8551BV5yJEv64jMFPTawapQ1M4wVIzZ3OBnKskSH/X2s6L2AdBZxrfuAwToBNbzPPQWgbcgLfmL8QfHjPVzTWEnXkLRnsIc+ULml3K3j+S05NK/CCQPNYTd9v+AEXtE3QEynDV3NSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZL2k1fMk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a77ea7ed49so54104341cf.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751278086; x=1751882886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TmyVst97ANhZx4JoTSpaqgbE/dllu1+3Bi73dEFUd4=;
        b=ZL2k1fMkVxo/9f83E/VjbecJxfdOX/B2JjNbODxM4yaWQe07bsxeaZIuhXKvZInGRY
         Zh/sAyy02SRKG3/s2mMDSsdTTI7fX/SeYRDO/4RJeMBV3gtwx9E87V8qhZ6CB0EZPhib
         /vlsbC3vNyFEFo8ETCfhajfWsuEaxWNQ5Cr99Bq0ywtulp3e3nwnqEUhj/eWhy8q68P+
         GUmAiuOtA7Lykm1N0N5cLO7jKPBMy2vyNC8Pk6yp5jHZ5cjIMFhZOWi2V7/3BNJkVPFP
         3vKi1J8Xn+Tp/Il6DL4u0rPbsm6KpLqTSfYmd4HCXB74Vx+ZINvARnl5GZzSF1f6GPQS
         mXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751278086; x=1751882886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TmyVst97ANhZx4JoTSpaqgbE/dllu1+3Bi73dEFUd4=;
        b=SnOo4OGZkB2IWpWrIfklB/XgapFaQvF8HvIhBO9Adopvg56FH18wUcw9uCLJ0EZe2w
         2R/URyHhfyGcoRikjGUDO0NpM7/ZOya8BOGVpaaOrUuSgStOi7QJ+g9qSRGczJEmMxun
         88bQyUEjdMMZ32nkySc8dpKOaS9abCihSScHeAUObc7dJd3sp7C8pZv4v7J79KzTF4CR
         SDfyaQUgjBEfM9FnGbsp2XZnLHQ/P33Mx+zJs+res3U/XgV/sz6Wo80jb0d68mLmQEZE
         3PFYTvpu2Gv4eWVrgHoq0t8fEt0tOCijBQI9CAMf++cOmBkyJ3e3cLqhFqrnehgDQqjc
         dV6g==
X-Forwarded-Encrypted: i=1; AJvYcCUfrxDGJRHKmIjqaHT71kjGj2XXWGIbsvxWN1GK+1Wtt44OfnhjAaRLOfvkH2cNgaErqw8LoXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiTH43g3Jfs0sUYs4zcWPH2uIGm3/7d+nFAbNLzB8/8BZjQ98O
	wBVVO1w29pfy/QdXBy6DC3gVHiD5uua60Cg41JTvndeaC0qiGxt34YWP5+SFL1iwHxFCXkmmCN4
	9rCGdzeIAds7Rsn+0DIRsJBho3c2zj+vwwMC7vjt2
X-Gm-Gg: ASbGncvneAZ49nOZFSsb48hEa8mG4F2sw2LdtA0zVxyG8fXFZk8PMXAK+mWG8FQyt91
	VPgmQrC+CpZrjI5EwhPJg+VETwjp/HKIWRS2yXWFk1K4ikpxhdVNHZDyVWaNLTXMLAWamD5LkAh
	C7z4EhOgfdlKGrcwubdoYy/zHAJvbA8szyDSjdvrzlVc3m
X-Google-Smtp-Source: AGHT+IHnXxZesah7obzb+BfblFfNy5csptaqR2JvX6+9t0UKwGgLkUVyMOjetlAX2F/t36TEFFjslg0D+uqi5+FBa7k=
X-Received: by 2002:a05:622a:4186:b0:494:7076:3422 with SMTP id
 d75a77b69052e-4a7f2eec818mr303576411cf.21.1751278085970; Mon, 30 Jun 2025
 03:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627210054.114417-1-aconole@redhat.com> <20250627145532.500a3ae3@hermes.local>
In-Reply-To: <20250627145532.500a3ae3@hermes.local>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Jun 2025 03:07:54 -0700
X-Gm-Features: Ac12FXxCr129s8-1LVaC2rlQ9FRvhy-gHFVDaDY_nvNoQLCXwpkSpO5lXVyj_oE
Message-ID: <CANn89iK0C+cmhPsikuAztBjppkr6W1NF3mFn0Rh1Npb+yDgzHQ@mail.gmail.com>
Subject: Re: [RFC] net: openvswitch: Inroduce a light-weight socket map concept.
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Aaron Conole <aconole@redhat.com>, dev@openvswitch.org, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	=?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>, 
	Mike Pattrick <mpattric@redhat.com>, Florian Westphal <fw@strlen.de>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Joe Stringer <joe@ovn.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 2:55=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Fri, 27 Jun 2025 17:00:54 -0400
> Aaron Conole <aconole@redhat.com> wrote:
>
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 429fb34b075e..f43f905b1cb0 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -93,6 +93,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const =
struct tcp_md5sig_key *key,
> >  #endif
> >
> >  struct inet_hashinfo tcp_hashinfo;
> > +EXPORT_SYMBOL(tcp_hashinfo);
>
> EXPORT_SYMBOL_GPL seems better here

Even better, not use tcp_hashinfo at all, it will break for netns
having private hash tables.

Instead use :

struct inet_hashinfo *hinfo =3D net->ipv4.tcp_death_row.hashinfo

