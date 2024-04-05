Return-Path: <netdev+bounces-85315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038289A28B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 18:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4D2282803
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE03E572;
	Fri,  5 Apr 2024 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Cfaaa53"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A01757E
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334643; cv=none; b=pFOGIy1PyQC+tpa5ErpN8astXQc+ZZ6nfJ0YLBqKQ0soUXNRXzcrjA0noqMtUoU78rA7jOiUORk2g8ib+UmUEzIgymT2+iufrWHj6BrxgnGTMnIxReHJky5TrsI4zqOKAGy0ewsYciqUvkDVXxRK1zH/SblMcTFVZ0IrpBpuOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334643; c=relaxed/simple;
	bh=mZAO0eGvkxHG2mpyu+CTArarNbr1y0UO3cO2sRLcGX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxjLca9fBhtZ6GJgdDfG3fra9VEflFt9wsOdTMYjFpspoIrZJNKB1s2wyLSFhoVtpBQ4tNMS8nxccuOl41l6HzX7cIE9BTFDa82WyOSZXby6iyr9GhrLb50Q0arRKHUoVnBtlTX0Tm9pvp0Ew5IwLlrURu2jlOOt0ePQ10RHSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Cfaaa53; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso13841a12.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 09:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712334640; x=1712939440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZAO0eGvkxHG2mpyu+CTArarNbr1y0UO3cO2sRLcGX4=;
        b=0Cfaaa53DzmmjnfbvYyIM/VTyn2u1ZkXnBM0g/B1Rh/NmHcw8hiB8N3Co73zN6ttNo
         XX1QUzoX0vpMeOAyPdx6E4Twyc9MZAMffCxS4UTW9mpUFyMif+Fy5KPVosanUSm5LEaA
         XEcofDgRlsBQzAmhimWNxWCzeRhb6XhhPgT3gLTPagFxdKSJ9igQjPsUmrCQuoI15S7o
         2W3jsaF/29a3pgwJrQCKgN5MHubNYqB/pojcTjiJkcQEd60RuVC/n2g7ytl3w8i8OKkY
         Fg6tT205xQ5MI9C9vU6Gyqr5a8cmywld2pNWEgfMRLhRSGgEQ9ie+tJ1VoN8pHGwkxZX
         g2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712334640; x=1712939440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZAO0eGvkxHG2mpyu+CTArarNbr1y0UO3cO2sRLcGX4=;
        b=vfBNZfQWNMrad/YGCnwJnoq5QUcY43REscM60LfSOHbYRdgLDLNw4FNt07DU09DEPP
         TGzhRyoSPmlStXuXxmhok+M82MhtrG8xpm8yaB49WbRwPCWBKwUvd17dqDU2qhZ64XBl
         yBPHkwB+AWZWIZM63rplo1w+L3edKQ475XyFpo4ZNsbvgnDBajOuo2byxJvGtmjHIPt0
         vhzihDul/wLDxZk7hu59Mqsfy1Z+MDmGJDPIZNdgKP0e/T5NiFM992IIdxtOJgmtScZK
         CcA7G7H3kP1FLo9JE0fzn3Qj3oC9upuSy35735VhuMdGKickLQdR5mmsHINLdtEekwvp
         zTSA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Fxh828Obw4dryAz2X80zDLGrLE+Kgq9MHvBW7B0MkH2qwnjQIQ/GHMsew1mvOrTGwiwzStJPzTZzl4B6BSg+duyDv2Jh
X-Gm-Message-State: AOJu0YwcDVEyio5PlGS2oeM9j2wRU+pJSV2yrv4WBEkCxqtWAGO8Pcxo
	87Ld1+FiGC3g2HbCr5TXYc5ffMOoo1RXL+xvYErZyAhbJw4D/vFcllenqfUChLuaSHeYvRsXlsx
	622JF3uE9Jgnk6XQ0ZNQ0h66p55XdiMDKMclQ
X-Google-Smtp-Source: AGHT+IFIxTt/47oN4xzxy7w2j/J2GRzOa4Y/2PA00jhLgiVN1DOFojIjGH5/gYJ9pa8ukyqCNzixRZgQzN3Sa197xBE=
X-Received: by 2002:a05:6402:2035:b0:56e:2b67:a2f8 with SMTP id
 ay21-20020a056402203500b0056e2b67a2f8mr239524edb.7.1712334639671; Fri, 05 Apr
 2024 09:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404123602.2369488-1-edumazet@google.com> <CABBYNZJB+n7NN2QkBt5heDeWq0wbyE1Y4CUyK9Ne7vBRnmuWaw@mail.gmail.com>
 <CANn89iLweXJRLdn=v6WbqtvW6q0yLz_Dox87+GAnZUmx0WevKA@mail.gmail.com>
 <CABBYNZK08zDX07N9BTcFku=RSzc=W_74K2n2ky5f+qSexSLM+g@mail.gmail.com>
 <CANn89iLO9hO9QqQtNh=qEmLy+tE2Dr7fe9Nuj2dxYrG-z0Cy5g@mail.gmail.com> <CABBYNZ+F44x3aYK1kKUi8vLJT04QF48ONzrW06YJz=aq_oSHzA@mail.gmail.com>
In-Reply-To: <CABBYNZ+F44x3aYK1kKUi8vLJT04QF48ONzrW06YJz=aq_oSHzA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 18:30:26 +0200
Message-ID: <CANn89iJzJc+qNgwnEuzGReXqp6Gs7hWnex0_+f2CP9eTuohZyA@mail.gmail.com>
Subject: Re: [PATCH net] Bluetooth: validate setsockopt( BT_PKT_STATUS /
 BT_DEFER_SETUP) user input
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 6:24=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
ave used this so far (without risking a kernel bug)
>
> Fair enough, if we don't really have any risk of breaking the API
> (would result in using uninitialized memory) then I propose we do
> something like this:
>
> https://gist.github.com/Vudentz/c9092e8a3cb1e7e6a8fd384a51300eee
>
> That said perhaps copy_from_sockptr shall really take into account
> both source and destination lengths so it could incorporate the check
> e.g. if (dst_size > src_size) but that might result in changing every
> user of copy_from_sockptr thus I left it to be specific to bluetooth.

Make sure to return -EINVAL if the user provided length is too small,
not -EFAULT.

