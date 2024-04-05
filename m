Return-Path: <netdev+bounces-85323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1E89A3AE
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 19:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96311C2162B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 17:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CEA171E53;
	Fri,  5 Apr 2024 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZppgxgv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14216C858
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339151; cv=none; b=hbgFHE0EahP1dPRWEVXVZbdlw6tgzhTSKZQSYvBbUgo/GTi6UpVLtJYib2TPJ3zCoNf7wkTtoM9NLUF1A32ZLW9O9ElWQAXKOzyHfKs41IcHDBis2Z2kZzQURYxASFeUu65uV8KsfB4M1u6YFo8fTwnv0eHgv3wtPo//T3KKLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339151; c=relaxed/simple;
	bh=wTKr7S2CnGDPCH8KeSUhRKLbKn96nzFzodF76YgrJho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSymoc3IJx/e6QtH9ehajjoWvSR/+mzWIc1ODL6oaX/ODkBOok4RoPLecEzMxViu3mKuTMBGZ7GrtO9auf64tHMS307Ho0yUMVMEm62+wrYZWVItu4TfvGlGfATJSKiMFvxga801opkDeXRaRIAPWmm2O4y0zQt6WtAdWqEgRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZppgxgv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so1380a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712339148; x=1712943948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTKr7S2CnGDPCH8KeSUhRKLbKn96nzFzodF76YgrJho=;
        b=PZppgxgv3sXQ5rxBacQdn/ZCVjKHGo/bOeV+IPdhHr1lRFql2XWpnBDmpThAhNZLMJ
         8LEt9Ja2ub9Trpfrypt/+CVvFnaLaFoigDmmZEZ6Wz2D1AEaP5WsJkRJ1ZuH7/p6vFwJ
         VYUlnUNdNfPqEKKw6PavVhDV3bCLzQ8/fu90lt95UmV+QvtJbRRudaoPsT8yiyho9oKP
         vRkv3ZBpG2/rBcbbIz3/CHZ2Im7QKAf4f1UpzV+vsZWtilfIYssYhBmQ2vCdM+cnC3vG
         +uGrTioOEk4cOepPAcjvwO+gmk55vIZJylySm6fhjX2auqd3y2EfXgA5jKgYgeXK9Cz3
         u87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712339148; x=1712943948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTKr7S2CnGDPCH8KeSUhRKLbKn96nzFzodF76YgrJho=;
        b=AS06QRJ+gfEjF45a99dASAV+mA2DlGOmP6GiEcJjPRPVuMlunGX+DszxtyKweaI3DL
         VheyyHAxENQDzfe2q2NONIJJJ2RlxCIlbh0V+kz/+kAP4LoIHXJdMIzBV6lOCgy//wNZ
         P8unPRTvDg1WkGdmqIEvj55dD1pJhqDY9VseIzOSoZdjLWygm75OsikGMnP6EbbMSK/f
         SRALP8DVFHAhNVXh2VFUzbLFzBCugAWV2X0JheHgkqCtsPT2zTBdoV+FTeL+q/3Rdpxy
         v//KyHmsmxIJ3iO0VFElL9oNVqjiZqPo+WUXHuJct0has/LT/fxB7lwa3zGSxTLktkmS
         Z0GA==
X-Forwarded-Encrypted: i=1; AJvYcCW25PmVBgK8iZPl+kXEeoaUux/4FdoBfrYcwus2vLI+GT+vQO/VxS//NagJ/fPkq1SzzDLT7BOL/R2yM2kgoVbWmUcGc5f3
X-Gm-Message-State: AOJu0YxSKYZI3rc1qj6CtVlhU7xiMkqaNB799KAbeu6/rERtle3FOJrY
	JWIKFPVhI9sgbepweuvJUJPN6893S1XABp/3EIPertVFvdcfeHcJg26itn2w7SBM0d17mwgZ/+a
	LfggAngtCYs+2o8aBtLXuiHYWmsBgRFDTKUOw
X-Google-Smtp-Source: AGHT+IFke6+lQWu9zNJbcE0cSexFTPrPSGmDeOHgeNv57K2lPwQ0sztrffp2byynXgEUGPFmDFwUOZ2UrYxWydLMWbQ=
X-Received: by 2002:aa7:d94f:0:b0:56e:2239:bcbe with SMTP id
 l15-20020aa7d94f000000b0056e2239bcbemr5277eds.2.1712339148083; Fri, 05 Apr
 2024 10:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404123602.2369488-1-edumazet@google.com> <CABBYNZJB+n7NN2QkBt5heDeWq0wbyE1Y4CUyK9Ne7vBRnmuWaw@mail.gmail.com>
 <CANn89iLweXJRLdn=v6WbqtvW6q0yLz_Dox87+GAnZUmx0WevKA@mail.gmail.com>
 <CABBYNZK08zDX07N9BTcFku=RSzc=W_74K2n2ky5f+qSexSLM+g@mail.gmail.com>
 <CANn89iLO9hO9QqQtNh=qEmLy+tE2Dr7fe9Nuj2dxYrG-z0Cy5g@mail.gmail.com>
 <CABBYNZ+F44x3aYK1kKUi8vLJT04QF48ONzrW06YJz=aq_oSHzA@mail.gmail.com>
 <CANn89iJzJc+qNgwnEuzGReXqp6Gs7hWnex0_+f2CP9eTuohZyA@mail.gmail.com> <CABBYNZK=oKCcMv8GEx__XiR+tSUwoTnwRkh2-6tJw1He9oGr6w@mail.gmail.com>
In-Reply-To: <CABBYNZK=oKCcMv8GEx__XiR+tSUwoTnwRkh2-6tJw1He9oGr6w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 19:45:37 +0200
Message-ID: <CANn89i+TB_cb9tSHW+8dAiqWXpAmtw=ktVG3WujiJfL2WcASiA@mail.gmail.com>
Subject: Re: [PATCH net] Bluetooth: validate setsockopt( BT_PKT_STATUS /
 BT_DEFER_SETUP) user input
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 7:38=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Eric,
>
> On Fri, Apr 5, 2024 at 12:30=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Apr 5, 2024 at 6:24=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > ave used this so far (without risking a kernel bug)
> > >
> > > Fair enough, if we don't really have any risk of breaking the API
> > > (would result in using uninitialized memory) then I propose we do
> > > something like this:
> > >
> > > https://gist.github.com/Vudentz/c9092e8a3cb1e7e6a8fd384a51300eee
> > >
> > > That said perhaps copy_from_sockptr shall really take into account
> > > both source and destination lengths so it could incorporate the check
> > > e.g. if (dst_size > src_size) but that might result in changing every
> > > user of copy_from_sockptr thus I left it to be specific to bluetooth.
> >
> > Make sure to return -EINVAL if the user provided length is too small,
> > not -EFAULT.
>
> Sure, there was also a use of -EOVERFLOW and the fact we are using the
> return of copy_from_sockptr so if it fails we just return -EFAULT
> anyway, so if we do start returning the error from the like
> bt_copy_from_sockptr then we better figure out the errors it returns
> are proper.
>
> Btw, do you want me to spin a new version containing these changes or
> you would like to incorporate them into your patch and spin a v2?

Please go ahead and submit your own patch(es), thanks !

