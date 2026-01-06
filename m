Return-Path: <netdev+bounces-247328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F16D0CF76D5
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 10:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E8C23040F15
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828130C37A;
	Tue,  6 Jan 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="RpS+foLe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BC30DEC6
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690938; cv=none; b=UwfR/FbgccnICK0F6NzbfmoSJeJm1jJAGWyyISPrL+mbKDouBONr1zIzuwbY13T4x69CoKOhBWYFrv/7P2252pk8pk1eFRCJNg9CxGHKA4GW3kFUyPMcnhiNphFFTopH9aei07doM68GqD2Hxx5GyNbIkmkDSfbwZhbUB6X48Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690938; c=relaxed/simple;
	bh=OA52/i2DySdJ2oa/UO8WVQLSVE0wUq50Xz8n8YBQARw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEdlnZ2r+psOYD4lVsWCTYWKKd6YkPt3GHqgWpMX++HPeCxnPsCnmAsfjmuncChS/SoeAUXGKfXaqQMTpiWGrIRc/jnN+P9O5OMV5w8oId7POWmlXTN/uxyH7Gw7uUEN+qV7XliFRGZCWGNAbABlyl6JPNa4Zv+WhB/0nCn/2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=RpS+foLe; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso116951166b.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 01:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767690934; x=1768295734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6/zpETfkXIXzs5jvYKUCRYKONy/bc8t30ozg4s3tEQ=;
        b=RpS+foLe7a6RinjXLpQ5o5TSzKdgfG8HShjE+fkVJtaPJudVXiJlkfi4ofYeoxkqBD
         mLQeOUxUl2p1OiejsUV6cmoNM6gIQwEB+k39bAn9ZL00YaTLFoY5nIi7JoJXo2DKEnw1
         7QHIVKeuD5oTQZPnhuNk5P1//+GiQlQ9zJL9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690934; x=1768295734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6/zpETfkXIXzs5jvYKUCRYKONy/bc8t30ozg4s3tEQ=;
        b=G/f8IDzKQtQB+fLRQNKK575xytPLWkkDvtlG5qL4GfV7GqSkb3cewSS8zdQviS1U/P
         OKV1epNT3N0ek8Ou5ER6dpD4xYPoEiXJQ+XvoBF8mAV3YrEjbdk5Zc17+vEYMg3zYynD
         wj0Ne8O3a7EuMy84JPA9mATJUkGicEjQFcoMnk0oSpcnZ1nQvx9nT93FAYmQbCztYYtj
         +xLA36oIFv678eANbV7iyYXcvGYvIbUXgy+9dC4/nxsM1YKbNkyU+y7RE+B5XInpex9/
         sE30c+7Tjgf4z1J3HPPUS7KpEwrmAARtQWQ/GM8f6Y2+fVOGqVqg4x6QGAtyptOkkBpD
         oVng==
X-Forwarded-Encrypted: i=1; AJvYcCU7pXpfa+nmsKQ2og1zFCyTVipx66HTfhekftABw1NQO9vReeSRY3vXYUA95BeLKTdBQ7LVg44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxU5mVza4i9BtsYA8EA2UcikJxkZ5/i2Hdt8+kH+YulH9LYo8m
	FHZFS9zYnx3KYPqIjowzvk++bqrJ+5rbvZyeVOoJhMH28hgFO361z+PM4QAgSuJhwak=
X-Gm-Gg: AY/fxX6xtClg9vXnQYzWP8vz2UVBoykzueLwX8TndNkCJwvMp40lD6QBv+An33MfDRj
	EmyIzQgvwVTWgZDia1qTnS0qIbgvr6UE6NQJ7hRRdNptIprr/7eKx5MX0U+CVIHOVE1m0STw4aO
	8uieDMjJn7Hzny9doHUQIH4YPQg4WDlNqFgrT8tlCt5ndSqZQ2bzaOhuGDvSUwiyBjDPNXhK9YZ
	vM7SoxkTd2ZbSlxmNepjGsY3Q7HGrSBQx/x468AGjYQkN+iwREl8LPDMcwtQSrZbJ4nWPLe6esX
	aGAtS3L90+DZGPLQztHU/wQlsfwutFWXI8OXv9dAfSSG5ItCZLlOEZ3VvcepQX7SuR6D3L4+wIG
	2yxdz4U8hivggbAmZSvrJSAD94ZGoEiJwTwoTdQcVf5tYRTCCfVHX1LBCprKqdeJUUpINOMQoCy
	JLp0srXX7ghGqvirDeunU=
X-Google-Smtp-Source: AGHT+IHa1yFWPnvONAfuUp5TLEw8FoXzXY4i9ww+OmCrNhj1GQ19Fi4TwPShASdRT4IaN8gbBkvqQw==
X-Received: by 2002:a17:907:3ea1:b0:b83:1326:a56a with SMTP id a640c23a62f3a-b8426c68092mr253739866b.58.1767690933968;
        Tue, 06 Jan 2026 01:15:33 -0800 (PST)
Received: from cabron.k.g ([95.111.117.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27c0bfsm177640866b.22.2026.01.06.01.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:15:33 -0800 (PST)
Date: Tue, 6 Jan 2026 11:15:32 +0200
From: Petko Manolov <petko.manolov@konsulko.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: pegasus: fix memory leak on usb_submit_urb()
 failure
Message-ID: <20260106091532.GA4723@cabron.k.g>
References: <20251216184113.197439-1-petko.manolov@konsulko.com>
 <b3d2a2fa-35cb-48ad-ad2e-de997e9b2395@redhat.com>
 <20260102121011.GA25015@carbon.k.g>
 <38d73c63-7521-41ad-8d4d-03d5ba2288df@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38d73c63-7521-41ad-8d4d-03d5ba2288df@lunn.ch>

On 26-01-02 23:02:53, Andrew Lunn wrote:
> > Sure, will do.  However, my v2 patch makes use of __free() cleanup
> > functionality, which in turn only applies back to v6.6 stable kernels.
> 
> I would suggest not using the magical __free() cleanup.
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
> 
>     Low level cleanup constructs (such as __free()) can be used when
>     building APIs and helpers, especially scoped iterators. However,
>     direct use of __free() within networking core and drivers is
>     discouraged. Similar guidance applies to declaring variables
>     mid-function.


Heh, __free() is OK for APIs, but not drivers...

Maybe this text is a relic from the times auto cleanup was not fully understood?


		Petko

