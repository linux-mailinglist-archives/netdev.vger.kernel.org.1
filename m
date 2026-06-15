Return-Path: <netdev+bounces-299610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FeCcEP5jMGr+SQUAu9opvQ
	(envelope-from <netdev+bounces-299610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:43:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D168A066
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:43:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=pD1g71S7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299610-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299610-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FA38305FAD7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9610B3B6C06;
	Mon, 15 Jun 2026 20:43:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A0286D5E
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:43:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556192; cv=none; b=IRcjbefgWwm1+xWIEnNHWTLHzJCyi5NK3gcK2g9ocHzUGFmSRtlXD/Xyjj7nCbG3Bvsr3nBJwjhIVHW0KDgyPsE5Gf/gWvmYBOSTZSGnj6igQ+mvxLV2NEtO8nEB7aAKmDBHh1zMrqnKZljg8cPSkyDisCTuFu0IT0zOUayw+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556192; c=relaxed/simple;
	bh=jBlnsK/KMS3kauJF9/6kISkgmEqaeXoqt4eJCNdej84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJIInqn29wvxWW9mz+yhWcwu6QsDJKi0zRdn3O+f9Bnt5Xd8Th84WLRvwgGcpJFe8XhwYpsdLzfolUCModjBv4VwaQ8xMGiEaBh0Y+wmB0l1iReLEnfX7ia0iZNkUsBDkVrGCjjLftiiMmjfDZ/OTJ5Q73Ttfg3O4lkd+CZCdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pD1g71S7; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2d865383so5275ad.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781556191; x=1782160991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBDZMBYyw+UgUQjRNToZ0sLPA9XJndpfItnW356E0MI=;
        b=pD1g71S7EtpQTpT/BiJKtBZQRzfYIfK1WP6Ecf1qhkq9I2q6+0lzhgkJbQX7E6OQx6
         8lYPIXsjJGFFmk0JHUpWjMO830tdFyAi4czLo4JWIsG9CmGUVWYN36QRues19Q5DkVdj
         uAb6x+QL2KT8NFZQqfFYaM2OErBJSvUL1I4Qqi2Gw4blEeX6e5fcACZs5tVxoZz7MPRZ
         XpM+9MbJBKt+snIfigmtEgPTGHOMCfwOSkYzkisOYnJS5b7bxPLQE6QRF/w22kQpxi6z
         3iR+OB7SKTTm2BqoMleG4St1JpsngU8TGjGfsyVzOw0ZohYNP8iumIUcX+Jidlm/7BNS
         Y3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781556191; x=1782160991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBDZMBYyw+UgUQjRNToZ0sLPA9XJndpfItnW356E0MI=;
        b=YE+Y3EYmATgADNfHw8Ydko66HwwUKAGjSq8EAkK8KJ0GFvkP5UoWC2V2qHqUp/8MnK
         ZwLQgpUHiLC3+aFseshLlOar+FY3pdUK/64vsv3JR1x1UDcqawBZxm5JirH5l2s+PE2w
         z2g8bcBN6VATHDIw8KEGoMbKsXrf09vUfAWI7jJ1dCsZFTxfiPntH6gAnZCXywYlHh1v
         K7m8JaQil2YX+O6UqCQNfQpyTzniuqBsMnGYXpSBbX+OrIJxpCPc+gOiSO/FbtSE4fXc
         t8c6XDvdyMmutFpW0/pOctCunwM91TSuhVnTwa4TEjRWVdwvZoJeKA+oaZvv75PD4YqE
         jWmw==
X-Forwarded-Encrypted: i=1; AFNElJ++1A5E79e74GVL4DoK4aLg9RwN2ShMvRy/f2SpBdSKPlTFGH33c+gRMoJXAvhdW8p5SQ6yNFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+S3va9/GnS1LmBhxsFJZVq+ZOLgpdrxD9QaiE7lA079tWQsE6
	f3a/+jr8l4p6MBdbx/9Ub15/tAEocTVWQNfm/ME7pXKO5Ftj76YMKocvk/YFk3bhCg==
X-Gm-Gg: Acq92OFLunYTFY7zMvlu1j5L34xb5Z/mCMU1uMlw+MvD9MnMJ7DJQFomTWQHu+orgL4
	nDMhjo6UIVpDCxyPdxKKizPGIH2TSzg1qIk0kccJq1ZhPLEJWMzrhlaWNGWhcdPG+ZZRy3TcrWT
	WQ1NvS+eU6usd4KGZ9/RcWjl9hsCg/NskcI038Sfn8udBdIKKlfWA3R1vGFOB4lJjpH3ZhS+l1h
	mgF3Smi93D6aRnSi4/b7ia3CCMenJaEZMbgbs9GTiR5aZavsAkngEFoLUR2wjdmm0UAFBeZfTp2
	jwEB1zPmiewehSHAqW/DQx8bkIYqKPU08N4Huir72iiE7RSkXcO+E2z6gclR5it0IFIHc6Qu0hN
	LNw9Fukg996iCFowX2t9eZBdilFiduVfEnUgDESThiXVyAb4+fPXki9edyYadSqYMWH+uLtKIa7
	zMYoXj2iH+WqYiHCa3HRwTaqN7qqhdixjxxrTnu+8xBrq4R4p747NmVaXopWsoQdcF85e6KbjIf
	u6JowEitIUiGooWe+8a1j99e/miNBsVBjKDCB/tIRM6bQ==
X-Received: by 2002:a17:902:d581:b0:2c1:ee6e:be1e with SMTP id d9443c01a7336-2c69a35837amr651055ad.28.1781556190181;
        Mon, 15 Jun 2026 13:43:10 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5228eb5bsm483197a91.12.2026.06.15.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:43:09 -0700 (PDT)
Date: Mon, 15 Jun 2026 20:43:04 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Christian Brauner <christian@brauner.io>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Todd Kjos <tkjos@android.com>, Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v2 4/5] binder: Remove mmap_lock fallback
Message-ID: <ajBj2BzEalR8jYX9@google.com>
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230417.77D64DBB@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610230417.77D64DBB@davehans-spike.ostc.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299610-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:aliceryhl@google.com,m:akpm@linux-foundation.org,m:arve@android.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:surenb@google.com,m:tkjos@android.com,m:vbabka@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cmllamas@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A90D168A066

On Wed, Jun 10, 2026 at 04:04:17PM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Previously, the per-VMA locking could fail in the face of writers
> which necessitate a fallback to mmap_lock. The new
> vma_start_read_unlocked() will wait for writers instead of failing.
> 
> Use the new helper. Wait for writers. Remove the fallback to mmap_lock.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Lorenzo Stoakes <ljs@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
> 
> ---
> 
>  b/drivers/android/binder_alloc.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff -puN drivers/android/binder_alloc.c~binder-vma-waiter drivers/android/binder_alloc.c
> --- a/drivers/android/binder_alloc.c~binder-vma-waiter	2026-06-10 15:57:56.419452721 -0700
> +++ b/drivers/android/binder_alloc.c	2026-06-10 15:57:56.423452863 -0700
> @@ -259,21 +259,14 @@ static int binder_page_insert(struct bin
>  	struct vm_area_struct *vma;
>  	int ret = -ESRCH;
>  
> -	/* attempt per-vma lock first */
> -	vma = lock_vma_under_rcu(mm, addr);
> -	if (vma) {
> -		if (binder_alloc_is_mapped(alloc))
> -			ret = vm_insert_page(vma, addr, page);
> -		vma_end_read(vma);
> +	vma = vma_start_read_unlocked(mm, addr);
> +	if (!vma)
>  		return ret;
> -	}
>  
> -	/* fall back to mmap_lock */
> -	mmap_read_lock(mm);
> -	vma = vma_lookup(mm, addr);
> -	if (vma && binder_alloc_is_mapped(alloc))
> +	if (binder_alloc_is_mapped(alloc))
>  		ret = vm_insert_page(vma, addr, page);
> -	mmap_read_unlock(mm);
> +
> +	vma_end_read(vma);
>  
>  	return ret;
>  }
> _


Thanks,
Acked-by: Carlos Llamas <cmllamas@google.com>

