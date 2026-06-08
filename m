Return-Path: <netdev+bounces-296679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6zRuG379Jmo1pQIAu9opvQ
	(envelope-from <netdev+bounces-296679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:35:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 636476594DD
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:35:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=om4WQfHE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296679-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296679-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81D11300530C
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364CA23EAB0;
	Mon,  8 Jun 2026 17:30:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A561DD877
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:30:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939855; cv=none; b=gJGCDAfRuJzPUTZgd4NDPf5izkdHI3zieSgVP4i70GXRNfJ/X11ubr8ZCCoW593IhW7rrusjoRoSU7EyUzcXuocZeGwgdGUSS1qyUk95Fq07BuSliqrU7ccBcYcqhGfvSyTOAPnoju3gn/JF3XDymbGlIOo7ziR6fj3RCQjQ/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939855; c=relaxed/simple;
	bh=8kCMTwljED/L2rYr27Y22xXrKDlzMGCGEZr76dtycjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zkb3Nf6RmxI65g8YBhDtkDSGecXO7gKo0ZaTXUDyV+PWmYX2EbNgsPaxGiBTgweKaNVRLtZn0b2wOeZd+KJg3cx7SGa60SNsEVmkJVA39lykeRTZnzNxvv5Ii3XEJefClRPSwU9UkjOIOwnpfi+o+HRmJdPqNGo92siHbXPpkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=om4WQfHE; arc=none smtp.client-ip=209.85.219.44
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ce9df31130so74606656d6.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780939853; x=1781544653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu8/bo/GD+ueu+T4fB3U+9+0cJ9Sc/+ZCWEG94ix8pc=;
        b=om4WQfHEu/gXtWdtAffkc4eZi85w3lHvVVWRpIRY5GujPf6EK3DeDcmeErpkOdE14J
         H8wHTzThy8Dfj9HhtUGLlo23jyYSzJKor+mQCoAnJmMXWkaML/r5sD70NeizOgfzh4/r
         dU0byJNeGLWKqH9z/eq1/xus4VICLn/Ny4EAM92/4GnNO/wGRGcrTLEr5hx8ITHJNSQF
         OLMKPFcJWs2XhpYY+t74XJIoCbHgVa3FTzh7h1ljg8Z0IFVYhLix8wGCCtoadyzoooL3
         6nPHWu5BFpK8p1eaz+AXe5AzAcmoNqP+8X9QGB8HRhSxo+mDBnGXj96poD9lVyot/ixA
         oiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939853; x=1781544653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu8/bo/GD+ueu+T4fB3U+9+0cJ9Sc/+ZCWEG94ix8pc=;
        b=gFPbTFg2IxI2OtZXiudECc1bm09ZdG1qIhTRHt5vcmJbM6s9+gTCIwTFObaz42JBGJ
         nnV6ze0LZgy5KKIwljzTUbbUHCXQHQyAvrHTVWBY6gkCrUM4bfxHzqMQPcQbGlLIHkUA
         9yRyT/p5wHY4QFpVGRAZ797tKymkwwABSheppK5YbwnBSZHtv1H3ZO95wHWIr+7pP4qR
         wWtMBb80PUc0rjgvrPw+jEuXEwv/wpeesA9gxhVVuItD8wy0BI0aVSiC2wJyFnL2344o
         wWC34+KbjlOZwDyw2Nog5fIW1zkiKTTp7nweT3axBDtN1PqwHJgKlyW6nKLcyQmZZDBS
         0FCg==
X-Forwarded-Encrypted: i=1; AFNElJ9qdJc+UUb4mHHyTzff87rBFNwAHs54Vaz30C0ZpwrbSiwo1vIQWjEXAdZwUnIS4t+u2ceP+Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyT+WQPj5VT7cFwlV7Jz4qwXc1aRzNOIe/oZf9XBB9GBXBtmaG
	QbcBmJT1N4uJvER53LYgqv67DBsxPPQl9fEiHcfN5rraDnmuzAXuBqQ/2vVG3anb7tc=
X-Gm-Gg: Acq92OE/aGNtnahhHrZgvPnW26Dat2OsYjumrD4nR6fXQlhJN/XXZ7a2z8Dnm3/j9yi
	IZEHp4eHtl8NunRnO6f0G+rCQ13q22VRhgOl0t0YLQyI45puBxeCP7SAAQyxtfEYG6rK/QvA+YO
	Aq8BHqODT2eJj6AmhTNVCZ2I3UppSBWsyuY04JfkvzRjyTOS5QXUdfAwKsttnj5I75aQrZx//aj
	0jEzG0qVNtO+EV4bJEs4Mkh49GMoqP0vwykuV60ilhZnWE/sYVDTkGFJHt8OaWF2y7i++rJL15F
	3lbIqGi8iB7t4t6twQrVffESwMolWUDin8m+fR1/XjlS8suyUvUK1tLU1bJwGG5BR6M7C/aN5Fr
	l/ztiVoYTcuElVlDnj/ikOMjGk/gWwYQdCulUcDOB409M2GhFekX0GPfTQa0l7T3D/Nw7JOJroe
	EL6YsdvA5vA3buTD+D3JcXOuhXiKV/ku+n35DQX7ZGCDY3SDhDJn94NK8YaN2ppXhGSoHCtYcUQ
	e+WY1gH+EfvsJRNNnp428CNgtU=
X-Received: by 2002:ac8:59cd:0:b0:517:b68a:8d84 with SMTP id d75a77b69052e-517c22529e3mr30782621cf.56.1780939841127;
        Mon, 08 Jun 2026 10:30:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb9bd6sm187424546d6.13.2026.06.08.10.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:30:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWdo7-00000000BOR-47jj;
	Mon, 08 Jun 2026 14:30:39 -0300
Date: Mon, 8 Jun 2026 14:30:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: leon@kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [for-next v3 5/5] RDMA/mlx5: move mlx5 clock info to common
 struct ib_uverbs_clock_info
Message-ID: <20260608173039.GE2764304@ziepe.ca>
References: <20260606050003.3648306-1-abhijit.gangurde@amd.com>
 <20260606050003.3648306-6-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606050003.3648306-6-abhijit.gangurde@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296679-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:abhijit.gangurde@amd.com,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 636476594DD

On Sat, Jun 06, 2026 at 10:30:03AM +0530, Abhijit Gangurde wrote:
> Use struct ib_uverbs_clock_info from ib_user_verbs.h for clock info.
> 
> The original struct mlx5_ib_clock_info remains in mlx5-abi.h for
> userspace ABI compatibility.

Please don't do that, we generally don't do compatability for
compilation only, especially in this case where rdma-core is the only
consumer and it has its own version linked copies of all these
headers.

Though it seems like the contents are the same so you could just do:

> +/*
> + * deprecated, see struct ib_uverbs_clock_info from ib_user_verbs.h
> + */

#define mlx5_ib_clock_info ib_uverbs_clock_info

Jason

