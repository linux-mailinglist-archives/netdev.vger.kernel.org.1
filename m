Return-Path: <netdev+bounces-107808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898B691C6A6
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48B71C23C82
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0CE74077;
	Fri, 28 Jun 2024 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRYoICpc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46056F2E9
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603222; cv=none; b=PazH+FTWPN7wfiBsoaDOj1yQ/AYLuv+xhhguY7PcT0m5lp/bKcVsIKcDN52L4KMWGYX21j9Lw9JIXsCl7Tf3G8AnuYHDxb7tpz/G6FKv2Ci1E2A0INH8QdxO1N3KfU30la7WMonB+80D25MBHmVhFfVYR3tjiUfaPK/BKWm5YFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603222; c=relaxed/simple;
	bh=6QXwTTqU9dCigAS3UhUE53cMazcnkF4Z48U8udsxmqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEZPUrBcP4z/TAdA2eGLJHxPLiQe0k5+03rsvoeCqhat1gOHtidrMEouZlmnx+0w87TsS4/YKP6A1d99GgLVt8FQewV4Vnn3jSR9kzLULDPsmfTpVDkKfToUfCbLXzG7iwLTJG1UrplkL1oC5iKHUlKz0M0uDEDsATZj2r3/hSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRYoICpc; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-444fdaed647so301cf.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719603219; x=1720208019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QXwTTqU9dCigAS3UhUE53cMazcnkF4Z48U8udsxmqI=;
        b=kRYoICpc6e4Dle7k2f7dIa93gSeOu2/bO65/hb75lnG1JfosHpPmKVp1aqunZJaLBk
         mkdNQqJ5nBg7Gn0uAzkmSXSqozrWP5WUpdLjBovjmps1hOAarMrC+NvRr06rMj40zyJF
         uMmkx0Z4Dl39yE+5RFcRjydn834E616DY5IKhPBkcmCbzedd5I7a3sfLLFx3t5MoAIq1
         cTNyUFdXCnwixOeogABRUEBUK9wUuY77nf4m+LjvvEFZVBQCjrP3PuBjXAtDagAvoRn9
         U7oOse9ytnmJlpY7kHf5LI1mryiLAj9zJrnpS/HuMnL5DAzigRavsq4G2vlsODqxiI43
         oPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603219; x=1720208019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QXwTTqU9dCigAS3UhUE53cMazcnkF4Z48U8udsxmqI=;
        b=p3kMCTmhXVvlvAvfXQ7yTP+DTo8mkwBgi3IujmNTGvI7Nk2EQ9KXMQEnhyOWXYqt8y
         aZ6TF8NM+4rFkkPgPe4CfW6A5ivg+6b/zw8i2oQKc/95lNcrBukYT2D5QqvRIV461VnM
         eyEKpy/IRwYVZpIdJDsqdyIpIq4tyzQUg9M+oHNpwXJ0o2JVp1sw/LdmeXZWhquaIVVY
         HzzhRZqs643g2jMpY+TrerFUy0WabcGp1yV67BvWbK2+VUfarvlLFdiCi3Qalk0wdVC+
         oY19Ys0wXuzQreU92N1t4RGNVaDgVTOb5F/gqApkyl7RROYuFXZ5GyP0Mi/AZtdmEj6l
         1s8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqKq0gbe4AH77FU6/F7DCEUdr61z3DfVXars3wtKcIOCjy1ttV5gUfXcr9xUNXwLlPEt8O6WpN7dAFIEnnMGXBRtbg9DWi
X-Gm-Message-State: AOJu0Yxdu6ZGTnaMbnzxkQlC1PDzDL7vLTuRE8rLKKjkl6zFpl3Y3kWb
	ZibDWvVZwFXu5OHlQn6JlKeM7M+UqPFgjRo3nnktvo+A/4qhTi7XEFl2s8QqN7yndPQdhJOqVKo
	oRVzAcSHhi8qOliaaiXGkTxpHpXCO3rNVA6M=
X-Google-Smtp-Source: AGHT+IEwCGvLi2iA/LfG/mLbUbs6odMsIOIzNDbTRuV8XKAMItqQiOAtfAlviAM271ajfzpFfco6xr6iP6STdiXUi7U=
X-Received: by 2002:ac8:515a:0:b0:444:cdc4:fef5 with SMTP id
 d75a77b69052e-4465d3e4135mr314891cf.27.1719603219427; Fri, 28 Jun 2024
 12:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510030435.120935-1-kuba@kernel.org> <20240510030435.120935-2-kuba@kernel.org>
 <66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
 <20240529103505.601872ea@kernel.org> <CAHWOjVJ2pMWdQSRK_DJkx7Q9zAzLx6mjE-Xr3ZqGzZFUi5PrMw@mail.gmail.com>
 <20240627153347.75e544ac@kernel.org>
In-Reply-To: <20240627153347.75e544ac@kernel.org>
From: Lance Richardson <rlance@google.com>
Date: Fri, 28 Jun 2024 15:33:28 -0400
Message-ID: <CAHWOjVL2hM4Lv=jNAv9CmLHYJL5ZBHmDH=ySQr7fr1Z6kgAvjg@mail.gmail.com>
Subject: Re: [RFC net-next 01/15] psp: add documentation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	pabeni@redhat.com, borisp@nvidia.com, gal@nvidia.com, cratiu@nvidia.com, 
	rrameshbabu@nvidia.com, steffen.klassert@secunet.com, tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 6:33=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> I was under the possibly mistaken impression that Google have used PSP
> for years without rekeying... Did I misunderstand?
>
Actually Google does implement connection rekeying when master key
rotation occurs. I believe this was the case even in the first production
deployment (Willem would know the history better).

> > A tiny bit logic would also be needed on the Rx
> > side to track the current and previous SPI, if the hardware supports
> > keys indescriptors then nothing more should be needed on the Tx side.
> > If the NIC maintains an SA database and doesn't allow existing
> > entries to be updated, a small amount of additional logic would be
> > needed, but perhaps that could be (waving hands a bit) the
> > responsibility of the driver.
>
> Interesting. Hm. But SADB drivers would then have to implement some
> complex logic to make sure all rings have cycled, or take references.
> I'd rather have an opt-in for core to delay reaping old keys until
> all sockets which used them went empty at least once (in wmem sense).

Right, ensuring that the old entry is no longer referenced by packets in th=
e
transmit pipeline before removing is definitely a concern. One simple
approach is to simply keep the old entry around for long enough (e.g. a
minute or two) to ensure that any packets referencing it have been transmit=
ted.

