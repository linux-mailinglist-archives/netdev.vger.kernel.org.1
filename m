Return-Path: <netdev+bounces-128368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4002F97931A
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 21:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AE7B20E70
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 19:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AA25476B;
	Sat, 14 Sep 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="VJYq0qRX"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145604AEDA;
	Sat, 14 Sep 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726340666; cv=none; b=ibtPWTbnLrNVT9UZwFHA/SN6oQBhioFaWBvaJpaafHP4bqWgiVizMf3EOu+/cWtxsQkMrwm6+CH/1CCcqwEagwtRrSPnZhRsEKp38KpvQ+LJEzZHpOxA9PgkyCVSbddbfLdsGCg6f6zJuKgcKnJNY2g7VsIw7IIF3U5zsZYLZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726340666; c=relaxed/simple;
	bh=g1cqcvO9UV0eNS3Ui8Ko2I6PHkp3MC4MoNE310SXaME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTkLu8mbRlpAeKMyJF3h9nJ5GiHWEJ4rY1Iqln4DoL4g/56jPbwozFW8PtRnUBW/GWn8sxuj99DoMCsXnnw8Z9qQ1lQaZXKr0S1uRjHyBZ4wMlFXUtWjCK8IBbR0Ix9BXZaxKIMcYDoR6iRgsQoi7jeXsOkvKStmbYcKEde29I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=VJYq0qRX; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1726340654;
	bh=g1cqcvO9UV0eNS3Ui8Ko2I6PHkp3MC4MoNE310SXaME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VJYq0qRXdNy7U2ig2BXGi4f8+OUfsQWRUycba6Bc26uqApjuDelY5LDkRoEK1sNkX
	 7OlwzmshyVVL6FSBbFwyur1bBhR0kSHfWsmJ37wu8TVKgqwfA/h4xnbilVXiUeTjKM
	 KxP8pwLqa0ekt/s/mMVIG0xJ0+7MnroVqY0aFEWn8hGlI3lO1qhwVmVkxf+Y6LtXJp
	 cI6yYVPZfl6JJn6Le7GDGGaJfEMtRJZX9o3Gqa8/I+7OPJCoZkfEncSYYbZIzL/fIg
	 qv9frc2K+hU0+wk/e1mYML3J2tRA6yOTjZ3SYAxCFqHJt52Pi9mcPlkpySOBJ8myc8
	 KPyvvlWaPn8gA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4603160078;
	Sat, 14 Sep 2024 19:04:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 9072D2009C4;
	Sat, 14 Sep 2024 19:03:38 +0000 (UTC)
Message-ID: <376db1bb-8a00-40e5-bf70-f8587d460372@fiberby.net>
Date: Sat, 14 Sep 2024 19:03:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tools: ynl-gen: use big-endian netlink attribute
 types
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240913085555.134788-1-ast@fiberby.net>
 <20240913213941.5b76c22e@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240913213941.5b76c22e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kuba,

On 9/14/24 4:39 AM, Jakub Kicinski wrote:
> Nice improvement! Since it technically missed net-next closing by a few
> hours, let me nit pick a little..

Yeah, sorry about that, first realized that net-next had closed after posting.
I had just waited for my net patch to make its way to net-next before posting, so
MPTCP_PM_ADDR_ATTR_PORT wouldn't change to NLA_BE16.

> On Fri, 13 Sep 2024 08:55:54 +0000 Asbjørn Sloth Tønnesen wrote:
>> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
>> index 717530bc9c52e..e26f2c3c40891 100755
>> --- a/tools/net/ynl/ynl-gen-c.py
>> +++ b/tools/net/ynl/ynl-gen-c.py
>> @@ -48,6 +48,7 @@ class Type(SpecAttr):
>>           self.attr = attr
>>           self.attr_set = attr_set
>>           self.type = attr['type']
>> +        self.nla_type = self.type
> 
> is it worth introducing nla_type as Type attribute just for one user?
> inside a netlink code generator meaning of nla_type may not be crystal
> clear

Maybe not, I just took the same approach as byte_order_comment, and
co-located it with the existing byte-order condition in TypeScalar.

>>           self.checks = attr.get('checks', {})
>>   
>>           self.request = False
>> @@ -157,7 +158,7 @@ class Type(SpecAttr):
>>           return '{ .type = ' + policy + ', }'
>>   
>>       def attr_policy(self, cw):
>> -        policy = c_upper('nla-' + self.attr['type'])
>> +        policy = c_upper('nla-' + self.nla_type)
> 
> We could just swap the type directly here?

That could work too, WDYT?

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 717530bc9c52e..e8706f36e5e7b 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -157,7 +157,10 @@ class Type(SpecAttr):
          return '{ .type = ' + policy + ', }'

      def attr_policy(self, cw):
-        policy = c_upper('nla-' + self.attr['type'])
+        policy = f'NLA_{c_upper(self.type)}'
+        if self.attr.get('byte-order', '') == 'big-endian':
+            if self.type in {'u16', 'u32'}:
+                policy = f'NLA_BE{self.type[1:]}'

          spec = self._attr_policy(policy)
          cw.p(f"\t[{self.enum_name}] = {spec},")


