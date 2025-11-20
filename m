Return-Path: <netdev+bounces-240379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B61C74039
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 12ECF2DB53
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3003370E9;
	Thu, 20 Nov 2025 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLuGfdqx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6yi1tWC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD59333432
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763642575; cv=none; b=q9bft3QyC/nQAe5yl4RoqrQ6Ewlp8eis++uJ7/d6FDIG7LtCr3rbXjwv1osWSHrINhiQP9kfxQOkUH+JzNIsadmqKEuWLHsdRJf5ePp8c3TptMWApUJL+CaN5UYSKaGTjcv4veZxi1ByRxluCvRxyYGfHr8vZSQdkquJyr70IvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763642575; c=relaxed/simple;
	bh=fp0C2mrMOtA1KciesOPU5KuAb9X1JoByajlzSPN+zNg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dhISAEVcNm6nVinYFthNWb69yXiV6mZ6HDZF4PU515/znAsfw9jjDG0AWQyox4de6He3KAQd0GAMLun/ghEcUsccBEOEAseAi/h2bBO8M3oQO0Wf/AnQ6b7lO6ZLw3RqCkbv0T0fR7DEweDEkV1gUPvPxu3i/67H5daZb43Pbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLuGfdqx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6yi1tWC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763642572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0f8ay78GKAqCOFenMizrbHAD0xXs8zW/BubZz2PRy/0=;
	b=ZLuGfdqxtQHhCJxVACOTlg064ykhEZ1LoOCbgEH0wksI1xVJ+wC04uHXjBKeB68LkoBkJz
	jPWcQgHKUshnwOMNwl01UkrbwpnK6c00ROJ/Ho5WxItbNk316vKeOQ2YW8Oo/8gW78t5Fr
	ak2UGo37g/O/7kKJl26WK9iwq/81wMQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-TZQEHi-tMZ-WFoVMOToztg-1; Thu, 20 Nov 2025 07:42:51 -0500
X-MC-Unique: TZQEHi-tMZ-WFoVMOToztg-1
X-Mimecast-MFC-AGG-ID: TZQEHi-tMZ-WFoVMOToztg_1763642570
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4776079ada3so7648465e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763642570; x=1764247370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0f8ay78GKAqCOFenMizrbHAD0xXs8zW/BubZz2PRy/0=;
        b=G6yi1tWC0oRVd7LsM10anDWeBkQUwYIYVQNkauGV4TaCei1lc0YfqhaWyKlcDdOLSw
         t546LuPCA7EQQZffSfd9DA+EMbdl3Nhx8Bh+MtVBbiV1G7aYqljNn+BdqkSN0UiZXK+Z
         RGKHVcEYkxbDXdRo1Gf4WJAcssjNQ+Yi8Ozd9IglKDoAn7reSFtwZIUYnyoC8qAowrJv
         /put0xgvDpHlO0B/sW/7mlFBRaTT+kut//5i9Xga/bG2daWWck4D+DDWZlVPaZXPb+wB
         zicGWARBgvRfoRub9UvVBNGNQji2tBNLhgNh4CLmvHLWz/TtEPJx9Wh1vSCEdfFTT7C4
         0AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763642570; x=1764247370;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0f8ay78GKAqCOFenMizrbHAD0xXs8zW/BubZz2PRy/0=;
        b=vUaEWBj6MSuTb6EdQ2e4MP+oP3vRhd3hgGE/cov4F6+P9GIUoJuk0w1Ji9xuizCS5R
         VarMLqhaPv6uYF94tWcx8KzLY4m2NZQXYX4iVFQ8lmpPurkZo7zJrKPhzYVjpNl281A2
         B6XzXOyvrULK63gqBYysoYk3iPxTkxT1n4lgkBp4bRR35Oo1LF7Htc2H8KCcydkULEqP
         qTGLNt+b+y6gV4N7XbKp2v1YV7OClB5Pe1BVpZvSn2VwwY8YKLP1lzTKSHwtFOjBiA20
         FsShnbpyCq++CJxIQ6q2YA604HbQe7jRZFOXrrGcIuqFs2A9jdpTkmXqgeOdmwexBdhO
         tZXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe1VBlakwFkr/4ILXUudktsfq8kcD5MyRSj/K4v1uY9NW9LT1NMiTgzAzROW6//WCKaZwuGIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyri0l1rh6yHWleQ6E7A9Owwi/tvwmdUK5y4HeaqgSSWslayibx
	zRTLn/wRax7AhoGQHt9dSvKG0oeWq5BuFHNi1v389q6f6zj286AoNqc7VxoW6iIIM7fWo9z6lKJ
	93tnE2tk8H/yDMPFQHVJOFCX4Be21vtgdEkJi3peR1jMn/eK53XVCMgxRYg==
X-Gm-Gg: ASbGncsDjBHAHbSP9yshzVHwwyqdZUMJuHBBU0yR00vv6BByqCVINOrnxwV53szxfHv
	3qnsKdUBXs7jJ9gpXyoH2on4AZ2WM0/taLwPvuwicKswu7zsEo36Rq+kXeKQaBFVpJSqPe0JszN
	qFuJX9BuUOOmnYdXTlpFskQeTuWeW1948xgTcHctyULWrwR6kvhdZ8xhp3z0/aUlf+DAUbiMca1
	DewsPakFumVrgZdfh8WEcJs/IbAmsXFO5330YTPNPCN9AYqz3cj/a0MtQHEWGc9qi5Org75u7T1
	3hminTN4+zk5hC2Unon4NftlFMSt6vorfbgTQNAYutXQ24oojUalECCU23YCmp/3eUIjMUAhQzv
	P6QQqBfpHQJpo
X-Received: by 2002:a05:600c:3b83:b0:477:6e02:54a5 with SMTP id 5b1f17b1804b1-477b8a899b6mr29483495e9.18.1763642570524;
        Thu, 20 Nov 2025 04:42:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTsN51ECygeEQemr/WNJEj/MwIM/NRC/0lDbIpE1k+SEnTrPYbxY1M6EulV62cEOVtg8HpGA==
X-Received: by 2002:a05:600c:3b83:b0:477:6e02:54a5 with SMTP id 5b1f17b1804b1-477b8a899b6mr29482895e9.18.1763642570131;
        Thu, 20 Nov 2025 04:42:50 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10804c8sm107152825e9.15.2025.11.20.04.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 04:42:49 -0800 (PST)
Message-ID: <0b9e0c0e-9684-495f-ba30-9fc77b7b33b5@redhat.com>
Date: Thu, 20 Nov 2025 13:42:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: bonding: use workqueue to make sure peer
 notify updated in lacp mode
From: Paolo Abeni <pabeni@redhat.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>
References: <20251118090305.35558-1-tonghao@bamaicloud.com>
 <9eb3b5bd-5866-49fb-b4fc-5491cb3d426c@redhat.com>
Content-Language: en-US
In-Reply-To: <9eb3b5bd-5866-49fb-b4fc-5491cb3d426c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/20/25 1:33 PM, Paolo Abeni wrote:
> On 11/18/25 10:03 AM, Tonghao Zhang wrote:
>> +static void bond_peer_notify_handler(struct work_struct *work)
>> +{
>> +	struct bonding *bond = container_of(work, struct bonding,
>> +					    peer_notify_work.work);
>> +
>> +	if (!rtnl_trylock())
>> +		goto rearm;
> 
> Why trylock() here? This is process context, you could just call
> 
> 	rtnl_lock();
> 
> and no re-schedule.

Whoops, sorry, I lacked the context. ndo_close() will try to flush the
work under the rtnl lock; the workqueue must not block on such lock to
avoid deadlock.

Still a comment above would be nice/useful for future memory.

/P


