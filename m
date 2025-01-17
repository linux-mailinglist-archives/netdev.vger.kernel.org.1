Return-Path: <netdev+bounces-159142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A5DA14801
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 03:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833823A717F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 02:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3687C1DDC35;
	Fri, 17 Jan 2025 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="K5ALaNwG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493111CAF
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080162; cv=none; b=bWwYpySalcpHjG1ogu5FXRp3w/ScCzi+isFt+yu2o1ClqXBaMNdZXkmIztL9s6Y56kVPLpWYHo5BxKSbc1xwE8r801BhpxcnbS2Py9GyODf7wBnISaCD14zfRRyg+MKmqY5ZHyk/cr50f7Hbe/fYGf0ECVmQSfHZCA6U/fPsk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080162; c=relaxed/simple;
	bh=GK6afS3pR7STHAAJosx89JAfCV4nfsvfsdBaf/OGF3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlWXaTM4EVuOFsv4UE5A9aBZ5iXudMSdO52ff01dR70Tmdw9U+0+cXqlipFrGIOpTZu/LPO7RzQveikfeJmYrFh1L+R9s0W3+YsYZ2VElGFdTX4dnG1NK4G4dlVWuD3SDcVR9YaDElYOwU4bW9vHqW0ZJqJpxQ9n2XqCiaA2mWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=K5ALaNwG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216281bc30fso37004005ad.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 18:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1737080160; x=1737684960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCuVVzkQy59UCcZDOiVi2Rn0kAlSnwhXHYiolAdQcns=;
        b=K5ALaNwG74qYfE1QmaRna5H4CbEbuA+ufaQ0BuDvDyfS+vY85fabswCaV4QZAOzunX
         QtbXo2MUuLsIhfPwryez9Utum3rJvCcW+GhpUEBTISnas/Qx1stoUWX7m77xmVbzNk4i
         MOyNCm7hh2wlcNji270u7E76ma0YKzHzXpEIOHnCPE11jX2oIndyLLdaWiPYZk34isfm
         U4c90wWnC3+JqORVL6WNHwU5if69yDwBKwsG0+dDwxKpCyqqXsjSTylG9Z7uNTa7G3Ef
         LWDKmRMmsg5bUQcC10W3GvUIrWkbcXi03FD6xAluiUyNJrNdsF4ULBfOoafeZ0276HhL
         cAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737080160; x=1737684960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCuVVzkQy59UCcZDOiVi2Rn0kAlSnwhXHYiolAdQcns=;
        b=RWgHhB8lgvVTPtNTtK8wQjlykKLxSiPy82C5pJMd63y+KRShmHzOkL9Wzg4iCYL+Lu
         idxJjvO2attraWbC4Uf8PvZXuKVjM752wSHozgkvo6M/Du2H7LF5xO7xDTTP0of+iyoi
         WOIa7tOezanLGGfKncVxeZxn/cTNhN+QrC0WXmk8CbvRwktgHS3SUpJ+U+Wb+FoVMOPo
         O1TA3bixb928aKN5bEAJNDgZCWKsj1f8etuDsewV1gXuCqzhvfdiRZOmnJD/au0HZybD
         6zptqogr/1cxqPn1XcGRzCyfZCPVsy6euupaV6Y2OkLwbJK9txMyh0KM4MhEgd7GfGif
         cxKA==
X-Forwarded-Encrypted: i=1; AJvYcCWy9MDi0WKiDP3PvmxP5ShZZUohjtcOQJy5aeZtw746zlVWWdKx1AnBbfUwgIJFOBiQ+TyzwOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Rq5foBiK0x/eVaZdpfdce+MJgFSqGe5RZdbevW7KSvll8XLc
	rC6fLNB5GBf140fROeHLAOUqnOcYvwP9UgAT5j6Qt8L3FB3C2BhxsARdmE5hbKOzg5UOmQhqcip
	mkk8=
X-Gm-Gg: ASbGncv7FtRyx9P2s0Ap/4ETaCYBnA7eqpEomXtcSgR1H5p6pzZXyJiYmPBpjkll9qi
	m7fca3u+Za89dd9Rzfcx9oag58xKFmvEmXqGBhw4J4tWFFlqYgPpIaCAYITMKxA2xqjkH6PlGN6
	4QEghrmglzb4b+UJ9AacnIXWf/mFU4OgT9zT8l93rB7PHKpqoez2h/OBlE0+GZcRxaDW1RBxv8S
	4f37KkQIl16gmHQArfrj/jYzi4lYADfr5K7xmW9LJiPilrN4/WQHsd/jAkyo3SjFMOYx8IpYpdJ
	e9+th1Z7Pe+xQHkOyg==
X-Google-Smtp-Source: AGHT+IG7iU445RErzMyHQfWntDOYm0u6q8Co5wgOH5BezmytYlTIPCVKI3H5lcFN36ZKluXllht/Nw==
X-Received: by 2002:a05:6a20:b805:b0:1db:e40d:5f89 with SMTP id adf61e73a8af0-1eb21590232mr1301770637.28.1737080159994;
        Thu, 16 Jan 2025 18:15:59 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:cf1:8047:5c7b:abf4? ([2620:10d:c090:500::4:b8ed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f1776sm690701b3a.7.2025.01.16.18.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 18:15:59 -0800 (PST)
Message-ID: <4f8dc7b1-0213-46a1-85f5-2d77e7b98067@davidwei.uk>
Date: Thu, 16 Jan 2025 18:15:57 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/21] net: page_pool: create hooks for
 custom memory providers
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20250116231704.2402455-1-dw@davidwei.uk>
 <20250116231704.2402455-5-dw@davidwei.uk>
 <20250116174634.0b421245@kernel.org> <20250116174822.6195f52e@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250116174822.6195f52e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-01-16 17:48, Jakub Kicinski wrote:
> On Thu, 16 Jan 2025 17:46:34 -0800 Jakub Kicinski wrote:
>> On Thu, 16 Jan 2025 15:16:46 -0800 David Wei wrote:
>>> From: Pavel Begunkov <asml.silence@gmail.com>
>>>
>>> A spin off from the original page pool memory providers patch by Jakub,
>>> which allows extending page pools with custom allocators. One of such
>>> providers is devmem TCP, and the other is io_uring zerocopy added in
>>> following patches.
>>>
>>> Co-developed-by: Jakub Kicinski <kuba@kernel.org> # initial mp proposal
>>> Link: https://lore.kernel.org/netdev/20230707183935.997267-7-kuba@kernel.org/
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>> Signed-off-by: David Wei <dw@davidwei.uk>  
>>
>> FWIW you still need to add my SoB for Co-developed-by.
>> Doesn't checkpatch complain?
>> I guess not a deal breaker here if I'm the one applying it...
> 
> Ah, and in case I am not..
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I'm sorry... Checkpatch does complain but I missed it in the sea of
warnings of 'prefer unsigned int to bare unsigned'.

