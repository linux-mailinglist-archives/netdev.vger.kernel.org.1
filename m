Return-Path: <netdev+bounces-67053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F742841F3A
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAEE29575D
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB56027C;
	Tue, 30 Jan 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT59q9/r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B3657DC;
	Tue, 30 Jan 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606345; cv=none; b=Zp6X+bZ58KVKxfmh4tOxj+cmUdXeGU4swaSDKZMR83kFJzAaGhWGl7GU8d+bXOBmaVTY7R/dNRK2Ss5bZG9R/YwbYY6RHENqVC4bsZOXlBASCY9u519Be1K11yQT0kUFPAsEvf5sJW7O+Abn0Trj+AJJZV+N8M2iQ+gdwxwoHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606345; c=relaxed/simple;
	bh=CDEVKAukMSd4Ch9/i4zmBazocJf38KDwE3Uzg9xR78I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=sM47Fk7E7suPZN7CN2TbkkvKoSOSBLW4lq3cBsNSECg856ui1S+xwJG0wcxc0H6wv10gvmTpP3gR8iF2OnS7T7VzltarVH6eU+jD+jXX6lgwybueMhPKK0H2O16poXBVFQh3Wt8bi7vp2i8QC+RfgHlCxk7lc1C3qWo1h2WYE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT59q9/r; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fafae5532so402415e9.1;
        Tue, 30 Jan 2024 01:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706606341; x=1707211141; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bdstY2hKysbHEBB9RD/YGo6z98AGMmpK58OyypNypM=;
        b=IT59q9/rnbvK6hmEpXD5CyqswL1MX63PTHFYFremYQxcfzQVJ/tFh94u+3gDUYihSD
         nmja7HaQcWuSjoRaKfTrxjEutYPrir+Dv8uDCWbLYCm8pRoRM4Tu+h0k3UdEg9x2h7Xd
         7KuLJCsgmbQ+ScVKPR0EG9tuR3ke0OTleG3L/A5ogc43N4uxp9nArj/0V+1j2bV0IU0E
         Yy9eufWjDo09vgVQu+XqYxQPbd61/lwK6ItHZL624DYIDZhlUUa8XA9YjonWV7j303rZ
         1i4gzwIWHA7hBX1QTIabU4dMAD5JJModEa1GEKtqI1iILQtXKBDqgNvZqpBeCDiIWtny
         ey2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606341; x=1707211141;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bdstY2hKysbHEBB9RD/YGo6z98AGMmpK58OyypNypM=;
        b=OiMDLspaS+7uBmBsfinHpdpUZMAiDIfuZpUgluKxdGOtoJOZDlKBiD/B+Si/lE+qsc
         YbTN0wYEf6d4Hgv6pe98rbagR+m4XvonpZlCWvS/fjIjN/h0dGc4hwl9mZAFrxqcecxT
         1yE0t1qV4INcdfecdkUPqqJH3BQduffe61zj8q3ZF4Kk76TDICrPy7txWyx6AcNhLyAv
         hk6XTfvJWkxFk9O9F1Pai9cRP4TmcheDwqoSqbqrJpzp/2mS6vsp+8XU8+TICQPSjxrB
         Eva0nveWgRjMEthiqS5BsTMns1eqtl8ySHdi2D/RUyOBTxCbEY80eTtCqai13Q9PjOvZ
         hzZw==
X-Gm-Message-State: AOJu0YxypD00wHz2k9i/rsUZjwE2Y8usE8fYZgyQDiUMX/ikYCKzj8sd
	dtbTSWJBQhO8/C33/XK+aNe+KWqk8KzIgnUWNnhxlMpT7SZEZ1y7
X-Google-Smtp-Source: AGHT+IHtrAvZTqRVMu8om+eVDC5NRwRPwHIwC5z52RQNL0KsaPyjesn72We47CmYayg3wlQscbydaA==
X-Received: by 2002:a05:600c:3592:b0:40f:a661:ee6b with SMTP id p18-20020a05600c359200b0040fa661ee6bmr281363wmq.7.1706606341324;
        Tue, 30 Jan 2024 01:19:01 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id b7-20020adfee87000000b0033aebf727b2sm5464150wro.60.2024.01.30.01.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:19:00 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  Breno Leitao <leitao@debian.org>,  Jiri Pirko
 <jiri@resnulli.us>,  Alessandro Marcolini
 <alessandromarcolini99@gmail.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages
 in nested attribute spaces
In-Reply-To: <20240129174220.65ac1755@kernel.org> (Jakub Kicinski's message of
	"Mon, 29 Jan 2024 17:42:20 -0800")
Date: Tue, 30 Jan 2024 09:12:47 +0000
Message-ID: <m2zfwnuquo.fsf@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
	<20240123160538.172-3-donald.hunter@gmail.com>
	<20240123161804.3573953d@kernel.org> <m2ede7xeas.fsf@gmail.com>
	<20240124073228.0e939e5c@kernel.org> <m2ttn0w9fa.fsf@gmail.com>
	<20240126105055.2200dc36@kernel.org> <m2jznuwv7g.fsf@gmail.com>
	<20240129174220.65ac1755@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Sat, 27 Jan 2024 17:18:59 +0000 Donald Hunter wrote:
>> > Hah, required attrs. I have been sitting on patches for the kernel for
>> > over a year - https://github.com/kuba-moo/linux/tree/req-args
>> > Not sure if they actually work but for the kernel I was curious if it's
>> > possible to do the validation in constant time (in relation to the
>> > policy size, i.e. without scanning the entire policy at the end to
>> > confirm that all required attrs are present). And that's what I came up
>> > with.  
>> 
>> Interesting. It's definitely a thorny problem with varying sets of
>> 'required' attributes. It could be useful to report the absolutely
>> required attributes in policy responses, without any actual enforcement.
>> Would it be possible to report policy for legacy netlink-raw families?
>
> It's a simple matter of plumbing. We care reuse the genetlink policy
> dumping, just need to add a new attr to make "classic" family IDs
> distinct from genetlink ones.
>
> The policy vs spec is another interesting question. When I started
> thinking about YNL my intuition was to extend policies to carry all
> relevant info. But the more I thought about it the less sense it made.
>
> Whether YNL specs should replace policy dumps completely (by building
> the YAML into the kernel, and exposing via sysfs like kheaders or btf)
>  - I'm not sure. I think I used policy dumps twice in my life. They
> are not all that useful, IMVHO...

Yeah, fair point. I don't think I've used policy dumps in any meaningful
way either. Maybe no real value in exporting it for netlink-raw.

>> Thinking about it, usability would probably be most improved by adding
>> extack messages to more of the tc error paths.
>
> TC was one of the first netlink families, so we shouldn't judge it too
> harshly. With that preface - it should only be used as "lessons learned"
> not to inform modern designs.

Oh, not judging TC, just considering whether it would be useful to throw
some extack patches at it.

