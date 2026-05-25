Return-Path: <netdev+bounces-291291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOZJLncqFGraKQcAu9opvQ
	(envelope-from <netdev+bounces-291291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:54:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0575C980C
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECC973018410
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D794E3E9F69;
	Mon, 25 May 2026 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTgqzR8h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A13E9C27
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706399; cv=none; b=nfLEwSfBKI/W9+IRmiTb89Zj75ONVPWjj/HHz5Q8uDzPXgylRaOYFBJPRM9RVKR9Qu4ZPYFu3mgEkEDhIJocJD90l4LV5ucIpLuF6gklS7nqYMMuZLriz5sfs6mIMfmyvk+fkPuW2q0edNgy66vdZoPuxYmIphlnGaquVLA7liM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706399; c=relaxed/simple;
	bh=rCoOpEyyUCy5izIH7PFgiOzmcy6juASzPqw0DoJcH0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcNsZp20pGztTDZzWHMfYzIBfm+LhdWkuatK75VzaAooLD7Wtj8ySNNPpyzxlLtwsEMd6SooobduM66NDIHwWcNUOkTKctpmcII39E1sJegwmvLChA5mI5j3aCPQLmsoYGrOxuXnNeztLyofKypbbXgE7DOqDIguQIEc6mXl0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTgqzR8h; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4905529b933so12169915e9.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 03:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706396; x=1780311196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIaUsl5OR/SB9imIspw1g7Ej0mCc49YZbthvw9ulBV0=;
        b=JTgqzR8hYkHOKVq6LvCHMzI0UwunfbBdpl/kEjtAGqhI2I7iKdjb3u8htt8q3YB9ts
         ha7iOGO3j7TsCDYZrDTwZXZN5qnWneBCiiJrN0gZmfTP71m+TAnkmixGpGfXMYlFXLuh
         jOOkwKLGWqpVtCeS3Mrw2+SkkfDazmU9QwETwepYvxlj/z4HxlcXSZxOno+Se6LB3Y65
         apXE8bM7gRw4SA+Nb9040sqIvK2Rx3Q9BQGGpo+ObaOTNGJXB6N+/bJQZHUiZ89vGUAT
         n8b9ei+uZqcVnbG2clDOzFjzpS3Q8Snqg1RztkVmkKgDVnlZmA93NWsLguUXR7Rf98iB
         kObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706396; x=1780311196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIaUsl5OR/SB9imIspw1g7Ej0mCc49YZbthvw9ulBV0=;
        b=CXmzxsXZXESnDnGv0SMbZ5HUijMZPJ3dYizGn6ZNlOpw9N1ejvcMJlg9p7pUi7wsOS
         IZDDVlUIFBoAXkCuQlR0GqPAaDOxlngr0J+AX0F9js/MxjwH5M7QqsGn7YqubL/q6NEQ
         Erp3TP8yNyPwOEOY8mFprDO7WF34c14mpWlqquASoOWtmPmlAV5iTnk4y4UKKhV16NSi
         yfl5WucBqfDWYziREKfoS7uHGA6fx0e2Mu1P8J9pBq/4AG146OQGDSb7jfLz4Kak03oa
         Uu7uTrpX3Ak3yZSjQuWEt45HoQR6R0T6z4NAEPo1+UfJiOpb5e8+Qs2i55cCPgwGOxEe
         xAnA==
X-Forwarded-Encrypted: i=1; AFNElJ+o68uGUUG6zSpRWjr5dseARrnq6ZgFF3VqF3usFw+MKrQimqn9lW/t7P19s8WGcWfU12q1Fhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xJNiHFa/sA87a2PE655YZzZPIShj6rcYCYc0Ng2O33+sE7lm
	+8nsLsVRAwtX5xfDhWu2tCHLvSVpgUt50tT072XKKKk72FiOYZrzKC8u
X-Gm-Gg: Acq92OFPFDeBUbCh7YYVL25qG46v7n8LSyhLVAMygQ9r0LZRsioNO4prxqVw65fUJHR
	5/8HkShfWijQwantfee2eCcQYV+QN6jLG/6JROjeMSGmiOnuwOuddX7Jk6UbIDfBtAji0OZGSVx
	RS1njdmSYnKkuw1pXzdPoj6H8b47IHyRB1vsiPRGTz0Sr6vVqfojo6ZGIBIkwQ1yk5STfhJ7Gko
	xZPNM5bMt21pqsApcQ1aSRCLUvuoD7ZiGyOwION52LE2TzCs1QAKnTuvkPQsOQzRMDANS2P9LhZ
	reoGHNJkI1IujjW4/VUT7YS/wArY4ieQQ/Kw3q7lbipClkRUlKW/SE6YMsdkxCwWPnlN7Dyte/6
	zpNdb5fAh/WxyIavd8YLwV9Ok1MJlxq9AjfzF/F254FlhCxxfUdc3G2a7XSY9ryoVw8mS+FJSJw
	/pwJjeRXPwiK7unlpbuGK3eaLlRmh+C8f/QXch/uSLdSBn03rT9FUnrlv+QxzOijoY
X-Received: by 2002:a05:600c:468a:b0:490:3d62:f5df with SMTP id 5b1f17b1804b1-490428e5a6amr234019415e9.30.1779706396365;
        Mon, 25 May 2026 03:53:16 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a33dsm222417485e9.11.2026.05.25.03.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:53:15 -0700 (PDT)
Date: Mon, 25 May 2026 11:53:14 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
 pabeni@redhat.com, mst@redhat.com, davem@davemloft.net,
 jasowang@redhat.com, stefanha@redhat.com, edumazet@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260525115314.3cf310e6@pumpkin>
In-Reply-To: <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
	<177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
	<20260523173557.5cc4f4f6@pumpkin>
	<ahQbVxvbBEJZ3TBU@sgarzare-redhat>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-291291-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,netdevbpf];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2C0575C980C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 11:57:45 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
> >On Sat, 23 May 2026 02:20:29 +0000
> >patchwork-bot+netdevbpf@kernel.org wrote:
> >  
> >> Hello:
> >>
> >> This patch was applied to netdev/net.git (main)
> >> by Jakub Kicinski <kuba@kernel.org>:  
> >
> >Did anyone else notice that is isn't a bug?
> >
> >There is no way that a 'count of bytes of kernel memory' can overflow
> >the size of 'long'.  
> 
> It's more of an estimate than an actual calculation of memory usage if 
> we queue the incoming packet. In theory, an overflow could occur if the 
> user sets `buf_alloc` to 4GB. In practice, though, I think you're right: 
> the memory should run out before we get to that check.

The calculation is:

	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0); 

skb_queue_len() will be the number of items on the queue.
SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically sizeof(skb)).

Unless you either corrupt the queue length or manage to allocate skb that use
less than the minimum about of memory that product can't overflow 'unsigned long'.

The later calculations might wrap - but the multiply can't.

-- David

> 
> Thanks,
> Stefano
> 
> >
> >-- David
> >  
> >>
> >> On Thu, 21 May 2026 14:47:32 +0200 you wrote:  
> >> > From: Stefano Garzarella <sgarzare@redhat.com>
> >> >
> >> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> >> > to 32-bit values. The multiplication can overflow before being assigned to
> >> > the u64 skb_overhead variable, making the skb overhead check ineffective.
> >> >
> >> > Cast skb_queue_len() to u64 so the multiplication is always performed in
> >> > 64-bit arithmetic.
> >> >
> >> > [...]  
> >>
> >> Here is the summary with links:
> >>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
> >>     https://git.kernel.org/netdev/net/c/4157501b9a8f
> >>
> >> You are awesome, thank you!  
> >  
> 


