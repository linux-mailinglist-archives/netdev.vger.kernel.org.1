Return-Path: <netdev+bounces-105528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A3911943
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3894C1C2134A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3F84FAC;
	Fri, 21 Jun 2024 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/HhG1tp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34BA1CAAD
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 04:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718943396; cv=none; b=DBsYD4iXkEbRyF2hHFQB72dZw1pruBjkL/kdJBW2yFtxtvfE4pdfV/DCyDGayCQpfQWYmASGfe/biHbgUv5jQkywOepOrMidEtDtOz8dK9lRRpdlBPzRsPH5kI2GBlwb/+VggcjlSFFvh7B0NwRz1uqU7K6iJADF/s8v8BrSc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718943396; c=relaxed/simple;
	bh=Rz6G0BDuaR8F7fyeIb/CzW0GOsHl+jW+xBS3X9zU01Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYK2lvYpvXRzK3aXlhbze9y4GUvz1WJcMneoEuU+CXeHotpcHAfQr23ux5pDGNt921eoxOrXrBHrHjgYilZJm6T96jx7jhizgigfA/g/Ealtdfz475hD55Uwbs5jalIvkFgt75iVvgZRkCFhcBT99LLDQxaavTjcoR57JQGni7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/HhG1tp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-423b89f9042so3745e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 21:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718943393; x=1719548193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yU9bBMYo3DLSZpGPlh+ckaprKGY5QhfxqZXl6kfjlcE=;
        b=O/HhG1tpHiuBfvEx+U9EBwWHfBKwxD7sLm8yLL2EbN20kBhOAUMviWO/9koTVUPvSU
         oZ1jPVKJoXbHnZw+45BxSdcc33T1M+NZpxnWdkQaDynZCp8eD51NsYupFvBP6u7X1a4A
         bOE5jQzAfozp/agGzRxqWJYVVP2Bd+T+VjXv3gwxG+gN0P/D9H/LTIhqJugrqxbllUKt
         voPza5XdlxTHJj3GGuP0iJmXAO7bY9+INhRMN6QcZvCru1mwa2eeUL+wEj/9KgDSObeH
         e1MtDN167mt1G7lHK4RiAoan7EHu/HYn+sD8aVS7UMIfaBv3Vx+bJPXGAaXDsXDy1zkD
         YSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718943393; x=1719548193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yU9bBMYo3DLSZpGPlh+ckaprKGY5QhfxqZXl6kfjlcE=;
        b=pKMjz7w0pXYOjZ7R0T55fIiY8lJG24bBir7ONkBuKX+k9qtryT9RHp5/DPiA07nqBr
         vkK9pppREbmD0Z6Uwvk9c51CDtCrbhX8NVkvfqU8CuS6apjf9MK6dDLI7zQCg7bS/dpJ
         KEbbGGnp7TBQLrwPdiHefR7LwmUMV5ou2OlS8U24kyV2ez+4STrsTwJFqG97psxWdCWc
         E4axO/NcfD+AhvKxvfaDU0+GFiYe9bGfJFxSoEsVR4aXu9gKSitwGsl1DSTXcKFhNTfq
         sSi8Cxdud8UZu5Dd1rHDGUPJijnhoQ8L/ILzbdwWrEc/wmGOcXdm9SF5Aq0xAbfUYQpL
         GSCg==
X-Forwarded-Encrypted: i=1; AJvYcCU1XjP19MCLJnBqhr5nNmnW9USz0/6bheoSLoez86cJi8fmTj2NxGdZJhvMytAET16FvAtJP9Cr30xTkjEMwtmjFrPs8+1v
X-Gm-Message-State: AOJu0Yy3uRtm9eBA5wyluD9xn8pqKGFkiXSHeBEDePA9z/f3uCIZkbh+
	d+qz5bepqDkFd1wuula037wRUosOKtpLCngXh1+3hfN5YJW5LPSs3pvLpM0/GdwzuQtvudh33Ik
	5/n5z2cmMyeScGCCtY3cQtBT7WKcb3P6G1dMh
X-Google-Smtp-Source: AGHT+IEAPf/VMJxv/HWsKYKMfrA4U8aGD7lp2GsZ+TIuBxCszbBzGRHiTZdwbfj2cDBTw75qAd2KEHmBM6qqJ/yo4zQ=
X-Received: by 2002:a05:600c:4e0a:b0:41b:8715:1158 with SMTP id
 5b1f17b1804b1-424814421e1mr184995e9.6.1718943392741; Thu, 20 Jun 2024
 21:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620114711.777046-1-edumazet@google.com> <20240620114711.777046-4-edumazet@google.com>
 <20240620172235.6e6fd7a5@kernel.org>
In-Reply-To: <20240620172235.6e6fd7a5@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Jun 2024 06:16:21 +0200
Message-ID: <CANn89iLhQS3H8UyaaFvPVD3Q-WLT+Lp0GK6Zzg4RgANKyd34pg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] net: ethtool: perform pm duties outside of
 rtnl lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 2:22=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 20 Jun 2024 11:47:08 +0000 Eric Dumazet wrote:
> > Move pm_runtime_get_sync() and pm_runtime_put() out of __dev_ethtool
> > to dev_ethtool() while RTNL is not yet held.
> >
> > These helpers do not depend on RTNL.
>
> The helpers themselves don't, but can we assume no drivers have
> implicit dependencies on calling netif_device_detach() under rtnl_lock,
> and since the presence checks are under rtnl_lock they are currently
> guaranteed not to get any callbacks past detach() + rtnl_unlock()?
>
> I think its better to completely skip PM + presence + ->begin if driver
> wants the op to be unlocked, but otherwise keep the locking as is

This PM stuff came 3 years ago, for apparently lack of user space awareness=
.

commit f32a213765739f2a1db319346799f130a3d08820
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Sun Aug 1 12:36:48 2021 +0200

    ethtool: runtime-resume netdev parent before ethtool ioctl ops

I have not looked closely at the ->begin() and ->close() stuff, I will
do this next week (I am OOO this Friday)

>
> I also keep wondering whether we shouldn't use this as an opportunity
> to introduce a "netdev instance lock". I think you mentioned we should
> move away from rtnl for locking ethtool and ndos since most drivers
> don't care at all about global state. Doing that is a huge project,
> but maybe this is where we start?

Yes, a per device mutex would probably be needed in the long term.

