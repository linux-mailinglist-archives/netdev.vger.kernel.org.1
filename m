Return-Path: <netdev+bounces-247900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1EBD0063E
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 00:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51F933013380
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF19F2F39DE;
	Wed,  7 Jan 2026 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOqKkyTv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491382EC0A6
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828347; cv=none; b=LCY8MDPzAv448RsvJCmVexsKfnU/VUXWiGfTB6O4PVV7rcVqLbcjYq27Gxhzb1g7O0Csx8woYrwgUzVkg4wePhSWnoN/6GGwR+1MW7YTpgGTIDOFDnKqLc2gYdMfCGSGzXim+DvtomBqJRmooAN5he5VzWwt2VBfLOHxosUySBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828347; c=relaxed/simple;
	bh=xte6Op8c+gje52GWKjY1PXBRWaV8I69pg+nSgTFrkos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdbaypGnYpCw3BRN8vOZqR8LMqp9QNdq1EmEgf4OltYnrxtTmhsRt4uhE83zmsOBOXeEvERmlmq4r9uLAiamrXC5rMyZDqviSuDkAqXCsoyfn4TpgEibTkFfFqZJNE0CL8X1zhLSdndY/CmQ7jCZfP3ogpvRp6vE+4iEshXVaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOqKkyTv; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-11f36012fb2so2865059c88.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 15:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767828345; x=1768433145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9aNw+LAmFxfJKjKyNuMyCvNOGzb5sDFR8RwzmkvIj88=;
        b=EOqKkyTv+oWs+fnOm3pDJLCll7z+9dixDjAAQclx7mZJgFFQxyO6EAB3fRH5haVak4
         XV6+lm9NHlQ/PJJQvTZ9GZ4oWi33zixR0ZZXBd9OT6jzKkeQHJeyXxlYApTRkXfiqCP8
         C0o2qUa1m+HU48gkTwzzYf0HcfxrvqDDERQ8WCgUXqfm5MU4aL8DCoLX3hG4PKqvfjDz
         PBk4GSpPtZyoy3mtaV9/ib2PYCMXr3hUKb0bv5i565p/Og8Jw7UIvMUDUCNQS/69Le6y
         HZDe/ybAude53J4TMbAibRUTtiNwiWQCWOYg6c04rRX7D0yl/LS2Wbd6Q6CL4C1CNLFM
         5jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767828345; x=1768433145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aNw+LAmFxfJKjKyNuMyCvNOGzb5sDFR8RwzmkvIj88=;
        b=k8kIazCI5HLkNpKYwV5zodECtBwxZKwF/rhDadmn/764pS7J/UgCAkalxSMeS5MPUZ
         rWkFonXj4Q7PxXME72Y3WL0tOCeX3OzafAdZD8/1QOmoNmmkjskVPbc+ACOkp75YnpxW
         xEUWAIjMkEz4ojmwLDElFGU/GaQ8PiTpvfD616U46JVOIFC3fxbN2ljttTmJW2bLgcA1
         0IzMRGEYhLmTP92AgNwCfRCA7TK3ausR7O2pK3aFuPYZ3LjubP2MJFp4pmwChfHK4EgB
         UchdDoX5VlpBVxb3QjCsbjuXGdiUhAWyutauh8eE3mpWgl/rwSedZoZOf7qjtw3JHDGy
         fEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdgNYy+/3YjP4rRy0qOkmYayxteQjR+SLUQkz0gBvHAYDqHS+UhWbT8gvpzRQYbeExAqbmQj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3I3SuSyUtNnabYDFtN6fswr9xZbRyffsZFPhk60IowJWItFPg
	cSEag/pUyTFBqPVHVHZe1N8ScpSH3Swsponx9uTngL02q1E1PwyTMfCEqIG0sg==
X-Gm-Gg: AY/fxX5gIE/iQUArvm9gq/IEUKv2zeCzToVP49STP5CvmFhyr+mHGCo+edQjeLmEUfv
	lHqE8MO0g1Rk8zjw6ZXeR7lyMF5nc6q5aSGKzt9nxWbbYqDPF2NiXiXViiZDryEknx/VpqD4+8H
	3Iy5KTTQs8+Nsu2zj4lyHVVNwQG/fO+sAFMpdkqQEEqW/pu6I6wc5S7wlH5n24pezp1KslMPrKJ
	S1pPxxg0qMHrNWIlv3xgnYz++fPnp6JdGYf3K6WeUKLDNDaxWqk+8fZVx6jFqMoCPOluVqqZFbD
	BfKe7Ua5a3dZPJ2gyce/LWq8uT+MH9zYk9iKJNIGGgFt/R7dLK9gLWnzVMDfFSytgDquadyULje
	Evyi8mdjtaLX7Pnlz3Xy8cuPbGeXsMGGmS0DerLSolTER5evgCGuh41AHJ7tpRPP8lk3eFbwfOE
	8R68ahCbgiKWYET2dIPQ==
X-Google-Smtp-Source: AGHT+IG6/0LQJZ7aHjdnPJMlyL+x4aeRNV4gig/cDxiQgr/D8kMIOPK7cq0vOqYTJM9ACcNBNR1hJg==
X-Received: by 2002:a05:7022:6b87:b0:119:e56b:91d1 with SMTP id a92af1059eb24-121f8ac007dmr2684640c88.2.1767828345111;
        Wed, 07 Jan 2026 15:25:45 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:36c8:e8eb:df03:2fdc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243f6c7sm8977314c88.7.2026.01.07.15.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 15:25:44 -0800 (PST)
Date: Wed, 7 Jan 2026 15:25:43 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Neal Cardwell <ncardwell@google.com>
Subject: Re: [PATCH net] net: add net.core.qdisc_max_burst
Message-ID: <aV7rd0dNS2NBX5b+@pop-os.localdomain>
References: <20260107104159.3669285-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107104159.3669285-1-edumazet@google.com>

On Wed, Jan 07, 2026 at 10:41:59AM +0000, Eric Dumazet wrote:
> In blamed commit, I added a check against the temporary queue
> built in __dev_xmit_skb(). Idea was to drop packets early,
> before any spinlock was acquired.
> 
> if (unlikely(defer_count > READ_ONCE(q->limit))) {
> 	kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
> 	return NET_XMIT_DROP;
> }
> 
> It turned out that HTB Qdisc has a zero q->limit.
> HTB limits packets on a per-class basis.
> Some of our tests became flaky.

Hm, if q->limit is the problem here, why not introduce a new Qdisc
option for this?

> 
> Add a new sysctl : net.core.qdisc_max_burst to control
> how many packets can be stored in the temporary lockless queue.

This becomes global instead of per-Qdisc. If this is intended, you might
want to document it explicitly in the documentation.

Regards,
Cong

