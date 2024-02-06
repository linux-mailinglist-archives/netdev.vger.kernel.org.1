Return-Path: <netdev+bounces-69523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BC484B83E
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990AB1C20DD6
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A6131750;
	Tue,  6 Feb 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHq4iZ+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5821DA20;
	Tue,  6 Feb 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230761; cv=none; b=cKBcKezRh4FCgrdd2+Hiu4peVnbXkXEwVNbOAjOWnCxFIs8RLyMv8gInd1py2fJiSVqFqSrkS9dc0iT63FTvGc9qEhDs/ec2OhyJI/Z6Obtgc5LowRbeUiZPUOiDHXEn/m9hVXe+Iuq1Z4+HN1IcQmu3M1+OMUXeFOgScAnaYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230761; c=relaxed/simple;
	bh=LUd9SG5sOcHRXqaXymRltsBzOxHrf0WQuPqjWhpQqvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dk7EpfDmKfdaB90ct6vTNqNKHRTozPZGUtRu7JNVYqb66n+vzcUqZIEOEoNb3x4Jr19U9Pmgher7HEWP77GQfu+HSSdqP8Xyi9p+6UN8nx1LOZEThVj02lAYd7bdXg4/GQfQIndMf2g6kxwaSTZ182qf/2Juz5t07ENhY5HIAAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHq4iZ+f; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so71986651fa.1;
        Tue, 06 Feb 2024 06:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707230757; x=1707835557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISPzFQ+39hOc3TGV78mJtmOkKk6KWk7wNietvjIUL+M=;
        b=GHq4iZ+fX7JGrdiSwodWvVHTNVVPLc99KNAeOhNkSJWm+Pup95P1AdlkonQVG4bNvC
         QvPm88jDbQNliYeOgLMGwOKDbMweUtt4aUEIR4W3i4wnEiE5TxPHs067L+/uo4nf5c0a
         8uPJ4IVOYb51FWDYGO/FdaOHfs5DJcDhg+6KyY+tnUHzSMWxm1kGwllESFK8ngHs1bwq
         XTbdiw4LPmBsc+ejtaPRqkWcGuVgjEC6onybVXQGv8LrhrT+XGd3Lc9PFEA+SVGMQXTo
         ap+ymlGR4Ko37+t1rWkO4bbugumqE/XhXItY0QXYDYDwHQx3JcZ6ffAan/f8mgxbzwn4
         jg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230757; x=1707835557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISPzFQ+39hOc3TGV78mJtmOkKk6KWk7wNietvjIUL+M=;
        b=wAxUiJnpxzipPHTETe9N0rPIm0VboCv1L6XFtNhW5bzgQ2UJsGKiZ1Fkn8ij8PYfwk
         eTl1piasX8If3TVtcGx4SN7Ay6aa5w20lb0sY4VzB2gwMqwl89MlGEuV2+3yCZW7uq4E
         dVt6YaxCzOjpmH7l1gfgupiZfMILH/qrz1sGtNa/DHDfJOjqxl2N0c6F/gUXQN4RPTWc
         OMleUfgJKL6iDbvrMKL48LwvdMYV5t2SlVuT3CBzjkO+Dih1lFcizm2JA33knHxo3JYY
         GleReH5UDbd0A8naa3vTwUNmEtYYUZgnZWMBGMl60FEkkrlhg73t01RGYAT1ulRmnM+U
         45LQ==
X-Gm-Message-State: AOJu0YwqvrKbbSpgP8izz2NWF4mQQGolX7HKnGmD30AplB1UZRytA4PK
	tidNB+/6JEAV+sd20JCWBSQKaUHn4W78QG/KWyvB8LH/wmHyn7GbQdQvop/pbGpkyQrVEAKLpvs
	s1Qk5SLENKuq/G0tkgCp6X1MqjsmeG+7A
X-Google-Smtp-Source: AGHT+IHTm0oYeU0BFiO7sjdAegtXN/TU+YVqfKf4DXQ50ZtiWoJdulvCHfcJCiZdQyoSLAIrhOvYX5vi3FWBnC9JVZk=
X-Received: by 2002:a05:651c:388:b0:2d0:7b53:9330 with SMTP id
 e8-20020a05651c038800b002d07b539330mr1390434ljp.14.1707230757242; Tue, 06 Feb
 2024 06:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202213846.1775983-1-luiz.dentz@gmail.com> <f40ce06c7884fca805817f9e90aeef205ce9c899.camel@redhat.com>
In-Reply-To: <f40ce06c7884fca805817f9e90aeef205ce9c899.camel@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 Feb 2024 09:45:44 -0500
Message-ID: <CABBYNZJ3bW5wsaX=e7JGhJai_w8YXjCHTnKZVn7x+FNVpn3cXg@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-02-02
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Tue, Feb 6, 2024 at 9:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Hi,
>
> On Fri, 2024-02-02 at 16:38 -0500, Luiz Augusto von Dentz wrote:
> > The following changes since commit ba5e1272142d051dcc57ca1d3225ad8a089f=
9858:
> >
> >   netdevsim: avoid potential loop in nsim_dev_trap_report_work() (2024-=
02-02 11:00:38 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git=
 tags/for-net-2024-02-02
> >
> > for you to fetch changes up to 96d874780bf5b6352e45b4c07c247e37d50263c3=
:
> >
> >   Bluetooth: qca: Fix triggering coredump implementation (2024-02-02 16=
:13:56 -0500)
> >
> > ----------------------------------------------------------------
> > bluetooth pull request for net:
>
> A couple of commits have some issue in the tag area (spaces between
> Fixes and other tag):
> >
> >  - btintel: Fix null ptr deref in btintel_read_version
> >  - mgmt: Fix limited discoverable off timeout
> >  - hci_qca: Set BDA quirk bit if fwnode exists in DT
>
> this one ^^^
>
> >  - hci_bcm4377: do not mark valid bd_addr as invalid
> >  - hci_sync: Check the correct flag before starting a scan
> >  - Enforce validation on max value of connection interval
>
> and this one ^^^

Ok, do you use any tools to capture these? checkpatch at least didn't
capture anything for me.

> Would you mind rebasing and resend the PR?
>
> Thanks!
>
> Paolo
>
>


--=20
Luiz Augusto von Dentz

