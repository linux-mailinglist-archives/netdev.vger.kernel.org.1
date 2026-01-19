Return-Path: <netdev+bounces-250938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39832D39C08
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E61543001FC7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373FE20C490;
	Mon, 19 Jan 2026 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkLpbSPG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67A205E02
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787082; cv=none; b=Wp2UGa6XWKe3ffztS+S1w8tGVbmoV507R7JgTs39FFAi5oQCn/yH2th9uOTZoDmfLYFP4qsr9VQALhtC4QJg7HJwxeLRPXB7onUQP9RZCHGhCu+RCuTgdx3DJrHcb8j1SEtgG2fl4hdB3Nzfwa0zHW7w+//ZSXeOXDaVm6qycJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787082; c=relaxed/simple;
	bh=imMIwrXigzI5vwbukz8WWxz2ySwfpRZI8TdfhUe9VeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXNKdAK5H3zgAh7CQCz9I5Gwgm1pMvVO0mG22h8xssfozSCJU8Wp0/Ni7CJCtnUviV4uQWTzWgwTl9JqQ+JKMIxHYD6H0uMT4Eyfu5u0nIAYWtttQOQZwUflbO4SADfDRvQo3rOEi08NFpxXK7kzhURn4LLPRCHtFBJs8HwUqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkLpbSPG; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b453b17e41so2490130eec.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787080; x=1769391880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3th0y0cIznxHYM7wgGa8mBjjcrfa760dKMtxGCo2pgA=;
        b=AkLpbSPG8XltAouD4xqG6o4l2ur/0jQUDpokh2GJn1OyZ2/6CqWi+/0hCQvaKULX6d
         3gsseOJD9ZXe7KyJ/bNo8zJzAMTlLvJC+mmxZzkND1zUb+0xEdJodFm9uDxFJwSCwJrK
         PPP/4dMCw0u3be6nlM5UNXM4zJYtbCrUBsWopdL9DG/uxdUf8ChmX5JfHUNs5VhrV1GX
         dZ6Wg4X9aHv1zotaoy/Z8UKCcClzQjqQDediZ8L/dgCyCtsjO599g55/IAxpZAPPDXO4
         N7vAUuVXh4xt00OeUh/CfDrKqBsHAhNWy1brYXb0e2vKSE/wXqP/ztZLbvnvLnc51n7u
         fZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787080; x=1769391880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3th0y0cIznxHYM7wgGa8mBjjcrfa760dKMtxGCo2pgA=;
        b=bOau96TwUk/fp5PCZRjuRL71Gz8mg3O4oKq4gTeVcg8DOWRQ8ryv/EkopHGEFeaNUo
         ZUpqgSUg88KsmL7CvFi//QFUfsRHUaCHWnF4LF909JZFwaOHaxkxPYfwKqrpvRCU42kC
         23Yt6r2u0kmYdwVAQyMsNXPELO7QF0dzFOh5nhrmg672yTDG7mc50TfM7uDiAb9tVqAd
         0raly0zQa2Y2CrCcPLqR15JGyHbW4wrVbnEdFfdibpMJQbo1XsMf0MW5p+WqQb0JoAAv
         9yMQTH6YH0Y1ysz/frJVoLJjHnWTMlkddxM5rC5zbAsf12/FPFHDE0GeuKNO+wZUUp0A
         2DZQ==
X-Gm-Message-State: AOJu0YyhB16ht6UC7yXbQcaYCnl8sPLrrkvWcPYlk/BW7J1Ts8QFnBCR
	MDg0BSr+PSQf+OH3G82yzlJb47BwK01WF3tC6s/d67UAAWVVBkJ/+qI=
X-Gm-Gg: AY/fxX5POnAvuCg0fNt2TyzSjQ46bMJre/Efz6Z87/jGoTI6hVc5FifI3C+qzNrRfLe
	zAjB126W5zsCr8haILVgIwshSFkgOebMbf2s5roZCSIG840AffDXqOXHELiFV9N67aQ0+7BE4U7
	MjDft6ydbvEw8shYFrvBRSlD1oBEJm0Y/pMxNJrCO2GJoUKSw9cqdp/XeLJADoVAQ+VFAv6tVHH
	5OXdhCRkCATa1Xrp/r0xL5C04BL13oGBFYpzAQDmPEh6lj33ShRD/IpkHBa+RsD6kEQRNsx82pc
	150LLYrzhCLYmg0F0fTAZ+TypfDoAjWZcn0bbEvmvrASmYrMVAYjG6+mxq66eoyvuk5W5FVzasD
	kMLwNDlUu5H9D2x+MkImlaheIc1N4XID8sx/c5+9M/+7hv3Jlth52e6tBOi4GDaLGTlQfZ8D/Ia
	dYuab2uMfG3YlQZRhoqUmDtbjREgfwjdvjO2yXqRvbYZZ/+lAOoU9WRei5WMxXTZS9YFA92wLR6
	FphsA==
X-Received: by 2002:a05:7301:9e43:b0:2ae:56ef:c85d with SMTP id 5a478bee46e88-2b6b34b2b47mr6917311eec.9.1768787079909;
        Sun, 18 Jan 2026 17:44:39 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6bd8e7cd9sm10075828eec.16.2026.01.18.17.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:44:39 -0800 (PST)
Date: Sun, 18 Jan 2026 17:44:38 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 04/16] net, ethtool: Disallow leased real
 rxqs to be resized
Message-ID: <aW2MhiZrE8MU0CCC@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-5-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-5-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> Similar to AF_XDP, do not allow queues in a physical netdev to be
> resized by ethtool -L when they are leased.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

