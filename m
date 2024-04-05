Return-Path: <netdev+bounces-85321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822489A396
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9BB1C2142F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67F3171657;
	Fri,  5 Apr 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM38lWxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5116D9A0;
	Fri,  5 Apr 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338734; cv=none; b=peZZlKxUIzM0Dcu3c+UQ+Dn+YBHhJWB2vICvOTAQwy2XwKZQkuY0w6jVxb38zVUlPkLCT9d0IL7MVB9wtprDbF4juIUxQVtmA2vMBV8vIfWZ6Gyy+Roc38wm5jmkVhSK7oVQJbnM5NEa2FKMo41tyi36u8SCNx8otV6qzUPTjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338734; c=relaxed/simple;
	bh=EXITSmx7hg9jA8ZgsjkiM95zAu11JqjVmt3SeHVSGSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKRzQtE35wVZM2ac8BB6zmKCGU6GfNz0bXb/zNkdO7AVZ4WOloG/CYIV0wgIHRiBLGTcWv8CFLgO/pNdcs5r6g5x3YUzmf68zSMCIV2LT/H8W1PVvJk5wy5yD13S3+/ZpL+qCtf79LjNUjt3Cp1sn7wU+DlNYarrY5YSnD18AVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM38lWxV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d86e6908ecso8519561fa.2;
        Fri, 05 Apr 2024 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712338731; x=1712943531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXITSmx7hg9jA8ZgsjkiM95zAu11JqjVmt3SeHVSGSY=;
        b=hM38lWxVE+TfHcCcDIcrbSZ2Anj8DsNdFSYuviOsrnkneHcEB8FjzWS3IEwN4urXqm
         Zza2wLv9TiRMurU3KYj7zrSrK6SHovHGbnGhvgu9nP9lbODMC0lB6rMzmEEXNKzBJFFE
         HSq26F0+jvuLXzOTpGaVezRqZ/tlARTkydWHgJHiYfYYgHPfAA11ONyzJTbjUhsjj61r
         HXp7msqU1yadqDGic1nh1qWTC4jWuPc98xizgMT/WwbFpUuSxGI4rt8Su0I4c8iw+LPT
         w1C+4UYyU3irTY6Kxx/QeFG56G6YFfej5Zanuumv7VTUJO3AgMv2PUDU+pFEcfm1Eh+2
         xdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712338731; x=1712943531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXITSmx7hg9jA8ZgsjkiM95zAu11JqjVmt3SeHVSGSY=;
        b=An47bvAiN23yNCmo1NvErT5Lj2jQEDKuwG7pktIfrqTvBeHDKJwIbs6FqStO34wkkL
         3G1njYIV8R0jKxt8Er461BAjz6T6DuXC7WbXTPG/PJOzhbnMAqad/fAfIjkSyyt8rdxT
         gLZhUcjtPvdz5U1yGfXxAthpn5FYARv4Nt+JESpT9RVVfJENObOiDbkx2NzqYWavYiGQ
         MEzEVk3UP/kp3SwRE20d6fIcjtxcsCoySwdE9dpIGsf3NBodEN+y04jyuuyfr8tsoXZn
         WvZt/ULAMrDwH31i2BMISOjmj2023/ngIE012OdT3i+45oqmjd763veaD3IfujPjNsZe
         Khag==
X-Forwarded-Encrypted: i=1; AJvYcCXvxmfPJqBk24aMa0klToJFN0HVZ07iBVVvTkbDFQ2ejQ/Q00Fip83qKKSpzJERxCUGFjtYAFYwYhDzhuApEXbKWsjX+O4lhPATquXusL1L8d7MDvZ1iVweZumvJnLZNwg4BQex841M
X-Gm-Message-State: AOJu0YzUk9j3ursrK9X3N4P2UMhglZ9oSnpWOSPO5Mtdw56+Qf9rE5+M
	WLxMzq16sx3N7Hqr+US/uYWFeg9UT8RKmd6H0GQU4FIKMrsLplIAqCNrmW6eszjFXNCbpPP7Dz5
	KR+jrzsmY98rg0Qa+NJopcw9HvpQ=
X-Google-Smtp-Source: AGHT+IHTphl54WyHS7Z2uZ5aawmBbJz/huBk0AIdoBBwIVUMOj5VgkOJbKf9onGpQ4k8pxY4sOdYuKvxtAaysh6jnsg=
X-Received: by 2002:a2e:a26a:0:b0:2d6:d45d:b49b with SMTP id
 k10-20020a2ea26a000000b002d6d45db49bmr1635741ljm.10.1712338730780; Fri, 05
 Apr 2024 10:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404123602.2369488-1-edumazet@google.com> <CABBYNZJB+n7NN2QkBt5heDeWq0wbyE1Y4CUyK9Ne7vBRnmuWaw@mail.gmail.com>
 <CANn89iLweXJRLdn=v6WbqtvW6q0yLz_Dox87+GAnZUmx0WevKA@mail.gmail.com>
 <CABBYNZK08zDX07N9BTcFku=RSzc=W_74K2n2ky5f+qSexSLM+g@mail.gmail.com>
 <CANn89iLO9hO9QqQtNh=qEmLy+tE2Dr7fe9Nuj2dxYrG-z0Cy5g@mail.gmail.com>
 <CABBYNZ+F44x3aYK1kKUi8vLJT04QF48ONzrW06YJz=aq_oSHzA@mail.gmail.com> <CANn89iJzJc+qNgwnEuzGReXqp6Gs7hWnex0_+f2CP9eTuohZyA@mail.gmail.com>
In-Reply-To: <CANn89iJzJc+qNgwnEuzGReXqp6Gs7hWnex0_+f2CP9eTuohZyA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Apr 2024 13:38:37 -0400
Message-ID: <CABBYNZK=oKCcMv8GEx__XiR+tSUwoTnwRkh2-6tJw1He9oGr6w@mail.gmail.com>
Subject: Re: [PATCH net] Bluetooth: validate setsockopt( BT_PKT_STATUS /
 BT_DEFER_SETUP) user input
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Fri, Apr 5, 2024 at 12:30=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Apr 5, 2024 at 6:24=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> ave used this so far (without risking a kernel bug)
> >
> > Fair enough, if we don't really have any risk of breaking the API
> > (would result in using uninitialized memory) then I propose we do
> > something like this:
> >
> > https://gist.github.com/Vudentz/c9092e8a3cb1e7e6a8fd384a51300eee
> >
> > That said perhaps copy_from_sockptr shall really take into account
> > both source and destination lengths so it could incorporate the check
> > e.g. if (dst_size > src_size) but that might result in changing every
> > user of copy_from_sockptr thus I left it to be specific to bluetooth.
>
> Make sure to return -EINVAL if the user provided length is too small,
> not -EFAULT.

Sure, there was also a use of -EOVERFLOW and the fact we are using the
return of copy_from_sockptr so if it fails we just return -EFAULT
anyway, so if we do start returning the error from the like
bt_copy_from_sockptr then we better figure out the errors it returns
are proper.

Btw, do you want me to spin a new version containing these changes or
you would like to incorporate them into your patch and spin a v2?

--=20
Luiz Augusto von Dentz

