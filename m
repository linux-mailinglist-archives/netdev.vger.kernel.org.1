Return-Path: <netdev+bounces-108391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A8C923ABF
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B411F22CD3
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF238156C69;
	Tue,  2 Jul 2024 09:53:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A50155C90;
	Tue,  2 Jul 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913994; cv=none; b=VX70HXenJP+pxVYXsfPBE5IyHoEL0065ySUoXbD2A0wLVyK0aMwNfckEB6gTW9QwtCGUHjnbD7azV2R4x2Bh0eDCPh9lMVK11KGjg+Vo1YND1UDBPEr0UCW6ZId+FyU58eZQ9st5gtVEC49zxluLiLtusiInV7vVbDQocFBmhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913994; c=relaxed/simple;
	bh=05Y0Y8bWhUd/xPS8FWSfPwW7fc1njuZTbn06uYLuB2o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O7L9Vab4H8px1ZwjzMq3NItxikDWPacRgB1TYfSC3e/O+g2tLu78CWtuHNY/0ELqc/qcA3uWwmvaC+WmqM2YDiajIYIkY1YTqa8wsLl5M1KLWMpoQ7cqgAMRMukQ9e4go8RDuRprbGlGtJzniGwmoW67eXixn9PfBc3HjmDJz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECE52C0007;
	Tue,  2 Jul 2024 09:53:02 +0000 (UTC)
Message-ID: <447c0d2a-f7cf-4c34-b5d5-96ca6fffa6b0@ovn.org>
Date: Tue, 2 Jul 2024 11:53:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 netdev@vger.kernel.org, echaudro@redhat.com, dev@openvswitch.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 05/10] net: openvswitch: add psample action
To: Simon Horman <horms@kernel.org>, =?UTF-8?Q?Adri=C3=A1n_Moreno?=
 <amorenoz@redhat.com>
References: <20240630195740.1469727-1-amorenoz@redhat.com>
 <20240630195740.1469727-6-amorenoz@redhat.com> <f7to77hvunj.fsf@redhat.com>
 <CAG=2xmOaMy2DVNfTOkh1sK+NR_gz+bXvKLg9YSp1t_K+sEUzJg@mail.gmail.com>
 <20240702093726.GD598357@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20240702093726.GD598357@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org

On 7/2/24 11:37, Simon Horman wrote:
> On Tue, Jul 02, 2024 at 03:05:02AM -0400, Adrián Moreno wrote:
>> On Mon, Jul 01, 2024 at 02:23:12PM GMT, Aaron Conole wrote:
>>> Adrian Moreno <amorenoz@redhat.com> writes:
> 
> ...
> 
>>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> 
> ...
> 
>>>> @@ -1299,6 +1304,39 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
>>>>  	return 0;
>>>>  }
>>>>
>>>> +#if IS_ENABLED(CONFIG_PSAMPLE)
>>>> +static void execute_psample(struct datapath *dp, struct sk_buff *skb,
>>>> +			    const struct nlattr *attr)
>>>> +{
>>>> +	struct psample_group psample_group = {};
>>>> +	struct psample_metadata md = {};
>>>> +	const struct nlattr *a;
>>>> +	int rem;
>>>> +
>>>> +	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
>>>> +		switch (nla_type(a)) {
>>>> +		case OVS_PSAMPLE_ATTR_GROUP:
>>>> +			psample_group.group_num = nla_get_u32(a);
>>>> +			break;
>>>> +
>>>> +		case OVS_PSAMPLE_ATTR_COOKIE:
>>>> +			md.user_cookie = nla_data(a);
>>>> +			md.user_cookie_len = nla_len(a);
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	psample_group.net = ovs_dp_get_net(dp);
>>>> +	md.in_ifindex = OVS_CB(skb)->input_vport->dev->ifindex;
>>>> +	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
>>>> +
>>>> +	psample_sample_packet(&psample_group, skb, 0, &md);
>>>> +}
>>>> +#else
>>>> +static inline void execute_psample(struct datapath *dp, struct sk_buff *skb,
>>>> +				   const struct nlattr *attr) {}
>>>
>>> I noticed that this got flagged in patchwork since it is 'static inline'
>>> while being part of a complete translation unit - but I also see some
>>> other places where that has been done.  I guess it should be just
>>> 'static' though.  I don't feel very strongly about it.
>>>
>>
>> We had a bit of discussion about this with Ilya. It seems "static
>> inline" is a common pattern around the kernel. The coding style
>> documentation says:
>> "Generally, inline functions are preferable to macros resembling functions."
>>
>> So I think this "inline" is correct but I might be missing something.
> 
> Hi Adrián,
> 
> TL;DR: Please remove this inline keyword
> 
> For Kernel networking code at least it is strongly preferred not
> to use inline in .c files unless there is a demonstrable - usually
> performance - reason to do so. Rather, it is preferred to let the
> compiler decide when to inline such functions. OTOH, the inline
> keyword in .h files is fine.

FWIW, the main reason for 'inline' here is not performance, but silencing
compiler's potential 'maybe unused' warnings:

 Function-like macros with unused parameters should be replaced by static
 inline functions to avoid the issue of unused variables

I think, the rule for static inline functions in .c files is at odds with
the 'Conditional Compilation' section of coding style.  The section does
recommend to avoid conditional function declaration in .c files, but I'm not
sure it is reasonable to export internal static functions for that reason.

In this particular case we can either define a macro, which is discouraged
by the coding style:

 Generally, inline functions are preferable to macros resembling functions.

Or create a static inline function, that is against rule of no static
inline functions in .c files.

Or create a simple static function and mark all the arguments as unused,
which kind of compliant to the coding style, but the least pretty.

Best regards, Ilya Maximets.

