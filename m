Return-Path: <netdev+bounces-251331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6DD3BBC4
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 00:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E01830274FF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 23:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9035F2D8DC4;
	Mon, 19 Jan 2026 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G/Jd15XW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1296A29D291
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768865518; cv=pass; b=k/aUxKTe5awB9/DLK+wY/r7zknyaoaMmAAmkNZ3KLV4bkNEjnE2vmchzb7uzN+TZ9jYkh6dZQK80XOgZQW+1i3FcHsD5YO8YWWcIJzeA2UK5LyoFhhs3k5ZKixnQI+6kZqCmg/anaUfYY83QMecOTU5vVUVELfzUKhpr5JQRhuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768865518; c=relaxed/simple;
	bh=uuBegOhsLC7Fed2e4wyoLTmC+E9EyIwYR90cs4vY0qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afTinAqKQvPzTHlJ1lxxm51j7l7idCDua0NAjkHwse2KYLZcRwdWRMcP/Xf5/Eyg+QzV1g+mnQyh3Gg3gJqnCty7f3pzYze8+Cet8G/ZeUPzF/Jx35nyN63AfWrm1KlRrDPPa/QBf+6+Td9LP+012AnG3Yc5yvJ7e/Kn8xXMH1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G/Jd15XW; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so3162257a91.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 15:31:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768865516; cv=none;
        d=google.com; s=arc-20240605;
        b=hrwGTe+7Qrr5S/C0nZeDrYNxfVTdSNtJq5YEGylX5BF43zGHnBomgyqNAx940LA2g+
         HsHUn9/GmZLOVv/foFaNwkt425qzy1HuYs5Eifckd7xXqpDON2nLsBh08IMVh4H+FmOd
         rY7UcktKPyw1rETGegAgTMD7blOH0ooVYZTeyYYNwX+SKu5RP3ivvOhvO+Z4UckTHSMV
         pnlDgG/6gA119ZP5DX3vkk/YsaO/VbNMFDoXBebZPM6/39xjZ87XVxmQNVy3y5NQ/+sG
         zkcUyTJe1gEiyKYf1IN1erQiteAyVqcp4oDon0iPtxSDiifGrxRAVWoCUJPuquaGLhF8
         F2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuBegOhsLC7Fed2e4wyoLTmC+E9EyIwYR90cs4vY0qs=;
        fh=OIGI6NdgwdM/0KkxTwuUKEL4R/5Eox1ayz4V1bYvAY4=;
        b=bEJ3ag5nOYKJ8tx2/oCEPU7worNhMTBbSAUumpkXK7vUwDDWf54d7IWHjDADmyTgwr
         qoAoG5jLqwyUOy3YchpaJ2URQziv6oHORLeyI6kyy4X5WbRoshohndefHmwNluSTga+I
         09m3zhHmyS/YbkPrV5ygIoJ0nDcvFJCXkGEfbxu5im4Orudzjqevu51vVk0yNJFdh1eL
         ju6LklIrHb8eaomfSYpe/TAxy/AcCEdXmRtNhdTQmRCaHDmS0bS2fWpB0Hs+UAEaLcTu
         yxcPk1w/yyGVNAf9xiBRdCDCANYBvtlmxuiAhgDkqWpX1hhz1FhDBbxXBI1PX0jZM0rI
         Dbwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768865516; x=1769470316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuBegOhsLC7Fed2e4wyoLTmC+E9EyIwYR90cs4vY0qs=;
        b=G/Jd15XW0rNztVU1/K60oVoYKmJiXSaeIEt4rZLSc0/OjJYxsZ1xdu/AhVNY8qW58Z
         Fu+prL/hNN3xHeduocfglK8gpdo6k3rcJ4yajdGC3i8CO/X49b9RjpYeUVDFbnMpkk0/
         c3f4b5uYzRm/jEit/UtkT95AeiexxGXrI/Zv3/DN6wz/SzhT4ahY7AypeEao7GrjYiZT
         HTOPxqVt1s91KLn3uKdNtYzis0EHBvA8CFGs0Bt/WxgjJtKyNgf9v7olJy36AgLRURvf
         tPPmNDmxuImaYlc/gl1Ui5jh8VVO0ARUmRdp93oQkuIY2pL+cz9Wc3Q68WjDRDTlJXlL
         v7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768865516; x=1769470316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuBegOhsLC7Fed2e4wyoLTmC+E9EyIwYR90cs4vY0qs=;
        b=mL6g3Fx5tjET1+ATgpQohxik/o3D/ZV4KIsYl92636PKXnGOQAU0f1LAv0wIAo/xW4
         oaNB3GmZfbNuDlkk50Et7Bk4a2XmLC6SfNNe8fp9yU3SrztbmAVCXUVm3jGVuoTDo0JB
         X6t0+deLvaimkc8EZtnss71QKj/kooWlFevBvi3LOdxX6/rbjVvf6u5XQ40CPRK6+b4v
         Q/eNfQwu9NcQom0bZKM7C6FwOt/MKW5Fan3aOMP6LGuQTZEVM7M9nKJ5IRdO4vm7ckpT
         n6ve63cdgp/mPPfDCC4dPvvI3HS2STiA3H4zFRE1mW3ajwChdiNo/e0GU4dDhbP1BOnE
         ZXoA==
X-Forwarded-Encrypted: i=1; AJvYcCWTWLU50tleqi2jc0zBDG7P00I6+ZAZi/F7/EfST2DdrrJ/QQxGyXX5ZT2hWtK7ljUGfCTz/w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0gSQipG0kVU2RGLoQszhpLFLdrbRYq5/VqEoNq9X0cpsSbdc
	rpayUf6RbYBdV175JZ+1gaY6r6jLPQWTc6lVP80EFki1kWP4h+s4RMLaNBwKREDoJrNCfpYxg7X
	wk6N1JKrzxnjq4fNxBfZWEX6MXTG3BNIr/j07Gdoa
X-Gm-Gg: AZuq6aKicm8Zee9NccKuVSLy3Q5YCnJgyyRT+0r4WF8cpo1dNXjcgVUb2/NsEYK1a1P
	49V/gUfu/PUt8iCheN+0fY+D2R5gaF6rKR9LoO9o9Dsua3PXuFX+gAc2WUCDLMVShf9fMMQtb5I
	ETgOdkUT6gfw6/uP6Pxu8YlUARU6EZ/m+If0GJQOV7s9bfkK2iNgQFdgIyZ3u92FPZiM0NV/don
	HnMaFXe02FsgelAAUBAr03yqp58CIDXaGNtbzHrYEc0eWj7+/HCHyQJabviejPQZOeOfItuSoIl
	wnp1JQ==
X-Received: by 2002:a17:90b:3884:b0:34f:6ddc:d9de with SMTP id
 98e67ed59e1d1-352678fcf6fmr12723525a91.16.1768865516220; Mon, 19 Jan 2026
 15:31:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aW6YMA11KFzSkgfw@gmail.com>
In-Reply-To: <aW6YMA11KFzSkgfw@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 19 Jan 2026 18:31:44 -0500
X-Gm-Features: AZwV_QiFd1darNJ4-NmTZegkEnbH1-U4PfcCWwUcHetbwfp2L9PL0OETFXKKpSM
Message-ID: <CAHC9VhR4d7WXOVR7Y9ee2+=-t2nThzOo-ySMB+5x_87LfBJbZw@mail.gmail.com>
Subject: Re: ipv4: cipso potential BUG()
To: Will Rosenberg <whrosenb@asu.edu>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:46=E2=80=AFPM Will Rosenberg <whrosenb@asu.edu> w=
rote:
>
> Previously, it was discussed that skb_cow() has a bug due to implicit
> integer casting that can lead to a BUG when headroom < -NET_SKB_PAD. We
> concluded that it was not worthwhile to fix the root cause and to
> instead fix the symptom found in calipso. The thread for this issue can
> be found here:
>
> https://lore.kernel.org/netdev/CAHC9VhQmR8A2vz0W-VrrhYNQ2wgCYxHbAmdgmM2yT=
L-uh4qiOg@mail.gmail.com/
>
> I recently reviewed the use cases of skb_cow() throughout the kernel and
> found that cipso_v4_skbuff_setattr() comes very close to triggering the
> same BUG. However, I concluded this was not triggerable. Even though
> len_delta can become negative, leading to a negative headroom passed to
> skb_cow(), we do not satisfy the condition headroom < -NET_SKB_PAD.
>
> Nonetheless, I believe cipso is using skb_cow() dangerously, but since
> the issue is not triggerable, would it still make sense to patch it?
> I figured I would throw out a quick email. Please let me know and I can
> make a similar patch for cipso if necessary.

Sometimes the easiest way to get an answer to questions like this is
to send a patch; since I would expect this particular patch to be of
limited scope and very small, I think this advice holds true here.

--=20
paul-moore.com

