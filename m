Return-Path: <netdev+bounces-125281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E2F96CA09
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D9D28A254
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 22:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A73149C52;
	Wed,  4 Sep 2024 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4LLF44U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265BB535D4;
	Wed,  4 Sep 2024 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725487345; cv=none; b=tVtcxg6JYTwNAH5eFgVWzFFMvcdSlBBxRyi8x33pf1MM5aH063PV3bH5AXMQ8s6KHN8ImGNKgW1pNDt86JqT+Dbn2nssta6YLfzg3XxUcRSAFMltdaRG77MeZeca7dr5GUPeU+X/5moPLlaY1E1H5BRvLVmJe8zlYFipDeqvruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725487345; c=relaxed/simple;
	bh=OFxToRORFGTs4a6R74AoOJ+6TUbIRUfl2djDeijt2Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaOlbPgCWbrS/f/wlvIJL7DVS3/0w3OwRPvvbQWhFZwVEriuK8B2vvjT+2ogx0L+n+0LNUO1Ez3NaEgtLU/whHkQvWjlaOaSSwcmjsYoszAqu35xO3RqvwOQC1G8wyZGe/DLZUAD6esZrvXWi3pVUBxpWhEcwhi2EAv3zchj4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4LLF44U; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6db20e22c85so430147b3.0;
        Wed, 04 Sep 2024 15:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725487343; x=1726092143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq3nKTV9GBiSoFZtqRjMQ2sXfW9rZ91ehlIYVCkFdxc=;
        b=m4LLF44USrhwUnxko9qxnWnDDosAgUe42yrk2bJSTjXuBfq6we0vpXqGp9Ta339AIj
         kohV6b+6b0+H1fYtdboOatHq40vmIv1C9JSfT2Mr2VO5k1HeRzK4znsnzKGgE+SyUlhM
         elAWUzr0pyOU15FR433nmPD2qhmuEARgccgP2dIbJP4Ii3ldk86gKbwb5thJPOBnUOfL
         Krh1soee35lGLQPhyHYLnQFyCauwiRI8VT3dapyXF82qik/XOnPtyCzWRuLmBT6xagmO
         o7X4gfq7r6q3vEt82b5AbDkbnGck0VHDeFvsQ5amol74u7vtQsVTh0qnsPyLdaXevwFY
         xCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725487343; x=1726092143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lq3nKTV9GBiSoFZtqRjMQ2sXfW9rZ91ehlIYVCkFdxc=;
        b=vg99O/XjZV3JlLt1vXJxVmsCYuT8mknzcBqljDuxiEVm6hShyrExXL+egpskzwkAmW
         Nomi4fogNbSpx5fyWDPBKqba633L6OzRcVypmPfO+meH4wgXM76bFMtY+eyhsjVtPuxm
         vb47vtPSqGeGg5k6AYstlkQXEC65GRBmOblYdj/x5nBAMNIA0PrcADQQ+jTR/gD7+jPH
         kxsSBOP9IfHFzGEEfEuSV23VzJyICkXrQ22mlrj+f7NRLDDSzggI4v+F1j8Pnh9ugRhm
         +3IiCSqMbJB28Tkxg7sOiLEGfSOlX3mdFa4KZxlWdkRx3K20JF++pxOuMX3OFW4356fp
         n++A==
X-Forwarded-Encrypted: i=1; AJvYcCVlvES2qDxZ95rwreYqNJSwYI2r+40r2EuFVuBq6aFjvlwQS8nXoZJR4V8Y8LEgTZ7ZiONcQ+z7VJsJSxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+B8rurbERdqf5OMwcH8/32mPHFUGZ/lgGrLpINwcfMU/aEBc
	VzFksolx4TO/e1N6TB6EbZBu0swa3mA7mBbPYA7Gfy55AK0Zs9GtEbEd2Tk8kbYab9PGxoVQ+ec
	+tjpDZMK25iOBKFSF/ic6advl8VM=
X-Google-Smtp-Source: AGHT+IE+aC6ebrmZOE2HYjfdJfK9QlKwICZrNFPfJ8ZCKcOm1HrVcVtnSxvfUsRiaqNrtXJ5FIgic6bv6zaUSbbmwr0=
X-Received: by 2002:a05:690c:81:b0:6b0:d9bc:5a29 with SMTP id
 00721157ae682-6d40f62dcf0mr244774897b3.32.1725487343043; Wed, 04 Sep 2024
 15:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904205659.7470-1-rosenp@gmail.com> <adcde43a-aaa4-4f2f-a415-e15d77ec7c41@lunn.ch>
In-Reply-To: <adcde43a-aaa4-4f2f-a415-e15d77ec7c41@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 4 Sep 2024 15:02:11 -0700
Message-ID: <CAKxU2N8sXUnMvXmJ4s045J6Y0UiQZVufJFaxA4=cXOvnEt=8Bg@mail.gmail.com>
Subject: Re: [PATCH] net: phy: qca83xx: use PHY_ID_MATCH_EXACT
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:43=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Sep 04, 2024 at 01:56:59PM -0700, Rosen Penev wrote:
> > No need for the mask when there's already a macro for this.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> The Subject should be [PATCH net-next]. Yes, we all keep forgetting
> it, but it is important to the CI.
Procedural mistake. Need to use --subject-prefix looks like. Should I resen=
d?
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew

