Return-Path: <netdev+bounces-84571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D25489760F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 19:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560EB28DEEA
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CE0152DFE;
	Wed,  3 Apr 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="mifHZt1F"
X-Original-To: netdev@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD16152DF0
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164468; cv=none; b=RR6gcpdOvypTKwrQTbJFl8qzFVMFkQXnPLhpVpjqBwzzsAw4r0g6e+O9cg9mzyBcmNH0rKF6FK4lJt4wsSLw6ZXCS/ysnp2RHxR/pucBKt5tVDqF1qhLzTT/Bfa19yWSAe4d1C3dtlhiKO8swc4pfp/quJ/2a9139kRLe/MhJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164468; c=relaxed/simple;
	bh=qmxqmlUJBz726UE7HUrKGD95zzODIeLBNvs0WCeptzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1q9E12NELjJNda0CUcLfMMeZ2oEwYiPK7tUF5/5e/RM9btYYYetnLi6tnR8+OhZnX8YZCpl07flYGgoWaVIieAoqaO6RE9RoKcEHb3ESphHOB8U8NWs1TmEWgJ3hkTdjQah0fCnyCbXVVB/86bKsvnVvSxcK2yOuURH5N5diFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=mifHZt1F; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 25993 invoked by uid 988); 3 Apr 2024 17:14:15 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 03 Apr 2024 19:14:15 +0200
Message-ID: <c4f2c217-b2bd-4716-be17-3c6097873061@david-bauer.net>
Date: Wed, 3 Apr 2024 19:14:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vxlan: drop packets from invalid src-address
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, amcohen@nvidia.com, netdev@vger.kernel.org
References: <20240331211434.61100-1-mail@david-bauer.net>
 <20240402180848.GT26556@kernel.org> <Zg1PYMUh6FCT5FQ2@shredder>
From: David Bauer <mail@david-bauer.net>
Autocrypt: addr=mail@david-bauer.net; keydata=
 xjMEZgynMBYJKwYBBAHaRw8BAQdA+32xE63/l6uaRAU+fPDToCtlZtYJhzI/dt3I6VxixXnN
 IkRhdmlkIEJhdWVyIDxtYWlsQGRhdmlkLWJhdWVyLm5ldD7CjwQTFggANxYhBLPGu7DmE/84
 Uyu0uW0x5c9UngunBQJmDKcwBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQbTHlz1Se
 C6eKAwEA8B6TGkUMw8X7Kv3JdBIoDqJG9+fZuuwlmFsRrdyDyHkBAPtLydDdancCVWNucImJ
 GSk+M80qzgemqIBjFXW0CZYPzjgEZgynMBIKKwYBBAGXVQEFAQEHQPIm0qo7519c7VUOTAUD
 4OR6mZJXFJDJBprBfnXZUlY4AwEIB8J+BBgWCAAmFiEEs8a7sOYT/zhTK7S5bTHlz1SeC6cF
 AmYMpzAFCQWjmoACGwwACgkQbTHlz1SeC6fP2AD8CduoErEo6JePUdZXwZ1e58+lAeXOLLvC
 2kj1OiLjqK4BANoZuHf/ku8ARYjUdIEgfgOzMX/OdYvn0HiaoEfMg7oB
In-Reply-To: <Zg1PYMUh6FCT5FQ2@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.990611) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.080611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=qmxqmlUJBz726UE7HUrKGD95zzODIeLBNvs0WCeptzw=;
	b=mifHZt1F6aj+cCioSUniM9XR7OQ1pYe2NtbOOXAy9ucCc5I9uAlxYhXdwXZoDXCnPS8bPsHaZy
	IbcKJUzLS7q7bDanX93LP/VpEwZYLl8hGhuTIpqfGitdMHRiZp92ixkqU12J9IdcFImoHzAxjE0i
	G6vbgc2ZXtakWGgXD/KpKEwQ3Myl++jAaEjfpHPsRcoFh5ly1NYXdSGANYpUNfyuYvgt0VwbB7vM
	xnvlgjeelK65NfOc1U3TTWogv1m5p4qU4kghWa9dqmyt1dT5mKP9e9fNo3imY8Lha1G+unc2hi+g
	Gh9CVaF47bk/VugKqDYKOpWDXaTV/YneqfbsDnkdbrlsV50GziTqHBgdzAlXeuyJx6epg/1r4YD/
	CrczZS94ZcALJ+9rXxvhSKxbcXXT750//150NhsDUNZsqWxHuOSR4OvpXBpQBgZvB0zQhqXxG++Q
	yEWKjx80hhVW+7lnuLr7/Wrl9qD2AZb6EWo2cXenqNFwsNxz+oEzS4KMmtvE5GyUAza3vkU5SZpp
	wNWGbll3wrvj7/FXWmntqkZtFBaclt+fa5xhwcOKKyQUxPw43dVoXXmy3FmBxZEpbxpkErEsl0cr
	LOp/ZbG3X0B2hS8bLOlxtMpl+aKkEGlkARgQhD8UZ5S5Sbqh6NzpnUIYX8RtLTBa4RRO0wnqgiNa
	I=

Hi Ido,

On 4/3/24 14:45, Ido Schimmel wrote:
> On Tue, Apr 02, 2024 at 07:08:48PM +0100, Simon Horman wrote:
>> On Sun, Mar 31, 2024 at 11:14:34PM +0200, David Bauer wrote:
>>> The VXLAN driver currently does not check if the inner layer2
>>> source-address is valid.
>>>
>>> In case source-address snooping/learning is enabled, a entry in the FDB
>>> for the invalid address is created with the layer3 address of the tunnel
>>> endpoint.
>>>
>>> If the frame happens to have a non-unicast address set, all this
>>> non-unicast traffic is subsequently not flooded to the tunnel network
>>> but sent to the learnt host in the FDB. To make matters worse, this FDB
>>> entry does not expire.
>>>
>>> Apply the same filtering for packets as it is done for bridges. This not
>>> only drops these invalid packets but avoids them from being learnt into
>>> the FDB.
>>>
>>> Suggested-by: Ido Schimmel <idosch@nvidia.com>
>>> Signed-off-by: David Bauer <mail@david-bauer.net>
>>
>> Hi David and Ido,
>>
>> I wonder if this is an appropriate candidate for 'net', with a Fixes tag.
>> It does seem to address a user-visible problem.
> 
> I'm OK with targeting the patch at 'net'. Looking at git history, the
> issue seems to be present since initial submission so Fixes tag should
> be:
> 
> Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
> 
> David, can you please re-submit with "[PATCH net]" prefix and the above
> tag?

I can take care of that. Thanks for analyzing the situation.

One thing i still have in my head when looking at this:

 From my understanding, when i manage to send out such a packet from e.g. a
VM connected to a vxlan overlay network and manage to send out such malformed
packet, this would allow me to break the overlay network created with vxlan doesn't it?

Can you comment on my assumption there? I assume you have a better understanding of
the inner workings of the vxlan protocol.

Best
David

> 
> Thanks

