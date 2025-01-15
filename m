Return-Path: <netdev+bounces-158539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F81A1268F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BC13A67BE
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD9C13DB9F;
	Wed, 15 Jan 2025 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Lm3wOwko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC112BF24
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952822; cv=none; b=FYYBamHRFTFVS79tZuHQk/CL5o7QunNXfOSDGXrIQCn1WQgQLBLkd3zZv9tAt8oQs8HuukSUBMnV0GepFWJWttrkuM4VmPua99kVdr8MSlqW5iMgnYjNNlNXG5W9ioXG5MUi+MUhqJafgkgUVpAktzTlmXub/7xjWi4ruiD8h6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952822; c=relaxed/simple;
	bh=1AvMoU+I739xYK4gjmeP4+Ghbvde9T/5mj9++l2dz3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gmj/TiNfC+9v2+s0AxEZjfgMoX+oVGdqhz1Xz4eBPyz6I5VnDNFlDIToqrIhJ4IJTfs2I2kCqSc4vbL+jFQQg0kBkvodxeew6kPWM4DHDS/lzrxSqKBVsLOUSDueVkSLlmCKy4wTeq60qMV+Kp8Fav0H3cAyGyBTRCYIxaIvo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Lm3wOwko; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f441791e40so9008787a91.3
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 06:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736952820; x=1737557620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYlnNMwNgVCQYHqelJFFojRZvlLtalcOn671K/kH8yU=;
        b=Lm3wOwkoN4A/NYmtQclAc5dHUl7d93wzkdsBJaoQh/4RxfLMuE4Ff7sSXy9arwqcaW
         Pr8MJWgCJFOvnZ7ph8b7jHTX6OWahGmfGAhaBML/LYMHQUNbd9gSvM74ErbU5sZ3WQhR
         GujGpDcfBE/DbFNmmmMZZg3WSDxY1bZdCvNGj9hd2PORpimKTRgj2Z5BlFe8ts3UGDAZ
         Du+EXm9Eue8/IngYqOhhmWaFxyluWrUnOCE6ljFilgXsUTe2+m4L+IgMipLvylvpJuVf
         40of/uHMTfiIPfSCEllBfZTGrilbIGscNq1Hp4F7czIspJR2QrNLprnjynD+btz1pxco
         D22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736952820; x=1737557620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYlnNMwNgVCQYHqelJFFojRZvlLtalcOn671K/kH8yU=;
        b=cgIYXfB0PcZs4DDjc4qtBi8jONBbyeZ88HCelAkUSLDRKhnfGUu10Rl2rbvUoOrrTL
         kAAGQQeIQ9ca0EUzMlzyG8IQVf0HWYijqbJOy7hCRiShb7VL1fnc/ZoXAgW/NgECdeUm
         0p5SUW+zou+hBYFDKj6zKpRdpy/jn7x22Ww2tMIgxT0TwJ9ytya6XXl7FTj+dZ5GWKAJ
         C0blI40Iq5XU7deKPsv3NonbIf5OpVScaazO3v/6WNYx5aVdNRDWdJr7Qc0oQiuqx/Q4
         sUfLqbQnV5NWc5BMPMEkSYdOpivRQIZ0hvuFOa52Qzer7YMFA0P27DlIcbLsveD9U6uj
         J9KA==
X-Gm-Message-State: AOJu0YzVPqIaycPH9KXhGxhy5VrdnSLmvew8UyVSxRyjvEMMGosBecQ2
	sxzZEDVEP5rM+KT1PHJVkcFlygOt0RO4kkLy3SIzBkF1xnnbyGjWky5jOk6F4rSV7M2klTA1X2G
	BgIbYs8t50Y7rbONLKDMBeDDYzxJfRxDMv3rh5hZHWi8PkPw=
X-Gm-Gg: ASbGnctnOM4XKS8pNWhjyTXGlC9I7hGnlDiZtIeEocTInpMeAwnC4A/6iMPcatvK5sa
	R6RSw51ZrRng4Vf5YeRtjlAdKN6IJMsIdzUR5
X-Google-Smtp-Source: AGHT+IERWc+jKFDIxAo+VLfk/wRUDQYy7GLx+yu0HRC0TCYKbKsVfYvn/ENqhXXDbLSlX2F2LvKXROtXO+Lj+7xPNck=
X-Received: by 2002:a17:90b:2f0e:b0:2ee:8e75:4ae1 with SMTP id
 98e67ed59e1d1-2f548f6aa23mr38858722a91.21.1736952818519; Wed, 15 Jan 2025
 06:53:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111151455.75480-1-jhs@mojatatu.com> <20250114172620.7e7e97b4@kernel.org>
 <CAM0EoMnYi3JBPS7KyPoW5-St-xAaJ8Xa1tEp8JH9483Z5k8cLg@mail.gmail.com> <20250115063655.21be5c74@kernel.org>
In-Reply-To: <20250115063655.21be5c74@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 15 Jan 2025 09:53:27 -0500
X-Gm-Features: AbW1kvbdk8ErKPpnkzXPYqKbGyJpZw3tOYaVH-3SpH4H6eAg8tGonrp2ChYkPxw
Message-ID: <CAM0EoMk0rKe=AqoD_vNZNj2dz9eKSQpgS0Cc7Bi+FQwqpyHXaw@mail.gmail.com>
Subject: Re: [PATCH net 1/1 v3] net: sched: Disallow replacing of child qdisc
 from one parent to another
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, security@kernel.org, 
	nnamrec@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 9:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 15 Jan 2025 09:15:31 -0500 Jamal Hadi Salim wrote:
> > > On Sat, 11 Jan 2025 10:14:55 -0500 Jamal Hadi Salim wrote:
> > > > The semantics of "replace" is for a del/add _on the same node_ and =
not
> > > > a delete from one node(3:1) and add to another node (1:3) as in ste=
p10.
> > > > While we could "fix" with a more complex approach there could be
> > > > consequences to expectations so the patch takes the preventive appr=
oach of
> > > > "disallow such config".
> > >
> > > Your explanation reads like you want to prevent a qdisc changing
> > > from one parent to another.
> >
> > Yes.
>
> In the selftest with mq Victor updated I'd say we're not changing
> the parent. We replace one child of mq with another.
> TC noobs would say mq is the parent.

Yeah, Victor's test was to reduce the number of lines changed. IIRC,
there was an _child_assert which would have to change to a different
number given mq doesnt destroy the manually created qdiscs.

You can replace a queue attributes (eg queue size) or its algorithm
(example change from pfifo to bfifo) in place - that doesnt change.
What the patch avoids is taking that queue and moving it elsewhere or
having it "shared"; that puts it in the funny state that was used in
the exploit.
That was the ambiguity i was talking about in the earlier email.

> > > > +                             if (leaf_q && leaf_q->parent !=3D q->=
parent) {
> > > > +                                     NL_SET_ERR_MSG(extack, "Inval=
id Parent for operation");
> > > > +                                     return -EINVAL;
> > > > +                             }
> > >
> > > But this test looks at the full parent path, not the major.
> > > So the only case you allow is replacing the node.. with itself?
> > >
> >
> > Yes.
> >
> > > Did you mean to wrap these in TC_H_MAJ() || the parent comparison
> > > is redundant || I misunderstand?
> >
> > I may be missing something - what does TC_H_MAJ() provide?
> > The 3:1 and 1:3 in that example are both descendants of the same
> > parent. It could have been 1:3 vs 1:2 and the same rules would apply.
>
> Let me flip the question. What qdisc movement / grafts are you intending
> to still support?
>

Grafting essentially boils down to a del/add of a qdisc. The
ambiguities: Does it mean deleting it from one hierachy point and
adding it to another point? Or does it mean not deleting it from the
first location but making it available in the other one?

> From the report it sounds like we don't want to support _any_ movement
> of existing qdiscs within the hierarchy. Only purpose of graft would
> be to install a new / fresh qdisc as a child.

That sounded like the safest approach. If there is a practical use for
moving queues around (I am not aware of any, doesnt mean there is no
practical use) then we can do the much bigger surgery.

cheers,
jamal

