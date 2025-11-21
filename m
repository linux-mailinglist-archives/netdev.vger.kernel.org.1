Return-Path: <netdev+bounces-240899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9DC7BEBD
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 00:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2690366E94
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 23:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CA8310629;
	Fri, 21 Nov 2025 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfy3Mwfe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C962D8762
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766613; cv=none; b=ZaB0v+QqkgkXzFP/7jDNdNBt4LgaXPm0IPD4TkyeYcePbYL1jdVq6yQEbOYKv4bsgHB8eTTYb89rMJg3b2EXLIWHjioZ6HbLgKLv6I+aPlZzIaFJPmRBQAWq2SgZtwtbeAcUfVjtFl4vKz/hrbrtV2gNtkwoXpF8hMtdrZJl2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766613; c=relaxed/simple;
	bh=VdHSOcTtxGxUrX1sBmgMTtbKzqAZgA48oaPuJfmSDVo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WbVuzLAJMbl9kI2eeYhjtczraIbLL48d8JCNn0znbMiHilQqGHvlI5c1pYRf2n/1BcCmJ9Dxw0UfPR+SYXjuNg9288kT3uhWG73uOcX7BtDWEDp1SFueQplHIE39pz4skpDVXK09C9Htyz1acDzSyS6KQGgzNLilq/TJlJ8gg34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gfy3Mwfe; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78a76afeff6so27769507b3.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763766605; x=1764371405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIhyiakhBQz7pP1gby69E80SsuyQpol3QkLbw3g393Q=;
        b=Gfy3MwfeBAYXXFSDqQBu+dxtBEWzVHhV0k67Me+B+IKfi+rm+AIm0fF2tWd0W9FSw5
         E5V1rel0jQnt9SLmNNetqtkoJf0MBJt7biWmIwdC+4QJ8nDyI17AozBJiDvDtnjM8yzG
         DslS4SMJkKhYDTT7oz3p6hLHoGrJZRZB0Tv8NBbLcz8YyPYQ3FuSIKvtFXjTaBVQ7ciW
         9zrNdBDsFFdDGc7kZxNsakPMklVf6HMDWWNlSYgZZ5BBocjzQVtQSEV/7gEqQUuS1Lb3
         Hod9sk6sRY3/SEvktzUI8Q8WCthkPBDH1gVJLAdXoxMVOzoCtBcTvIMNA6tF7Tj60g4I
         ofsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766605; x=1764371405;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIhyiakhBQz7pP1gby69E80SsuyQpol3QkLbw3g393Q=;
        b=WMccKhG2AODIUrirT/ztVZq6SR8qHalSkx62QuhVPe/fxRhhbL9Kar7Kq9/FGDO/OB
         bw2Ymp1Oi2PvVF1u1RcppbXiqab3/u/t2h3Q6M+ik8Tovisy78XmRdXTqybGNjNDxRnN
         7FB/oqKP3zUkyJ1mvyfQDOhUcDxRUoD6IYwRO6v2PPRFBqh44WHA679cS2kKKgt4w3Mg
         vmkSVl3E0CI7m/i0HgNtkDTNr55B/AQHpsu/SlfbRBRkqh7VUayd2tmsJKkqL5TTIswj
         LcG++uLiPqMm6aagG9zHWb9YvOxzDSA6JZ4HMdWlOiW6Kw6c6fsEnPrWDjJG0A6ha0es
         B2lA==
X-Gm-Message-State: AOJu0YzYraernGxKPV2+zJFE7rUizFk2hvWKNh3SIIit8GmfZGRDT84q
	4zpSyFxauToI2sQyOR1Xy5BXRkxoD7e/tHyOBH4gXrBiT7ziYGgvyIoS
X-Gm-Gg: ASbGnctsyF1GwqlSvlzgyaC4hTjQPz5KOyYk+zQ2SXPPu6r+jbwDzfw+bsHFXialxBc
	Ks1ICmzxR1t/1egT3nJ0VkdbwD7ophvrgxqkWTU77zs7jnhPirP1QZgR49vopLXD2PqEwq6AMSg
	wFktUcfI5YUo0HEAnRGhv9ktfS/xs+1guJfWpNXuT2WAEZ/axqRR4MH70e2ky4RAs5iL0iV1rFF
	cYv9kMVIVQasdm3cMSQz2dDMneFD+V1tw8JHAG/+yskc6kY0mxnVAHelFSQuDYMcwXtCE/K3xdo
	MLpRRAALMXBNQ+CGxiSZ9N9V9YwG3dOkBMv1C3dG+WQ7q73AzgnEUBeIdDmXr8FoNLD2pqWVvx2
	R6uufJvUaQc5wMCJ/pcpIztyTSy66/E0sYuA2Kccvoz13CqcHFEz0NHM5nZC6s1pSC0zaQdTQuo
	Q7ZrH+xMLYHZRgeIRekr1jlCMkcDGGUvLprDImRjSeSbqTMqbjLMl+yktojzb+KdrxxFs=
X-Google-Smtp-Source: AGHT+IHfCNm/h1SWg6slN1yIU0nIrFVDdi5F9NffXFDZ8GMcG484usVNe9HQYWOgCoGXaTA5uDjGxg==
X-Received: by 2002:a05:690c:b9e:b0:787:d2ee:e2d6 with SMTP id 00721157ae682-78a8b53930fmr29887407b3.34.1763766605302;
        Fri, 21 Nov 2025 15:10:05 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a798804c4sm19847067b3.3.2025.11.21.15.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:10:04 -0800 (PST)
Date: Fri, 21 Nov 2025 18:10:02 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 dw@davidwei.uk, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.2fe8d4c058a2d@gmail.com>
In-Reply-To: <20251121040259.3647749-1-kuba@kernel.org>
References: <20251121040259.3647749-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 0/5] selftests: hw-net: toeplitz: read config
 from the NIC directly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> First patch here tries to auto-disable building the iouring sample.
> Our CI will still run the iouring test(s), of course, but it looks
> like the liburing updates aren't very quick in distroes and having
> to hack around it when developing unrelated tests is a bit annoying.
> 
> Remaining 4 patches iron out running the Toeplitz hash test against
> real NICs. I tested mlx5, bnxt and fbnic, they all pass now.
> I switched to using YNL directly in the C code, can't see a reason
> to get the info in Python and pass it to C via argv. The old code
> likely did this because it predates YNL.
> 
> Jakub Kicinski (5):
>   selftests: hw-net: auto-disable building the iouring C code
>   selftests: hw-net: toeplitz: make sure NICs have pure Toeplitz
>     configured
>   selftests: hw-net: toeplitz: read the RSS key directly from C
>   selftests: hw-net: toeplitz: read indirection table from the device
>   selftests: hw-net: toeplitz: give the test up to 4 seconds
> 
>  .../testing/selftests/drivers/net/hw/Makefile | 23 ++++++-
>  .../selftests/drivers/net/hw/toeplitz.c       | 65 ++++++++++++++++++-
>  .../selftests/drivers/net/hw/toeplitz.py      | 28 ++++----
>  3 files changed, 98 insertions(+), 18 deletions(-)

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for improving the test! Especially addressing the missing
indirection table.

