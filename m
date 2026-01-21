Return-Path: <netdev+bounces-252058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAVKCfhJcWn2fgAAu9opvQ
	(envelope-from <netdev+bounces-252058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:49:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1B45E47A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFE724FA884
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7630539526A;
	Wed, 21 Jan 2026 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ecYTw7xK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B403624AB
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032150; cv=none; b=CY2vy6aFAbKBn0PcHv4hbRWR0fHRd9BmPSfM1ztQIK7r6wQoyGi59oNJwbyKQuZAtT2Uz7RxzYdfJJboqov6GPmgOdc1kGgP3c56lN5eFRGsq+i9bbye1a0hA+GImtb1WlrHQ0IgBZboFcTtZU1BjZ8q2s9n5X5Q6LIaR8BwXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032150; c=relaxed/simple;
	bh=2SFqDiH83MW4ugjSYoc3/nCATH+R8FXbL80fYxa71co=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L2AFc/7upAubLRjTtEtXrBdHHSypzw5ns6oXM6G0dNFckvQX9ROsUmCU59m9lth7jQpLsYMCNpHykj3mE7iopYZKROcDhFTXyNhBiHwrqknR55kYWHPKYE1urv71GkP+H5qYRmAbruKMhCszRLBDk6a+uUIrjD2iKEK4Z9T2IbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ecYTw7xK; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233bb90317so1201818c88.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769032147; x=1769636947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J5o26zUnay0o8KGgb7cyYz/y8MIhvkmFsB5HLG6SVuQ=;
        b=ecYTw7xKvpsrSRzuYUK7y1MEjBcnZ8BbiQFS4jivnso1LJ6+BokxipVxRuxpr1CD0K
         aa6NAIiJVOL3LQXhVzMqm34zGDGiLOppFRWg9zuhjDHrxN30rA3WePntt6H6vy891GDy
         R7c7NfTsz6MqR1rIYiFB7QaUPu1ysAyuY+03FPf3SRBA/YFqXyCRU2apTmtBRPWQ5G4/
         jiLXLOpxBdMrE56p/8AuS4UsQuIandbhOIg5Z/4KXVa5KlIeDQy7qy7KIPDYUGlhNlw8
         9A+U3dZe4vKSadHsWiH088upHRIXus/Qab0w87Zjx03xp3V81Mhs7NM6FTlK49Fhjf4r
         vylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032147; x=1769636947;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5o26zUnay0o8KGgb7cyYz/y8MIhvkmFsB5HLG6SVuQ=;
        b=DcjZq1xxtZGaSijIiTWOl6aY5y/c5Bu0oeI+zRt67IBpGhFEmMs2z3+8VvSvceRVxO
         /fiesri5pbaP23uT0n4km/yXrN23nE2QyFHM6BC/mx7dNTzrDHM7vnzwgSOOpocvpxEy
         8tMIsl9w3b6SnZ43+g3s8DXeYNpNTdFb0vhRrf7NSed/3Iy1lMBA95rQonChXKDzk4IG
         hJTymncLjVWpE1yuN6PXUGOVRTq7dxe372fLNeEmYa+KPLauwiI5qXV5bOZ9RtO+ZuXT
         Jy8z7TpQVMhhpmOgcK5qGq+noVtNHrFQYHE50nyB8nVYD5GlSc0xz1jzoSMudi7ndhOQ
         UiJg==
X-Forwarded-Encrypted: i=1; AJvYcCXrzbufbyCMM4bksZApIC7f0Ml8j3F3BrAKQemGa3ePGbEZ+pn/bXtYca6cUrSqgzTVjX8mZGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7rlVwhqFC1W5nnddnlY+qbtz3yCY/p9edjMSVVmSXghsh0XSy
	6L/6sQ/yLqJEpkjsoN+8Bo0XXucZuWBT/H61dHnD/cJcoJawyHzHk2VwWhFlUtimAA==
X-Gm-Gg: AZuq6aJwch/K6tQo1pU1eUYUJynqKPHKPBuYA2CBnUU99z14JuehU2545/VVa1P1JoW
	3oPGkyMTmxCRK8Q+aSGVMxslAlJ3p0QgYFBcKXylZm54euI2jlpHY/60qK57rM0XdWfPQ1dnFpH
	h64I/9NrP4YvmR+ff87GbOZG+MkaihAa7JCRSRqAXeXFGgqDG/WYfaimQfP9ymciQgNJ4aeFro1
	r4PUMdc+Aw6okqaX65GiZ1w2svwGaLISubpZl1hR7BUSYOs3x+UaWbSkos8nsJnh0nh6teVTuhl
	ZtdIkF/Xqks7CqJOvGXgZV8XWNe1pvLsZZGAItTViljwjuW3OAPXkiXdnCL0CjDLUxuY5W0tMY0
	+s/mVOwFzJitBQWXzqa/GlHE6oSMI9jCuVrLPnWB73rKQxJBJ2rfyOvzesfeeTX0x8Z1NR6YOIA
	zlSTPs9AfOMO4AXfS5/q5/gA==
X-Received: by 2002:a05:7300:ad2d:b0:2b6:b246:dee0 with SMTP id 5a478bee46e88-2b7247158f4mr526028eec.4.1769032147014;
        Wed, 21 Jan 2026 13:49:07 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b70d7f729bsm6550761eec.16.2026.01.21.13.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 13:49:06 -0800 (PST)
Message-ID: <412136f7-1d46-42ac-96f9-b6cc462204b2@mojatatu.com>
Date: Wed, 21 Jan 2026 18:48:59 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule
 list
From: Victor Nogueira <victor@mojatatu.com>
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260121131954.2710459-1-p@1g4.org>
 <20260121131954.2710459-7-p@1g4.org>
 <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com>
Content-Language: en-US
In-Reply-To: <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252058-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mojatatu-com.20230601.gappssmtp.com:dkim,mojatatu.com:mid]
X-Rspamd-Queue-Id: 8C1B45E47A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 16:44, Victor Nogueira wrote:
> On 21/01/2026 10:20, Paul Moses wrote:
>> Reject empty schedules (num_entries == 0) so next_entry is always 
>> valid and
>> RCU readers/timer logic never walk an empty list. taprio enforces the 
>> same
>> constraint on schedules (sch_taprio.c, commit 09dbdf28f9f9fa).
>>
>> Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
>> Signed-off-by: Paul Moses <p@1g4.org>
>> Cc: stable@vger.kernel.org
>> ---
>>   net/sched/act_gate.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
>> index 48ff378bb051a..e4134b9a4a314 100644
>> --- a/net/sched/act_gate.c
>> +++ b/net/sched/act_gate.c
>> @@ -509,6 +509,12 @@ static int tcf_gate_init(struct net *net, struct 
>> nlattr *nla,
>>           cycletime_ext = nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
>>       p->tcfg_cycletime_ext = cycletime_ext;
>> +    if (p->num_entries == 0) {
>> +        NL_SET_ERR_MSG(extack, "The entry list is empty");
>> +        err = -EINVAL;
>> +        goto release_mem;
>> +    }
> 
> It would be simpler to check this in parse_gate_list.
> That way you could return -EINVAL there directly
> in case 0 entries were passed.

On second thought, I believe it would be better
to check whether parse_gate_list's return is 0
and the op is a create. Something like:

err = parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
...
if (!err && ret == ACT_P_CREATED) {
     NL_SET_ERR_MSG(extack, "The entry list is empty");
     err = -EINVAL;
     goto release_mem;
}

so that you don't need to add new arguments to
parse_gate_list.

cheers,
Victor

