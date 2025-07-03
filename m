Return-Path: <netdev+bounces-203829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E83BAF7619
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E71F4A0463
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FF12E6D2A;
	Thu,  3 Jul 2025 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqJ4aGtr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C412E339E
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550498; cv=none; b=V9iKRWO2eF8hEE7jk2zTmMKzz6EccpLFIBiz8KGYvfnab0NdNha5tAHKYNaB+bG87d3QxrWzP5W5eqiPunnR7d8G1sFImqeBBXmIsnS/cLMJTTVqwRu2Mwn/5xPkoFhqZMEnBbGha382X5XFaSp7ORwbCXFej/IAX90maV2zu8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550498; c=relaxed/simple;
	bh=EfnLWETl1J5M1bL6Y29tMN98S/aXdjr4ysoydW1po4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8ZhcDQb/rTEig1vJSpCdCxVMf05MindYSqT3YHhN+P2lLE5S/ywNJsfr+OThhopvNVD3D6viz340bXpJWr/rWL7VIbhga6CM8xsMDc/wkRtQEPDBSUHqosI1WYt6VZEOPnrfOVp6pQo/z3FzhMGfnRwDiGoFmIDQKm3RfIAjfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqJ4aGtr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751550495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJrMtFaBP2BGL6npOuum/zHAyGQyeC3LXV3nbl5mRq8=;
	b=OqJ4aGtrJpU+r3avD6ExMNRT1cMO0/T+YtkeXn8j1T+O8/0H4txcrOmrpWc7c9t7lPGuBF
	I6iVfbngRYwH4BRFQWMv9sNAd3C3SEditp0DBIT0JXe0MCnnw4io/zMlwCZ0X3Z64gtBHE
	NCa/PhnfA9GuDsLXuB185IvpWFU9KZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-EZco4YH-ME24K41430f5Dg-1; Thu, 03 Jul 2025 09:48:14 -0400
X-MC-Unique: EZco4YH-ME24K41430f5Dg-1
X-Mimecast-MFC-AGG-ID: EZco4YH-ME24K41430f5Dg_1751550493
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a6df0c67a6so3708193f8f.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 06:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751550493; x=1752155293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJrMtFaBP2BGL6npOuum/zHAyGQyeC3LXV3nbl5mRq8=;
        b=XnNnmFGRiQ2sIRxDcWZuL5YfiWp/jMslW9uyRRmTKU3gzZI1fMvAAd78ywr4YZIveD
         t2DXq6Xh3bSsCUGgwK9grMMboKrfyZZf3OaXgBsZOr/yd6k0tlqAeiqV5XrmxFoWArPB
         pgliqWXTA7wcIA3cliTwGX0F0VacUe/tjFM6uyTnxTHgN7+OMby/uzSyFCJBzjs3Cdg0
         vlKpwPZgwMveP9ZG3aW2cgWYXkOBZ28X2/WneORILDepaAbqVyCbkvP5Yu8S66bHwh8a
         2EGypgdx0xsgfi2iqUnjupgvRBinR4qdMTV+niAJOFInbXQrqDFCqLZMwqbszBpl20UD
         s0NQ==
X-Gm-Message-State: AOJu0YyxCXkyEiZQ68acB7WPABRKpTv61B8lxmzlVCLPXZN0m8amUWGg
	nPRucLegczYyaH385Dw6QBrmjDti5+FHNKEWK5zB9qduyqydURkAZ62rRgeC4tusW2r4fLp1uJ7
	DXPJxHJDPJVMUZuP/O4ggVp9IyraHiQ+AGEXSaXWrG0TStWINtxZs4ZQzMw==
X-Gm-Gg: ASbGncsLjTLBYYbhmsEBFlhWD6dctmtC9sP0n4EKNUo1d4qhKSe8vVFzKPlu8y9kJSO
	0Pj/1fB8+ZGmvo90fLjWS77vUU8T3nq+V75y678aGmWjrKx+DlhKqyFhoXQLpHuqVynabMtqIMt
	CJu+gVamLd+cMCOn9kQGBXmuXR+1VHW0P8Qa5tZq4reAenOcNmwOvwbz2ykz9i4Z4NBeEyug/rH
	I9EGLSL+90UlUMlSejvx1DdeB0zRXjYYKepQmjFMx5VnC1kjnPbOj5WrFr9qFO77UohN+A2hLtY
	rIdEKdWumjBvRKZAdT2sZ9SRk4a220Qyy1ubaktgHK7rXXLLCvidLvDkVXpyY972bsY=
X-Received: by 2002:a05:6000:290d:b0:3a5:2848:2445 with SMTP id ffacd0b85a97d-3b1fe6b5ae9mr6007915f8f.16.1751550493338;
        Thu, 03 Jul 2025 06:48:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd2kcIWtwK91F48hm7gSXrDxg3r7yvE33vIqHRfIQfbCwGMDKd3QlGq6N3EMfPF5sDl04JmA==
X-Received: by 2002:a05:6000:290d:b0:3a5:2848:2445 with SMTP id ffacd0b85a97d-3b1fe6b5ae9mr6007887f8f.16.1751550492828;
        Thu, 03 Jul 2025 06:48:12 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7098sm18357751f8f.4.2025.07.03.06.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 06:48:12 -0700 (PDT)
Message-ID: <4cab9be0-3516-454f-883b-7a999994c447@redhat.com>
Date: Thu, 3 Jul 2025 15:48:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 0/3] ptp: Provide support for auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 John Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 Antoine Tenart <atenart@kernel.org>
References: <20250701130923.579834908@linutronix.de>
 <faca1b8e-bd39-4501-a380-24246a8234d6@redhat.com> <87ecuxwic0.ffs@tglx>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <87ecuxwic0.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 2:48 PM, Thomas Gleixner wrote:
> On Thu, Jul 03 2025 at 12:27, Paolo Abeni wrote:
>> On 7/1/25 3:26 PM, Thomas Gleixner wrote:
>>> Merge logistics if agreed on:
>>>
>>>     1) Patch #1 is applied to the tip tree on top of plain v6.16-rc1 and
>>>        tagged
>>>
>>>     2) That tag is merged into tip:timers/ptp and the temporary CLOCK_AUX
>>>        define is removed in a subsequent commit
>>>
>>>     3) Network folks merge the tag and apply patches #2 + #3
>>>
>>> So the only fallout from this are the extra merges in both trees and the
>>> cleanup commit in the tip tree. But that way there are no dependencies and
>>> no duplicate commits with different SHAs.
>>>
>>> Thoughts?
>>
>> I'm sorry for the latency here; the plan works for me! I'll wait for the
>> tag reference.
> 
> No problem. Rome wasn't built in a day either :)
> 
>> Could you please drop a notice here when such tag will be available?
> 
> Here you go:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ktime-get-clock-ts64-for-ptp
> 
> I merged it locally into net-next, applied the PTP patches on top and
> verified that the combination with the tip timers/ptp branch, which has
> the tag integrated and the workaround removed, creates the expected
> working result.

I had to wrestle a bit with the script I use - since the whole thing was
a little different from my usual workflow - but it's in now, hoping I
did not mess badly with something.

/P


