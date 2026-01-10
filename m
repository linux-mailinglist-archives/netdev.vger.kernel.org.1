Return-Path: <netdev+bounces-248728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE352D0DAA4
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 20:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B36033011029
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F52224B05;
	Sat, 10 Jan 2026 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTPZ26dL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C32AE78
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768071851; cv=none; b=opfrPozo5uBJPT6QF54h7Vvs1Os1rlmrp6zcDMfzHcuVqzEPcV/6k5feyT9UNLnQh0r3Jd+7Ctv5c1wwo9CpQY6xLAb4stROeusk8j//KyEQJzyeKgzJazhw8iABvrPRHzoyXXp27HRnnI+iDhcvhL8zsYI2wEEEO/Tz6zTKvq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768071851; c=relaxed/simple;
	bh=dskCpJd+YCujyIx7XR9oysY2xe4QopxRDplMgNdfrEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4NifPNIrVTvOXSZCsaBTV1Rge3JBK8zPThLcPy5v6xOCXFqGn7JmLkrC1baA801uDIBlYZpoqynBj6gqS59ORqi1tfIlnukTrhDwzDMGzY+xeX96J3gW7I1IUhicOLGZqvKF9vBdtfOLCRIpdmlk7zVvfTfn66GYytKT9zBsrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTPZ26dL; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11f36012fb2so6758012c88.1
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 11:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768071850; x=1768676650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JlaKzcSrJRaLTx4G3ypkWP+DmBlFYtf0U4Y+cLGn/os=;
        b=PTPZ26dLPUKTp8l4cXDO+wcww8GGsTCAeby1ZtRIjFR2vbnO993G7goKPB5ZHW5wGu
         CN7hQlgx9qb2A/cVtO7lrytJk9E7Y6vrXws/ISO3eQkMnDH94ub3nTyYsZETcD6Y1909
         XA3wUVefWU4rtxhI/nMD7mcTl4WA6/GPNIv88F32VwMZApLrNzWEYaK6vgaamToMUwIF
         a88ivxergm80Bk4xzkFWmvKZy+RpAaS1XzTfu/HaSl1wMYcKc1fpT5uCAH2TMx/1SIBe
         xVtaPM87J/FSndMpKRMveDRdmngvhF22SnXDQEx/thLcUMQBtVZHRH7BWAN38sd6O/M0
         m9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768071850; x=1768676650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlaKzcSrJRaLTx4G3ypkWP+DmBlFYtf0U4Y+cLGn/os=;
        b=lYmkW+Nb0kAGPIHGiMRsGjYNkmtiGrETMtApcdITWP0hDL8aM3b+F2iNnC9d2+wcRl
         lFsbyAK06zlgjgXGdDaQ4Yt6i0KVFft4pIJtrrRu05CL1jwIcwWLadSFiGHt4vt8BQ+6
         35hGZkKONXiw+9PWMlm2P++NGBh7jLih0Y8dFGlQ/DTuj5MX0j9JBDPR4N2deJrt/XCT
         6S4NNVwUTJQJM9uZ+u902k496UfSFFSvxgP1bRsW0sU4Cjk3WsHwheUvnK95XwUg3Jgi
         Rulgo4B45TZpfnvb0y0d91dZvJHn83d19SAtC+LHceHhqFPQF5mnhZp2CqiOYQ7CUWGp
         oiFg==
X-Forwarded-Encrypted: i=1; AJvYcCU2ro/+C1he+vpXqbcw8aKBXC7QcNY4ijorLbJmlcmzhD75bMOPmn7DmSwlD0s3IIKfohkbaVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwuzqSGnfVK5jV+1RBAx06T6N6NgSqRDkg7ZGd6KkSKECXKMy
	/cs7IcAlv/8hE5qG40thZLtXABaamA3J7XPDoPFG9KaGDX5PcVYC6JQ=
X-Gm-Gg: AY/fxX7TaHgpE9g21k6SL/QC20JWoDrbjFrj5cjE44sOw9K7H9QDcEBZIh22e518AIG
	u4jNPSuwbg3kG9ZT2bg/UY6GSMYEIuCWU7X8CfOjizW5D1JaHuD007qtthseNnioo0B4XFAAbtm
	zQB02e8ijqfRG0XfzzV5V59hVHARCsLWO8nK9XljELYxnFbjqg7K6EMYMrMHFzEoioDmp/VidFV
	AXQ7ZAFMu2kdN75p6h9iwoT70GZRpuvVwakkHmK8lHGTkzspBYCiuTESrjGmXSIETsFn1X/rmDr
	h94hVJeFoI4RhfE41bRN5Nfthqm8kowr8in+5o4KiDKZIBLFWhJsN9RyycDQc2xWuuMr8OOOWJQ
	JhS4ueCJ63eaThJ9nlBMzafvaVESXe5RPyAllZDBMVgNN6enUXh4DsvHYFPx1juAb6xTQvISVpZ
	sOGguNLTXjO4R8xs2CCXZROwBjvlrIxnuWABg9225Dlktj6g2Dv1+vj12ktln0/dmNWhSYTx4Qv
	Xe0eg==
X-Google-Smtp-Source: AGHT+IG+GcY2ymFoaEhKDPrjsSUaDi3OJeOrtrZ6G87StYoPBMKwjqu22SqnvFYvMfDQetvm3ldMLg==
X-Received: by 2002:a05:7022:41a7:b0:11b:9386:8254 with SMTP id a92af1059eb24-121f8b65e84mr13876132c88.41.1768071849335;
        Sat, 10 Jan 2026 11:04:09 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c239sm16559538c88.9.2026.01.10.11.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 11:04:08 -0800 (PST)
Date: Sat, 10 Jan 2026 11:04:08 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, gal@nvidia.com
Subject: Re: [PATCH net-next 2/7] tools: ynl: cli: wrap the doc text if it's
 long
Message-ID: <aWKiqKPYiAeeyhPq@mini-arch>
References: <20260109211756.3342477-1-kuba@kernel.org>
 <20260109211756.3342477-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109211756.3342477-3-kuba@kernel.org>

On 01/09, Jakub Kicinski wrote:
> We already use textwrap when printing "doc" section about an attribute,
> but only to indent the text. Switch to using fill() to split and indent
> all the lines. While at it indent the text by 2 more spaces, so that it
> doesn't align with the name of the attribute.
> 
> Before (I'm drawing a "box" at ~60 cols here, in an attempt for clarity):
> 
>  |  - irq-suspend-timeout: uint                              |
>  |    The timeout, in nanoseconds, of how long to suspend irq|
>  |processing, if event polling finds events                  |
> 
> After:
> 
>  |  - irq-suspend-timeout: uint                              |
>  |      The timeout, in nanoseconds, of how long to suspend  |
>  |      irq processing, if event polling finds events        |
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/pyynl/cli.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
> index aa50d42e35ac..e5e71ee4e133 100755
> --- a/tools/net/ynl/pyynl/cli.py
> +++ b/tools/net/ynl/pyynl/cli.py
> @@ -10,6 +10,7 @@ import json
>  import os
>  import pathlib
>  import pprint
> +import shutil
>  import sys
>  import textwrap
>  
> @@ -101,7 +102,14 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
>                  attr_info += f" -> {nested_set_name}"
>  
>              if attr.yaml.get('doc'):
> -                doc_text = textwrap.indent(attr.yaml['doc'], prefix + '  ')
> +                doc_prefix = prefix + ' ' * 4
> +                if sys.stdout.isatty():
> +                    term_width = shutil.get_terminal_size().columns
> +                else:
> +                    term_width = 80
> +                doc_text = textwrap.fill(attr.yaml['doc'], width=term_width,
> +                                         initial_indent=doc_prefix,
> +                                         subsequent_indent=doc_prefix)

Any specific reason you wrap to 80 for !isatty?

