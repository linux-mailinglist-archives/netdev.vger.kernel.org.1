Return-Path: <netdev+bounces-182572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43244A8925C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 05:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A76189BEDA
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBCA2DFA5B;
	Tue, 15 Apr 2025 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drDkCUAP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEC22DFA2D
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686229; cv=none; b=UNVvyn2rrjKRYYIBq5bvwwwjTD+ZV5GQ32nVezavdykj365oFLO5aluL7nGkvZlMbYimy0zCJZv6LngO3ykD2l29YnX/7Hv+LN0VcgkaA/y8l9KBpO4Cum55O05/st/4IIm8Uvh1fborPrp3KYXJE0xMPdgcQaO/VCr8W8fJIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686229; c=relaxed/simple;
	bh=7Ddcg7W3er1d5ROCgYCdnGJ6X4gYZggHsbvsekodTFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I62Ye5PgHVjGqIL/8gjunFNz3YVNUzXrEIq50aGbE+dNJpEm/kpC9zDHN2a4dAVEY+H4IZj+fWJcdGu024mGlc0j28Dvxi2PepZSv2JKgQFnXdA6u+fNbhqrCjLOVBlSubSjdHPqn3AkxHEH+p6RZj3MRZRw3shTzLVO7meY/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drDkCUAP; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5499c8c95beso4321e87.0
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744686224; x=1745291024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5o8wCf0ZmAetYO0UliI4/Ia44n4Ie/lZPY4GaHmnSc=;
        b=drDkCUAPO1TudHWSIWqUtAsLGX8wALf7GYJ5tMff66cfugc9pvhntppk+YPfH+Gteo
         b3pSksAKclnPWn7sXNZmbnfX4oZ2j7WR1RtxII0caN7eabiJofZTanpWu5w80ocd3kY/
         5VFKQXu3VNAUCbUvwHebuoBV5nhb5Az89hR7U/bN2Qq6ACOWUjLJ/TbHW5l9BcstDxzQ
         R87crqN9Gh7ZUWcoZuarAkWiEZA5EHTfHGvF6UgqHxzmFIiyPBZ+rWeMZOSZ850IidYx
         HCDtJeo2AYLummhlSkDk1lHlFwwAomLEX8wK25zqzz8HefmRARlwgBsSrcqYLkMg7lgN
         mRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744686224; x=1745291024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5o8wCf0ZmAetYO0UliI4/Ia44n4Ie/lZPY4GaHmnSc=;
        b=DYFm+k28tHgcsAdwLedWaCMuAVyxEfLo9VPlum4YWVp+l+vFYiyQY8y4F39ZP+GIr9
         KT1tfzZrwLRa6SJlCy6Dz7PpzvsbwPo88N5Xp34Xj+sBG95we9gkBdWUezn+DibtmOZk
         DBcUcu2OaUVXgc2I+kzW0pm0f1AY6aYM7qJX6iOfjMLOvDmiTQMu8llTUwfJXAJYUIG4
         w6K+P9WyqUNziw7WON99dPWAY+sCOZr6y2dqN7DoXamPzcqHDwCrqCZRXuBanJ0k7FhX
         c7MddixIvAmbOnBENsIJfnkfF3nj4nNRQsjCSGE4mHkeP0KI+o4gi8Hq1CqONLwxC54R
         PvPQ==
X-Gm-Message-State: AOJu0YxmZcXKJpsW6KsOxnDjg8E/oj6twVSA88ScPto6gfh1tx759YgL
	yxpnOAlkWCgpQ1aa+5NN5Vq9UGduVtQJt3T7MVqqXW4P1w4N2Tibz87rGUqh+xHCcWDnvDOVc5L
	Uz5phKz/yZg0Jyjv47Ku+5VUsWFGrtD9WsMiZ+FnfJWyOD+r2MqMw
X-Gm-Gg: ASbGncuYzlZcTCk4I8mnZ/tJg+GcW7OqcKrVHGPystPjbisDo7eG1jA9tpsrwrF41PZ
	Kk2Icq8bz1ASzHeXOVCWEAVvIb6URCqO9nLvz07uzIPrc9G4b0jtRuN1awnXMFDl1ZDWeFufTQp
	ZMUD7LusXWkhmOUKMm+kgm79SqjbacfqI0bl5NrFSIohcX5TRUc0RI
X-Google-Smtp-Source: AGHT+IFOz/w+m1S6m21IB3+fV7O1fvdVvxc+JZui6nrtvDFFnCzkgS49+OMM+IPU+ETrULO7ucXDrN71/PpDZ6hKSps=
X-Received: by 2002:a05:6512:3f08:b0:549:7c56:5300 with SMTP id
 2adb3069b0e04-54d5b76b359mr70098e87.1.1744686223842; Mon, 14 Apr 2025
 20:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313023641.1007052-1-chiachangwang@google.com>
In-Reply-To: <20250313023641.1007052-1-chiachangwang@google.com>
From: Chiachang Wang <chiachangwang@google.com>
Date: Tue, 15 Apr 2025 11:03:31 +0800
X-Gm-Features: ATxdqUGhj8mAwq_9yVMVHlV7TlBS2vnmuubPHHlGx8D9KxmcL8tbrUTIxEKyB3E
Message-ID: <CAOb+sWGK5ufBSBDkhXfwJTH+C9Jpa+0qCVvf=9RW1GQig9Vosw@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v5 0/2] Update offload configuration with SA
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: stanleyjhu@google.com, yumike@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steffen,

I understand you may be occupied by other works. I would like to reach
out to you as this was uploaded for around a month.
May I know if you have any review comment for this patchset ?

Thank you.
Chiachang

Chiachang Wang <chiachangwang@google.com> =E6=96=BC 2025=E5=B9=B43=E6=9C=88=
13=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:36=E5=AF=AB=E9=81=93=EF=
=BC=9A

>
> The current Security Association (SA) offload setting
> cannot be modified without removing and re-adding the
> SA with the new configuration. Although existing netlink
> messages allow SA migration, the offload setting will
> be removed after migration.
>
> This patchset enhances SA migration to include updating
> the offload setting. This is beneficial for devices that
> support IPsec session management.
>
> Chiachang Wang (2):
>   xfrm: Migrate offload configuration
>   xfrm: Refactor migration setup during the cloning process
>
>  include/net/xfrm.h     |  8 ++++++--
>  net/key/af_key.c       |  2 +-
>  net/xfrm/xfrm_policy.c |  4 ++--
>  net/xfrm/xfrm_state.c  | 24 ++++++++++++++++--------
>  net/xfrm/xfrm_user.c   | 15 ++++++++++++---
>  5 files changed, 37 insertions(+), 16 deletions(-)
>
> ---
> v4 -> v5:
>  - Remove redundant xfrm_migrate pointer validation in the
>    xfrm_state_clone_and_setup() method
> v3 -> v4:
>  - Change the target tree to ipsec-next
>  - Rebase commit to adopt updated xfrm_init_state()
>  - Remove redundant variable to rely on validiaty of pointer
>  - Refactor xfrm_migrate copy into xfrm_state_clone and rename the
>    method
> v2 -> v3:
>  - Update af_key.c to address kbuild error
> v1 -> v2:
>  - Revert "xfrm: Update offload configuration during SA update"
>    change as the patch can be protentially handled in the
>    hardware without the change.
>  - Address review feedback to correct the logic in the
>    xfrm_state_migrate in the migration offload configuration
>    change.
>  - Revise the commit message for "xfrm: Migrate offload configuration"
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>

