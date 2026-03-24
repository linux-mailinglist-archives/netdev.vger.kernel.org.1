Return-Path: <netdev+bounces-271092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD0/LHKewmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:23:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E730A177
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B0A9300BD9C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0AC3FE364;
	Tue, 24 Mar 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ey1+pBI6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGYT1W7k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3937105D
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362154; cv=none; b=ZNOX3UnMWw3ouvWnOP4FapTsYvkbO0c0UCKekTImm48SMC3Sefs16gyqFg51wnQH+D+SvBJBbajCFCwIy73YmFQGT/mYZBLKU9/6P3+S6Q6LgUzjNEGnzhAU6+zJBfuqvGA7ZNY/oUKy+bnNTrCTYd+OUM8ULKS1KQjrdojZZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362154; c=relaxed/simple;
	bh=+JqPvqTvRGwomW9cuWWefeKqw1sh6JUr7wi3vB+GV6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fObm2JdtQUuVz+Ft0HA76wVhXxxVLh6andDRkQ+89O3Q5jiTsYK8WNDN5Nr1e58p0w2OYoLV5veRW4IMdck6BZyFsAb1DTx1e/teivFCy2nD6OjNqIKjUH+ClAn8qLZz6apE1Ak+q4WoiNabNOoqQhhymw8iM5/r8M4QxF/XtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ey1+pBI6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGYT1W7k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774362151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18KRDHLzIA9/k/+Yb4m+mZAoVSWXH3Uu2nOvFWKk2VI=;
	b=Ey1+pBI6Pw6QZYXB8xVdTWHA0awMetJWtpCRClGxTabraN/eQ1OrZm02uY+N4w5AVLFy2J
	GVJEXFaGKaWLu6CzHvo+dZkpbmp7zFO/ly2r4Z1HxBQc06Z/YAJC0VteKUI1CRWZtZxUNt
	EFY2oMv7j4DB+2snqTC8/LVKx1NflKQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Xuk_GHSqMl6RdJfAzII-gA-1; Tue, 24 Mar 2026 10:22:29 -0400
X-MC-Unique: Xuk_GHSqMl6RdJfAzII-gA-1
X-Mimecast-MFC-AGG-ID: Xuk_GHSqMl6RdJfAzII-gA_1774362148
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b3a675316so1128557f8f.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774362148; x=1774966948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18KRDHLzIA9/k/+Yb4m+mZAoVSWXH3Uu2nOvFWKk2VI=;
        b=eGYT1W7khPXZZTKZJZSdkeh6j99U+BqKeH6W0LO1CkMLDz4BqNQWB4NMN9dh+gXROL
         Y6WmL6gh1Y5EiOlac56PPzGJJ5RBm+p65CQAb9scYYLFG48P90+E/2P4/43KElcMRwVB
         EO0gMcA/CXj0NekitjqyrK0f3x+tJxqVWNFHEG5cFxq3L4V4Uil5PhJ8q78nw3YXN+0F
         q/kN00pnDFkV2QrmYm71XpdK8NSbKcaFok0KY5O4AD67Lv6N3H04nDLrHRZqOKbL6fg8
         4071tpyiqI6YfxweFrFf1PBp5FfYj088yrdsRa98XGJ+uHm+C4etW6VnjuBVVN+Ap0Sq
         yN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774362148; x=1774966948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18KRDHLzIA9/k/+Yb4m+mZAoVSWXH3Uu2nOvFWKk2VI=;
        b=JcFqB7qF/FZfPn8lWDTt3cJssBINCEDanBcMgNLhfiqbNE2G41hwyYWNKX+1qOrPbK
         CjqqrRZVOi3jyCaaDfnSzFMHY6AnxO6PHpW+4umdh05+/in7P96HyL92Vm4gCSOPbTom
         PngHpGZDD5qR88MXPHXPpnD8aAT4d2VWxyVhVYxZmdGvVqz65J5+EDW70N/Fb7eTmg28
         qN6X1S1tJWnat019Si1ubQ/TT6GkU/QaKX8PJekUHNz6XkjGrjf9yHWp9LYQGeiID4T1
         EEB3DNRh4HHrSE5yAGj7rnNQvzFeEtdA+0a8l3ae5xuDZi2bC4iMvppNj9Px5UEgVvOT
         4llA==
X-Forwarded-Encrypted: i=1; AJvYcCXij45ywwHdnzXCRI901hQD7v5MZT+9fXnGDsZJTuwP9ebPjDsgCDZPt4/F72w0Oh3kUn4mZZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0sA608JHUy7leHTpnITck6bPw0IYJOk7JG0FWKvguSB5xlfs
	sLwj7l3iyd2eXwOWsGkrA0tlNVwwdfstlp3Y1GGTG9H97V4/LaA2EMp7zYxQ5n6CsCBIgyyD2cY
	PrIBCJELZXKMltfgs7T0VBhuQjttx615/kTI1oD5xys0r45ZKaHZFljTX+rABcHUz2w==
X-Gm-Gg: ATEYQzw9WnZ89h/useN7RE6InoeZ1iOwmjPBUrxREC+WcfmFBsvdxAxwTkGqaitreep
	8EH4dNTFctdUFHVVkRr5GSkS35fJYf4Hrj6c1eJiM3rMRQiMzl/6E8R97zgEAoDO+JQyFJMfyg1
	JY9AER/7bcwDd1DoLwBaoDjbgcaP/5qBqd7wqIsMSVOiMH04HAmHMZDrH5wg6th+OQiduC6fwGm
	OkbaYewjE92nzDrojKmP6ZTQiNZw89nH+XDDdya8RS0IsxqOaQIkpx+X+U2BkoOvGKa+edZpjVV
	zgUrb8ao4EEn64quN086ED9U7vWrWXZytduHlS76tG5kZmpZIVo+b55eF8SHWhB6kUx0Hm+kLu9
	Sdknv2E4dKTddYbF7pVXeSZzd/qnwNe4FzZ2Vspjyc7p+ek6oVWMbOdtn
X-Received: by 2002:a05:6000:430e:b0:43b:63e5:2526 with SMTP id ffacd0b85a97d-43b6427db81mr25655056f8f.27.1774362147375;
        Tue, 24 Mar 2026 07:22:27 -0700 (PDT)
X-Received: by 2002:a05:6000:430e:b0:43b:63e5:2526 with SMTP id ffacd0b85a97d-43b6427db81mr25655005f8f.27.1774362146743;
        Tue, 24 Mar 2026 07:22:26 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647177e8sm37720328f8f.34.2026.03.24.07.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 07:22:26 -0700 (PDT)
Message-ID: <5ec229e2-41d8-497d-ac8d-094e07aba4f2@redhat.com>
Date: Tue, 24 Mar 2026 15:22:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/20] xfrm: iptfs: only publish mode_data after clone
 setup
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
 <20260323083440.2741292-21-steffen.klassert@secunet.com>
 <4cc9cb27-90b9-45fb-8d90-28cca9e12b96@redhat.com>
 <acJ66ndBOEs7d-1D@secunet.com>
 <75af5781-0ed2-4b05-879f-db6628af0692@redhat.com>
 <acKGU5rF-yH2LI7v@secunet.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <acKGU5rF-yH2LI7v@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271092-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1g4.org:email]
X-Rspamd-Queue-Id: 105E730A177
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 1:40 PM, Steffen Klassert wrote:
> On Tue, Mar 24, 2026 at 01:35:25PM +0100, Paolo Abeni wrote:
>> On 3/24/26 12:52 PM, Steffen Klassert wrote:
>>> On Tue, Mar 24, 2026 at 12:33:15PM +0100, Paolo Abeni wrote:
>>>> On 3/23/26 9:34 AM, Steffen Klassert wrote:
>>>>> From: Paul Moses <p@1g4.org>
>>>>>
>>>>> iptfs_clone_state() stores x->mode_data before allocating the reorder
>>>>> window. If that allocation fails, the code frees the cloned state and
>>>>> returns -ENOMEM, leaving x->mode_data pointing at freed memory.
>>>>>
>>>>> The xfrm clone unwind later runs destroy_state() through x->mode_data,
>>>>> so the failed clone path tears down IPTFS state that clone_state()
>>>>> already freed.
>>>>>
>>>>> Keep the cloned IPTFS state private until all allocations succeed so
>>>>> failed clones leave x->mode_data unset. The destroy path already
>>>>> handles a NULL mode_data pointer.
>>>>>
>>>>> Fixes: 6be02e3e4f37 ("xfrm: iptfs: handle reordering of received packets")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Paul Moses <p@1g4.org>
>>>>> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
>>>>
>>>> While applying this series to verify the PR, I get the following error:
>>>>
>>>> Applying: xfrm: iptfs: only publish mode_data after clone setup
>>>> error: sha1 information is lacking or useless (net/xfrm/xfrm_iptfs.c).
>>>> error: could not build fake ancestor
>>>> Patch failed at 0020 xfrm: iptfs: only publish mode_data after clone setup
>>>>
>>>> The above also prevents the CI from testing the series. Steffen, could
>>>> you please have a look? Possibly a repost could be needed.
>>>
>>> I guess this is due to a merge conflict with:
>>>
>>> 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
>>>
>>> Repost will not help in that case. Not sure what to do
>>> here. The only thing that would fix it is a forced rebase
>>> of the ipsec tree onto the net tree.
>>
>> Out of blatant naiveness on my side, how much of a pain would be that
>> option? If more than negligible, I guess we should avoid it.
> 
> It is some work on my side, but the bigger problem is for
> those who cloned my ipsec tree. They all need to do this
> forced rebase then. This will hit them by surprise then.
> So IMO, if we can avoid it, we should better not rebase.

Ok, pulled. It was not clear to me that the ipsec tree has stable hashes.

/P


