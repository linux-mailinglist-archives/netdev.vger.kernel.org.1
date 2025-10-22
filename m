Return-Path: <netdev+bounces-231916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09472BFE9CC
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFD619A070A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 23:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC0277CA8;
	Wed, 22 Oct 2025 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFLLzFxw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804A2E6CDA
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177227; cv=none; b=U7TWH8byl2LaWJ4voZnZdG7G0S6F5SBWw+h90EAQKdUdByJiSyScB/gUgnJC4QWEaCHyOGZH7Sojtww2y3x3YNop2eVC8xD2e3XidCOF9QogklsbbzFHgTvUjAyyvu8hY/9OH9FCz37JPjTZd2wbRI7Q/zaL4HrOPnODwVDpVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177227; c=relaxed/simple;
	bh=r6cA3yKrCQltGwHLzoG/Vep91Wo6UicTBRXqUsQMN64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJCbDO34XLMTfdedFmdt03IgdFlH0IMtpArchqLhZ0cuhgkHkrrOvFM8yl1Y4pf8Rryz3TTlAasko/KuD1BOq9dOq6KRlRmmG75HUP9aAoPaYg1EWYRgm3t1lb5tPVcCPuzNYrh/t/HC5hVrsYy5IX8I3Bn0dR8VfzyWX1OxLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFLLzFxw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-269639879c3so1444605ad.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 16:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761177226; x=1761782026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IPmMkl2zSB8WQOl4v4X+gU+jOB05bhe8pbNfirMWTAU=;
        b=IFLLzFxw81+VrjMkqoZ+JwS832vUcwgutYlKGOk9vJhIolTHlib3ICSji8jJyopQjS
         rRxhhrf4DdZKldexH9hqLFOVmgxmbhNEFlP4GbyUDmcg7ihw+5EogsKgdUjuR/N2PMC2
         XiutNK9JaYvef67SJCH6h2k2NGsa4vB3lytiXWU7j/VciDLvsb8Cr4yJXNUZK5OUjoF7
         gNvRySXTzJavanSHdaOleVpg3+9iFH7Lt9PZmbJ8Enu/9IuLaBcbtsp7koGVBrvhL4n7
         ckGgMR0GZ8+BCeL8n0hy6hy38dbSOfLcBN3T6sSnivzMvenaRftEXz7o52IV/3yMcmXN
         mLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177226; x=1761782026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPmMkl2zSB8WQOl4v4X+gU+jOB05bhe8pbNfirMWTAU=;
        b=ANG5xAvmhIZ2cSt8EUo3F19ZbYLiYdSDQ1iG2OKZ40ZZGMvq1eRm4hkGGq+wMePfMB
         8XWuviLnktykWTW5/dq04+3ux0j3ZxvFjrEFHURc1kArkYpUi4zQUqsjtN3PpPbZ+mN1
         TixlDW2vbCCZMsFJTFc8gnHTzN9Z+EPXIZiMdMktafEl2aAa8RzNh9Y7CdpKg79HOeR7
         RpqcS0o3kW0DDhuDmb3hRTBXmZLtNAEkINKWza+xfLYLFHqi2XDm/ykhzWnsvbWXpWLJ
         0adgcRbrCpMtmwi9uDMLwW+s5RXTNlp74ZgAoZ2cyodQhWttZBSQ1NHeDPP/i26pAUsZ
         rB1A==
X-Gm-Message-State: AOJu0YzgxhQ3mcKJbCoIRgnZETi/+VOAO5SdzIeqckwsXMZcc+7j+8kw
	jzHfWHRpHmjVAr96CL+QGGdHm/vqdir9WA1ClXRCZaYLI1QkcgjSIJJUDjLUNIZP0XnhZgsvxQx
	oZDrTQ5wsT8jjQGULpcaABNfsgu4fKsxPV2ob
X-Gm-Gg: ASbGncsQaoIwMjWl6APE69M1YbW4rnjIh4QtZy635EsQuRGtElaZJ9PoQjIshp5/rf6
	uTWiet/Acv0rgr7WNtL6bv49whPESVcqeLXIw9SDg0GwipRBQ9ueVBj+qoI65iuyXLODKErVL/s
	gydXQFUHYS5PLku0Mmg+HMsrcPRu+6HdCZJjFO/NiwSjeS2qtV48IPDeeCbyMQj+Zm4iUraP/zW
	EEz4CEZCW4EVVE64mOJbDVmGITNY1w8uyAN4mY66HSaMtRHitbGv5JTKuT0M6BFBabRwhicJ76i
	Y0mcepIRcLpmBR/mJeRgEqdhCpUOS0Cgw9tFWUraEiheHTenrs3Rt1e82mKBJRansc4N3TnUycL
	Q+vT7YRpgKUS1kfZ6nUQa/aCTMA==
X-Google-Smtp-Source: AGHT+IFf47PZk/svwArUCpqGxhWAtssHhzPaQPTlep3i5NihxIbBJCQEqktFe3RM7hxAzfyggDl9RyhSfzrG08pz1vs=
X-Received: by 2002:a17:903:19e5:b0:265:89c:251b with SMTP id
 d9443c01a7336-290caf8519dmr305227015ad.29.1761177225791; Wed, 22 Oct 2025
 16:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022221209.19716-1-ebiggers@kernel.org>
In-Reply-To: <20251022221209.19716-1-ebiggers@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 23 Oct 2025 00:53:34 +0100
X-Gm-Features: AS18NWCnf9yflT9pRCWaROMTaeZ4T_33Gc0YIvslEerxrOl3Hw1YfsTkfp4474o
Message-ID: <CAJwJo6bXoFN4k5Y58Uz4NiaBs1EuvZQ0EQsjOrH_bKkGQJp2KA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Remove unnecessary null check in tcp_inbound_md5_hash()
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 23:12, Eric Biggers <ebiggers@kernel.org> wrote:
>
> The 'if (!key && hash_location)' check in tcp_inbound_md5_hash() implies
> that hash_location might be null.  However, later code in the function
> dereferences hash_location anyway, without checking for null first.
> Fortunately, there is no real bug, since tcp_inbound_md5_hash() is
> called only with non-null values of hash_location.
>
> Therefore, remove the unnecessary and misleading null check of
> hash_location.  This silences a Smatch static checker warning
> (https://lore.kernel.org/netdev/aPi4b6aWBbBR52P1@stanley.mountain/)
>
> Also fix the related comment at the beginning of the function.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Yeah, I think it's a left-over from the time when there was only
TCP-MD5 support.

Thanks for cleaning this up,
             Dmitry

