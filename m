Return-Path: <netdev+bounces-182588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C3BA893A3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D5A7A204E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 06:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F1823E25B;
	Tue, 15 Apr 2025 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNaU4YwN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE01F94C;
	Tue, 15 Apr 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744696993; cv=none; b=WDBefIu/cvZQvU37UkUpKspkNv1xi043Q8YSuZdX4RJoMfFQZhfo6eF0u9jg7zDDjRTkFwrZDfeYtCrrLnORqzeCcVlV//nJvX2InvyhHHexbxyikiEYpnCC2zNM5Cdls4Tf/3BC5la1fzAtSSgj4XDsFeLHyJm9NTwAssgL078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744696993; c=relaxed/simple;
	bh=hlfRVJJuCs5IUDWSAYIIaABehbmvmvVU2UhiMt1D7Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbOUq1FnTKDkJ3OpVPXWkK6s7W1wcafLymC9Loj1NVZbWmo77Ad+WDoI9Cf597L9AO0ALAijO4Jn/HKYoYRpn9XNEVIQ72wYGf4f/GZyf8+VngnGtn72Hi3OeM5ZPLxGDwHJBVz+1T7X1jWndxYi2eTWmdSD3WycfLc2gOsgJ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNaU4YwN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2243803b776so75712655ad.0;
        Mon, 14 Apr 2025 23:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744696991; x=1745301791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7Qk1X0o8DMfzX4pCXrk+EkWVL2wErXcBLH6oWkB2gc=;
        b=jNaU4YwNXTNQcEtkGVof0INKK6pgZv9tpXEb6Y83k5V4NPEQTnuA/mbP7NGN2G5nzV
         I5zRKV+btuZN9/SccVcsi8uzI5W5Z2ez/49cmSzJOge7bC2eGnWqVpgQ6lA6FMyoY0nR
         RnzJSJecuExqUivJ/nRqe0x3lJPPLoO/PWtZD04HUFciGC84fwvOOaCwNxCDN+FbFpw3
         tPGCL8fHS2RnueB32m8NKQBffoU8iwAyPt1bJASo3JS6amjvTk0l61XwPMSbAN7awc6m
         tBjyu9K96V8wegejswvbBakfL3EvoKyY5h0fDJf4k8C85GZFQe+RTN57sQ1awHm66veh
         +VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744696991; x=1745301791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7Qk1X0o8DMfzX4pCXrk+EkWVL2wErXcBLH6oWkB2gc=;
        b=mwOEGXZuzrr7stBRCik885kCi7fO5bkpXQHDGKXDZgcEkJLXPTT/XVLNmmJA7Hcli6
         EtWmip98AHXtBAF08hPEIxuIr5ZRPXXZJ9LJnAw5Rm6LJ9J7U8rVSBoHoQ7IVTBTeoIj
         fZb+rjnNJwLHanQ/g4cWq8WjftdPLbrLAFCn0reWRUFE5lg2DVXKxwpINfof+QCBOR99
         uF/KQW93IzDoQLGndHGSij7CQS3gffqf2ZHDMX+gYw3kV++LIDvfmsJi3xJLGx8U0E/h
         9N4BpE68rfffB79xY/IpmndT8sLSuFjk8DEuV9iBJNYfc9IzqKteu/GiClD9nUhyGZP3
         yriw==
X-Forwarded-Encrypted: i=1; AJvYcCVF0wGlDnJxKNs8n3OqeVC8r+cYCNPUrGPI8+9WykEeWzTDbxdVi9tsFSjTQap5fpbbtmnqi57L@vger.kernel.org, AJvYcCXj92AepOoiOK3zuEhpSNyynSJSSJlOyclt1PWnJSvz3Z8+d9RdkjLhGQC4HRKWIk454MaVIHRpRvtb1gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZ5reuhTSZd4vBr80yxPjpn6a2w5uoaSNJVJQhF9/LZ3b2B+U
	t3lPPV2CrCow4APws9b0NVI70yWRRNBTo8z5K0XWPsnv8N405P7s
X-Gm-Gg: ASbGncuMI7PhF8aSYrlR/QiMxTnQJE4buEAoDX1GicmspFTx1B0YdLcD/LKgVtr1wam
	3P6mhOrqNMUZXvUUvL4SoCXAuCUbDHjC7qTvkAPsmA4SgsgCldJXlEuWK3Mr8g0jnolpJC3NSpL
	+pLVGLIo7gQ/zvGvOqm9r7lBdub8PKJZLT+iJEs5IAEzCeWQjiBlqijvIk5wWqmfieQtOmgQ22i
	FSsfmq7ZOHCMz7izp6lwMxiyOON7DQtjAUDUSl54mhQNhgA4xPein8kgYp5uI6+R9aUbkFAsIDe
	O7AYDV6rQmGpmJCozlu7A4hMlCy02GmJLg==
X-Google-Smtp-Source: AGHT+IEnh2WnuJkEMg6P4jG7ned0rdmBUdJoSbyLSkHpmGP3JOguPi/WvzLsdJ+V4IbKDgU4B/gBFA==
X-Received: by 2002:a17:902:d544:b0:223:397f:46be with SMTP id d9443c01a7336-22bea4fcf94mr215343255ad.47.1744696991321;
        Mon, 14 Apr 2025 23:03:11 -0700 (PDT)
Received: from nsys ([103.158.43.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd12b4d5sm13759275a91.25.2025.04.14.23.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 23:03:10 -0700 (PDT)
Date: Tue, 15 Apr 2025 11:33:06 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: cxxz16 <990492108@qq.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, bbhushan2@marvell.com, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Subject: Re: [Patch next] octeontx2-pf: fix potential double free in
 rvu_rep_create()
Message-ID: <tzi64aergg2ibm622mk54mavjs6vbpdpfeazdbqoyuufa5ispj@wbygyurrsto5>
References: <tencent_20ED8A5A99ECCFE616B18F17D8056B5AF707@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_20ED8A5A99ECCFE616B18F17D8056B5AF707@qq.com>

On Sun, Apr 13, 2025 at 02:16:39PM +0800, cxxz16 wrote:
> If either rvu_rep_devlink_port_register() or register_netdev() fails,
> the function frees ndev using free_netdev(ndev) before jumping to 
> the 'exit:' label. However, in the 'exit:' section, the function 
> iterates over priv->reps[] and again frees rep->netdev, which points 
> to the same ndev.
> 
> This results in a potential double free of the same netdev pointer,
> which can cause memory corruption or crashes.
> 
> To fix this, avoid calling free_netdev(ndev) before jumping to 'exit:'.
> The cleanup logic at 'exit:' should handle the freeing safely.
> 
> Signed-off-by: cxxz16 <990492108@qq.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 04e08e06f30f..de9a50f2fc39 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -681,7 +681,6 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
>  		eth_hw_addr_random(ndev);
>  		err = rvu_rep_devlink_port_register(rep);
>  		if (err) {
> -			free_netdev(ndev);
>  			goto exit;
>  		}
>  
> @@ -691,7 +690,6 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
>  			NL_SET_ERR_MSG_MOD(extack,
>  					   "PFVF representor registration failed");
>  			rvu_rep_devlink_port_unregister(rep);
> -			free_netdev(ndev);
>  			goto exit;
>  		}

There is no potential double free here. If you notice the loop at the
exit label has a predecrement (--rep_id) so if rep_id is say 7 when the
rvu_rep_devlink_port_unregister or register_netdev fails, then the loop
at the exit label would free from rep_id = 6 to 0. And so the
free_netdev calls on those two lines are required.

exit:
	while (--rep_id >= 0) {
		rep = priv->reps[rep_id];
		unregister_netdev(rep->netdev);
		rvu_rep_devlink_port_unregister(rep);
		free_netdev(rep->netdev);
	}

(De)allocations in loops are quite tricky.

Nacked-by: Abdun Nihaal <abdun.nihaal@gmail.com>

