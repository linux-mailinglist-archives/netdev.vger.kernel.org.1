Return-Path: <netdev+bounces-88382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019038A6F03
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333AC1C21517
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1691312EBE8;
	Tue, 16 Apr 2024 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0fQ/SJj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2C12DDAE
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279117; cv=none; b=Dujun4b5AAMsymcFSqkB8q+Myk/nEV35lFtdJeq+MrNUNoI0jjewxZ6J0e5taA0PLojgAifRWGFYyfo+jOeAKRKnuchxYAzE2KJk/wbkSyCKe0uhmjWm3S38ZPeGlUNP0sSnlbYyK1+xP2b/n1B+C02E2Lluy5gLljafG+cbQPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279117; c=relaxed/simple;
	bh=JnEvuPoHC2SSeqGxAR9sibfM/VnGoBgEaTlUV++DVUM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WCRB2bMpjtJzmmF6bmnvCGeKsfmCQLxkgg6ozNA7smD3KPb3mTW1tApWUl/elVoJ/0k6S9ZcsJ/AQolNghGmnEwJMqWKLlO0nG8qfdJFq6jK5clRx2GhQDGstYuTAgkMO1Hbq0bhjWeJ9rYm1xYNMrVsoQ5iSmPI1Gke9z7mR+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0fQ/SJj; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78d5e7998a0so340365285a.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713279114; x=1713883914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnEvuPoHC2SSeqGxAR9sibfM/VnGoBgEaTlUV++DVUM=;
        b=d0fQ/SJjl242JpN9sPoB6tj8SrjNqvT9fYNPbSJDVcHORRC6wgu1dFUWJ/tvgtGalE
         5XhsSNbJ89AJrTmIzxoLCn95tXzmMmOJqzR7fxWuD0UzAovvp7CXy57QlT5pt05UuPL2
         aWpPk2cDTrjsrx12RXyV42VqxMY9RbNw9DszqeUQVu4dyJLxUPzrqIrh2hzOxIHQMtfK
         IUeW662pLdnE9TureLT/Ny8hj7JLe9bxleMGeMsYaP1iDZ2UEFqGBbYYKc0J0zx+3WNL
         2hkzKFjENNzLjPiDxWB+nkqN3uBtJD8YwOtCl2SJtIt4dCYGfyCFX3Msoj6OKHjFmLc+
         0UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713279114; x=1713883914;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JnEvuPoHC2SSeqGxAR9sibfM/VnGoBgEaTlUV++DVUM=;
        b=h8mIfNef2zWPeV2LXnsTWgyj48ap46v2RZv9zVbBAM/qecFWx7Yl6lpbGVvXqGQd7n
         5D8OGbwm8FqKkNqTHjmqsl7ua9A3SaKEbreVWl4bZ3PcBUbFSj5ne8FtlygHCQdaEz6I
         pN39PP5Hav0iPn9Gs8gJdHPUajuBLk6yh6RPakF4FzOOrJ8N+BH3ec5SKHuekkEd84VC
         nRKXz26nnXEySxuGYdvat8JXCAVlmm9kAsWnLXY5tJs7mNF6T58pHFCslTYA7oyb3VVZ
         s/grcknlg896EoNsRH8w7JO7lsFTkEdT2IYy2R1yaoOHZ4PIuswsKTRzk0w+pVCmuUAq
         M3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsZccnXG3fyZV5vVXILjnRCO1yy8RO4Gb1zSE0ij4Avaw11Iz4ewhdvqO87542zXGAwqGHgCLqT+mlj5HNjsmC6FjCjJcr
X-Gm-Message-State: AOJu0YxMe/cF16gwfc1kZQvbHp4cd9zEQdifjWQwcoQKNTpqgxbem/+U
	N2PO8lbjI1cZ11he0RV8gOU7uSR3cEnmV7pCLjn7HgbGFiDEVrcr2tCV+Q==
X-Google-Smtp-Source: AGHT+IEQiLX5705CCkT5wwCTR8cBFBX7adE2oZJUvpcke+puKqEzaIDCZ1rKiCO1S4OTO5Ykky621g==
X-Received: by 2002:ae9:f017:0:b0:78e:f3d9:6c41 with SMTP id l23-20020ae9f017000000b0078ef3d96c41mr2324200qkg.22.1713279114564;
        Tue, 16 Apr 2024 07:51:54 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id vy23-20020a05620a491700b0078d66e2ac1bsm7592519qkn.61.2024.04.16.07.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:51:54 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:51:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yick Xie <yick.xie@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: willemb@google.com, 
 netdev@vger.kernel.org, 
 davem@davemloft.net
Message-ID: <661e9089df8f7_5279f2948e@willemb.c.googlers.com.notmuch>
In-Reply-To: <CADaRJKtvGf_+aCx00KpJqz3gerBCWKvg+=PxcsTPSbLEhAwg8Q@mail.gmail.com>
References: <20240414195213.106209-1-yick.xie@gmail.com>
 <661d3583a289e_c0c8294c1@willemb.c.googlers.com.notmuch>
 <CADaRJKtvGf_+aCx00KpJqz3gerBCWKvg+=PxcsTPSbLEhAwg8Q@mail.gmail.com>
Subject: Re: [PATCH net] udp: don't be set unconnected if only UDP cmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yick Xie wrote:
> On Mon, Apr 15, 2024 at 10:11=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Yick Xie wrote:
> > > If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
> > > "connected" should not be set to 0. Otherwise it stops
> > > the connected socket from using the cached route.
> > >
> > > Signed-off-by: Yick Xie <yick.xie@gmail.com>
> >
> > This either needs to target net-next, or have
> >
> > Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
> =

> I should have added that, sorry for the mess.

No worries.

> > I think it can be argued either way. This situation existed from the
> > start, and is true for other cmsg that don't affect routing as well.
> >
> > If the impact of the route lookup is significant, it couls be argued
> > to be a performance bug.
> =

> With sendmsg(), any smaller gso_size could be picked up dynamically.
> Then it depends, "ip_route_output_flow()" could be as expensive as
> "ip_make_skb()".
> =

> > I steer towards net-next. In which case it would be nice to also
> > move the ipc.opt branch and perhaps even exclude other common cmsgs,
> > such as SCM_TXTIME and SCM_TIMESTAMPING.
> =

> Both are fine. Though could it be better to take an easy backporting at=
 first?

Sounds good. Please just resend with the Fixes tag.

