Return-Path: <netdev+bounces-89761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258508AB747
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 00:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF81B21933
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 22:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BFC13D630;
	Fri, 19 Apr 2024 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7t8xvfO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91191364AA
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565989; cv=none; b=aH+mU2KQOhXa/QBogW90BOygB2AL0rPnPxBWAFHBmnqurKS8luyi/RmpiJl8q9uYlNmJhJhenL6wccu823BApbnSdiyncbFftaZtmmkWLQM8xsJxubSY2TGtzb37Eg5ITFKpldibzmFNRkXN4J0caHaTCJw0D8753Yr2W49ah1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565989; c=relaxed/simple;
	bh=qo7/N5ZF9+TTT+lb3wooerYp+x/U68ObQtBJ6S9FeKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6nldTPfCDWWZ0JgYHTeY/PjRdwBVB+4AlxBVkFomQZpMlaiAcwXVc82+Ilr9jZAL1wx+4x/rqG8YGmjFKT0oP3HM44SLOHqBc9op8U2T6nwnap0oCShtWaLvlUCPoCekflj2IebSgapqeXsBIO55P+064yNRea3pdaEvISsT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7t8xvfO; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ad21f3e5dcso585104eaf.3
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713565985; x=1714170785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EICelP/lE33eIq2U0CujJA6vcfBMPCSauA8jxb4szvI=;
        b=u7t8xvfOt/2PWWJX0GO62wwDFNOiCd8dcypkXmGjKbNPru2pGrz+Teg+hsmHdmJI8c
         rh4d8mhsPsV+AgOtH/JgYleSZ1eehf7K91JZvGrds1erFAeAqNSfBNiZaBP5Z31am7SI
         C4tplUS5i1avIkZWzrl99QzjpxxnS93+6mHgOrq3wamx4Ijz7w+WeDiJsQKeSZbZ8Dsk
         UcroIMFtqiUcFwkRYIa0/KLPM0DekD3JFGzbZSoOlE3xiwqrdne96nAjnqD39ub+Qs8X
         /uVrpqkTz2qoT0oLQGLAZ+Eeyr/7Xsr8l4VLGVbYgOlyi6Wp3ca4042DQjaNHqDHe6kM
         oNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713565985; x=1714170785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EICelP/lE33eIq2U0CujJA6vcfBMPCSauA8jxb4szvI=;
        b=YuDD54aERQsklQAlvdgIkT65a/XroeqySmzViQ4oPTjIDgloa6iJPy8b83ua5B+4hI
         gRGdyAFkHGnXagwqUN0San87IYcWfmNMgsVSvAChtYfUEknE4litBF2ILkuZtzLqLJTX
         SJBhVUtBZv7kQ12Qc3HjGrPXFGA6LlGccuECk9fCMw7x3mWKa06i0DAKWgeiQM6bQzvF
         EA6QzE7Seuj9R+3Ong6ZDiGGixYXz3HtnNfodU+fuqcslCNYxiPqlHlCt4Uf0v2mvNeb
         Gc5YaVhrIDtuliSKPhzsk5XS/kpcOfx7Y28PjjpOrjcvloJsdOUbfLR3o8Nhc6/3Np+D
         1XjQ==
X-Gm-Message-State: AOJu0YzOYZAZnKLkf3Aa4Qo3VwxH/uVrr+HEAgP0Knz631gh/bxjg62E
	rQ9fACu14YCF+736UEoC5ml55PUN66v8bl/73ru3vSNXXcYLbYVKjlfW0qlzEb5VheSpXSVGREw
	bcEgWz4X4KwNWR+okd8OW8AQloe95KD8zSWaL
X-Google-Smtp-Source: AGHT+IHEnnhJ3TpniFY55Ans9kw7hmgu60cCGtL/COtzPJLQc4/WppOPvC3h7Nu+VstK2Zo6B4TfM66ODjZpeYGOcBQ=
X-Received: by 2002:a05:6358:5d8e:b0:185:fc1f:23ab with SMTP id
 s14-20020a0563585d8e00b00185fc1f23abmr4306920rwm.6.1713565985270; Fri, 19 Apr
 2024 15:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418042706.1261473-1-maheshb@google.com> <87cyqmx850.ffs@tglx>
In-Reply-To: <87cyqmx850.ffs@tglx>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Fri, 19 Apr 2024 15:32:37 -0700
Message-ID: <CAF2d9jjeYACm3ueLPjiYqNMBXrJ3U2dnWqKx-AbgRWLVLz+qUw@mail.gmail.com>
Subject: Re: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally in
 mono-raw base.
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Sagi Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:56=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Apr 17 2024 at 21:27, Mahesh Bandewar wrote:
>
> Subject: ptp: update gettimex64 to provide ts optionally in mono-raw base=
.
>
> Can we please have proper sentences without cryptic abbreviations? This
> is not twatter or SMS.
>
character limit in the description is the limiting factor.

> Aside of that this is not about updating gettimex64(). The fact that
> this is an UAPI change is the real important information. gettimex64()
> is only the kernel side implementation detail.
>
>    ptp/ioctl: Support MONOTONIC_RAW timestamps forPTP_SYS_OFFSET_EXTENDED
>
> or something like that.
>
ack.

> > The current implementation of PTP_SYS_OFFSET_EXTENDED provides
> > PHC reads in the form of [pre-TS, PHC, post-TS]. These pre and
> > post timestamps are useful to measure the width of the PHC read.
> > However, the current implementation provides these timestamps in
> > CLOCK_REALTIME only. Since CLOCK_REALTIME is disciplined by NTP
> > or NTP-like service(s), the value is subjected to change. This
> > makes some applications that are very sensitive to time change
> > have these timestamps delivered in different time-base.
>
> The last sentence does not make any sense to me.
>
> > This patch updates the gettimex64 / ioctl op PTP_SYS_OFFSET_EXTENDED
>
> git grep 'This patch' Documentation/process/
>
> > to provide these (sandwich) timestamps optionally in
> > CLOCK_MONOTONIC_RAW timebase while maintaining the default behavior
> > or giving them in CLOCK_REALTIME.
>
> This change log lacks a proper explanation why this is needed and what's
> the purpose and benefit.
>
> Aside of that it fails to mention that using the currently unused
> reserved field is correct because CLOCK_REALTIME =3D=3D 0.
>
> > ~# testptp -d /dev/ptp0 -x 3 -y raw
> > extended timestamp request returned 3 samples
> > sample # 0: mono-raw time before: 371.548640128
> >             phc time: 371.579671788
> >             mono-raw time after: 371.548640912
> > sample # 1: mono-raw time before: 371.548642104
> >             phc time: 371.579673346
> >             mono-raw time after: 371.548642490
> > sample # 2: mono-raw time before: 371.548643320
> >             phc time: 371.579674652
> >             mono-raw time after: 371.548643756
> > ~# testptp -d /dev/ptp0 -x 3 -y real
> > extended timestamp request returned 3 samples
> > sample # 0: system time before: 1713243413.403474250
> >             phc time: 385.699915490
> >             system time after: 1713243413.403474948
> > sample # 1: system time before: 1713243413.403476220
> >             phc time: 385.699917168
> >             system time after: 1713243413.403476642
> > sample # 2: system time before: 1713243413.403477555
> >             phc time: 385.699918442
> >             system time after: 1713243413.403477961
>
> That takes up a lot of space, but what's the actual value of this
> information? Especially as there is no actual test case for this which
> people can use to validate the changes.
>
I'll polish the testptp.c changes and submit them later. But if this
is not adding any value, I can remove it from the log.

> > diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock=
_kernel.h
> > index 6e4b8206c7d0..7563da6db09b 100644
> > --- a/include/linux/ptp_clock_kernel.h
> > +++ b/include/linux/ptp_clock_kernel.h
> > @@ -47,10 +47,12 @@ struct system_device_crosststamp;
> >   * struct ptp_system_timestamp - system time corresponding to a PHC ti=
mestamp
> >   * @pre_ts: system timestamp before capturing PHC
> >   * @post_ts: system timestamp after capturing PHC
> > + * @clockid: clockid used for cpaturing timestamp
>
> cpaturing?
>
> s/timestamp/the system timestamps/
>
> Precision matters not only for PTP.
>
:) ack

> >   */
> >  struct ptp_system_timestamp {
> >       struct timespec64 pre_ts;
> >       struct timespec64 post_ts;
> > +     clockid_t clockid;
> >  };
> >
> >  /**
> > @@ -457,14 +459,34 @@ static inline ktime_t ptp_convert_timestamp(const=
 ktime_t *hwtstamp,
> >
> >  static inline void ptp_read_system_prets(struct ptp_system_timestamp *=
sts)
> >  {
> > -     if (sts)
> > -             ktime_get_real_ts64(&sts->pre_ts);
> > +     if (sts) {
> > +             switch (sts->clockid) {
> > +             case CLOCK_REALTIME:
> > +                     ktime_get_real_ts64(&sts->pre_ts);
> > +                     break;
> > +             case CLOCK_MONOTONIC_RAW:
> > +                     ktime_get_raw_ts64(&sts->pre_ts);
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +     }
> >  }
> >
> >  static inline void ptp_read_system_postts(struct ptp_system_timestamp =
*sts)
> >  {
> > -     if (sts)
> > -             ktime_get_real_ts64(&sts->post_ts);
> > +     if (sts) {
> > +             switch (sts->clockid) {
> > +             case CLOCK_REALTIME:
> > +                     ktime_get_real_ts64(&sts->post_ts);
> > +                     break;
> > +             case CLOCK_MONOTONIC_RAW:
> > +                     ktime_get_raw_ts64(&sts->post_ts);
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +     }
> >  }
> >
> >  #endif
> > diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_cl=
ock.h
> > index 053b40d642de..fc5825e72330 100644
> > --- a/include/uapi/linux/ptp_clock.h
> > +++ b/include/uapi/linux/ptp_clock.h
> > @@ -157,7 +157,12 @@ struct ptp_sys_offset {
> >
> >  struct ptp_sys_offset_extended {
> >       unsigned int n_samples; /* Desired number of measurements. */
> > -     unsigned int rsv[3];    /* Reserved for future use. */
> > +     /* The original implementation provided timestamps (always) in
> > +      * REALTIME clock-base. Since CLOCK_REALTIME is 0, adding
> > +      * clockid doesn't break backward compatibility.
> > +      */
>
> This wants to be in the change log.
>
Ack

> If you want to document the evolution of this data structure in a
> comment, then 'original implementation' is not really the best wording
> to use.
>
> I'd rather see the documentation fixed so that it uses proper kernel doc
> style for the whole data structure instead of having this mix of inline
> and tail comments along with a properly structured version information.
>
> /**
>  * ptp_sys_offset_extended - Data structure for IOCTL_PTP_.....
>  *
>  * @n_samples:          Desired number of samples
>  * ....
>  * @...
>  *
>  * History:
>  * V1:  Initial implementation
>  *
>  * V2:  Use the first reserved field for @clockid. That's backwards
>  *      compatible for V1 user space because CLOCK_REALTIME is 0 and
>  *      the reserved fields must be 0.
>  */
>
> Or something like that. Hmm?
>
will attempt to add it.

> Thanks,
>
>         tglx

Thanks for reviewing Thomas, I'll address them in the next revision.

--mahesh..

