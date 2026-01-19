Return-Path: <netdev+bounces-251196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE48D3B3B9
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D0D33045CCE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45F324712;
	Mon, 19 Jan 2026 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMFxGtQJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C414322557
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843010; cv=pass; b=tZSJSH9uCgJlKHo8Ni99okKT0uwtVrL4so1bsncQCPsUfxLoN4m3mSDL5wne1jXJJrM642b4wDO7gRSMNWTDmP81Ynz3qGAh4ftFreWc6nSZxFNrhFxWErw/UnSbJlYd1g7acbJ/tavb4tSnLgeUTZ+4Frn1KOcqFnbQpSx7FBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843010; c=relaxed/simple;
	bh=ZsGcxa3/dujvAI4Rmb4qGNPcgAP3/YJKOOLBJnfEpuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJKJGDxptpPFepNe4t0UM+HHHodeSOxa9YMaGnZSDkn20Xii89lehGarJPy1K3tLGTMY7mD0xCF520/J0M9Acpc9R6gnMj0eJwNSe5RzO3umaEBjJVjKjD4KlI0s/Q9s2k3A4fwwEbyVxvEroZeDFNNh52WRHcScK3oCqyz1KwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMFxGtQJ; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d256c2a9so4445690f8f.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:16:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768843007; cv=none;
        d=google.com; s=arc-20240605;
        b=YNCxzi94HbRK62JG7CFpeCoLasdonjXec6PYYuOV/lXEXD/MIxyvwzBhns5mwFIcrQ
         8PwasuDqZoW4IK7GoRsE6S9EaqMfk8oT0L5XMhPkW3Wr3iJ/D0pltSeUKlHaTWHOeMyo
         M5U0vpCMGyIa9hu4zYNKkiQF+9gWO8qpZOsF4BY5nvIbKWOfgqNMWcAPOQ8dSrn5xFdx
         7WAmcOxfVFfPZrLDffHFF8LSxBwQ+HzFVOENOtNtoN3OMtIXkatALn30t3XgFCPvLc/K
         mmUH2hmn2nzAqxbzp5vN28BbfROsjwWC1/kRFiySPdcKk4lEg/VqUIJ6KHImE87KyLN5
         1HqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fWkUXehTFxDxM5oaQU46NekzR5HsGH8LROOWkLyzh8s=;
        fh=SRG37YUPAZ28waVa3Wq/KyUQkAFUDoE0nz4gMDlUj8w=;
        b=i/m5bQrw4xQzua5CejZ6YY74VSa7FzEjOQ332wr0oomZpBiikb6qldfWoZvETJXQBQ
         ku90JhKrHOyh4h2AttaUtTMrxpj1WMzuKwLBaO565/G6GP+z6Sk8DxeycyjG1CqT160T
         e20hEkvtU1dDFaxcKeJKHNcStTEnctXZ0BDjH5an7dyfAVsp0jhx0wA8wXK9ZCe67reC
         R/nzqd00MpvcA6RNZVNrUrF/Fl4tHoTqG/W10zvoOotTXO+k96R+pXCoJE+gdEjiBDdq
         GPE1uC0Mt8LdcH4rLVf35v83oXhC2IYGWimMMp21g7KpjliboYZYHkqiCZOMTD48i6jp
         o6RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768843007; x=1769447807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWkUXehTFxDxM5oaQU46NekzR5HsGH8LROOWkLyzh8s=;
        b=HMFxGtQJB8yNIu+iVcfduKq8+H3jqRLpQiFPcT2JeIgJqtgWOvjV1F8lqYWHMHDzsc
         Jrb6SODsSSIx7IcLImFT2MJpUHgtO3YcCA7+kiosGu8mS3zsCcmkN/Fl8V/M3zAM0KbS
         k4XJ6ah/+Yz4Av71A+4SJI2jj91J0fri16+gggYbliR0aRVXwQtAtv0LI+5RWDaoQg1O
         75+GfZh77gq2hQhpuTHRHe3L5ObCCWiciWE/7oXWaMitr+L2vXSVFA3i/raNZZDz7dwT
         xzBz9k+irhxfskVD+xVxSiwt7DV/3Em9ij5ppgQslSEz7xJ0czzdzptalO2dbO2sEFWO
         3yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768843007; x=1769447807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fWkUXehTFxDxM5oaQU46NekzR5HsGH8LROOWkLyzh8s=;
        b=Da5Sl/WbDD/9yDAjUyzP8wBWZpt3AHh/sJTLEiIh5Cn2OeEFKZdDHjkVJx4o8NPwuh
         LGtDnq8DVXlQnn/RsNnLOKr30GTEbbpfcoJu0nq/9xoi+/+sXI/us8cP8SWdMaw3m0Sz
         YNd5cffbVKwoUx4FrwhRI2LbW8oOq+z8NcUEzhr1NCAnjZjk+JB+ziOuS8Ltpj25gMhP
         qwPHljX+zauqt0E2ByCsSb1ggk70Omo9ot34UDXAllnh7soBAvop+egSdnP6/kBsNX3D
         6Z0nO0Q97VlYMYIG1UxHAlpfGN3okn9f/7BqYBw4UTsTwSdj7+28X12KtbPgEalcHNtn
         aQVA==
X-Forwarded-Encrypted: i=1; AJvYcCV9eOH+9Y3DDmO6uz/DCTfNpbvtuu5UvPxWvAbSC+fGrjIJrRDgJSCFGbPXu8qa8n9KDr6ksxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5dZCDe4kZxrvJlf80OAM+dt3EaVw1631EpDI2EPUKJmzMl3/a
	ISRQOJv+/d2Iw6OwOuUq6CExvgse6eGAqTO7273U6c+Mt7YuBfesEm3C4qhjmtcDUtBKxOrIVuh
	SiGB2WMzCnDBGcYSjrvM+6l3ykfh4B4w=
X-Gm-Gg: AZuq6aIFQsiJSroEJAxfzcMY8c+FbGFcYL6957UHJYHK6yYSedZkmNhaj822TvB/Syh
	0vVRIsCA76VtkT9qhdbkVr6tyYZkwjDi7nBd9CyScvthHQiM9V4EgXUE+vZ9mF3USQe0b4qkYFS
	LTkU0NNSLA+8mCENAC7lC2TMzfWdKoUiLBSdEiE6DPOZXXdQLaJtYDNWKvV49pKlb+B5uyDDkkG
	mGvyu+t3nSMI+byw4UfiCztTLcZOtQmrTIn+Q12zR5S64zdNwViTqN/Ec3Q2MGOrP0/6EU078XU
	35TVuQTfwZDt3tLLcpb8/kCyiQNz2L6Th06thG81D35cWXer3+hiMAk=
X-Received: by 2002:a05:6000:2282:b0:430:fc63:8d0 with SMTP id
 ffacd0b85a97d-4356a0773aemr14767256f8f.36.1768843007458; Mon, 19 Jan 2026
 09:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119091615.1880992-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260119091615.1880992-1-sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 19 Jan 2026 09:16:36 -0800
X-Gm-Features: AZwV_QhGkCpvhEfASfQzOJSn-VdxNup-v3_JeJot5VLuqsiIqW0y6hGuFkj_iBM
Message-ID: <CAADnVQ+j8Q5+2KSsaddj3nmU1EkuRAt8XwM=zcSrfQfY+A1PsA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nf_flow_table_bpf: add prototype for bpf_xdp_flow_lookup()
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 1:16=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com> =
wrote:
>
> Sparse reports:
>
>   netfilter/nf_flow_table_bpf.c:58:45:
>     symbol 'bpf_xdp_flow_lookup' was not declared. Should it be static?
>
> bpf_xdp_flow_lookup() is exported as a __bpf_kfunc and must remain
> non-static. Add a forward declaration to provide an explicit prototype
> , only to silence the sparse warning.

No. Ignore the warning. Sparse is incorrect.
We have hundreds of such bogus warnings. Do NOT attempt to send
more patches to "fix" them.

pw-bot: cr

