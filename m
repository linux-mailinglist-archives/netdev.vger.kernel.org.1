Return-Path: <netdev+bounces-111749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 024A1932724
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855FCB219DA
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A619AD90;
	Tue, 16 Jul 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyFCx8Hq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199519AD60
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135430; cv=none; b=sFkOeSibngRrM1jbtf+HmjrhIvTBiUSThQvWg2tzD7gTIq4iTxHhPTTCbiCxpcIxI1bxtC4WCC9wEFRiMrLvc6EN7fx6r+EkOldAguHOb/icRR3QFz1LPSjyX9tXmWZOKCNDkCxHPwi7rHn9AzwYCekrKP5YnuFUOAopg2rgkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135430; c=relaxed/simple;
	bh=k+1RV5GCOT+tXPua6FJHUXMrykjI0VBKOpOtbCgIoYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwALK7BlQBfxx3LNpvwFE8B3aATb21Z3eKEVZvC9o/0vdH2HNF+LMhm36a3uTBgmQ58gUoC4oJqZVRDtZq6/0WnwSQicFjf7Y0Dqc7NV7XMCIlE9ilJIvFaysxagxXaC9q8jtqBCbNixdRfEswYtoFYz2tqwyziCDN6PvO8HBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyFCx8Hq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721135428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1gOfjCAx0JVhYPMj4vGIbpwiWQL5RJ8uO9QhWtc93A=;
	b=YyFCx8Hqmti+EVjkVJ3tu5O1kShFs3y/RehqlK7x5sY+YU1Icq9C/Og4yxrurhMIy2bb7A
	TFQn/pSxUpf5J+zjNrOrQfn/HxBAcS5GCu8iZx1dM6ThgKjeE9HbuD1TtCP1oVLgIxsMyS
	WY7E98aQ2x8v69qtGt2UgMBwt8Uptuw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-0pGGZOTlMmOFAFkH2saLwg-1; Tue, 16 Jul 2024 09:10:26 -0400
X-MC-Unique: 0pGGZOTlMmOFAFkH2saLwg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4266a5c50fcso10271195e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 06:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721135425; x=1721740225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1gOfjCAx0JVhYPMj4vGIbpwiWQL5RJ8uO9QhWtc93A=;
        b=i0QiqIpF88fUxyywvMsOcv3mAEMInv5PUJocmD1gQZshgtHll+p6zysJypdRlwDnn8
         hiUGzJagJxoBlcvVXHgdfLiecvjkcX09EOJ9vZtSUVUMRY65SXmfOPkgATtpDqJDLm4g
         0n8Vn5dWTduXxXwAxqgzOcbhoiB9fa/oed2zia19TgHlWHCadShVQ7YagwUsFVT5HcFc
         reul3rUay6Z0bsDg1uEyQCyzvtXCPA6eamncV5T0pY0EIq0TEvuTcqdkiPWF9m7DE0HB
         R+ellh/pYH39TXn7e5IwNhZ7WBU/DDyCOYJXgiOsEiLZ8735X8pOn/cl66ODTZSRguPa
         VSNw==
X-Forwarded-Encrypted: i=1; AJvYcCWABJclP8QRLnrpfEFhIlTp8pKKGCMrHr8BAO50Le+te/jnXDFqY92jqVEYaws/rRyDj5NZ3FLwDkDWxYCk/qATQfRACHhh
X-Gm-Message-State: AOJu0YxaOB/4aPbgOXRM2Ac+UQfO5ZAjzoFbdYwo4yo8wiLBLEg6cEhl
	FIDOd/9FgH9ZHFNSRvbFEwX8IqbZF2fPCtWyG6VEGOglp8Q+TQ7xBCgee+VpTr7KhKJZKm1OmiI
	8EjqM16+APDhMfXVxTKi7rm/grwdgxAkeEf7ZX+X7yLU80wcOQxgy3g==
X-Received: by 2002:a05:600c:3b93:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-427b8a559f1mr12081365e9.6.1721135425394;
        Tue, 16 Jul 2024 06:10:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+ZbyRm/fg6TpbsA1hJlGXyGgkBQ+2szmJWprS7Kts5UhI3RP5xWMTxQEtgatsEgKvIffHsw==
X-Received: by 2002:a05:600c:3b93:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-427b8a559f1mr12081225e9.6.1721135425043;
        Tue, 16 Jul 2024 06:10:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210::f71? ([2a0d:3344:1738:5210::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef44b4sm127311255e9.42.2024.07.16.06.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 06:10:24 -0700 (PDT)
Message-ID: <c87f411c-ad0e-4c14-b437-8191db438531@redhat.com>
Date: Tue, 16 Jul 2024 15:10:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
To: Tung Nguyen <tung.q.nguyen@endava.com>,
 Shigeru Yoshida <syoshida@redhat.com>
Cc: "jmaloy@redhat.com" <jmaloy@redhat.com>,
 "ying.xue@windriver.com" <ying.xue@windriver.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240716020905.291388-1-syoshida@redhat.com>
 <AS5PR06MB8752BF82AFB1C174C074547DDBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <20240716.164535.1952205982608398288.syoshida@redhat.com>
 <596fd758-11ad-46c0-b6f1-2c04aeba5e06@redhat.com>
 <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 13:43, Tung Nguyen wrote:
> 
>> I think that consistency with other tipc helpers here would be more
>> appropriate: IMHO no need to send a v2.
>>
> I do not think so. If you look at other helper functions for udp media, they use predefined error codes, for example:
> tipc_udp_msg2addr()
> {
>   ...
> return -EINVAL;
>   ...
> }

It's not a big deal really, but, as noted by Shigeru, all the other 
tipc_*_addr2str() callbacks return 1 on error and such callback is 
invoked via function pointer.

If only this one returns a negative error, modification to the function 
pointer callsite will become prone to errors (and stable backports more 
fragiles)

Cheers,

Paolo


