Return-Path: <netdev+bounces-141403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D909BAC6B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 07:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EB1B2097C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 06:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D5C174EFA;
	Mon,  4 Nov 2024 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRlGmAvx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F758E552;
	Mon,  4 Nov 2024 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701015; cv=none; b=vGQVEqPhofcMA8CBtNoNTWIYZznRDmdStqnMGvcSzayaYvsakXw4ouAG8YCMe83yJZvFwgWNZaCB7ZewKIbFxzJQao7S/mhPqvSICTNTeUr1+eAjyU9QWrs0KtJJ1iTGjRXKIwG1QNtC/1VD2L8hE9/7MHeRfFfbXnrJiqQTDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701015; c=relaxed/simple;
	bh=Kiw8a+xA3aXfOth7seODVyspc+w1aMxA9R4BE8XJd/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4wm47LlEBGiUDCwaHZeGKCDMwnokHqhHtoC1ClZBSfqUniBtqG8j1VV+a1UCTH6b9/oW6dwOKaKpe01wUP2C0mmPbT49G39JU9qUhYppSAvaabOX0gaZCSvt+2vjpeMf2ftOUopaC/loBT8a6jixCtxbTVsHI8k+RK0xSL+pmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRlGmAvx; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6ea339a41f1so32217937b3.2;
        Sun, 03 Nov 2024 22:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730701013; x=1731305813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kiw8a+xA3aXfOth7seODVyspc+w1aMxA9R4BE8XJd/M=;
        b=YRlGmAvxd9XyQ50C3LsyYNHHRv9BNmaAtvhuvuEnIHPPhZ2tmyfO/pfY/zfmG53bRv
         Nh4Ouca4YPvNFur/53FNctWfe0br8tE2DTDF0/ZB7/R3q+6UYZ5KcKnaINNt1fySYru1
         Soj/+Krj2+0SquXj9bYInUAAMl3gISTOWPzcmGpe5K3GY6/PvcS+b9cdesVMxctB3k1I
         uxAR71CzraIaCSw5JLtdeeJ/ki7Uj/M84X4Z6D7+7sEn48C+bLNGOZTJ1YVesljWr2Ye
         g3pmufA2ITtWk2zUqWal56w7EiC8xh7O4e8Bt4n0IiEDPbJLpEm9UQLoA6r7C8IvWQvx
         A4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730701013; x=1731305813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kiw8a+xA3aXfOth7seODVyspc+w1aMxA9R4BE8XJd/M=;
        b=k92a4f4PXisEteNTtzwPPlOQgeWP1VKK8Xce+Qf7A5SD1gtc/GuCNTOW3Kw3RER2PS
         o26pmEap1tSNCD6REjln/Vm4vTRnrLMPHr5PUvJmydnFL5N6G5axoAb7nuxMZqfHNh2z
         S5ab4MuidlxB3tHggL7r/k+2itCw7hv6cKf6i7Fqb5ga+xFum/hwfQ9ef/S+CDZXasGt
         honymDzeNcwwEyuHhMCxpxHItoMqeYnKzk7kWrQ9H/U69lESvJ4uFZhs7G8zjZYM84K+
         ZJtHka4C00WcS+EohUgchsb8fatB6wAU/NLDRxrHWSAqWd13kCxztL2nLOmSXt5r8D+V
         JTPw==
X-Forwarded-Encrypted: i=1; AJvYcCUAHoHSER03b6wjq//PQfCHpn8BvNeEcLIvI1AQX/HqO8Yj18s6IxHvHNyDi9pfQGctrMjyRAowJ47f45s=@vger.kernel.org, AJvYcCXAJ77zj0Mrq8kRlf/Zpb64o/FDO+6Hd/VACrE+GNiTZhfLfXPPDTOg7h6rGvCAL84fy55VKZck@vger.kernel.org
X-Gm-Message-State: AOJu0YwaweGR0eOgO9mf8VJ1526QgRwrZA+w+nLcwpH2yZm+4aLghU5F
	tJORrw/vr3mw2YHYZMgjzHgh2SO6jV3kD+YbdvxSHNHpbM5aDpE6cfU1ptjN6YObclYd7kkCvZt
	WZt2nZ/mBMpCj56S14nQ39nfqwDk=
X-Google-Smtp-Source: AGHT+IGJB4eiqFsQlBpPDbvU+9TL2+/+gaI/Zv3VT7t7LsbHIO6fEc83s+vpuAuSa2pFhS7jDrTbuwDE+xp0UbbZ9U4=
X-Received: by 2002:a05:690c:6410:b0:6e5:af24:92fa with SMTP id
 00721157ae682-6ea523cc89fmr144655627b3.21.1730701013395; Sun, 03 Nov 2024
 22:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030113108.2277758-1-dongml2@chinatelecom.cn> <20241103152715.498aae63@kernel.org>
In-Reply-To: <20241103152715.498aae63@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 4 Nov 2024 14:17:59 +0800
Message-ID: <CADxym3YLqzU8wKSzrz=LCHz5EKEtKaAhHbzWZ1iVhQiHTg+cmg@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next] net: tcp: replace the document for
 "lsndtime" in tcp_sock
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, lixiaoyan@google.com, dsahern@kernel.org, 
	weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 7:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 30 Oct 2024 19:31:08 +0800 Menglong Dong wrote:
> > Fixes: d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
>
> Fixes is for bug fixes. Please drop the fixes tag and add a normal text
> reference like:

Yeah, I see now. The fix here is just like a typos fix, and no
Fixes tag is needed.

>
> Commit d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
> moved the fields around and misplaced the documentation for "lsndtime".

I'll send a V2 with such a comment.

Thanks!
Menglong Dong

> --
> pw-bot: cr

