Return-Path: <netdev+bounces-141910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA289BCA20
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94033284050
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866A31CCB46;
	Tue,  5 Nov 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIn4Pfvr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DD18BC21
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801803; cv=none; b=Rf5W0gtGAHBSUYpvpqDCRFk6a9yuvGFHKyfnqq0JdE5Q46dzCXOhR/CNe2N0gkTYPQDiTYnGNNobb02YtD7dQbI5XfIsbB8ucncu7/WTwamYaDgtPZkAlSf98r1glh20XtqAvQ++3Y0xwesK4tHDc79AlFrsLSB0gYKEKrcp5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801803; c=relaxed/simple;
	bh=jXZnn9CDQr5QdRFYqn8JotIwjw6mt9QZm/drQ1Fws5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wvs7Xb4Th8HCHkXeftsfJ42y26sjwS98KWoDxMzh0bbrzt0nS5g660eAm+DEuw3cl38rgA8iUGNPwD8DEAnx1w2YMTUSXzH28KTke6P8FoRr3pJIWcUVzDgroTue0L4Cl2zR6hAYusH90vnhHUcUN7DjkuXRpB6rA6OlAUwaIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIn4Pfvr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cedea84d77so1948738a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730801799; x=1731406599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXZnn9CDQr5QdRFYqn8JotIwjw6mt9QZm/drQ1Fws5g=;
        b=BIn4PfvrtVBhvom/8k31tTuLDGqDIpPdYHj3o+HHfCIhPd4mgTrnv75SHuFSKX8yBD
         wdOwnvWD7Dyr0kxRIL5GDwKGsKisNSScfpg4agkVIS49oRACLhTYpDUOkkonCLercKPl
         s1Y7KHew4PW2uznmcFk7ZiA+hmuZR8wiw7WMosNqJZJPKTQK+K4g4x6wcQloErtnMez+
         pTAXMMQebcO2ZINMQPRH6QiCcNnvvLQQVeuPBsXmAbzh/jDIIm92aBoujA98soLaZ2M3
         bhrmbapQ/fqhG2/GbYLlqGnTLs1p39YbiQ5GKSkHAJ9VNShW0JqnrHfpgaIqJHM30dbf
         BdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730801799; x=1731406599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXZnn9CDQr5QdRFYqn8JotIwjw6mt9QZm/drQ1Fws5g=;
        b=mi/jZeXq5yb801jfjqQss+J+R5dQFjN4cn0msJj2o23Q4fbOu9fr6VHtAixdRijkWC
         eQ1OG6wSE0iv3mzu8XEmqoL1pNW6kY4kwxJ9nJMLZg9NN0rffVhHd9kDvNhzzYZC98yk
         SVB8Dus4kQdZaGHYovgMjWtKjVM8STqRWj2OPAQcV7KXhrLJB6P1BU7FjeOBLOGkKjjF
         OCMaPA0rZBN1nbMEt5S/t1/TFrMTyUMDCeLCtGtZkg50/X5PBSKC7dMGsp5A4gz1OGq5
         DzdeC2toMBegvRc5rsYQ6hM9O0EYVJqeOgAioHpCI4FxEFRFE3gRsgsTIHX0Ah/pwZ02
         Wxwg==
X-Forwarded-Encrypted: i=1; AJvYcCXpUTH5BcNw42+njTlVb26VrEDn5JLMgOK1bS2h1QPdRZYvK24PwqO7Ya9sCTSwfgD+QoPvBuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvCPKgBzFiMHTHl4TtlJEbE8mjKuOVq3yCCl69OztA/dr9Su7O
	opqF+/6tSJRDH4y2b6BOMmoEFONapXw5Ow7qRiAvfTWhOw3eEY06tA0Rbxv4lhVSfLeoga4DAgO
	deW+MANvmokA6nGzpyc1Od6+Ur67bH3dWWlmm
X-Google-Smtp-Source: AGHT+IE1C6CsjxFtXMrEsU2VJdgboxjwyVCyTBTM5sw8vvVyUQI5q17QWSx1gPUjf5trFtccOYqpOG/SQJa4ohQ8wgY=
X-Received: by 2002:a05:6402:358a:b0:5ce:dead:1f1 with SMTP id
 4fb4d7f45d1cf-5cedead02c2mr3613722a12.11.1730801799034; Tue, 05 Nov 2024
 02:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105020514.41963-1-kuniyu@amazon.com> <20241105020514.41963-2-kuniyu@amazon.com>
In-Reply-To: <20241105020514.41963-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 11:16:27 +0100
Message-ID: <CANn89iJX+Z81vsx5=mbWN_gGDuzQ2e8W51NQic1Gg-kgjcO_tQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/8] rtnetlink: Introduce struct rtnl_nets and helpers.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:05=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> rtnl_newlink() needs to hold 3 per-netns RTNL: 2 for a new device
> and 1 for its peer.
>
> We will add rtnl_nets_lock() later, which performs the nested locking
> based on struct rtnl_nets, which has an array of struct net pointers.
>
> rtnl_nets_add() adds a net pointer to the array and sorts it so that
> rtnl_nets_lock() can simply acquire per-netns RTNL from array[0] to [2].
>
> Before calling rtnl_nets_add(), get_net() must be called for the net,
> and rtnl_nets_destroy() will call put_net() for each.
>
> Let's apply the helpers to rtnl_newlink().
>
> When CONFIG_DEBUG_NET_SMALL_RTNL is disabled, we do not call
> rtnl_net_lock() thus do not care about the array order, so
> rtnl_net_cmp_locks() returns -1 so that the loop in rtnl_nets_add()
> can be optimised to NOP.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

