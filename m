Return-Path: <netdev+bounces-242324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A850C8F386
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BA114EB4FA
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5558B328631;
	Thu, 27 Nov 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UguZPZ/M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A71296BC2
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256307; cv=none; b=A0XXMxEIhBuBZvCHccLHhgZYXdYEuLW/1utHryocaap7HR9xeUVCkTlWnAr2u8eMZV6bVGOKFvvp+S8k19tvympry40M7yvBe561jkmsc0+RN+PSAk3UyD/PzMfrfTpR7+STy3lS9JslCrbeH95LEsdaFpObhJ2i4A3kflD9+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256307; c=relaxed/simple;
	bh=lmT+th1EMcNn4O/gymBt5PNtyWASP3FSDcKA6sN8jbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IK2SNfomUr8YAGtB844DoZO9iUCfgNoOJm69E2Aj0ms4r2+0BcxmZX1cPcT3z91G4QgfK3w1QnLUwdO6XM2nbnvz/a4Iyt/XSxGFQL+FDyXhtEL+VxRVfWTr1k5jhh7JWOoLUa2j+GbsYsdXocc67JgldXlD9ijBTvRpuiM9VNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=UguZPZ/M; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bcfd82f55ebso949795a12.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764256305; x=1764861105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmT+th1EMcNn4O/gymBt5PNtyWASP3FSDcKA6sN8jbc=;
        b=UguZPZ/MD4B3Y4+W3rlz5hWZzpcRHurvFRmKKc7WNmP5vBZkaogv/UyibzrGE9Fxcv
         jk6txE5l7cEqd2RRwV098Kb+fZNSj8m0uJUeyEPPnWgeA9wgtmflOkh/czEfO/0n/7Av
         EvVgppds7N6yY678Vc57AgL876X2sBdrrs5N8EO8BGz2vTfmGjx384OtnDkTbewM9odv
         7wC9gLkw65QQoFFonKTbfLT6N1PgHF0IVyJ+2+SfZ75BPfVYSsGYuZ/8B+BlrH6iUPg8
         vpOEIhfbekBVdt+qSPXyYLKxmbsAt5e9HKgfUgWlbOZDIYGEFEfNemFcXizy14hGWRSI
         st0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764256305; x=1764861105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmT+th1EMcNn4O/gymBt5PNtyWASP3FSDcKA6sN8jbc=;
        b=fe1UbiPGCSKr3E1DHXx1Sfsss4lB5h/TbZC/j2Op5clMB0YjQUxGuNbL8xjzt26MjZ
         jvAfvVW+EJeLqF43QjVKQ8R67IGD1NeualYDPg36o8zav5K2OXOeJy5YQ43CeWn0/4Dy
         MqRRJ4q9gCLwakNfY7tHqSP8+rdewaQH7EpGhLnUdtZKJm4+dl5OK9XS1ID8DAnYGLp6
         1FAUi54of1mvbb3DPtK4WuwweEBsYj1806CB96DaB7vDzVkmSu7vuSFhIkmhh8qZRisi
         NMa530NgYrokwLPo+HXNfA0PFkUxVFGmJh7lj74zwRek0xPoO9sFH3gbslsSYYYe+Mww
         G/9w==
X-Forwarded-Encrypted: i=1; AJvYcCUBCAoZqIh5SxvYTwt6UKuvOJQxaBSYZqL4N/9KO+uDD+kwt20zxqNM4znNm9M6FZibgDr6DAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzidGjoSPgqiGIWX7ftmhBVq3UdourXga4+F9g6Q7/NYJu5FLTU
	qrfI82AT/ANP2CxSAo313HimYyueszEtUYHabiKODAOL5qtln/VUJiiau2U8omkUju/QvLgaI0U
	8mh1aF3UTPUguRiSdyQHLSCHqZf9pWAE0ZzcHAOyz
X-Gm-Gg: ASbGncsh6K0CAW4HBt75AN2zsvMrEMFUVxxbhkVtH7dJmwPF+Jb0LnYz3WI0KfaOdZT
	UAEZgstZzbwyCVjSyvg9jSxR9/sPEaV5hg/23Yar2k89ZByd0mPaBguU2whdf+niQZ9mNHTDuEf
	Y7hCmeEmwIFg08k0tCK3tzktk7bIqjX60ja6ZLr78XmHuXHKx/n/AoYGpWBv2vNOTxkxV7U2KAq
	suFfaz6Nh2U1z8V/G8OCd6jLsuKrK++XvsGc2NlvXqAIk91/qCyvcpsgXEhujQQkg2/TqfN87bZ
	VoCbTMeSri1nVw==
X-Google-Smtp-Source: AGHT+IHW2sOmQkqwY7D8TPAnSwmp3RQqP9+91O0yCbXDTbBaTLKudtbHGHQb7E33CRmz3b5RD6BiYzrmkqiouPaeIhQ=
X-Received: by 2002:a17:903:166e:b0:299:dc97:a6c9 with SMTP id
 d9443c01a7336-29b5e3b6b04mr271950275ad.20.1764256305057; Thu, 27 Nov 2025
 07:11:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110123807.07ff5d89@phoenix> <aR/qwlyEWm/pFAfM@pop-os.localdomain>
 <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
 <oXMTlZ5OaURBe0X3RZCO7zyNf6JJFPYvDW0AiXEg0bXJwXXYJutLhhjmUbetBUD_pGChlN7hDCCx9xFOtj8Hke5G7SM3-u5FQFC5e4T1wPY=@proton.me>
 <CAM0EoM=i6MsHeBYu6d-+bkxVWWHcj9b9ibM+dHr3w27mUMMhBw@mail.gmail.com> <ASx87MmTb79KImWwsBhstFGoue2UNiX4l0Y0NXCSob-VNrOsz05jh8lG76DbQ7FWjGABCdc45LY6vQ3VI7UIv4KzI5LI2mB65eje2PwlHrE=@proton.me>
In-Reply-To: <ASx87MmTb79KImWwsBhstFGoue2UNiX4l0Y0NXCSob-VNrOsz05jh8lG76DbQ7FWjGABCdc45LY6vQ3VI7UIv4KzI5LI2mB65eje2PwlHrE=@proton.me>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 27 Nov 2025 10:11:34 -0500
X-Gm-Features: AWmQ_bk4zxVrMhQekbIb7zl8iaJSbVsi_4IrOTAr54OxRrI86bsKGmg01AkxoN0
Message-ID: <CAM0EoMkmggVd6-zbH_9z=wcHAW7dwOg+-Axh2k5F1jF72oj=_w@mail.gmail.com>
Subject: Re: Fw: [Bug 220774] New: netem is broken in 6.18
To: =?UTF-8?B?7KCV7KeA7IiY?= <jschung2@proton.me>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, will@willsroot.io, savy@syst3mfailure.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 27, 2025 at 1:08=E2=80=AFAM =EC=A0=95=EC=A7=80=EC=88=98 <jschun=
g2@proton.me> wrote:
>
> Mr Salim,
>
> I do not understand what your saying. You provide a bash script, and I ca=
n test
>

Will you be willing to go on a zoom/gmeet call? I think it will be
easier to communicate.

cheers,
jamal
> - Ji-Soo
>
> =EC=97=90 2025=EB=85=84 11=EC=9B=94 22=EC=9D=BC =ED=86=A0=EC=9A=94=EC=9D=
=BC 17:24 Jamal Hadi Salim <jhs@mojatatu.com> =EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1=ED=95=A8:
>
> >
> >
> > Hi =EC=A0=95=EC=A7=80=EC=88=98,
> >
> > On Sat, Nov 22, 2025 at 1:56=E2=80=AFAM =EC=A0=95=EC=A7=80=EC=88=98 jsc=
hung2@proton.me wrote:
> >
> > > #!/bin/bash
> > >
> > > set -euo pipefail
> > >
> > > DEV=3D"wlo0"
> > > QUEUE=3D"1"
> > > RTP_DST_PORT=3D"5004"
> > > DUP_PCT=3D"25%"
> > > CORR_PCT=3D"60%"
> > > DELAY=3D"1ms"
> > > VERIFY_SECONDS=3D15
> > >
> > > usage(){ echo "Usage: sudo $0 [-d DEV] [-q QUEUE] [-P UDP_PORT]"; exi=
t 1; }
> > > while [[ $# -gt 0 ]]; do
> > > case "$1" in
> > > -d) DEV=3D"$2"; shift 2;;
> > > -q) QUEUE=3D"$2"; shift 2;;
> > > -P) RTP_DST_PORT=3D"$2"; shift 2;;
> > > *) usage;;
> > > endac
> > > done || true
> > >
> > > [[ -d /sys/class/net/$DEV ]] || { echo "No such dev $DEV"; exit 1; }
> > >
> > > if ! tc qdisc show dev "$DEV" | grep -q ' qdisc mq '; then
> > > echo "Setting root qdisc to mq.."
> > > tc qdisc replace dev "$DEV" root handle 1: mq
> > > fi
> > >
> > > echo "Adding ntuple to steer UDP dport $RTP_DST_PORT -> tx-queue $QUE=
UE..."
> > > ethtool -N "$DEV" flow-type udp4 dst-port $RTP_DST_PORT action $QUEUE=
 || {
> > > echo "some flows will still land on :$QUEUE"
> > > }
> > >
> > > echo "Attaching netem duplicate=3D$DUP_PCT corr=3D$CORR_PCT delay=3D$=
DELAY on parent :$QUEUE.."
> > > tc qdisc replace dev "$DEV" parent :$QUEUE handle ${QUEUE}00: \
> > > netem duplicate "$DUP_PCT" "$CORR_PCT" delay "$DELAY"
> > >
> > > tc qdisc show dev "$DEV"
> > >
> > > echo
> > > echo "Start an RTP/WebRTC/SFU downlink to a test client on UDP port $=
RTP_DST_PORT."
> > > echo "Capturing for $VERIFY_SECONDS s to observe duplicates by RTP se=
qno.."
> > > timeout "$VERIFY_SECONDS" tcpdump -ni "$DEV" "udp and dst port $RTP_D=
ST_PORT" -vv -c 0 2>/dev/null | head -n 3 || true
> > >
> > > if command -v tshark >/dev/null 2>&1; then
> > > echo "tshark live RTP view :"
> > > timeout "$VERIFY_SECONDS" tshark -i "$DEV" -f "udp dst port $RTP_DST_=
PORT" -q -z rtp,streams || true
> > > fi
> > >
> > > echo
> > > echo "Netem stats, see duplicated counters under handle ${QUEUE}00:):=
"
> > > tc -s qdisc show dev "$DEV" | sed -n '1,200p'
> >
> >
> > Thanks for the config.
> >
> > If you can talk about it: I was more interested in what your end goal i=
s.
> > From the dev name it seems $DEV is a wireless device? Are you
> > replicating these RTP packets across different ssids mapped to
> > different hw queues? Are you forwarding these packets? The ethtool
> > config indicates the RX direction but the netem replication is on the
> > tx.
> > And in the short term if a tc action could achieve what you are trying
> > to achieve - would that work for you?
> >
> > cheers,
> > jamal

