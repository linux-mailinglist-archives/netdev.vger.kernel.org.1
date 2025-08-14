Return-Path: <netdev+bounces-213809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB74B26CEA
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBE63AEFF9
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E08A1991BF;
	Thu, 14 Aug 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyV/x5oH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700011F12E9
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190063; cv=none; b=DOp0DrWpG4Z9vsyuHk8Za5b0yFEvMVpARzF1LH7j3AmsS6iBmn/Ie98xd7Pqsh3KUqvNezgqg//YhrVvIZAV0mvU3m/WTZuyDvuEA+CqLl+bFJAWPbmMMSwJveuNRwdgb5cwDuMm1ZdxKyMGtj9GeghVXwJvS5333KFb149718o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190063; c=relaxed/simple;
	bh=EsdEwijNTbSS9N1O6E3mNzgnqewi41SW819Ty4rnlsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRT9kB+Hg56RleidnMYQXwCfAx2RHhSka6VcLJazAZYG1u5O+O7Jw6LxG+hHxgJy5cj0uBSD/tc+T4EU5FryWschC01wM7hWJeN/oXTijPaj+/djJ9BMoZLueIoO7ftWALHkOSK1eRBBSp6mTOC5x+tKHN0OF6oXcSj/lmn2rZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyV/x5oH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755190060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGFzoPE7I7vzQLKoa4u+1Ej8MCxkkoFclzk+eyJt6CU=;
	b=fyV/x5oHiZDTrcVVG3Q5wR9jTjSu1PEPOZ3oI9BvnpP3QGaz1VQNpkcxOy8bKRJ4KZKas0
	IVQpMlJ5TJxnsqgyLelmATRJZaYpUwYE3bKHS/sM5BUwiuOEpngqWIZ9CzvWXjgeBZraGa
	8ztJTJtLHtH1ASB95M3R1u4wo4b9Eqk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-5DBzoK2OOb2mLpXzFDMbfQ-1; Thu, 14 Aug 2025 12:47:39 -0400
X-MC-Unique: 5DBzoK2OOb2mLpXzFDMbfQ-1
X-Mimecast-MFC-AGG-ID: 5DBzoK2OOb2mLpXzFDMbfQ_1755190058
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e87068c271so258224785a.3
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 09:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755190058; x=1755794858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGFzoPE7I7vzQLKoa4u+1Ej8MCxkkoFclzk+eyJt6CU=;
        b=ISv7FD3cT62wezkLtggbfQy46BwmpU/YAMCYYxdISel4rsNUmyiezruyvDnWZLm0MA
         kZtz1AQZgnZOiuSil9nOQkmZdNbokSnQEmA4nutX/ilqQ7p+eEETdcHm3VPloNOThRVu
         9AEFn7QsFOvbt5U0zf7u0+G+XGa/PUcrUNyG96etyeFZmFMBngRQUN0/xVB4XoXVif+T
         KfIdJfR7PSkmkrbwwEhnjuI0VbJBD4eVfw2xBiRpMEpGGwm8eBV7/nszZsIB+27gwDc9
         XjH2VRK8WYiZZ3Ft/CJNvNoEIKeBqj6lGTG9/BsYs3KteHhoxgaMfrSNPLlw1MoBWETe
         COyg==
X-Forwarded-Encrypted: i=1; AJvYcCWYP1FgsNasKQVFdXie+G068fkF2yhoRXvp/CywQtGbMOyPQN2F3ZPCta1Oy8gXhKTRTCFvakc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQkV+1E/PLosaaplP+3vjulp9L1nZ02wQCesOroe/r9uu810o
	s0MRDvngnMVz4gWWiF7oz77x50qBgYTyehIqkSCjBsqKjSheD8mAQNpXQdw7ZCxqSLCgtrnoMRg
	KaXaVYS7IPd83ns6DttqkqskVPyoGXImZH16uSVr3z7yZi9xqZNqmRolINQ==
X-Gm-Gg: ASbGnctKVDRmXCMQXSY5jHzJWBp/BxQgGOiJYTGZoO6H1wtwUTvgcAfv3mmdSSaGjce
	7ETZTOQhzZW74fQlDa9eSIsT9sV1WFEjbpcGZfFXntOJXbNiB8zPkP2xdlMVCXzfoVvBEO4WZz8
	n6bZ1ZOvauvk7WJcBhmmOnE55cY9PZ+ZQTEkDXZKEcK6RwNUoKtNPntNLQBvjPh9rPAE4rnufbD
	UcpZcVR0tbpaCDt3RPZ2V+4/AKuauWHdPvefkShWfn6A1Pu+CVKwPjG4nj1p4VAHF2CXwLSkSK9
	R9DMgncTvc02F1K4GtPHvPuRaC8Wo1MuP6vflCuJlGaKG4mJt0RQQ5e3Z/C5+jRfdxHrbSGZKEX
	tvQbUd11kwFM=
X-Received: by 2002:ae9:c002:0:b0:7e8:199a:bae4 with SMTP id af79cd13be357-7e870491925mr360466285a.52.1755190058428;
        Thu, 14 Aug 2025 09:47:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUsprLxb5/Jq3VXba/sR1kti55UVWCEuylm7tA+juX4dvkeO8AXX2+NWmOpHAPw+XEnr0s4g==
X-Received: by 2002:ae9:c002:0:b0:7e8:199a:bae4 with SMTP id af79cd13be357-7e870491925mr360462585a.52.1755190057910;
        Thu, 14 Aug 2025 09:47:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f597fd2sm2146479085a.14.2025.08.14.09.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 09:47:37 -0700 (PDT)
Message-ID: <504a5c1c-83eb-4940-bd2b-66f8c3f26c03@redhat.com>
Date: Thu, 14 Aug 2025 18:47:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 10/19] psp: track generations of device key
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-11-daniel.zahka@gmail.com>
 <324f1785-80a8-4178-937a-c3d6a47e6d79@redhat.com>
 <32b6cce4-6751-486a-b853-5604a48572e3@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <32b6cce4-6751-486a-b853-5604a48572e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 5:53 PM, Daniel Zahka wrote:
> On 8/14/25 10:07 AM, Paolo Abeni wrote:
>> On 8/12/25 2:29 AM, Daniel Zahka wrote:
>>> +void psp_assocs_key_rotated(struct psp_dev *psd)
>>> +{
>>> +	struct psp_assoc *pas, *next;
>>> +
>>> +	/* Mark the stale associations as invalid, they will no longer
>>> +	 * be able to Rx any traffic.
>>> +	 */
>>> +	list_for_each_entry_safe(pas, next, &psd->prev_assocs, assocs_list)
>>> +		pas->generation |= ~PSP_GEN_VALID_MASK;
>>> +	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
>>> +	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
>> AFAICS the prev_assocs size is unbounded, and keep increasing at each
>> key rotation, am I correct?
> 
> psp_assoc objects are added to the active list during psp_assoc_create() 
> in the rx-assoc netlink op, and then removed from whichever of the three 
> lists it happens to be on during psp_assoc_free(), which is called when 
> its refcount goes to 0. So basically, a key rotation will shift the 
> psp_assoc's associated with the device around in terms of bookkeeping, 
> but the total length of these three lists combined is determined only by 
> the number of sockets in the system that have entered the rx-assoc 
> state, and have yet to be closed. For now, there can only ever be one 
> assoc per socket.

I see, looks good.

/P


