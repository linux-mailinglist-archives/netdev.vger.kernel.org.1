Return-Path: <netdev+bounces-89457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D278AA4E5
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 23:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043AE281D83
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B67E194C8E;
	Thu, 18 Apr 2024 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="japJKBXa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84917165C
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477355; cv=none; b=oCFREVNKMrjjdqVuEsHVeBykUzMWL1HxpXgqy7OhNQP6L0m7W/AOp6cL5Qv9/ddqkg0PrK3gQusCwLzZ90bttmbXOqb2k8e46jPkk7muXQirSMo6RD6rJRm1g1TWHGCWbApvQrKqxXnRcPDOppuXDZBfWNloqAW19P6bav23naU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477355; c=relaxed/simple;
	bh=ItdsySbV0lPybW5ztcQmHxXAn7VWI0ub5D98gTkJSrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scwac4hZbR13tz4Zs1xcIDLqFSuGMbLDFh5HNBNkF3nRoSg6IDVWrlVOg1RLHYdPgBRn/RoYrw+bqpT1KoLCYFmD+wBG3AGu0ZJYo7XxRXAffTy4VFeHxSLyllaiAsUbLFaUwiH1xymlma9000zP4L2tuV2+vY7872wNDPxZxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=japJKBXa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5200afe39eso143600166b.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713477352; x=1714082152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhV9GZMkSACj2lrmvXlmANpvznzdOQX9qo4uUDwMcoo=;
        b=japJKBXa+86zn7Yox1yXmrC6SiG77Ur6tBImrbesmSSIYIVZRzoJRGcbTsTyCGXwGa
         oSSW+VcDO4DQWn/MmVxuzfz6omK/Bf/70h2JITUWFhPEglgzcLh8LAwpRzG600riuJKP
         JjFMMf1HjQmMKkkdL+IzdaqZ4fhgB+Mdu8DY3zD9r8eh7sSqwXw5WhDvSCnAJZZffnTA
         WjbISvGF0+nIk4r7V9DORCJTjxA5HLqTaUgPCkLvpKOGkVAHrhAwc+W+vbZnr694i9El
         WgHnBZABa+itL0nl8rr5qMLIsMMg6W3JXiLTpAFBo9JHnhneiBcYRJl24u+MTbVqYQza
         fRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477352; x=1714082152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhV9GZMkSACj2lrmvXlmANpvznzdOQX9qo4uUDwMcoo=;
        b=Mjzl9+XsUzdJdcBmXooiEIcXsf6va4AmT1UCcwGGG7rYIccA65aV4rs/7Iy8xUxgSl
         RxnV8Fa28qlVjnWiQN6pZg6EJMIy+PlTjxoGX2Zdb3X5TuLHpj4ihsoa7h1f+iyvXAs/
         LaxxA9+v49bgA1GPUBITap5Y2BUAnqIo1/jB4LQoElea5KUFtCmGBS8iQH2RnOb7xrYN
         a47Sy7tJVjs3/ywi6i2rT3bQ7ewSsF1Y89lTYP4yRHl6Cuk2+SYxGPedVRptfDzN53h3
         WbO4AgW91QrOv91i+3m9NPmwM3LzwRHwpnxOzpkjbxxjBwygb9+BW9mo95WtUP/VknnC
         E+eA==
X-Gm-Message-State: AOJu0YwETyWZnLWK8/NY/zX3o4SEEimS2a4Tv/iV+SncdzueLlnuiiZ2
	G5578LzPh0z4dN4TMU18e0A/tPm4/Loxp87d7s3mlR1Cis7dxO+Gfmr39hNmar/IS/mlFJLfpR/
	E1ywHRd5Qk42JiPGi3N2zmNYDDhpfKoaPc9kA
X-Google-Smtp-Source: AGHT+IEgrqMzseXhuE1MFm7bRhPgecioSbcNLqvI1E74oTaOIZRKUvvE8AzUbaF/fSmiiG/TIsE2tZHqipsLB+fVIJ0=
X-Received: by 2002:a17:906:1e0a:b0:a52:28f:5e61 with SMTP id
 g10-20020a1709061e0a00b00a52028f5e61mr255944ejj.27.1713477351449; Thu, 18 Apr
 2024 14:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com>
In-Reply-To: <20240418195159.3461151-1-shailend@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 18 Apr 2024 14:55:36 -0700
Message-ID: <CAHS8izPncB9T7xAU4gOcM5Hx1+HUCU88KcJPeSO7ObCCfcLdbg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/9] gve: Implement netdev queue api
To: Shailend Chand <shailend@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:52=E2=80=AFPM Shailend Chand <shailend@google.co=
m> wrote:
>
> Following the discussion on
> https://patchwork.kernel.org/project/linux-media/patch/20240305020153.278=
7423-2-almasrymina@google.com/,
> the queue api defined by Mina is implemented for gve.
>
> The first patch is just Mina's introduction of the api. The rest of the
> patches make surgical changes in gve to enable it to work correctly with
> only a subset of queues present (thus far it had assumed that either all
> queues are up or all are down). The final patch has the api
> implementation.
>

I applied the series locally and tested it with devmem TCP. All my
tests pass. You can add to the individual patches:

Tested-by: Mina Almasry <almasrymina@google.com>

> Mina Almasry (1):
>   queue_api: define queue api
>
> Shailend Chand (8):
>   gve: Make the RX free queue funcs idempotent
>   gve: Add adminq funcs to add/remove a single Rx queue
>   gve: Make gve_turn(up|down) ignore stopped queues
>   gve: Make gve_turnup work for nonempty queues
>   gve: Avoid rescheduling napi if on wrong cpu
>   gve: Reset Rx ring state in the ring-stop funcs
>   gve: Account for stopped queues when reading NIC stats
>   gve: Implement queue api
>
>  drivers/net/ethernet/google/gve/gve.h         |   7 +
>  drivers/net/ethernet/google/gve/gve_adminq.c  |  79 +++++--
>  drivers/net/ethernet/google/gve/gve_adminq.h  |   2 +
>  drivers/net/ethernet/google/gve/gve_dqo.h     |   6 +
>  drivers/net/ethernet/google/gve/gve_ethtool.c |  13 +-
>  drivers/net/ethernet/google/gve/gve_main.c    | 200 +++++++++++++++++-
>  drivers/net/ethernet/google/gve/gve_rx.c      |  89 +++++---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 114 +++++++---
>  include/linux/netdevice.h                     |   3 +
>  include/net/netdev_queues.h                   |  27 +++
>  10 files changed, 459 insertions(+), 81 deletions(-)
>
> --
> 2.44.0.769.g3c40516874-goog
>


--=20
Thanks,
Mina

