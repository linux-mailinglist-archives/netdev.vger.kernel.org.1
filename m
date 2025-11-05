Return-Path: <netdev+bounces-236086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD3C38458
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C1C04F3B08
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6642EDD51;
	Wed,  5 Nov 2025 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByyxT8Ln"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03621E097
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383416; cv=none; b=ns4giklHuU+U8IMUxrPpud4Lze3VkM7+dkDCq0MeTT3bsdK9MVYyiDAzdB+VwLzeUZPTpXzE0MZ0Kbr01xSrOfTeXCg0Ni/93HkVKDl4SBTREXSOB8Xgf41vradS39WcMVorXkxzZtvuzf+IwWCJ6QMCChYxrqTj/EjhNLtBkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383416; c=relaxed/simple;
	bh=FTXZ5vO74QZiowktk12TLrnqOYri08BSx/eGcuuJfys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhTjyaTYYBE0iJMHkr4n+/N5/8qMo/oDwrfIZpxpp2MwBxV9Yy8pQvfs0xvhsZrCZb1pJERtXqaWxxfAnWAo3cUjY21A/dIpPFNfb6j47rZHt6Wmitjh2DKEzvbK4spSjD74zpbbNInr+QXCq2gG3EzGR8GlHOnR0+KAb8vRkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByyxT8Ln; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59434b28624so1308e87.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 14:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762383411; x=1762988211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d38bnEq+1o+YEmK6XU9ce+0ywAuUlel3clbqJSBWsEI=;
        b=ByyxT8LnU/ScdARqRGyLuooRxswKk5qWDA7/HI8soU4jR6zuj4lg8w0TaxODrb0gR+
         gdr7khoNlIbmGO0ovayt7wlHvM9XXsT2RShbUjo+WR+7k+S67AO70J0LWcgsh1OvX0WQ
         K15EemdRHCzbrvkPtD4Cm/oTcAjIKfVhCF8hUWaDCeePh+Hwqfo89PWBwkeeQHx+lS8u
         BrrkgoWdxXfbYlxiVC3ADDzyhza90GTVYuDCRux2rWS1W9WGzUXs1ygjNuEjgtKbRrSh
         Mj3GtRsv6gqCOcWlBrk2jnlqiD1J3BPLpsUkne2S2fZ6Zu9Lb90BisT+ih4mEsMzzcXt
         bHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383411; x=1762988211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d38bnEq+1o+YEmK6XU9ce+0ywAuUlel3clbqJSBWsEI=;
        b=fythe1IKVN6+SiQ8SIZkf1Y7v6GW4PGG2n7ITAOmbzpWFUJoZUplcxog4HAGUwhyS1
         8XiZIAlfrHloAn+4vVPuCs2chZh2qC78Yh0lyspXNydOjYpF/fmitRuM07xcXHqJlnNo
         rrG7XbKDzhZepx/pbyC9yDCbxqHEbNZqz7tOtx4qYwtRJJiqSUj73jnCW+xCuGregzRu
         kpkZcTXx/4C1vh/9L9G4NcjkJXPv5Ar894EZcFbcR3H0T+02MPlbIK8SsjlvZyz3ZcdU
         HXzx9yFTTmKdkN+cp1Zf9dAyerPsdBdqKU6E7ZDl60CYAaZobPLQhSbMRYUlclt/0Hif
         pxCQ==
X-Gm-Message-State: AOJu0YwC3DJon4Zq1pJ3RfMb5q+T10Pz/IQ0W/VMtUuXc7CLwSgE3e49
	eYRL6isBSGbJRmlDwpBYDjd3js8YTgNsheJD//ePpqtlc6yke7grxHQwvxgARQitC0qtbEezVAH
	lKo8ABukj93rd2+ZqVLkOKTsIsmzzcwXaSgSWFVqA
X-Gm-Gg: ASbGncs0IimGVa0VkHEDXcbt3kZe1uMMovikzYxAQYDWg0Rj5Ef6XL3mBO+nctOHW2+
	xNuIWQ9RJF1Q2ClTksKkh5/GSyrAfeec1SYtDms0FPAV6zQj1f9wM6YM8pojEVuHpQdmg+HeY02
	81rwZyrftflLYrm1l2P7hB2c603IPlH9YvSIgEao2m6UonO6h/ljTGgtMM5tjMKgKOP1WLT6Upc
	kqX8OVQO90j0s3VEGTaZsPlf2SC6AEv80oO31wJ6bfYFnMubYWUSBm2MwmimWWI05H3xWZPA5Jk
	RE8xBj8O5BNMfE0=
X-Google-Smtp-Source: AGHT+IELG+HICsMAz5WYIIataT/mL9Fv7C1S8sUPq6saB0SfJBmqQbRUMs7vinFwj3opyitCVZtQCnjbw4I926TKdPY=
X-Received: by 2002:a05:6512:64:b0:594:4116:8dcb with SMTP id
 2adb3069b0e04-5944c81d104mr38713e87.3.1762383411288; Wed, 05 Nov 2025
 14:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com> <1a07e27f-69de-4a38-884a-5ad078e7acf5@kernel.org>
In-Reply-To: <1a07e27f-69de-4a38-884a-5ad078e7acf5@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 14:56:39 -0800
X-Gm-Features: AWmQ_blqlcUxGwWGO3wIa-GDL3sDQYUwtR_l1Dra-FSHUPTxILlqtmtqPNFP9n8
Message-ID: <CAHS8izM+sPsaB7iVbNu7DEu9qH-89c_XDdMM=SpWFT3Ywq6k3g@mail.gmail.com>
Subject: Re: [PATCH net v1 1/2] page_pool: expose max page pool ring size
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 1:56=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/type=
s.h
> > index 1509a536cb85..5edba3122b10 100644
> > --- a/include/net/page_pool/types.h
> > +++ b/include/net/page_pool/types.h
> > @@ -58,6 +58,8 @@ struct pp_alloc_cache {
> >       netmem_ref cache[PP_ALLOC_CACHE_SIZE];
> >   };
> >
> > +#define PAGE_POOL_MAX_RING_SIZE 16384
> > +
>
> IIRC this was recently reduced to 16384 (from 32K), do you have a
> use-case for higher limits?
>

Yes, I noticed that. Increasing to 16384 resolved my issue, so I did
not feel the need to revert back to 32K.

We're expanding testing more and more and I may run into another issue
that asks that I re-increase the limit (maybe with a check that it's
indeed a ZC configuration, so no extra memory will be pinned), but for
now I did not find a justification for that.

--=20
Thanks,
Mina

