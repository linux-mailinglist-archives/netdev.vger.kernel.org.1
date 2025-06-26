Return-Path: <netdev+bounces-201572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A596AE9F26
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA8A3AB06A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EA32E7170;
	Thu, 26 Jun 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3IzrZqz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD92E6D12
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945305; cv=none; b=tWIVt1Sfqi41xrea6GULD/KsYCZD/OkeIDMe04H8K1z844RoCyxPrEr/l7p2lYPk7bEkGUBRwc9EvLJL0uFvdQbMhUq4w5ug6T/lGQwVZppvBFj64LfmI/nXZyT1i5IweBdkTXRq5a6iNpp/f5W0ydMCdvC3RowGZl/V3SgbvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945305; c=relaxed/simple;
	bh=u//lhMQd9KbT5fl1+Ybodhjdf9qWY1hgEEFgP8FQnaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wj2cfN6SVnJp1orOZiqZqznQWq01JFQCMJbTI9g6a+0G8m+iPgYMGZeY9YtJ+bInVb16625C6p6Jtt6922HliQYEJAuci27xA8Yc99Wv+Xuikpw1aUQBNGyCj6yYtweE1ltX1Xd1xC8Clg8GW4j2k1QmicEEI9iU3ZQzDdi77Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3IzrZqz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750945302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0Ss0ltDzwSWgijfXapYyn0ZCd0YeYzc6zs5snpEFT0=;
	b=X3IzrZqzb6P/3q4ABT7PxyjL3htqgi08bgbVQtS/NM+WDGaHpCmc41YI4RyaUGUzZgwhJb
	lu+EhQRwVOH3x/fvtfpER31GO4eBQ5YXW6Q4wuzyhw6LT/bO3wpJQObLmpx4hVehh6xCSl
	/MUh0d1Tpaphx3MND5A3y7IPIHk6d6k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-gj5RnWgjMEqQx_T1sOaD-w-1; Thu, 26 Jun 2025 09:41:41 -0400
X-MC-Unique: gj5RnWgjMEqQx_T1sOaD-w-1
X-Mimecast-MFC-AGG-ID: gj5RnWgjMEqQx_T1sOaD-w_1750945300
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so618375f8f.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 06:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750945300; x=1751550100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0Ss0ltDzwSWgijfXapYyn0ZCd0YeYzc6zs5snpEFT0=;
        b=wYOwC8zIuRxTNtpqY9oOJTgUUsXHu4xNmPuqvRR4ZZi163r+jgHh27Nu7RTtAnYWIL
         ft0G0oIZokYzpeZADf2znP0wfOuwXDHfNFNcYBI3Pqwuk2pnXxnB7rjqg7K9l6t5C89u
         M/4dy8u4pLVpn0RZTPrE7APLO4COQpCCDRyqkadfYupNzV604G1ovlvWq/Umv05EJj2F
         1BMzJwwKidz6xiIEM7d4IxXTXLUi9m0Gajcte225e+rJG+bs0KdOtRZlFo/iIEYyTMH6
         iLMYvX3IKGyIMkIOf6PeIJGA6IIww9RVDrgB7wOPW9wRpqg/VCEi6AlIeYDBw4xPNs8r
         qt5Q==
X-Gm-Message-State: AOJu0Yz2Zjaxtet8YigbIhSnFOJKpYUkKLrpQGEg/KZScRbTrPZP9k1I
	JfGBtUOjLZXwOnhcCAWZ3DcupMRHwWverW4f0QRpCZyTqTQpplxJmKiPGgBgiUaJ8yZlJHToNkN
	+cA+HhZur3c5UtqwvmlG9HxofRMA8LfClecxtEzGSSXEjxebGvEZkqw8Yjw==
X-Gm-Gg: ASbGncuCQbA7wtMXX9auKXp4nhpQ7FiFcQJbyoRmoSqVtA7lE+G6AKpg0JIEHQVjWER
	TK8J9yUnxuXwdiVrjFFaLP71VIeiaiNIi9brTylBQaLtJ9J/Ca24JhcrJX2sab889evEVH7qqMU
	oDR1OaYEfNLbuOsTii1rElthmeQpR2xFjifQnKo7K2KitG4nCtMm6vbdHxGbTWZ/1PIvzVHmsD3
	Jhf2xAQPbmOFf5oKDkR51cPvSZsgGAHGtGMULKKlKE+HLXd+V0ponD9NCU+0qrOwqhgosv5zW0W
	XO/OmscA9KHBSvHJH0oaJAWABe5e0D9+7lD6AonEUK6tfw/+zevSvJLcWOhDTTC6+tZY2Q==
X-Received: by 2002:a5d:588e:0:b0:3a6:da76:38b0 with SMTP id ffacd0b85a97d-3a6ed60d1a6mr6807748f8f.25.1750945299844;
        Thu, 26 Jun 2025 06:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfpzvDzK/js7oHvBCNDg74CZrX6PkImoh75g9knZnAzWkas5KoUDeobMR5WQSvrVxD20Ig9w==
X-Received: by 2002:a5d:588e:0:b0:3a6:da76:38b0 with SMTP id ffacd0b85a97d-3a6ed60d1a6mr6807707f8f.25.1750945299335;
        Thu, 26 Jun 2025 06:41:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a831051c49sm292841f8f.30.2025.06.26.06.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 06:41:38 -0700 (PDT)
Message-ID: <46fe8f22-48a5-4593-827d-3b59e9aee7e0@redhat.com>
Date: Thu, 26 Jun 2025 15:41:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v7 3/3] net: bonding: send peer notify when failure
 recovery
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <cover.1750642572.git.tonghao@bamaicloud.com>
 <6965bf859a08214da53cad17ea6ed1be841618fa.1750642573.git.tonghao@bamaicloud.com>
 <77694cec-af8e-4685-8918-4fd8c12ba960@redhat.com>
 <EA1E6A18-1A83-43B8-B91F-5755EB553766@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <EA1E6A18-1A83-43B8-B91F-5755EB553766@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/26/25 1:36 PM, Tonghao Zhang wrote:
>> 2025年6月26日 19:16，Paolo Abeni <pabeni@redhat.com> 写道：
>>
>> On 6/24/25 4:18 AM, Tonghao Zhang wrote:
>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>>> index 12046ef51569..0acece55d9cb 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -1237,17 +1237,28 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
>>> /* must be called in RCU critical section or with RTNL held */
>>> static bool bond_should_notify_peers(struct bonding *bond)
>>> {
>>> - struct slave *slave = rcu_dereference_rtnl(bond->curr_active_slave);
>>> + struct bond_up_slave *usable;
>>> + struct slave *slave = NULL;
>>>
>>> - if (!slave || !bond->send_peer_notif ||
>>> + if (!bond->send_peer_notif ||
>>>    bond->send_peer_notif %
>>>    max(1, bond->params.peer_notif_delay) != 0 ||
>>> -    !netif_carrier_ok(bond->dev) ||
>>> -    test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
>>> +    !netif_carrier_ok(bond->dev))
>>> return false;
>>>
>>> + if (BOND_MODE(bond) == BOND_MODE_8023AD) {
>>
>> I still don't see why you aren't additionally checking
>> broadcast_neighbor here. At least a code comment is necessary (or a code
> checking broadcast_neighbor is unnecessary, because send_peer_notif is set when bond is in BOND_MODE_8023AD mode and broadcast_neighbor is enabled.

I see. send_peer_notif is cleared on mode changes, so we can't reach
here with a non zero value after changing the mode to something else.

IMHO the scenario is not trivial, a comment here is deserved (at very
least because I already asked it 3 times ;).

Thanks,

Paolo


