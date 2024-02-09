Return-Path: <netdev+bounces-70453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F584F078
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 07:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CBF1C222BE
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 06:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A41657AB;
	Fri,  9 Feb 2024 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eqGvwdxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F49F657A3
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461732; cv=none; b=rCQ5LzPEDMb6v4jfEOJi/tPeJgw0gQ4I/R7Q3ltZ68+7EgovXN43co/Za8hBNltUUZg2C0BXkopbIsYseJyzZ32ykCuoaAdP55qrXllrkbpNBr2IF8NrsnVmj8Y9o0gvM8VY+RLeY8sZuECCiIcj4+WemtaC4XtYTKy1I28ijdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461732; c=relaxed/simple;
	bh=711cHkfsOgZL9MPEIGbLJw6rxtGeCrt5XH4lwE/BkYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpFaFoGUb5/0z+0OAs25kiBi7qfhz8JXHiWyOyiMTslIZpReaCXWTdO6xEl1nw+eAAvt4UMfn92hoiuW4SgDzqazBDzHtQ0gRbm0OjGLucTB/L7V1vj+WgIKCa9STsFNlu4QZeJJv49WCQaOpKsj0cnaY0LRu2Vyha/IQHFpIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eqGvwdxR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4102f273c46so5598365e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 22:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707461728; x=1708066528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdmhTFAG6NaVssbeznKI3+O6lsTy9x8b3RBjAgRQHbg=;
        b=eqGvwdxRp44etQhRBblUs8VkRGXVUfA2vnANJVH8uElAkHKHFfXhULxGOyvf7xVnZ4
         kImY/S4awjzl76fCWYqB9BRHnsGwOMcCVvyjTAuaCd8td5ZMwyo1YhxyGyR9z1PcJPD1
         FDbO1Njk/o5S84xg14Zh8Hw06B50ZLaVH698037NfMisAbYfBM2cxFdiBsYz9RE2Y9iy
         N5K1CAls9q594WUBOgL4HNhzand6c/kmhto2J/SiMfayedlVBKMl8cZwBLCQeELdNJhT
         vOJiuV/cOdAS1qKK6dk9tChNb6QBJCv4bEwds/Q0oUIBFh250gnBWWENXEuLXVYLKopB
         sGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707461728; x=1708066528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdmhTFAG6NaVssbeznKI3+O6lsTy9x8b3RBjAgRQHbg=;
        b=raq7yOkt6pewm99tK79Xtes4ehqxEUcoDdGfchLFYAFvVdJTu/XOjPHa5IRSyM99rl
         1w48fv0LDC+ipR8+QX7O9usAdTQy0kf3HWNgqI1d2bPGWYJ4ykLHVrHICF/wqiBPsPyz
         LCbMgH/QmA5xjqjPFOzlVvseYch+wAW2OdJmOV0e++2qzwxk7lKBQlj0tPKz8Rqvrl7H
         dX2p8YBqGayX1XvwdeWGNV/RHd8XO/8Xng+VRVvb80ZRp4QilxBEBCPcuaY8zVngFyac
         UY4MuxyIfunDIcDPXwZsAaUuvKvIVJcbi4iNSQ7pnZ/lgvcD6yMbRyOvhWPyvNYZeucq
         Mq6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV5JV2np64kR+DpV+O+eaexx/1TkdtK/txzGsaddVidYzNULzIk7ZaFkqst/jmzG/7Z9aXjM6Hm45CO3ztNlwbNaxGWT/c
X-Gm-Message-State: AOJu0YxztnUgqWuETyBJKQwekv1OSdrX0jjWHtHKiZeXWm9gY20QiTMQ
	70hbSEalCC2Tgvxg0tf3522unkREkIAjcDB78pPf9jk5WZqOhFHSBECu1gzYjCY=
X-Google-Smtp-Source: AGHT+IEPu2RWDQ+KqY+GeGeneEFcPV5/5TrF68Jrl3lB0+Rbgxl+MQ17fkELizSi9cWf1HBBZPTqjw==
X-Received: by 2002:a05:600c:3110:b0:410:6d90:8efa with SMTP id g16-20020a05600c311000b004106d908efamr409350wmo.6.1707461728520;
        Thu, 08 Feb 2024 22:55:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3ZYsENv9ILXsLxYLkoe9NLe2w6+ikhpacM+wGjUX7q/ipaDRsKFVQUfi8xwGVEX85vmWtSyZGq4MkyiRNupbk43NCFAklZdneKzTX63V4ytF7/CP+KrZZgVrOQ6lDQ7Wo637qOJObgAr8t4UzqL2yaYrfY9FdDQ21B/Q6fM5sa8DtEwQG+SA9ngQXvM66WX09fWUMN6Sg7Ipjybk0OxUaQ7GK7r0i/xJXG2USZCMMRweXdtbT+83e3BZzKqbecMmCLdgsNI7Nu8BnPf5laPCuQkUk7Rk0NH0CZF1ps4+DETnbzq53zPTGHYe+Pqmpx3Knv7r4XaJ7btzUlgjBYOUV6/sKc8VrxKxZSG7NQfli0wp59duqk+a/XbCSExbdQnBNU0d+Ds9Z1kf0aL3aMIFNJAHdJqXvMSZyxjGAu+91R6WEFFYfeKG5/MGSYGlR7p+HaXr+/rHEBucD3Ag36XSbQ3C35xNnG253bmGfdYJSTho=
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bx23-20020a5d5b17000000b0033b4b4a216asm1037210wrb.14.2024.02.08.22.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:55:27 -0800 (PST)
Date: Fri, 9 Feb 2024 07:55:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <ZcXMXhQs2n7c4LkQ@nanopsycho>
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207070342.21ad3e51@kernel.org>
 <ZcRgp76yWcDfEbMy@x130>
 <20240208181555.22d35b61@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208181555.22d35b61@kernel.org>

Fri, Feb 09, 2024 at 03:15:55AM CET, kuba@kernel.org wrote:
>On Wed, 7 Feb 2024 21:03:35 -0800 Saeed Mahameed wrote:
>> On 07 Feb 07:03, Jakub Kicinski wrote:
>> >On Tue,  6 Feb 2024 23:24:30 -0800 Saeed Mahameed wrote:  
>> >> From: Saeed Mahameed <saeedm@nvidia.com>

[...]

>
>> Ok you don't like DPLL,
>
>I didn't say I dislike DPLL. I think it's a very odd example for
>you to pick for nVidia's contribution. My recollection is:
>
> - Maciej from Intel started developing upstream API for SyncE support
> - I asked him to generalize it to DPLL, he started working on it
> - nVidia expressed interest in creating a common interface, we thought
>   it'd be great to align vendors
> - nVidia hired Maciej from Intel, shutting down Intel's progress for a while
> - nVidia went AWoL, long response times, we held meetings to nudge
>   you along, no commitments
> - then after months and months Jiri started helping Arkadiusz and Vadim
>
>I remember thinking at the time that it must have been a terrible
>experience for Intel, definitely not how cooperation upstream should
>look :|

For the record, I spent huge amount of time reviewing the patchset and
ended up with redesigning significant chunks of it, steering Arkadiusz
and Vadim the way I felt is the correct one. Oftentimes I said to myself
it would be much quicker to take the patchset over and do it myself :)

Anyway, at the end, I think that the result is very good. Solid and well
defined uapi, nice kernel implementation, 3 drivers implementing it,
each with slightly different usecase, all clicks. If this is not
good example of upstream cooperation, I'm not sure what else is...

But, I don't think this is related to the misc driver discussion, I just
wanted to express my pov on dpll process, when I see people talking
about it :)

>
>IDK how disconnected from upstream netdev you have to be to put that on
>your banner.

[...]

