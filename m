Return-Path: <netdev+bounces-102973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E571A905BAF
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 21:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6835EB24113
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7114382D93;
	Wed, 12 Jun 2024 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="h9LqdHtw"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5A582C8E;
	Wed, 12 Jun 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219247; cv=none; b=P3hcaGRXvHxZAz8bDRg2iB7UqjA1AYRZpifLgbQXe6EcCEIIwUqQUhMrU7ERfbLKoHL8RZkSLNP/e0ym4KhJEEWiOwd37WEJClTYcub5moZcQrP/XdGSFU18yaKKngz62b0WgmqYxPZpabzuGm+1S6h/5FqSEuJJzjltgtihJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219247; c=relaxed/simple;
	bh=pYJ0NhdbHfLh+0Ti9ZhqGoLI9uZW8HiS8P0m+9+BSFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwx6tq8CLiUO2RGoc8aufZeEvPqhvBRP9UsJCDGInuIoyf6ThZTJoq54yBQ2oKX1/LYU1tGRJayP8617R8Q3dL2BNQG0lTVivsfEPSDmOJ68GDYXKix9zAKrQiKhGbyv4IkP3vmEzmKk02A9mh/QJoiWsYEEAgxHDetPA6rz/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=h9LqdHtw; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718219241;
	bh=pYJ0NhdbHfLh+0Ti9ZhqGoLI9uZW8HiS8P0m+9+BSFk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h9LqdHtwtogXhy/EoRPzbtvst5NoICJ5N8y76YZchkAvliQOKXDwNmHESWfnJq8ZN
	 oEDaPipW6ZJYWr9x6IdyT3HEsrnIydCOSDXbEs38DZsdwN/t5vNLAH90tj1wVvh0eD
	 5en6iHTVo9W/eahEb3Tk0b02EL+LmJOTSnFLpMKYQGjga+C9MD5r/G1ZccCL21dRs0
	 A2gb5hD5xVurnU+YN4CPPHB2/q8MEAfQidQipYjyHjmUaGrd9onJiNA0jbuU0aLAae
	 Sk2x8tT+CWtPX8/9XhtXXy1U9Yb4In2jM7lbTR9IVGF2+kXAB5OqfXy77GEZJSXuvL
	 3GCHLbeQPuAiQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9D76B6007C;
	Wed, 12 Jun 2024 19:07:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id D52B3201136;
	Wed, 12 Jun 2024 19:07:12 +0000 (UTC)
Message-ID: <2642a36f-1e53-4672-9826-8c07d10d69f2@fiberby.net>
Date: Wed, 12 Jun 2024 19:07:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 0/9] flower: rework TCA_FLOWER_KEY_ENC_FLAGS
 usage
To: Davide Caratti <dcaratti@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240611235355.177667-1-ast@fiberby.net>
 <Zmm5e3KFxFCQzwzt@dcaratti.users.ipa.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <Zmm5e3KFxFCQzwzt@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Davide,

On 6/12/24 3:06 PM, Davide Caratti wrote:
> On Tue, Jun 11, 2024 at 11:53:33PM +0000, Asbjørn Sloth Tønnesen wrote:
>> This series reworks the recently added TCA_FLOWER_KEY_ENC_FLAGS
>> attribute, to be more like TCA_FLOWER_KEY_FLAGS, and use
>> the unused u32 flags field in TCA_FLOWER_KEY_ENC_CONTROL,
>> instead of adding another u32 in FLOW_DISSECTOR_KEY_ENC_FLAGS.

s/TCA_FLOWER_KEY_ENC_CONTROL/FLOW_DISSECTOR_KEY_ENC_CONTROL/

>> I have defined the new FLOW_DIS_F_* and TCA_FLOWER_KEY_FLAGS_*
>> flags to coexists for now, so the meaning of the flags field
>> in struct flow_dissector_key_control is not depending on the
>> context that it is used in. If we run out of bits then we can
>> always make split them up later, if we really want to.

s/always make split/always split/

>> Davide and Ilya would this work for you?
> 
> If you are ok with this, I can adjust the iproute code I keep locally,
> and the kselftest, re-test, and than report back to the series total
> reviewed-by.
> It's going a take some days though; and of course, those bit will be
> upstreamed as well.
> 
> WDYT?

That would be great, there is still quite some time left before net-next
closes, I just wanted to get the ball rolling, with some code, so it is
easier to discuss the implementation details.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

