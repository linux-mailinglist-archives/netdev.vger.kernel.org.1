Return-Path: <netdev+bounces-207896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434E3B08EF5
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235F13B5317
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F52D5426;
	Thu, 17 Jul 2025 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlMLWksB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745732E3700;
	Thu, 17 Jul 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761979; cv=none; b=lZrAePhrbwOpHSd6adV01aYiu3qOZgUMUrBRL3fCxWIQb9NDG7pVwvcCee0ybb8+fd4bnGsls+M0Ck1ssw/aoweY5nOiw0kthUKOY3UgpMqvziLTpaZ3giTERE6AJstwckDZrKBdAhZBsq5N1knCrvKI6A1Kpr7qRARfVmUmCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761979; c=relaxed/simple;
	bh=nETYC/rTnSj8dVqR0h8qhds0TjNPLeVw1rsC9rAO/jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bw21s40CV6i1Q7Oxn/kZ2lWCA/CdJKD0BfBtc8X3CqC73tDxSzt8cej/0CNBvaemL0xK22FA7JbO8bXO6p1PqT7c1kzvScABC+OnLozQHydYEXWSB5mNvjcnXRiXw+bbW7DlUEJF/1AWX/EPr0qkloeLT3y5GOBAt5TCoXMTVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlMLWksB; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32e14ce168eso11152151fa.1;
        Thu, 17 Jul 2025 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752761975; x=1753366775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vxu8+bCUtlERkF02ujaWx/bVvcqy/SwbKTN3++d2H8k=;
        b=GlMLWksBwtSmA56Djovu1PNJJPvQzX5mahOrzR1ubihIGk+ln+42elxSFCJbzMUlcU
         MeDNGg34boj4/KQCO/NDotVnXUBA+7opIVjlNQ8jw/3JFyHut6wyRe8OjTbxMo1dEToZ
         YwWzxyCpgEV1vkS/X0F1UwEn7sPlRYRhIg5igsrPqXP5wzRn91mKoi/8gijgd6oydj5W
         HbZO4H+xCi/qzMx5FuTbN1SUmc45g7leycXR1I5H9mf3e3NbdFVVGm632DGeXd11BZ6d
         5t0hxgKzAbrV84/H6rtg3bU+MDB/n74e98HDR7iZZsq/3w1e0+mUZl4KoHOcRUYOvhJW
         iuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752761975; x=1753366775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vxu8+bCUtlERkF02ujaWx/bVvcqy/SwbKTN3++d2H8k=;
        b=tE09poRBKENG5jyNdMfYodxKw3e0WEIc61QxQH8OyQ9v5Z+zqpk3AJ8IHXZUsKX87N
         SRkNO6wybaNDRDLI2yAc9RX1unf7cVvVuThQjGxYiJ28XIIyLK3Z63hgtUA3OMbk1pfO
         W2VWwGP0fL8/20N2KVuYHKnxpg+qTa0UVsKVV0buCL9+6djS5MUzfoh2r6Naq8pVMk8V
         gdghGnEcZhhZh6i5TDRs7HMCjrDaJ4TN5CruicCavYM26jBDmdPIe+/B2+JrZAqT1B17
         0bldSMbIolvS6OR1FUQDS33yN0kQiA7TvYfZDDSKS7PlfVbH2cwM6LMWWl2zHMEY5j/C
         DYZg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4V+RBZpJWpKP+BB13wEW3fgW+6ebtSyI2DCxvO4CDkCray8nKBCjVgNZAPe1RtVXhFGJXZqPosoDMpw3LwQ=@vger.kernel.org, AJvYcCXUm8Bi2dzk99PM7jdR+cRhvmprsAGfrtdkb3+TnGTi/mnd1yuR2FmfEpwzJOAa8bHuh7C9zjfN@vger.kernel.org
X-Gm-Message-State: AOJu0YwZM6/5te4qnmwZi/MvPOqFnn2XDqxF+KPuKvjcoT+sSZiF6AdY
	41bCBNJ3PKgzrFmCGYFS5+EdYCPDsZ9a4Efgeht/Mu3bSEfYsR6Bd3KyrE6F+73qUNBSDATKJYk
	OxqFYCfNGwfzTZBiLkbwYU50YUpbtrJJjm7N7
X-Gm-Gg: ASbGncu8pfIjrjVYzAaiVVoQ2Hr6zQenjuURQ07I63d7PjNPTiLOx4dnrMUznGd8ltC
	Sixmgr8edHHgS4CffEpvPQODGbFlEaOns6kDY2K4usmoYnJCBXGvv9RfsKqKr2c4f8bj0icHSYR
	t0B6JznIxwebmskeV2hcEyvZz2s/WJA2DiOAH0MI9IULL4rKqeDnqCY/fAch280LkNJU3dZjr7f
	Cnyrg==
X-Google-Smtp-Source: AGHT+IEVAJcOQrBB41MYBcoYH3u3Dgll0keTxcuu/nXXagoS2SFW/BSRXGxiCfcyWMViHZL2IJJBTPTqclukfTnFbvg=
X-Received: by 2002:a2e:ae18:0:10b0:32f:22f8:a7a1 with SMTP id
 38308e7fff4ca-3308f61c682mr16314211fa.32.1752761975022; Thu, 17 Jul 2025
 07:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716195124.414683-1-luiz.dentz@gmail.com> <7d445ce0-bf96-441d-8fd9-2ed6b0206b4f@redhat.com>
In-Reply-To: <7d445ce0-bf96-441d-8fd9-2ed6b0206b4f@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 Jul 2025 10:19:22 -0400
X-Gm-Features: Ac12FXzzebMNjl9AjKwgWamVkIV3_OD1myHqtjaxTvLz-LWY57-R5fiAsam8y2A
Message-ID: <CABBYNZJ64MSJWDDWJkVsYh3HqTwVVs=xNCfMj7ZMzzH7Y7q6dw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2025-07-16
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Thu, Jul 17, 2025 at 6:17=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 7/16/25 9:51 PM, Luiz Augusto von Dentz wrote:
> > The following changes since commit dae7f9cbd1909de2b0bccc30afef95c23f93=
e477:
> >
> >   Merge branch 'mptcp-fix-fallback-related-races' (2025-07-15 17:31:30 =
-0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git=
 tags/for-net-2025-07-16
> >
> > for you to fetch changes up to c76d958c3a42de72b3ec1813b5a5fd4206f9f350=
:
> >
> >   Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU (2025-07-16 1=
5:38:31 -0400)
> >
> > ----------------------------------------------------------------
> > bluetooth pull request for net:
> >
> >  - hci_sync: fix connectable extended advertising when using static ran=
dom address
> >  - hci_core: fix typos in macros
> >  - hci_core: add missing braces when using macro parameters
> >  - hci_core: replace 'quirks' integer by 'quirk_flags' bitmap
> >  - SMP: If an unallowed command is received consider it a failure
> >  - SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
> >  - L2CAP: Fix null-ptr-deref in l2cap_sock_resume_cb()
> >  - L2CAP: Fix attempting to adjust outgoing MTU
>
> This has issue with fixes tag, the hash looks wrong:
>
> Fixes tag: Fixes: d5c2d5e0f1d3 ("Bluetooth: L2CAP: Fix L2CAP MTU
> negotiation")
>         Has these problem(s):
>                 - Target SHA1 does not exist
>
> Could you please adjust that and send a pull v2?

Sure, I will send it asap.

> Thanks,
>
> Paolo
>


--=20
Luiz Augusto von Dentz

