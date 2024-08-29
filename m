Return-Path: <netdev+bounces-123422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C7C964D2A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A139128115C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4462F1B3F30;
	Thu, 29 Aug 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIgBxxpo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9394D8C1
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953597; cv=none; b=ABB/0mjGrGfbLshydBG3EmOfGtk4+y/5ud9FkllrpUhuO5AsZXstCTrCUraIrTJUZI3YXKpufnAPUlU0hfHEWq3fRDqAx3t4aFmIT0tbd8EPXrRFZSVAcYuOCOKz0iL4Bd0risazZcx7VPwri7KKJXC+lB4pDrjNk7NaZ/zq5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953597; c=relaxed/simple;
	bh=z4qOO3mLrYSNA5ZX/uoH9SIEoDoVQickqElVeaDh9Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1s2Y2Ue7WVKwd6EEYDvdKvJ51mJRDe8tp7UiSyglmi1MKyb7TyrTjXStpLSV5H7a3HsTOnigGChOZ9N68FsUlJ6n0Pw8NvcSInG2rielAMcDo6PGnhXEUEEdRVCHaZsQJ2n6kly3fIdFgr88mzy7/+zC1MRMOjTscz7Nywj+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIgBxxpo; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39d2256ee95so4309645ab.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724953595; x=1725558395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4qOO3mLrYSNA5ZX/uoH9SIEoDoVQickqElVeaDh9Xc=;
        b=WIgBxxponUnjZBX1K+3aGMZUL7weyMbzK3+M76L44DM4I76QGFxf+/Bh7kwSspzUys
         7Q8y1jngUYiA9tiFkEinn8XWcYac9DMUd8uBRENSJlxuzADQsvZwaBzDVpFCpaJfbuXn
         /LW1FQeIKIaIXN5HbB8Hg36DKYzu/mtXAndjjYOREJyM9q13lHCbWx74ljcx7Gx50X+c
         mYAK/jcy8LgkF1xVAMTu4n/zE4rTcA2ifsrzB9LJ9yCHNq1vWlmzHH/HHMZeKRBg30v+
         DSN+4k6X8mcmBLKSdo+jyks726V3MEK/trhj7j3hV+2w52Ft+CAfANcRjKgGT9UCGRc6
         8z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724953595; x=1725558395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4qOO3mLrYSNA5ZX/uoH9SIEoDoVQickqElVeaDh9Xc=;
        b=BxgS7CQobWQor1l0809CwANDYec3pIQHmTxMuo1ctzG4ZrHR3C+VV5HV+wwx/6E517
         +UJGC/j0Qf7fWLcxHKlYxdAyE/04KfuQgTX1ntS1Kz7AM3ZZZC5eEbyzG5JQcp84i0jU
         dLXeJW+Gofgs25UsbQBK+pPLdYmVnYXJ11GGNKDjdXw4hK2yUA9A+EWXGbtsFSQhdkdG
         mcIta4iRuKXxwt4K61r8BgbPjK4Mpo5zpEGG8A7CR8XYGSmbvr4t8ts+/JCYdN/vY6w2
         SS3ngSUmpFP3P2Vl5Waw02VMcgMpYtyak86MfJaOs32CkzyCZkg5RUAuFcfe8BnHERPM
         8saA==
X-Forwarded-Encrypted: i=1; AJvYcCUqyXnXYN3qlpTjWUd73ugafCdynPFSltXA9PNkZZvdDgMSHz89vuIA1k52XCjNBcOIZwJa+os=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXNXEpgscVVjAo6QJOQeoBejX+QiAAyp9woR0h4O2fhMHj1FQ
	3/140JxJCKEXOFapNpRgIUlD53pxjd7SCvr3f4LNs9NEavDgw05hOh0M0YFYlnhtzGv4/SE7jqD
	zUn3vALpgqvVsKKo3Xp9eVw6eqwo=
X-Google-Smtp-Source: AGHT+IFk0TB7oJIZvA74IIg4KsJhNfGtvD604u+g/wWQsdHgZBzlfSoYkkW1xarUdZPv1ZsAmPi5anBDoeRnmMWIecQ=
X-Received: by 2002:a05:6e02:13a7:b0:39d:4e3e:7571 with SMTP id
 e9e14a558f8ab-39f37854932mr49201215ab.23.1724953594861; Thu, 29 Aug 2024
 10:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
 <66d082422d85_3895fa29427@willemb.c.googlers.com.notmuch> <CAL+tcoD6s0rrCAvMeMDE3-QVemPy21Onh4mHC+9PE-DDLkdj-Q@mail.gmail.com>
 <66d0a0816d6ce_39197c29476@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d0a0816d6ce_39197c29476@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Aug 2024 01:45:56 +0800
Message-ID: <CAL+tcoCUhYH=udvB3rdVZm0gVypmAa5devPXryPwY+39mHscDA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] timestamp: control SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 12:23=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Thu, Aug 29, 2024 at 10:14=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Prior to this series, when one socket is set SOF_TIMESTAMPING_RX_SO=
FTWARE
> > > > which measn the whole system turns on this button, other sockets th=
at only
> > > > have SOF_TIMESTAMPING_SOFTWARE will be affected and then print the =
rx
> > > > timestamp information even without SOF_TIMESTAMPING_RX_SOFTWARE fla=
g.
> > > > In such a case, the rxtimestamp.c selftest surely fails, please see
> > > > testcase 6.
> > > >
> > > > In a normal case, if we only set SOF_TIMESTAMPING_SOFTWARE flag, we
> > > > can't get the rx timestamp because there is no path leading to turn=
 on
> > > > netstamp_needed_key button in net_enable_timestamp(). That is to sa=
y, if
> > > > the user only sets SOF_TIMESTAMPING_SOFTWARE, we don't expect we ar=
e
> > > > able to fetch the timestamp from the skb.
> > >
> > > I already happened to stumble upon a counterexample.
> > >
> > > The below code requests software timestamps, but does not set the
> > > generate flag. I suspect because they assume a PTP daemon (sfptpd)
> > > running that has already enabled that.
> >
> > To be honest, I took a quick search through the whole onload program
> > and then suspected the use of timestamp looks really weird.
> >
> > 1. I searched the SOF_TIMESTAMPING_RX_SOFTWARE flag and found there is
> > no other related place that actually uses it.
> > 2. please also see the tx_timestamping.c file[1]. The author similarly
> > only turns on SOF_TIMESTAMPING_SOFTWARE report flag without turning on
> > any useful generation flag we are familiar with, like
> > SOF_TIMESTAMPING_TX_SOFTWARE, SOF_TIMESTAMPING_TX_SCHED,
> > SOF_TIMESTAMPING_TX_ACK.
> >
> > [1]: https://github.com/Xilinx-CNS/onload/blob/master/src/tests/onload/=
hwtimestamping/tx_timestamping.c#L247
> >
> > >
> > > https://github.com/Xilinx-CNS/onload/blob/master/src/tests/onload/hwt=
imestamping/rx_timestamping.c
> > >
> > > I suspect that there will be more of such examples in practice. In
> > > which case we should scuttle this. Please do a search online for
> > > SOF_TIMESTAMPING_SOFTWARE to scan for this pattern.
> >
> > I feel that only the buggy program or some program particularly takes
> > advantage of the global netstamp_needed_key...
>
> My point is that I just happen to stumble on one open source example
> of this behavior.
>
> That is a strong indication that other applications may make the same
> implicit assumption. Both open source, and the probably many more non
> public users.
>
> Rule #1 is to not break users.

Yes, I know it.

>
> Given that we even have proof that we would break users, we cannot
> make this change, sorry.

Okay. Your concern indeed makes sense. Sigh, I just finished the v3
patch series :S

>
> A safer alternative is to define a new timestamp option flag that
> opt-in enables this filter-if-SOF_TIMESTAMPING_RX_SOFTWARE is not
> set behavior.

At the first glance, It sounds like it's a little bit similar to
SOF_TIMESTAMPING_OPT_ID_TCP that is used to replace
SOF_TIMESTAMPING_OPT_ID in the bytestream case for robustness
consideration.

Are you suggesting that if we can use the new report flag combined
with SOF_TIMESTAMPING_SOFTWARE, the application will not get a rx
timestamp report, right? The new flag goes the opposite way compared
with SOF_TIMESTAMPING_RX_SOFTWARE, indicating we don't expect a rx sw
report.

If that is so, what would you recommend to name the new flag which is
a report flag (not a generation flag)? How about calling
"SOF_TIMESTAMPING_RX_SOFTWARE_CTRL". I tried, but my English
vocabulary doesn't help, sorry :(

Thanks,
Jason

