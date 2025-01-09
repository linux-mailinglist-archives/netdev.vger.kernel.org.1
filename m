Return-Path: <netdev+bounces-156664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44186A074BD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBF73A1A9C
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B189C215764;
	Thu,  9 Jan 2025 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2UXU7nF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CCD204C06
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422238; cv=none; b=LhjkW+zNRAma3Gi4lXbsPVN/0N/NK3xd8TO8uAne+fmcE8N7KGhSjUNqhGweHZak+jtExV8AbJQhONemeZvyPZ0DZr1QFLUQnpYtMRcopWJFztdSlnPhD4GMgWGWDZ1iRUlPouECDgWgZWwAmKbzcMnP7OLPf8fP+wdY+AWisG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422238; c=relaxed/simple;
	bh=MWJIfG3EFW5zN1jm7iUuCCwJjr+SHshyV9DZVso8yCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAryaW02SoT/tnQ1ZIm8lFYM2oFPhFWIA3O/+06L7zgEprOKC0tgxlp35IKGmOq11fSKQslKtMHcVuTKQB5WLpmOhKb0McU6BLgOc7PpbAJA7Ut+G14mpx2PVjbUHbEGg6kCAYFG3pqLaiAS2s/SQACQ8f+rYuelWiB/Lovz67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2UXU7nF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736422236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+C+yeB9onaJB9oxQIHx1Fw47BxibqCdt7kN2YotgjY=;
	b=K2UXU7nFP5jIjrBnMfgsKUvTS37f1pWXV+q7t6AL9f80xjfTEaLW5FbmwRL6NtXzHZXu/0
	6tecFyE9S2yxCq1R+d8yV368JHTkuRSL/7MP8cAPpF4kJG6vNrQZqKi+mN6dFaYquTFDoQ
	3FNyyqoBw7h4LNyyn92HyjPRHuHBEwI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-rOyh2BLQNj-B25yyIS8r9Q-1; Thu, 09 Jan 2025 06:30:34 -0500
X-MC-Unique: rOyh2BLQNj-B25yyIS8r9Q-1
X-Mimecast-MFC-AGG-ID: rOyh2BLQNj-B25yyIS8r9Q
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7bcdb02f43cso91220285a.3
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 03:30:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736422234; x=1737027034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+C+yeB9onaJB9oxQIHx1Fw47BxibqCdt7kN2YotgjY=;
        b=cAo2uShUx/nuDQ5JbV9vBtYFyB0IFhchB3JYnhiOdqbbpzv+Hku3QUub+FCaznJfPd
         +miQIQNDZJEoYRfvS24iUi8krgtn0qCdarecNBsIqiN/kKTzn7nnMDcXmVrfdQFdtYET
         lj7uRwr0CHyLvep88C4jgryP0zVUCVRfljkOXDOmcWrxAsd6AWi8UvJtpkiedlT8BnaI
         G3CwO1csHW/PdQJA1Q1poEFCET+YznOzDKaLznygA1SVgEpNsBlaAP1w19u1YOpg7eTp
         pd9urnxnECkVKHVgB9ulXGjKD7QqnwkYuisASrM5UE5IVEfd+wv/q/7IusiZchHkKs5R
         wFBg==
X-Forwarded-Encrypted: i=1; AJvYcCVrMxNaYyozJ+Qph1GGEbRUa2Y2H5RxSkjvLKvbk5ixvvH53Ynri1Zj7D/5o0/bYj//oP8X570=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPpwUXOqGyLsD8nWs3WH5ca8Jv5hvZ6iicoETO5Cenqj9kIFJ
	iHHJPbF+rZNnat/p4Qhibhb0RDPO4PHbwMQyM2WqyxEQJrKFcpo0wCfEklCN+qxmYnZfkWWUyXR
	a1lmXfT6KjEU9nZgCtnShfh2Z843cqYn58BfpIrkF7m8ckZdgrXVuKg==
X-Gm-Gg: ASbGnctqNqoWl+uHmQrOCIUK2/qu3yED4T5pPciZFiYNb21q6nhYyRW07SbZ5WeL94i
	uU/iCK5WxU5MSmW0pWphv8hNSUrxKwJP8dOQ0WU99kYKpvWbu44yzTE2hg+W+AhuKIWC5O9FN/R
	1llm9xvTchBR3ZbjMYE58bivyCt8EMFNmq+Mk3UjAAWUT3KjBgfZC5Egz6GFV1RDvVx6SLCft3R
	fY564Pt8oHmANl4YebHAUJSnPK3QByWN3LR2gJ7UhAPstLDSXQud3hPoNfHbCLIKKViOxz85lmh
	VOqoq5XX
X-Received: by 2002:a05:620a:1913:b0:7b6:d710:228c with SMTP id af79cd13be357-7bcd9717d97mr941365585a.31.1736422233792;
        Thu, 09 Jan 2025 03:30:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoVONBcpj9Hf9GDpebssTYWXL6/TajT6pi/ndfNpOhIYVD3t+wpbYxbK1qQlzjmCwLMT/ebg==
X-Received: by 2002:a05:620a:1913:b0:7b6:d710:228c with SMTP id af79cd13be357-7bcd9717d97mr941361485a.31.1736422233433;
        Thu, 09 Jan 2025 03:30:33 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce328128fsm57807685a.61.2025.01.09.03.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 03:30:33 -0800 (PST)
Message-ID: <361414dc-3d7b-4616-a15b-3e0cb3219846@redhat.com>
Date: Thu, 9 Jan 2025 12:30:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v4] netlink: support dumping IPv4 multicast
 addresses
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20250109072245.2928832-1-yuyanghuang@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250109072245.2928832-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 8:22 AM, Yuyang Huang wrote:
> @@ -1889,15 +1935,16 @@ static u32 inet_base_seq(const struct net *net)
>  	return res;
>  }
>  
> -static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
> +static int inet_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
> +			  enum addr_type_t type)
>  {
>  	const struct nlmsghdr *nlh = cb->nlh;
>  	struct inet_fill_args fillargs = {
>  		.portid = NETLINK_CB(cb->skb).portid,
>  		.seq = nlh->nlmsg_seq,
> -		.event = RTM_NEWADDR,
>  		.flags = NLM_F_MULTI,
>  		.netnsid = -1,
> +		.type = type,

This patch is apparently breaking a few tests:

https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-01-09--09-00&executor=vmksft-net-dbg&pw-n=0&pass=0
https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-01-09--09-00&executor=vmksft-nf-dbg&pw-n=0&pass=0
https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-01-09--09-00&executor=vmksft-nf&pw-n=0&pass=0

I suspect the above chunk confuses the user-space as inet_fill_ifaddr()
still get the 'event' value from fillargs->event

Also, this will need a paired self-test - even something very simple
just exercising the new code.

Thanks,

Paolo


