Return-Path: <netdev+bounces-95542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C2C8C28E9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA69B261F5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6F4168BD;
	Fri, 10 May 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WxUwDIpQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645221429A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359553; cv=none; b=qckZ52n5bzmTpszee/ceRAmrW/AXEQXNXkH8wnwhmFLpZ7HmMhFtSyradtX3iJVGtA8vlOGgv5qDuEruA8MdDJMucBDDZ/3Z861DIzsrTBoayTMcTpC2rpvJSRsOuHHFIuojWr8phPqh9613rmR8LNQFbWbNoZeDQa2Bxdu/2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359553; c=relaxed/simple;
	bh=IO/tJZ68RvBtGtUdjhyK/eRCWJdPd5uxAzWx2KRBods=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDxVma6+AZDmfvtEyJR0Z5VBTLNR63oZm7PZDIbxrrwPA2Ju9THWrTYZT42P5Hk+wT6qeAK7zrU+tXVHO8oIXhE6qA3J+cPc+nTTticct50mfpoRIzSxHg4tp8mQc3asFAwe7MTUdoBMGDr6wSiHfgz7uENTz/KzzPN8/Ixjs4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WxUwDIpQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34db6a29a1eso1808379f8f.1
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715359550; x=1715964350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaxtUnOJmP45P1JGNrV/UVX05M43+pCoWlRSHcvYUFs=;
        b=WxUwDIpQVxw83ailAoc9QvC3yFHVEJo33CGc3+zLoSftPQ50uS1/NjwiEI6Hy24SMy
         voxUq5Vqhay0Pa2zSozgAIexhI4zuok2/bOcxfKG9u972pmYCXefBYkhm4XOUCPOm+cp
         wX85s2pRZ5s2wUeTkTghkh+bTRAUFhleAk9KNDJbItALLG1ME2Qq/m+NvjkWQNJoMzZ8
         ttMl3ktrSpcpOa/SkQtbTMhm90Wr+DIVbE4nLq0epAa6lFns0+K/XxNe0KsciOlyfvq2
         EOm1DT7ENAaIu0FM8esOVvS2gKgOx650XNsYymz2WFf5ZCYdNmAAZ3aN4H7jyF3vFab9
         x/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715359550; x=1715964350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaxtUnOJmP45P1JGNrV/UVX05M43+pCoWlRSHcvYUFs=;
        b=u7m2i6CMWzQ25f6OjJBr928MQgNblBoX51nggw5dH8D/cf5XfkHsvwIhKzn8Var6wp
         TbE9OSJaBcDThaiX+bU9e9Tz1xSKxdAWCTynIe6hkwsni+5xgm0ujftFt6AZGyeDoLOy
         Swab9kuUuIuBeeLSEPcS1c/7LG3d+Bizpo4lIC0J46GoWJvXX6ZtngoHm3V6IhG5VIrU
         VzRTJDaCaqSr4VzGLHkKl/4EMlye/cmxOEKMyO38uejt1D+3BBBb3Yk6ZkfrcDZUJG//
         ssJmVqngwplr9k8d6iTtCUwHA2u/QJPphrYvzhd+VvcGXajBlCoB+T1dAZgjP0rGGMnP
         G+IA==
X-Forwarded-Encrypted: i=1; AJvYcCVbcG2YNtThzOg6WhO2kbMqLg7sSCVM9UEzfXTTGUwqjMo/NnxE9oyl5aSVtfa03GS8i4n3T/A5ylaqoeqxTLq0UHr5lytJ
X-Gm-Message-State: AOJu0YyrmjM0iSl3jNy3RQycm9ITrnC0txuCGaKk4sKBWxLSkMrqW1qR
	fEegZh95xEb2ige2XSsJNgYOBTJc3jQwZV9rwJQccf28XnLnBu6pZRdAmJfkOkwD8qzQRNo37fA
	h7SN9j36Kc3BVVBi1KhOK4Xu3fRNOveiZUDPH
X-Google-Smtp-Source: AGHT+IEDr+l7KFhftKmNc/alZdq8t4AOx+lDWsT4CH9fPSrDCOWD9OWtX2TXZbJvbsHhfIg3qWFVvcOGyd+MvQBNtPs=
X-Received: by 2002:a05:6000:12d0:b0:34d:b284:9c65 with SMTP id
 ffacd0b85a97d-3504a969198mr2248659f8f.45.1715359549525; Fri, 10 May 2024
 09:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502211047.2240237-1-maheshb@google.com> <ZjsDJ-adNCBQIbG1@hoboy.vegasvil.org>
 <87cypwpxbh.ffs@tglx> <Zj2dZJAfOdag-M1H@hoboy.vegasvil.org> <878r0inm1c.ffs@tglx>
In-Reply-To: <878r0inm1c.ffs@tglx>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Fri, 10 May 2024 09:45:23 -0700
Message-ID: <CAF2d9jjnB7hkjzAdynSMOWwiy9OZEbTrfSQxsVxhF8wwatW9_g@mail.gmail.com>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Cochran <richardcochran@gmail.com>, Netdev <netdev@vger.kernel.org>, 
	Linux <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sagi Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	John Stultz <jstultz@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:50=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Thu, May 09 2024 at 21:07, Richard Cochran wrote:
>
> > Thomas,
> >
> > On Wed, May 08, 2024 at 09:38:58AM +0200, Thomas Gleixner wrote:
> >> On Tue, May 07 2024 at 21:44, Richard Cochran wrote:
> >> > On Thu, May 02, 2024 at 02:10:47PM -0700, Mahesh Bandewar wrote:
> >> >> + * History:
> >> >> + * v1: Initial implementation.
> >> >> + *
> >> >> + * v2: Use the first word of the reserved-field for @clockid. That=
's
> >> >> + *     backward compatible since v1 expects all three reserved wor=
ds
> >> >> + *     (@rsv[3]) to be 0 while the clockid (first word in v2) for
> >> >> + *     CLOCK_REALTIME is '0'.
> >
> > ..
> >
> >> I agree that it wants to be in the commit message, but having the
> >> version information in the kernel-doc which describes the UAPI is
> >> sensible and useful. That's where I'd look first and asking a user to
> >> dig up this information on lore is not really helpful.
> >
> > But writing "v1, v2" doesn't make sense for this code.  There never
> > was a "v1" for this ioctl.  At the very least, the change should be
> > identified by kernel version (or git SHA).
>
> Adding the git SHA before committing the change is going to be
> challenging :)

Instead of v1/v2, how about I can make it 'prior to kernel 6.10' and
'from 6.10 onwards' etc. (as Richard proposed)?

