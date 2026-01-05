Return-Path: <netdev+bounces-246909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B71CF244F
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 194B23032971
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE5238C33;
	Mon,  5 Jan 2026 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OH+aFBkM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C422BF3E2
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599331; cv=none; b=QDHVyCpMgfI6GpXi2+ZVQSeZsLQqV8/K6bKcjYUtgMLVmc33/kDrRb4dB+m6cOM3tMbyxIt++UgL6Jz1cDFNNovDyOgHQZmKXO8FO2y4d3d2l+fpvz/KeUFIQTrDcTeWITv8NceL6xFITBbhK4p2jVP66JG4hDGYkGA4jzgzdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599331; c=relaxed/simple;
	bh=j2oEn378porabATzocWv7e1aM8zjtpn9UwQbQDPCreI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luTntauCMzQpl7SQQbBeEjEaIQHr6zXM0VGft0mKwho3fgRROx3P3FfpWWwwQMhLag+3ZdnO1PO+G8teIvCphEBN28M+nliULkngriyKxv3Exzu95EysvlTJY+voKBjV7A84XRq56XLa7LK42emWn9F8NII8ATTwqeuZ3Vu1PuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OH+aFBkM; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78fc0f33998so90327627b3.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767599329; x=1768204129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/bmKUL8qRgfsee/YSRKomJGCW1Xn7Kw0x3qvqzn2es=;
        b=OH+aFBkMsiVf2yc2A2cCjzLZFm4dlGqPa19CFAJKwBkyOvgZ+LX6syaDglnbF5Bjla
         S8OlvuwTUKeaWllUVnwOQs+b3GLdcTGsQII3xhsXxTXVJgxXyoKZLNaSeuReW7LyiJOP
         INKKpO8gvL+zuR6H9ubqCYmZ3im5QUT/Bc/j0TIcfnlbtAQEz37PvtHyoHHu0JXHQ7IN
         0geDNl4yaKfd0gKmgnRiTfL41Z5oyUkv2BagqnMYcrmEUPRMxqiHesZ26Y7TnUcjnBbE
         8mLv+i4q1+J7ASO2YIAjAnhmpTKdBlX5KyTH4bgLyg3FB1MeQb3Z2lXtCEdc7X+AJTUf
         fz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767599329; x=1768204129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/bmKUL8qRgfsee/YSRKomJGCW1Xn7Kw0x3qvqzn2es=;
        b=IknXfOYFFnbCdHPTe5/dphNX9OHYumj1GXM+pZjLQEZXt7B5Stlvey+FJWc2JTS6ov
         QGyeOaUIuu4u6daHIerBsxfPX7aem8VDlG8AmsSZr4HK//asptwgeHgBteqeBnWkbIzs
         eU8QSgPeaAAbcXzVNbJCNCuhd+gu5soPcMENTLxyh90+B08+clzacPgslop5SDnWj+lr
         q26asv9HkMyxyAxgo6EamZMWAdMmzCEHbnOmkHSx0HbLThAkaBfxh/Lv5hCWqpDlvg7U
         scJoZOXC99P8a/+xgMC/gFrzI4kduvFG9UaXDm+8tqSv8fz1A8tlsP8zsiPiINFBfRTx
         W4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUusnAdgGlwkJ07fpfBr66l39c9ZfDmcWBmnqlncPVov6Ak4KBE1uDOK359rvjrulL9yWRQYGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8UYDOgvWhtzF4tO5sR9vrBRWWfPNfZtSt08ue9TV/d6gjuA4t
	wge8+UguQAPqvjWA/qhIyw2k1sHRHXRuuIhIBrqtboq78Y5Lj/iiZjprmDEGl0HBiQcsU7+15UR
	mVlMH38tg5i/n4lbFwxskmC3Tj1yviLUq9VaHrep1
X-Gm-Gg: AY/fxX6qxoUAG1m98eTsuqdfCN6ct0rt5xLQJoE4nfRSvV4gRGBZEDOZv2IEqpJig4O
	lOUi7Pcci8sO0gOii5D2yEH3eDqkhEEZvbV6DoaXNw5dQhwo5LHT2gKzF891SBWUd3Olc+kiJeD
	fNj7rfUbtYuL1SfVczzj9sMwupOi7/rhRONbEsf068PdazhuPvY7yiJ2hBqzDTKXVAo11MeEih+
	KKH7pdV5sJOUvdgs2MGMAlW6qVmWDuaONbOkbzqem8Y0Uo0G+afq4wjG2bDxNELyjWM5uEF
X-Google-Smtp-Source: AGHT+IFXwD6cyHsmNMVFhNyUFnv73nXM9DtxTI03TbOYxZoqM7wZ1DoxUWMcaV3/f+02LJFjruPLwy6ZlwuYEsuX4xs=
X-Received: by 2002:a05:690c:6903:b0:786:4459:cb84 with SMTP id
 00721157ae682-78fb3f709d9mr827618377b3.29.1767599328726; Sun, 04 Jan 2026
 23:48:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105064729.800308-1-boolli@google.com> <IA3PR11MB898683A1383A409E8C4B02F6E586A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <CAODvEq5MxAYzDiqNSnxJKNCFR9=LZYt5BD3SMXnNRXJehkYfBg@mail.gmail.com> <IA3PR11MB898663460FABC5C8AE6EC85FE586A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898663460FABC5C8AE6EC85FE586A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Li Li <boolli@google.com>
Date: Sun, 4 Jan 2026 23:48:36 -0800
X-Gm-Features: AQt7F2olVWHj-Q5KbjHeu6UGJFmCgKQmT73Y8neJNidXLmBWOQDX17KdtGjTzxM
Message-ID: <CAODvEq4Fma_N+oRMuuW2X-BbnkSNUxbHiwh6dDA_3Q0YKR_mdw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] idpf: increment completion queue
 next_to_clean in sw marker wait routine
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Decotigny <decot@google.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, 
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	"Tantilov, Emil S" <emil.s.tantilov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 11:43=E2=80=AFPM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
>
>
> From: Li Li <boolli@google.com>
> Sent: Monday, January 5, 2026 8:39 AM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; David S. Miller <davem@davemloft.net>; Jakub=
 Kicinski <kuba@kernel.org>; Eric Dumazet <edumazet@google.com>; intel-wire=
d-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.or=
g; David Decotigny <decot@google.com>; Singhai, Anjali <anjali.singhai@inte=
l.com>; Samudrala, Sridhar <sridhar.samudrala@intel.com>; Brian Vazquez <br=
ianvv@google.com>; Tantilov, Emil S <emil.s.tantilov@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH v2] idpf: increment completion queu=
e next_to_clean in sw marker wait routine
>
>
>
>
>
>
>
> On Sun, Jan 4, 2026 at 11:19=E2=80=AFPM Loktionov, Aleksandr <aleksandr.l=
oktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Li Li via Intel-wired-lan
> > Sent: Monday, January 5, 2026 7:47 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; David S. Miller
> > <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Eric Dumazet
> > <edumazet@google.com>; intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; David
> > Decotigny <decot@google.com>; Singhai, Anjali
> > <anjali.singhai@intel.com>; Samudrala, Sridhar
> > <sridhar.samudrala@intel.com>; Brian Vazquez <brianvv@google.com>;
> > Tantilov, Emil S <emil.s.tantilov@intel.com>; Li Li
> > <boolli@google.com>
> > Subject: [Intel-wired-lan] [PATCH v2] idpf: increment completion queue
> > next_to_clean in sw marker wait routine
> >
> > Currently, in idpf_wait_for_sw_marker_completion(), when an
> > IDPF_TXD_COMPLT_SW_MARKER packet is found, the routine breaks out of
> > the for loop and does not increment the next_to_clean counter. This
> > causes the subsequent NAPI polls to run into the same
> > IDPF_TXD_COMPLT_SW_MARKER packet again and print out the following:
> >
> >     [   23.261341] idpf 0000:05:00.0 eth1: Unknown TX completion type:
> > 5
> >
> > Instead, we should increment next_to_clean regardless when an
> > IDPF_TXD_COMPLT_SW_MARKER packet is found.
> >
> > Tested: with the patch applied, we do not see the errors above from
> > NAPI polls anymore.
> >
> > Signed-off-by: Li Li <boolli@google.com>
> > ---
> > Changes in v2:
> >  - Initialize idpf_tx_queue *target to NULL to suppress the "'target'
> >    uninitialized when 'if' statement is true warning".
> >
> >  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > index 69bab7187e541..452d0a9e83a4f 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -2326,7 +2326,7 @@ void idpf_wait_for_sw_marker_completion(const
> > struct idpf_tx_queue *txq)
> >
> >       do {
> >               struct idpf_splitq_4b_tx_compl_desc *tx_desc;
> > -             struct idpf_tx_queue *target;
> > +             struct idpf_tx_queue *target =3D NULL;
> Linux kernel is against premature initialization just to silence a compil=
er.
> The target variable is dereferenced at idpf_queue_clear(SW_MARKER, target=
))
> but can remain uninitialized if execution jumps to the next: label via a =
goto
> before target is assigned.
> Isn't it?
>
> That is correct. When the following if statement (line 2341-2343) evaluat=
es to true:
>
>
>
>   if (FIELD_GET(IDPF_TXD_COMPLQ_COMPL_TYPE_M, ctype_gen) !=3D
>    IDPF_TXD_COMPLT_SW_MARKER)
>     goto next;
>
>
>
> Then the initialization at line 2346:
>
>
>
>   target =3D complq->txq_grp->txqs[id];
>
>
>
> would be skipped, making "target" uninitialized.
>
>
>
> Therefore, in this patch, I need to initialize "target" to NULL.
>
>
>
> The =E2=80=98NULL=E2=80=99 target variable can be dereferenced at idpf_qu=
eue_clear(SW_MARKER, target)), isn=E2=80=99t it?

That would not be possible, because right before
"idpf_queue_clear(SW_MARKER, target))", "target"
is initialized to "complq->txq_grp->txqs[id]":

  if (FIELD_GET(IDPF_TXD_COMPLQ_COMPL_TYPE_M, ctype_gen) !=3D
    IDPF_TXD_COMPLT_SW_MARKER)
    goto next;

  id =3D FIELD_GET(IDPF_TXD_COMPLQ_QID_M, ctype_gen);
  target =3D complq->txq_grp->txqs[id];

  idpf_queue_clear(SW_MARKER, target);

"target" only remains uninitialized if the if statement above
evaluates to true and skips the initialization.

>
>
>
>
>
>
> >               u32 ctype_gen, id;
> >
> >               tx_desc =3D flow ? &complq->comp[ntc].common :
> > @@ -2346,14 +2346,14 @@ void idpf_wait_for_sw_marker_completion(const
> > struct idpf_tx_queue *txq)
> >               target =3D complq->txq_grp->txqs[id];
> >
> >               idpf_queue_clear(SW_MARKER, target);
> > -             if (target =3D=3D txq)
> > -                     break;
> >
> >  next:
> >               if (unlikely(++ntc =3D=3D complq->desc_count)) {
> >                       ntc =3D 0;
> >                       gen_flag =3D !gen_flag;
> >               }
> > +             if (target =3D=3D txq)
> Are tou sure that incremented ntc value is ever written back to complq->n=
ext_to_clean?
>
>
>
> Yes, the value of "ntc" is written back to "complq->next_to_clean" at the=
 end of the function
>
>  (at line 2360):
>
>
>
>   complq->next_to_clean =3D ntc;
>
> Thank you, I don=E2=80=99t see it from the patch.
>
>
>
>
> > +                     break;
> >       } while (time_before(jiffies, timeout));
> >
> >       idpf_queue_assign(GEN_CHK, complq, gen_flag);
> > --
> > 2.52.0.351.gbe84eed79e-goog

