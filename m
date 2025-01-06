Return-Path: <netdev+bounces-155386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2659AA020E2
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61013A3A9C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F661D88AD;
	Mon,  6 Jan 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dXwS/SFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D91D935A
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152542; cv=none; b=QLpvREezkY8jCOJwn3UuFRArVlW7G6xdg9WoJdeeQzPtlrScsJnIhUEQOK5zGRL5BU5xPI1H01jZo++/aWFxl9fNZi2ce5resTWn6/E5Z03oinreUll6m2pVW5QPenxOxsXlOZNW6KRrEXZoxc4UhfR/yEmxWG/9gw+uTl19eyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152542; c=relaxed/simple;
	bh=CibIDh+L+jOA2+Tg5JLcI9IcKwtYDe7zwarfrr1A3mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA/FkHnVjcPb6UMMt4bBpId81D2tqrVl7Ur/yLkgBSpD+zVke9M0sa3kSJCwkHOJBMkOgkvJsnQ7mppsS5cjLZYsPvTxy50R+SXdcUmg7VGOJaa6UVjA2uPPlmCbxhNTieAL994RtJyF3hcvErxvR/IbE3OHJt6xck+gJftH99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dXwS/SFF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so587325a12.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 00:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736152539; x=1736757339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neFF+VG862sTZO2javrQmM9vKH+gtglUTxoHiigYK3U=;
        b=dXwS/SFF9ECKKOe1YyciGcsFDP91K+MfnDCiSMcwgNS3VcyDHXCIBEY3a9dZXovXQD
         QRQF6DdtBVkrVhSLMNzxudoGOnSxsoYjR6YsRQP1vnCJ9USVdzbWDuQ5rSpjP0CM/ZhM
         q1ZYt2ELCdp+0xE0SKJg35rlXTDLiXFxs3J14JGWD+Tp+MLhg03fE6Uiyw1EPYxMy14G
         nEcFKFjJcih0/blZeNmlJrkqfGZ74tUkmnit9Kw35Zg8r6Gcsub+IxNkDOnzXeeR0R2g
         r+yrttrPc1VYOX4/E74gqOIyvO8owXfjdpIS58nnzrsdn/NcCqU8Djp+D8GDYGtag7Qg
         EoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736152539; x=1736757339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neFF+VG862sTZO2javrQmM9vKH+gtglUTxoHiigYK3U=;
        b=D+RYM7FIomcNAXEur9HXJgAJNKd7hCBlt1Aim/T1O64RscSGvGVbvmUgQNumMyYZfT
         i+zPR5OHq84pACYPCBpRPtybihEpeB9SMC319z90+U6WbxdhEwM5qSdihp7QGpwfgECa
         jLBevY7JR6dhFJk5lW+xhXtA5s4FnH/fO6fyL/JWOQP0STRXYM759V0pHWJuF9EduvXI
         +plBcQItn052UQ8xKmo+GgW+HZNyCa1X0KeI/4Tp38U5eFVETnwuIkKngy33GeT90GWG
         1BVy5ud+/KPHURKikqHWSCrzQ+PIe0L+G8UnASxaYpThe4hWLvysPF/G01dquEhprVQ0
         vCfg==
X-Forwarded-Encrypted: i=1; AJvYcCUX7PXqNBqJSA0tuV7Yy57+wnHsgPxkqfOpSadCL3VBJEGueuBta5I7FWmV3ceAw/0kmtpIlNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEncOUxp1qYwZX9PcRVAaYqZIWuWMDdJ8iqU4MEP37Y9zIEqV1
	/9pdHj3NN6MTZ5qChlnCaVPUeK8AK/nlqepyh7xYBd96xReKUxg3C4+u/7BD9Vy3Gj8kjvPu5Yl
	dPh4v2kVrY2AKg4R8iqrILVOnhyBlm2yXPpG+
X-Gm-Gg: ASbGncu1OpL4/zqDjjN0K99dH7Pn6plbWRAeuOpFJFRw/xXxpkkcSlVLWsaPxqpIz0m
	bbFOHIYOevWYbBwaPt23Osn4F5E6KZsoifFhbMg==
X-Google-Smtp-Source: AGHT+IH0VLSIxBPcoxhU+YblrrqpTJDjIWA7ZasDvk5U9423z7LvLQgWXdT0vGWBz05S9alQF2WSgjEgZAVZl3GefiE=
X-Received: by 2002:a05:6402:26c5:b0:5d1:f009:925e with SMTP id
 4fb4d7f45d1cf-5d81ddad8edmr56636771a12.16.1736152539089; Mon, 06 Jan 2025
 00:35:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106081457.1447130-1-yuyanghuang@google.com>
In-Reply-To: <20250106081457.1447130-1-yuyanghuang@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Jan 2025 09:35:28 +0100
Message-ID: <CANn89i+wHj5NaCcXs74TPC8nBz95fEBMLZ1Pg5F68kwrWkO_fA@mail.gmail.com>
Subject: Re: [PATCH net-next, v2] netlink: add IPv6 anycast join/leave notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 9:15=E2=80=AFAM Yuyang Huang <yuyanghuang@google.com=
> wrote:
>
> This change introduces a mechanism for notifying userspace
> applications about changes to IPv6 anycast addresses via netlink. It
> includes:
>
> * Addition and deletion of IPv6 anycast addresses are reported using
>   RTM_NEWANYCAST and RTM_DELANYCAST.
> * A new netlink group (RTNLGRP_IPV6_ACADDR) for subscribing to these
>   notifications.
>
> This enables user space applications(e.g. ip monitor) to efficiently
> track anycast addresses through netlink messages, improving metrics
> collection and system monitoring. It also unlocks the potential for
> advanced anycast management in user space, such as hardware offload
> control and fine grained network control.
>
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

