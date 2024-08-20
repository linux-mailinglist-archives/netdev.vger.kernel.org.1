Return-Path: <netdev+bounces-120160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F8C958769
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0D41F23CA0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083B418FDC5;
	Tue, 20 Aug 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxB00t3n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2BE1CAAC
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158509; cv=none; b=D7EbuInTdZf8bWxX5CeS8joIPWBYQXd2SofQVmEz6G+7T3ATdL5K7NAWDO6vsqqTeVK1g5HMR+xEVUyDVkoo77SlCOiKl65GV9+LOiF/dq0IVyrlUdqFfBNQmTt+b1xhhRttmEn19tYe2qFnPYQs9PbeblSyfsT10UmWEOlTHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158509; c=relaxed/simple;
	bh=YQtsn+NrcevJRsTUWebeLd+4Df08G1Ny2dtwEfeMbqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/fVZw0+MOiekCRHIpfyjDfTPLu0yJRqxpkhJ6u+PI417k9VB8CcTuTXnItDfPfsqlOgOgNXeiSpLXI17cftHXq1HXd2adT/k/4wlB+1Ugkluw4Xwolpqw5S7YqVB1HDMWcwFDuRmiSmcJgdiK4d/dnSE0JMsEtvX3UrA1bDFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxB00t3n; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-824c85e414bso200062839f.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724158507; x=1724763307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQtsn+NrcevJRsTUWebeLd+4Df08G1Ny2dtwEfeMbqw=;
        b=gxB00t3n/A6hrPcwyKTsys+g+pbVxYPT7XlMpN3lEM5MKgdT+Du5jC7K+DP8iBx1rY
         wkqDFQw7QGpfupEATVB04ijgbj2Kw3LWohn43/C/mLfUpFp83+p8tIFovr1zIb4zIyJQ
         mIPT1fkkRlUUpTUgdXyA9cSqqpGoqJ0ao8pw/8mt7lZQgzzjKC5SyOEV8EEOKrlLqGRa
         hEXWKPEmFy7Wx7Rg8JK4pjMQXoECsNFuR1Pvwe3Ici4ggHCYnZ+V7DyyjQ4E0ac3flrw
         xOT82HtbvS6O5kqQT248kZatETmccbNY5IYN32R05IIVSf/UGv9QEhEq+X9alJzD24sm
         Fd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724158507; x=1724763307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQtsn+NrcevJRsTUWebeLd+4Df08G1Ny2dtwEfeMbqw=;
        b=oKL/ufixK0s96Aig0HsB/mX0RBg6ZBtP4Y59hR5OYmWXfb1O5CzPhTNLFQB1iANR3z
         9gfUWVa30hqk+7Sh2LxP8o/gFh/SE/b6WplObFzEeFZbjcDBm7CTMnM0LwHYCOtodevo
         i9dwBhFl6pa/IC1fI9z4WwVf8ffxF+ZnsAkJKHABjnWOaG6dMqfIyky2v7+CcWb+pF7V
         d799/sBr0VD58DIyTXmGTwdBAGWvEpDbC7oWoia19sX568/Af8vngyWXDe+kkNG/uiu7
         sKX68oNhvq4DU4gijea4WSUsRmo92oj35DNfIPERefdEAndE9nfgzPntntB5LkhpIfl6
         rITA==
X-Forwarded-Encrypted: i=1; AJvYcCUHb9FGFvf2Na5jHMs2RoV6PyjysrBs0eiefCSNlvSsHIKdbskKs0j5GdiwtokjMBjq/smuv1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrB6cz2KBvMriDq5ddyyoY08IxWcn4H6P4fG8nFE2DBmaUkZ1H
	7BsjIlT6CgV2QsJqjXSWMNslu0omUJ9gtjUdkz+F/Ht2SII+xeJsDx9ksohl0hdfUavNCZlL6ew
	xEiVph6jLT46wo16sRIvUALA37lE=
X-Google-Smtp-Source: AGHT+IGcvN2T2/JcsnMi791D4WTOWZCdkiHs9LaaJcfFYp3HcH7eDTLk/+6MpM5irK1KbaSuyMXBNGitZTA5pTmThpQ=
X-Received: by 2002:a05:6e02:1a8f:b0:395:e85e:f30d with SMTP id
 e9e14a558f8ab-39d26cde766mr160035545ab.2.1724158507677; Tue, 20 Aug 2024
 05:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815113745.6668-1-kerneljasonxing@gmail.com>
 <2ef5d790-5068-41f5-881f-5d2f1e6315e3@redhat.com> <CANn89iLn4=TnBE-0LNvT+ucXDQoUd=Ph+nEoLQOSz0pbdu3upw@mail.gmail.com>
In-Reply-To: <CANn89iLn4=TnBE-0LNvT+ucXDQoUd=Ph+nEoLQOSz0pbdu3upw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Aug 2024 20:54:31 +0800
Message-ID: <CAL+tcoCxGMNrcuDW1VBqSCFtsrvCoAGiX+AjnuNkh8Ukyzfaaw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: avoid reusing FIN_WAIT2 when trying to
 find port in connect() process
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org, 
	dsahern@kernel.org, ncardwell@google.com, kuniyu@amazon.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Jade Dong <jadedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Tue, Aug 20, 2024 at 8:39=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Aug 20, 2024 at 1:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 8/15/24 13:37, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > We found that one close-wait socket was reset by the other side
> > > which is beyond our expectation,
> >
> > I'm unsure if you should instead reconsider your expectation: what if
> > the client application does:
> >
> > shutdown(fd, SHUT_WR)
> > close(fd); // with unread data
> >
>
> Also, I was hoping someone would mention IPv6 at some point.

Thanks for reminding me. I'll dig into the IPv6 logic.

>
> Jason, instead of a lengthy ChatGPT-style changelog, I would prefer a

LOL, but sorry, I manually control the length which makes it look
strange, I'll adjust it.

> packetdrill test exactly showing the issue.

I will try the packetdrill.

After this patch applied in my local kernel, if we have some remote
sockets delaying calling close(), it turns out that the client side
will not reuse the fin_wait2 port like when we disable the tw reuse
feature.

Thanks,
Jason

