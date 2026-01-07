Return-Path: <netdev+bounces-247649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 048CDCFCD53
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC623070D5D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4328270EDF;
	Wed,  7 Jan 2026 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="OYyZnfag"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A02517AA
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777460; cv=none; b=CHcbliylKKRrQymGNPrr/KJ2ViYN4QUOXScEpmynsO8UK7JdD0gKikpfhnsigzikZYJcIx7/BJ8BJDm1o8nlwPsFWk/2UWlULsZWLuDVFQI2SdushQAW1oqUXSJOEV0tpUa1YbpwHOOddIE2pQa3jsZDS4/WRKIE4LwhHl0oBFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777460; c=relaxed/simple;
	bh=sJibSbyiHEkM8f1lwodBlV02zdN7wr4k/0gSXJo4KoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=of1eN83RK1ysiJ2pY1oOFi+i6/VzK+92CN9xkNZ9wp75wUYKKgKpq/spFvUb49iSZaEO0QwJINjCLChP8JWHELR0yRuu9KzTRn9IbTB7pz9RMyYMe4TlbkTtfYLgrtTob5IyFlOcDqTJQgyCFZmkPvwlOd7i2jAmDVXYXgaYiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=OYyZnfag; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1767777448; bh=sJibSbyiHEkM8f1lwodBlV02zdN7wr4k/0gSXJo4KoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OYyZnfag+BvZ86xIlXCc6s2j0ZU/mwWIDPvaihWNf3NR+WxR/giefkdxvT9Qkecd0
	 fZF957s6y+yZsfPDTK1CmRIDPXxJTzCAPMa4RtJPkpjWKSqRbUOnzN1wza46SUu8Ff
	 wD5I4znXjNmGAzkdo4CmKjs/K99x2v5bDRLql+HPsFMIb2l8VkykiP1zdcLLyVAZ+h
	 Xt7j2j3gxM9GdqvVeILrsEgb9P5gLDjjASk0jnDYVeePAutBqKndp1ONybUCzDTWGz
	 11qqbxOG2dm5V52UlymDAtazwHPixG79eDM7vp71lKAMiEJgY01upwhB08htPodKsY
	 D++NbCT4v2bEA==
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/6] net/sched: sch_cake: Factor out config
 variables into separate struct
In-Reply-To: <willemdebruijn.kernel.21e0da676fe64@gmail.com>
References: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
 <20260106-mq-cake-sub-qdisc-v6-2-ee2e06b1eb1a@redhat.com>
 <willemdebruijn.kernel.21e0da676fe64@gmail.com>
Date: Wed, 07 Jan 2026 10:17:27 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87jyxt4w9k.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:

>>  static int cake_init(struct Qdisc *sch, struct nlattr *opt,
>>  		     struct netlink_ext_ack *extack)
>>  {
>> -	struct cake_sched_data *q = qdisc_priv(sch);
>> +	struct cake_sched_data *qd = qdisc_priv(sch);
>> +	struct cake_sched_config *q;
>>  	int i, j, err;
>>  
>> +	q = kvcalloc(1, sizeof(struct cake_sched_config), GFP_KERNEL);
>> +	if (!q)
>> +		return -ENOMEM;
>> +
>
> Can this just be a regular kzalloc?

Yeah, I guess so. I'll change this if there's a need to respin for other
reasons, but probably not worth respinning for this on its own? Seeing
as it'll all end up in the same kmalloc call anyway :)

> More importantly, where is q assigned to qd->config after init?

Just below:

>>  	sch->limit = 10240;
>>  	sch->flags |= TCQ_F_DEQUEUE_DROPS;
>>  
>> @@ -2742,33 +2755,36 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
>>  			       * for 5 to 10% of interval
>>  			       */
>>  	q->rate_flags |= CAKE_FLAG_SPLIT_GSO;
>> -	q->cur_tin = 0;
>> -	q->cur_flow  = 0;
>> +	qd->cur_tin = 0;
>> +	qd->cur_flow  = 0;
>> +	qd->config = q;

Here:   ^^^^^^^

-Toke

