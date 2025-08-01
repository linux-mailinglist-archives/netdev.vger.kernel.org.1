Return-Path: <netdev+bounces-211298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8344BB17ADC
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 03:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BAF01C24432
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 01:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9E2E630;
	Fri,  1 Aug 2025 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGVFD/HI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6985723AD;
	Fri,  1 Aug 2025 01:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754012099; cv=none; b=Kgl1yJdr7Jc/MytKB7rzgZhME2S8+/Y6Ak144KauVkzQz9xH5HnPkCHgSoykayerlGbHIAPK5kt6XPPK9bF8qj8ajvzV5DtNbDTCF8fJ1ZetLJejrPman3vRYOx5hw7GcuN2egczh8/4iWGHl8qH19OixRcfKq8hfd0pwihRxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754012099; c=relaxed/simple;
	bh=XjH2O1E86RQUEarkxqbY+gvMmkq/EoShxACAjX4zAFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unbq1aDpKMwKL90RsRmXrH+gMwI62aLILyOfRZgV+dAnW3Bf9mnUk0u8H7+nSKc/9Z96UGuzbgfUYFRaP0zmGtGfq5+31U2uMX9WPTMqEpelc491t5NV1f/mN2auHrSX/d6EUjwUtvRS8BOki7WjlerSH1qQ101NmeHj7Rn6xlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGVFD/HI; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-71b71a8d5f0so227067b3.3;
        Thu, 31 Jul 2025 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754012097; x=1754616897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08ID5kY3ckc7uruII/wDxPJvnRvUsM8vOn10ourRG5g=;
        b=MGVFD/HI1CgGooOmYBjJxCg10ZRBb++l2cSjVmN71uyG02k0/CDyM/XkyUc0AnzGiE
         eOSNV5/0Xq3tMB/l+RSvoqGN2+rQxPjaH69+zbHiXZZHYS45g7efSFtuE0nxXrSkEX90
         j6oO5OjYVsetSwpFVdxyD1O9H41deqTpeiLQiWULIMjXMug9WUaqp7Gq9DoDHog0v0N9
         QXlDONcxZyO8TBdzCnaBmszOGwIeOfMpqIVlwvdO6QI2RQ4FKTODj3Lft6tfwu/2mTT9
         V3ki7Z/Zx0IT5dn2xiyXr33P87KZpO6nKZtBVGzLEeJJjvc/sxmSGMCAoogdYKqrrviz
         dLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754012097; x=1754616897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08ID5kY3ckc7uruII/wDxPJvnRvUsM8vOn10ourRG5g=;
        b=iurQqfaMUM2ZMdmcKvawoa7PtkQhCGh7F/FeOAkRNgDtSZXXsr8VjYOkfsAUobgeji
         10ysH6ip/4dJJ/dLrYWh/wHlrAcT/4rv95xSzrYfKow+gEGFRwSBL1OzNdLq4821/FAG
         zg9FgHvH+dbPuD6u1KSlIYxfw7Oi8ecCeiung0MsN3xefNxVuMQezod5f0eDUTFRr3EK
         eS7hAiSJBVz1DvskWNHcpsrs4KeMnCy8VyOolUqHn07OnpIJUvbpNtNR8+AwVdDIGs3n
         K9KKRIAWyUB2aW3Nh8R5J5MfolerRiUH1WgJ9eY2zUAgwIOhg+Em9pBiX7nJNMlHPicN
         Xq1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvguO02tYChY1Vu2tPybhPYZ/mJixFtQh2ObQPEgaRpUlHtENL4bb6f1ysXmUg6GqjfC2XXjc37iy6mRQ=@vger.kernel.org, AJvYcCUy2298lKl7O2LTlp24DBMhPxPY7Uzk7RbJWUjZPkpHNYlomjHZClZsPO0umqYi1jH0K+8sbBfP@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5bt+Ekauld9UMGA0yjVsZctfcTT+NhfnkliMuOhjO/UyCj5I
	e1lNPeMvZWd0+zdsB3R5EGI6u5Nw8IJrM5JW06oJdEtt57v++Mga61JjINpAAVo/66LMBgqHdEu
	X55X7Hu8xuPQInKG/xtH/03+uas4NOwg=
X-Gm-Gg: ASbGnctlHqNPnByMBknXWPIgQMDm6lgqNlZP602FjWAlqQYUuJ+vz6JliMlVwjvHoHM
	NjvxNQ1DKnFfssLjyOt/fksoejpslIoNYVE6U7Z+bxatJvvJ5Bs+ribL21k85YXzmAJy9s/O04I
	ZdgC011S5nYhp/DjfStrz7HtJ/gXSAQNuGL2/r83/ASpXuawyrCrsT7dEh2dSU1elth/ZjZZnZR
	lbMzkCwN0A7nx/q1Q==
X-Google-Smtp-Source: AGHT+IGstYxmewNf8YiqioIjdzJ2WWwwXJyFgGUwXuc1csHH/OMG7yh4yzpqPLjwKOKrL0GzfhUiTnKyLREnOArAhfo=
X-Received: by 2002:a05:690c:6909:b0:719:f77b:9395 with SMTP id
 00721157ae682-71a465edc2emr123888347b3.1.1754012097353; Thu, 31 Jul 2025
 18:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731123309.184496-1-dongml2@chinatelecom.cn> <CANn89iKRkHyg4nZFwiSWPXsVEyVTSouDcfvULbge4BvOGPEPog@mail.gmail.com>
In-Reply-To: <CANn89iKRkHyg4nZFwiSWPXsVEyVTSouDcfvULbge4BvOGPEPog@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 1 Aug 2025 09:34:46 +0800
X-Gm-Features: Ac12FXwHbdc6SK1C7VCQLRmBkgpDvjiFRQeRV6YmSk9AqntKmjvrLRL__Iw3BxE
Message-ID: <CADxym3ZY7Lm9mgv83e2db7o3ZZMcLDa=vDf6nJSs1m0_tUk5Bg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ip: lookup the best matched listen socket
To: Eric Dumazet <edumazet@google.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 9:01=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 31, 2025 at 5:33=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > For now, the socket lookup will terminate if the socket is reuse port i=
n
> > inet_lhash2_lookup(), which makes the socket is not the best match.
> >
> > For example, we have socket1 and socket2 both listen on "0.0.0.0:1234",
> > but socket1 bind on "eth0". We create socket1 first, and then socket2.
> > Then, all connections will goto socket2, which is not expected, as sock=
et1
> > has higher priority.
> >
> > This can cause unexpected behavior if TCP MD5 keys is used, as describe=
d
> > in Documentation/networking/vrf.rst -> Applications.
> >
> > Therefor, we lookup the best matched socket first, and then do the reus=
e
> > port logic. This can increase some overhead if there are many reuse por=
t
> > socket :/
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> I do not think net-next is open yet ?

Yeah, net-next is closed, which I just realized :/

>
> It seems this would be net material.

Ok, I'll send the V2 to the net.

Thanks!
Menglong Dong

>
> Any way you could provide a test ?
>
> Please CC Martin KaFai Lau <kafai@fb.com>, as this was added in :
>
> commit 61b7c691c7317529375f90f0a81a331990b1ec1b
> Author: Martin KaFai Lau <kafai@fb.com>
> Date:   Fri Dec 1 12:52:31 2017 -0800
>
>     inet: Add a 2nd listener hashtable (port+addr)

