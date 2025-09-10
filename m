Return-Path: <netdev+bounces-221544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21976B50C53
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 05:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114911BC68B0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCCC259CA0;
	Wed, 10 Sep 2025 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="yQ/267BV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233D256C83
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757475175; cv=none; b=gup10pQ2SnGoyvlORIJC4pGk3BfIBvKkHtPQBigdcZlUEqOBHUdf7XkduXsmiXYlF2RBJEpX0pGEQbTopKuJpS1SxF5DHHCkyZKI0t1puKpvfdrnkhOb6r2vS6Y8/jRMzD12o49sm8Wnpk/Em4eFUTwRQ2twPaOuLQMWk0zp+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757475175; c=relaxed/simple;
	bh=S+wXPlb/MR9V7tLCA68slyfXrdwRaCA75TJe+fhGGm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgFKxeORfYwdjqtd424PNI3W0vsxLIgiZZVneVOcPC8T4jgi1O2tTfqNqNKBrkR34alW0rsn+d4+8Jm+pNo71UpZhritJZ3GgNxrZPYFgGizOjL7HnPkOMjiMk1RY7z0NEVLI8plTcrdJQ+FelTQvhGNcAzlhF+fCbSozCB2IIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=yQ/267BV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7722bcb989aso4768879b3a.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 20:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1757475173; x=1758079973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrz75l4Xjdvkppz5VMt5Z1XX5jZHQW7UmCIBXGePwyg=;
        b=yQ/267BVuOF7xyj2espXYhwEA59FmnZ4nICdImfeb167TVKnrlfZ4m18i7KbhJWsRR
         WXgtq/UcoHmratxg8otPm1HwstX6mVWyzfNQ6vgGV3BqyV8Pqn+oMygmgjN5I6dlnGBf
         ezymksdqgzWdOv7CVqBa99nxFv9Yd1KIkHg2rb8C7RLaxJ5fnYj30p2sz3jIAqUD9lCz
         7y2yzoNBADcLvLTi4IOfx+3QMC2kOQtis948IDEOzzQKg2Pb6SpbrMdvpRC7Jnd/f1ED
         glnRL9KB8P443YUrezwoMV/n3FoMUY3SyIVwbD/bYqq8SdtsHVMcxowAZnSop89bL6BQ
         lNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757475173; x=1758079973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrz75l4Xjdvkppz5VMt5Z1XX5jZHQW7UmCIBXGePwyg=;
        b=kCXjUL2k3iuEhzhDZv7S/KLvyPh+S/6covdHkG/o1BjxcBr/0cBv7aVpf3zZj3BYOA
         kFjPPhUKwu/7IhLGcvigs26R18K/Mwd2wEKDFRCMAehrijvNE0uxJF94Ewg7OqEmexnp
         EK/oBLUJEK4eoKkwfQxpfMgKmhQIhlDTPrgbG0Lq1592t9rq00Inf0ljuN4zuNm8/UJD
         /J+DXLHycDJYEdfbq9kXxDvl9jC0wUS1VlY7giOQySD6d00iin1inZqUNAGWDNj/Xsnn
         XAHzYeGwGaZGOXXxUlHAhDBvzWhnBiNvcl925KDseQm2MzLhPx6yuSsBaFv6p2MdXjXZ
         AL4g==
X-Gm-Message-State: AOJu0YykWhC52/aaMoqnzLiSF5EKNFZKFm3RJhRC0p2ZyVttPl1iXRYj
	lMN71YhkrRUB7NtcJMi1Qk31K9MqwfM/LoJqHrcYpO8VhiJBzW6G2mljRAbsasbTikMsnATPsx2
	EZxZ98cs1GJ680d91W2uXaiyo74aybiY4uMrUHJbU2U3GRRws2NU=
X-Gm-Gg: ASbGnctSRTqhbx0sU0t1VCVzDs3gT/+LBP+YPFSUOj+U8zU2DaC2YTPicKkRwabtUJT
	kgHavLsa+pBOse1U52IXUdL5Amb4RGBsPRhguJPgc4yvbMh3+PAgD6pA0hEYBimXb0yfRI24dmq
	FyAtVrKsQ+4BGG718rHpupXSxqANbyPxPtO58BtdNt1CNLSeRaDiiVhyvFQ7xPZFaAwspU7eM3D
	R1nURMmMB8bTxrKcrG7+bEuod+8HrJEUFM9MaRr8ltbfYdy6kkWO68C3zLAWMdjne5CMA==
X-Google-Smtp-Source: AGHT+IFjv3jKWWU5foo1JA7znJSXicuOK+v401xKkYTKT+VfcSuUB298o8DBtiGN8RRmUSXDIAIL7PmM8Wjm46YHN6w=
X-Received: by 2002:a05:6a21:998d:b0:245:ffe1:5609 with SMTP id
 adf61e73a8af0-2534557b084mr19444919637.44.1757475173007; Tue, 09 Sep 2025
 20:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
In-Reply-To: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 9 Sep 2025 23:32:40 -0400
X-Gm-Features: Ac12FXwFFG7KA2p9SKTrOk4s9-lJLaWrpCI58lLB3avremaUpnHcb6JuoQ5_5ok
Message-ID: <CAM0EoMmJaC3OAncWnUOkz6mn7BVXudnG1YKUYZomUkbVu8Zb+g@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] tc/police: Allow 64 bit burst size
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
	David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 9:50=E2=80=AFPM Jay Vosburgh <jay.vosburgh@canonical=
.com> wrote:
>
>
>         In summary, this patchset changes the user space handling of the
> tc police burst parameter to permit burst sizes that exceed 4 GB when the
> specified rate is high enough that the kernel API for burst can accomodat=
e
> such.
>
>         Additionally, if the burst exceeds the upper limit of the kernel
> API, this is now flagged as an error.  The existing behavior silently
> overflows, resulting in arbitrary values passed to the kernel.
>
>         In detail, as presently implemented, the tc police burst option
> limits the size of the burst to to 4 GB, i.e., UINT_MAX for a 32 bit
> unsigned int.  This is a reasonable limit for the low rates common when
> this was developed.  However, the underlying implementation of burst is
> computed as "time at the specified rate," and for higher rates, a burst
> size exceeding 4 GB is feasible without modification to the kernel.
>
>         The burst size provided on the command line is translated into a
> duration, representing how much time is required at the specified rate to
> transmit the given burst size.
>
>         This time is calculated in units of "psched ticks," each of which
> is 64 nsec[0].  The computed number of psched ticks is sent to the kernel
> as a __u32 value.
>

Please run tdc tests. David/Stephen - can we please make this a
requirement for iproute2 tc related changes?

Jay, your patches fail at least one test because you changed the unit outpu=
ts.
Either we fix the tdc test or you make your changes backward compatible.
In the future also cc kernel tc maintainers (I only saw this because
someone pointed it to me).
Overall the changes look fine.

cheers,
jamal

>         Because burst is ultimately calculated as a time duration, the
> real upper limit for a burst is UINT_MAX psched ticks, i.e.,
>
>         UINT_MAX * psched tick duration / NSEC_PER_SEC
>         (2^32-1) *         64           / 1E9
>
>         which is roughly 274.88 seconds (274.8779...).
>
>         At low rates, e.g., 5 Mbit/sec, UINT_MAX psched ticks does not
> correspond to a burst size in excess of 4 GB, so the above is moot, e.g.,
>
>         5Mbit/sec / 8 =3D 625000 MBytes/sec
>         625000 * ~274.88 seconds =3D ~171800000 max burst size, below UIN=
T_MAX
>
>         Thus, the burst size at 5Mbit/sec is limited by the __u32 size of
> the psched tick field in the kernel API, not the 4 GB limit of the tc
> police burst user space API.
>
>         However, at higher rates, e.g., 10 Gbit/sec, the burst size is
> currently limited by the 4 GB maximum for the burst command line paramete=
r
> value, rather than UINT_MAX psched ticks:
>
>         10 Gbit/sec / 8 =3D 1250000000 MBbytes/sec
>         1250000000 * ~274.88 seconds =3D ~343600000000, more than UINT_MA=
X
>
>         Here, the maximum duration of a burst the kernel can handle
> exceeds 4 GB of burst size.
>
>         While the above maximum may be an excessively large burst value,
> at 10 Gbit/sec, a 4 GB burst size corresponds to just under 3.5 seconds i=
n
> duration:
>
>         2^32 bytes / 10 Gbit/sec
>         2^32 bytes / 1250000000 bytes/sec
>         equals ~3.43 sec
>
>         So, at higher rates, burst sizes exceeding 4 GB are both
> reasonable and feasible, up to the UINT_MAX limit for psched ticks.
> Enabling this requires changes only to the user space processing of the
> burst size parameter in tc.
>
>         In principle, the other packet schedulers utilizing psched ticks
> for burst sizing, htb and tbf, could be similarly changed to permit large=
r
> burst sizes, but this patch set does not do so.
>
>         Separately, for the burst duration calculation overflow (i.e.,
> that the number of psched ticks exceeds UINT_MAX), under the current
> implementation, one example of overflow is as follows:
>
> # /sbin/tc filter add dev eth0 protocol ip prio 1 parent ffff: handle 1 f=
w police rate 1Mbit peakrate 10Gbit burst 34375000 mtu 64Kb conform-exceed =
reclassify
>
> # /sbin/tc -raw filter get dev eth0 ingress protocol ip pref 1 handle 1 f=
w
> filter ingress protocol ip pref 1 fw chain 0 handle 0x1  police 0x1 rate =
1Mbit burst 15261b mtu 64Kb [001d1bf8] peakrate 10Gbit action reclassify ov=
erhead 0b
>         ref 1 bind 1
>
>         Note that the returned burst value is 15261b, which does not matc=
h
> the supplied value of 34375000.  With this patch set applied, this
> situation is flagged as an error.
>
>
> [0] psched ticks are defined in the kernel in include/net/pkt_sched.h:
>
> #define PSCHED_SHIFT                    6
> #define PSCHED_TICKS2NS(x)              ((s64)(x) << PSCHED_SHIFT)
> #define PSCHED_NS2TICKS(x)              ((x) >> PSCHED_SHIFT)
>
> #define PSCHED_TICKS_PER_SEC            PSCHED_NS2TICKS(NSEC_PER_SEC)
>
>         where PSCHED_TICKS_PER_SEC is 15625000.
>
>         These values are exported to user space via /proc/net/psched, the
> second field being PSCHED_TICKS2NS(1), which at present is 64 (0x40).  tc
> uses this value to compute its internal "tick_in_usec" variable containin=
g
> the number of psched ticks per usec (15.625) used for the psched tick
> computations.
>
>         Lastly, note that PSCHED_SHIFT was previously 10, and changed to =
6
> in commit a4a710c4a7490 in 2009.  I have not tested backwards
> compatibility of these changes with kernels of that era.
>
>

