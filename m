Return-Path: <netdev+bounces-134113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD769980B7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC50DB24908
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E9D1EF097;
	Thu, 10 Oct 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5/eB7Bk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A591BD00D
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549414; cv=none; b=Cz89/qtws+z0GEV8k2VbTeJTu1V5382NIJpACVTfl/1LW1Bbc4Qc+Tf2x6zEJSGj40gA4rlad4rARj0Ww74Cvz9YLrktfa+fWUEv6IAhFjXol3xEDzxThqKZy0dE6GvtekeH57AX6S10ttgFwmTk/5UtEhQnOXlYHMJ69LiUjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549414; c=relaxed/simple;
	bh=RPICO/xSZ1JZIfI5STBLI0MQwsr43F5yawZuz7URMag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V24XNM1nLMcQeukx7LvDnxCz07Kf+FBPR695E6+uDD4+MvPtO6gL47cXpr0s6eq/7tcbDeE5qHAUkrfd9xvjQ+zj80keZsqzfTjxZRUfdsAEauxBb9WPtuB/lVIglHF6B6LH+RjfYrkkSug8uZAPR9q1Iivd3eaPdYdKhnMKXDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5/eB7Bk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728549411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blXE1l3GsqxUERKvaiIELpZWy2wzdLKhdqfuQHdwWGE=;
	b=E5/eB7Bk8eOxPdZK14CA5DAaYEwuhDeST0qxOeQ1tZWddcRCdGsOI1YYoboQfs8GC+h5r/
	03Q0wtxsCiCd4dVUKXyf8WuwPhRwEJt003hUVlnuu7G2jgXjWmf0wJUATRbX/iXPvN+znm
	kc/3a76V82GWaPKFk3Ethq3JKV3+1Dk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-XAGltDhROrauCwRWRuHmpA-1; Thu, 10 Oct 2024 04:36:50 -0400
X-MC-Unique: XAGltDhROrauCwRWRuHmpA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5399524dfbcso597107e87.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 01:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549409; x=1729154209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blXE1l3GsqxUERKvaiIELpZWy2wzdLKhdqfuQHdwWGE=;
        b=UjkZ0SURicOSoJp8ijCkRf2r8L9MZ/lC0Q6+Tcu2iN8Qak8TBHpxM0hvM7sRa0hYwa
         JBofQDPksH7ybsH7gnj7lyk81Zji/WX4BVa9eb3/pCdqg8whYBLczMZPCvatghqd1iP1
         RIvPaGm+hCLkmkwJNDx3tJShzjC1zY0wxsUDzzpB274uibkUPj508PA4Jqb5Var7nwx5
         RWc2RqWSQjkM4MoJT6nGuA6bF0wT5atMJHl+6eJy093CEhJg8gw/HW7iI3JkaEjQnlI9
         NCCaC03ynPUsa88N8QCNyvEhCV03HeLHhYmCiH+dDLVRcmjSuqLGERNTP2RAonpBl/pt
         POWg==
X-Forwarded-Encrypted: i=1; AJvYcCX56b4Sa7Pg14R5EZQMVfiRsfPYdfo0CZBU6MRfZjV4AtYnfeQrQ1DIXJUgVJMJEhvvZoSU0F0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+vBj3awqPQKbnqLhYanwjKffMDx5I6MAQVgWV+3bv+aMNpxB
	5BUbupCxq9lDDYjBHti7DQFO7kKRHwGgyvgM2ghlcNAzMNpy2WYU7P7nsBktuqc2VCcsiBX2F5b
	jDv9gcw2M7+fCjbc7FVTuPp6RmLHne3dsE057vo7RkMXiB89GFgZGJQ==
X-Received: by 2002:a05:6512:2245:b0:536:548a:ff89 with SMTP id 2adb3069b0e04-539c495ee90mr3483465e87.39.1728549408599;
        Thu, 10 Oct 2024 01:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK/8PwHgM8qolzAiwL3ib5NLCzTm2E+zJkvoQgp+wP6OVio34GwwGItF3MHwZiaAlPyVAJCQ==
X-Received: by 2002:a05:6512:2245:b0:536:548a:ff89 with SMTP id 2adb3069b0e04-539c495ee90mr3483448e87.39.1728549408225;
        Thu, 10 Oct 2024 01:36:48 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748f0a5sm41091745e9.48.2024.10.10.01.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 01:36:47 -0700 (PDT)
Message-ID: <749706b1-f44a-4548-9573-5f7b3823be67@redhat.com>
Date: Thu, 10 Oct 2024 10:36:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] mlx4: update mlx4_clock_read() to provide
 pre/post tstamps
To: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>,
 Richard Cochran <richardcochran@gmail.com>,
 Mahesh Bandewar <mahesh@bandewar.net>
References: <20241008104646.3276302-1-maheshb@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241008104646.3276302-1-maheshb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 12:46, Mahesh Bandewar wrote:
> The mlx4_clock_read() function, when called by cycle_counter->read(),
> previously only returned the raw cycle count. However, for PTP helpers
> like gettimex64(), which require pre- and post-timestamps, simply
> returning raw cycles is insufficient. It also needs to provide the
> necessary timestamps.
> 
> This update modifies mlx4_clock_read() to return both the cycles and
> the required timestamps. Additionally, mlx4_en_read_clock() is now
> responsible for reading and updating the clock_cache. This allows
> another function, mlx4_en_read_clock_cache(), to act as the cycle
> reader for cycle_counter->read(), preserving the same interface.

It looks like this patch should be split in two, the first one could be 
possibly 'net' material and just fix gettimex64()/mlx4_read_clock() and 
the other one introduces the cache.

Thanks,

Paolo


