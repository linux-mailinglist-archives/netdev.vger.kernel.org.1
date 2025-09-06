Return-Path: <netdev+bounces-220581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30AB46D95
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 15:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719937C676E
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2042877C7;
	Sat,  6 Sep 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="OgLxGL9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2527FD52;
	Sat,  6 Sep 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164431; cv=none; b=HPhfgADvxkGlh5g79PEfwpDYu3YMbQ4+YHFOiIvyEBeUQGR60lHyrU7xi9TheM9aDj6bv99+kfSLA9hrE+hSKjUcJwZKlaQ/3FPZ6ejFEdI50s5sbc/5ECEXLmtOekz+Rk+M56FnedCSSApLKP+Re7Qj9obe6HUzxPoH1GeWxbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164431; c=relaxed/simple;
	bh=U6Wn//k2dt+WlP5FxdkKg0o/lsaAgnjgIxpLlAHFjRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBxJx2RiFI5eLQY7GK2G662NFAV0W+3Xs+TtKoLJG7nGQL7V0q7mIf3WEeyqCU/sAZrJx1SEsvDuyudg5gaPvwth5eLEXI0Y9tcoIUR2It/4spypMAJGvvHOM75cUmfgxG3Ov0Yl5K585I9NVNfdmUQxAWAKiC0MIleDnrh0ih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=OgLxGL9P; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757164418;
	bh=U6Wn//k2dt+WlP5FxdkKg0o/lsaAgnjgIxpLlAHFjRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OgLxGL9PmY2hDenIKO9MTOuA3hj3rjjLAE6gjC9/ut3CTDj/0n6d/ADaLV5sS/pre
	 qdp9FbPirBIExy5Mm6og2meB1/orgHoCFAjd1mkFfN6LpqT5tDkT+pt1SvnX6v4Rr3
	 S+dUj2BvE4zyk7sJXMzhEK+TNEpx0jSsvlRlZlz1sGzjD4U7Pbw7Lc9JjP0N1JkP6X
	 aJBoU8dj0tx2HIbz7+5uGBtNJa4Rd/kls/Gn4E9QNFJgn/AewqUzY9R7NJduTXFdld
	 zISErTvpey3eCskU22l+eQ26xZTtEPZOgNdeKHDXVD3NPo5/0eVwBL78KMSspEUwe4
	 9UiA8dfLBbK1A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5E7046000C;
	Sat,  6 Sep 2025 13:13:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id E9D4C200438;
	Sat, 06 Sep 2025 13:13:29 +0000 (UTC)
Message-ID: <4eda9c57-bde0-43c3-b8a0-3e45f2e672ac@fiberby.net>
Date: Sat, 6 Sep 2025 13:13:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/11] tools: ynl-gen: define nlattr *array in a
 block scope
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-5-ast@fiberby.net>
 <20250905171809.694562c6@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20250905171809.694562c6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/25 12:18 AM, Jakub Kicinski wrote:
> On Thu,  4 Sep 2025 22:01:28 +0000 Asbjørn Sloth Tønnesen wrote:
>> Instead of trying to define "struct nlattr *array;" in the all
>> the right places, then simply define it in a block scope,
>> as it's only used here.
>>
>> Before this patch it was generated for attribute set _put()
>> functions, like wireguard_wgpeer_put(), but missing and caused a
>> compile error for the command function wireguard_set_device().
>>
>> $ make -C tools/net/ynl/generated wireguard-user.o
>> -e      CC wireguard-user.o
>> wireguard-user.c: In function ‘wireguard_set_device’:
>> wireguard-user.c:548:9: error: ‘array’ undeclared (first use in ..)
>>    548 |         array = ynl_attr_nest_start(nlh, WGDEVICE_A_PEERS);
>>        |         ^~~~~
> 
> Dunno about this one. In patch 4 you basically add another instance of
> the "let's declare local vars at function level" approach. And here
> you're going the other way. This patch will certainly work, but I felt
> like I wouldn't have written it this way if I was typing in the parsers
> by hand.

Thanks for the reviews.

In patch 4, it is about a variable used by multiple Type classes having
presence_type() = 'count', which is currently 3 classes:
- TypeBinaryScalarArray
- TypeMultiAttr
- TypeArrayNest (later renamed to TypeIndexedArray)

In patch 5, I move code for a special variable used by one Type class,
to be contained within that class. It makes it easier to ensure that the
variable is only defined, when used, and vice versa. This comes at the
cost of the generated code looking generated.

If we should make the generated code look like it was written by humans,
then I would move the definition of these local variables into a class
method, so `i` can be generated by the generic implementation, and `array`
can be implemented in it's class. I will take a stab at this, but it might
be too much refactoring for this series, eg. `len` is also defined local
to conditional blocks multiple branches in a row.

tools/net/ynl/generated/nl80211-user.c:
nl80211_iftype_data_attrs_parse(..) {
   [..]
   ynl_attr_for_each_nested(attr, nested) {
     unsigned int type = ynl_attr_type(attr);

     if (type == NL80211_BAND_IFTYPE_ATTR_IFTYPES) {
       unsigned int len;
       [..]
     } else if (type == NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC) {
       unsigned int len;
       [..]
     [same pattern 8 times, so 11 times in total]
     } else if (type == NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE) {
       unsigned int len;
       [..]
     }
   }
   return 0;
}

(I didn't have to search for this, I saw the pattern in wireguard-user.c,
looked for it in nl80211-user.c and this was the first `len` usage there.)

That looks very generated, I would have `len` defined together with `type`,
and a switch statement would also look a lot more natural, but maybe leave
the if->switch conversion for the compiler to detect.

