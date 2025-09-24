Return-Path: <netdev+bounces-226087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B1FB9BD82
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 22:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B941BC27CB
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 20:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C362328563;
	Wed, 24 Sep 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfPJE5UZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AEC327A14
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745271; cv=none; b=IaueQEU+9AlyhuoLoTbi+b5R/JCSLmdtXwG2pXwRGA1j6RkEznYdDCITDZACOX039ZGZtG7Drn4rgS7tDUa1PosOSXM0Gh94ON08VgEMY7Ah1hmDf2f+C2TzhuKTXhGVGUgpY7XVNVWmYf1gzIMHr1zEejwiTdIe/GhpIicYMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745271; c=relaxed/simple;
	bh=i4tepmVLJF01K2/9GNZdWtMm6Bdzo/yVQxDSsWRN+Jg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Qf46qxf2waud/h/d3T2hW4SE/uowjXLgbXWufu01VP7Di+O/w5SCw0q4bQidCkOyn6EqWILqgIQ8lBfnPFH68yPavoUlWHQaUlptjv9ZDdkYuioIMPy9QTJnhvIY0eloxjTnrho6U7+cnMfdHPx0kz1s8z0He0zaC1ynnN/w6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfPJE5UZ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-84ac859df55so42598985a.0
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758745269; x=1759350069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wlEDUguwj3kgwA2J5nd0z5PycLVbQ//dyWrS4QjJvE=;
        b=CfPJE5UZ0/qSDB1EhduAsLKwdjWvTYSjaio8Opmyd18r/+jw0e697R+mz90h83AZjo
         SRLJtuFHbewoUXxeViJhRLmeA+NHziVTsr2ZQ+7Wai81y37sJUEvN7GRyHo2BhOHUWEs
         FgR4mBkMTUtvENcQCYI8pNQOYUjVKm3rUkK0O88URS5YzecZ9CFvMCIcuyBK9Z0F1gq1
         5MU+k2xXerYvD3rSZ6FynmeSL8vQqP4NhkIEVs/GWrsAdmxg9Pe9H7s6uTfKga9FdyTh
         CTnM3LoFed1pSb9McS94N3j8OW39LabAGRSILM9Z8c6koyJ0M3PByN20hUeq5ZhP1lB9
         P2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758745269; x=1759350069;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0wlEDUguwj3kgwA2J5nd0z5PycLVbQ//dyWrS4QjJvE=;
        b=rikNvx19jO8gaXL0hKlt+5dT0S9JgoPJjvpXCKEtjWh9nhPVolNsk4ubDPtO5EGFhs
         B9STcYm2U0ms7CMm4vKaVBkMzjwQbwzJnLldu7vig93wHCT7Fpq7UCG/wbqmKBYKljbq
         virCQdcMf4aoq+tpeGbtA+11ze+zxXqtcpgQv70d8OQQsCTdZ8Ghj3WgYOLCY+vE2WFw
         z0J4U+9r6rEUqqyHSikXx0hueFti9vm6EinWUUJ2MXS6AaNnioFrOx3zWtbY5OIK++2+
         9HchfcajoBi3lsWpvpYABqyMZdY31Xttuil77gto056uAR13HuB+DObOa+3U7lcAXfR/
         CbZA==
X-Forwarded-Encrypted: i=1; AJvYcCVKt2paQYUrrTXXaWZnbYn+SXDYEmxVjdTiAZNszm4KdX/QerfR04YiinAnsDDgdcufTnxs4tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgppmx6ugj2Z9FOFsrLsOt7MvHGC7VyxtbN7IuqbTrdjBy7uyb
	lnNH0mu64aoe1aal12HvzSNJjkA44fI73Io8vT7XvcyxsNj8HbW26CkN
X-Gm-Gg: ASbGncvMrPvnqlI/Kiw5fkcx/6zasrVBtu1zVlymF6Acfao4jqL4LPBqKJofYO5HLyz
	IEaeeiNoak8fxluwMlpNc/BcIRTOYLKCKxv2BWUVHS0OmgsVmQ1KYjmSuDRNbw26PQ8/aKl0p1g
	+pt5qJFZGEugLUI/5dWTi0WAurDqtu1zu1qNYyyuiJ8SQfh+8nwpPCQG5tnRg5RxiXU9KsYv4fJ
	4rHCK3jJnUCFc3yk6G24zmdeN0UIwsgxCTn3D2/p/b4jGIFcKzs5Gas/KGhHzCJ3VCjm2yuXjpH
	iPynxCBiy5qjLzup4D+kAQzvvZE+lvJfmc3NWUsOeXDqQbczGpTQGJPV6GUHtdDgcYQl8Jexfii
	F+nX1ymzpV014kXwt42qoMpQUMnS96xmW2WKiCN8dOkM3bnoXepeZLCJEuN1Qqhn6cZpn2/0PX4
	gbJRgl
X-Google-Smtp-Source: AGHT+IFibZxWZirLt9Olg9HUXAjXOqN7fGVG5ACXJFneXFmMLHtLcJNCl/n29OHLI2egwWYfcrXagw==
X-Received: by 2002:a05:6214:5295:b0:7a3:b6ab:6f2 with SMTP id 6a1803df08f44-7fc443d9de1mr18600436d6.63.1758745268685;
        Wed, 24 Sep 2025 13:21:08 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-800fa5f6dd7sm733946d6.0.2025.09.24.13.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:21:08 -0700 (PDT)
Date: Wed, 24 Sep 2025 16:21:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wake Liu <wakel@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, 
 Wake Liu <wakel@google.com>
Message-ID: <willemdebruijn.kernel.2b5618e3b2d34@gmail.com>
In-Reply-To: <20250924044142.540162-1-wakel@google.com>
References: <20250924044142.540162-1-wakel@google.com>
Subject: Re: [PATCH] Net: psock_tpacket: Fix null argument warning in walk_tx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

[PATCH net-next]

Wake Liu wrote:
> The sendto() call in walk_tx() was passing NULL as the buffer argument,
> which can trigger a -Wnonnull warning with some compilers.
> 
> Although the size is 0 and no data is actually sent, passing a null
> pointer is technically incorrect.
> 
> This commit changes NULL to an empty string literal ("") to satisfy the
> non-null argument requirement and fix the compiler warning.

Which library defines this argument as nonnull?

I'm not aware of this restriction in the POSIX standard.
This pattern is quite common.

> 
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  tools/testing/selftests/net/psock_tpacket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
> index 221270cee3ea..0c24adbb292e 100644
> --- a/tools/testing/selftests/net/psock_tpacket.c
> +++ b/tools/testing/selftests/net/psock_tpacket.c
> @@ -470,7 +470,7 @@ static void walk_tx(int sock, struct ring *ring)
>  
>  	bug_on(total_packets != 0);
>  
> -	ret = sendto(sock, NULL, 0, 0, NULL, 0);
> +	ret = sendto(sock, "", 0, 0, NULL, 0);
>  	if (ret == -1) {
>  		perror("sendto");
>  		exit(1);
> -- 
> 2.51.0.534.gc79095c0ca-goog
> 



