Return-Path: <netdev+bounces-247605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 406F5CFC448
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFE993002166
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632CD1A9F9F;
	Wed,  7 Jan 2026 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="U2m48U+t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18E49659
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769239; cv=none; b=pgcmLaoM5BGWYQsUMzGfzOrJLa4cZFfZwUe0lO82huwUTJWR/scqa8vjstI/EokdeQOq9ZKTPHj50815AcmGp3YHUab7PEd5dS1TwqN9RBOtgB8g1R0IkEJxhPR2hy8SGlNCtKKzJhjeWN48LxjoOdJSD/tAPlsi8qFvcQxaoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769239; c=relaxed/simple;
	bh=+NELbcuBKSb2gmNJgfVKtjLLulo/N6LU3MMpLJeiNVI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XBFHIHPTp/dHMWlH698SsGuMtRDhL9JJtliyhyVb9WTJatWK2YEzQjCh8yx2tFvfmVKiVbz6EAQsLbiVe5E2I0rMWEgIc03nAiqg3ZNG/gEZqExiQl8RYr5Wn8b942OC+GAQUN9jumY22oG9+BmKNrE8H85oGEHvdnNhHFjxliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=U2m48U+t; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso14009455e9.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1767769236; x=1768374036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fPRISrW7nU2tESwo5DtOtFxjqkVVlfwlqVRPtNAmMRw=;
        b=U2m48U+tQNpHbcvVYjvx2Hc4END3kDceql7zjYRL1URjjavAg2dXD7LhaAhiOHiXCM
         C682EM2LQi/aXAOODFd/LT38pZKO4loF9DM9FOY3i5CkMNosEncE1wcWnN9M9+P8R0VZ
         3Y2cbkSHnp68oXokiba+6L86ImSe2Lw50sMWjisjNqFdze4lnk2s/uunA02cD8JQiUwk
         lmncBVYJEsNx4tndJW0lROalwLft8ik9RvBZODmyYneGufnc9rJIaFr/K2SVYtSrcK0b
         UNRpFJQVfSm5GmbBeDOdxzLMHDv+4GYuXfETEXyp+RxsY1gs2EjBSzlhlnmNDNYG6H8O
         XjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767769236; x=1768374036;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPRISrW7nU2tESwo5DtOtFxjqkVVlfwlqVRPtNAmMRw=;
        b=POtBW43qrLbPcQPxbgWztvoI67PkGxczTNOgMOB0TgSg6/psv3CZ7Tlesfit4lsdd+
         g7OplsLN25UgPVl1M20MY8yBly26+8iHXYey06hT3bKcwCh+HJM3WL62ITlNmmA20h9T
         VOCaKHt16gOPYtFL1FeCMv4uVy4W9J1M0zBd+J2ds5/zBOouDgc1of9T7v4RIpxxZVxW
         eAlq0EFOiEOA2m1svSfqHqH+AlWhjgR8CaqzUL6RHrV4QsCbK27sgJbSU/bThPB2hTed
         R630dlrJiTmt1O24TYr1w0toGbXyO2QHVQrcIQbjvy4NkbcalDha5sXs1gAuhJuq8tvK
         ZiUg==
X-Forwarded-Encrypted: i=1; AJvYcCXHtOHZ5QoGU5zamYHN2ZisRQ/sMEvQ+Qwb4VyoXgrb/bU7jP9Od/u4XXVRAPXeRCIWLk+l2yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDQnJTsPJ/GSIzjdGCmPypSFCVhKklh3kHjpZ+7oHl1gJf3yd
	QSSgICEu0VPYlQQMAsjDcAepkmNnyuHguLzBGKjt1TCBGjVayQ86sL/m+P+TmbI50dU=
X-Gm-Gg: AY/fxX7WUw4JkqyH/FpnTNdjOxIFgoYlg/fZ5yInb7QgtQaty1cvEf037hx+bCU+Wuy
	jvAIzWMEfbV+OQ0bZLg+saWiJ74K20uj/VHjIxyuZPDfjfuWFwiqmlEKOeuEOXao5yQm1EzA31z
	VhLuQaYFTzR4Dy+ePFOqgknqQIyQVrGQsV9ax4vJmQklASmH3XfeKD5cODQKZYEwJLjf9EYMuoo
	9mc++vFf83YzYhzFX0P5yMhhDMmIXPNAEtXb3R75Nj03Dw43vIDYZOeR3JMMHUkg+r8XNpZb01j
	3pIcHi13IL33IutB9YeIlwvkFxuaBJi/BGUoTRMpwsYK8nFzIXc5GcbxusZAtNMD4ShNPkIJovC
	MZRu121FWVxlBLFKXnzvxx5WYm94FyLA9hU+FxujQ+i8XA1TBs2MgZdrS8/otfJqeJZ4GlhEkdc
	hRbYX/4xInWP3vtg5HPwqiqqvDovDIgigJ26KPq+/SCExuI12wvonHZKLZd3gUkN7tQOm8Nw==
X-Google-Smtp-Source: AGHT+IHC2bxc9oZ/9sT9c/UleScErjee7L1YpakJzlTBr2Rs7cjhA/5xwJR5t06vB/s4t7uYLRnBxw==
X-Received: by 2002:a05:600c:5298:b0:47d:6140:3284 with SMTP id 5b1f17b1804b1-47d84b40804mr11435785e9.37.1767769235678;
        Tue, 06 Jan 2026 23:00:35 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86637b90sm6401795e9.2.2026.01.06.23.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 23:00:35 -0800 (PST)
Message-ID: <6a7cb6d7-b337-4b21-b236-5419b785dc90@blackwall.org>
Date: Wed, 7 Jan 2026 09:00:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: annotate data-race in br_fdb_update()
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260106194022.2133543-1-edumazet@google.com>
 <f3bf9a76-c110-481a-a89a-c54d5856cfe3@blackwall.org>
Content-Language: en-US
In-Reply-To: <f3bf9a76-c110-481a-a89a-c54d5856cfe3@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/01/2026 23:26, Nikolay Aleksandrov wrote:
> On 06/01/2026 21:40, Eric Dumazet wrote:
>> fdb->updated is read and written locklessly.
>>
>> Add READ_ONCE()/WRITE_ONCE() annotations.
>>
>> Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity 
>> notifications for any fdb entries")
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>>   net/bridge/br_fdb.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index 
>> 58d22e2b85fc3551bd5aec9c20296ddfcecaa040..e7bd20f0e8d6b7b24aef43d7bed34adf171c34a8 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -1002,8 +1002,8 @@ void br_fdb_update(struct net_bridge *br, struct 
>> net_bridge_port *source,
>>               unsigned long now = jiffies;
>>               bool fdb_modified = false;
>> -            if (now != fdb->updated) {
>> -                fdb->updated = now;
>> +            if (now != READ_ONCE(fdb->updated)) {
>> +                WRITE_ONCE(fdb->updated, now);
>>                   fdb_modified = __fdb_mark_active(fdb);
>>               }
> 
> Thanks,
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Actually on second thought, ->updated is used lockless in a few more
places, e.g. br_fdb_fillbuf(), fdb_fill_info(), br_fdb_cleanup().


