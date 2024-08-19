Return-Path: <netdev+bounces-119718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F52956B4F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2101C22157
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2313616B753;
	Mon, 19 Aug 2024 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xpm3+aOx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E40416B3A6
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072203; cv=none; b=EarzWsKdRsZ16o18PMVjBLbjeQ9HbcBkfMEz67iCQ0kHm8XWDpW5gyErVGvF+uEv7IeQRN38S7z383eN4TlFJ/7ccNzmvPo9KTtBYtakBEvNYMvnEZrkWpUcGrAMbW0ISROXr40V42Qnks34peUaEyycr8hV+gK5avgbuEinQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072203; c=relaxed/simple;
	bh=o8TWa8jXd/+J40IlAUdQjwsS9ueJqApwTT1lsEcJrps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzeYtlc2YEBPEgro8JP1TMhHhe4vlwlh6/cLynBr3Fn9x3+ecVTuZtPBLM01tQmWW43U9JXu5XfMZ1HqmnUs0EWy+wbYGim64/lDdafhUpmG5SJnvkTN4WpjPUjAZodOOXtNJSzqa9fSuaGeK2Tte/7yissI8f7E4dahV9GUQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xpm3+aOx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a843bef98so463529866b.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724072200; x=1724677000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNe+Uocz99X+ZSzZHYLSgSvqIQowOG+YIFyw7plUxUM=;
        b=xpm3+aOxjwonbb3p6JCYXSXwdqUV6my5s3EdZBHgSFqerY6mUEFpID07mSI3E87VRd
         UjICGUz4VgobDsynKkpJucVA/X/pCwwiMsrlhSyL8Vs8HQgwvjG9lPO7wD0lc53/MKF/
         OiQUEpbfkN9GK3WBPoMOTmCnlSnvX1WmI5HHspAC2Y+UWUa10y963G3dUU4FVJfprHAR
         IeO7Rg6G/Lb0mymOj2LUd6LSER+T7b0kHOj4voWk0ugbtU85WhBn4x53QXgXPPwuD9X9
         pSXHeWJVcTJWJN677L2gpQOJ+c7mjBPCllXWele1shNQR34gd5ohMAAqKr5Z49kMCJVf
         LEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724072200; x=1724677000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNe+Uocz99X+ZSzZHYLSgSvqIQowOG+YIFyw7plUxUM=;
        b=VTVip98DzDIxcjPEHsd4UhlkYoIHFIxFFrZoMbv+iZ5rmqfAK8+Ues6+PqI/nSBOIw
         SAeTQb9Fr1+qySFAHy47zMoVYhABDUa84M2djJsjLEdZbMqccL0pynFrttCjlFoeTxKl
         vTxcX7yckGjIzXn0GK92nzMR0JPwccZoyWajpcGI88zEdRM+WjVdKgcSVS8XgVWMxLkP
         GRzWVFIVht5Kzpx2TylhBJ6NbTg04XSL7JzBEVdLd3uzp6ajlZemL/Nl0/ImWjjE6ijP
         xsCzhDf4h8IFH+ZpHXuls8/acdW7ZeMPuSNjB6Gg4Vk2ylAjPAq1nytwrVTk/+aU3TDr
         3woA==
X-Forwarded-Encrypted: i=1; AJvYcCUu+LoMoBbdyO6rLlATYI0481PVTTKGurluqyy/w5i3aQN1nMBo4OQdk/SWlF1b3U/qSQr4Tu5yZGTLB2cWdInzVqPeBTfy
X-Gm-Message-State: AOJu0Yx2r/MzENaP1ONoDEZck5YUINYbroWygBcbbJDDNgFRdqSJoEk3
	VUqJ/Q/aTLaOH03t8qhf+T7z9MnLEbY3fNdNYEIqS96fCIZ1ZRBuxtcj1lKTk/nokr1MYfBl6jg
	WhGZuG5w64dy4TilN2CDS6W6XRGjr7gfYJoYq
X-Google-Smtp-Source: AGHT+IEAD5F26t3wUX4smHYhRTyiiUW2q5O3YuubYRAXfcFLIHU5M1buH5+5iwz++BJ78tU5WGeq/rtm/rM10UB5KX4=
X-Received: by 2002:a17:906:d7ca:b0:a77:e2e3:3554 with SMTP id
 a640c23a62f3a-a8392930d8emr668791266b.28.1724072198895; Mon, 19 Aug 2024
 05:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819124954.GA885813@pevik>
In-Reply-To: <20240819124954.GA885813@pevik>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 14:56:26 +0200
Message-ID: <CANn89iJgK-_xgFSjpH4m0qmcgwEMaTse7D=XbG-2qi=Gnej+xA@mail.gmail.com>
Subject: Re: [RFC] Big TCP and ping support vs. max ICMP{,v6} packet size
To: Petr Vorel <pvorel@suse.cz>
Cc: Xin Long <lucien.xin@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 2:50=E2=80=AFPM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Eric, Xin,
>
> I see you both worked on Big TCP support for IPv4/IPv6. I wonder if anybo=
dy was
> thinking about add Big TCP to raw socket or ICMP datagram socket. I'm not=
 sure
> what would be a real use case (due MTU limitation is Big TCP mostly used =
on
> local networks anyway).

I think you are mistaken.

BIG TCP does not have any MTU restrictions and can be used on any network.

Think about BIG TCP being GSO/TSO/GRO with bigger logical packet sizes.

>
> I'm asking because I'm just about to limit -s value for ping in iputils (=
this
> influences size of payload of ICMP{,v6} being send) to 65507 (IPv4) or 65=
527 (IPv6):
>
> 65507 =3D 65535 (IPv4 packet size) - 20 (min IPv4 header size) - 8 (ICMP =
header size)
> 65527 =3D 65535 (IPv6 packet size) - 8 (ICMPv6 header size)

This would involve IP fragmentation, this is orthogonal to GSO/GRO.

>
> which would then block using Big TCP.
>
> The reasons are:
> 1) The implementation was wrong [1] (signed integer overflow when using
> INT_MAX).
>
> 2) Kernel limits it exactly to these values:
>
> * ICMP datagram socket net/ipv4/ping.c in ping_common_sendmsg() [2] (used=
 in
> both ping_v4_sendmsg() and ping_v6_sendmsg()):
>
>         if (len > 0xFFFF)
>                 return -EMSGSIZE;
>
> * raw socket IPv4 in raw_sendmsg() [3]:
>
>         err =3D -EMSGSIZE;
>         if (len > 0xFFFF)
>                 goto out;
>
> * Raw socket IPv6 I suppose either in rawv6_send_hdrinc() [4] (I suppose =
when
> IP_HDRINCL set when userspace passes also IP header) or in ip6_append_dat=
a() [5]
> otherwise.
>
> 3) Other ping implementations also limit it [6] (I suppose due 2)).
>
> Kind regards,
> Petr
>
> [1] https://github.com/iputils/iputils/issues/542
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/ipv4/ping.c?h=3Dv6.11-rc4#n655
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/ipv4/raw.c?h=3Dv6.11-rc4#n498
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/ipv6/raw.c?h=3Dv6.11-rc4#n605
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/ipv6/ip6_output.c?h=3Dv6.11-rc4#n1453
> [6] https://github.com/pevik/iputils/wiki/Maximum-value-for-%E2%80%90s-(s=
ize)

