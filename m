Return-Path: <netdev+bounces-220867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449E1B494E1
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907637A9712
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837F130DEA7;
	Mon,  8 Sep 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LESLrDIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F331FF603
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348123; cv=none; b=cgAKgcWSD05501ELx2uJChU7V4BwYRRjQ8cok9PIzOWT+MW//pge1BBNIgU1WjsvYbsZ0WRM/xlpyVJQbVGTai6I9+CNx84j+Zd/ceUv5esjhpCXOAaDj0SM0hAfSpPrMqxO5H+mlWtPbLuZNLUh7vsN5xFZ4iDmiOCfTcbL9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348123; c=relaxed/simple;
	bh=uNUru7zzYgB2sxMmEWKB29J1/DPZc3utoJ6hlH1gScQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm5xGqEeuY6YVGQeUjRsIcz7iJb/4nQR6wQW2cYGdGSdGjSU2BD3hcn6PHxqbifucQp9FgtK55apmUrRLiackoZmZhhjlpQTaZ+VRwk8Oo1Bs7NpZHCv7+iPs48JFzyQBEaED4HbOk8cLMH2WJa0ilJXY4jjuLCEyTCn5lbGQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LESLrDIp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f62f93fdfso11035e87.0
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757348120; x=1757952920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNjG+KitGlrkzDIU5rpQqLyG76T9yZIXGSuaiItNQ8Y=;
        b=LESLrDIpxfQWYVGA/wU6w9ZLUZewdg8JUlLhcOdYWqNFyf1FaQzmTMPX0IAJoxaPkx
         Te4TJPalAFDI57mKuhdn55uolt7TQR6H2kQfnITd3UCuF3XOUlISZKbHKlayl98SoSMD
         Fprz7TwrrJkNR0jTo9bGB1UqFXD6xU6jh731vKzIT/DGN5hV95KfFMyp08xnDfX8+wAk
         CNvl/mpDVSt6dDBNenH4QRN3O+oiy1Q4moVG2JaMLu8GZGIAV/bZs6ahjnR2SZXwMC7C
         O61PTDtcGVoDuCdLZzse9/4OZ2AzLFLGNbaGpSYeoYrFCjxsSPEgBpBDI4zcZg3Ed6aU
         rZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348120; x=1757952920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNjG+KitGlrkzDIU5rpQqLyG76T9yZIXGSuaiItNQ8Y=;
        b=PtxQldzqlhtfRvm3ru3aQINV6zVtc4qrltKn68s4wlBecXlrQxS5MULdhfjU84ajBu
         qdvAHNoEQu/qp81PmKUAfaqzL35Nwn3hHDu3PGMDdXf7av4XNfN6MOq4VQewwyLf29X9
         nOsYdMeED2CbB0LLh4m60eM15epIBMNO7Mlpomb/bVxn1kE4fVRwoPvjGdS8cow4kHRZ
         j+aplLrl2aTxEf9L0Vu6+YTBTspPzf8JjQrugnrI6qaGGvN9C5+6VFMCSIlx4CYac70u
         6HkZJli1uWF1FmSRKeaJott7dNNOX4nWGa1YLrsbzp573hNYrYafi1kuG7B9S0C/cqHa
         g+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXDNrkrHsiuBP3pUMm4J/ywR6BsOaPrZaGoPS3h2wq5ttSJufZlJ1/YVOPW8THliiv2/2NddmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9VN2cHQbM6srnmwIL2kQuV2OT43DbBI732YGqMY4XQ4fCitcs
	FDG/9nl8YLkUy6nCeVjqnuwOhDY5b/l433PgFYVqqlSNWlsC9sfcdjyG9ZsIBD6ntdKd7gjPqT8
	+L/tW5b1jhq9BhuRU9rKZxoUK9LS6V74if1gDNmhbGh813N86b3Hb9CBk/qE=
X-Gm-Gg: ASbGncspdVdU0ogJVL5d0/1w1fppxDLo6A02KxCEE6HHBmDKJsJPSeq6qnaDGe1tPGk
	l3lq/gbdPPkowNh7KujHA6qlai5zB7sCzH1vLc96V2n8SIKJcr7tPh/9NMgU05hB5fF0sDMJTNO
	zX/hsO569/mu8inX3GkVocFxuDlR0KYJR1WwetTD/X1AErGaWjBcbmLEdpZ2bxsaHad4zRmJj5w
	9//ukIf6mnefE+mHb6p5ixgsw==
X-Google-Smtp-Source: AGHT+IHCFgf2RdVhu8TYS/rYvOmOVPxQpbxz1eazegKbLqZhwrcdPrTR9V2NoZ6tvq3rImVDtk9v8k9/bM5/xLJZgbQ=
X-Received: by 2002:a05:6512:15a9:b0:55f:6ac4:c3b2 with SMTP id
 2adb3069b0e04-5624189cb92mr517813e87.0.1757348119215; Mon, 08 Sep 2025
 09:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908152123.97829-1-kuba@kernel.org>
In-Reply-To: <20250908152123.97829-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 8 Sep 2025 09:15:07 -0700
X-Gm-Features: Ac12FXxUA5KIQ6gt91UijVuNGZtQcZZQjXWdNtL3h7riklG-58cTNHxzxIEdFLs
Message-ID: <CAHS8izPRupVvCDQr7-GF+-c3yeu83wZWgQth4_ub8bQ0AhQ9_w@mail.gmail.com>
Subject: Re: [PATCH net-next] page_pool: always add GFP_NOWARN for ATOMIC allocations
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:21=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Driver authors often forget to add GFP_NOWARN for page allocation
> from the datapath. This is annoying to operators as OOMs are a fact
> of life, and we pretty much expect network Rx to hit page allocation
> failures during OOM. Make page pool add GFP_NOWARN for ATOMIC allocations
> by default.
>
> Don't compare to GFP_ATOMIC because it's a mask with 2 bits set.
> We want a single bit so that the compiler can do an unconditional
> mask and shift. clang builds the condition as:
>
>     1c31: 89 e8                         movl    %ebp, %eax
>     1c33: 83 e0 20                      andl    $0x20, %eax
>     1c36: c1 e0 0d                      shll    $0xd, %eax
>     1c39: 09 e8                         orl     %ebp, %eax
>
> so there seems to be no need any more to use the old flag multiplication
> tricks which is less readable. Pick the lowest bit out of GFP_ATOMIC
> to limit the size of the instructions.
>
> The specific change which makes me propose this is that bnxt, after
> commit cd1fafe7da1f ("eth: bnxt: add support rx side device memory TCP"),
> lost the GFP_NOWARN, again. It used to allocate with page_pool_dev_alloc_=
*

BTW, there is a page_pool_dev_alloc_netmems now that also add the
NOWARN and should have been devmem tcp compatible and maintained same
behavior I think.

> which added the NOWARN unconditionally. While switching to
> __bnxt_alloc_rx_netmem() authors forgot to add NOWARN in the explicitly
> specified flags.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> CC: nathan@kernel.org
> CC: nick.desaulniers+lkml@gmail.com
> CC: morbo@google.com
> CC: justinstitt@google.com
> CC: llvm@lists.linux.dev
> ---
>  net/core/page_pool.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index ba70569bd4b0..6ffce0e821e4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -555,6 +555,13 @@ static noinline netmem_ref __page_pool_alloc_netmems=
_slow(struct page_pool *pool
>         netmem_ref netmem;
>         int i, nr_pages;
>
> +       /* Unconditionally set NOWARN if allocating from the datapath.
> +        * Use a single bit from the ATOMIC mask to help compiler optimiz=
e.
> +        */
> +       BUILD_BUG_ON(!(GFP_ATOMIC & __GFP_HIGH));
> +       if (gfp & __GFP_HIGH)
> +               gfp |=3D __GFP_NOWARN;
> +

I wonder if pp allocs are ever used for anything other than datapath
pages (and if not, we can add __GPF_NOWARN here unconditionally. But
this is good too I think.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

