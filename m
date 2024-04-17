Return-Path: <netdev+bounces-88678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F18A8320
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 14:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F6B2822B9
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A989B13D293;
	Wed, 17 Apr 2024 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUsoOVEY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D213C8FD
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356733; cv=none; b=L2XhrP3pz1qoaweOlUJlZv6dV0LpUW+CH1wIsUqiKT3t2FmpkuXBj34+3nWpLn+aMnHGhsrdF1cNpQxQ08hFUH6EYqxQiN9iFlxe5ntnvb07LXnEEPZu1VbPlDIZSrnGgIuOWCB1d427V0GehuCmDQ2uvbu5JzmdNS26gaqsh48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356733; c=relaxed/simple;
	bh=KxQa1zXsSJ5TQH3pbDBNaDTXMCQAqdEwEkXt5Zmcpe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyeDuKYeyMOAfuaF2H2aunoRgycZXPZCSmaNZEFceBZj+y33l/XJnlFnE7bxtL2eEWdLND3jF+HdTWtICpyxON64Qjsb34zQDzeBseUOsv+jBQlJhxF2AcSIIkF2YibiY9Yos7itVos4R6ISTTwf7q/P7okXxp9eG/oAvQzceLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUsoOVEY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4715991c32so709701966b.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713356730; x=1713961530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDqIasPh/qOk8r1NFnR+3VsIG0iqk4Jd/z2QKxMLgMA=;
        b=RUsoOVEYC5EUexGebg7J2mPQUoVnv7Goem3XKeCTnyDsuQoTPaaAlaUDJztEBu2Ihm
         PZRLLUF62fT6SlK+eQTcgEaTHzZl416shF4StwYFqawYJd0EJL+pGjiEP+fCQ0eMAiVM
         W1wJosCkv0fBHK5NJjabvC7g0GYs5MDzPUdkvRrOPVtjRJK4EhsQd7BOG3YXQe3nRRia
         sjrXMQM+8p62RGA450ivSSjYat0VtmlBcqeVZq4XS4opB53y8ZyihGtFBdo6LI45+y2e
         OyNIIl2GbOUsEJ0ultru+/NQ1LRLPPMA6S4Bmo8FKi35mpYu+aTuuybGy8x0XwDh/iBE
         +HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713356730; x=1713961530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDqIasPh/qOk8r1NFnR+3VsIG0iqk4Jd/z2QKxMLgMA=;
        b=LMEARStKTMGKYJ2GfxTcmGFq0qHv6A5mtnVe++b1jlxS3/hgQ1wFvUTJ+h5AleuUqI
         oOyXqzuGv9FWXt8t5pUGthvL6e10nTWfuVkRbuK1myeNfcE7qWV7Si41dkcTDXVo9w6x
         yMCJuUzZnMVQawfh4mrQWKZTrR1vb6zLjwyjJOtMIPypcrHsaeaxsYYGByeYatdTxRbk
         H0xYtHavZQ9WuGsFqkvTe/8iXxDUkriJLqVbYiSH8h44qj0LwXKBqNbVsRpX9t7CQa5L
         yiZmJZbRDHGIBpKvJaeiWm78EAAUipwtpmDyi0RJAH270G4+ek2qWPJsZtHZ8TtMHFkK
         trAw==
X-Gm-Message-State: AOJu0YymedXmB2t0zHTxf2ztKnmYKo8w1khNNmLy9QnKDrkduGN/f5Qk
	7Rtkkb1Qj6cLjdAOEITGFXwtfLmZfLmF1xc1E37gW36LUcspVOLiyRBb+WXhhWmah3lwJYuklXA
	yrF+OPMsvtEbFCecJHwifMGSjHgyRIjA6I5s=
X-Google-Smtp-Source: AGHT+IHAGJ3xsRj8pZK4WehfxYiyBMZ7WEtuehK9oOtZmTpOYVsaIYeYSt6M2rlpIU0MAB9nA2I8K6PJD6hmm0iDxng=
X-Received: by 2002:a17:907:9309:b0:a55:4a80:f5d4 with SMTP id
 bu9-20020a170907930900b00a554a80f5d4mr2442205ejc.43.1713356730190; Wed, 17
 Apr 2024 05:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417062721.45652-1-kerneljasonxing@gmail.com> <20240417062721.45652-4-kerneljasonxing@gmail.com>
In-Reply-To: <20240417062721.45652-4-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 20:24:53 +0800
Message-ID: <CAL+tcoCWT5PQ9BG697+AAxhxge2R=XsHgu-GEQjdDxYgLJn3aA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: rps: locklessly access rflow->cpu
To: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, horms@kernel.org
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:27=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> This is the last member in struct rps_dev_flow which should be
> protected locklessly. So finish it.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/core/dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 40a535158e45..aeb45025e2bc 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4533,7 +4533,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff =
*skb,
>                 rps_input_queue_tail_save(&rflow->last_qtail, head);
>         }
>
> -       rflow->cpu =3D next_cpu;
> +       WRITE_ONCE(rflow->cpu, next_cpu);
>         return rflow;
>  }
>
> @@ -4597,7 +4597,7 @@ static int get_rps_cpu(struct net_device *dev, stru=
ct sk_buff *skb,
>                  * we can look at the local (per receive queue) flow tabl=
e
>                  */
>                 rflow =3D &flow_table->flows[hash & flow_table->mask];
> -               tcpu =3D rflow->cpu;
> +               tcpu =3D READ_ONCE(rflow->cpu);

Hello Eric,

I think I don't need this one either, right? Only protecting the
writer side in set_rps_cpu() and the reader side in
rps_may_expire_flow() is enough.

Thanks,
Jason

>
>                 /*
>                  * If the desired CPU (where last recvmsg was done) is
> --
> 2.37.3
>

