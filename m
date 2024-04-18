Return-Path: <netdev+bounces-89421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3021B8AA3EE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E981F22712
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCDD17335B;
	Thu, 18 Apr 2024 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMBeJtxk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B81836CC
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471413; cv=none; b=STxZB9zus9aP1OypUUVtTIhhCcpO3c3UYRtJo+vubUGXc1qCJ/eYrmDoCnZVMjoe/rbZZLFo8ruyR1OxlsK0rFE2IOvDD5+z2+TMycBqo2jwLtZRgBOUeCLvssnsVC9oYD08Q7uIh1Mc/7cAlTFI8PkDOm9FNobFzIAK7UBQvbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471413; c=relaxed/simple;
	bh=sxPYPc2oa78fVTaAEGtgyMv1icwPRFja6crl/u3n6Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTTT+IzBAqx9SvpZwOF+JdCALYJQQuVaqD6P8vykHNSDLLU0PL+PwW10goRjZ3Mzj9DgHgkMSu7hs10zOb58MRaRS9ejtTNeJpG77BoGOw3AZhMCeKZrV1SosPpJ50sf1Aca8OXvmOjJajAaMTQvI1A5w0isOD5DkorZEajVm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMBeJtxk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3481bb34e7dso726535f8f.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713471410; x=1714076210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUJLXqyLsT7uEfGky6XlEof/G48boH2D+OqrPBPpmUA=;
        b=hMBeJtxkYs4uRfrGTgN619Zu0h3i1aZJzBGYWKjyDkGy220Ktm7i8/tjwHRfgnX/JR
         UREYXlQ2DF4UFgfnFJ/LoyK2glCSM1+TBDX8XPzAQqftQNSzfFODVgjV4yGZ0GBJtakN
         bdNUp2Ru87vkETkg5As4eDB/x2bxCqd6Cjdz0LNh9SVbUEaaFXF/NCC67KgXzXLIQP2C
         VXOZ827bLtwzoFi0+6Buh0lWHY3pfCmsb7/CVNR2Gzpi5oirPPwcsRdFZ9ARXyskabTR
         T0V0IS4fohNNxOudkOevY19jGfEL0DrpB+LacJJ7NvAM6n25V1BxibobE5OuL8GZnQmD
         9lCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713471410; x=1714076210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUJLXqyLsT7uEfGky6XlEof/G48boH2D+OqrPBPpmUA=;
        b=oVDonqTwvU5LqWIQyc5CyEFECyk2SCwS4MMSm+LNmtd4MZmMJRi77ZR/P+inK69b8x
         M+hRnQhzgXVo9dgIoxr6CLE9F476FzS41b1NL1Kmnc+zlcsKurV0YTLoe3V/D0Uj3Tpg
         +7meXyZu5Y50bFQtMf2AjjOlm2sSB6/NuvfJUGGWHG6lG77IpWGGFq5FVIvoOUahexW3
         t5qJr/180gg5vj/sgKzIaqm8oxSTzbJPRxnf6Nw9r9a26g05/+0gFk2vcDiKRZVwe+oW
         hFxhfcEXRDNbrjCcGoZ5UQ0feetW3uu38fuqNr9QoOaLhm6H93ErVM2eY+0g2h9LJLbc
         MXaw==
X-Gm-Message-State: AOJu0YxKUJoirrZLwb0y8Us/SZj9hS7R6H/wMrqWoMm16ab9zBr9rz6T
	//xPNKv3jWvmuPt+gEB6vjgPV8oiN84rVmS13fbkrZE/xl2YR5pMToz48Q==
X-Google-Smtp-Source: AGHT+IH0Wdd06gacVo92O5cOLLu3eq1S1Krh4ewHa4rqLThLJFJGK+unNFvar/uPp4qNRmlgw/CnyQ==
X-Received: by 2002:a05:6000:1841:b0:343:70bc:4578 with SMTP id c1-20020a056000184100b0034370bc4578mr2422142wri.70.1713471409829;
        Thu, 18 Apr 2024 13:16:49 -0700 (PDT)
Received: from abode (93-173-236-10.bb.netvision.net.il. [93.173.236.10])
        by smtp.gmail.com with ESMTPSA id cp37-20020a056000402500b00341de3abb0esm2675174wrb.20.2024.04.18.13.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:16:49 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:16:46 +0300
From: Yedaya <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] ip: Exit exec in child process if setup fails
Message-ID: <ZiF/rppvSxED2W8m@abode>
References: <20240324163436.23276-1-yedaya.ka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324163436.23276-1-yedaya.ka@gmail.com>

Ping - in case you missed this

On Sun, Mar 24, 2024 at 06:34:36PM +0200, Yedaya Katsman wrote:
> If we forked, returning from the function will make the calling code to
> continue in both the child and parent process. Make cmd_exec exit if
> setup failed and it forked already.
> 
> An example of issues this causes, where a failure in setup causes
> multiple unnecessary tries:
> 
> ```
> $ ip netns
> ef
> ab
> $ ip -all netns exec ls
> 
> netns: ef
> setting the network namespace "ef" failed: Operation not permitted
> 
> netns: ab
> setting the network namespace "ab" failed: Operation not permitted
> 
> netns: ab
> setting the network namespace "ab" failed: Operation not permitted
> ```
> 
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> ---
>  lib/exec.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/exec.c b/lib/exec.c
> index 9b1c8f4a1396..893937550079 100644
> --- a/lib/exec.c
> +++ b/lib/exec.c
> @@ -36,8 +36,13 @@ int cmd_exec(const char *cmd, char **argv, bool do_fork,
>  		}
>  	}
>  
> -	if (setup && setup(arg))
> +	if (setup && setup(arg)) {
> +		if (do_fork) {
> +			/* In child, nothing to do */
> +			_exit(1);
> +		}
>  		return -1;
> +	}
>  
>  	if (execvp(cmd, argv)  < 0)
>  		fprintf(stderr, "exec of \"%s\" failed: %s\n",
> -- 
> 2.34.1
> 

