Return-Path: <netdev+bounces-238034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53466C52FF0
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 841C635797F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738634EF0B;
	Wed, 12 Nov 2025 15:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29B33FE09
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959738; cv=none; b=GP4xu79Zfr87HT65ekV2EFmxPLMtH8BwDNSJvG+9r3RU3el/wxgcfJRILTrZUdRXrBdYlyVmTeCwQvar+sscayJub2M8bmmkIFYjpz03qzouwU1N8F7gyX1jBFxBtgj5EAlp6+7n5stGf/v0MI3UU9bTGm7TlpN5/jQ6eKLSrhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959738; c=relaxed/simple;
	bh=76WOkOFmx5HcPz2/+WOxmZx3STvSda5HgKEFtk9Msys=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bz2MclyIgVxWNwFav6FfJKixgqxPfpyjOudEPS3OqHGCqqGGCFuwtwxoGPeUx5z/CTbCsaCG9GCu2k4bgYsbdQytj1zP3Uu2SA8S9BTqf02gWxZrNzuj/+ZRFdnGfhiEfof6rrP85w4e6pPNCrLQhrlMeBqd7Q2EyzTiqAwOs60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6419e6dab7fso1321910a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959735; x=1763564535;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pst5SkWia0cZgdHzFsRJJzRo6QJIMQW2fySl9P02AaE=;
        b=BbTpmVQqTbgK1BKAUzrTfgE3QNOs4rVVo+u15WexQhXLRWqRSg5cNftugNsLpmYB++
         pgoGh1mYs9jinNHTSthZnkV2I9OuP+XzPBRW0TOOKL5V3XC3sQfpgJ+Q/o4OE2PVRPBt
         VaMdz2us+Sxfr91Z6EmSbthvjznjHXY8bcYoitbjZndjMC3xXTeTdHgciob5EOXOzFnd
         48HmMt299WNLXtB6sP8eDoPMDqt8eDJYs4x0pC8BAqpMqF5+aI9+HckT5bzAx8zYzw8y
         PBjjAlNvWxcRuwpV799rfGeelxDKBzkdUD2FwXNLnq0u9GEOgrxYzv/1G2R6vC5g9Tm3
         xqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTMKUQJMCr4mPgO82FVvv08K5HNY5kBqjJEDCaSfT7fp+oDeqf+7/Vq7BQrKSsjVv23u/Yx1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaj34BU8cPzeKfaTuDbmF18NZ3Dc9NxxFEBj+OGLsO1XuBhysk
	S+f48i1jq2AwbHIQOD1V0khbDK1qNbzMEWzQyN4Pgpc7poThUfewpuBx
X-Gm-Gg: ASbGncslkfq7AwIDLcJmtyvFDZF3GYg9Y+vL72yJzbKUOrkSnooBujG2uJoduiuuTrh
	kBcAQGGnzP+0UzCTMDhruOeUYneheCusXoej5wqs8UcOalswdzHh35NIt0fENPdNG1euv9XZvQg
	bfo0IlX3cLK7Q7l5N8EBbbQsFBBs6VWp4bsDDHFq1TPD86hIIv+/5wkeDNqv5YJi0Bb2YlLLU1U
	pk0Y3j6NDFq7ii+j6L850vqNhUVh4JhXPDQIgKtKgd3p2cvAh2XQ1faDUAv92m4QRvWIFC3HpVe
	VbAH/siyNYjychFQAucQkE1seLy0lmXPBdx6LJdmivZbfrNvYmhp621pE1DpZrdCKY3LQvYckH3
	YDXkRyQ65uvnBIT74CCnX0YM4TZ5bc0jXHF1w99pV1oYxoTxaoPhwVXVAoZILih7s5GqgZ9SdyQ
	onprVCn4+vL9EfvznG0ecsROqqNndODx8Y
X-Google-Smtp-Source: AGHT+IHzAExwmrSf2pmu8F5uvYvSiYIwYH5UZpdI88bJJRdLJg1EV9wMU4FYm3KyF6GjRxoYGQ385w==
X-Received: by 2002:a17:907:1c9f:b0:b6d:c44a:b69b with SMTP id a640c23a62f3a-b7331a6f6ffmr327471466b.35.1762959732872;
        Wed, 12 Nov 2025 07:02:12 -0800 (PST)
Received: from [192.168.88.248] (89-24-34-247.nat.epc.tmcz.cz. [89.24.34.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d3c0sm1675933966b.36.2025.11.12.07.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 07:02:11 -0800 (PST)
Message-ID: <76c06786-ba21-494e-a0bb-eccf1f547b28@ovn.org>
Date: Wed, 12 Nov 2025 16:02:07 +0100
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
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 dev@openvswitch.org, Eelco Chaudron <echaudro@redhat.com>,
 Willy Tarreau <w@1wt.eu>, LePremierHomme <kwqcheii@proton.me>,
 Junvy Yang <zhuque@tencent.com>
Subject: Re: [PATCH net] net: openvswitch: remove never-working support for
 setting nsh fields
To: Aaron Conole <aconole@redhat.com>
References: <20251112112246.95064-1-i.maximets@ovn.org>
 <f7ty0obfgg2.fsf@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <f7ty0obfgg2.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 3:55 PM, Aaron Conole wrote:
> Ilya Maximets <i.maximets@ovn.org> writes:
> 
>> The validation of the set(nsh(...)) action is completely wrong.
>> It runs through the nsh_key_put_from_nlattr() function that is the
>> same function that validates NSH keys for the flow match and the
>> push_nsh() action.  However, the set(nsh(...)) has a very different
>> memory layout.  Nested attributes in there are doubled in size in
>> case of the masked set().  That makes proper validation impossible.
>>
>> There is also confusion in the code between the 'masked' flag, that
>> says that the nested attributes are doubled in size containing both
>> the value and the mask, and the 'is_mask' that says that the value
>> we're parsing is the mask.  This is causing kernel crash on trying to
>> write into mask part of the match with SW_FLOW_KEY_PUT() during
>> validation, while validate_nsh() doesn't allocate any memory for it:
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000018
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 1c2383067 P4D 1c2383067 PUD 20b703067 PMD 0
>>   Oops: Oops: 0000 [#1] SMP NOPTI
>>   CPU: 8 UID: 0 Kdump: loaded Not tainted 6.17.0-rc4+ #107 PREEMPT(voluntary)
>>   RIP: 0010:nsh_key_put_from_nlattr+0x19d/0x610 [openvswitch]
>>   Call Trace:
>>    <TASK>
>>    validate_nsh+0x60/0x90 [openvswitch]
>>    validate_set.constprop.0+0x270/0x3c0 [openvswitch]
>>    __ovs_nla_copy_actions+0x477/0x860 [openvswitch]
>>    ovs_nla_copy_actions+0x8d/0x100 [openvswitch]
>>    ovs_packet_cmd_execute+0x1cc/0x310 [openvswitch]
>>    genl_family_rcv_msg_doit+0xdb/0x130
>>    genl_family_rcv_msg+0x14b/0x220
>>    genl_rcv_msg+0x47/0xa0
>>    netlink_rcv_skb+0x53/0x100
>>    genl_rcv+0x24/0x40
>>    netlink_unicast+0x280/0x3b0
>>    netlink_sendmsg+0x1f7/0x430
>>    ____sys_sendmsg+0x36b/0x3a0
>>    ___sys_sendmsg+0x87/0xd0
>>    __sys_sendmsg+0x6d/0xd0
>>    do_syscall_64+0x7b/0x2c0
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> The third issue with this process is that while trying to convert
>> the non-masked set into masked one, validate_set() copies and doubles
>> the size of the OVS_KEY_ATTR_NSH as if it didn't have any nested
>> attributes.  It should be copying each nested attribute and doubling
>> them in size independently.  And the process must be properly reversed
>> during the conversion back from masked to a non-masked variant during
>> the flow dump.
>>
>> In the end, the only two outcomes of trying to use this action are
>> either validation failure or a kernel crash.  And if somehow someone
>> manages to install a flow with such an action, it will most definitely
>> not do what it is supposed to, since all the keys and the masks are
>> mixed up.
>>
>> Fixing all the issues is a complex task as it requires re-writing
>> most of the validation code.
>>
>> Given that and the fact that this functionality never worked since
>> introduction, let's just remove it altogether.  It's better to
>> re-introduce it later with a proper implementation instead of trying
>> to fix it in stable releases.
>>
>> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
>> Reported-by: Junvy Yang <zhuque@tencent.com>
>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>> ---
> 
> Thanks, this makes sense to me.  As you noted, the "fix" (I don't really
> know if it is the right word since the functionality never worked) is
> quite complex, and still might not be 'good enough' to not have further
> issues.  It makes more sense not to try and support something that never
> worked to begin with - especially since even in the userspace side we
> never really did a set(nsh()) thing (because it doesn't exist as
> functionality).

The functionality exists in userspace, ovs-vswitchd is able to create
set(nsh()) actions when set_field OpenFlow actions are used.  It doesn't
work with the kernel datapath, since the implementation inside the kernel
is broken, but it works with userspace datapath.  So, just to clarify,
the implementation on userspace side does exist.  It's not ideal, has its
own bugs and doesn't work for kernel datapath, obviously, but it exists.

Best regards, Ilya Maximets.

> 
> Reviewed-by: Aaron Conole <aconole@redhat.com>

