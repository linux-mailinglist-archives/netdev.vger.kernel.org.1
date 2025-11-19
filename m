Return-Path: <netdev+bounces-239925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C82ACC6E052
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 87508242D0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E786134B1A0;
	Wed, 19 Nov 2025 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFbsE+sL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFgXU8vS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580212E5B27
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548814; cv=none; b=pK0Q+EAC8Q2ZkB6M7BzMLHWADJUbRJ8BWZGW30A7JgQJCTR7594xidTuX3t/fZod8/tG9sHyXu94e2szJkqdST4nGHT0lwgvGDvoxElJ7ixsMOe7rCOJzlyd+v3UR97jn5rB0fN6jPyYj5yeV3ni7kB7oVmbMqhD8m09bpo4dVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548814; c=relaxed/simple;
	bh=DZIAcCTww0s4iWal9ociel47JWmGW4w6rucjX7XMwbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MZrvV2De34uw59HkR6RDb9hJ0OwldneeCwX5TZjw4GWx9RG4YBckl+8Dd52I32FGJz+iAtnD554XfarPJ4xfLRxrKNbxdM7EoBnn8t6e7SBiL9IPLAS2HyCh2ypts44Cj2OCBYGW+AVPY7/qE4WU3erkAlNzcitwmMneGUXh+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFbsE+sL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFgXU8vS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763548812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0l9o/pX7rZdgzEzxtL69j/qja5gm9z4d5aM9fQ+O5cc=;
	b=eFbsE+sLoXWcfxX4eNox37FiBPERG7Xmzv6HczRwn4I7hja+t6Vt2OHxt5pWLdw/nwOwcd
	+1E2hWPYtZZRuvXMmGwz8WN6a85h6x8LXdPsXJF6FjmpNHUU6UwqbogWxDbK2/TXhNPLFN
	Jlz6lu1PCTBRlmkq2MAyanp+lXRJ6gk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-DKVG2kTYOneZQtu7MCDoZg-1; Wed, 19 Nov 2025 05:40:11 -0500
X-MC-Unique: DKVG2kTYOneZQtu7MCDoZg-1
X-Mimecast-MFC-AGG-ID: DKVG2kTYOneZQtu7MCDoZg_1763548810
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47775585257so50497395e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763548810; x=1764153610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0l9o/pX7rZdgzEzxtL69j/qja5gm9z4d5aM9fQ+O5cc=;
        b=bFgXU8vSey88dMC69sRh1ok7AdXRmRjMQ0kyKm8Ea+yeScTGNAm3ybq/7CkMLJqtYJ
         AL7qfkGv2IxH+Mpsd4LRpXTKOUoj2QMjHzFmXuKAuX1kjf4FOjOhnLVTEB9FKl43v1VU
         mCnZCZeqAdfbPgmJpMNrMHLwee/TI7SXAiXiu1E1mRiqK2iUGar+2NF1J9AWP4jUpjgb
         TxbCB9qPOthL01TnQVJta+H7yDHLjgARA2WU3zFWxmWzzLUeu+7w18L+dqGbm1xw9n9F
         dPaKhB7CgFBhQz5XxBlnq3koqDr0r08OS4q+JiUY9bqRYYhOS5a7V2IJTdC0MOwVN3ho
         xvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763548810; x=1764153610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0l9o/pX7rZdgzEzxtL69j/qja5gm9z4d5aM9fQ+O5cc=;
        b=O+Y5K0EUjYYbMWO7G+CoU7ek9wkYSGmMgpsN5SSksKRP9iG4P+mTrrW/Pky4LwPaaj
         lQmESlKedKolBVtIXhPGOAhioyVl6GRM0JCj0ESJG+/0GvobdtuWdn75igpf8b9/Obq4
         +ejwilivbbY0EQbMqw8kDiAGGOefOcVaNbNEJ2DhSrJSMd33N/yJjaq9iN0eVVXnOz0L
         esDyxsF73huIA+/LjPxMrOOa4wFsttduLHWwsrBPfqXvm5Z8knKZ82zay3TlRx7BB/rr
         uUwljfVUw1nJww0uhJxDJoy5VUj0PTpT3Hl+FQcqsChOJtu/HfGyGQGmxSv+IqO61Vy0
         yRTg==
X-Forwarded-Encrypted: i=1; AJvYcCUkw0gNMH4qI0cg6Dag1x1tglxz47Nc13pUZt04COTz4JD0uU0erX7wDxBakm5CbHyN4z+pZgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/GrPZlFVBnOysP6/QQTGMary2Xc7JxfqHGXMaBXyFCeoUx7U
	8/CixERXHrL0A/3wJYETZNoafGnLnM4bFRVqiYqysGdg10SZnbWiNVe6kqyeB0xom0ixSo71nXu
	SZdoFHe6S9K67vcueTOZpRsIOVBnppzRHGnAMqLg4uELW5IJFAk603i9Omw==
X-Gm-Gg: ASbGnctnaxRUHxs0yZ/u/M1FCSUJK7r0UYgmnJqF6P8DZ3MyolIFt/MRqXkJlz998Zf
	jPqqBt8A1Ce/7JS1xgktbL+gpmoy2W0cjuYCrXAjvVuIiIh1tiuP0zHuvsc3rhLT38BCsoCBpSY
	S/2rUDAn48ojja/0RwZtWZzGw/Zgyv2gqvVhD+yMA7QjDI3ZhRcPpsoANwSQH8llTEF3P1daKHs
	WlvyCP8T3kWQ/lnEcFTfIOc43R7RxitV0Dx9OQy5YMMraDyCdWm/6UUaVPl4o4vZpEoAhoSEaQl
	SOBJ4REGkFRXywTlX7eq3PYdEKyZSdcCMK89LZzOKeCXbaTcR3mcuwJQpDwAGdCfUpc0f3YrGaV
	LQVNX1YtDDku/
X-Received: by 2002:a05:600c:4585:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-4778fe59a0bmr191362585e9.2.1763548809749;
        Wed, 19 Nov 2025 02:40:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQBsoVLIQABpPzBRMJso90plcaov7SPkZ+FeWQLc/AfXpX8X110BATx3cN1ed3w5TAESS3iw==
X-Received: by 2002:a05:600c:4585:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-4778fe59a0bmr191361945e9.2.1763548809270;
        Wed, 19 Nov 2025 02:40:09 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1035c78sm40679485e9.11.2025.11.19.02.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 02:40:08 -0800 (PST)
Message-ID: <6d4aad6e-ebe0-4c52-a8a4-9ed38ca50774@redhat.com>
Date: Wed, 19 Nov 2025 11:40:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "parav@nvidia.com" <parav@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 cheshire <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
 "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
 Vidhi Goel <vidhi_goel@apple.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
 <d87782d4-567d-4753-8435-fd52cd5b88da@redhat.com>
 <PAXPR07MB79842DF3D2028BB3366F0AF6A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB79842DF3D2028BB3366F0AF6A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 11:24 AM, Chia-Yu Chang (Nokia) wrote:
> I was thinking to totally remove ECN from Rx path, 

??? do you mean you intend to remove the existing virtio_net ECN
support? I guess/hope I misread the above.

Note that removing features from virtio_net is an extreme pain at best,
and more probably simply impossible - see the UFO removal history.

Please clarify, thanks!

Paolo


