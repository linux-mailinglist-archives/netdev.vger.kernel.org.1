Return-Path: <netdev+bounces-138203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6389AC980
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677B61F21E25
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED0A1AA794;
	Wed, 23 Oct 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbVyUUsZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294EE1A00DF
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684691; cv=none; b=QqREP0lCr8Bfw1oKu7YHKOzLW7uTq2n//PAZyDA8IIhg7vKo2tR0Tc6Vid73XUL06U6qUvBHkbHAHKQ2zDIYyaMp7aytCdiSOWV/1KvXSPlYiJOWr7uM/z2IMjZ5gaBxukWfNq3QpxkNKngprUmiDsrNQx3zmMNfqetoPqFWHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684691; c=relaxed/simple;
	bh=9H+jPSglMipvsynqWginBG5HmJmcxmiYKU9L/k96CUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcM32zMobE4GcbEMDsW8xXx/VgZ5f9PfBEotRStVMnCmKGG5m6salo2oFhUpJKxszn1vcAMdX8xO6Hx9E38N3NAfA0qqxlgf/qAgzlqGML4jDrh3CzLHlWVXqIXDLE9DM8oA0u2N15V8q1JJQgB+FHf7yBHl7w5UbOJVgEI+5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbVyUUsZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729684689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mssz8CvkYVIcBitKTu06kb0S/cJ3eajJtBwsyREgho=;
	b=MbVyUUsZiKKzO5WrjF4hqjdV0eXG3tSxfCAmA8bjznrnGTiQ62ogKlO/OchS6tGNzyNG7K
	ZRlr6tKRokSrGTJSis+eQXjTFHDnocMzcv/3V7WtQ6ttYI1t0zVfaVG1UBktX5NP2CV5XC
	NeS/5MNAGt2PEdTjnelIt/ixoDVfCPQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-kx95MMuvNBy5r2Yn4VyIzw-1; Wed, 23 Oct 2024 07:58:07 -0400
X-MC-Unique: kx95MMuvNBy5r2Yn4VyIzw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43163a40ee0so41571795e9.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 04:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729684686; x=1730289486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mssz8CvkYVIcBitKTu06kb0S/cJ3eajJtBwsyREgho=;
        b=u2s6IxbOIHpgm5JuDE2NF1TkQhDnAiKBPQOBEvdsPxLHPPKI33swDBqDXGNlmkuFiL
         AZs+E2Jrp5jAKRli2Toc73W5S2suyekErZLM1hy6jNQfPLkJkLnUmvn7IxVWThysHRuR
         nBewAoOtARn2kL5Ha4JRzgXsPQiOZQQLvb4PeadoRp34rDg4e4NCG787Me/iD4YrTWku
         gPCXqKY3CEaJYHjwZKHtgb9aaLEQRWy1nIyd1jT18RxanBLnJY0rytbZrPf7SF3ooxFn
         qPlXlUILF/hJh3WE/gIBeQQt27YoVueTBf7ZdU/EfHYoeF6EQFgaRbYfGMkk6/Ran6ZZ
         LhYg==
X-Forwarded-Encrypted: i=1; AJvYcCWOdGpbQSONlCo8W+LXpk66ttXkxTNjdQv2H2211lQ39WVkWqqP7wWJZ0Pp0HRaQCk8Rg5fY2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy50ZNfycwDDAg2vID3Z/9KKAbrakzKGYHVTuqY2PkbI/QPsoAy
	/Ibboix3zv9N+n4LH9KQdFw7MOCiA5k1S3gf1P53YSfc73uwKE1IUXQmdScmqC3XQXo90CiIsLs
	Sryy9GVxe05bWHHqP1Mh6L/zdXEj4TbFdEvrPH/WXGD0FUtDIDRSb72RkKUKMj+DE
X-Received: by 2002:a05:600c:3d1b:b0:431:40ca:ce6e with SMTP id 5b1f17b1804b1-431841a2f84mr19194665e9.31.1729684686284;
        Wed, 23 Oct 2024 04:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/YzzmLyxM0Rp1YakBuvBzJFtayHkt8cdDRcWUoxqHWb/cqw09w3v3wO7O/ehFLlL5CPp6uA==
X-Received: by 2002:a05:600c:3d1b:b0:431:40ca:ce6e with SMTP id 5b1f17b1804b1-431841a2f84mr19194435e9.31.1729684685911;
        Wed, 23 Oct 2024 04:58:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186be531esm14211535e9.18.2024.10.23.04.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 04:58:05 -0700 (PDT)
Message-ID: <fb17dd76-b2ac-465c-b6ff-6633ac5f732a@redhat.com>
Date: Wed, 23 Oct 2024 13:58:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net: pcs: xpcs: yet more cleanups
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 netdev@vger.kernel.org
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
 <ZxjbPkQEOr0FBTc6@shell.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZxjbPkQEOr0FBTc6@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/24 13:17, Russell King (Oracle) wrote:
> On Thu, Oct 17, 2024 at 12:52:17PM +0100, Russell King (Oracle) wrote:
>> I've found yet more potential for cleanups in the XPCS driver.
>>
>> The first patch switches to using generic register definitions.
>>
>> Next, there's an overly complex bit of code in xpcs_link_up_1000basex()
>> which can be simplified down to a simple if() statement.
>>
>> Then, rearrange xpcs_link_up_1000basex() to separate out the warnings
>> from the functional bit.
>>
>> Next, realising that the functional bit is just the helper function we
>> already have and are using in the SGMII version of this function,
>> switch over to that.
>>
>> We can now see that xpcs_link_up_1000basex() and xpcs_link_up_sgmii()
>> are basically functionally identical except for the warnings, so merge
>> the two functions.
>>
>> Next, xpcs_config_usxgmii() seems misnamed, so rename it to follow the
>> established pattern.
>>
>> Lastly, "return foo();" where foo is a void function and the function
>> being returned from is also void is a weird programming pattern.
>> Replace this with something more conventional.
>>
>> With these changes, we see yet another reduction in the amount of
>> code in this driver.
>>
>>  drivers/net/pcs/pcs-xpcs.c | 134 ++++++++++++++++++++++-----------------------
>>  drivers/net/pcs/pcs-xpcs.h |  12 ----
>>  2 files changed, 65 insertions(+), 81 deletions(-)
> 
> It's been almost a week, and this series has not been applied.

Yep, we are lagging a little behind our PW queue due to limited capacity.

> First,
> Jakub's NIPA bot failed to spot the cover message that patchwork picked
> up - not my problem.
> 
> Now, I find that patchwork says "changes requested". What changes? No
> one has replied asking for any changes to this series. Serge did
> reply saying he would test it, and he has now done so, and replied
> with his tested-by.

I agree there is no reason for the 'changes requested' status, I guess
such change happened due to some miscommunication between me and Andrew.
Let me resurrect the series in PW.

I'll go over that soon.

Thanks,

Paolo


