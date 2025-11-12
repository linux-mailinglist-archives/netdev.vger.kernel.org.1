Return-Path: <netdev+bounces-238122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 152A2C54697
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A20F4E7DC5
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD1A29DB64;
	Wed, 12 Nov 2025 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ujCFF9vV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D319F137
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978339; cv=none; b=c4NTl//2TXHz4vmLw+yZpqtDPXdwcejDzczin2e6ALiBP1SvwZRynepS1mtoHa0wsNOKrYjgwt0/yT2dYN2VOUXUJCvi4+qhoeN+5hc01+FJBUStjUAZMyVdQl54BItlb9mrNb5Us+rjP7Zun4hQHwxTEthDFzcGbhoZF+FVPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978339; c=relaxed/simple;
	bh=gsP4RuV0SX74Q4sn2qalh8C+3yPvQoVzq/xVfun11BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEpqeO06PSDMlw8zoEDB2gC2Hllq+A9ZU7E01LSDoLjJ9QwprJzeLYyASaLXYs33b0wiXxdLoMxY2+z/sNRWIwfZRuKPNUv6tCOZkEGgTU85hqkQJvd9rGYq1WwZHMb6qqjCL+zZD6SnGLJk2TrTzQqVRckykVF7aIVAIAObnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ujCFF9vV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so20045b3a.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 12:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762978336; x=1763583136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsP4RuV0SX74Q4sn2qalh8C+3yPvQoVzq/xVfun11BQ=;
        b=ujCFF9vVRnLXzvMS2k3iAG8SDEEJO5uSSvMq6Esy8L5kuhwMHCaOZFqZZ4qtAIUy1d
         XQ44qIYBcNuxiyQaIUFIZ6GjH5pWkxSjWTOg96GlX+cz7yS9iQ5szPdiD74Xccj1mZQr
         50W6mg62KC7dH2JGkSwXBA1vpVi4pEw6t9QrQzbJEs5WvNZ0UDBx2OUgb7Mt7XPJuIya
         y3farylFxhsdp9NHRhQyljRBhHH09c/B44PWG/kXG6MaEJRZOJImesuFbni2tXeQVeLU
         X1SR6hyYhRZKP76LN5coM6vSBCScVuoSZzCiqP1wjRufdbyQkLToFe7X7ACvKFDWdMnj
         UWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978336; x=1763583136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gsP4RuV0SX74Q4sn2qalh8C+3yPvQoVzq/xVfun11BQ=;
        b=KJWiqncQOGgA8iujvpU6YrbqmEv2Fwh+weWhqG0qn/J4v28MEZHvV0Wnj7tCxzVnyt
         JW6qGtkEXb0IWch1TpPjfhkYYXt+K8oxAvWG9jKByOOATs75xpp4f8/iyu15R7+hMF6S
         Y4p9yMiMN+JTZtFWRg1GmR2TQNzPFFFUus4ovZHs+qfEuLN4nfoedz4ouNFtFDUPwq1H
         mLm1ChRdz7zMN4B3HD3cuougAwDhl0JAn4G9bgH/EjHFlYwBU3AXnY1LrzrPigG1SB/f
         2Tq2F7UI0RjjO4fIyvbRNoNYRYv+tl7wr+SV0vtST6cmYCvsln2OlNKhNIdwLDCQzWp6
         jyLQ==
X-Gm-Message-State: AOJu0Yypon/VKOyuiNKKvj5WYF2vIkFFbLNG9ZxuxdCi+L482THTCw6h
	HgHb/+GOszMlIUmxSy7nd+WIopN+9yP7OVMegGHTLHJYy3PEopGw9/CdCtIk6X9KF7hhiMOpfqq
	Qqvah
X-Gm-Gg: ASbGncvEsEOJh+HnboSeqSWhJJa0jZWW7XNjPE8AIgsPor/jQ/xlwY3gsPqELfR2gG2
	mh2gtqO01Id92N9RwWsbsjJmuMpfmB5INwXzZ9c+DBQpJcIaNHJhbacZnvg2l+rhJ5US+5mnseA
	Ypd377t4w/l7mFV2qQlBpPQFw/5pg+7U3xD3TWKNCIJDgcH9fXFQl/CCkB5wyxGu1juhwZ0jnAu
	Ng1e8yyNHTAiLdIpaMc+NXVyTsZr/3gEH0gSa741f1ZBgUFGjj3RtyAZXdTXZceAp+cy1vvyT4i
	AEVIwrMeWmt1+CfGpiHY2qFYtspyzlqFlwhEHiNsBHeE9y0jdl85aETZ5xVfKqNpg4TUlFFsnPB
	NXVR7ZbPzTMCdn+Tvlyh5fAMa8BDvY09WG9YA3AbRV4ca0h1DucAln3hYGvZKtb8EK/fevPSbY9
	BETbRl9WtR9hRZlDKRNQx758fBpHmX3w+Oyg==
X-Google-Smtp-Source: AGHT+IG0T8LAB89N+NLBKJi4tziCPLU6tUuh6eDgoooLFm7itDIrTgHFde48cWwu0NOkAzvIltUARQ==
X-Received: by 2002:a05:6a00:4616:b0:7a9:f465:f25 with SMTP id d2e1a72fcca58-7b7a52c74b9mr4620225b3a.27.1762978335682;
        Wed, 12 Nov 2025 12:12:15 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff8538sm19700242b3a.28.2025.11.12.12.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:12:15 -0800 (PST)
Date: Wed, 12 Nov 2025 12:12:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1
 code instead of AF_ALG
Message-ID: <20251112121212.66e15a2d@phoenix>
In-Reply-To: <20250929194648.145585-1-ebiggers@kernel.org>
References: <20250929194648.145585-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 12:46:48 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> diff --git a/lib/sha1.c b/lib/sha1.c
> new file mode 100644
> index 00000000..1aa8fd83
> --- /dev/null
> +++ b/lib/sha1.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * SHA-1 message digest algorithm
> + *
> + * Copyright 2025 Google LLC
> + */

Not a big fan of having actual crypto in iproute2.
It creates even more technical debt.
Is there another crypto library that could be used?


Better yet, is there a reason legacy BPF code needs to still exist
in current iproute2? When was the cut over.

