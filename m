Return-Path: <netdev+bounces-117098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4608694CA49
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA283B216A1
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 06:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3D716CD24;
	Fri,  9 Aug 2024 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZtTjcpQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFE3770C;
	Fri,  9 Aug 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723184041; cv=none; b=Rv0ZTYqKLKyykSaWxnZNUtLljKr4207h5vmBxxDu/MBmzWeCK9zo1CJsyVgFa30g5LJIBo+WsRLBtWmcupZTZbEM0BG10AXnxI80vLQEnMe0Xye1gHY0RGilIxJyDw9HZF+XS7jUlKdkNhB99g0u7IjL2B7jtCtfOqNCvtSljRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723184041; c=relaxed/simple;
	bh=ARX/Q/sasAYVVryfc9n8DSEOCNqLxXB8Afapu9TF/qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj/G8celfMsK4LH3oqK64jFWZWi/76D0GvGUzla+gghyVaI+PjQCjrvZZgvaR7Q7I3a5vlebIpuqVGHEZiDW16xg/yszcZO9q89ys1YC7Rrd9mPo1GlXT38VPiEt3PfB7j0HuKdnUnRz5T20n+CkiTMQ2cQJSMVQ9A33dxhAJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZtTjcpQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so3615699e87.0;
        Thu, 08 Aug 2024 23:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723184037; x=1723788837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7R+GvxQaqy1SfAZarZjxrPqQ4LKd/QY13USIM9naNYk=;
        b=bZtTjcpQvX9jCLtaIe2cdoi7gegOL0amopXRnRLlen44yvetyvpIDXGiybrJBFLCVt
         dx4h/s77vNVqa37PxnbdGFzkS+iYwuFx7z+yAtEEbmbU78pOdrY7vGedxT7mntCPJP+3
         Lok6khj6o311mPGzNEHkvXxcRIA3nOmzSjBsCna6GXPUEkyhWVJTMk/JUs4xq4vVY5Nv
         99PCcQFPvRGNO4O1LAWOIE/EOvEQFDuxSkK+YoJpagzGpA2k//N6Dam1KwtjHZvBr1Zg
         Yfykz5gl8n2HWD9GhtpViRkUIDDsh/h22V8zAo4YJeQ9m+sGVAtxWWUdIuna2u4xSzhd
         fWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723184037; x=1723788837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7R+GvxQaqy1SfAZarZjxrPqQ4LKd/QY13USIM9naNYk=;
        b=J4It/YdoytLoMTT4VigQY9ml44NMZ/IeFI1LMr4qAZBuQYW6V8vHXii58jpDbp8T2Z
         uo5la41mHCqa+rqN9msnxwQIvC8DCiKw0nlb0HzujTbijCKJAnS1iYAt9iosw4Uviqig
         QrkTnYmZpQBijJSGT3vaBU5a8Fwvydb3nEZqXTJ5hZFEnPWWqF8cHv9SLSFn9rLwaSl+
         9pu0OIkogtdjd7cFXYu2eBNngX9P6X4fSmmUNI1dkRm5t7LaLBJB0FBiunA4zW6kjva4
         GKaOfiv7iMnPraqYZbglT8DcWoSJutj6REdbERAlpF8MrfajB3JAsrAwy57qYjnYT4pc
         eIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6Jw+aonKCizYx1uoQWxoCBiJ+eBCqUISH4i8zN2MYcfBVlIIES6rqzC4N+qZt1klMIAlCajzaNkGfIOudZc/5pD6t6g7fO5yvwFQebwDDkP//YRIjyxDNzFNskopI6N3ohl4m
X-Gm-Message-State: AOJu0YxfuhQ2V2bZ30gaK8dJf4EdvuZ2ZIA0IiJIBRQFuctHbh5+I35D
	xbEClc29cXyVKcDIRgAGpVDVYyS/jBAfjq9nQijGzATUBh5Q/xDHrgGLm5Uun1eow4ULe4+0YK/
	SPXTJEme7UodJLqX69xqmKIEp3xc=
X-Google-Smtp-Source: AGHT+IG9KRqwmXzjbRJpRGmOXCH3Q/dtEY4RbkmR0dyQnNnDCe++wb1t9DF2EcGshwDzKk4qAhw3sbLKC4y/We4HCKQ=
X-Received: by 2002:a05:6512:31c4:b0:52c:df8e:a367 with SMTP id
 2adb3069b0e04-530eea129b6mr464503e87.53.1723184036963; Thu, 08 Aug 2024
 23:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c6b2fecaf381b25ec8d5ecc4e30ff2a186cad48.1722925756.git.jamie.bainbridge@gmail.com>
 <20240808081054.1291238d@kernel.org>
In-Reply-To: <20240808081054.1291238d@kernel.org>
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date: Fri, 9 Aug 2024 16:13:45 +1000
Message-ID: <CAAvyFNj3QBka0fS5DNLqYDXxAWxduBrkWp991yC6J_3JZa5H2w@mail.gmail.com>
Subject: Re: [PATCH net v4] net-sysfs: check device is present when showing duplex
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Shigeru Yoshida <syoshida@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Aug 2024 at 01:10, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue,  6 Aug 2024 16:35:27 +1000 Jamie Bainbridge wrote:
> > A sysfs reader can race with a device reset or removal, attempting to
> > read device state when the device is not actually present.
>
> True, but..
>
> > -     if (netif_running(netdev)) {
> > +     if (netif_running(netdev) && netif_device_present(netdev)) {
> >               struct ethtool_link_ksettings cmd;
> >
> >               if (!__ethtool_get_link_ksettings(netdev, &cmd)) {
>
> ..there are more callers of __ethtool_get_link_ksettings() and only
> a fraction of them have something resembling a presence check in
> their path. Can we put the check inside __ethtool_get_link_ksettings()
> itself?

No worries. iiuc that would also mean reverting commit 4224cfd7fb65
("net-sysfs: add check for netdevice being present to speed_show")
because the check is being centralised. Should I do that in the same
patch, or a separate revert patch?

