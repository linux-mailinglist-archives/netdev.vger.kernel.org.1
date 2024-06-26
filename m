Return-Path: <netdev+bounces-106867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F490917E42
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5121F23D1D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D672017B506;
	Wed, 26 Jun 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/UzYfX+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86216EB49
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398211; cv=none; b=rtkEGCvBdY9T5t5ZTMDQqZO2PkD9mOo+zSHnZIQlmyV6ixnBYzcJx9URLj4JMGqukYlXKoMmddlHMJQVXz5+ps5UN91LPW0figbBYHbGjb8I1xVcE76penMrsr9ZUvIz2XVk/9WDsdUrzIUlkftvfaj9TkT0wJlf+TM9DNJ8yAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398211; c=relaxed/simple;
	bh=WfY06YSzNyp6336qc2ghuApcOGkpX6FKJgq59rZYQEo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MwaKfll2+xZP9X1xawEYGfpj/oAYhsEgZJeFxtwnUbTswGE5eBxy7EL2JtrB9drJG88qgkhg9q6tIDSfCXzadW6U3iUXqzh3tLsdflopUxwziNafKS06dOIH/pE/Ko6e1+whFu0WVWibqRCx8KXhfTot4Ohs/0i6TipPRHqJtjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/UzYfX+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79c0b1eb94dso84774685a.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 03:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719398209; x=1720003009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YxDNvZCDWk34wSnApraIz9T6HD0e/VqFv2u5BkZ2BE=;
        b=d/UzYfX+NhHqymQNoGSBlU4K0UVeG95mGXjB6og9mRJAr5rGpOOMZ+NUFazqf4apP9
         l9pb1qF+/Js2W1uDG+TK7qFN8UUbIqTCHcWGBMM/poQN1fXs/bA8mn3yT47NHCP1KwTF
         JQHL4tZYAlixaVoqUsDXnnl+bSkyy2xRNizkEQM2+6rrtBl0PMpXOr7+udN7B/NAbWv/
         vpxrTafryL8B2vLkLC/51/6wF72suYhGxSgnU04cQuxeQVhygASTzSRE5IqoUPVuES6p
         si0AOF5jQSlvDEEnCDf1zQnu21s6VzgKCl00qb70QkQvmqIQX4/2kp0oC5rU+kGuCyNL
         tG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719398209; x=1720003009;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+YxDNvZCDWk34wSnApraIz9T6HD0e/VqFv2u5BkZ2BE=;
        b=BrqwL5lVG2P6TqVEDb/oFCpg3Z/ZXQdrIBByJ+GsCggJlaEhrMr4jaeaRhbcyZdMVR
         +7Hkbq/zbKqLRAntFTwsgSSdmDTaOvX882XN9n8Ax4zdhML3mcJyqld0pFf6m+UFzPQW
         jqzeEnAuRMpTxjJdNQOb4/+muyk6Ql2isBAqVp493y4ZLeCQHMDUTVFtZ6dTBIYhBrss
         TAnMXrFnKZbIDZdAchYv8ej1p/zKE6fhzFSCxTDln3wdbg9TRUkKZaAnMBHmCQN83tC/
         vw0xvrJDl2O0R/Xi/5l5MkJkQygMmW0KwrgR9wdnHoPBOr/eqhCTl4BXkUg2sUfaOuDs
         1NuQ==
X-Gm-Message-State: AOJu0Yychne04jBNAsARuIscgtDWDSga44lHMqu9464av8gDQqr44xzP
	8IqiXUhnENGlhKRM+AdXA1NqZriKu7lmz/KnrE6DL5xJRs1Eh7k7
X-Google-Smtp-Source: AGHT+IECMCYG3clhce86HlCa4z2vmM1EVZwiR2e/9f8hukYruZ5L3Mn7VLdKbe+/o8yV2TB97eUpog==
X-Received: by 2002:a05:620a:4589:b0:796:842c:7804 with SMTP id af79cd13be357-79be6d5bda5mr1133905985a.18.1719398209062;
        Wed, 26 Jun 2024 03:36:49 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79c04daf1d6sm137600785a.98.2024.06.26.03.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:36:48 -0700 (PDT)
Date: Wed, 26 Jun 2024 06:36:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 dw@davidwei.uk, 
 przemyslaw.kitszel@intel.com, 
 michael.chan@broadcom.com, 
 andrew.gospodarek@broadcom.com, 
 leitao@debian.org, 
 petrm@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <667bef407a84b_3cd03a29449@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240626012456.2326192-5-kuba@kernel.org>
References: <20240626012456.2326192-1-kuba@kernel.org>
 <20240626012456.2326192-5-kuba@kernel.org>
Subject: Re: [PATCH net-next v3 4/4] selftests: drv-net: rss_ctx: add tests
 for RSS configuration and contexts
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
> Add tests focusing on indirection table configuration and
> creating extra RSS contexts in drivers which support it.
> 
>   $ export NETIF=eth0 REMOTE_...
>   $ ./drivers/net/hw/rss_ctx.py
>   KTAP version 1
>   1..8
>   ok 1 rss_ctx.test_rss_key_indir
>   ok 2 rss_ctx.test_rss_context
>   ok 3 rss_ctx.test_rss_context4
>   # Increasing queue count 44 -> 66
>   # Failed to create context 32, trying to test what we got
>   ok 4 rss_ctx.test_rss_context32 # SKIP Tested only 31 contexts, wanted 32
>   ok 5 rss_ctx.test_rss_context_overlap
>   ok 6 rss_ctx.test_rss_context_overlap2
>   # .. sprays traffic like a headless chicken ..
>   not ok 7 rss_ctx.test_rss_context_out_of_order
>   ok 8 rss_ctx.test_rss_context4_create_with_cfg
>   # Totals: pass:6 fail:1 xfail:0 xpass:0 skip:1 error:0
> 
> Note that rss_ctx.test_rss_context_out_of_order fails with the device
> I tested with, but it seems to be a device / driver bug.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> +    if a >= b:
> +        _fail("Check failed", a, ">", b, comment)

Should the argument be ">=" too?

