Return-Path: <netdev+bounces-129922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 395F1987074
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D56D5B28773
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587E1AB6E7;
	Thu, 26 Sep 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dplgDuQ6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF81AAE2A
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343708; cv=none; b=mjWi7q442b78XppEsCl2M0GR0TgFW23NpES/DE1LEvtUMqoIyukfx3Z9FIpdFTPjst542HLfvUwccFnDleETuy6Uu0SfWlTfZKYrDDM4tlls0n3SXfiWjvnJ8/aVQ01uNve6jjiA6lSM3UykfxNSKI8GUFrXtVSfSVLEynunahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343708; c=relaxed/simple;
	bh=7KjcE0B1b3Lo+UG6zGvriAp6T9t+938/9Ug99PMsz3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8j4TS5Ranj1CJVkSUo70NW8SEW87GNB1GkaIfrfS2flr30kbvVVT8Ethb7oLsf5QpifcQ2Ad+2CTILISNufbNUCAcGeDZNupcbnD9H3Svng2UGFYup1KFItvr0z6/qUTPJDIcAZKjXzN2eVHgC58jgosV2Irw86YR56FxchIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dplgDuQ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727343704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=duedYL0F/SZtcaJ/2ctYIidXMcsINgd6fgzdoKb7MGU=;
	b=dplgDuQ6i4d2DP6H7Ji6Z55GxBowjR8Ln/5BN0Yzq63YwnrqkTuPZbuHsSOCZgtGjMuczY
	Y9L7B5ftdZEpepzrONR2++1YDOTSDEHrtvm99vZ69rZGWvt4ySdqTMFLG5aLbFeLq6mLxP
	vRG8WkASPm2BhLz2RehhR48WjdXRFjo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-FDgcNYgTPYiMqA9yF9CELw-1; Thu, 26 Sep 2024 05:41:42 -0400
X-MC-Unique: FDgcNYgTPYiMqA9yF9CELw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37cd19d0e83so132418f8f.2
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727343701; x=1727948501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duedYL0F/SZtcaJ/2ctYIidXMcsINgd6fgzdoKb7MGU=;
        b=Mv3BqhhvaEKE6ugsINoItBEwgcmaxizWKLVnNvUzikeC6zvONxfDqiw6DqJJ80SYGI
         52V6DnE9rljS87TeAqdzOCmH6tfcfwTobm6DYbbBIfQbEDv/pE3cMQk9B4lnaOzZePvS
         0Rk2hVh4QTiVckORylV7YQHVcNGKx8c4SCCkpvzLrePdK7VZ4k6BIcCF4jUwlcv/Nwua
         5+46OYv7o1W199loQe89n5l5N2XwR/I06bSPZZZsZievcvpY9Pk8dSu4Dh/rA4jzPcvM
         n6Q7/fTXo2IQpTif74B5GUnznS5fMkytmcaWMnJYd9sJSzc71C1KyTUnESrJ10Lhh9yP
         JNZw==
X-Forwarded-Encrypted: i=1; AJvYcCVfgU6w6hyEk9A5YUJJHwFoKO66E3tKZ8ohUAbkNRWgNbHIABIeVuDkP6FvkQOpvZuxSwjLTZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWwF2e7iX9QyYRcavMJn2cxAd1csp8ZZ2e8+FRelXg19zxqu+Q
	oaS0+/ZTRuKM2XoOBpYpZflrwydBgZd7xuDjmx8ynZfkpYxJ4G9nB9bXCYKMmKkdeX3JQFE11Z3
	ifses9lDDcLkAV8CsNAcJbznDme42CJL9c5YHFGFiXmZupCmQzTE9MA==
X-Received: by 2002:adf:f5cc:0:b0:374:c31e:971a with SMTP id ffacd0b85a97d-37cc22c292amr3012474f8f.0.1727343701342;
        Thu, 26 Sep 2024 02:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbNFmaQ62WOIINYfB3CeWV9VfSJOSRt842DmCJ3cUVE5vR4WBvRiBLHJBBmQvDyTZzZ/7Axw==
X-Received: by 2002:adf:f5cc:0:b0:374:c31e:971a with SMTP id ffacd0b85a97d-37cc22c292amr3012459f8f.0.1727343700913;
        Thu, 26 Sep 2024 02:41:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2a8b55sm5994446f8f.17.2024.09.26.02.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 02:41:40 -0700 (PDT)
Message-ID: <c51519c0-c493-4408-9938-5fb650b4ed8b@redhat.com>
Date: Thu, 26 Sep 2024 11:41:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 00/14] Netfilter fixes for net
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org,
 fw@strlen.de
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, fw@strlen.de
References: <20240924201401.2712-1-pablo@netfilter.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240924201401.2712-1-pablo@netfilter.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 22:13, Pablo Neira Ayuso wrote:
> The following patchset contains Netfilter fixes for net:
> 
> Patch #1 and #2 handle an esoteric scenario: Given two tasks sending UDP
> packets to one another, two packets of the same flow in each direction
> handled by different CPUs that result in two conntrack objects in NEW
> state, where reply packet loses race. Then, patch #3 adds a testcase for
> this scenario. Series from Florian Westphal.

Kdoc complains against the lack of documentation for the return value in 
the first 2 patches: 'Returns' should be '@Return'.

If you could repost a new revision soon, I could possibly still include 
it in today PR (delaying the latter a bit).

Thanks!

Paolo


