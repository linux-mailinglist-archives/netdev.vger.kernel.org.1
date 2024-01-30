Return-Path: <netdev+bounces-67095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E248420DC
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C20B2863B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18F360ED3;
	Tue, 30 Jan 2024 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OQv7KNAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACFC433BC
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609136; cv=none; b=YpXPrj2mN/QTlcBoLlgypDYGcHculY8ranNy6OA8IHcQwCNPTFgJ6N/JsweJI6RnCmIXTwNJcfWvEOXKH1Lcs+8DpqcNsXfFVQTrqr6tL845MX2NcaVU/t1b9jiuHoUQi2B1xtMLFQNXM0pk2Qt9lIMJ9479mjfDTLS7sUGN09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609136; c=relaxed/simple;
	bh=DRlRQXLhsU0+cKh3w23bLq1XFJxx5MrK/ImH2gQ3Op4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTkGA9KHzR3ZD1EyHtmM8ZaTuCjIOfDcIs/GS5cBBwyrda7uHfo/9Art1VkN6zJJ9QHCN69DQShiUfWftJ9YmEuxtVHGqNEi9oDPkEIV06T2LGjn8fvXkaOPeEQXyt9DR9xUnoXQJdxiKKmQUKcwmzZt2AuqyVpIBI00yIqHu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OQv7KNAy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so3703289a12.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 02:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706609132; x=1707213932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vNUijCkfAL5sfK5WTVaGUY4h4o2ULqP8+6/IA0phaQk=;
        b=OQv7KNAysFMWt3Z2bD4a7Dnjr/Z80w7sYgerEm9uhxdgv7J8nQB5MD/Rr8D9ulFRKY
         TtMO8mK/69gSJLdOy8mtYI0L+t66erGKmw5zuGWcaFmt5ECiN4veuFS93q4cMJzusZQh
         RL7N8qCNdj8m3517q8RsnE+4VpqkiqoHkEDET3i1QBewsVpS3F1AKeZwyaDmGV8Sm0VN
         6nmL1MetEGT7NiwwOF1HRMM1unJ74MbRC3oZjgNtRq1oy23DRr3btqm7vNW2l+l5OR4V
         dD5OsS1UMusbs6kXgHXBIosrW00KLCTdxnvzqXjcjg/uchAaJqJ6jpcbmzH33F2PJjOk
         imwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706609132; x=1707213932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNUijCkfAL5sfK5WTVaGUY4h4o2ULqP8+6/IA0phaQk=;
        b=vklurdGpQ5umi80rgttQ0i58mSg7a8iBk4QYhuxn2EwgFXBeq7jEiRFjeOcqFXGVD0
         If9enR+dYq8UiOhNEIDli78V9xWz0bOc8/6xcvYtVBCKRci1EkHcj9p/mtpOi4CXd4dR
         a4doUREzHhiEqD7nV1Iz1N2taYqqAuS23uGG8zAhtfTS39TE5vGJOg45Kp6E6jmXG2LQ
         HLzf7tr/KfsvanhRrB4PYbKBMqLtQpwJ0tN84FQXFBG1FVLXUOtfCYzvutpJFJkUfEH4
         cO5IKg1HclFfP0AAoVOiiE0dJt+s2jbItDMAS4fr1fcvGtEYqK6fUo9/czeMj4Sro/UR
         eKZA==
X-Gm-Message-State: AOJu0Yyao6uclTeRVLce0+lb3Hc1e+zFTM+ypNR8WZVvr0s/skbWaAqK
	SMX8d/1sE/6i4M20qBcJVybfM32ABLCgpKxUhEpzycf/Fj3yhOdWf5Yx64H4p4o=
X-Google-Smtp-Source: AGHT+IHuiHgGkkgi9w9V6/5T2cGD46YnixDp6OWJTGuzWpVdpX0pdAoc5abTFOTwONmcrsmDfpovrw==
X-Received: by 2002:a17:906:140a:b0:a33:b64f:48c1 with SMTP id p10-20020a170906140a00b00a33b64f48c1mr5919446ejc.21.1706609132502;
        Tue, 30 Jan 2024 02:05:32 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id tl10-20020a170907c30a00b00a3554bb5d22sm3545686ejc.69.2024.01.30.02.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:05:31 -0800 (PST)
Date: Tue, 30 Jan 2024 11:05:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipv4: Simplify the allocation of slab
 caches in inet_initpeers
Message-ID: <ZbjJ6CB5NgMIfBwk@nanopsycho>
References: <20240130092255.73078-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130092255.73078-1-chentao@kylinos.cn>

Tue, Jan 30, 2024 at 10:22:55AM CET, chentao@kylinos.cn wrote:
>commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
>introduces a new macro.
>Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>to simplify the creation of SLAB caches.
>
>Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>---
> net/ipv4/inetpeer.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
>index e9fed83e9b3c..5bd759963451 100644
>--- a/net/ipv4/inetpeer.c
>+++ b/net/ipv4/inetpeer.c
>@@ -81,10 +81,7 @@ void __init inet_initpeers(void)
> 
> 	inet_peer_threshold = clamp_val(nr_entries, 4096, 65536 + 128);
> 
>-	peer_cachep = kmem_cache_create("inet_peer_cache",
>-			sizeof(struct inet_peer),
>-			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC,
>-			NULL);
>+	peer_cachep = KMEM_CACHE(inet_peer, SLAB_HWCACHE_ALIGN | SLAB_PANIC);

The name is going to be different. Could it be a source of some issue?
My guess is not, just want to make sure.



> }
> 
> /* Called with rcu_read_lock() or base->lock held */
>-- 
>2.39.2
>
>

