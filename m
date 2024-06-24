Return-Path: <netdev+bounces-106102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473FD914DC8
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C78FB2443F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B113D283;
	Mon, 24 Jun 2024 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTS+9Usw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413972556F
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233739; cv=none; b=mJjiSTIp0y6ODw7nlJLY/W4L+dJgwod+tJ3DIr1b/mtqQpP6VYoT9PYZn+702HUXDPrYh3/Yf5X9dcLuW219gHaOV+/Gh3eB6aK8YV0w7e8ymrFrZ4E6euMXToYQRg2gpLjV5as/fur6jpuGdLpBeoDvbcBnyLzfNNmNuE8dcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233739; c=relaxed/simple;
	bh=XCtCRSpFThJ/lcGlkZS+6fzXrocU1uLYJ58+YjLVHyM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=j+nAZfRadTeoScrziNQGJcYXpYsqiJmvSPK0r5Gld8PDNYn8GzWKw0kuMMRAY0LSFq2vftQ3/ADAuVPc9JrI7t2kskh0un+1Gq8bCuwNr12TkO60NX1CFqR53nWFve2lkgVSLFCWnS04xiXPF1tGQ8nxcyO4Pv06G3F3v7xtJaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTS+9Usw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-421eab59723so31974795e9.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 05:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719233736; x=1719838536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDZN4tvQANBOQzxW9bLFlIHRzrquK3mJ3a4duNtWKBQ=;
        b=YTS+9Uswf2gPzFDK7vsFsoMVO5WVA7eN+pLRvdA9EI4ot7SwJ1v3pNJABoeP0ash8o
         tH60buE1eI1ES6F8eNH3dNWGW0XIbB/UBVj1Th3X/x5fBQ1Z0PDkS0vIKQThadQU5rQi
         1Gxzxt0W6Q6snXoGowHXk8/U4X5jnyH16aUMLLJcOGdywPHuFMojvATCQAw+BqjX68ql
         PAaW9TdVdcydCTTDW1dCZ+HCuEBGoDOCAuf/eBdGRhKOb15GAepkhG/Xd8ak2pwjdms2
         IQ8sKl0Kc/7rT9CopNYlDtKN0WgQBYlA81E+wVWWUC4S7JdiawuK32gr2kldg2wCovpz
         A3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233736; x=1719838536;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDZN4tvQANBOQzxW9bLFlIHRzrquK3mJ3a4duNtWKBQ=;
        b=A0CoPGnoftG5jFcZH35gpPL4fv9lfkTxE31a1Pabg1YmHLg566hR3P8qxNc6kU4WZX
         xk9U2Bggqo2s2N3PpMF3wHiXtPLIZLdE+qXh3jzbp6Rq/xJbkeuB4xj5fI6iDANwKtWD
         JWxaoCkIyfYuTFRBPT+Uc+1494PQcsKIAoL0ej4Yyqlevrt3ZA1mXMXVIE1DDXd3ixBt
         s0iJkyC8PdAxu1rSyZJOC6IFjONUp8HeFJFTeiBDTOjtdv5IFWxY/jQd4gW2vh2ei/mY
         bOzCazhS3HmaURpcbx5Ibj8RPxMNSmhYT8dKrFbRvtUzs9BsHZ7MdbXboBUABlA0w51z
         qskA==
X-Gm-Message-State: AOJu0YxJVv/c/jF74EyvSHIB/tk/EtP1LpzkQ/3lGw++ZFeUuOakttqX
	y13vlAicEWFJeoQVRrrGIqFSXahUHVi1ycSnGedkE+pWtyht/GmO
X-Google-Smtp-Source: AGHT+IFEZhjqXXgj9jV3sUMjszStwBGctT7cgk3sMJaVXVF1ZB485fxv8Uu27ojgVTMTRGup1tlm3g==
X-Received: by 2002:a5d:522a:0:b0:364:a733:74de with SMTP id ffacd0b85a97d-366e4ed3e13mr3810748f8f.28.1719233736234;
        Mon, 24 Jun 2024 05:55:36 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817ab01asm132159575e9.20.2024.06.24.05.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 05:55:35 -0700 (PDT)
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: rss_ctx: add tests for
 RSS configuration and contexts
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com
References: <20240620232902.1343834-1-kuba@kernel.org>
 <20240620232902.1343834-5-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <c085b55f-3b42-1655-ea88-3f6a1e03cf8e@gmail.com>
Date: Mon, 24 Jun 2024 13:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240620232902.1343834-5-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 21/06/2024 00:29, Jakub Kicinski wrote:
> Add tests focusing on indirection table configuration and
> creating extra RSS contexts in drivers which support it.
> 
>   $ ./drivers/net/hw/rss_ctx.py
>   KTAP version 1
>   1..6
>   ok 1 rss_ctx.test_rss_key_indir
>   ok 2 rss_ctx.test_rss_context
>   ok 3 rss_ctx.test_rss_context4
>   # Increasing queue count 44 -> 66
>   # Failed to create context 32, trying to test what we got
>   ok 4 rss_ctx.test_rss_context32 # SKIP Tested only 31 contexts, wanted 32
>   ok 5 rss_ctx.test_rss_context_overlap
>   ok 6 rss_ctx.test_rss_context_overlap2
>   # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
...
> +def test_rss_context(cfg, ctx_cnt=1):
> +    """
> +    Test separating traffic into RSS contexts.
> +    The queues will be allocated 2 for each context:
> +     ctx0  ctx1  ctx2  ctx3
> +    [0 1] [2 3] [4 5] [6 7] ...
> +    """
> +
> +    requested_ctx_cnt = ctx_cnt
> +
> +    # Try to allocate more queues when necessary
> +    qcnt = len(_get_rx_cnts(cfg))
> +    if qcnt >= 2 + 2 * ctx_cnt:
> +        qcnt = None
> +    else:
> +        try:
> +            ksft_pr(f"Increasing queue count {qcnt} -> {2 + 2 * ctx_cnt}")
> +            ethtool(f"-L {cfg.ifname} combined {2 + 2 * ctx_cnt}")
> +        except:
> +            raise KsftSkipEx("Not enough queues for the test")
> +
> +    ntuple = []
> +    ctx_id = []
> +    ports = []
> +    try:
> +        # Use queues 0 and 1 for normal traffic
> +        ethtool(f"-X {cfg.ifname} equal 2")
> +
> +        for i in range(ctx_cnt):
> +            try:
> +                ctx_id.append(ethtool_create(cfg, "-X", "context new"))
> +            except CmdExitFailure:
> +                # try to carry on and skip at the end
> +                if i == 0:
> +                    raise
> +                ksft_pr(f"Failed to create context {i + 1}, trying to test what we got")
> +                ctx_cnt = i
> +                break
> +
> +            ethtool(f"-X {cfg.ifname} context {ctx_id[i]} start {2 + i * 2} equal 2")

Is it worth also testing the single command
    f"ethtool -X {cfg.ifname} context new start {2 + i * 2} equal 2"
 as that will exercise the kernel & driver slightly differently to
 first creating a context and then configuring it?

...

> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 4769b4eb1ea1..91648c5baf40 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -57,6 +57,11 @@ KSFT_RESULT_ALL = True
>          _fail("Check failed", a, "<", b, comment)
>  
>  
> +def ksft_lt(a, b, comment=""):
> +    if a > b:
> +        _fail("Check failed", a, ">", b, comment)

AFAICT this implements 'le' (less-or-equal), not 'lt' (less than) as
 the name implies.

Apart from that these tests LGTM as far as they go.  One thing that I
 notice *isn't* tested here, that I generally make a point of testing,
 is: add a bunch of contexts (and ntuple filters), remove some of
 them, then run your traffic and make sure that the ones you left
 intact still work (and that the deleted ones are actually gone).
Also wonder if it's worth adding tests for 'ethtool -x ... context N'?
 You have it for context 0 in test_rss_key_indir(), but on custom
 contexts it can exercise different code in the kernel.

-ed

