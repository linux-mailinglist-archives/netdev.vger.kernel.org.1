Return-Path: <netdev+bounces-173522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03552A59451
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1777A240E
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA1422CBDC;
	Mon, 10 Mar 2025 12:25:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434422CBD3;
	Mon, 10 Mar 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609524; cv=none; b=tKHduWs1asSYVP4lB5dQ6SGHnQEiw1GMfiw41XZ85qdOQsyilQBathCSguMr1l9IcMp8YH0/nImtjm3jP79PJytAU39EBmcZWV9CDJjZ4TSFCtWtCoRNi4XoPhAvnB+m9BaUl00cbhpnzXvR5fniI5wIp7tJ3b4ZOccEZR3nIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609524; c=relaxed/simple;
	bh=TjOE9Xlgtr19Fasd7GSxPOe7cKx2RD6FF2ylaGumdXo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LPkwFStYkKnCvdWy6up5hcW+NcrZkCD0u5qMsuauZ4FxbHMmoA0nFxkIwPXVwEgv/RE0Ok3uRIMnZ2Eq18adB575JdJH6895mmiC+d4M7+z2z4JM3I2TvAx7m2uTfBt0DrtNG0FqdyLZIIz7RO1Qrd1HpS8OsGu0E2/Gu6/zp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so5444925e9.1;
        Mon, 10 Mar 2025 05:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741609521; x=1742214321;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLhdPnxW3Aib1tHXA2evIuN0clR2tpm3gxdkcC+TE70=;
        b=jN0E0aIV9ZiBtEGLTzdqCY9Zt/aPSV6BdNS9BvLwCS8KWAk1OOUfs7LcTlzjoiAlO2
         UnclWcvYRhl5555p1zLrAN5izGVZdZ0wX6H9xYNtahUTuZNfLnIokgQxslFpFax2G4/E
         X7tC1PRUuQ8n171Dmo9Y5sSCCxzZ47f/NwygIE5O5ZYMYNlf03eGj90LZqQydc29f0Sz
         pJPnikWRGXSe531a+tSAuQ+UJEY6QmshfEeZ/VLPG5n2+NESxIwquMmTaMBkq43bOSSJ
         mTwzScB2h6TYX3s5ztCgpvKVMJZ7tfJWkm2SRADgDcOUt9zNd1EjH8eKYCS306Sxpo2k
         wlYg==
X-Forwarded-Encrypted: i=1; AJvYcCUM9I0UfyLGiVNK3nbfKDZXKrRNYgbzgNVWeqy359HE7sXjxO3ox9gO0/bz6UczpdGTPN8hXEs6@vger.kernel.org, AJvYcCUsy9ChzPgI0iqoVuK4US0lJkp9e4sfz1stbJZkqed1bAKokM6pauqk8p+JbAKdlxdBOlMtd3l0sTgQO3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhU48wVxh6Qw+VKW/Z/7idFrozRJr6q8mSaGWwSF7Of9Dl/Vlh
	8JY60LdnbAxatXmGZzmXBMdAvSbJ8VL8GsJgjEDTWPLFN+0fYCc6qo5gjkd9
X-Gm-Gg: ASbGncv5DNkq6JUCZIW4bJEuwg3xKmIfZBJ+KTQ6ybVUxNm298kZd1sxQclOEALcjlx
	dYq6jPPwQZRRZRFPf2UN551TJU2x2DNWNNVMnz/Wxzu3BfEStiPGeWLk4P2XrMIFqC/RMq8exWu
	3QfkMdLglPL7jOdBsNb/bU1ZQJ0yB3WXdc25ZahO9o+cImqSXEC4Vuo6y5Rw47uY608ROCGpTIh
	A46lu9d1dQJfKQQRzZHv5Fr+Mr5X+2M5Dn0BCr4R2zTkWuDOYCHDjrOslU1g4LeJOU6evvWGtXk
	z+UpFajYKYLKc+/vjdowcze3dWkQrKEC/RdfTZKCLPQpnpFpKhqLAnrxyl0LMWFO1mrl5SiHW1V
	7
X-Google-Smtp-Source: AGHT+IEb+zyP4juANAeJTKrmCaoH+cXYIs0c9fGOdQyb78d4JTjyg5JpEUCkqWOhuS8YttYbuYDdxw==
X-Received: by 2002:a5d:64ab:0:b0:390:f9d0:5e7 with SMTP id ffacd0b85a97d-3913af025b1mr6177153f8f.13.1741609520468;
        Mon, 10 Mar 2025 05:25:20 -0700 (PDT)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0193bfsm14988629f8f.55.2025.03.10.05.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 05:25:20 -0700 (PDT)
Message-ID: <573e20ec-5b85-4b11-b479-d149e5c434b0@ovn.org>
Date: Mon, 10 Mar 2025 13:25:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
 Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [PATCH net] net: openvswitch: remove misbehaving actions length
 check
To: Aaron Conole <aconole@redhat.com>
References: <20250308004609.2881861-1-i.maximets@ovn.org>
 <f7tmsdv2ssx.fsf@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <f7tmsdv2ssx.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 21:03, Aaron Conole wrote:
> Ilya Maximets <i.maximets@ovn.org> writes:
> 
>> The actions length check is unreliable and produces different results
>> depending on the initial length of the provided netlink attribute and
>> the composition of the actual actions inside of it.  For example, a
>> user can add 4088 empty clone() actions without triggering -EMSGSIZE,
>> on attempt to add 4089 such actions the operation will fail with the
>> -EMSGSIZE verdict.  However, if another 16 KB of other actions will
>> be *appended* to the previous 4089 clone() actions, the check passes
>> and the flow is successfully installed into the openvswitch datapath.
>>
>> The reason for a such a weird behavior is the way memory is allocated.
>> When ovs_flow_cmd_new() is invoked, it calls ovs_nla_copy_actions(),
>> that in turn calls nla_alloc_flow_actions() with either the actual
>> length of the user-provided actions or the MAX_ACTIONS_BUFSIZE.  The
>> function adds the size of the sw_flow_actions structure and then the
>> actually allocated memory is rounded up to the closest power of two.
>>
>> So, if the user-provided actions are larger than MAX_ACTIONS_BUFSIZE,
>> then MAX_ACTIONS_BUFSIZE + sizeof(*sfa) rounded up is 32K + 24 -> 64K.
>> Later, while copying individual actions, we look at ksize(), which is
>> 64K, so this way the MAX_ACTIONS_BUFSIZE check is not actually
>> triggered and the user can easily allocate almost 64 KB of actions.
>>
>> However, when the initial size is less than MAX_ACTIONS_BUFSIZE, but
>> the actions contain ones that require size increase while copying
>> (such as clone() or sample()), then the limit check will be performed
>> during the reserve_sfa_size() and the user will not be allowed to
>> create actions that yield more than 32 KB internally.
>>
>> This is one part of the problem.  The other part is that it's not
>> actually possible for the userspace application to know beforehand
>> if the particular set of actions will be rejected or not.
>>
>> Certain actions require more space in the internal representation,
>> e.g. an empty clone() takes 4 bytes in the action list passed in by
>> the user, but it takes 12 bytes in the internal representation due
>> to an extra nested attribute, and some actions require less space in
>> the internal representations, e.g. set(tunnel(..)) normally takes
>> 64+ bytes in the action list provided by the user, but only needs to
>> store a single pointer in the internal implementation, since all the
>> data is stored in the tunnel_info structure instead.
>>
>> And the action size limit is applied to the internal representation,
>> not to the action list passed by the user.  So, it's not possible for
>> the userpsace application to predict if the certain combination of
>> actions will be rejected or not, because it is not possible for it to
>> calculate how much space these actions will take in the internal
>> representation without knowing kernel internals.
>>
>> All that is causing random failures in ovs-vswitchd in userspace and
>> inability to handle certain traffic patterns as a result.  For example,
>> it is reported that adding a bit more than a 1100 VMs in an OpenStack
>> setup breaks the network due to OVS not being able to handle ARP
>> traffic anymore in some cases (it tries to install a proper datapath
>> flow, but the kernel rejects it with -EMSGSIZE, even though the action
>> list isn't actually that large.)
>>
>> Kernel behavior must be consistent and predictable in order for the
>> userspace application to use it in a reasonable way.  ovs-vswitchd has
>> a mechanism to re-direct parts of the traffic and partially handle it
>> in userspace if the required action list is oversized, but that doesn't
>> work properly if we can't actually tell if the action list is oversized
>> or not.
>>
>> Solution for this is to check the size of the user-provided actions
>> instead of the internal representation.  This commit just removes the
>> check from the internal part because there is already an implicit size
>> check imposed by the netlink protocol.  The attribute can't be larger
>> than 64 KB.  Realistically, we could reduce the limit to 32 KB, but
>> we'll be risking to break some existing setups that rely on the fact
>> that it's possible to create nearly 64 KB action lists today.
>>
>> Vast majority of flows in real setups are below 100-ish bytes.  So
>> removal of the limit will not change real memory consumption on the
>> system.  The absolutely worst case scenario is if someone adds a flow
>> with 64 KB of empty clone() actions.  That will yield a 192 KB in the
>> internal representation consuming 256 KB block of memory.  However,
>> that list of actions is not meaningful and also a no-op.  Real world
>> very large action lists (that can occur for a rare cases of BUM
>> traffic handling) are unlikely to contain a large number of clones and
>> will likely have a lot of tunnel attributes making the internal
>> representation comparable in size to the original action list.
>> So, it should be fine to just remove the limit.
>>
>> Commit in the 'Fixes' tag is the first one that introduced the
>> difference between internal representation and the user-provided action
>> lists, but there were many more afterwards that lead to the situation
>> we have today.
>>
>> Fixes: 7d5437c709de ("openvswitch: Add tunneling interface.")
>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>> ---
> 
> Thanks for the detailed explanation.  Do you think it's useful to
> check with selftest:
> 
>    # python3 ./ovs-dpctl.py add-dp flbr
>    # python3 ./ovs-dpctl.py add-flow flbr \
>      "in_port(0),eth(),eth_type(0x806),arp()" \
>      $(echo 'print("clone(),"*4089)' | python3)
> 
> I think a limit test is probably a good thing to have anyway (although
> after this commit we will rely on netlink limits).

I had a similar thought, but as you said, this commit will remove the limit
so we'll not really be testing OVS code at this point.  So, I thought it
may be better to not include such a test for easier backporting to older
kernels (given the Fixes tag goes far back).   But I agree that it's a good
thing in general to have tests that cover maximum size cases, so maybe we
can add something like this to net-next instead, once the fix is accepted?

Note: 4089 is too small for such a test, it should be somewhere around 16K.

> 
> 
> Reviewed-by: Aaron Conole <aconole@redhat.com>
> 

Thanks for review!

Best regards, Ilya Maximets.

