Return-Path: <netdev+bounces-135462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1713099E04B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C915B2460F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239731BDABD;
	Tue, 15 Oct 2024 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhVzr2A9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99E1714C4
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979524; cv=none; b=f2BuYqfUbCakDJL77tAR/4/TRvhO9BILIs8J1e+mYLwmRBKeR4zggJ+b/6ercpNFvh2lfeajgEMz80OMrdOTi+pG1VzJC3hwPSx/2TxSKkNkXQdqshJtqjsNIYVq4WtfslMfw2I4tZr0+60yE4vxAcEm8xyHF0DgnrxLijv/wUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979524; c=relaxed/simple;
	bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkzCBfUh3tuV/koyJKo5VlHqwhiNeWYaCLvjV03e13sEOwrxOMsXaoMqLKMjGiVreDFunVDd0ba12hWWz3wZqh4C7wiOL5tTs9v+ocQXirfi+uQ+2WZ/Q76Wy7tx71hIS5Yfx34wRa4K18IAce/JMUzSK/LnZcGykPJlxNLeugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhVzr2A9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so2720886a12.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979520; x=1729584320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
        b=LhVzr2A9It71YnFnO/lZTidFk5WmLGfHKa4KH/Ckgl3F++ctFCTb04TTOyBQooxVsL
         yEwCPtDz0BtWiOfKPce9a7rP38owkGvBKdmgu5uQ+/qDMGHHA9PIB1K1/X2a57xdv55B
         F3RiCmCfh6Sw79XVNWcr7hm1WE7KouHTQFEG3hWHBldemauacOtwefwkOc/lvK5C5JRz
         F/jmHWBVifdgVP1gqVSUBGDV55c6WkdvuMP6exX5fVNtUyjjL/pRz5xLpRKsQ5HO7BnI
         wvwy0CzhApmAGpc9Y4YRo/r+CvWp1FcdT2fMV2yFu04QyoD9tcfzK7FBB1WRZ3S7+6Zi
         DjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979520; x=1729584320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
        b=i+GHB7RsMNJEiwiSnhrmEi/70y42TokrqVeCx9PG1RyKXaFEU9orANyVLFMVCrwUaQ
         JZr4bH/FGg7HpA/GpZ3kw1zaZ23oOdH4yc1aba+QjSJbi2E75+2PEQfs7mJJxnYgBmmp
         8wsNgSNUylKE128inoWjL1kAeCv53wvdCEKwEhJ493YJeROnkOkMQ09knj9XMCm7odYZ
         S0S+rvk6WKqUuN6gZVCIjUMtPnXk5kz4dbPXZim19Sm6sABsaPwcyVcBFQUKf+62lZgd
         xd/FMR5N00WJvXr0dJfKNTWyHPyX6HIpZz6zU59QL2Q+KHtfp8x52aZpJrEiBDaLjBZe
         Y8nA==
X-Forwarded-Encrypted: i=1; AJvYcCUE28iGXw5zgYkWqRJurOECQ6caHp60gs7BeFaK8dvKJlWMNPcb1JGxRnj/+N2vx726dmrdlDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7a+NBAJpYWSvDAhC2hjZMDPsZPi9qCTNnZZo6+/HsNT+0xNbl
	YrsLTnRxZSupG3UKAnb/KjHbw4DGCyhiigGoEliXGZQjOxXcvJPdHYgD+IajFNm5wxwtO2NSu/r
	7YSrDBLTkDKEq0vXcTjkrORqv9LXain03GlsJ
X-Google-Smtp-Source: AGHT+IGhXaZt34jHqjOXUdH0Zm4cm5o6e/qM4AoXLZ89WM8Mb4hUFPFZtihXBdV2SHb1Q6OTW0ryALy+WWGkbtzvcNY=
X-Received: by 2002:a05:6402:1e93:b0:5c9:845f:25fd with SMTP id
 4fb4d7f45d1cf-5c9845f2752mr3195903a12.23.1728979520189; Tue, 15 Oct 2024
 01:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-6-ignat@cloudflare.com> <20241014213503.99078-1-kuniyu@amazon.com>
In-Reply-To: <20241014213503.99078-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:05:09 +0200
Message-ID: <CANn89iJ49HQGuZikfz_56jUpdUDHfO_1QPGSrnN_OA6PxZdK4g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/9] net: ieee802154: do not leave a dangling
 sk pointer in ieee802154_create()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ignat@cloudflare.com, alex.aring@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dsahern@kernel.org, johan.hedberg@gmail.com, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	miquel.raynal@bootlin.com, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, stefan@datenfreihafen.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:35=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:04 +0100
> > sock_init_data() attaches the allocated sk object to the provided sock
> > object. If ieee802154_create() fails later, the allocated sk object is
> > freed, but the dangling pointer remains in the provided sock object, wh=
ich
> > may allow use-after-free.
> >
> > Clear the sk pointer in the sock object on error.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

