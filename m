Return-Path: <netdev+bounces-227353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0389BACEDD
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD6B16EDCE
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E0530217C;
	Tue, 30 Sep 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvk+UXUK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A72FF14A
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236604; cv=none; b=oJrG0h37jfGtHMAALdy6U/NBiDteIXzow7+MpJEYoZZqS86F+3fiilb9E7mXZMsbMb3LLFYrEUPpUdbqK+Q/b8ymmkBZSV14YTT73RmJqn47lLT52Wz7qAldceYUHQL/6dC1jteYCgwWg6OYiITfHQb1QfGKt20FysjSlljbwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236604; c=relaxed/simple;
	bh=CXTHR3+ruv4b2NmSi2QyXZZoVB+RVVvtqzPGciNVlhQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FjkdRg4pFILv58MetObFPU+rM3INZaKgyTtoF5jrvAvTSuGOnunO1PgxEs1gxdWocmxCLc7wnx7iKxOt0ux7yh5x1SABsrDQ3eOr94Rwvl+qwGkj3OcpNqhWD3FSmwtO8ysKn9/6ft8ER7Xvv1ZI5Z8699GHS7dEtQWiqdYEis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tvk+UXUK; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5838680e242so1854169137.0
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 05:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236602; x=1759841402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DIF8xxMKs45jgicXUY8+fOYkrHvhQ+64uTG3AYNzDU=;
        b=Tvk+UXUKR42fXurqNX5CdCRTrz97ra7T/rehDSWu/Kv9o1HhYT1Kx5ECY9DTL80ne/
         pm/LtH+QDZ4usoK9jUR89XgUGnJUZ2Qe4pL/wCUgBCTn4d3HWF4zsSlMM/7zzx7JhvCc
         g9pnajzLLnXM4AyclMxKSnLnBL3Lcts5SxwNDZvmOB1A8ORKfpZ2RXYj1snSoUBw2ikm
         tIXrQwN/XULzh30zcPbF2cz1RAsObQHv6TqDXXIhuWhOsdm8vAefd91xpIoH2SUdhSwW
         lMotnX8RjG4AEdvUIDVp/wT98drwzwzk1bS5bkuBnKZ4qfaOXdbInW7ZRLKLhHhpStv2
         gJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236602; x=1759841402;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/DIF8xxMKs45jgicXUY8+fOYkrHvhQ+64uTG3AYNzDU=;
        b=FiYGGatccpQDux61Oo+si+3QUtBElhl0iOIU8ZsBPdaHLJ4lF6SIbDZMcmW6L8Cat4
         bSuWZV2LpAxAvLPCLTzlm5te964BaBWQgSePjRsjekYAzdQbbzwj8jIsuXyyJjsKJi60
         gz1jEkvWFRUAU14gdrokz4IIm2hp+TWUk9mX44x/UcYcsdy/o6Eyr2w/hxR13Gdn1OQD
         z+IvneD14He+j9b0xGwVxC0sta7IuFT8lsQFwzLeFB+4a8lXnWRytjN0qa5otpfUT+Lx
         RoAcsnOn3Uc7/ACSlJvk+XXcvB1V9tUfFLrq1pW8cXcjQvwNbI+EmG35k18kbevQv3fe
         PGkw==
X-Gm-Message-State: AOJu0YyGaG55rB5K0S3tnXXkw6Z7Lt9lAF7tUrRWbYyTdKb/66nOR9hS
	AHxpF8TulyvOAwNspsiRfb+ztlGMBrjB7P1bnSa2z3bylaCLjZKjfKNJ
X-Gm-Gg: ASbGncsPpCz60KrbVP3flZhcJJCQ5qONxPkwJhc2VMV3KolGzBSWY5IAxYwnrijJnaP
	r0bmzG935aFu+DiunDjK4+VdJ9C2on/NiPLrXug4QGRmEm5LaDp97ChOwdPhytASD2u2T3juDSD
	kGw8W3zbSRc63wDtNDdTOu3YyGR/JA+ENVO2GXefXl5/rKu5pHBUacvxnYxIUsgKhWRWn2lpjGE
	PNR1rWgkOfG+tOKq7ypV2UUlu6dtaRAXHB124NXT9zoc6yf8yOTTQO69rO3gggKniKaiPuXUiMa
	1xTm5Jg/kpN8AaMjH4O4yaE8vzQa4bHJzauDDq9FnZD8V0zQsDtSNfEfD62vCl/vLnhXlT1p0/Y
	XtDbnWeclhUywf5gVALizWeoqBx1dAHIaYX5ePz3l7nqYzmHfP5u8/MOEWvqqJFfPNmvk88Zs47
	26x8bQug70CdcJBxuXaAC7djgfzRVkQTzxvk6mAYg=
X-Google-Smtp-Source: AGHT+IF3jXqpSXTJaRkGEMK7WKJd7LDbG8wy3D5EeY7LmVpdZLbKNSI6KpFy0rL2Q30+2atZz2NZEA==
X-Received: by 2002:a05:6102:3906:b0:4fb:f6ea:cf88 with SMTP id ada2fe7eead31-5acc6240067mr7922871137.10.1759236601986;
        Tue, 30 Sep 2025 05:50:01 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-5ae389dd1fesm4532961137.12.2025.09.30.05.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:50:01 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:50:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sidharth Seela <sidharthseela@gmail.com>, 
 antonio@openvpn.net, 
 sd@queasysnail.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 kernelxing@tencent.com, 
 nathan@kernel.org, 
 nick.desaulniers+lkml@gmail.com, 
 morbo@google.com, 
 justinstitt@google.com
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, 
 david.hunter.linux@gmail.com, 
 Sidharth Seela <sidharthseela@gmail.com>
Message-ID: <willemdebruijn.kernel.30a447f86eaaa@gmail.com>
In-Reply-To: <20250930120028.390405-1-sidharthseela@gmail.com>
References: <20250930120028.390405-1-sidharthseela@gmail.com>
Subject: Re: [PATCH net v5] selftest:net: Fix uninit return values
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Since it's now only to ovpn, better prefix, which matches other
patches in that directory, is "selftest/net/ovpn:"

Btw, review the posting rules. Leave 24 hours between reposts:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


Sidharth Seela wrote:
> Fix functions that return undefined values. These issues were caught by
> running clang using LLVM=1 option.
> 
> Clang warnings are as follows:
> ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>  1587 |         if (!sock) {
>       |             ^~~~~
> ovpn-cli.c:1635:9: note: uninitialized use occurs here
>  1635 |         return ret;
>       |                ^~~
> ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
>  1587 |         if (!sock) {
>       |         ^~~~~~~~~~~~
>  1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1589 |                 goto err_free;
>       |                 ~~~~~~~~~~~~~~
>  1590 |         }
>       |         ~
> ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
>  1584 |         int mcid, ret;
>       |                      ^
>       |                       = 0
> ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
>  2107 |         case CMD_INVALID:
>       |              ^~~~~~~~~~~
> ovpn-cli.c:2111:9: note: uninitialized use occurs here
>  2111 |         return ret;
>       |                ^~~
> ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
>  1939 |         int n, ret;
>       |                   ^
>       |
> 
> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> ovpn module")

stray line

> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> ---
> 
> v5:
> 	- Assign -ENOMEM to ret inside if block.
> 	- Assign -EINVAL to ret inside case block.
> v4:
> 	- Move changelog below sign-off.
> 	- Remove double-hyphens in commit description.
> v3:
> 	- Use prefix net.
> 	- Remove so_txtime fix as default case calls error().
> 	- Changelog before sign-off.
> 	- Three dashes after sign-off
> v2:
> 	- Use subsystem name "net".
> 	- Add fixes tags.
> 	- Remove txtimestamp fix as default case calls error.
> 	- Assign constant error string instead of NULL.
> 
> diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> index 9201f2905f2c..8d0f2f61923c 100644
> --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> @@ -1586,6 +1586,7 @@ static int ovpn_listen_mcast(void)
>  	sock = nl_socket_alloc();
>  	if (!sock) {
>  		fprintf(stderr, "cannot allocate netlink socket\n");
> +		ret = -ENOMEM;
>  		goto err_free;
>  	}
>  
> @@ -2105,6 +2106,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
>  		ret = ovpn_listen_mcast();
>  		break;
>  	case CMD_INVALID:
> +		ret = -EINVAL;
>  		break;
>  	}
>  
> -- 
> 2.47.3
> 



