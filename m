Return-Path: <netdev+bounces-239178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2E9C650AF
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6101B365D4B
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976FE2C2364;
	Mon, 17 Nov 2025 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ7jAYav"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D902C21E5
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395551; cv=none; b=bFxNLI8WAPKeOw91AZSyDzhFrttRmj1/P36EuiYXu0mKljD53QLjbTj41s+wQdj9Gx0NqE8QznB/rdV/x7FIR+zr6s8Hf0n9pGxQcFS0P+9tvuiF026pGjmEqXeNljGtCOc+Bh0qQkn0fpFhUNjfeHdPYTN9fknG9akie8HE844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395551; c=relaxed/simple;
	bh=rtpjIiIlwv8Z4omsOMF5KY5wtcbo4rQbTFrRHKz+CEQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=J+cCIzG1KSFF4gJ497rIfflQ3ZzT6tdQNAmnJ54C/77mg6yMZZr5mxGloQP7ubzqDv26Omb3Geg4qM5pR1rEFxHtsKbI16sXzNJCQjOWXmlBzauJrT3zWI3tPgEVO/rjMpZFWjlA9pLKaevroEjWZvBuA0yPn102LThHU3vXSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ7jAYav; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b31c610fcso3966205f8f.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 08:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763395548; x=1764000348; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIQH9Z7cUezUjldbG+MilUGr+vhpfO0JfTL7ifs5sCI=;
        b=hJ7jAYavo3C1/TG6ll6NAicftlF3LVdy+kf3hFlnuIZFykMFnD5AM2XPKaUTuLGUEF
         nuvKcWeBmGq5xutW+Vm25Epnk/yhaDqxBPrfL7ehUtNatWMtIN91zemgoQ4UQTFzDsqD
         o7qoxG7KJNgC3jWnu7Ea+8gpLjdii3kwsdHvR1WBk66qavmzz+rRv1qvPU+DiIKEP2MC
         rnfvbV4+5ab0eX85omsEJjNvlG4eSwaDUmLSAEN6B/ZxGUMxv0MI11lxbFHJ14Rsn3k+
         nqxKWlVFgrnhGmBztfg8S12+NoZD/+at5dUjz4/46FucwuJGocgVlLSovn+Erl9m6QRN
         b9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395548; x=1764000348;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GIQH9Z7cUezUjldbG+MilUGr+vhpfO0JfTL7ifs5sCI=;
        b=vB2TetKOIxNOYchi26LtNU/FPIqYLGGMPpByAinq5VrBnX0nFIee4ltUQ85Dm9qJnr
         IbiJ65uVr14qjb1hcUpFAVW73nPqc42WqZlXRjyxJHgnUFoxTMWtYzg3zP3YLbYOJDWP
         CLPe6VCSSvX1YeQTvm8ngo/qJvWJppHRlh2DldzF7Ch0p777Hcx5m6sDdBtToymwp7SV
         61FlwKrGFMKVwygKAfxkBxa48nMuCjdVhur+lUHmUEvWYC8h0beXXNlzcY4txXGf6r/T
         Lio1PV8vKSBEMrPRH8XhjD83ULeaI0qeCKPoQ0tHEFqjMRnRV8kSPdnQxSUB06LHieG9
         QpxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHlBX5KOemDp5z8WFXDKMgM4uotpD7GpAXqCVexpH/ZQ8PdmIDizb5lqsh8Za7TFraQFg/1Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6H/HRR7lf7XXqcJRFwAv37YHBSw/Xw80MYZi17k79H/xj3Izr
	L4kyuuGEBuv2b9CwfrqWRLk2vrtKM6nnwD6VSF795jxNlFLmbkKjDGfB
X-Gm-Gg: ASbGncvbDHUqNqSkgZ47F1JWDXx3X4BBSirEmSMtaDFhNG/gVcPth89PThSI7LFJ6fk
	L6WYqa2yS54s5GQXunsRQeuKpkkw8dqEvq9NUPulESoB1eMgwyZO3AWDfHl/gnsONL2qvnHsr7Q
	YWSQJtrZmZZrHPxOvrL0aW7jHN86lwg2t8CYVHtNmFGBQbMoUPa2uCpTrnSR1bWTxMx+1cPrv93
	TuX1HqBTQ8JmdlwexMSTJtzjTIzRjmfDXMLfZgOaViDwooRtDdwaggVsXy+gA3Q3IcM056J19JS
	qf+4xSi7CBl1OTQQF9vnTKmpAAENYM5znD9dn5dzUszbcaknWFFbgqxAbVGCPuQAXBYT5TCU3Bn
	gyrJpkeJfU9N5nQ9nr/RiUQ1hysYAtI7BTIe3bRZ6kudvfjBQlVNGDnqQtGiqbxgn+Lqlxj+HnG
	NJKORg4u2rm2dlvb1cwvej4+mkut0j2Oqdzw==
X-Google-Smtp-Source: AGHT+IFJtFrkxaLk28xLtAautoQrmDYpq9UtvQj5B3teNEO1FH5SHr/O+P9hTImJsKXpGip44YXjmg==
X-Received: by 2002:a05:6000:25c8:b0:429:c851:69bc with SMTP id ffacd0b85a97d-42b59342f3fmr10432513f8f.8.1763395547294;
        Mon, 17 Nov 2025 08:05:47 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7408:290d:f7fc:41bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae2dsm27430854f8f.5.2025.11.17.08.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:05:46 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
  <netdev@vger.kernel.org>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  <bpf@vger.kernel.org>,  Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net-next 3/3] tools: ynl: cli: Display enum values in
 --list-attrs output
In-Reply-To: <20251116192845.1693119-4-gal@nvidia.com>
Date: Mon, 17 Nov 2025 16:05:22 +0000
Message-ID: <m2jyzomypp.fsf@gmail.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-4-gal@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gal Pressman <gal@nvidia.com> writes:

> When listing attributes with --list-attrs, display the actual enum
> values for attributes that reference an enum type.
>
>   # ./cli.py --family netdev --list-attrs dev-get
>   [..]
>     - xdp-features: u64 (enum: xdp-act)
>       Values: basic, redirect, ndo-xmit, xsk-zerocopy, hw-offload, rx-sg, ndo-xmit-sg
>       Bitmask of enabled xdp-features.
>   [..]
>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  tools/net/ynl/pyynl/cli.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
> index 3389e552ec4e..d305add514cd 100755
> --- a/tools/net/ynl/pyynl/cli.py
> +++ b/tools/net/ynl/pyynl/cli.py
> @@ -139,7 +139,12 @@ def main():
>                  attr = attr_set.attrs[attr_name]
>                  attr_info = f'{prefix}- {attr_name}: {attr.type}'
>                  if 'enum' in attr.yaml:
> -                    attr_info += f" (enum: {attr.yaml['enum']})"
> +                    enum_name = attr.yaml['enum']
> +                    attr_info += f" (enum: {enum_name})"

Would be good to say enum | flags so that people know what semantics are valid.

> +                    # Print enum values if available
> +                    if enum_name in ynl.consts:
> +                        enum_values = list(ynl.consts[enum_name].entries.keys())
> +                        attr_info += f"\n{prefix}  Values: {', '.join(enum_values)}"

This produces quite noisy output for e.g.

./tools/net/ynl/pyynl/cli.py --family ethtool --list-attrs rss-get

Not sure what to suggest to improve readability but maybe it doesn't
need 'Values:' or commas, or perhaps only output each enum once?

>  
>                  # Show nested attributes reference and recursively display them
>                  nested_set_name = None

