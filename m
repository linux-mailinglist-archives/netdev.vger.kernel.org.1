Return-Path: <netdev+bounces-106233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F6915664
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 20:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64CA1F25651
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C85219DF94;
	Mon, 24 Jun 2024 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="kZ4P3ifr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D937182B2
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253264; cv=none; b=YafivzLdcBxv6tDfllbjbjBHY9Xs32AO+bBOW4R+u2SMB5jH57GCCl1t6aUalMe6ntCRgyKfEU7v01wSPhkXraHFmDM1b5x0aevJ3Z7Gxexe1gUritrocYZ9+rgJ3AJJoZwcW5KOE0bfHslqz7EJSsuQbnGVwPsp3fuJkBMQVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253264; c=relaxed/simple;
	bh=+8LYlsEfZQaWimhKSuj+BrBfsXNCrDY1Q9PSAy3sVv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/orViKU+BCfJpOumDovbkyntOXNLrl+WMO/GHkY2SSXFYibKjpYPRJ9mpVQmXee5hGlp8i9wvcnnQnUE6XvmC6DzPF+agrgKvbP8WDSbculOIjFvHf5VgQgYDFrAK5HydXKxwe9ICrqQtytyArv+QR7WgeD0TZ654GVRwWiUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=kZ4P3ifr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9de13d6baso30899855ad.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1719253262; x=1719858062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfsPFIGM3GyuDwC317K935A6v7LfUkQBBtGvjXr3aM0=;
        b=kZ4P3ifruB5QKh8zRH1HfjQlHmtxFQOxh+9HSv6WVEzK4QSERhnr3xZ78OZ4tlQLQk
         UHaW6MofMPym6mS/B+t3tHMfBaBKmzt4uWCvXBBHav+iy5SKaQYENduFheW4wSIQN9U9
         S80wovB1pOicxCpW7RgHnekj3qzjY8D/6uF57OzRUkGlrgOGtuaNEW0civSr+OEcVcp4
         r1pYcSucUrNlqrMsdIVy9A7Z6AWSVp0yQ53fQ2K4WF4WzTqzjMtrKHuNsNE0WNMQx05U
         YQeII2D+LjEN8Ry0/XJeOigjsIVDSDxJdmltPfzaJslV2zFvTtmy8mlbk5vJO9ahBzhW
         LXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719253262; x=1719858062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfsPFIGM3GyuDwC317K935A6v7LfUkQBBtGvjXr3aM0=;
        b=QmPGDHnBA3ZVTao9JtoUwSWKiKtvzZqCqLkB54B4jRqQvkmmm9qoepVn3HGMaotUKW
         3jKkw8NYC+MCQF/OphT4/juV9PHm4MvLHgv1Tjf0CA0zqH4NpqUpvCT3UVLZRWVg00ZD
         QwcUlLm4OuSDpiqOb+Gq6mqXX38yYbYQAs7auQvfm+jQ4LfQQFKA5EuGuPi3MIInxgbh
         SPj0imVLIj8pyAkvlRcoRycea2sr1P2SG9mVzo/5/2FKdF+YQ6x9cUoA+Yb1CLt/M2pW
         5zTw1iuijOdCWkm1anM58/JmEAHKDC6/ZZs8dxAMbzOYd2n1BQqlnBvUt0UvQwmUCBFi
         jchA==
X-Forwarded-Encrypted: i=1; AJvYcCU66Y6LajpR+G1/x9wZvYnPBdHGjfhyAVndfoV9HBC5RlVJ2tSPam7cMn7rpHVmNkp3B1HcBcw/qwSXGwSqWYcw7PbWoJU/
X-Gm-Message-State: AOJu0YycCFTJJnOCErs7sz68PEehyGwOftGqsW3D/priJSxkzDHam72g
	8mBi7v2T3CbnaJDxM+OJxjHOfnIt4gebsK8sgWWnCnlR6gu4CfhzX9INFB6pMxI=
X-Google-Smtp-Source: AGHT+IGMLYMn5odILjcv96Jl649rhYyerg1Ed087qYu2c0Xv3BdbGKA4CyVpQNCD/ZXPQvLI01Ijew==
X-Received: by 2002:a17:903:22c6:b0:1f7:26f:9185 with SMTP id d9443c01a7336-1fa23f22930mr58326485ad.10.1719253261626;
        Mon, 24 Jun 2024 11:21:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::7:10ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb5c93sm65347045ad.267.2024.06.24.11.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 11:21:01 -0700 (PDT)
Message-ID: <ba5bef44-c823-4ec3-bf2d-66f66821d043@davidwei.uk>
Date: Mon, 24 Jun 2024 11:20:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] bnxt_en: implement netdev_queue_mgmt_ops
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240619062931.19435-1-dw@davidwei.uk>
 <20240619062931.19435-3-dw@davidwei.uk> <20240621172053.258074e7@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240621172053.258074e7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-21 17:20, Jakub Kicinski wrote:
> On Tue, 18 Jun 2024 23:29:31 -0700 David Wei wrote:
>> +	/* At this point, this NAPI instance has another page pool associated
>> +	 * with it. Disconnect here before freeing the old page pool to avoid
>> +	 * warnings.
>> +	 */
>> +	rxr->page_pool->p.napi = NULL;
>> +	page_pool_destroy(rxr->page_pool);
>> +	rxr->page_pool = NULL;
> 
> What's the warning you hit?
> We should probably bring back page_pool_unlink_napi(), 
> if this is really needed.

This one:

https://elixir.bootlin.com/linux/v6.10-rc5/source/net/core/page_pool.c#L1030

The cause is having two different bnxt_rx_ring_info referring to the
same NAPI instance. One is the proper one in bp->rx_ring, the other is
the temporarily allocated one for holding the "replacement" during the
reset.

