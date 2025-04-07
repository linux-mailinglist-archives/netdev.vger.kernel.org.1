Return-Path: <netdev+bounces-179591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FAA7DBEF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F8F188F242
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE8235BEB;
	Mon,  7 Apr 2025 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YBSXl0iz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BB419B3EE
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024378; cv=none; b=MLEgHN8gaGgbbtJWLRH3k/KfDIxjk8iy4KHDeu7sBlznY5HhDl3cGCf6onlTyYwNLJdiKAZYnY/LWawGvqB4ybeVd6LL28Y05cgOozHT5oFh9fULcCQFPuwQZKUOMxAmEnUTiaAJO2rSaBsvD4L10VIqsLWNLEnNoV3tV+gmbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024378; c=relaxed/simple;
	bh=AL+ahj7dfiZANf4bLM4JfXUzkjYLjK+fM0ENF6TGoJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqZega4BLZJLt8SarBObjunRI5u2H6lSE5Cp2GtfWiBB3a5vBRkFSryjLcP8pHm7LeTb+B5exQRoW3GLG6IeM3pWNBlCZED7TBfsXiK/0hHoU8NvhQ9f1c3nH60gajYBdxrHv10y1c9/pLKcyoH5sVHsup1b5VlrUrzUypC7JOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YBSXl0iz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3996af42857so3357007f8f.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744024374; x=1744629174; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=20bUHYsEipJcwLblzli40jQ8NdyUhId+ZJ46Yj9DedQ=;
        b=YBSXl0izn5KuxXpUeCMRqfqDVTJVx7oyf5uCq8wgx4nBkl2qjuNtz4haTikarxEOlk
         iLE61rplVTcN48mCZ3On7FNhwrNvvE/RdMBvc8Q5pORxUTLcqcpMaGxoJwsGaPioalnH
         RwNEyWslccERhdfgEhf7fIgI7vQjD3U48eCS6DmLArIw33hWBoyMPlS1UE3607xsD0+X
         9sqRKl9LqUsq6l/DIdJPevWUfpPAmesokTFwsx9uVz/fZDF5TFb1DIvubSpNhuQkDY/X
         8vTe1ppovzuj8ValmvTHzr1cVxn1Qm+CYxU0LBl0HSAlxFyRmNC1R+hV89LqFyuwAfw3
         mONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024374; x=1744629174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20bUHYsEipJcwLblzli40jQ8NdyUhId+ZJ46Yj9DedQ=;
        b=CqM9RafRDyo/SDsPzyONHFmgFYSAicYpmnMo+OPLuqptrgyesmemLQ4rD1Pf9xxfcY
         plo8YEz3DEjL1SDWmskyao/voefpUpjmUHshpEhx7mxvqRXj3Jd1TgyYH6mcydhMy+4k
         BNC97kGIWWNG967Hi1+Qq2esNinPsDznJaasHYIPsW4lKRbnJM3cJPWwfkSdW0gMWMuK
         FtS/uIAwiTwq17YcFAXb4qypspRmYcH3BhmTlH7RoLFh55W4pbutoatLZhO2SlkXvzw0
         NUqsr2mQSJ/7CQCtq8ooFb+wPqN9gyrvs5WOaTK06wP5IVgO9ogY8zIJ+RQ5KJ5aZ2gh
         pzBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/V+9qHPhUP15MwYdr0EDYVC/pG0OJLrniAZBlEz8gQHTVnqla8/wxnXTfSmdTHcM4169os7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YymDNbQ582fd0MtwqA5/JeQfuSt0gjHItTUL0Zi4SGYsaH0yM+m
	V/8nkVgIwlAx0hhnksymAWuE1QS7WT2KSJ+ZoMu884Q6tGBTXO5j514S71h1hP8=
X-Gm-Gg: ASbGnctqNW9QnkVROgqXKU89/cKbmvXd7RW28Q48fEWL9szVpAop4LexLxw4LcPZ0L1
	JXAW5Ok80sIEcFC7FmCjMcyFLMHVKLpfqq9TTjQzFOUg6ZuWuvOIg7XKvFQht8hyN/KH+xur2xD
	th40Y05M/kYM0lz0AeGluhnIXPqAt0SQVY07cxhcjI/P0MAAPwoB9PbSryGKmojnQDAJIg+5beH
	6l1COjMQGnemF9KioqB9kwj5jvoDCIrpvBpFfX8tcTTOVf3vfMmzEx9Ms5rIogcVj/rcj69xnIT
	7IcY2g9hd3JkhqlVG+TQeo1UT05RSpGaMevSbXQDKwg5+8vzOVLb+tHlfFHnrZ8=
X-Google-Smtp-Source: AGHT+IE4tuEiTkGPsiWe7SwzDqxU9f4gNGUNJZiwCln3b2OiavGRy0eucWRFlVEN5QotbOHwm3VfpQ==
X-Received: by 2002:a5d:6da6:0:b0:39c:2673:4f10 with SMTP id ffacd0b85a97d-39c2e651726mr15617494f8f.23.1744024373764;
        Mon, 07 Apr 2025 04:12:53 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b3572sm129740055e9.39.2025.04.07.04.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:12:53 -0700 (PDT)
Date: Mon, 7 Apr 2025 13:12:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Ilya Maximets <i.maximets@redhat.com>, 
	Frode Nordahl <frode.nordahl@canonical.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] tc: Ensure we have enough buffer space when sending
 filter netlink notifications
Message-ID: <szzzagmx5jstl6hymloxwtquazgrzpqx3xr3kqqdx43w4xnldo@mjfs76uczbdr>
References: <20250407105542.16601-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407105542.16601-1-toke@redhat.com>

Mon, Apr 07, 2025 at 12:55:34PM +0200, toke@redhat.com wrote:
>The tfilter_notify() and tfilter_del_notify() functions assume that
>NLMSG_GOODSIZE is always enough to dump the filter chain. This is not
>always the case, which can lead to silent notify failures (because the
>return code of tfilter_notify() is not always checked). In particular,
>this can lead to NLM_F_ECHO not being honoured even though an action
>succeeds, which forces userspace to create workarounds[0].
>
>Fix this by increasing the message size if dumping the filter chain into
>the allocated skb fails. Use the size of the incoming skb as a size hint
>if set, so we can start at a larger value when appropriate.
>
>To trigger this, run the following commands:
>
> # ip link add type veth
> # tc qdisc replace dev veth0 root handle 1: fq_codel
> # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in $(seq 32); do echo action pedit munge ip dport set 22; done)
>
>Before this fix, tc just returns:
>
>Not a filter(cmd 2)
>
>After the fix, we get the correct echo:
>
>added filter dev veth0 parent 1: protocol all pref 49152 u32 chain 0 fh 800::800 order 2048 key ht 800 bkt 0 terminal flowid not_in_hw
>  match 00000000/00000000 at 0
>	action order 1:  pedit action pass keys 1
> 	index 1 ref 1 bind 1
>	key #0  at 20: val 00000016 mask ffff0000
>[repeated 32 times]
>
>[0] https://github.com/openvswitch/ovs/commit/106ef21860c935e5e0017a88bf42b94025c4e511
>
>Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>Reported-by: Frode Nordahl <frode.nordahl@canonical.com>
>Closes: https://bugs.launchpad.net/ubuntu/+source/openvswitch/+bug/2018500
>Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

