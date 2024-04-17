Return-Path: <netdev+bounces-88641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DFC8A7F8A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 11:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DE51C20E1C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DF512DD87;
	Wed, 17 Apr 2024 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKX9QEQv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A7127B45;
	Wed, 17 Apr 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345765; cv=none; b=DgR5mzRsedPhElXxQEtqFscBoFJeNLmaYFiwKgUKizEbb4QVWrKKxj4+XRnMJJo0SXogwNPm/N0qCcVH6U2zkduzsylV+vUO/M+Qd98dnYxqnNdk6taOlkHsecLyo09IMjs4VVbQNo+D/CA73KdVnCc8p3iQxnZIt+3e6Cyfq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345765; c=relaxed/simple;
	bh=c4au2icJSPKncXqRvVreWlcffcYZI2pV7PV/A3myfjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoOL3A8CfW8epNZ260t8CW+XTXH5rNNzkPGxHXm7wNQNrhUawkqvmTAr0pPARtQ+K16wd8qVBtln5U3B+ipfr6DU5pJKWHNLodq/fh0sclqf1N0y4DAQhePb7TCRMwfDVbnf1ODKeOaw/lB1kLpCyClbyOStgZak+4YiCKyWtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKX9QEQv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51beae2f13so614247366b.1;
        Wed, 17 Apr 2024 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713345762; x=1713950562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW9PmjLbwn7pJabXhHqlARTl4IzAtlALQknNYaa1aEo=;
        b=dKX9QEQvVJcf9wPo8bwNyOYa70DxEY8vp7W/ED66w6jmxzKw6WmHmf8Jb7fD/xtSjQ
         dGpI5B67+G4wkeSZJJBbBWSzPmet+k/o/Si92aEBtmLkz079ypmT2M8yJWeKs+7Zy0NM
         2c8WQXtGCUxlZsNjhqw3YBU9Ql6QFQyNVcEKr9LvHRDdx3Y/Pjqg+tcaNWxdcmuMnzkG
         XsADrvdECCSCIHS+ZRFDgwjmhAtJ14epcjAHRRlr5GwwOOLj+bMJi52piGh3+y4qCgnk
         8ZXFIbwTO+ab7kRUiyvI8HyfBfKAkk5dwH21yyViGOgQ20mCawsiq7++p4Qh3ekLBR5J
         b2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713345762; x=1713950562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OW9PmjLbwn7pJabXhHqlARTl4IzAtlALQknNYaa1aEo=;
        b=Y8yQF2lJWDfPZG677aE+9YLQby2L6L//zV9HTKb9JrAyXjpi9/dx8iLEYjoABOXfRf
         YDjnauDFJtP5R/W57wBKOY/1Vv4IFh/s3Tll9gXS/ZEyLy1yuMtVSCv9Jiad55ElCSA0
         2hyx7xXcF8T4ssGOY8DGbcL0iNrXxdiNgOBo+q0MRx2Zy2EfIHHjtRe8IJuwnW+hXz7h
         5RvPeWnh8vbWpySPMIrtJWKylmZbaRZqIuh3QVQ/zhVohrMASz9NKTz1mBtbWKNd5zX2
         gBG+h6uHR0YGS6Y/kng3YnB5MquSVb3j1Fm6Vyd/0mWm0l32UPNtfPHxAj2CHWqzXrlu
         4PaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoVR7EGVfok721rPWgVTTJ+luCnGui534WMNt/mLg6ZHV96JvFUJav4X6AcFHrbjtDxEKEQ0n62wf3d65olXADUvXCY3mKmB/wQK+hry9ya3c7PgkcZpz+eO1hoed4l9xnCr8BokZYFhww
X-Gm-Message-State: AOJu0YxwIpZ1XHJLGYagLyUR2Vf40GQrSPDu7ZvkurE24bykhdhOlGsa
	FYMldG9yl9bMBhBWHSp8pSV2e9/9XaJ78F9PCWmZovr7zcNAAHIZ+FivtJ0fmfZfM8sYCEJtpxn
	FZOfmq8YaAHbUk6sfFe0nX4QgJeQ=
X-Google-Smtp-Source: AGHT+IHL2T/dUxZvTLwRpF9eorxg0NEt2cytKUT4skY49BBflJcjLDdYgmw3ytzpCLdQ5PdeePx2tsTKBimLdU+a+kQ=
X-Received: by 2002:a17:906:3fd6:b0:a55:54eb:c3dc with SMTP id
 k22-20020a1709063fd600b00a5554ebc3dcmr801485ejj.77.1713345761680; Wed, 17 Apr
 2024 02:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <20240417085143.69578-2-kerneljasonxing@gmail.com> <CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysvgR8FrfRvaa-Vg@mail.gmail.com>
In-Reply-To: <CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysvgR8FrfRvaa-Vg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 17:22:04 +0800
Message-ID: <CAL+tcoC8VPOhvPbdbJUrRrAiLaOF2jwsoBkFBEkivPgMzijG5g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Wed, Apr 17, 2024 at 5:02=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Apr 17, 2024 at 10:51=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add a new standalone file for the easy future extension to support
> > both active reset and passive reset in the TCP/DCCP/MPTCP protocols.
> >
> > This patch only does the preparations for reset reason mechanism,
> > nothing else changes.
> >
> > The reset reasons are divided into three parts:
> > 1) reuse drop reasons for passive reset in TCP
> > 2) reuse MP_TCPRST option for MPTCP
> > 3) our own reasons
> >
> > I will implement the basic codes of active/passive reset reason in
> > those three protocols, which is not complete for this moment. But
> > it provides a new chance to let other people add more reasons into
> > it:)
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> My original suggestion was to use normal values in  'enum
> skb_drop_reason', even if there was not necessarily a 'drop'
> in the common sense.
>
> https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr=
+X4k=3Dw@mail.gmail.com/
>
> This would avoid these ugly casts later, even casting an enum to other
> ones is not very logical.

Thanks for your comment.

It's a little bit tricky. That's the reason I documented and commented
on this in the rstreason.h file. I hope it's not that hard to
understand.

> Going through an u32 pivot is quite a hack.
>
> If you feel the need to put them in a special group, this is fine by me.

Yes, rst reasons only partially rely on the drop reason mechanism to
support passive rst for TCP well, but not supporting other cases. My
final goal is to cover all the cases for the future, so I wish I can
put it into a separate group, then people like me who find it useful
can introduce more reasons into it.

Thanks,
Jason

