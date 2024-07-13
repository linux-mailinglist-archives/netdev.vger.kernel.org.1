Return-Path: <netdev+bounces-111177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4198C9302F6
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 03:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D0C282EEB
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 01:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BB68BFF;
	Sat, 13 Jul 2024 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="v0PMbDDV"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4829748F;
	Sat, 13 Jul 2024 01:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833320; cv=none; b=aRg2LDPmuTISGVHexHe5WQYwWrH3j1ttrRSZl8MxbNpJgD3QCKjAbM9Q4Ktl//KoIITmhZj14K+DXwvYdaUyfFvtBaoiFBUH4TosxkcwtllkmkQ1/khNexMtVuaLMYCUJ93R00zvaxCNZBHqVBv/et/g0DfPlHfRhcKxsJF+4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833320; c=relaxed/simple;
	bh=du3UW8tRNOLxQwkKF7Z6rMUYEyzL+xfjgY6IRpaAueg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBbRUfHyzGl1EBH3bBe0uDUsW9FBDP6I2ok5LjMrAiN6KugEzUZURMUMyHdLUizt0J6XLYu7IaCst5BsupMQ8OnZHYaKyO1TSG4PCX4Kh4YL2C7/NccShOBT1GqQmEFCVBbk/F/PDyK9cQsL3sPpIYg7zD/m6BKJ5qruZuZM230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=v0PMbDDV; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720833308;
	bh=du3UW8tRNOLxQwkKF7Z6rMUYEyzL+xfjgY6IRpaAueg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v0PMbDDVruenwHGcOXejYi0xAzx7FtGIvgGlfpSrqLC9W5AmiFcfHJ6XHkpr+eJEd
	 LeFFiVbrfkoNT76Rh3bvESxyFA+KfcdFDhJz7GvHsZYESdPl9Li1BfXQugG3y8OYct
	 eI/vhj094zqXMwOv0X06/ujF0ntOHVXXk3LCWmlvdUzJnrUZwgVGLkQFWH6k0GzdW+
	 e0Pq9I5MdkRueTT8LZdNJFZ5mH2fxUb7iBl2nhZNwjuZhU8f8ZdNdkkcsEQBYXPPIT
	 bkH07WvI/U0fjhDJ+rdPRV523t+Ipy6TiGkZjmfHhJg0DflE3Z7hIYPp/xxltJtept
	 r6tcUNh/oUTsw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9797260078;
	Sat, 13 Jul 2024 01:15:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 1C01320484A;
	Sat, 13 Jul 2024 01:14:58 +0000 (UTC)
Message-ID: <84b4b03d-3ec5-48cc-a889-bbeaaf3ceb0c@fiberby.net>
Date: Sat, 13 Jul 2024 01:14:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/10] net/sched: cls_flower: prepare
 fl_{set,dump}_key_flags() for ENC_FLAGS
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Florian Westphal <fw@strlen.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-kernel@vger.kernel.org
References: <20240709163825.1210046-1-ast@fiberby.net>
 <20240709163825.1210046-4-ast@fiberby.net>
 <20240711185404.2b1c4c00@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240711185404.2b1c4c00@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jakub,

On 7/12/24 1:54 AM, Jakub Kicinski wrote:
> On Tue,  9 Jul 2024 16:38:17 +0000 Asbjørn Sloth Tønnesen wrote:
>> +	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, fl_mask)) {
> 
> Does this work with nest as NULL?

It does, but it gives less information:

  * struct netlink_ext_ack - netlink extended ACK report struct
  [..]
  * @miss_nest: nest missing an attribute (%NULL if missing top level attr)

NL_REQ_ATTR_CHECK() doesn't check the value of nest, it just sets it.

That line originates from Davide's patch and is already in net-next:
1d17568e74de ("net/sched: cls_flower: add support for matching tunnel control flags")

It was added to that patch, after Jamal requested it.
https://lore.kernel.org/CAM0EoMkE3kzL28jg-nZiwQ0HnrFtm9HNBJwU1SJk7Z++yHzrMw@mail.gmail.com/

> tb here is corresponding to attrs from tca[TCA_OPTIONS], so IIRC we need
> to pass tca[TCA_OPTIONS] as nest here. Otherwise the decoder will look
> for attribute with ID fl_mask at the root level, and the root attrs are
> from the TCA_ enum.
> 
> Looks like Donald covered flower in Documentation/netlink/specs/tc.yaml
> so you should be able to try to hit this using the Python ynl CLI:
> https://docs.kernel.org/next/userspace-api/netlink/intro-specs.html#simple-cli
> But to be honest I'm not 100% sure if the YNL reverse parser works with
> TC and its "sub-message" polymorphism ;)

After extending the spec to know about the enc_flags keys, I get this:

$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/tc.yaml --do newtfilter --json '{"chain": 0, "family": 
0, "handle": 4, "ifindex": 22, "info": 262152, "kind": "flower", "options": { "flags": 0, "key-enc-flags": 8, 
"key-eth-type": 2048}, "parent": 4294967283}'
Netlink error: Invalid argument
nl_len = 68 (52) nl_flags = 0x300 nl_type = 2
         error: -22
         extack: {'msg': 'Missing flags mask', 'miss-type': 111}

After propagating tca[TCA_OPTIONS] through:

Netlink error: Invalid argument
nl_len = 76 (60) nl_flags = 0x300 nl_type = 2
         error: -22
         extack: {'msg': 'Missing flags mask', 'miss-type': 111, 'miss-nest': 56}

In v4, I have added the propagation as the last patch.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

