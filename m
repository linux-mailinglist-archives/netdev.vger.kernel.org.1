Return-Path: <netdev+bounces-211601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EE0B1A549
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A8B18A2AA5
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECCD20408A;
	Mon,  4 Aug 2025 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4Gklk9u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FE1F4612
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319124; cv=none; b=Wml72ujZuDJEHDLG76Bs34KwTnIMmar2yF6NnLc07Kr7tFeLjAjKiSCwtpKAzC4+42/13PrWSx7QsajlokIK7V+Ynsk/aMnOrv0m4EKNp/JwRjaPWxRgbMWSqcYxIZdXJ2lpjZGPpc/8Ep+vVpl7LjI/xtgTaXoT+BO/SX2iioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319124; c=relaxed/simple;
	bh=2y2cW/nVA+NcdxY9F5J53rimKrYI8WYONjvDon0Weuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txESiKcF/AbfAd3bBAK5poQV9dqwvJ1IdQgbjOlTttfqdGsRIy1lOfSAdXdaeIWd8ckbVZuJsH9pKoUqdZ3tRDaFgxV7+W1JA47HFG3NILRoVkzPLE1Cn5LVF+c6obFm0E0kSTyZgIS3HWs7l+XMkaACTkiier+T1y3zL6HRqYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4Gklk9u; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b0739c6557so10800521cf.3
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754319121; x=1754923921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmE1vMT8V0fPcAqg3vqWWI1l9zeCtCrbJptVBplLKHg=;
        b=I4Gklk9uNjuM6GhzyVknuRJxojDW7cEats09IE6tO25GTA3cxsaEZGTULxiJDqxfy4
         m0Qw3apFcUVJ2Im3yhswMHBB+fcaHAsfbuAUhjkGlXgSKbHBzMtCdG/1f0LJcmv3SFuV
         7/d44xdDGombIdt9LvvoqldtkPm5QXPajM7ZKr7yOS4An3fEwZJ0x+qYoCVE4uVWt9hr
         Fa+fBc9ycC1XthId8JDPdO2ETQlO27hztpVScNTChrg66YY3tDr9GW4nA+m21zglKcpk
         Z3jpouZG0dj8BpCqc+Jvst54+846L0o1fyF7LZ8WRk06A7ksv8EQTUhzEUlJ44YE5Yyh
         71Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319121; x=1754923921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmE1vMT8V0fPcAqg3vqWWI1l9zeCtCrbJptVBplLKHg=;
        b=SAxRGo5gD6b1Jw22TGyOMRl25/mxisoNCr63ELgVEdGggQ5NzCZoTL+NSJdW24jC1U
         AugPoPW+ryKuVzd92t5ojUZYyAZtk90tdfhyiHUvolnTd4Al9oiag6xDvAmmYlejOst5
         NdbB3go/8R160CJ83/Ff/0LVpg6tsOJ6oelg3/j0cdnOXhnE6qn3quzGdHuquFwb3s9D
         PwHsvywY8NEzwt77m4VE5ZPAIXQT/XcgKej5ruQ3qy+781cTMqum0WPKf79QnO4h2Wqj
         j9mOWzLHi38SkSfQ+h7StElK1no2jXd0TIR2tH5KmpVZ/yNe2HUyjCwclxQZPFBv6HyI
         2++g==
X-Forwarded-Encrypted: i=1; AJvYcCW1e64rsoxlNEyXioj7LiTbZHvol/brOZLOdn7hBo1+OVK04zGGn4PxTMg9wSRJuC3esOnPDH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtLFkWHK1TE20fWCsMq40tqT3fezhK4/Qgwc7xp8RpNmSrypA1
	qrAjXHXcZFkQGxsADLpb456xXmyw/tqUpeD3ZmeF2jekhaXE8h1lZ0ODwPoTYzrcjnmku7TeWkf
	fpHXJCFDm5bMVWmG+0LREmj7065DAHD5/cuMNE1dl
X-Gm-Gg: ASbGncv+B3MCUAz0+rHqsJ1rbZOCD3D0ywQWdAbmdMTjNH+GTumTUTAAXmrYZfvNgH2
	NHUdlF35Z+s/g1S4ClFKuLGYTB+QNJYkfUcOvaNEWeGHxcoMOYNlD1sMx8xsgGrGHh/SoFNXP1I
	cPQZCLINnI3ILsw78kb5bLt6WZpbhjWRPwuWXMynzAe5t0Vy4UxegY/LVwyUq4DY3wLsXs2vvek
	TZ/
X-Google-Smtp-Source: AGHT+IFN4OQcigJdLkT1/uANlBF6fmKo4Koz5CBEMaqvT84b+f/4ncu0Dsk2NICeTABkWTTkJzvJUKiP0P4dGY50/5Y=
X-Received: by 2002:ac8:5acd:0:b0:4ab:3a21:c08f with SMTP id
 d75a77b69052e-4af10ad666dmr136169211cf.47.1754319119219; Mon, 04 Aug 2025
 07:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804143918.6007-1-osalbahr@gmail.com>
In-Reply-To: <20250804143918.6007-1-osalbahr@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Aug 2025 07:51:48 -0700
X-Gm-Features: Ac12FXxrPFlqdIJn4rF2OSxwQzoUrreDnpy9ONFpa6xDERAqRhOrr90DDkNoP_Y
Message-ID: <CANn89i+UZOcFKjoTLJtx0M4-TPy1Do6CVsJ7C-OWkoLGQq_F8w@mail.gmail.com>
Subject: Re: [PATCH] net: tcp_ipv4.c: Add missing space
To: Osama Albahrani <osalbahr@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 7:39=E2=80=AFAM Osama Albahrani <osalbahr@gmail.com>=
 wrote:
>
> This commit resolves the following checkpatch.pl error:
>
> ```
> ERROR: spaces required around that '=3D' (ctx:VxW)
> +       .twsk_destructor=3D tcp_twsk_destructor,
>                         ^
> ```
>
> Assuming the purpose was to align the equal signs, I also added a space i=
n
> the previous line.
>
> Signed-off-by: Osama Albahrani <osalbahr@gmail.com>
> ---

I have a patch removing .twsk_destructor completely, waiting for
net-next to open next week.

(DCCP has been removed a while ago)

So I would vote for not bothering with your patch.

