Return-Path: <netdev+bounces-161256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1685A20381
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 05:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049667A3EC0
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 04:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F04198A06;
	Tue, 28 Jan 2025 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdTZ/Jba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2D1991BF
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738038323; cv=none; b=A1TQM98VcIcD+94kHp11PHqLlOelOX83y9fdJB2X07cKBWVP1XMVyW9XHXMWLw4G+tM6QU44kCKUwiQuKYbbVQwrb9x7jaErhlZs4d9GnCn6MWLlF2tTu22X2y3YNd4jaTb2fUK37PIPS7EOPm49t2SCcOn9F0b/dvUsMtHruaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738038323; c=relaxed/simple;
	bh=11bqkB54pIHiKc5ButCzGwgr45pJIQMnrCAWq8p3lA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcYhun97saVmV8QlnNT9VU7qCIOkc5lNGl0HyyPUEkVXtgYGhiDjFXXvhyR+OP6R/Z5xi9Z0dJNTa6hXIixGGWnZHf48a5ZIG1qcx8oPxkQcZ49gvsQONTw+o0G+10FcM48qZkGgpshqYCYsr6+v0uCksMWY+C87h1xb4uZ4Q0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdTZ/Jba; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afd56903b7so1391449137.1
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 20:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738038321; x=1738643121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soTEC2hs0hDsA/Hx6T0AxgC+2Bfdh1wRmBwdrMabW6s=;
        b=bdTZ/JbaodE1C/UR4p5omUeHA5qUU8RpTlx0S8B6YRCrbE+Wey+vyjaDTDy09xaTGZ
         JMlR2kgAL0KXnjhqvHKLdxJeZ8jhJPY27aCt8SqqOmyspNydz7Cmgq58fueEnZ3K1sTv
         iHmTc6OPVg++cAGkFqiW0VB2FOjQttXgfYaj23IbkP8FuEvhFZ6NYHDKN/QYRZU2kNpk
         TECX1Y/5dITkEpyOaxFk+oQp3rk/HwFy36odvieha6o4qNdq6ZN9a/rAVoYokHQYlfhs
         ESkUpkhv7U2DyzAfua/fAV3GBcNquXtbbE+UpLi66qPa3hoUC4WJksNJjoiQUOhEwFJZ
         T7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738038321; x=1738643121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soTEC2hs0hDsA/Hx6T0AxgC+2Bfdh1wRmBwdrMabW6s=;
        b=szs87tS5Saj+shQEdVzMHA1FLwrE9YUHxT8go7M2RrD9V2FRaXRTNy5mmDViPlbD1I
         NlDV5k5D1Kz4sjkiK+5zcB7oxhIdgoj8V4qZkHstnI6eUh5hMw2aj/uMdHYwCCJ440zf
         FN/YzMfKmjkj5UOISrwKOXMgTw0UxJRq10dxPcnGYeIjCI4Iu4uLGHRwFLp8658KaoAJ
         KPEJjHwDHVwxxy30AYwurSzG27cPYqaR7VDx8Ug0SfFp5W21YiIqVjxvc6djlo3+txzL
         Vv54p/pYv5EgmxmtUV0sP+c3uznYswOeEfcrDsgdQGUIofgA1q3DxVF0fLPe4KQGtm3z
         5Rcw==
X-Gm-Message-State: AOJu0YyrTjwDZ9w4MMksQQXRWN8+VFX9EcSICsLvEC8vkDLFbr0bfxdo
	royHY3E+R94QS5ayoZZW8Ig0C0GAbeVI2REhHqGz+zHnUnVZpnGggucAPZ32huYaKzrB2bVv7je
	KLVB7tcKVYuRdhD8KzL3nFLPbLm8=
X-Gm-Gg: ASbGncsABT8nIM+alKT5kBSh6/NSLVjO2fOb3nZyXJWQy477B7XI/uH11vNxbb0wMr5
	owmvOkbHyaTtYZCYuPobw08Zt4MOfQiaU7jJHVPS3F+Dva2rCfSOpcB6jQGHNoLHdka71V0zFN1
	raU8M0HgzVOKYiXdPMZzfeKReg/gA5Gg==
X-Google-Smtp-Source: AGHT+IEhpTe6VnwskkgRskp76WQ5pV1z7pLNONm6BCF5QFuzFzZlKLluoGh4wnsNNESC8Y3ntCm6BeocZu9scGeZo8I=
X-Received: by 2002:a05:6102:3c8d:b0:4b6:35c4:6fcd with SMTP id
 ada2fe7eead31-4b690be4319mr38988544137.7.1738038320913; Mon, 27 Jan 2025
 20:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
 <20250126041224.366350-3-xiyou.wangcong@gmail.com> <20250127085756.4b680226@kernel.org>
 <CAM_iQpXaf9132bjg=MkJYttoz7ikypmeJbpo=-t6qJmutYe9-g@mail.gmail.com>
In-Reply-To: <CAM_iQpXaf9132bjg=MkJYttoz7ikypmeJbpo=-t6qJmutYe9-g@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 27 Jan 2025 20:25:09 -0800
X-Gm-Features: AWEUYZkUjVR0QYXstz8IBySf7ODeIORdOA4kQTOM81N7lgAuaTRiCksQ-XSWFPc
Message-ID: <CAM_iQpXDtMngE1Pcf9KBmRpb5sZK4EJj6qgPgt1ioYW4QC9W3g@mail.gmail.com>
Subject: Re: [Patch net v2 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	quanglex97@gmail.com, mincho@theori.io, Cong Wang <cong.wang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 5:08=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Mon, Jan 27, 2025 at 8:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Sat, 25 Jan 2025 20:12:22 -0800 Cong Wang wrote:
> > > From: Quang Le <quanglex97@gmail.com>
> > >
> > > When limit =3D=3D 0, pfifo_tail_enqueue() must drop new packet and
> > > increase dropped packets count of the qdisc.
> > >
> > > All test results:
> > >
> > > 1..16
> > > ok 1 a519 - Add bfifo qdisc with system default parameters on egress
> > > ok 2 585c - Add pfifo qdisc with system default parameters on egress
> > > ok 3 a86e - Add bfifo qdisc with system default parameters on egress =
with handle of maximum value
> > > ok 4 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes
> > > ok 5 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets
> > > ok 6 b1b1 - Add bfifo qdisc with system default parameters on egress =
with invalid handle exceeding maximum value
> > > ok 7 8d5e - Add bfifo qdisc on egress with unsupported argument
> > > ok 8 7787 - Add pfifo qdisc on egress with unsupported argument
> > > ok 9 c4b6 - Replace bfifo qdisc on egress with new queue size
> > > ok 10 3df6 - Replace pfifo qdisc on egress with new queue size
> > > ok 11 7a67 - Add bfifo qdisc on egress with queue size in invalid for=
mat
> > > ok 12 1298 - Add duplicate bfifo qdisc on egress
> > > ok 13 45a0 - Delete nonexistent bfifo qdisc
> > > ok 14 972b - Add prio qdisc on egress with invalid format for handles
> > > ok 15 4d39 - Delete bfifo qdisc twice
> > > ok 16 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit=
 =3D=3D 0
> >
> > Same problem as on v1:
> >
> > # Could not match regex pattern. Verify command output:
> > # qdisc pfifo_head_drop 1: root refcnt 2 limit 0p
> > #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
> > #  backlog 0b 0p requeues 0
> >
> > https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/966506/1=
-tdc-sh/stdout
> >
> > Did you run the full suite? I wonder if some other test leaks an
> > interface with a 10.x network.
>
> No, I only ran the tests shown above, I will run all the TDC tests.

Hmm, I just got another error which prevents me from starting all the tests=
:

# -----> prepare stage *** Could not execute: "$TC qdisc replace dev
$ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1
2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0
sched-entry S ff 20000000 flags 0x2"
#
# -----> prepare stage *** Error message: "Error: Device does not have
a PTP clock.
# "
#
# -----> prepare stage *** Aborting test run.

Let me see if I can workaround it before looking into it.

Thanks.

