Return-Path: <netdev+bounces-300768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v8wwJ7vJNWrQ4QYAu9opvQ
	(envelope-from <netdev+bounces-300768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 00:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 343986A7F19
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 00:59:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300768-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300768-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D63A13025F73
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C680336D4F1;
	Fri, 19 Jun 2026 22:58:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1C633EB0E
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 22:58:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781909938; cv=none; b=SNN/UTElkGh8bu6WkrjxKkjhHIhTww4gMG4zI9cpENLxIUIi/HA5VjWG8SfCzYEZM6S/2ltrFufAikhQxQRGtejHE7eT0I8CE4YuV9TbL3QLLoqXlDrXt6wklswvALO1AVJmwVLsDZEXvN8AgXFpWj45Wz4/vVPHHJowtaTvHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781909938; c=relaxed/simple;
	bh=P44btkX/5G9W5QhX0wBooqqGpL5H58AxXskj6RX48zk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i0IQwlgkrOdrzuH8wAttCKNNpQyH+PkO8vMtncjB9viz8xKPy/X6B7D5gbPcuwPM50S/HpoknyUsr+UAMzyrMpgSXJOpD1e8X6pCJplmdNokzaxAP4Y+rQC4Fau6GFMpx085An8solsn2A9oRknp6rlRzfSL3rmSPLQXd4kVDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-49222b6e871so21446995e9.3
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 15:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781909934; x=1782514734;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07lVSutuBZtSqSTP2+DZuX+nW0UInURGUViWnvtWS0g=;
        b=BH9Ka5c6Rjho+z5sucTyl2q9OdYcLSjU3k2Ye6EtKnUVOxhdD3dkWKPN59NyT2wudp
         VnsVKiOc9YQzTx/Ucl+Qb/15Yfak0i86oCM7NhXOkPtt6bV2lQHEKurf4uUwzjFu8YoK
         kCRu1qqpAejTA8DQGMm6kUR+Q5Rw7nRexTdY+kgl1G5frsr3jbdroKCyN0USO/7pDdNF
         E6IS+KYiL7OgASYpQyoL8K3+nu+rBp9kimaT7QBPHgQuD1YKBNMbq0nNLacpKYwUlY3X
         ptTsCmzWMWZ3+mJDn/ig8UlLP1Nz9qGyVXc6IY1Pcfmwr35I6S9oa+Lx6Nc397OhXEbL
         R3ZA==
X-Forwarded-Encrypted: i=1; AFNElJ+m+pVtcay6V9DgdFDQwysDSN45bOF3yrEpX+cUMrWK+LGBC7uMmxArMsy3ApnnFgw2Xcu3g6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJxWmw9E6mPbB6qlZi/A4/szV9i9SvsYS1ivPDnaPvahWBWYp
	Ia+YUehiFs0XG9jGy005Do3BHnBNS0t5DLeaWFaNJtFLdfZJbHWVeefu
X-Gm-Gg: AfdE7cnpMzNimdCEipASyiK4LEKUuKFwMPrY3bZJJKxx1HbUS9Eu9H63D7X5iQ+n5FY
	kPP32k20bolLYH/ZwNqxwPKQZ8byVi3Lf2LeDo8jNq9XqVQAx6lKoRrBiz97JypUKhuFl8hJNY7
	hlgB6Ro1FudVBACEZFVKRNGy4+bgFo79mkJmFfmpobU4/maSqiMAXd4xqRcSa3iBp8qHmYk817i
	BBCkUXMlXL+Vzrsnw7J+ldCv3itXk9g9Zk9idNfE9lsVSqls/VGJK81P1YzJWkp1qa6T/HS1YiR
	S6wvx+QxY3BiwzUaOzCiS9gu5m5X6q19U5Bq/OTI8V4nQcCJLFC4nvoyY2z+VMEcAC3AFbrEloR
	59cfrxvV/64t/iB61w4rwJij52MYLVdVn4RIWu83PAEUaGK9DgGk1ez4eMQYlqbDSGKo4Xhsoqr
	/HqBwMObSKQTcKcWEtOnlN9yPqs/OVmK3BE4ND0SyVK7JmAq3nkpYwdB8=
X-Received: by 2002:a05:600c:3e83:b0:492:3fb5:4697 with SMTP id 5b1f17b1804b1-492423140e0mr91571045e9.5.1781909934193;
        Fri, 19 Jun 2026 15:58:54 -0700 (PDT)
Received: from [192.168.88.241] (89-24-48-145.nat.epc.tmcz.cz. [89.24.48.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240eef2basm98973675e9.2.2026.06.19.15.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 15:58:53 -0700 (PDT)
Message-ID: <d967e161-f0a8-434f-9f71-a8838b8576ac@ovn.org>
Date: Sat, 20 Jun 2026 00:58:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, Johan Thomsen <write@ownrisk.dk>
Subject: Re: [PATCH net] net: dst_metadata: fix false-positive memcpy overflow
 in tun_dst_unclone
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, netdev@vger.kernel.org
References: <20260616100332.1308294-1-i.maximets@ovn.org>
 <9e941b82-23d4-44e6-a240-b7949ace76ab@embeddedor.com>
 <b16e8bac-e149-4052-b1cb-8fd3e1137f9c@ovn.org>
 <a95aabe9-6294-42ed-8327-b7d74bb4a8c8@embeddedor.com>
 <13b922ce-8450-48fd-adf7-5377989fb6e4@embeddedor.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <13b922ce-8450-48fd-adf7-5377989fb6e4@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300768-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_RECIPIENTS(0.00)[m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:llvm@lists.linux.dev,m:write@ownrisk.dk,m:gustavo@embeddedor.com,m:netdev@vger.kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[ovn.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,ownrisk.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ovn.org:email,ovn.org:mid,ovn.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 343986A7F19

On 6/18/26 6:02 AM, Gustavo A. R. Silva wrote:
> 
> 
> On 6/17/26 16:59, Gustavo A. R. Silva wrote:
>>
>>
>> On 6/17/26 16:01, Ilya Maximets wrote:
>>> On 6/17/26 10:08 PM, Gustavo A. R. Silva wrote:
>>>> Hi,
>>>>
>>>> On 6/16/26 04:03, Ilya Maximets wrote:
>>>>> kmalloc_flex() in metadata_dst_alloc() sets __counted_by for the
>>>>> structure to the options_len, which is then initialized to zero.
>>>>> Later, we're initializing the structure by copying the tunnel info
>>>>> together with the options, and this triggers a warning for a potential
>>>>> memcpy overflow, since the compiler estimates that the options can't
>>>>> fit into the structure, even though the memory for them is actually
>>>>> allocated.
>>>>>
>>>>>    memcpy: detected buffer overflow: 104 byte write of buffer size 96
>>>>>    WARNING: CPU: X PID: Y at lib/string_helpers.c:1036 __fortify_report
>>>>>     skb_tunnel_info_unclone+0x179/0x190
>>>>>     geneve_xmit+0x7fe/0xe00
>>>>
>>>> This warning has nothing to do with counted_by. See below for more
>>>> comments.
>>>>
>>>>>
>>>>> The issue is triggered when built with clang and source fortification.
>>>>>
>>>>> Fix that by doing the copy in two stages: first - the main data with
>>>>> the options_len, then the options.  This way the correct length should
>>>>> be known at the time of the copy.
>>>>>
>>>>> It would be better if the options_len never changed after allocation,
>>>>> but the allocation code is a little separate from the initialization
>>>>> and it would be awkward and potentially dangerous to return a struct
>>>>> with options_len set to a non-zero value from the metadata_dst_alloc().
>>>>>
>>>>> Another option would be to use ip_tunnel_info_opts_set(), but it is
>>>>> doing too many unnecessary operations for the use case here.
>>>>>
>>>>> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
>>>>> Reported-by: Johan Thomsen <write@ownrisk.dk>
>>>>> Closes: https://lore.kernel.org/netdev/CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com/
>>>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>>>>> ---
>>>>>
>>>>> Johan, if you can test this one in your setup as well, that would
>>>>> be great.  Thanks.
>>>>>
>>>>>    include/net/dst_metadata.h | 7 +++++--
>>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
>>>>> index 1fc2fb03ce3f..f45d1e3163f0 100644
>>>>> --- a/include/net/dst_metadata.h
>>>>> +++ b/include/net/dst_metadata.h
>>>>> @@ -164,8 +164,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>>>>>        if (!new_md)
>>>>>            return ERR_PTR(-ENOMEM);
>>>>> -    memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>>>>> -           sizeof(struct ip_tunnel_info) + md_size);
>>>>
>>>> What's going on here is that, internally, fortified memcpy() retrieves
>>>> the destination size via __builtin_dynamic_object_size() in mode 1.
>>>>
>>>> That is:
>>>>
>>>> __builtin_dynamic_object_size(&new_md->u.tun_info, 1)
>>>>
>>>> For the above case, Clang returns sizeof(new_md->u.tun_info) == 96.
>>>>
>>>> So the warning is reporting that 104 bytes don't fit in an object of
>>>> size 96 bytes, regardless of any counted_by annotation or allocation.
>>>
>>> Hmm.  Does __builtin_dynamic_object_size(&new_md->u.tun_info, 1) return
>>> 104 when the options_len is 8?  If so, isn't that because it is counted
>>> by that field?  Asking because the fortification doesn't complain if we
>>> keep the full 104-byte copy as-is, but set the options_len beforehand,
>>> as tested by Johan.
>>
>> I see. If that is the case, then, internally, fortified memcpy() ends up
>> using mode 0 instead of mode 1. Something like this:
>>
>> __builtin_dynamic_object_size(&new_md->u.tun_info, 0)
>>
>> The above will effectively consider the allocation and counted_by because
>> it will interpret new_md->u.tun_info as an open-ended object due to the
>> flexible-array member (in struct ip_tunnel_info) whose size is determined
>> by counted_by.
> 
> Indeed. The execution stops here:
> 
> fortify_memcpy_chk():
> 588         /*
> 589          * Always stop accesses beyond the struct that contains the
> 590          * field, when the buffer's remaining size is known.
> 591          * (The SIZE_MAX test is to optimize away checks where the buffer
> 592          * lengths are unknown.)
> 593          */
> 594         if (p_size != SIZE_MAX && p_size < size)
> 595                 fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
> 
> with p_size = __builtin_dynamic_object_size(&new_md->u.tun_info, 0)
> 
> The code never reaches the part where p_size_field (__bdos(&new_md->u.tun_info, 1))
> is checked at runtime because there is no need for that.
> 
> So yep, this patch is okay as-is.

Ack.  Thanks for looking into this!

Best regards, Ilya Maximets.

