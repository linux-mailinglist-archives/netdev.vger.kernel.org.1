Return-Path: <netdev+bounces-68644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072B38476DA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398DF1C25B91
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EBD14AD02;
	Fri,  2 Feb 2024 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYPLBzsL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37387148FFF
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896784; cv=none; b=gTfHrR0l4IeiBaOk5k9jhNoef2vPCYDFXC1QSAXSKUWUjRBUTmC++gA9r5ZvWZ8KfMOvTG5ORmsPZ+FjdaGB0LQ9PokYejjRsqwzvP7xBCJqN2jVZzYfGhLCj4/4RX5gPBdUwMfqVEEam3TSryQ6UswETXO6yg0PvxHcdnpClSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896784; c=relaxed/simple;
	bh=PbsGV+LRfbFclR41vL+iMrFaR+sc6SmvwNXGlLB70Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aycbBL1U5dmKQhoIakfpVPaRr820d09PzKJq4n9CWiJRe4rdo/twtnB+5hpPqLW3TIsBDmFOv1IHInVfzLBBtlk85defCdFH5hifmw2QJ5wbXLIuPxyOmDo/PafsC34tcrjEVyWZjvq8xH9biw6EBNzDPtDA+o7WuvnM6kD0cvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYPLBzsL; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68873473ce6so11925636d6.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706896782; x=1707501582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEmXtPEVMO3oHchObaEeNLlugLVri5Npjz+Khhebm7g=;
        b=YYPLBzsL1r5Jej00eSNA+2x76YPfjfGMz/iUhshPTOP8Io8RxFdQuNUhZQFJiO+/6M
         dK2CAobNiey7ViP1BJFs3rvQyf9SyTg719z1xdU6zkC8lY6rQcK0UB5SebXKODa2WRtn
         OezM8Vc7N9dx22iitxv7fIsCJZCkL90K2X9EJvh5LscO1Et+oWZ8bnNQ68aLvd5aOa8r
         ebnxZV8fV1KiKjVULog33sCwgWrtTORpnLitkxVzwI0zxL5zPxn5/avtQtPpL/ekDAXb
         Hjz/CH+HjTtat9sZm7pbrff1PtTZm5hC6HZ3EzFnjW8blTcrhFfvlqNHIY1q6Q9xzaq3
         6DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706896782; x=1707501582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEmXtPEVMO3oHchObaEeNLlugLVri5Npjz+Khhebm7g=;
        b=hgfm+H/RG/Q0fg3hYnQV2VGIX+vdgAuGOZn+2qeCv4+XEDmCe7+3F4W9xBa826pO/M
         S+aypxGfRjHzRMvW/XeCra8DjdolgsV/wE5OpXdnqTM78FKG87f2ZEpLjXmrNAETQWMl
         OJWsm1cRdqJcSg+0oHmd5T9ld8orESVkPKZWLrIWwAn/rWA/UanIEuqmQ9MV+EB7qUmN
         bcKpE7C1PpaVADUtdN4JNvHi7WiE8x3iRFVrXsYJoFECeZeNdTzFuWx/HD4wTE4KO+cE
         3WipJyRmc678cfOWSXzPsO3pay/xYPwJ5JvlOwoKLhAI74sawl5uEb8Gb4TMcfsIG6MH
         i1gA==
X-Gm-Message-State: AOJu0Yxbl4JWjjhxPza9+ZCQx55ITOtpdZlL5Xt1vz7M68q6o+1sJ+EF
	IbxDn/5QisVHjRGdBdGowusexTLEeapVNIfh6Ouz2/AG7O3+I7yqx81R6jhPrBXv6bhzuKb/ISa
	vP73tFwP5juYYj0Jx8txhFNTbkZvjn8oKnKdY
X-Google-Smtp-Source: AGHT+IFHffLQtTMSTo5MUK3Dg8CqXbPyFRi0wqCfcGRuk9MxRoFa7PZm9cOEbEUY9T1OOExuntVHNL+xSqTF5WAgEvM=
X-Received: by 2002:a05:6214:1c0d:b0:681:9c10:e33c with SMTP id
 u13-20020a0562141c0d00b006819c10e33cmr11755584qvc.53.1706896781885; Fri, 02
 Feb 2024 09:59:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129202741.3424902-1-aahila@google.com> <ZbvFEtQskK3xzi6y@nanopsycho>
 <CAGfWUPzeWeF-XPGem=VqxG=DaOEMRWnjCcueD+ODsEKLczDEMA@mail.gmail.com> <ZbyXJu0ZO4sZfrV2@nanopsycho>
In-Reply-To: <ZbyXJu0ZO4sZfrV2@nanopsycho>
From: Aahil Awatramani <aahila@google.com>
Date: Fri, 2 Feb 2024 09:59:30 -0800
Message-ID: <CAGfWUPyaSrmWG9eY+TgBwmzP4eHoLf4S8L1HVCGr9p+Akkh5Rg@mail.gmail.com>
Subject: Re: [PATCH net-next v6] bonding: Add independent control state machine
To: Jiri Pirko <jiri@resnulli.us>
Cc: David Dillow <dave@thedillows.org>, Mahesh Bandewar <maheshb@google.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Don't touch procfs here.

OK removing procfs changes.


On Thu, Feb 1, 2024 at 11:18=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Feb 01, 2024 at 07:45:23PM CET, aahila@google.com wrote:
> >> Any chance we can have some coverage via self-tests?
> >
> >I plan to work on these self-tests decoupled from the current patch.
> >
> >> Hmm, I wonder how it makes sense to add new features here. This should
> >> rot.
> >
> >Could you clarify what you are suggesting here?
>
> Don't touch procfs here.
>
> >
> >
> >On Thu, Feb 1, 2024 at 8:28=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Mon, Jan 29, 2024 at 09:27:41PM CET, aahila@google.com wrote:
> >>
> >> [...]
> >>
> >>
> >> >diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/=
bond_procfs.c
> >> >index 43be458422b3..95d88df94756 100644
> >> >--- a/drivers/net/bonding/bond_procfs.c
> >> >+++ b/drivers/net/bonding/bond_procfs.c
> >> >@@ -154,6 +154,8 @@ static void bond_info_show_master(struct seq_file=
 *seq)
> >> >                          (bond->params.lacp_active) ? "on" : "off");
> >> >               seq_printf(seq, "LACP rate: %s\n",
> >> >                          (bond->params.lacp_fast) ? "fast" : "slow")=
;
> >> >+              seq_printf(seq, "LACP coupled_control: %s\n",
> >> >+                         (bond->params.coupled_control) ? "on" : "of=
f");
> >>
> >> Hmm, I wonder how it makes sense to add new features here. This should
> >> rot.
> >>
> >>
> >> >               seq_printf(seq, "Min links: %d\n", bond->params.min_li=
nks);
> >> >               optval =3D bond_opt_get_val(BOND_OPT_AD_SELECT,
> >> >                                         bond->params.ad_select);
> >>
> >> [...]

