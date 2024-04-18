Return-Path: <netdev+bounces-88961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C338A9185
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 05:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2E11F21A8E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771AD4F889;
	Thu, 18 Apr 2024 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDfYhDcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9779286AF
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713410619; cv=none; b=r76wob5TljG9HrIs5gHhFXDnctoLukXuBrp1IKkP4qwtOX/h9WVqhyvm/CeX3aZBtRdBXV3hJD85funpHZ42F199UIJejYaxEPqZLzqDNoQlY16VSq92yjC+mzA3RH+5QmKGf7BkhnnIloExEREuyebXlQSfyNqjxrLPzgq/9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713410619; c=relaxed/simple;
	bh=OcnbWGomO62dM9Er3ij/a6hEtQYmsCnNfKF64S3mWDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhPX0Cq7GLpbKkOZfVIi9/g68UsfWK/MAH3hC9x+f1Zp866cul3v/fyBnPeR67YgUREHIA4P6j5PAFPk1L8Ef+1A2VlDUX9LvbckcqHSv/xWlm81WYuLLTb78RFTga548NbHjexbWBT9vfoBYmp0GM/O7nh75Nw3wu8S8auYkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDfYhDcz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5200202c1bso35949466b.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 20:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713410616; x=1714015416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF+YojIpju8aS7DHdqfwp0nimPHsJ8xQMAGlru6uSsI=;
        b=YDfYhDczMQM1/tUl2VHcusE8mtfjp23cy7ac1wAb9rviTWAUmKLfjmLg1UMgebQB9S
         H6U956jwCLyBz04LXSGq+RGAfzQDVzkwpDfi4etbpjDHglGCgsOB/efNZI3K1JNgAveI
         yu1nIPrLaMgvh8x5Hb3bpD7pWsyjq76bL5/yo5XlONqbHGrGFiIVN0bEJIJ5ZerhyNgN
         wzUwQgtE+gXXmEO2Q3mvqj2WBYFFx7Yk1nfbk4ZfxrIY09L1ewQvu+x8Al8gzyQYWss+
         4zRuf8Hg5ZVFyssJbMOnrFGavw4WywxBdiX/rNUyJpVB4KPKyxh2sLCHkyeTmd15Iyxy
         syag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713410616; x=1714015416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF+YojIpju8aS7DHdqfwp0nimPHsJ8xQMAGlru6uSsI=;
        b=Aqi0Na5uiQf/PNsgNHwTaDfm4MfENj4iiKY16ARVm6x1qdvRSj30nPlMNPWl1TtuoF
         MvOV3pdyLkaqXwGw/ugUW7/Dx+/brpzIjdML894iwVQj6eJyzhqC9060Gd2uU80EUESX
         bZHeBiFuuMN0vBpkVRA5YjhnIye+6aS9qWF3O5hEYeR4ZVWNIbh1NpWwih40zmjzJMry
         DgImHdezyWI973eIFgs+tpCKx0b1+JhUxpu2Fizj5Td+iQ9nSKWhVqx8dhfcIKtJYiEk
         TP29+irVN48q6m9JOTKT2vRuF3yGxLNvS7kJjRcYjocvPnvnzod2CarN0G4cC56425jX
         oZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBF7mJmNom4kW3J+crYUsAEUYWL6Fjl3ok8dQ77ZOvRGfazIAE9cmzzgUKSHYTQXSV+gMd4OymmwV2Q++48U7DHUiZx9gA
X-Gm-Message-State: AOJu0YyS71YGwzTsJMihnPmiYWJERlmONCesL8I5C+mXFwxt1YJExQ7S
	CxN6FZnxNzArqd+8NjWiErQOjAA3m7Oy9Xp3B6FbNz1+wYjlJSgJy5nkswgH+jTvBsCRz42EzYq
	81vJbD3HwaRz6IdIX7dSnvhkr1Tc=
X-Google-Smtp-Source: AGHT+IH6v0+Gh4lN176js7QRMzXti373vrdJ5ojljCKSyppoR3/sWo3ogfbb5PhzY04bhA4C+jJEdaF5D+oSQaikXaU=
X-Received: by 2002:a17:906:26cb:b0:a55:621d:d961 with SMTP id
 u11-20020a17090626cb00b00a55621dd961mr1234847ejc.0.1713410615741; Wed, 17 Apr
 2024 20:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-2-edumazet@google.com>
In-Reply-To: <20240417165756.2531620-2-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 18 Apr 2024 11:22:58 +0800
Message-ID: <CAL+tcoB0SzgtG-3mAYrG6ROGbK2HwqXCTo21-0FxfOzKQc397A@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:59=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Blamed commit claimed in its changelog that the new functionality
> was guarded by IP_RECVERR/IPV6_RECVERR :
>
>     Note that applications need to set IP_RECVERR/IPV6_RECVERR option to
>     enable this feature, and that the error message is only queued
>     while in SYN_SNT state.
>
> This was true only for IPv6, because ipv6_icmp_error() has
> the following check:
>
> if (!inet6_test_bit(RECVERR6, sk))
>     return;
>
> Other callers check IP_RECVERR by themselves, it is unclear
> if we could factorize these checks in ip_icmp_error()
>
> For stable backports, I chose to add the missing check in tcp_v4_err()
>
> We think this missing check was the root cause for commit
> 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving
> some ICMP") breakage, leading to a revert.
>
> Many thanks to Dragos Tatulea for conducting the investigations.
>
> As Jakub said :
>
>     The suspicion is that SSH sees the ICMP report on the socket error qu=
eue
>     and tries to connect() again, but due to the patch the socket isn't
>     disconnected, so it gets EALREADY, and throws its hands up...
>
>     The error bubbles up to Vagrant which also becomes unhappy.
>
>     Can we skip the call to ip_icmp_error() for non-fatal ICMP errors?
>
> Fixes: 45af29ca761c ("tcp: allow traceroute -Mtcp for unpriv users")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> Cc: Dragos Tatulea <dtatulea@nvidia.com>
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Shachar Kagan <skagan@nvidia.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

I wonder if we're supposed to move this check into ip_icmp_error()
like ipv6_icmp_error() does, because I notice one caller
rxrpc_encap_err_rcv() without checking RECVERR  bit reuses the ICMP
error logic which is introduced in commit b6c66c4324e7 ("rxrpc: Use
the core ICMP/ICMP6 parsers'')?

Or should it be a follow-up patch (moving it inside of
ip_icmp_error()) to handle the rxrpc case and also prevent future
misuse for other people?

Thanks,
Jason

