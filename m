Return-Path: <netdev+bounces-221551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2CBB50CD6
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 06:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB48618908C8
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 04:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBE5299924;
	Wed, 10 Sep 2025 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AqKqaxpu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CCC26E146
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757478595; cv=none; b=jOEjAZ/m1GS59EURBJLsoJF5DsCpKUCyV6BtUQ2STdq11khKaB7Tsr7IcYHDAWjcGZslbEfJzEUPa0oeISva2PdchfWR/GVeKdRZNjJMZECrik+iwo4DxMZ4eW8IaTvMi2BW6bf6pH+h0flgAFLj4hxmBKOQZtMDSjonP4HgLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757478595; c=relaxed/simple;
	bh=cBzuUV2DMixVJL0q+yDt6jD/zTPuneDzgcaHfpTwam8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rn585xNiUpq+K0X3Fl00jvEnCRZzU2UR0Onu0eNhrzyjvUuKsVQkZ5sPpt9zhwbxZRDFm+8r3G9FIP2vKb4oBiObiLlp6iNYT414/guJgv9OvwPnyYsxwmj6LnMO3WWHO/ZcXY5z/JBItmxRmdx6Wo4tC+dI9l1rJTOtao0n77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AqKqaxpu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4d4881897cso4454945a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 21:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1757478593; x=1758083393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9zrN6e/abeUx1Ayuq/Sz8za+g68JQp5bwGOxs+g/+4=;
        b=AqKqaxpuphzhyHYkZ37R8aVVV3d5jwoHb4bESpY4jzJRm/WtFh2fvPKd7LZEnyESRP
         jM2nngSFrxaXUHMCdf7Oz3X+odaAVWOe1tXpPgfKAfsqQDCAQNuPzmfz3zHRGALG28qw
         osNRt5KqJfEEc8kHQ1aCcFE8zXDKwn6mU5pR5UHy6xrvB7fqYvRh1ynR126xaocTuBiD
         7QQ3ygsKxY67gDJNpRTwLt4wRm6duuMnNqS0972v1lRDS4hVwOSGGcEffFjKR7BhYWfY
         O9sNYGzmjTnKjju5udvc6WP/G76fZHYsCt+m5KURFHV8tPmQwg3jQ8SxuAwHEdN7HOYN
         yagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757478593; x=1758083393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9zrN6e/abeUx1Ayuq/Sz8za+g68JQp5bwGOxs+g/+4=;
        b=UNCZyDizAERrolKOrgaYbmusEhLugop/d8zUo9F92dtLeROJ7TxlGRQc6BpHCkR0nf
         XtffeSa4cGFZXzvHHEfVgrQMUWf94ntIzKpyg3NAqVYyRAPxBV8uQxd4UBfFjv3Xte7n
         rAvDMqqwRH75+VsgmWC73gU7qB6Jx89/FJAhW/zYL9IjWKKrnAzE2syJdaMPK+6bHPLl
         0fSblDg74cL50ri/SgUl67LJnhl81f09M+5Pp5Ys5yhPWNaOo9OdXlweLYcdgbwf+A2U
         J9thZwFlJi9up96Y3bUG9IuVuoVxI5NSmcWu8GQGoUuEsnKGQ2p+DkTDBdFnXCB+Zab9
         8Fiw==
X-Gm-Message-State: AOJu0YwKAWyHulUMOcAVeB2Ke+JAvdsRuziyFv2QXknU5GvpmNNExsu4
	8YWHBW9H1rdfU4UlWE71E5GOBl2uEhVRuFsT3cpOW5pUEE5vBzDYnkELPxsvmWeVUrbIxyQsNxF
	eDMZW0cxqVd/nxVVl0syXjlp4pPPoDJvh2dPUb3K7e1OW8nn8k7g=
X-Gm-Gg: ASbGncvVZqyFX+pCjS1mjtl1clNYTsE2aS3vCjKEd4RmJzvWyXO7OIwZkzj9sOwbykl
	T4kFUVn2XHLQmpqQ/Fs9N8+IXQvXVsHA3+2mYHswMFgJ2CkOjgTvrbr7Ip6ZuIlyAbehU0QUfke
	T3KFGzHkrf1DqAVPb/PvWv8dK+V5owBTAuuM5jlSAQXOc2EDqwtwJmE0ty56w//XBxZkhQhu6qi
	CgnXb1AGfn+e0HQmADbAO8wEK/90yFyGh2UIFFTIFGMBoyD4NQHV4Rir3BUnCmUONGBUw==
X-Google-Smtp-Source: AGHT+IEnWYrpBv67hNFcpD0eSVBWFIhmKeQQ6AcWKU6ujjbnwyy6gNsxzXZu9fx4Bce7zUHnvLyBTxuvZaf7irXYnKo=
X-Received: by 2002:a17:90b:3e50:b0:329:d09b:a3eb with SMTP id
 98e67ed59e1d1-32d43f17820mr18667309a91.3.1757478593099; Tue, 09 Sep 2025
 21:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
 <CAM0EoMmJaC3OAncWnUOkz6mn7BVXudnG1YKUYZomUkbVu8Zb+g@mail.gmail.com> <2940856.1757477093@famine>
In-Reply-To: <2940856.1757477093@famine>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 10 Sep 2025 00:29:41 -0400
X-Gm-Features: Ac12FXyPMkyW2xWekroJ8NcYAt34C8Fz2wv5wLydgmwRFx3_DkcAst4C446xIWE
Message-ID: <CAM0EoMnrrvKBdz4WjzFmzZhkhjGiJ-+=yr8RMkT5USzTafSybw@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] tc/police: Allow 64 bit burst size
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
	David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 12:04=E2=80=AFAM Jay Vosburgh <jv@jvosburgh.net> wr=
ote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> >On Sat, Sep 6, 2025 at 9:50=E2=80=AFPM Jay Vosburgh <jay.vosburgh@canoni=
cal.com> wrote:
> >>
> >>
> >>         In summary, this patchset changes the user space handling of t=
he
> >> tc police burst parameter to permit burst sizes that exceed 4 GB when =
the
> >> specified rate is high enough that the kernel API for burst can accomo=
date
> >> such.
> >>
> >>         Additionally, if the burst exceeds the upper limit of the kern=
el
> >> API, this is now flagged as an error.  The existing behavior silently
> >> overflows, resulting in arbitrary values passed to the kernel.
> >>
> >>         In detail, as presently implemented, the tc police burst optio=
n
> >> limits the size of the burst to to 4 GB, i.e., UINT_MAX for a 32 bit
> >> unsigned int.  This is a reasonable limit for the low rates common whe=
n
> >> this was developed.  However, the underlying implementation of burst i=
s
> >> computed as "time at the specified rate," and for higher rates, a burs=
t
> >> size exceeding 4 GB is feasible without modification to the kernel.
> >>
> >>         The burst size provided on the command line is translated into=
 a
> >> duration, representing how much time is required at the specified rate=
 to
> >> transmit the given burst size.
> >>
> >>         This time is calculated in units of "psched ticks," each of wh=
ich
> >> is 64 nsec[0].  The computed number of psched ticks is sent to the ker=
nel
> >> as a __u32 value.
> >>
> >
> >Please run tdc tests. David/Stephen - can we please make this a
> >requirement for iproute2 tc related changes?
>
>         I was not familiar with those tests (but see them now that I
> look in the kernel source).  I did run the tests included in the
> iproute2-next git repository.
>
> >Jay, your patches fail at least one test because you changed the unit ou=
tputs.
> >Either we fix the tdc test or you make your changes backward compatible.
>
>         I'll run the tdc tests and have a look at the failures.
>
> >In the future also cc kernel tc maintainers (I only saw this because
> >someone pointed it to me).
> >Overall the changes look fine.
>
>         Understood, but this isn't documented in iproute2.  Perhaps the
> iproute2 MAINTAINERS should have a tc section to clarify this
> expectation?
>

Ive been asking for a while now;->

cheers,
jamal
>         -J
>
> >cheers,
> >jamal
> >
> >>         Because burst is ultimately calculated as a time duration, the
> >> real upper limit for a burst is UINT_MAX psched ticks, i.e.,
> >>
> >>         UINT_MAX * psched tick duration / NSEC_PER_SEC
> >>         (2^32-1) *         64           / 1E9
> >>
> >>         which is roughly 274.88 seconds (274.8779...).
> >>
> >>         At low rates, e.g., 5 Mbit/sec, UINT_MAX psched ticks does not
> >> correspond to a burst size in excess of 4 GB, so the above is moot, e.=
g.,
> >>
> >>         5Mbit/sec / 8 =3D 625000 MBytes/sec
> >>         625000 * ~274.88 seconds =3D ~171800000 max burst size, below =
UINT_MAX
> >>
> >>         Thus, the burst size at 5Mbit/sec is limited by the __u32 size=
 of
> >> the psched tick field in the kernel API, not the 4 GB limit of the tc
> >> police burst user space API.
> >>
> >>         However, at higher rates, e.g., 10 Gbit/sec, the burst size is
> >> currently limited by the 4 GB maximum for the burst command line param=
eter
> >> value, rather than UINT_MAX psched ticks:
> >>
> >>         10 Gbit/sec / 8 =3D 1250000000 MBbytes/sec
> >>         1250000000 * ~274.88 seconds =3D ~343600000000, more than UINT=
_MAX
> >>
> >>         Here, the maximum duration of a burst the kernel can handle
> >> exceeds 4 GB of burst size.
> >>
> >>         While the above maximum may be an excessively large burst valu=
e,
> >> at 10 Gbit/sec, a 4 GB burst size corresponds to just under 3.5 second=
s in
> >> duration:
> >>
> >>         2^32 bytes / 10 Gbit/sec
> >>         2^32 bytes / 1250000000 bytes/sec
> >>         equals ~3.43 sec
> >>
> >>         So, at higher rates, burst sizes exceeding 4 GB are both
> >> reasonable and feasible, up to the UINT_MAX limit for psched ticks.
> >> Enabling this requires changes only to the user space processing of th=
e
> >> burst size parameter in tc.
> >>
> >>         In principle, the other packet schedulers utilizing psched tic=
ks
> >> for burst sizing, htb and tbf, could be similarly changed to permit la=
rger
> >> burst sizes, but this patch set does not do so.
> >>
> >>         Separately, for the burst duration calculation overflow (i.e.,
> >> that the number of psched ticks exceeds UINT_MAX), under the current
> >> implementation, one example of overflow is as follows:
> >>
> >> # /sbin/tc filter add dev eth0 protocol ip prio 1 parent ffff: handle =
1 fw police rate 1Mbit peakrate 10Gbit burst 34375000 mtu 64Kb conform-exce=
ed reclassify
> >>
> >> # /sbin/tc -raw filter get dev eth0 ingress protocol ip pref 1 handle =
1 fw
> >> filter ingress protocol ip pref 1 fw chain 0 handle 0x1  police 0x1 ra=
te 1Mbit burst 15261b mtu 64Kb [001d1bf8] peakrate 10Gbit action reclassify=
 overhead 0b
> >>         ref 1 bind 1
> >>
> >>         Note that the returned burst value is 15261b, which does not m=
atch
> >> the supplied value of 34375000.  With this patch set applied, this
> >> situation is flagged as an error.
> >>
> >>
> >> [0] psched ticks are defined in the kernel in include/net/pkt_sched.h:
> >>
> >> #define PSCHED_SHIFT                    6
> >> #define PSCHED_TICKS2NS(x)              ((s64)(x) << PSCHED_SHIFT)
> >> #define PSCHED_NS2TICKS(x)              ((x) >> PSCHED_SHIFT)
> >>
> >> #define PSCHED_TICKS_PER_SEC            PSCHED_NS2TICKS(NSEC_PER_SEC)
> >>
> >>         where PSCHED_TICKS_PER_SEC is 15625000.
> >>
> >>         These values are exported to user space via /proc/net/psched, =
the
> >> second field being PSCHED_TICKS2NS(1), which at present is 64 (0x40). =
 tc
> >> uses this value to compute its internal "tick_in_usec" variable contai=
ning
> >> the number of psched ticks per usec (15.625) used for the psched tick
> >> computations.
> >>
> >>         Lastly, note that PSCHED_SHIFT was previously 10, and changed =
to 6
> >> in commit a4a710c4a7490 in 2009.  I have not tested backwards
> >> compatibility of these changes with kernels of that era.
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net
>

