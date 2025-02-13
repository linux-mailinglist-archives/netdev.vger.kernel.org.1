Return-Path: <netdev+bounces-166109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDC1A348A0
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E75F3A3DBF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA0818A6C4;
	Thu, 13 Feb 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWHWGfhE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E626B087
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461768; cv=none; b=M7SUljmC0Yqf4vBUNUD6YrbJc6f93Jpy+iqq4gWoY1J4cFIHcAlWdf88tCNUDG4VekHungmOXT9HX9S2qL/4JJArJ1mRJIdIKJjCAv1ufB1/krRAJy4x7B1CdzImx6Ne+ZjgJiBXPvEIRe/Wczn7V0rL64M7RbLWO/werurwD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461768; c=relaxed/simple;
	bh=QxiTelb5JpMGvUMV4w+dtN38AruWvC+WVoDMbUIhQ78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ov1177Nh6Bqbmta+WLdLEeY3gV2uvGOniEBJOfXu7yRgt80lr6GL+284j8sH5CP9QRKwrZXy8pA7K0YDX3q4/DbOffjylRtJPoXeiFKRrj3jqypNooUHsMahDw0CGkMSkY5MRdHQZKiN8E7xtMev9V7jKjrsEcKrxLzylqwfugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWHWGfhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32DFC4CEE5;
	Thu, 13 Feb 2025 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739461768;
	bh=QxiTelb5JpMGvUMV4w+dtN38AruWvC+WVoDMbUIhQ78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hWHWGfhEmk1swWsG/jXOivnNLcZQSQzzR3KKPF4j2trWx43kr36eNuagP5I8T9kmj
	 RgE8f3n8Uuq/tvrWfVR95p1kuVJqiJgcwcYq+2r3nnr/Ym72LQ6/wDZgAOQq02vL/4
	 NK8eFz2BVr5wwhmh0t+sZZMS/IKaMmkic21mNwiA/gWuFBJXlK8DTqfIJczLuY8lY7
	 rLejLIHQcHfvdSHNTxTEHftiG11YlTU21d4v3rtRTQm4FptFS2KgOxDTQWTSOtIHat
	 Ykpkz+OImNERH7N09lqyfNfwHIEA6TcHkZGJZ0HyZgpHV7dAN/ekFNxMgi+8sPXV3w
	 8JhplcWPFisFg==
Message-ID: <b35c478a-8772-4391-b9dc-db981f34edc9@kernel.org>
Date: Thu, 13 Feb 2025 08:49:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] ipv6: fix blackhole routes
Content-Language: en-US
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Eric Dumazet <edumazet@google.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Paul Ripke <stix@google.com>, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20250212164323.2183023-1-edumazet@google.com>
 <20250212164323.2183023-3-edumazet@google.com>
 <9f4ba585-7319-4fba-87e0-1993c5ae64d3@kernel.org>
 <CANn89iLiEcbnbMj7MdCTPsxoT3fHANALZ9LAAsG9T+sWcv-vew@mail.gmail.com>
 <Z61ZXLdD4VQZFcBa@mini-arch>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <Z61ZXLdD4VQZFcBa@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/12/25 7:30 PM, Stanislav Fomichev wrote:
> On 02/12, Eric Dumazet wrote:
>> On Wed, Feb 12, 2025 at 7:00 PM David Ahern <dsahern@kernel.org> wrote:
>>>
>>> On 2/12/25 9:43 AM, Eric Dumazet wrote:
>>>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>>>> index 78362822b9070df138a0724dc76003b63026f9e2..335cdbfe621e2fc4a71badf4ff834870638d5e13 100644
>>>> --- a/net/ipv6/route.c
>>>> +++ b/net/ipv6/route.c
>>>> @@ -1048,7 +1048,7 @@ static const int fib6_prop[RTN_MAX + 1] = {
>>>>       [RTN_BROADCAST] = 0,
>>>>       [RTN_ANYCAST]   = 0,
>>>>       [RTN_MULTICAST] = 0,
>>>> -     [RTN_BLACKHOLE] = -EINVAL,
>>>> +     [RTN_BLACKHOLE] = 0,
>>>>       [RTN_UNREACHABLE] = -EHOSTUNREACH,
>>>>       [RTN_PROHIBIT]  = -EACCES,
>>>>       [RTN_THROW]     = -EAGAIN,
>>>
>>> EINVAL goes back to ef2c7d7b59708 in 2012, so this is a change in user
>>> visible behavior. Also this will make ipv6 deviate from ipv4:
>>>
>>>         [RTN_BLACKHOLE] = {
>>>                 .error  = -EINVAL,
>>>                 .scope  = RT_SCOPE_UNIVERSE,
>>>         },
>>
>> Should we create a new RTN_SINK (or different name), for both IPv4 and IPv6 ?
> 
> Sorry for sidelining, but depending on how this discussion goes,
> tools/testing/selftests/net/fib_nexthops.sh test might need to be
> adjusted (currently fails presumably because of -EINVAL change):
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/990081/2-fib-nexthops-sh/stdout
> 

yep, I verified that yesterday - there are blackhole selftests. At this
point SINK or whatever the name would have to be a new API, including
how the route is installed if no local failure is really desired.



