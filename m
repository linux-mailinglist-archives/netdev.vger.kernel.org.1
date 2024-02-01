Return-Path: <netdev+bounces-68199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7558461CB
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 21:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E42C1C22587
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 20:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0D985627;
	Thu,  1 Feb 2024 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22ukRdaz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A18528B
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818262; cv=none; b=jjbErhOe1rdjON/TiM8efs9a4Cn/n1xy5N3M5GMy1KCsr9aSSg/ZPJxJ8XZ6/IkxKkfNPJ8y0KT3gpAEH4djsfavdXDiByuRKq0YzKu85uWdeAm4Z+tZZdwg4a+I4fn1MEMCwuRXo+F3LIJY8vMeJmWqegbM5xMzJGv+LZ8LtlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818262; c=relaxed/simple;
	bh=p+cFD0VWHPwsCLWu7k74qwLoPELrk6sXEkr7D0IEpZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPOvGegltF2a2fpHcGsvKkhG8OZS3buzDqNadL4YGql7qZLVOc4qweDkL9+eDLEgBdVgksuFH2eCrIZcdVJGVoSYDnE5AOIEDkLFCkFqvgPR+b9jXm/hXUoJu7sMzibMTApBXnXYrqfDmjghBXE9T3Fid6ol4dZ45+Sj9SeG5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22ukRdaz; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f63fd3dd8so2344a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 12:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706818259; x=1707423059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HUJ91Kg1r9ZFRIyQrQf1AnCt8Vh5OB+DO7n+ndiBvI=;
        b=22ukRdaz3qzrzZopZn75tQZ3UnJ7uTG56vidKyf4W+fGlsynNwhUba1ENozlu5UUG8
         zEHdkVovIgcbefkSDb2Z3VfHRnwna71Y4iwqWaoh02IbQO0odRzF97eRW71U2AHhCMbk
         e/5ZLEUY9Tgo0212OFZ87DBKjmKdA+SuWUD2iJiAMOZBNGeu5/9+c59TpSqqJXgeSZos
         Qo6ynypzEm/Cw5IIfQAyhaN55YAYf4Q2aEZwwvfzfDrSYWvXEjQRMKfN312TjAH6Q/eg
         j/QHqKRxexjDYQ8ydRtPAEc9NH5AkilDUOBwxzbtaXT3pENt4jJ6yYVjEo9Vsm/JOM3K
         XdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706818259; x=1707423059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HUJ91Kg1r9ZFRIyQrQf1AnCt8Vh5OB+DO7n+ndiBvI=;
        b=VmSjZEj1T3EagocC5MbLEzerPH1KLMTD92Yytbu2CgHrPOP0EQ/PRDX7JkeG91L/2a
         qdCSoS2XW6W9kPJN5rIvZwhAW3GzRN3WsRK8Lfhf8+CYwK/koQtpe4g+/3ENVvVYyY87
         7HJq1t3nAdjrPHSZVq4d73sdLFAG0/kkD3BwwEagM30bjwPTBB0W1c7d8e/CI0fl3R9n
         rLLGRP7msynZYq0CeZ0v4HK34NWW+m1SPPuovfQT4m2Igr0gePVql083YQvLXpRa936W
         lnoM5iS9/LABGQT2cxYHrEfQYunZOy0cA1rYcksDcNlJ2GwpG1KCgixYv9OZuO0UOAeo
         JATA==
X-Gm-Message-State: AOJu0YyIqKYx8OBTK8uff7UbprfFhhYjyPmeQIrpsUzOHl3lbwuzFajN
	MSfKg7WZvdMD9jqRbiv6wpvlrSly6PWLZWwK1VK7IXfrW+E62EQ/P8XRoXWgYKPWtUs96b+Vnz5
	ebkJW6d/329JXLSb0CRV8RvRQH4y6Z/tXPEpmeQAAhklLcEwmUIMR
X-Google-Smtp-Source: AGHT+IEN0t4/mPKYbcBDp05j0wQtiit60NotPmlcWlN6xcItSGXXXc0Gf6Vz8fkxYCFxOLQvZ1XV7WjqCVfkJP7q+bQ=
X-Received: by 2002:a50:c34a:0:b0:55f:cdc8:b43 with SMTP id
 q10-20020a50c34a000000b0055fcdc80b43mr15747edb.2.1706818258802; Thu, 01 Feb
 2024 12:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201175324.3752746-1-edumazet@google.com> <9259d368c091b071d16bd1969240f4e9dffe92fb.camel@redhat.com>
In-Reply-To: <9259d368c091b071d16bd1969240f4e9dffe92fb.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Feb 2024 21:10:46 +0100
Message-ID: <CANn89i+MLtYa9kxc4r_etSrz87hoMF8L_HHbJXtaNEU7C22-Ng@mail.gmail.com>
Subject: Re: [PATCH net] netdevsim: avoid potential loop in nsim_dev_trap_report_work()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:49=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>

> The patch LGTM, thanks!
>
> I'm wondering if we have a similar problem in
> devlink_rel_nested_in_notify_work():
>
>         if (!devl_trylock(devlink)) {
>                 devlink_put(devlink);
>                 goto reschedule_work;
>         }
>
>         //...
> reschedule_work:
>         schedule_work(&rel->nested_in.notify_work);
>

> And possibly adding 1ms delay there could be problematic?

A conversion to schedule_delayed_work() would be needed I think.

I looked at all syzbot reports and did not find
devlink_rel_nested_in_notify_work() in them,
I guess we were lucky all this time :)

>
> Cheers,
>
> Paolo
>

