Return-Path: <netdev+bounces-213081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044DAB23695
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 21:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CC53B416E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432EF26FA77;
	Tue, 12 Aug 2025 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWWqRHWn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE022F83B4;
	Tue, 12 Aug 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025299; cv=none; b=ZP2bEFYtX4PJaF2oQjRoqsrnWAkMH474zaG7sRgoBPpplYUhYo6Igbpz1DMJoEeDhHsQbflhXzyPNogUNVphuxDh5Ek8XtXeLO30AtD7WrNwKO79WL1oWpSwDybYgPsrJN4y93Jt8IZEzf6Hh/iccIHWaSd6LMKyx+UmF0JmJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025299; c=relaxed/simple;
	bh=M/p3pYZE7NgDPFNWKrq7He8MGAFpae6CLjM2PEmsp+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SkXIIgq742p4vylpsk8OQsV2Sl9D1+EuzGFYF8vRGIwiQsOVLV2ayG72QC28QzgBcMGkMVtwo6l2/sMCGSkWL8aGb0/bPSqxduhml+aYDUglU1hnLQIRYwD2JpaUzKFTuoaId/zOHeArifx5lk6sfSmcpW/+wFicfdreqIe+nNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWWqRHWn; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e917b687974so953009276.1;
        Tue, 12 Aug 2025 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755025294; x=1755630094; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJdPfv4oJrrKa85uLhLU8NneF6sIzQNQGxQtBwW81ws=;
        b=EWWqRHWn3qoD1EeGN8cutudOfSrEBXCqc1g3epYvGl+PPT3Y/kd27VmRk3vH8QvTn2
         LcRiX585BsfmVztvv6yATjWmz89tIFVNHR80xwT3CnyixIbmGOD0kf/j0lHMEkCJhNFi
         DuFxhCPRpe/h3xylRlTTxs2aPt/DG9INjKii9Vb2rEYJiDNKa1HleVvSQ+hvL2Nx28U/
         fLiRQigBcfHCn5dgCxzEqpZBl3fMA2KYFDLsXjYZ8vthFglesp1SFC1hL6ZZLsr7o0sN
         AeDKm0CuFcyrVqoQ8UW+EbmpAZYGOr8rR/Ijpa9gQ9PCI1Fs29LpMXQ1UvZcexWUoyXu
         jhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755025294; x=1755630094;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJdPfv4oJrrKa85uLhLU8NneF6sIzQNQGxQtBwW81ws=;
        b=qWCA4pHTtQilVUqFIpYPQLy+6/QUghp1BImNuLluRr3SCn/cuK7oSZA1veTJcIPgxT
         p4Sz3EH9Pw6W8aC7t0y5tvQtmvMPdlh0c2c+KUYWJ6OR5tWy75AfjBXk56XfsjplzNG7
         4OxLIXoSrk305JFs777lzWJbhMx597CguWFoEoNJvetK+vaESnhJ3h5NZ/bCTewVK1/k
         MNGfaSDyqIvaj3/IqHaAHKnXQ2CH8m9A8GUfe3oQqXQuxpf9vZ4nqQEn7LjPU/X3Ug4W
         hmuOav2vy4RhtPXnUhtDWSKvMOWKCnV6A4uU+KC9oHjRe67K+xVjeybsCy4vZnry6/Sz
         Hj5w==
X-Forwarded-Encrypted: i=1; AJvYcCWURW8rhgqQu85ibqP5icC7Z85NnOdpi2BDqDSwCE4rJ+FPhna7OIeVEd+JW5EHBP2oeBdcrNXXLXwXuhM=@vger.kernel.org, AJvYcCWcPjlLKruItScAaE1XuJYfmvIQ9njECmol7gKPgcSOw4PNSgrvMKjvBr8ILtQRXk92Y8JiGDw3@vger.kernel.org
X-Gm-Message-State: AOJu0YxciCOa3vyc/w/HjUxU/WWkw3/iSC/h/psMr0L9yShca+pFTQjN
	uzQ1P5uNgIOsLSL/YwxYVZJzhXrXd2yDfMaia6g3AO1fRoGgglCaB+CX8zIwOYhLM/iHgYh1NZm
	8kPna8H9u0VAJ2G/DrXckNcCLZPVoHuw=
X-Gm-Gg: ASbGncsH9J7QB+Pfz7qihxILvmhI9AGqmE6FxTjLUwKbVtKp8Sc1KoAb17/wKecnd12
	hcC3nN21Q1MEsO6KEJmCnkm3dSMMMFaEg9r8xZpcT07jSPb9nuT7qRbQmmvB9RYII3Ennijl3WZ
	SFCl3nH+ZpjJbMdi93Nz6dz3cMgnpiSmgsvucKrddwlWFAcNrSfjnFK3KBUzLeJK3fn+gbjwfZf
	uAxmd5Qcd04mFnP+a7e9JAmq5IFMz9XFJXdAuShzw==
X-Google-Smtp-Source: AGHT+IGPPLINepNlKnFcr8z4SjIsSnt/rMexZuZnT12hj0cF/2iB0grJ9swlvm70eT5xVdjIhOfhJZt1My2vevHknTI=
X-Received: by 2002:a05:690c:f0f:b0:71b:9482:d53d with SMTP id
 00721157ae682-71d4e583afcmr3655797b3.35.1755025294325; Tue, 12 Aug 2025
 12:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810180339.228231-1-chandramohan.explore@gmail.com> <aJp-qm55O_ka7vSv@MacBook-Air.local>
In-Reply-To: <aJp-qm55O_ka7vSv@MacBook-Air.local>
From: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
Date: Wed, 13 Aug 2025 00:31:22 +0530
X-Gm-Features: Ac12FXxxR-kay0lQFHL4WJVsvGyvbGh-9Np6TBGE-rCLMw2RbPNtLGXCmw5VIeo
Message-ID: <CADBJw5aqQCprGJvG2T4v2_O6BK2dh+2cZRLbyryyktucsqHtVg@mail.gmail.com>
Subject: Re: [PATCH net] Octeontx2-af: Fix negative array index read warning
To: Joe Damato <joe@dama.to>, Chandra Mohan Sundar <chandramohan.explore@gmail.com>, sgoutham@marvell.com, 
	lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com, 
	hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 16:37:14 -0700, Joe Damato wrote:
>A couple pieces of feedback for you:

>1. Since this is a fixes it needs a Fixes tag and a commit SHA that it is =
fixing.

Thank you very much for your feedback.I will add the Fixes tag as suggested=
.

>2. cgx_get_cgxid is called in 3 places, so your patch would probably need =
to
>   be expanded to fix all uses?

Thanks for the suggestion.
I can add a similar check in cgxlmac_to_pf() to check if cgx_id is
negative and return an error.

>Overall though, did you somehow trigger this issue?
>
>It seems like all cases where cgx_get_cgxid is used it would be extremely
>difficult (maybe impossible?) for cgxd to be NULL and for it to return a
>negative value.

I could not reproduce a scenario where cgx_get_cgxid returns a
negative value. However, this issue was reported by the Black Duck
Coverity scan.
The fix was made to cover all possible return paths.

Please advise if you think there=E2=80=99s a better way to address it.

Thanks,
Chandra Mohan Sundar


On Tue, Aug 12, 2025 at 5:07=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> On Sun, Aug 10, 2025 at 11:33:27PM +0530, Chandra Mohan Sundar wrote:
> > The cgx_get_cgxid function may return a negative value.
> > Using this value directly as an array index triggers Coverity warnings.
> >
> > Validate the returned value and handle the case gracefully.
> >
> > Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
> > ---
> >  drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/=
drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> > index 8375f18c8e07..b14de93a2481 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> > @@ -3005,6 +3005,8 @@ static int cgx_print_fwdata(struct seq_file *s, i=
nt lmac_id)
> >               return -EAGAIN;
> >
> >       cgx_id =3D cgx_get_cgxid(cgxd);
> > +     if (cgx_id < 0)
> > +             return -EINVAL;
> >
> >       if (rvu->hw->lmac_per_cgx =3D=3D CGX_LMACS_USX)
> >               fwdata =3D  &rvu->fwdata->cgx_fw_data_usx[cgx_id][lmac_id=
];
>
> A couple pieces of feedback for you:
>
> 1. Since this is a fixes it needs a Fixes tag and a commit SHA that it is=
 fixing.
> 2. cgx_get_cgxid is called in 3 places, so your patch would probably need=
 to
>    be expanded to fix all uses?
>
> Overall though, did you somehow trigger this issue?
>
> It seems like all cases where cgx_get_cgxid is used it would be extremely
> difficult (maybe impossible?) for cgxd to be NULL and for it to return a
> negative value.

