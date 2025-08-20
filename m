Return-Path: <netdev+bounces-215145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96223B2D318
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BC05646A8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC4257848;
	Wed, 20 Aug 2025 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlZLaG0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AEA246781;
	Wed, 20 Aug 2025 04:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664643; cv=none; b=sxrRpF60RscjUp6FZywUaqgG6PH8hySXKvFfJ0vHCTg6gwuUeAxKkoEovNsVEyZdgLp99ByIiBVv5PpU1R0n9b7oK/Ewo+b/MZh1kHYGmRMB04bfW5na4WSSGL/gLGh3Deubh2PIsMUa6L6a0DrJaRkel/RrAmxFrG+cLjDumEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664643; c=relaxed/simple;
	bh=Bv9VjwckBvoU5YMqYa3H6bvn7QRPMvYL90zpwo+4EkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Csvb90CpABEBo2Ak4wIsjfFecqXsrk2b8PlOP9OJP+tpGogy6ptFytfdykJEj4iAAgp5hDkm9xsTkLHVEYjZEHfAt10KCuXc8kOgu9eb9R+/CfxMMMjXFo5+k9XUydacTuh9vBc7CIq3wpImtuWHl5sbOf9HYQQUT6q0lcgrTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlZLaG0A; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb73394b4so901044366b.0;
        Tue, 19 Aug 2025 21:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755664640; x=1756269440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kv/MSyHeFY0oNfqJik+K/LSo8NnFpCP0WfCa9r6wA7U=;
        b=HlZLaG0AlUOit3PU5Kij19z//F3jLqdz2bSP5wwqWrOsCkSYN6XGD4DEHvetzGSXXM
         gL8HEw2qWDXl0fyVnxRuPJC5eAZUuxvT4KyEXVAB4RMtFiGA201BDhE6m19DXWQ3Iog3
         CHrkc3OG/3Hk1XfhVQ65MT+owvULZBDdvW5uYvWFIktdyaJkcrTGiV1ZbSeaz05etSTx
         I31jDj6NpWIjdYv+lacMhH/M1TVOsUsrkKHIIUcyeRNvB17U2CkYhdVQTX0sdny0lyKy
         64mS1XF95WMk6plFE2eqI5WzNKjYDsBtASw0qTpNyMbQeXUaB72HbkTecEvLgL9Dq55x
         ZLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664640; x=1756269440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kv/MSyHeFY0oNfqJik+K/LSo8NnFpCP0WfCa9r6wA7U=;
        b=hpwJSMrBzTYUCQBFIFuBDV13/cDBZjlD/wSwhPamWpZVFjsw+HvRWKN3Pp4mCS+RBB
         Cg1G93ADjEG5k4ZjCN7lRVMkn4z8nP/SmkNy+axMiPjgdeWN9lLE6U4wlsnWRG4e0ml6
         xOWVdgWSp0Bvn1RSZ+FFkfrXz3TiWQA47A5ne7RQ1EPBFarzt3O+iK+nNMuAte/Z97t9
         r7bGrOPLZfqj4nMHXk8HxQ+uvGh/KJkhAKCXCndXPpHOlCCYTspt4BVCU/fwhy/qXP0D
         MNG8bkbuiP8UmmiG9ZZv0+jaLauyPJaMD0fa7zszvYbgmaMDl1tiEOLXTS4puM4jbb6F
         ZQfA==
X-Forwarded-Encrypted: i=1; AJvYcCX1rT50Z3fqg/G0eT2ijaYF+zY9kuo9VQSmRFEw7s+ciAd6JFM7Z1tzNzMnkErPmvVzclGGXSvc@vger.kernel.org, AJvYcCXI/GzCddAfWvQBvOgP0GPjC+acPYVHhCoIkhPjqudnRY0+Fb1qnB4k4/tyqGPnozEWFfPAvaB1K/2CrE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb2Iv06JuervhrSwVgCv1h3nT58FOUuBJbxxASR4yt3MiZycSC
	yvEqtoV1HS13OV8z55mJRUsNm8nvH+7K1lTPq2pHW/ksx/2b8Zr8BlTO5TlUNCcb1wGbOIG55Hs
	EyHjoS0qOMRqKj89rnQF309Ta9i/ruaU=
X-Gm-Gg: ASbGncvQQDdTbcrH6ndVRFOplx2wk9DRR0SC755pUJIMv7UU+vD5zbVUn3F79n5R1wo
	xwNWJu7BSEzncwfLxQw0MqHeGWBZoOjc/9NTfpnoFTDMHCJ6P8TIE8YyhbskuGYxtgDj5V2Qeva
	7bwCczEe1WflEsnkUdbCASxilPkxN/0ZBdkipyzpeUzox+7HIuhTB6DgYHuFUDGwcYO2FIYW2cy
	cFBZ1HR
X-Google-Smtp-Source: AGHT+IHI5uzGB2TjPfbW5XQCH2Ei2yg01pUDHe7XLzbyvRh1cnWqRVhpb2IRJcE7aHPdL1zfWyBLM/7TTFkzspG4xGE=
X-Received: by 2002:a17:907:96a2:b0:afa:1ef1:342a with SMTP id
 a640c23a62f3a-afdf0091142mr137291166b.20.1755664639619; Tue, 19 Aug 2025
 21:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2bac01100416be1edd9b44a963f872a4c25fda03.1755231426.git.jamie.bainbridge@gmail.com>
 <20250819174748.7d5869d3@kernel.org>
In-Reply-To: <20250819174748.7d5869d3@kernel.org>
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date: Wed, 20 Aug 2025 14:37:08 +1000
X-Gm-Features: Ac12FXzhd_cPi-TgZ1g0Dzvxexs8t1W_7SLN1XSPQrvJGOKOy_lkF2yKjfIkARg
Message-ID: <CAAvyFNjo4hC6_L=xdMgz1CvzpHa1Jr0JMuH7xx1WfTs9+f8f3g@mail.gmail.com>
Subject: Re: [PATCH net] qed: Don't write past the end of GRC debug buffer
To: Jakub Kicinski <kuba@kernel.org>
Cc: Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Ariel Elior <Ariel.Elior@cavium.com>, 
	Michal Kalderon <Michal.Kalderon@cavium.com>, Manish Rangankar <manish.rangankar@cavium.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 10:47, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 15 Aug 2025 14:17:25 +1000 Jamie Bainbridge wrote:
> > In the GRC dump path, "len" count of dword-sized registers are read into
> > the previously-allocated GRC dump buffer.
>
> How did you find the issue? Did you happen to have a stack trace?
> It'd be great to know the call trace cause the code is hard to make
> sense of.

We have a customer vmcore and a private Jira Issue with Marvell.
I can submit a v2 with a panic backtrace. However...

> > However, the amount of data written into the GRC dump buffer is never
> > checked against the length of the dump buffer. This can result in
> > writing past the end of the dump buffer's kmalloc and a kernel panic.
>
> I could be misreading but it sounds to me like you're trying to protect
> against overflow on dump_buf, while the code is protecting against going
> over the "feature" buf_size.

I double-checked based on your comment and I have selected the wrong
buffer in the array.

Like you said, it's not easy to follow.

I will resubmit this if possible.

Please disregard this patch for now. Sorry for the bother and thank
you for your review!

Jamie

> > Resolve this by clamping the amount of data written to the length of the
> > dump buffer, avoiding the out-of-bounds memory access and panic.
> >
> > Fixes: d52c89f120de8 ("qed*: Utilize FW 8.37.2.0")
> > Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> > ---
> >  drivers/net/ethernet/qlogic/qed/qed_debug.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
> > index 9c3d3dd2f84753100d3c639505677bd53e3ca543..2e88fd79a02e220fc05caa8c27bb7d41b4b37c0d 100644
> > --- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
> > +++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
> > @@ -2085,6 +2085,13 @@ static u32 qed_grc_dump_addr_range(struct qed_hwfn *p_hwfn,
> >               dev_data->pretend.split_id = split_id;
> >       }
> >
> > +     /* Ensure we don't write past the end of the GRC buffer */
> > +     u32 buf_size_bytes = p_hwfn->cdev->dbg_features[DBG_FEATURE_GRC].buf_size;
> > +     u32 len_bytes = len * sizeof(u32);
>
> Please don't mix code with variable declarations.
>
> > +     if (len_bytes > buf_size_bytes)
> > +             len = buf_size_bytes / sizeof(u32);
>
> The way it's written it seems to be protecting from buffer being too
> big for the feature. In which case you must take addr into account
> and make sure dump_buf was zeroed.
> --
> pw-bot: cr

