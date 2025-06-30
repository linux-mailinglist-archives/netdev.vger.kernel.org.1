Return-Path: <netdev+bounces-202390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA3AEDB17
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2CD16836E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1E41DC988;
	Mon, 30 Jun 2025 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HWbYX9ga"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C3226188
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283182; cv=none; b=V38bBn7jVSbe7ZRDBdgvFXWujKUmz2qySzKmtfi1YPvipIl0lMS4b35mPYuyr6H8cLCyXbbuvUb2dEcWp6vHqAyufTWqySUXVCG12GFviw8ku8VNbR50RRGsbdtvERCdo9TZTxb8HdtUwtgpi8uvHBTJBFzImNWf28LyAoGp9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283182; c=relaxed/simple;
	bh=65twQm64xfydii+ny7JcysPG1SmfV3sfh84wIm6T9rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZJLab3COX2f2UdZrHwhi1AdKBMCBl8BTPW30H+15ZW/BBEqUaMximpSvCgLa0ca6iUcyc7IY/HtTEpVXwHC/MqY23l7tkkOcmqSO8BSMaWa9HBVqHf5bps8GQf1U972P6Kc0G33dB4Axb8VrD7d+R/MJKpC2cgsUx4EyCLEL1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=HWbYX9ga; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7426c44e014so4497530b3a.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751283180; x=1751887980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swn5rDTKn7kkspqbQhYIkyYeTrK3XocLUwaW+rvFqvw=;
        b=HWbYX9gauTTrsQjpcDQeB9haqVVbmykC7/B3SXvsljsha2tS7OL/Ku//FsRHM6s5MM
         lGVskKHRdGbYzbQct9/MzrOcS6aXlXR6hX/H7VyUcDXFlWVxcaJrS6Ey9twCRVpIb5td
         IFdwmzCvtddtYV1+sHCfxQkTwXTcgJDnM0Q/3LgGTjHU45jCr+m/GJLXmtaM3/yMoJnC
         jTrRvh9/dDY/96r4+62QCU0Xv/9MfWlX2mW3Ksd8WMiSv33223GWF09h3Co4Hu9x2nNF
         AFytKbLAaFo3nC/ycGrM6Ss6KKeqhQTHwFLD8mFNqj1FbmmPzpy0+ffiQWeTILKam+Hv
         5AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751283180; x=1751887980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swn5rDTKn7kkspqbQhYIkyYeTrK3XocLUwaW+rvFqvw=;
        b=CcOox1Byk0quMTtWTfcWbpcuAIryCqLNZQzE9qWn7xswWdYavj/1Pcf4kuRzEHHLxy
         ViECHOGx20RfXTYQlUtHKHnSWLVgXgkQdcZORkbmtnXvSdpCyN2kzWz7bmlkB1Ph7JRz
         ExmuOWQjxWYie6MNwHoPo6BJov2GLVN/lKrNUSlqlVn4U2HleusgI4FaOvWELOE8KW/1
         v24ez+7g45KOKnQ1LmQqUHM/Cptw4B6ZSpqk1aREPx7RdYE36opx/SxryHLO97FF0gaf
         d3V79uG0cSCGCvU/ireP0FSHXPEyVdlzUgY4ARSNC24+taJFXPGxEyczDpwIKPAhB9CW
         CzKw==
X-Forwarded-Encrypted: i=1; AJvYcCUKO3VA4nhGKZkFAiHCUFg+2S3OarliqEZuezzh7LkgKTmEbo+Nc7APbBOnF5mR3iAGE9hkiDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJsuRI4uPxuZmUQCsad1ko+nCR+LQwEQ4HYu2hdabaDPSb/W+d
	td/RzoQJTsr6IwZkMlQurNVgRACBkXwi9t/rSFKEeZgd864aCMWRQS0A3M3G2Wv3tIwzOOyboOa
	z5IPjgZIZPmsjsZA7eNKdNHM2FgaJmkM2veQi5mK/
X-Gm-Gg: ASbGncvB/q9dV5Q7E89HF1LpZgcPnNcnf41SF6Io1pcEBhvzItx3IUK0CcUO4UdfR7h
	H0U4MAFNVmzJtsqtlOQnsSuJXUi3Gsv7Rke7Y3BTXsnQGWiB9abOtvQo5uU1LPs7PpzKYnIcm3Q
	eb2bk/O9aPUVx+2G75CgENg+wS2mzVPU5QwIW+dCpJ5kSeOPjR4h5a
X-Google-Smtp-Source: AGHT+IFMx5kxaPJKwhVKJbzQBSW6mcJI+L7E/YGOkmSKT+YO3sM5jbGyvojrMJwX+1OfB7Mhz4U3uACWfkxMGg4NOQ4=
X-Received: by 2002:a05:6a21:9006:b0:21f:bdc8:c34b with SMTP id
 adf61e73a8af0-220a180a2c3mr16857465637.42.1751283179898; Mon, 30 Jun 2025
 04:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627061600.56522-1-will@willsroot.io> <aF80DNslZSX7XT3l@pop-os.localdomain>
 <sf650XmBNi0tyPjDgs_wVtj-7oFNDmX8diA3IzKTuTaZcLYNc5YZPLnAHd5eI2BDtxugv74Bv67017EAuIvfNbfB6y7Pr7IUZ2w1j6JEMrM=@willsroot.io>
 <CAM0EoMkUi470+z86ztEMAGfYcG8aYiC2e5pP0z1BHz82O4RCPg@mail.gmail.com> <aGGfLB+vlSELiEu3@pop-os.localdomain>
In-Reply-To: <aGGfLB+vlSELiEu3@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 30 Jun 2025 07:32:48 -0400
X-Gm-Features: Ac12FXxaoVHKufjwKytNvrHFGYE7gX4LKc3lHE_YWx3ZBNZKs3GbEiCNXnltyYA
Message-ID: <CAM0EoMnjS0kaNDttQtCZ+=hq9egOiRDANN+oQcMOBRnXLVjgRw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org, victor@mojatatu.com, 
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, 
	stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 4:16=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Sat, Jun 28, 2025 at 05:25:25PM -0400, Jamal Hadi Salim wrote:
> > your approach was to overwrite the netem specific cb which is exposed
> > via the cb ->data that can be overwritten for example by a trivial
> > ebpf program attach to any level of the hierarchy. This specific
> > variant from Cong is not accessible to ebpf but as i expressed my view
> > in other email i feel it is not a good solution.
> >
> > https://lore.kernel.org/netdev/CAM0EoMk4dxOFoN_=3D3yOy+XrtU=3DyvjJXAw3f=
VTmN9=3DM=3DR=3DvtbxA@mail.gmail.com/
>
> Hi Jamal,
>
> I have two concerns regarding your/Will's proposal:
>
> 1) I am not sure whether disallowing such case is safe. From my
> understanding this case is not obviously or logically wrong. So if we
> disallow it, we may have a chance to break some application.
>

I dont intentionaly creating a loop-inside-a-loop as being correct.
Stephen, is this a legit use case?
Agreed that we need to be careful about some corner cases which may
look crazy but are legit.

> 2) Singling out this case looks not elegant to me.

My thinking is to long term disallow all nonsense hierarchy use cases,
such as this one, with some
"feature bits". ATM, it's easy to catch the bad configs within a
single qdisc in ->init() but currently not possible if it affects a
hierarchy.
For starters this is the first one such "deny" feature specific to
netem to not allow hierarchies where we can have a netem loop inside a
loop. It didnt seem like we need the infrastructure just to handle one
case and for that reason i thought William's solution was reasonable.
I could swear i posted a sample patch a while back but i cant find it
now.
The other obvious case seems to be  ->qlen_notify() effect (but there
may be other solutions to that one which we can discuss).

The problem we have is all the bounty hunting is focussed on finding
such nonsensical hierarchy (and it is getting exhausting). We can keep
fixing things that break because the bounty hunters find another
netlink message to send that will put it back into an awkward
position.

> Even _if_ we really
> want to disallow such case, we still need to find a better and more
> elegant way to do so, for example, adding a new ops for netem and calling
> it in sch_api.c. Something like below:
>
> // Implement netem_avoid_duplicate()
> // ...
>
> static struct Qdisc_ops netem_qdisc_ops __read_mostly =3D {
>   .avoid_duplicate =3D netem_avoid_duplicate,
> };
>
> // In sch_api.c
> // traverse the Qdisch hierarch and call ->avoid_duplicate()
>
> What do you think?
>

Could this not be circumvented by some filter setting this to some bad
state? The answer seems to be "yes" but i may be misreading.
If you can isolate the solution to just netem and netem fields then it
should be fine. What i am not comfortable with is adding some feature
or metadata that is available across all qdiscs just to solve this
(nonsensical) hierarchy use case.

cheers,
jamal

> Thanks.

