Return-Path: <netdev+bounces-84564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519A689753C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511A61C25CD6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3455150982;
	Wed,  3 Apr 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OuX/YlS6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B444139585
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161805; cv=none; b=PFEt5J+WmOFZ9lDjwpnIEDZYMmyCdDX09CfIjgM650NzXYaFrdquCty4+pM1nX6vUT17HtAvYAT2GrSXCGQbbxXzQbdTpLed1m5Je4dZbc7eVKGmG4Nbhg6uK8mtHllh4tvaltHsWjIddyPu+/HSSUoUAcvjsD46apmjsgA2hJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161805; c=relaxed/simple;
	bh=euAFO8Clw3pP5qIbVAUGnUfJ30fBuMGE4BnruenTn1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PW3f6Hcnqc218evMu3oBd9XUh9HcHAKTjJLc0jS1ZJ1AkjrtW/p9n3Rry8EvcJ0inKXBCr+bbemB+bvUtDO3rB86HIp2HgcGf3TwduK1U3j6ff7kV5a+pXzGdle2b3mVfBp02jyumMIDcVW8x0L4b6RnOfITZsvpMlOePRp7vZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OuX/YlS6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56dec96530bso51a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712161802; x=1712766602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euAFO8Clw3pP5qIbVAUGnUfJ30fBuMGE4BnruenTn1M=;
        b=OuX/YlS6hFRVamHfsUEQxVkL8OipuVmE8x2/toE+hvMPLuWAjoeKOnLP7x/V4SdR2j
         /mThhrmUkLcy7ARb/cikquMaskrv3fk4Dy+JUtK0R6WvAtRK3EOqPI/Mo13DtaScrgrW
         rHjQxAUBvawDCcr/tylL0xGkFtn2+y8Y9Njnhdbo4VbdtpSabUjWRfxGUEBxqV4FA6T2
         k8cs8UUdQTlpJAgwqhjhT57MLtWIGU+B9BkXumK1uWCp1y93FK6zHVVnnyYj4ebVWurL
         gDkjeUfQPvLKMz4XujD6NwTVUZ8PXp/YTr+d5vrkkIpPpRWjF9P5w6rbSW75VHBfj75N
         hH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712161802; x=1712766602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euAFO8Clw3pP5qIbVAUGnUfJ30fBuMGE4BnruenTn1M=;
        b=cwPS7hoScxtyQnhEDdsuEUgP93goqgQr4VYH6iV65pbsv5rgN1w2RP8BX0MbmjPLoh
         dnhwia71pJCImuJcZFek2mMC5AnmgbTCVF6KyjsotWsagynjYu0Hf3S7lekUWbVlAV3U
         k25Yr+2dvPNsYtoMQ1J67M8Le0dQ1falyfXrXByfOo3OUk0L/UahJJeFQ/Lkz0sxOp5D
         kMghxQliVDtdudxdr/JnFuNFZVvmFTxc/r2Es+r1G/ewjGNVjiiPJrcoaFIamo22Lgzu
         xL1Qy17sg5LV0lc2IonJTA3dXljBLqIz4TtsFqRp95WWZDLnz5P90k17XrbfqkVUgj9e
         6a1Q==
X-Gm-Message-State: AOJu0YyqYA8TUawOyrEkEHlOW+S1fSZPRd18QIPlx3e7KEW5kdr9F8cS
	mzahr3hKB3+iiK0o/Ky2y6yckyRcNMndjLthT4gdAuCyvOIaxL0/fg/0pxGfc7YWfRqw7W+k7f/
	4lz6dYSYhKllAwm5Y8zxDwsaoC5H7yVfknH6TTXEN9erT2/Rk5g==
X-Google-Smtp-Source: AGHT+IEdTYNLl3lph2QKQnGHmuW7zrGgUGa3PMyy86dc1vzA0Cv5mhOyz+7L5WrG3+kBN6Pb5mRVv2h2QvEzuPHul8Y=
X-Received: by 2002:a05:6402:1289:b0:56d:ecf2:2a14 with SMTP id
 w9-20020a056402128900b0056decf22a14mr246927edv.0.1712161802179; Wed, 03 Apr
 2024 09:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403152844.4061814-1-almasrymina@google.com> <20240403152844.4061814-4-almasrymina@google.com>
In-Reply-To: <20240403152844.4061814-4-almasrymina@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Apr 2024 18:29:51 +0200
Message-ID: <CANn89iKDCjgn1QZv3N9Qem5E+4GxWc=xB0OE=9jc+8-ceRP-BQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] net: remove napi_frag_unref
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, 
	=?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Florian Westphal <fw@strlen.de>, David Howells <dhowells@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:28=E2=80=AFPM Mina Almasry <almasrymina@google.com=
> wrote:
>
> With the changes in the last patches, napi_frag_unref() is now
> reduandant. Remove it and use skb_page_unref directly.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

