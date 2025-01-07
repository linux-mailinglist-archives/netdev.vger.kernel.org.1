Return-Path: <netdev+bounces-155832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A7EA03FFA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7605D7A1B62
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0CE1EE7AB;
	Tue,  7 Jan 2025 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMcYLRQE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3921E9B39
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254559; cv=none; b=I5vwBiFvYHNq0l7l7aNWdFCerPpkj8Dz6mN7mNNhon31VWgvwbnkZ9b+cy+pwmSeFTIuOJPplIm8XPedvKLlqfHPSTafkUg7cWgpeKCiXt3Jk8qqgpuEj3Nwv1ahxyWHuyVCkbCZoN9K0V9/+yUpiJgQXH0uUs5bWxIowT+46Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254559; c=relaxed/simple;
	bh=JF808BppjAt3PD19li8xODTLj1BsXOfpaXjK5erP2DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQrmBJ+1gjM0QM7qwtSSbewKpFzrNQELRpKoNLOID2C9nbd4zZzakvlQLM8VyoSiRI4Nr7ILl1huhdMrFwqLwnLjkSn4laINcUf932paxd9yfwi3VeHqN1ovBa1pFsLsto2cd8h8s65YX301a8+UMrdfZtit4BVQBYoUP/e54KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMcYLRQE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736254556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIvHNcbKV91l888L6x154xq92Lnl6od6ZW9drJwxM+Q=;
	b=gMcYLRQEhA1jCw3IPhPyLK8sLYUxlRxZiUiVxWXjB4R7JvSocxyHizT1AOhc7aT1X+RFSr
	GAT5IUipVideaa9UqJ99bcb/E/vcts+0Em2Z0s6uKCjIrtUTnn4AC5zLvVO5Ky/Huv0S7v
	jW85VI97vwOP2h6W854Fqe6+hm+FeJw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-4Oagy7eKOYqtQILCnBbdZg-1; Tue, 07 Jan 2025 07:55:55 -0500
X-MC-Unique: 4Oagy7eKOYqtQILCnBbdZg-1
X-Mimecast-MFC-AGG-ID: 4Oagy7eKOYqtQILCnBbdZg
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8fe8a0371so257746636d6.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 04:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254555; x=1736859355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIvHNcbKV91l888L6x154xq92Lnl6od6ZW9drJwxM+Q=;
        b=ZXaCBBu05N6mrGriTUz8JViT7VtjNCO1ZDxvDzLYMhjNK0EODUQLGl0tsQ8+AO+v2t
         d9ga+Obtp4mBwV0cRKTflhHGkM6+uAnlN3jl+McBgc5V97Rjw4hECL5lTxRFgMA3o9p9
         rLP99dYvxz+XTLFTfzh2NZHdBrPCQGd7eNRqlDqa/igGJOp75v3tai2YYJ5bl3ZyHpbq
         aFEtWeoBVFB5HHfbOuDtovFB+BCCB2yS+gI4LYqsA8SGLB9jSzEsHVZqD+o9fm1OLMGV
         afyYjKQNUy4V2qvxfxwNq/FJyFJiof2XBZuVvrSpx0dhGp0wwKzmQLqsXKBEmaNxkXcU
         xmYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR35odSV6lrx6+38MURLV6eq5ieUhVpbwdmmZR57FaJ8lTJv3ELGy5Zt5wX5nftZsOO4DyPkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzASb7im2hbi8nNN8WEdsPQtPO5RREhyzq1CnMHlEyDbEzf1eTc
	06f+RWd5HhDud7Fn3IuRfzUDk0Wu1U8a+U3/gZq+ZLkMZLRKSnuZ5m9Y/SCGLcbmXOCvyfc2dWB
	aLkNALxvbnnru/vSTVhW9vwuTmFgv0lSCoY2D1J+78E5uj3ZRQbFamw==
X-Gm-Gg: ASbGncuGECztNuML9tVL9lUPfwrt8O0sspLBs66hNGRfzgWuOqLmKUB5np1e47tVok4
	vXwmZ4oUouBj3heijmVrUCMoFXfNAaJ5bNAasXkzDCsJROjjNq50L9qh7L6qcL1tvc4d5s6DVfc
	FvrkhQRulcfEH6XyijA7m8OuWqx1oC1TXq+c38gQa0yOKWoWjLEioRbNQNWXAiL/3gRmBx80duR
	Xd1vQWJiQkn/n3oLq//AO/U5yByLzAKwml54YY/1dvKsKsetIEngQKwByPHz//gx4eIsHuzydrc
	luaysVWY
X-Received: by 2002:a05:6214:5018:b0:6d8:812e:1fd0 with SMTP id 6a1803df08f44-6dd23345603mr876964596d6.15.1736254554748;
        Tue, 07 Jan 2025 04:55:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzffAZccmVazBg4sMdwsiRJjyzVqiunq8YpNL94CX2Ew8VM3+625KkdkrTtHC+Jey9FHsYQQ==
X-Received: by 2002:a05:6214:5018:b0:6d8:812e:1fd0 with SMTP id 6a1803df08f44-6dd23345603mr876964436d6.15.1736254554478;
        Tue, 07 Jan 2025 04:55:54 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810db8fsm180689736d6.46.2025.01.07.04.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:55:54 -0800 (PST)
Message-ID: <3fe814ea-ede2-415a-8b3e-e09a29e4218d@redhat.com>
Date: Tue, 7 Jan 2025 13:55:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 0/2] dev: Hold per-netns RTNL in
 register_netdev().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250104082149.48493-1-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250104082149.48493-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/25 9:21 AM, Kuniyuki Iwashima wrote:
> Patch 1 adds rtnl_net_lock_killable() and Patch 2 uses it in
> register_netdev() and converts it and unregister_netdev() to
> per-netns RTNL.
> 
> With this and the netdev notifier series [0], ASSERT_RTNL_NET()
> for NETDEV_REGISTER [1] wasn't fired on a simplest QEMU setup
> like e1000 + x86_64_defconfig + CONFIG_DEBUG_NET_SMALL_RTNL.
> 
> [0]: https://lore.kernel.org/netdev/20250104063735.36945-1-kuniyu@amazon.com/
> 
> [1]:
> ---8<---
> diff --git a/net/core/rtnl_net_debug.c b/net/core/rtnl_net_debug.c
> index f406045cbd0e..c0c30929002e 100644
> --- a/net/core/rtnl_net_debug.c
> +++ b/net/core/rtnl_net_debug.c
> @@ -21,7 +21,6 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
>  	case NETDEV_DOWN:
>  	case NETDEV_REBOOT:
>  	case NETDEV_CHANGE:
> -	case NETDEV_REGISTER:
>  	case NETDEV_UNREGISTER:
>  	case NETDEV_CHANGEMTU:
>  	case NETDEV_CHANGEADDR:
> @@ -60,19 +59,10 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
>  		ASSERT_RTNL();
>  		break;
>  
> -	/* Once an event fully supports RTNL_NET, move it here
> -	 * and remove "if (0)" below.
> -	 *
> -	 * case NETDEV_XXX:
> -	 *	ASSERT_RTNL_NET(net);
> -	 *	break;
> -	 */
> -	}
> -
> -	/* Just to avoid unused-variable error for dev and net. */
> -	if (0)
> +	case NETDEV_REGISTER:
>  		ASSERT_RTNL_NET(net);
> +		break;
> +	}
>  
>  	return NOTIFY_DONE;
>  }
> ---8<---

FTR, the above fooled a bit both PW and our scripts: I had to manually
mangle the cover letter into the merge commit. I guess it would be good
to avoid patch snips in the cover-letter,

Thanks!

Paolo


