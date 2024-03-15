Return-Path: <netdev+bounces-80017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBC487C790
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 03:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD92D1C212D7
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 02:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8A76AA0;
	Fri, 15 Mar 2024 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwQQbNF+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04D79DE
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470086; cv=none; b=LN0tgj3qk2MU6/mODz3aCMpJdmCXtDgZ2OX4kSz6BVI7PCw4pQrEjijupmRfwY3KYR2R/2hcoKsAlOpnFAttMKODmFwmGGnJHU0B9iJ9v4ZEDodku5qEJWmxtALU4ivc5qzVPJOZP4su/I+0sti+aZCXBJrlopEDPHeP7lnaLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470086; c=relaxed/simple;
	bh=3sN91xSQJYCCwlGVlZkCAHVvcsrlaZ+bV7z9B9hEAeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAJV0R5Qnjqql9HW3/gOg6msZbXL9+T7FnTYq9G8r0gMOLwleHeQDC+f8Xp5gcHpHtva90fI5QwEtqZRhfI5R1vvDLYBwWbHBh7zKfUGLUUqmBycXpRA6yui0o3C9Ta96WPpJi3MQekIKcCjZUJUK7uWbLBnQvK8g8pWSKcYjxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwQQbNF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E303C43390;
	Fri, 15 Mar 2024 02:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710470085;
	bh=3sN91xSQJYCCwlGVlZkCAHVvcsrlaZ+bV7z9B9hEAeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EwQQbNF+O5BsycE2hAAZjtFNTGdYbfc0txij5ut/w/0QX85j8mRyW/W3T61Qxw/c9
	 udvhEN9vh5m+dA3XEpemPcX2tA68RzFdpqOuExPwOHpc4fbIQJJJmFwLUcM8PzkRKY
	 GPF5E32gK9wPHdc84eY+dbFFgmwhMAnvl41NMqU0HNh0mzQ9aAx/hpaXZcutzrBjPQ
	 vaXBTDCxXIT/990QSNVik0Ib5sX7EJ6vi/pSOw7DZG/GlwGRwLH3HJisUOdtEhINWG
	 kVMfCKCmZOMBOYXlfbYOHx/a49R0yK+eomg4SIx1JqwEH4ZlS42Rg1GHqZ17538o14
	 ZXqck/had79WA==
Message-ID: <19699d5f-29d7-4e14-b954-d612c5035b4a@kernel.org>
Date: Thu, 14 Mar 2024 20:34:43 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] ifstat: handle strdup return value
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>,
 Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org,
 Denis Kirjanov <dkirjanov@suse.de>
References: <20240314122040.4644-1-dkirjanov@suse.de>
 <20240315022329.GA1295449@maili.marvell.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240315022329.GA1295449@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/24 8:23 PM, Ratheesh Kannoth wrote:
>> diff --git a/misc/ifstat.c b/misc/ifstat.c
>> index 685e66c9..f94b11bc 100644
>> --- a/misc/ifstat.c
>> +++ b/misc/ifstat.c
>> @@ -140,6 +140,11 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
>>
>>  	n->ifindex = ifsm->ifindex;
>>  	n->name = strdup(ll_index_to_name(ifsm->ifindex));
>> +	if (!n->name) {
>> +		free(n);
>> +		errno = ENOMEM;
> strdup() will set the errno right ? why do you need to set it explicitly ?

agreed.

pw-bot: cr


