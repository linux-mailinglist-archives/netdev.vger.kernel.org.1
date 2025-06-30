Return-Path: <netdev+bounces-202655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DE1AEE84E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 22:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14DC189C0E4
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBFF221710;
	Mon, 30 Jun 2025 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ow1vygOL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358B20FA9C
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315431; cv=none; b=ULhqaitVhBSeCaIow6wHrPwVOxdvrRTrnylSu5lxOAiknDioCUkEIb5A36+1ueWccvDB5GH20HZcyapuvFmqFFCyzp20aBH3WVD2Zf8nFIZmdYF0ih18aXb8DOrpBpElIDEtXZUKW+HQQtfO+W9mUXCWpql5l8y77QjgMECIq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315431; c=relaxed/simple;
	bh=h+Mc6pJAi9ivbHwTbXp7FIv58m+7zjdedWczhF69Ah4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tARqXV+fUs1uqTjpdu8fe2jQygV7N0/yjCYGX0rR4vwRB71pQtmXuUshEvnpegECcjtV0SNXKRwH7vtJcVll9shGkvdziIgteqF2UtyCrx9V/pJxTwz0Kse6YFmLgNYWxFHcS14PtXC/9R1FsLCApZEnWvOpndqDb21LvFbC3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ow1vygOL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso4460733a12.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751315428; x=1751920228; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=elCM+oF9Z0IdOGQ7xKJIbBaSxMaf81dbIGi1GWq89Uw=;
        b=Ow1vygOLBWZu4XhRdv+2B1RJLa3gb8w2dvpRzcQSTzLIhtqNV2g+RPIUfT4x1pA6zd
         g8rmkJD6TLFdUSI9ynzh+LsThZN2pz4cKBDFgM9ymQ6qbuVAPfBZzgskjGvKe3attyZ+
         myGvYmGoi8U6oaacqDtwrHvpUhb+37Mk2rVaqPkMjAzy1JsT3ktnboGgtkloi3syJUgV
         IaLXLQhVvnGrHi6nTExNz8+GewLl6dzypeCOjYA8ZQfMwGHNvRnIwFMSdV1LToYbMnOe
         t8LJ6gNyWBykbJFSh+XgBz8wAgmx5U+rPJV7it2OtahrSwjKZCT6sKlXRu1D+v4fnw1p
         q3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751315428; x=1751920228;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elCM+oF9Z0IdOGQ7xKJIbBaSxMaf81dbIGi1GWq89Uw=;
        b=W0ScLNtN+vxZ4Nos9J47JPijlR3VmzHjrOmOJzQf6WxpdUgtoOGRCOZ/XJyt9ALJGo
         oOKRyL/UDarbfljgBzAFFAzYGfynBIet1RQQcATuSLjGbC82u0k5wQcsL/aw+hQPdkIH
         gDSfQwb8yBD9e3HTDm8Eauh/rwzxwhnO2XKxOJ9Owl75YudcT1KkvpI3VwrcWy6ffxKw
         1LbKpBOb4XRcS7YjePLpmIqpySGFhOktYXIFW1Y8EtTnZeHEHXrR/aCqHPd3DcWJ8oAj
         VRYOnwRfZTa3UwA93qqit9quJjyoNolyltXrijQGSoteGqLhBhWba+dMtcdwiFWn58e1
         UIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk2B62s642b15/0vB4cKNN8JjLYJWafTuhxlnEkMi1/1WYuu0WXSZQpE3y9hgtA0QgOVy1YE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyG1ibQbimrvG6leGOkPxCMq8o/0Rw8U7L8mz53Kg4FffeT52t
	eT9FI5yNpcQ12bAtcC2QY4Xv4HqQf6b2PWQDxBLGM4fuJfTeTgRbZgIEtjvabxwrCuo=
X-Gm-Gg: ASbGnct5rm3N7CYDshaOLgz5OfEMZg/x6AW9oFt8SLg0Wh6yCY3Gx4DJxaD06+Kr40J
	5PIXgkDdgw41y9TrTUygdoASkYGiMVVJudAz2oNyIALIfE0+dlpSWevRGvgEdNpilKwvGx2QxX2
	oF+pJRnmMjrLZf9FwhqOOJ7k3AQFRuEs0WMcBHxBbn/LX8wfD9uSlx/mwtH05Ri1sSE3IL1gAvN
	Nh2H7VDPJbb0MH6qo2UIMXz3d9EX3bvI4jvhz2q9HSz/CMVU1WNLt1AJOYQEMyWcF/9uQnH80v2
	rpdsjy0QLlQRlTeE8o85SJf0G5gwSh8REhT/+aPB/Z9LFRKHXGGV8g==
X-Google-Smtp-Source: AGHT+IHXbStwUwhue6mULs4NhRSntv//JjrAdkWxN+/rbT9QEVTAP8vDqK8QfKQta/W83NCjG9XMQw==
X-Received: by 2002:a17:907:c018:b0:ae3:595f:91a2 with SMTP id a640c23a62f3a-ae3595f9724mr1328108766b.57.1751315428228;
        Mon, 30 Jun 2025 13:30:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363afdcsm725086066b.29.2025.06.30.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 13:30:27 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Arthur Fabre
 <arthur@arthurfabre.com>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Jesper Dangaard Brouer <hawk@kernel.org>,
  Jesse Brandeburg <jbrandeburg@cloudflare.com>,  Joanne Koong
 <joannelkoong@gmail.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,  Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next 07/13] net: Clear skb metadata on handover from
 device to protocol
In-Reply-To: <aGK6hdOwBSC7r4gF@mini-arch> (Stanislav Fomichev's message of
	"Mon, 30 Jun 2025 09:25:41 -0700")
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
	<20250630-skb-metadata-thru-dynptr-v1-7-f17da13625d8@cloudflare.com>
	<aGK6hdOwBSC7r4gF@mini-arch>
Date: Mon, 30 Jun 2025 22:30:26 +0200
Message-ID: <87o6u5nfa5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 30, 2025 at 09:25 AM -07, Stanislav Fomichev wrote:
> On 06/30, Jakub Sitnicki wrote:
>> With the extension of bpf_dynptr_from_skb(BPF_DYNPTR_F_SKB_METADATA), all
>> BPF programs authorized to call this kfunc now have access to the skb
>> metadata area.
>> 
>> These programs can read up to skb_shinfo(skb)->meta_len bytes located just
>> before skb_mac_header(skb), regardless of what data is currently there.
>> 
>> However, as the network stack processes the skb, headers may be added or
>> removed. Hence, we cannot assume that skb_mac_header() always marks the end
>> of the metadata area.
>> 
>> To avoid potential pitfalls, reset the skb metadata length to zero before
>> passing the skb to the protocol layers. This is a temporary measure until
>> we can make metadata persist through protocol processing.
>> 
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  net/core/dev.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index be97c440ecd5..4a2389997535 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -5839,6 +5839,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>>  	}
>>  #endif
>>  	skb_reset_redirect(skb);
>> +	skb_metadata_clear(skb);
>
> And the assumption that it's not gonna break the existing cases is
> because there is currently no way to read that metadata out afterwards?

Correct, only tc_cls_act_is_valid_access tags the register as
PTR_TO_PACKET_META when loading __skb->data_meta, which allows access.

Something worth adding to the description. Thanks.

