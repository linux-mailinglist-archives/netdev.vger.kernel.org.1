Return-Path: <netdev+bounces-260240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KcIFtLUnGk5LAQAu9opvQ
	(envelope-from <netdev+bounces-260240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:29:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B23AC17E5C4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5703830579DF
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7B236A004;
	Mon, 23 Feb 2026 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thz7n5lA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35B349B12
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885651; cv=none; b=mQYR8X6WXVysK3fxjkp5jVufZPNXtMLfHina21Pz66o7CJ4hxEHcn8fK6C9KsTuO3zavu8nhQA+Ohh+6nSI+IILCm//bf4IBRNLmZ51NQ6PvpRNJI5G3I78mJHq2vDHnkMcrJap+gom5Pzv6dtw65dv5r0lOMBeheOT+OCoVDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885651; c=relaxed/simple;
	bh=5VQdwq5iYupfVOxuFIbNgn6g2jKZzhc9p1uHTrGLLb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PG6Xg3tfL6gAs8bzT7RG0xf6Mac8rs9quHbxWstaGbgkvbesNmqwlduNGzrdWc2Y4HbVJvmAsfg8dMDIDyu8CZtPBmDGpk1N/784vDprTe2DDhI4wDr+J3jChhszIvRaX7ikyJ1bLcSP46B0UUxDTJJll/y2gz1tPk1kRBlTaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Thz7n5lA; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b82c605dbdso4740379eec.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771885649; x=1772490449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kNjNLoqYQo3bHcLqqQozYiyVl1uROHpptaYq1t6Tjk=;
        b=Thz7n5lAFUZZ2i31BwDbOhjQbJ9sizJgo0KCdcqxbTWW7EDTe5/yPNB2gpxNK+GpmB
         vnLo9LKHCeLaqHIcekwSk5dYXLZw3SKn39EjtXXkv+VcRSPS7qMQpkAP/mu1ow6m1bSL
         07nMu9HC6SIKxuF+TYXMqMkEWqF+cuzdU9wmPvPsCVQmiY51FH+gfCoO1Thr1NQ9Evyw
         vv6JvIdGYzXCHPm4wcKpKu7el1MJSwrMBFKt1LzXFjqKZB4dXQdQ5rWkDvKfOB1GIp7m
         1YXCAisDuZLh+QOGFqnILQZJsWixXbvmwObHf/wPJzpp6KrFAkRYc4Rh6w+9/0yT0ihO
         tNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885649; x=1772490449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kNjNLoqYQo3bHcLqqQozYiyVl1uROHpptaYq1t6Tjk=;
        b=Tk3wuI3iWgatU2U9jJ/QZMMqAYAAwupOBIorDsVr4AIUrnY2tKPLN7nb3hW+DJr0jb
         769ROWphbTpXlmyyVSlb+E4B7gT6ezQXt3GqK7K5NLGrtiYHXvjSfNXf6kTnbFIduZie
         MYltMv4sa1oPyR0qs1yOeD5V+QdIwu6W9zIHxX3K0OIGrKsEqzLDUr2HlVHq0cuX53L8
         DWTWZGSUBDfMPPJK7A3+DhiYCHmLXOj91zvxXwH09NVF68qVEO2/zjTC/BR5n2JF7dNX
         qEGv2xHVZi2aMnLTxNCu2dtPZyMpKx3aUqmbHcVC4zku+J1lWgIQBoOkxJNJNhknqjOE
         UVTg==
X-Forwarded-Encrypted: i=1; AJvYcCUTZWawarDsCmIHlWWOM0ebFJS87JNUxcNjDsZcSOwUW+qvzKPFjChi8xPJaKJ/jlsUIPHbv/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6D46e18YgoOQYVeGeFgYuiFqp6Y27IwXj/udk8IP6fDpes+B
	oEEv++f59HoM+u+QttYljZ2qPN/S6/esM13rDTV33QW+i0zd+1aHTbJ7
X-Gm-Gg: AZuq6aJmN77lrexwS5etGjc1h9Wy5+HmSZlnke1UeXwb+Jg6DL575WGRLjLfKAkCum6
	L0oYLEa218IjvSI0BFJP8Q+5sYe7A195Se9B66NEISEgIUjwyaHKEQLPwx1Nb/3hBLtHWk8fV96
	WLGC/UWdg4iMNae2rpoKipzb2kq3p1f4Z/gMVpmRPBeiRTqMwccDHJ/+m9DPG34xvh/uhgumE8v
	Sd6FjB7dgqyRThG6caes7jqA5JE7rzAIKcaZot3aQKvn/j+Gvx9dUQ70hozYn8gWa2hc4HI1/i6
	Cqe2ionBxBXASpS5VJIjGKVz+Rk82So6QKC2fmEunEnW1JPG2iRoQfFe+sDN7bduXvSIIqvKWzO
	7AdVuAKdDDfivcU42am633YzGOoNqoI3CREU+YjQFHsSSiS/cA9Y0exyiWfKN/SN9ZtjKoCrE84
	qt7MHaaSiirT0CJBAdzDIur3Zr8UYr8xmwsDMOBTV1xwH5IITKNPX6lvyhKEAXsvYkBaQiKvSl0
	B1S52OBwJPzSNki7JBbaqCYfdIHI3wyi+mwO5YYHrIRo2CkFHlF/4keyFn/0FC0wDjzZ418wB/p
	dTRowRWvZlPfaJfJA/J+8II3cw==
X-Received: by 2002:a05:7022:670d:b0:11b:9386:7ecf with SMTP id a92af1059eb24-1276ad6e489mr5429438c88.44.1771885649310;
        Mon, 23 Feb 2026 14:27:29 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:b343:b0de:3e59:4e65? ([2a00:79e0:2e7c:8:b343:b0de:3e59:4e65])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa37e9sm5525797eec.11.2026.02.23.14.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 14:27:28 -0800 (PST)
Message-ID: <41c375cd-5c23-407b-9e35-8779f899ad09@gmail.com>
Date: Mon, 23 Feb 2026 14:27:27 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/62] bnxt_en: Fix bnxt_dl_reload_up()
To: Michael Chan <michael.chan@broadcom.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
References: <20260223214950.2153735-1-bvanassche@acm.org>
 <20260223214950.2153735-19-bvanassche@acm.org>
 <CACKFLimX0PPJGeJMG-nycNMufbFsJ4YUTnGbLHC_20xF2n9OQQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <CACKFLimX0PPJGeJMG-nycNMufbFsJ4YUTnGbLHC_20xF2n9OQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartvanassche@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:email]
X-Rspamd-Queue-Id: B23AC17E5C4
X-Rspamd-Action: no action

On 2/23/26 2:17 PM, Michael Chan wrote:
> .
> On Mon, Feb 23, 2026 at 1:52 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> bnxt_dl_reload_down() calls rtnl_lock() and netdev_lock() if it returns
>> 0. Hence, bnxt_dl_reload_up() should invoke the corresponding unlock
>> calls. This issue has been detected by the clang thread-sanitizer.
>> Compile-tested only.
>>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
>> Cc: Stanislav Fomichev <sdf@fomichev.me>
>> Cc: netdev@vger.kernel.org
>> Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>> index 15de802bbac4..1e9a3454bb29 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>> @@ -562,6 +562,8 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
>>                  break;
>>          }
>>          default:
>> +               netdev_unlock(bp->dev);
>> +               rtnl_unlock();
> 
> This doesn't look correct.  The 2 locks are taken in
> bnxt_dl_reload_down() only for the 2 actions
> DEVLINK_RELOAD_ACTION_DRIVER_REINIT and
> DEVLINK_RELOAD_ACTION_FW_ACTIVATE.  For the default action, no locks
> are taken so I don't think we should unlock here.

Hi Michael,

My understanding is that bnxt_dl_reload_up() is only called if
bnxt_dl_reload_down() returns 0 (see also devlink_reload()).
bnxt_dl_reload_up() returns an error code (-EOPNOTSUPP) for other
actions than DEVLINK_RELOAD_ACTION_DRIVER_REINIT or
DEVLINK_RELOAD_ACTION_FW_ACTIVATE. Hence, bnxt_dl_reload_up() is only
called if "action" is either DEVLINK_RELOAD_ACTION_DRIVER_REINIT or
DEVLINK_RELOAD_ACTION_FW_ACTIVATE. In other words, the code in the
"default" clause will never be reached. So I think the above change is
correct but also that the patch description should be modified to
reflect that this is not a bug fix. Did I perhaps misunderstand
something?

Thanks,

Bart.

