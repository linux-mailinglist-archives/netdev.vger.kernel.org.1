Return-Path: <netdev+bounces-155392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25FA02239
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279AF188485F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC981DA10C;
	Mon,  6 Jan 2025 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZovOqNL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2611D95A9
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157158; cv=none; b=FpIqSaUstl4fbozlOYKrQbDfm8rdOACqATeezQZo852UuXoStJR1f6IvyQsGsPUIRE1RVtQuXr2fl1yRhCRCID0fnQeM1Ebb3xLLntFjd6I4tttQv4kbxaoHcC5uOPh1swTrusj+tbL90Y14cvK8HRNjjIOiOo66DeYpa4Nn3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157158; c=relaxed/simple;
	bh=9Ws3Vg39V4nhhhogzqKmhfSX1u6cpS+7W39WWIyDEx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZoxD2F5LpoxAulG9VSzB44eD0Q/vRkjrJnMi9zSJvh8+A5KqsJ9zhKzkZj6Nm/TylAhzNFCzwsmCP1/19zCBZ31q5rs7rl0LLr+qfq+nSVvbim2m+hgCjOsVXFXJnVE7aj1anZMMeJ41fnYfIC6i+uEgDZzwdObLOpHEnjCURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZovOqNL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so599989a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 01:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736157155; x=1736761955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx7LiUsDDCScbTrA4th1upmy10yKcoruKcf6PaN7f4g=;
        b=jZovOqNLiZ4eDrV+tvYPiy8U47tvN4NM5JJkFpo4CpGZtv4xVcBjTlmvOsFoUTtDgo
         UTzb84KX/Ct5NxpofCRLOvlwf0mv9Kt3evOrmo9r+Q01JDZ7dWKqZ+3l9qN44P8Xp+64
         yGPq/k6Wi8Mr8RlbmkY6bwHo5tRVsL1eq80n1/W4N6S2f/0zdeWPP8pWwn/Z80i79rNv
         yFeFg82AeUrXlRW+U7KJ/qSEX6Yg7UOflgnaMvPiWVTYC08DDGowlPL02a8qrY61LXk0
         ChOMra27rDuS30ctRciPk3Vw4UJLR6x7lFYPa1NM9hENZ5vw1hv02IAOsQezbHtT7UH+
         c5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157155; x=1736761955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx7LiUsDDCScbTrA4th1upmy10yKcoruKcf6PaN7f4g=;
        b=pqdm2MIQ4q7/Jw+S243Wh9n4DgALpgwJKrKqXR+tHGpdlFHiefV/ILvUXr4+b9w9/U
         eCSiMhZ0GVf0BkT4f3rQmwCNXAnhtLNeP42y/nJ+S5eW7U4IxNoZdW3z0zpjoN/6MJYw
         snZXdKZKEI1k4ydgwnhKnk9bETt8OpQMgY4eQfPsb4xBP7yKdNixNXd9LaPjnbkn9bvE
         af3eOHxe6bKxKIonlaIJf9MmWrMDtSPzvpnHVGLU8Qo8VuqPgz3JeVPxQ/NTo+7zsxam
         qxKclYhGRLZf8CyBNnpFFCHVzmH7Ib818uENEcW7fSHyTbCN1XzDxeVXYblf2xTCrMtl
         U9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVTC/dbLFWF9pwWocSGvLskHzu50VLiqqImmCWzqM0uCr4luuribOt/UCNm54uZRFN+czfUl5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/IKRmmQRYREPrxwa1xQ7sFb4bQaTS+8QHYN8RiHqM/2Jvb5p
	540E8EkRXsWdi4/QethE44umAy40QT5B+Ae9sKoaJFoAPrisAY37mqBD1Fx5UKmQ2ZApO+6SG9c
	F45XfS8x/vW7KXdsP8TThM9LCRrIfk4vUmAw/
X-Gm-Gg: ASbGncsDFlzmsDfvTMnGRVtkK+fWGfnph3t9TDleqNJzU1uJip1ktwfZqO7tX3LIout
	HneNQ9E87QN7os4kLhqfTNPIn45sf5M52tOtJdw==
X-Google-Smtp-Source: AGHT+IE4iZVs9FeeSrHyPPmLE2wzktl+JXPoH+gujZoMEo8QXn7A6PhZBA1fFrLTNRJ+90Je8TcAvxz2ULwMgzEkN9I=
X-Received: by 2002:a05:6402:1e8e:b0:5d0:8359:7a49 with SMTP id
 4fb4d7f45d1cf-5d81dc74098mr45879412a12.0.1736157155422; Mon, 06 Jan 2025
 01:52:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103185954.1236510-1-kuba@kernel.org> <20250103185954.1236510-5-kuba@kernel.org>
In-Reply-To: <20250103185954.1236510-5-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Jan 2025 10:52:24 +0100
Message-ID: <CANn89iLafXzZcdfTzGFgqdxumDweS28AZ-KoPgjcx=ZpsvNABg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/8] netdevsim: allocate rqs individually
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	dw@davidwei.uk, almasrymina@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 8:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Make nsim->rqs an array of pointers and allocate them individually
> so that we can swap them out one by one.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/netdevsim/netdev.c    | 43 ++++++++++++++++++++-----------
>  drivers/net/netdevsim/netdevsim.h |  2 +-
>  2 files changed, 29 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index a4aacd372cdd..7487697ac417 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -69,7 +69,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>         rxq =3D skb_get_queue_mapping(skb);
>         if (rxq >=3D peer_dev->num_rx_queues)
>                 rxq =3D rxq % peer_dev->num_rx_queues;

Orthogonal to your patch, but I wonder why we do not use
dev->real_num_rx_queues here.

Reviewed-by: Eric Dumazet <edumazet@google.com>

