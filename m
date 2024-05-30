Return-Path: <netdev+bounces-99321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D908D474A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1FE2852B1
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 08:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33EE17619A;
	Thu, 30 May 2024 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW5CL7ur"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C3E176185;
	Thu, 30 May 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058360; cv=none; b=NDNZXnJU2k6lFUlI2svnBVNcN67ud0Gv/8bWkvrwKEgI+QCiBGtF4GBtAekocX98a4QPGpJpHqafXqN1l+Bj3IU/65lb2u3sqcrd0zCqIoVeGS0LpKR4rAR2/HV2rNAAtt3Y9v6+3n2Tk/LzkGzFwkm2eBH8xrzwLDBcTKwVHoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058360; c=relaxed/simple;
	bh=oBD7vg86GXe+oDTvDJhgKE8cSH7YYaTNNz6p30fZnDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klitUiQMJxZW7Fr6DjIUjpjmh61NXZzq6UhQvXwMYFZ1PETVIVU3I0FsTvgt2RzwW/aORtiiDIuiKq7RtKzW+EnFnUamjlWHZzwSdz4yKUmFO+AyakNApWVXIQk2v1VqPDrNYcsdRTeHw9w5nqz/SIhzlktFJjl5PxwEeSvlLM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW5CL7ur; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so254558a12.1;
        Thu, 30 May 2024 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717058357; x=1717663157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMJb+X5rFOm/8h5g2VHIevAuWgAsNBn0K9qQmDWI2IA=;
        b=HW5CL7ur+OFLdF6MgA6e+kzYSqDL6fC7bySQZggl9hSqc/fC7GnKM4qsVyhxr7A0ym
         iPSjK9pOTWGUiGXxuS1vPw2ycjNJw4ehJIrkSkAILKxELx5sgOqN1esJj3FuL0UppOLu
         2Aj6lxkBRVHp97RxaMi53M+cxRy7pAB/pmoELlseq3M1YyFEpxFeNCfLRTYCMGNlN7dL
         XhbUGwTtHO4MDoR0ZoIcGTnWHMqJK5w7vuxUaPlu+XdpY14cryT20Kc+XRh21sWXs/Qn
         mvKoZmY6UK1O7/nADpxlMcKBxnnc/afPiOlwapJiQpqqpi5WbgMcREABAqX6KEW/+ZQ4
         QY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058357; x=1717663157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMJb+X5rFOm/8h5g2VHIevAuWgAsNBn0K9qQmDWI2IA=;
        b=J21yle/ozTiSXhmhboQ9iTYx21UxTG/EX02ZqbONUglOsrVD5zciWYh2ncqZiFd0G7
         URcpwfPPfkSbaUBxTtZR4/LBdheDfRe1Gx7dOTQOJ5A4onKtFYX9CmBMeNFrV8rfRlN2
         8tMzmZs7UUWJrN4We++O2OuR163iRpXeW5aGRMJtiDhiBR/5Sm2EOA0e0bZ79lMAXWNA
         aG/pKYap5yQQDtvEkBAckRcTHnSR1qZPprnfn/IPnh9sV8WhO5tQKGi5S4ux5NwM77yC
         Ckl1TlYewLTYaIkafKpWbbq0v884hDlS9So1RDsrhr3NNcS2ZlEcV3dwYM0gyTQQOcgh
         7nrw==
X-Forwarded-Encrypted: i=1; AJvYcCUdCsMHbuah7ddHHKbK+f1q04cUgrFMuFy/fC2ckaSviALYVMq31BuK3TeromHlyWH1rEo1pkAQpjtZQ++vqm+6WfuEsDoHyjcpuH+cb/eHDkq3CjNGb5oGdQXgiLmqiKphVLDYskFweNXwgxsPxNYkNK4IIi1hnbtSjnPEdYDxTk6DRBox0xAoFSLkHDw74qjGcW/GK2bGZ/EF10I=
X-Gm-Message-State: AOJu0YyPAz+yzx7O3fTAaLWPe3qGhMJO5S0FZcnkeVdWkaCeUKBAmX8x
	YmPJV+DjglSmAaEIJDQvQR94N2f6Dy/a0/MWAQ+bCjYWMxUBetkPLdmdE82tQ8HZyIC9HqHAw8n
	h7jFy3Yx9lzS2BP1h4Km1mpdcjEU=
X-Google-Smtp-Source: AGHT+IG7yOFBPDUV2NHqb1k6mZUOqdzgdMdSZX6ZWJyyabNzowuy9EYpTY9T3kf064PGg0Fz4wHjKlI8QOZpr/4OWWU=
X-Received: by 2002:a17:907:11cf:b0:a59:c28a:7ec2 with SMTP id
 a640c23a62f3a-a65e8f6f43bmr92418466b.41.1717058357020; Thu, 30 May 2024
 01:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
 <20240513103813.5666-11-lakshmi.sowjanya.d@intel.com> <ZkH3GP2b9WTz9W3W@smile.fi.intel.com>
 <CY8PR11MB7364D1C85099E4337408EBAFC4F02@CY8PR11MB7364.namprd11.prod.outlook.com>
 <ZlSZ63ST-Pj9CwCh@surfacebook.localdomain> <CY8PR11MB7364118081A77973A9504C4CC4F32@CY8PR11MB7364.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB7364118081A77973A9504C4CC4F32@CY8PR11MB7364.namprd11.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 30 May 2024 11:38:40 +0300
Message-ID: <CAHp75Vevif+oX8Lq9D90ekTSixC6Q2Mfr38HrgVhzq0ab-COyQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] pps: generators: Add PPS Generator TIO Driver
To: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "jstultz@google.com" <jstultz@google.com>, 
	"giometti@enneenne.com" <giometti@enneenne.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Dong, Eddie" <eddie.dong@intel.com>, 
	"Hall, Christopher S" <christopher.s.hall@intel.com>, 
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>, 
	"joabreu@synopsys.com" <joabreu@synopsys.com>, 
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "perex@perex.cz" <perex@perex.cz>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"peter.hilber@opensynergy.com" <peter.hilber@opensynergy.com>, "N, Pandith" <pandith.n@intel.com>, 
	"Mohan, Subramanian" <subramanian.mohan@intel.com>, 
	"T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 8:52=E2=80=AFAM D, Lakshmi Sowjanya
<lakshmi.sowjanya.d@intel.com> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Monday, May 27, 2024 8:04 PM
> > Mon, May 27, 2024 at 11:48:54AM +0000, D, Lakshmi Sowjanya kirjoitti:
> > > > -----Original Message-----
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Sent: Monday, May 13, 2024 4:49 PM
> > > > On Mon, May 13, 2024 at 04:08:11PM +0530,
> > > > lakshmi.sowjanya.d@intel.com
> > > > wrote:

...

> > > > > +static ssize_t enable_store(struct device *dev, struct
> > > > > +device_attribute
> > > > *attr, const char *buf,
> > > > > +                           size_t count)
> > > > > +{
> > > > > +       struct pps_tio *tio =3D dev_get_drvdata(dev);
> > > > > +       bool enable;
> > > > > +       int err;
> > > >
> > > > (1)
> > > >
> > > > > +       err =3D kstrtobool(buf, &enable);
> > > > > +       if (err)
> > > > > +               return err;
> > > > > +
> > > > > +       guard(spinlock_irqsave)(&tio->lock);
> > > > > +       if (enable && !tio->enabled) {
> > > >
> > > > > +               if (!timekeeping_clocksource_has_base(CSID_X86_AR=
T)) {
> > > > > +                       dev_err(tio->dev, "PPS cannot be started =
as clock is
> > > > not related
> > > > > +to ART");
> > > >
> > > > Why not simply dev_err(dev, ...)?
> > > >
> > > > > +                       return -EPERM;
> > > > > +               }
> > > >
> > > > I'm wondering if we can move this check to (1) above.
> > > > Because currently it's a good question if we are able to stop PPS
> > > > which was run by somebody else without this check done.
> > >
> > > Do you mean can someone stop the signal without this check?
> > > Yes, this check is not required to stop.  So, I feel it need not be m=
oved to (1).
> > >
> > > Please, correct me if my understanding is wrong.
> >
> > So, there is a possibility to have a PPS being run (by somebody else) e=
ven if there
> > is no ART provided?
> >
> > If "yes", your check is wrong to begin with. If "no", my suggestion is =
correct, i.e.
> > there is no need to stop something that can't be started at all.
>
> It is a "no", PPS doesn't start without ART.
>
> We can move the check to (1), but it would always be checking for ART eve=
n in case of disable.

Please do,

> Code readability is better with this approach.
>
>         struct pps_tio *tio =3D dev_get_drvdata(dev);
>         bool enable;
>         int err;
>
>         if (!timekeeping_clocksource_has_base(CSID_X86_ART)) {
>                 dev_err(dev, "PPS cannot be started as clock is not relat=
ed to ART");

started --> used

>                 return -EPERM;
>         }
>
>         err =3D kstrtobool(buf, &enable);
>         if (err)
>                 return err;
>
> > > > I.o.w. this sounds too weird to me and reading the code doesn't giv=
e
> > > > any hint if it's even possible. And if it is, are we supposed to
> > > > touch that since it was definitely *not* us who ran it.
> > >
> > > Yes, we are not restricting on who can stop/start the signal.
> >
> > See above. It's not about this kind of restriction.
> >
> > > > > +               pps_tio_direction_output(tio);
> > > > > +               hrtimer_start(&tio->timer, first_event(tio),
> > > > HRTIMER_MODE_ABS);
> > > > > +               tio->enabled =3D true;
> > > > > +       } else if (!enable && tio->enabled) {
> > > > > +               hrtimer_cancel(&tio->timer);
> > > > > +               pps_tio_disable(tio);
> > > > > +               tio->enabled =3D false;
> > > > > +       }
> > > > > +       return count;
> > > > > +}

--=20
With Best Regards,
Andy Shevchenko

