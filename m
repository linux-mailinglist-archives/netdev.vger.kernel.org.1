Return-Path: <netdev+bounces-88003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCDF8A52DD
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA290B20F62
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC898745ED;
	Mon, 15 Apr 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="yvMcSKo3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1563D0D9
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190636; cv=none; b=Lxk+8xeD7xBuDTsOXFUN/0FYzeTIeBhIo90BD+a8RWcmfnc/0edwbiQX8Wjxdd8ANtip9JCH9QDEU/Aq9LCIFJaSElCUmtpFT+fXVj/RcEKvjqtA55UsOO+V6wM+uBJkZUBFI7xk8eGL+Cq7FqxYdASMN2cBfuTVBj3fkf5bba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190636; c=relaxed/simple;
	bh=/GzR4exSwJRZiPyKuCPjsTiU2SNACOfW6mSk9wj7agI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebidw96V7KmpTsdStXkNO4Fh3umfFiWTFXlzxT0i9+3zgclPk+eX96ix6brS6I5jeaPGDbKFs/NqUC+wcIBRvbE0nzh//+1vDh2lqzr0J+cd1qaDjbOKlddIuAtOn7HtoqfGM/i88mtCE0vMuzRGg6EPHQpIZGmlTRprRCNZqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=yvMcSKo3; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-617e6c873f3so35042597b3.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713190633; x=1713795433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GzR4exSwJRZiPyKuCPjsTiU2SNACOfW6mSk9wj7agI=;
        b=yvMcSKo3llvYhijvifkwilZlngzTOyX2nT+uekjcMlZmfSz9kQDFMiCO2x1gXpINjC
         VinqNn0OIP8mDxam3KgGn7EDnt0s245PMg1Ro64Rntkyf/Jg1YpIMCIt6fvpqrufZ/ta
         P9VUNDBb84cljmjBYdMbBldxqPQITHE1P9zGnspnYw5Kfdv5G+g6raL32TNMzzX2DrgZ
         jXlNDkZLjcvte7edJ+TqPYhh1JyVa8nR+0eUY5csnZ1/IybmxLO6XKqYCJKQxQTen4k0
         WdpxoYVbe4dqrhaVbE+6lOCUXk2evRbaIkDSMMWJVTtKqMH1qIX3a+om/agGVwxfnlqw
         qeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713190633; x=1713795433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GzR4exSwJRZiPyKuCPjsTiU2SNACOfW6mSk9wj7agI=;
        b=MXET681Tb3Jd4C/qYjEpSjfowDMTQzcZ96MMNTBqxDdGzMv4GRK+U08zhzdtzLC5Q3
         80QQYbOvRFoMANbTqgsZB00lsN0WmG/PSYeG21xBM0Ztxe/SRqx60SxNqXptyqeyV4iN
         HDtdSgm6QiXiADdGFdcNbRkRx6nmiYqlD/Vdu4xodIDBd7MCkXfbbvZAyPDIjfWff10P
         cogZ59w4K/fR8ois33jFBM8pBKW0CaDtKksA/o2h2DGaB76l/TV4Dekuiw7sRo2BW6pY
         UrSGCoK3GSttdyNibv1KlwFj9Vl0exZBAJ9lAK/hAZ4Qxijd2eiKvUYt5XtUEy2eoN5H
         jTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCn/jOpm0/sFkkfMylD8HSxHzDxS3B4foF4M2/Lv30vOzulhlIno/SHi0+HcYynTi9BzlnnHZq2DCECYbsEW6yClXFTLp0
X-Gm-Message-State: AOJu0Yw8IyDeiXfaW1w0xwpwTn0PuW+kkIYfabN26ASGIzUfuHJLaqMb
	8N62xDLb4DjSxYPWrXm/sb0gaSnRraLXt3zIvEVnmL5CUIL1xEJhd2bHV1R2GPh67NaYcbDWZAr
	pf4/QQONu8eL1wCTE+LlLCwiGIJIKMWrKYBv5
X-Google-Smtp-Source: AGHT+IEzldycUoqUEuca8N0Wkzt/i3EjHxY5F3p9RestGMrOjvh2qVGmhs6xWe3CFkscSq/1KPnrcvh3oUTPRhz8Y40=
X-Received: by 2002:a81:bc53:0:b0:61a:cd65:3010 with SMTP id
 b19-20020a81bc53000000b0061acd653010mr2939138ywl.30.1713190632770; Mon, 15
 Apr 2024 07:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326230319.190117-1-jhs@mojatatu.com> <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
 <CAM0EoMmQHsucU6n1O3XEd50zUB4TENkEH0+J-cZ=5Bbv9298mA@mail.gmail.com>
 <CANn89iKaMKeY7pR7=RH1NMBpYiYFmBRfAWmbZ61PdJ2VYoUJ9g@mail.gmail.com>
 <CAM0EoM=s_MvUa32kUyt=VfeiAwxOm2OUJ3H=i0ARO1xupM2_Xg@mail.gmail.com>
 <CAM0EoMk33ga5dh12ViZz8QeFwjwNQBvykM53VQo1B3BdfAZtaQ@mail.gmail.com>
 <CANn89iLmhaC8fuu4UpPdELOAapBzLv0+S50gr0Rs+J+=4+9j=g@mail.gmail.com>
 <CAM0EoMm+cqkY9tQC6+jpvLJrRxw43Gzffgw85Q3Fe2tBgA7k2Q@mail.gmail.com>
 <CAM0EoMmdp_ik6EA2q8vhr+gGh=OcxUkvBOsxPHFWjn1eDX_33Q@mail.gmail.com> <CANn89iLsV8sj1cJJ8VJmBwZvsD5PoV_NXfXYSCXTjaYCRm6gmA@mail.gmail.com>
In-Reply-To: <CANn89iLsV8sj1cJJ8VJmBwZvsD5PoV_NXfXYSCXTjaYCRm6gmA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 15 Apr 2024 10:17:01 -0400
Message-ID: <CAM0EoMmcTgdWQ0z0b9Ne1JHyTUq-R3-za3vMH1PfNVVoYwmcUA@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:11=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Apr 15, 2024 at 4:01=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
>
> > Sorry - shows Victor's name but this is your patch, so feel free if
> > you send to add your name as author.
>
> Sure go ahead, but I would rather put the sch->owner init in
> qdisc_alloc() so that qdisc_create_dflt() is covered.

ok, will do.

cheers,
jamal

