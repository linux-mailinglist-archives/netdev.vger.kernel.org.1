Return-Path: <netdev+bounces-136138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB569A080B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C905E1C20F16
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B41207213;
	Wed, 16 Oct 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RihX+YSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B920694F;
	Wed, 16 Oct 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076886; cv=none; b=JIep5x3LjLU3v1xy0+zDhd6GnFYzxSwait1UPK6jyNQ8Bbbf7AyARzbdyGwIrfTivtirIy9vzBRZpMH0ByhwXRSOvS/RYboQ1PNCslN75Y4f2jr+d6d8Q3g2SzJs0k0bF1KV9CFCK0CGV3wBnODJgLXiTPo8mFIa5JH8KcAHfj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076886; c=relaxed/simple;
	bh=GxKG4+Zaa8Exeey8AdpBwGfCynvajyhPcr9selFKhGE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPVXG/C2FfVhmvKZh/ly62m0wYjHHOC8azX8qdbLrMvKyz2jCuB73KvzO6Z0VKiVQ3PLKAAbTIn0b35+No+2KqlxBXzwQ9+oyNVZjExqi/vjN0bjg8gFZBd3M/sjX3na2ccksvxEdHVVPrXCzj0xmXgSAgk45ywfuxKrrpp9uWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RihX+YSb; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so22547221fa.1;
        Wed, 16 Oct 2024 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729076883; x=1729681683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPuPFBsmpS6kyoRLa40oYeelH6usyUcNmM0E4LHOWqA=;
        b=RihX+YSbpKeh8Qg7Qg4a958lgYLsWbD6G9/YXJxKiKdoyyxnvsiGsBfpLok7LjOCpg
         wvtOXVFBMSs4P81DKoaVir9MscJgQnbxoOV3Jg+lUg3aHVQ7hB4cHq0EPb1irY2Gu95r
         Opseu9aM5FdISuN796BR8GlSt6D1BgCnDlGdX1FvynFTyZcd59qvQ1sZPeg+rN14dxP4
         UkkXkpc4r21X9mV3Eg+ZWR5V8etyO1/x2p7V8ji08ujATyVw4PLB6KFOi4y5v8SG/nSe
         yntvjEE8FC5b/oeNONTzSLUVYiOKsoArendUdBhRm3YfAxXqIQ76GNRgQQi7e/jGvlwI
         FGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729076883; x=1729681683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPuPFBsmpS6kyoRLa40oYeelH6usyUcNmM0E4LHOWqA=;
        b=s8kiEGo8K3rMXPvVb58nZXEJL9zqUgdvDvOOGgpr49R3YBB3C0iot8cY1O7Uy3k1IA
         oyWMWwlMDNsIN8oAwE1vAYh4M1WJxtrYXEY89LqcvCOdKZXXjd9UnbXqxGid6apv6ghu
         YV8xkwIv6HV8Y1GpMfCPPnrKYlvRtBtgQNg6XfBNHJ0W7UFOrogpxakT93iaa6kwxHP7
         XHF44MIxa4ZbhK8FMpz1SZfhvwe0+trb8BEK712u3lu8HaCRH6wKLU0ZKZ2knce72hRZ
         mJOnUOOP41WzXaj2SFaLnDz8Szc70ttC4SnSxNTcrw6BOt1TJRWogsWpgGRTcEzAXAwU
         dt+A==
X-Forwarded-Encrypted: i=1; AJvYcCUA1TlmLVgVuH+ljN7UxER71/PoQhJGf5DQyqiU/yMS4AiFDPz5CBKXb/dHATt1UKmWFXKq8H2IyulOF3Nr@vger.kernel.org, AJvYcCUf8ZleUCrThn0pA0ya+/bEao0+fKQjJRQKWfsgVaV3oKl7ljEZjL80eIMplCvNu0Kc6OhTlqz0@vger.kernel.org, AJvYcCWT/CIM76o1mRGQSsMXHOV2RDpygnPi6r5CxJ5NuXWQ+GLYLlpCjSbqzLL5dlhNcUWFFHXzX+g/q/tmWZRZ+3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jYmPVrGU9MPAHCKH2UIRhkNv1zE1nnQtKuwnANUzgp91M44M
	WPy3SeE0+RtuczSFaZNv6ThjGPWoNP6j01IzVDN488CpUIbJU1xs
X-Google-Smtp-Source: AGHT+IEHessqDzBZmmSlW84vsn2IkViAv/IV58tYEB2Akc/jcICFPjSzRBjgIngWFJgycMKdtw7HXw==
X-Received: by 2002:a2e:b88b:0:b0:2fb:57b7:5cc with SMTP id 38308e7fff4ca-2fb61bb6a8emr23201981fa.36.1729076882416;
        Wed, 16 Oct 2024 04:08:02 -0700 (PDT)
Received: from pc636 (host-95-203-1-67.mobileonline.telia.com. [95.203.1.67])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d0fdde5sm3912151fa.21.2024.10.16.04.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:08:01 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Oct 2024 13:07:58 +0200
To: Julia Lawall <Julia.Lawall@inria.fr>, Roopa Prabhu <roopa@nvidia.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, kernel-janitors@vger.kernel.org,
	vbabka@suse.cz, paulmck@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] net: bridge: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
Message-ID: <Zw-ejnmxwVkiVPNM@pc636>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-9-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013201704.49576-9-Julia.Lawall@inria.fr>

On Sun, Oct 13, 2024 at 10:16:55PM +0200, Julia Lawall wrote:
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
>  net/bridge/br_fdb.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 642b8ccaae8e..1cd7bade9b3b 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -73,13 +73,6 @@ static inline int has_expired(const struct net_bridge *br,
>  	       time_before_eq(fdb->updated + hold_time(br), jiffies);
>  }
>  
> -static void fdb_rcu_free(struct rcu_head *head)
> -{
> -	struct net_bridge_fdb_entry *ent
> -		= container_of(head, struct net_bridge_fdb_entry, rcu);
> -	kmem_cache_free(br_fdb_cache, ent);
> -}
> -
>  static int fdb_to_nud(const struct net_bridge *br,
>  		      const struct net_bridge_fdb_entry *fdb)
>  {
> @@ -329,7 +322,7 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
>  	if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &f->flags))
>  		atomic_dec(&br->fdb_n_learned);
>  	fdb_notify(br, f, RTM_DELNEIGH, swdev_notify);
> -	call_rcu(&f->rcu, fdb_rcu_free);
> +	kfree_rcu(f, rcu);
>  }
>  
>  /* Delete a local entry if no other port had the same address.
> 
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

