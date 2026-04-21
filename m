Return-Path: <netdev+bounces-280230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC+5MrLT52kzBQIAu9opvQ
	(envelope-from <netdev+bounces-280230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:44:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D168143F133
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94BAD30046B1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7B43DD501;
	Tue, 21 Apr 2026 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwoYtd5P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E937F8C1
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800685; cv=none; b=efT8FMtOcUyGBLBjLIBkNH63rrkGfxGwokI7S4bU1+HBoZHNRXPwbzpnE1mBn+OAK3czsFVyl8zJGPC3o5nKxdyGnEr7yzE5LNfCy+u8SoG2oDl40aHMmH9ohtgHAMN4vw8Qvl2ThPuLNtX0WHbA9Kj9K3EOo/pZ7PmzLFInSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800685; c=relaxed/simple;
	bh=tsOgYJLQMBNXdjtq9nILBb554UufCmVscFZPO0StRs4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CDDuxNNYfCnpTfipx7/qBHM8dVSwKwdK1RQJRhV0g+v3cU6q5u01c34MAjJCjUwhWXXECk7wem/W2of7PxvGktp3rJlyQ75HFASN5lVKhUaYwC7/yfb5x6Eb8hpPYP2X4qkRSrmy/0x6zydQen0udGviYyW/WV2C9WZlyv9ShfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwoYtd5P; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12db2e415a7so705503c88.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776800683; x=1777405483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsOgYJLQMBNXdjtq9nILBb554UufCmVscFZPO0StRs4=;
        b=ZwoYtd5P55E7HC0pP5/KdtMk+nBgh0Jcij6xDRjhcHdXyWlK93L2Oiz1+h5DtdO88+
         Dwn/5HLr2mymAEreuWVJkFMIVvtElRA2B/u6roX12RVmChyFoQNX5PSb8xL5q5b2lkKb
         b9CZ/JZkmoUakxPKD6XAysvQvHyd2hq2vyz0G3aXCjRNhVK/Sja1hV7gXEixOHtyZ+Kn
         OyNIM8AooVfbSeoWagB35Bwn08QttHowx9hX+lpAn3ihri+knHW1yvsrOsC7IDqmCWBF
         VZtlmokea+4lcEqYdKkSGdzHub8A2M65chDwK3OV2qTsCRVrSlTYvDKZMMt0ELcgxwD+
         VzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776800683; x=1777405483;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsOgYJLQMBNXdjtq9nILBb554UufCmVscFZPO0StRs4=;
        b=kLMWXFkKFHEARAqaDa/+ZDvf3f63rnmTwQ78AuDZC9Oyl82UpxxS7PeWCDRIO5dWS0
         7mL6FocD7a/IWwQkGGn3ka0nfuS5ooKQsjgB2f/AtiLmAMdYWiG1MkWz3Svqbqoh/ylR
         VGPMbOPZlWU86Zm+YAgibPxLFWShCrEFSzfTvxbhfTkBmKcYJfiPNu8TgdSJzWMtJhBh
         TzYgnldJoimnyWH9DwX8gMs0p8IlXiqctJF7YZMzNKcttUywVp2dxhGPJvNOMt0E4Ua1
         ZZVFUZnYzMFPAiRzDYRxKv7M9mq+UU7H+10Cmduag2JP4d7F4se8HntwORx89/+oalYn
         +dkA==
X-Forwarded-Encrypted: i=1; AFNElJ/pmVd3T6aSyOV5S77mQ45S3ODmw478vFTq/rxvGXaLHrjupzcsPJiF3+WNzJuxblMnvzm4tZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjYZgWxqfkTPALScULiBJx6Jf/bvdTe+I1/WqDuV6Gx1xMfIkx
	L2L4/yF0w6o8J2VpJqgZXIgcZmJljkeveDuEPZfFKeFVnzAeSf8cWrsc
X-Gm-Gg: AeBDiesfKNkYcolFMurX2DPOswhAHJ3p+7Z0+prthCiZg5MiTytLVQfNn8N3aIRGpCv
	ISDYYMuyjQ7mhXYcEH3dPNKZXzx0hoPVlT9myy+vap8tHtPtN+vo4egQFAWN9dk3TxqET0OH0Bf
	Hjo8OqH69q9zfySbUYvzD3d5+rHGkX3zMj3LCNwZKSr6WKx5wYd1kGsr+KVvPlDu16V7LIuZG7R
	pIb5iSWEEcO5g+ESHOQMSgnyTSqAgudP8Biyz3VwJperxW5w5z7i3IW0ZEIOxZTC2zxB3nWR238
	2WxIfwa4f7dVpi/Z3QDwjS6dZEyKeYaMz4L6tOYhprfnjW1Sr2seZmgK9nh0cywOcWikRuwHyTU
	SQfc/+CS9QabxUBm7r3cziFMQz34E50kvv3gVx+0+dJTQijYU1QHKl4XQPb6QTD/uhyrBWh9Ij5
	pUe73iAZ/LzC+V5F/+/MIlOsJT71nCaQ3lJdeWfrG6HN1c/Zg=
X-Received: by 2002:a05:7022:69a:b0:119:e55a:9c03 with SMTP id a92af1059eb24-12c73f9fc27mr9469128c88.31.1776800682510;
        Tue, 21 Apr 2026 12:44:42 -0700 (PDT)
Received: from [10.0.0.2] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a2ac32sm20775919c88.15.2026.04.21.12.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 12:44:42 -0700 (PDT)
Message-ID: <676ac55c-1549-40a7-9a0c-c69e472417e1@gmail.com>
Date: Tue, 21 Apr 2026 12:44:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yuantan098@gmail.com, netdev@vger.kernel.org, idosch@mellanox.com,
 dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 royenheart@gmail.com
Subject: Re: [PATCH net v3 1/1] net: l3mdev: Reject non-L3 uppers in slave
 helpers
To: Ido Schimmel <idosch@nvidia.com>, Ren Wei <n05ec@lzu.edu.cn>
References: <20260419145332.3988923-1-n05ec@lzu.edu.cn>
 <20260420113208.GA972415@shredder> <20260420182640.GA1027405@shredder>
 <20260421091039.GA1085009@shredder>
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <20260421091039.GA1085009@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,mellanox.com,kernel.org,davemloft.net,google.com,redhat.com,resnulli.us,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-280230-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,lzu.edu.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D168143F133
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/21/2026 2:10 AM, Ido Schimmel wrote:
> On Mon, Apr 20, 2026 at 09:26:50PM +0300, Ido Schimmel wrote:
>> On Mon, Apr 20, 2026 at 02:32:08PM +0300, Ido Schimmel wrote:
>>> On Sun, Apr 19, 2026 at 10:53:32PM +0800, Ren Wei wrote:
>>>> From: Haoze Xie <royenheart@gmail.com>
>>>>
>>>> Several l3mdev slave-side helpers resolve an upper device and then use
>>>> l3mdev_ops without first proving that the resolved device is still a
>>>> valid L3 master.
>>>>
>>>> During slave transition, an RCU reader can transiently observe an upper
>>>> that is not an L3 master. Guard the affected slave-resolved paths by
>>>> requiring the resolved upper to still be an L3 master before using
>>>> l3mdev_ops, while keeping existing L3 RX handler providers intact.
>>>>
>>>> Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
>>>> Cc: stable@kernel.org
>>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>>> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>>>> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>>>> Suggested-by: Xin Liu <bird@lzu.edu.cn>
>>>> Tested-by: Haoze Xie <royenheart@gmail.com>
>>>> Signed-off-by: Haoze Xie <royenheart@gmail.com>
>>>> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
>>> I think it's fine for net:
>>>
>>> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>> Thought about this again. I would like to check another approach
>> (synchronize_net() after clearing IFF_L3MDEV_SLAVE). Will update
>> tomorrow.
> Sorry about the back and forth, but I thought about it again last night
> and I think that this is a better fix:
>
> https://github.com/idosch/linux/commit/e67517758ebcddf8a1b97817e4ab0fbf82f467fe.patch
>
> It's a minimal fix in the control plane of the VRF driver which doesn't
> add more checks in the data path. I can submit it later this week unless
> there are objections.

Thank for you time and review!

Btw could you add a Reported-by: Yuan Tan <yuantan098@gmail.com>? Thanks.


