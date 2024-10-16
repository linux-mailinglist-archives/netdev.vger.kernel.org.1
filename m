Return-Path: <netdev+bounces-136135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 132C69A07FE
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E46B2267A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E24E207208;
	Wed, 16 Oct 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbTnO6ig"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702CA1CACDB;
	Wed, 16 Oct 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076686; cv=none; b=g0UK/WUM4JqwH7G4bYfT0SSBXGMmBdpiOOlzYDEhi2UEi7DG9BfnDqiHZg646PoY0aN1K3MC/Prf4FupLu4WtAJzsWUjSHStZCM6nSFvmzOjJq3U9SW68fs4aRCeNPoq3xt97eOaMGq6J3Lxrho60Pb3j6JAl1C8nJtfdU7zbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076686; c=relaxed/simple;
	bh=/JTdtZ8yw6tvm9jNmB3rBmdMWwXa9IoO6v7YodFLaWA=;
	h=From:Date:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlTIatD/iWzPLWEcvuXLl89vQ9IJXztIEMrmoqlXGvp6RhOKYEXRp4snD4REOyCV9UYo1PsHmQKD2vmSVOtBqBZlL7Z43+NtNVJBY7t+25kWOfF27UgOouFPrM7fSKpyt1tpDUFJDE0rfDZgGaPny9S31Z5ohuP+QyzEfhS8YPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbTnO6ig; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb501492ccso28741651fa.2;
        Wed, 16 Oct 2024 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729076682; x=1729681482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NDbDctKYaoGebw4v3E0DI+6dZhiijtiLFfSf+SUecWQ=;
        b=YbTnO6igDl3Osz/id9gmHd05VnChMBUfDPZaT48hQuAya7C5SHvPdZ8yofOlQtRNQ1
         ct26DNF0Ibt1xU/8KElQjjY0Tp+jxDzpCfvHtpQj/yD81Eqv9shDFyXt8KpNItZ0SVsh
         DbMAXhTkOJhhurP7rltIUQsQR0ldJAnsga0juFW4JjsgC4lmCiUx9XHBIUAtgH7JZrMZ
         1dEKkN0BMQJ1nIVXGs19p0WNeaWYABxcgTI2lm8Hh3jr17VPZEWkj6cz+zGWb0aBLXXP
         QnJQ/rnN+rn4EvPVznFHuUjK8+7TwtRnYOa4/C0E1xQhOrBmarMMxLZ+8VKwXsk8ienG
         J2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729076682; x=1729681482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDbDctKYaoGebw4v3E0DI+6dZhiijtiLFfSf+SUecWQ=;
        b=VdYuHmaPsWXulkT5TV2jdv1zdFt+AKB0cSWenm3k0beOMDBsVKsK7cMwFpIwMs0ikx
         +f7jRPmLhz3Fjj5tOIbXI5dj0bwWs80j7pirfnXoq+7yhwfKs2dBzfhXanuieLl/WuHS
         C1j62HwY/2lcZcrpwrhHUd/og11nclLwMonZcT/AjzvCy5Lyd8zT5tdz7ShqHdIAkGRM
         Iqj1a7YO817fyER3UtOhmkN5wuLahegDu/M09SFdgwrRPN+PtuYrY6Myt9LPiIBl2jPt
         oFwwjzK6zp5UmLsS2tFc5A8dL7H4NK/81FDOm4QdCDcXPWo1TuXAkypBTsb3M56hOvtr
         eUwg==
X-Forwarded-Encrypted: i=1; AJvYcCUwVeNlJChzPFmCaau3eJ7gJh8KxOtvY/NVF2qFooX9mw8OqkzUSoHLvhoRuyLDwOQBu8pg0QjJJo/akqjr7bw=@vger.kernel.org, AJvYcCV6bPAJLle3aIywtIgtZKwABIUNqyiAQ7n8yop9k3rHQJB8oOH3QVkFPpc0TeF6qkQQ0H7yYcrX@vger.kernel.org, AJvYcCWfR26NtCpHvnHRhI3Mu40pAdqmf1hLEaLBU7hKzOcd63f5/CQ48F4cgdaXYm7wdNlFwQNxbqiqW9RZZf1R@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3leMRryA9y5OYBDiuxZ2JZC5uDdQYQS7fO/U9FMvKYmAd/Nr
	4hemdWm9JzKprxqgpHghWhFeFbZfTFEKI5TtBHjeadHJf8QoQCJP
X-Google-Smtp-Source: AGHT+IGfqoIo176A3Xc2Q2xeErsC3HAJJY4ekVVwX4mFx6IEqtAbOxCsr3LqgtbGCH29R44xS0WATQ==
X-Received: by 2002:a2e:a541:0:b0:2fb:5b23:edba with SMTP id 38308e7fff4ca-2fb5b23f28cmr33996231fa.23.1729076682233;
        Wed, 16 Oct 2024 04:04:42 -0700 (PDT)
Received: from pc636 (host-95-203-1-67.mobileonline.telia.com. [95.203.1.67])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d1a8590sm3863191fa.122.2024.10.16.04.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:04:41 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Oct 2024 13:04:39 +0200
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, kernel-janitors@vger.kernel.org,
	vbabka@suse.cz, paulmck@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] wireguard: allowedips: replace call_rcu by
 kfree_rcu for simple kmem_cache_free callback
Message-ID: <Zw-dx50JDeenxwCr@pc636>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-2-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013201704.49576-2-Julia.Lawall@inria.fr>

On Sun, Oct 13, 2024 at 10:16:48PM +0200, Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were made using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/net/wireguard/allowedips.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
> index 4b8528206cc8..175b1ca4f66f 100644
> --- a/drivers/net/wireguard/allowedips.c
> +++ b/drivers/net/wireguard/allowedips.c
> @@ -48,11 +48,6 @@ static void push_rcu(struct allowedips_node **stack,
>  	}
>  }
>  
> -static void node_free_rcu(struct rcu_head *rcu)
> -{
> -	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
> -}
> -
>  static void root_free_rcu(struct rcu_head *rcu)
>  {
>  	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = {
> @@ -330,13 +325,13 @@ void wg_allowedips_remove_by_peer(struct allowedips *table,
>  			child = rcu_dereference_protected(
>  					parent->bit[!(node->parent_bit_packed & 1)],
>  					lockdep_is_held(lock));
> -		call_rcu(&node->rcu, node_free_rcu);
> +		kfree_rcu(node, rcu);
>  		if (!free_parent)
>  			continue;
>  		if (child)
>  			child->parent_bit_packed = parent->parent_bit_packed;
>  		*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
> -		call_rcu(&parent->rcu, node_free_rcu);
> +		kfree_rcu(parent, rcu);
>  	}
>  }
>  
> 
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

