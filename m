Return-Path: <netdev+bounces-227342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC6BACBCC
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1998718887E6
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283382EBBAB;
	Tue, 30 Sep 2025 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlSu87lr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59526A0E7
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233455; cv=none; b=lBB/f2mUWtfzt+p6WYkwBBX2wjMgPVBa21LXWlNJIJwHHfAxXv/go0ZXFDsdQ+kyq9CEWXeHAq9wnqSt4OHnu759eJ356w18uT4cyNCBY+EjobwMkSfJmOsYdkU9eAs5vDYuXudInm0KUK0UmO1yO2F6yetIJxzwOz4CCOG/RnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233455; c=relaxed/simple;
	bh=kqh94AtRdnvNOtGrMAnDMgdoDLSE5h0RhP/RH4pYhF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHUONVjPhOynQFpcxuN3nGyTpdbHNUpf45+N8fJDkpi5n4c3CeD4LL2vitYkNw1eU05Jx58X3LjYNdYqF9DCKZxwDDCDYZcQBTKWZEQx5U292Y7nu/E/ChNJKQIUw/kO7HbzKqu9tqqWMClbrLvCAc+hcnIN9KavOznGzbwCwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlSu87lr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3b27b50090so534627066b.0
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759233452; x=1759838252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqh94AtRdnvNOtGrMAnDMgdoDLSE5h0RhP/RH4pYhF4=;
        b=JlSu87lrBGp51zsJOfS9Gtmj29SnA4ufqCSxSgHLG/eerN4NAGR0zwFC7Vn0rRPmGr
         lfVXhT4I5SLzKGbFeyhTPLIki5kJryEdq6lqeZibAhgb/goZkpLkO5idZrqNj4Xwdfgq
         n+J68h9pG26lJcNOrEZGolrcmJLF9TTGyevKASMmtAi7VMutSl5dHEyFdjTzleVzU65i
         65v/+tpc7UINF+ghDj6DUn5uXatBBuk0K//EfbskD7pdUD/kdH/BNThSVtsYM6dltJbl
         dX4q52N9EaeEAY+hgi65d7EiMBoHYHnpAA/RyB9R5iKlBmHHEbuH4+rhyjaafxJtyF2I
         UwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759233452; x=1759838252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqh94AtRdnvNOtGrMAnDMgdoDLSE5h0RhP/RH4pYhF4=;
        b=AfpQjZcopOgbT7eswYH3XUg2AZjlcAq2IlT+KfrgsaG5EE1hlY7lglrgQVSAK0w6QH
         clMPGoBF3ieuUq+NHgUJpAQKjEiBROx+CAeD0XmNNuSh6/+2zdVp6Y6r7svGCLyeQbbu
         Z4inD4jY7HX4lDCPb+j77E4BOZf3F0QaMdkb3vI8iRKvudPIrsAtX8jyYgb33GU6rKaX
         V+/K4e+7GMCAJ9PDBvds00Uz6o0o8ZNJfwtzgkMvPrXszBIY+m1/1p8098GWGMu7Udkc
         b5sQllic88/8B9wPAUMkh/WKgEHatN9WwirMG8kPWQtti45074L6eCFB3j0kAp8fZUQJ
         NLPw==
X-Forwarded-Encrypted: i=1; AJvYcCU5qMMuq2EEC4ABaiAC4y10dp0oFvx+2aqlbLGaF1027sCkC4wqPK1y8cppqXuyML6Zrjwf7l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCe9C0cVZfmpVg6JILB0tnjbzTkbHyKhCXcR1cPYE4dLOSFXB
	ueot1xbXa5bd/v4dRoUwXqaOzNhfAcjIVvdeJxr1B87vzun4WscWdMWqoaLTFXvCKFrLtbi/3Oz
	fbFx9ZroLr0PmbCJTo2cgxT5MDjfObD0=
X-Gm-Gg: ASbGncsvSmZLtGQLak2+BGcfKdkqSbyMV9QbxMttQCXRjpbtDDFmM3VSU5l/BfxuHHP
	ogRmAbAFBr+4eP5RkkcC5pddv18kmscHWfOv/YQcwrw6hs1Em4dWc4S1ybIHHhv4AqoKkR8ihHP
	+hMi4V5YK+tD6irU+K3MabbaD12sqDF+QeYbNsI2ngv3Dv3kvCO9yFuMfiWjjK00XPJOKyA55+o
	9Zy26QXhZO540bFhQTdTLu0STY+0831fMRu/eujr2fP95QieV+LgyPMd/3coVr2GL7G6QCy4r5A
X-Google-Smtp-Source: AGHT+IFMtK7lQG2C6CXy0BdUz73VA5EZWA5GWFM67vubKVCmaj1C4S2cfo3XpGObqlbGqLwQb0CID+MEAVyWsVhI3os=
X-Received: by 2002:a17:907:1c95:b0:b46:1db9:cb7c with SMTP id
 a640c23a62f3a-b461db9dc6cmr76159766b.33.1759233451417; Tue, 30 Sep 2025
 04:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930100656.80420-2-sidharthseela@gmail.com> <a21498ff-4dd0-4b3a-9b2e-9b932b5925ad@openvpn.net>
In-Reply-To: <a21498ff-4dd0-4b3a-9b2e-9b932b5925ad@openvpn.net>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 30 Sep 2025 17:27:20 +0530
X-Gm-Features: AS18NWCxdvM572oUhIGZSez5YvvgrvAB2_xyu9_VKgGBmy-3EY7uowJXb-VjjF4
Message-ID: <CAJE-K+BrTdtXTF6VgRzen=YVmuUgU8ktu_36nXqc2vTF=u_vLw@mail.gmail.com>
Subject: Re: [PATCH net v4] selftest:net: Fix uninit return values
To: Antonio Quartulli <antonio@openvpn.net>
Cc: sd@queasysnail.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	willemdebruijn.kernel@gmail.com, kernelxing@tencent.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 4:50=E2=80=AFPM Antonio Quartulli <antonio@openvpn.=
net> wrote:
> Hi,
> Thanks a lot for fixing this - I hadn't see the warnings with gcc.

I am glad, thankyou.

> ret goes uninitialized only under the "if (!sock)" condition, therefore
> I'd rather assign ret a meaningful value instead of -1.

Yes, you are right.

> How about adding "err =3D -ENOMEM;" directly inside the if block?
> Same here.
> ret goes uninitialized only under the "CMD_INVALID" case.
> How about adding "ret =3D -EINVAL;" inside the affected case?
> Both values are returned by ovpn_run_cmd() and then printed as
> strerror(-ret).
> If we blindly use -1 we will get "Operation not permitted" which will
> confuse the user IMHO.

Alright, understood, Thank you.

Sending in the changes in v5.


--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

