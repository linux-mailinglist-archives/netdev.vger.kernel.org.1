Return-Path: <netdev+bounces-235581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2980C32BC1
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 20:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC32A4E1F24
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5FC32939C;
	Tue,  4 Nov 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Ox0bnPKG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E792E8B9B
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283414; cv=none; b=KstJ6TYq+nqUZdnJLKMgpx97kKp3lAYzobLEVQYNXiN58mO46NoCTNsLQAF27t/JkhBWgcP31GfPT69Eb18ZsTcRRcJObA+DM8QrVrbdiBBYl0gtwyiwodBlpLEcQHzbnVaUH5jFADUHywfz6E1Atlmpq27XSrL4TbZK5GpZGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283414; c=relaxed/simple;
	bh=9LWKCVKfpkLorLNhfnXcCyl5zFVxqyoqSkP/ChRZHu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMV7NurbKs2bz+M6G4WYlx8nxTsZXngqJKy4kStdiuISFCEtFf/fjA4s2J6Qz4uqcrVDIvwBVEyv+JLNweIpuC2i1mazggmRGtvHWZrsnC2yPlrwDH/aKYqwv0keJNlhQaOKLeYQ5BDlDyix9sP95lFihL4ExDsx/ZWDpFpIpCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Ox0bnPKG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so7658633a12.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 11:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762283411; x=1762888211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHPzEXIUZ9pzwlZg85xxsGY9keDqq8RNI/L/RPCgfS8=;
        b=Ox0bnPKGBxpnyVrD+/j+pdLorEiJeX+G/OhHidwX/7BDlE6kKnTpyIqv4rC9RTMBKi
         paXZfAbg+3NJ4suxUuiWVB0DqTb74x0Vdx7NQVYBS2xLx+RxNsUb40AT9BfadRU/ox2v
         8SKASLMKfIuXIYX40GyPA1MBuIPae8EzKZuvjL5FPZXNXbynw4iJKSZvXi/3zA6hSBab
         AIa5WV8/VXgmUdD5B5pkITDqadTBi8GyalTeKcWESfXJrbs7c1ApH/R4l3q5EKnypmcR
         toS7ff6t3WHdo0wEYJAvMgjNRSavRndK2frLPyyB7XyAo5Cpkk65p6IlAilabLTUYqxg
         PXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762283411; x=1762888211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHPzEXIUZ9pzwlZg85xxsGY9keDqq8RNI/L/RPCgfS8=;
        b=GthdT/KUIqxESRYkdNEKHpdsv4TVoSmXKmGMf5g3MUIIXThnamcaVpXW0W3pPgolSH
         rdFmn04m+rUbfh6vvAsZQ3kZ31/uOhYE1unBc3dP5Is4oRei/e578HArf5M7RB2ng2ka
         zBmA6FXccfUSmmju1nZHRn4LCYgnlFOq0wBj1MTUp/bpscAGjx20Hb7T6xAITxawaEYE
         DR9KymL1Y66aIVYeXI0wvMTWg8O9SYt3JaenlZBmdqk0XJ+Nq9LCdEzGYhn8BP4ZhN0g
         IeJVjqeRjMwGayTr0AXqKkyfPmWUvFnl0vZ9o6V/5gVJqGcsaW5BR5gknR0F+w2ZFnlK
         zZ2A==
X-Gm-Message-State: AOJu0Yz1V6s7yVvEJB3LsqKs1vNuJWIMcBf3voUSB6CpRFFvHlQFqSlL
	UArIeCAk0VKfWCa4syc4BtGFJp/kGiMB2DoreIpcE5PaklPbQjgPjfdd08YHRhjEEEOPwzn6DXN
	VH7XjSqI=
X-Gm-Gg: ASbGnctOJEiQTfpJcLryDqH2OGBaK7im8dIQF0IK9S/nZTnTe+JhKXh0QceuzrPOIl1
	mxngL2DNJI16TAx01q8t/eLvZzRWJ2NzFAQLfjVthaVSYqa7lAD0ljp8pIs9aXqs7KRtnDzAjYP
	3H4h521yJJtCtX5qTOJLwcYbNxnnBrmmkFy54nhuwzcddB/ldNeo6w7TW8GqJibMrd8WjEsP8vj
	EhiOmFhqVrBn7HMGCm7YPuKlHJ5ya/9u2yc5jL9WenEU0T29E7qb2xYvqPBfiFDdAc3uxWchmMy
	OKYW4BB0CpEC/R4/p0UHV+3zaC2vWp9y4oXp1B3k3H7T/ARhR9zBah6rl707dSlFUXjWpD4z86w
	WNWDIZ1G2bh8YXV0kqDO26LYJSqRDoKLUPXDs4q1IkFrLwwX/id72DbZbHsSeHQPnMmaA7s9Uaw
	gMkDXN9DGqfXGsa4u2XQbceMGdaG0CAsU7
X-Google-Smtp-Source: AGHT+IGVSDgEL05gD1VP583K60Rshyb4V0TRe73xfvSbKrRc1EoanFAlaR1O1a/+yOYg6dakhlj2rg==
X-Received: by 2002:a17:907:72c6:b0:b70:b4db:ae83 with SMTP id a640c23a62f3a-b7265605335mr26751966b.60.1762283410700;
        Tue, 04 Nov 2025 11:10:10 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d7030adsm289300666b.24.2025.11.04.11.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 11:10:10 -0800 (PST)
Message-ID: <2252e81c-fe49-40aa-944e-4c94d5de563d@blackwall.org>
Date: Tue, 4 Nov 2025 21:10:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: forwarding: bridge: add a state bypass
 with disabled VLAN filtering test
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, tobias@waldekranz.com, idosch@nvidia.com,
 kuba@kernel.org, davem@davemloft.net, bridge@lists.linux.dev,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org
References: <20251104120313.1306566-1-razor@blackwall.org>
 <20251104120313.1306566-3-razor@blackwall.org> <87qzudn256.fsf@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <87qzudn256.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 19:15, Petr Machata wrote:
> 
> Nikolay Aleksandrov <razor@blackwall.org> writes:
> 
>> Add a test which checks that port state bypass cannot happen if we have
>> VLAN filtering disabled and MST enabled. Such bypass could lead to race
>> condition when deleting a port because learning may happen after its
>> state has been toggled to disabled while it's being deleted, leading to
>> a use after free.
>>
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>>  .../net/forwarding/bridge_vlan_unaware.sh     | 35 ++++++++++++++++++-
>>  1 file changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
>> index 2b5700b61ffa..20769793310e 100755
>> --- a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
>> +++ b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
>> @@ -1,7 +1,7 @@
>>  #!/bin/bash
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> -ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding pvid_change"
>> +ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding pvid_change mst_state_no_bypass"
> 
> I think you'll need to adjust this test for v2, can you please change
> the above line to the following while at it?
> 

ack

> ALL_TESTS="
> 	ping_ipv4
> 	ping_ipv6
> 	learning
> 	flooding
> 	pvid_change
> 	mst_state_no_bypass
> "
> 
>>  NUM_NETIFS=4
>>  source lib.sh
>>  
>> @@ -114,6 +114,39 @@ pvid_change()
>>  	ping_ipv6 " with bridge port $swp1 PVID deleted"
>>  }
>>  
>> +mst_state_no_bypass()
>> +{
>> +	local mac=de:ad:be:ef:13:37
>> +
>> +	# Test that port state isn't bypassed when MST is enabled and VLAN
>> +	# filtering is disabled
>> +	RET=0
>> +
>> +	# MST can be enabled only when there are no VLANs
>> +	bridge vlan del vid 1 dev $swp1
>> +	bridge vlan del vid 1 dev $swp2
> 
> Pretty sure these naked references will explode in the CI's shellcheck.
> I expect they'll have to be quoted as "$swp1".
> 

Oh haven't written selftests in awhile, I've missed the shellcheck stuff. :)

>> +	bridge vlan del vid 1 dev br0 self
>> +
>> +	ip link set br0 type bridge mst_enabled 1
>> +	check_err $? "Could not enable MST"
>> +
>> +	bridge link set dev $swp1 state disabled
> 
> Here as well. And more cases are below.
> 
> I've got this in my bash history. Might come in handy.
> 
>     cat files | while read file; do git show net-next/main:$file > file; shellcheck file > sc-old; git show HEAD:$file > file; shellcheck file > sc-new; echo $file; diff -u sc-old sc-new; done | less
>
 
Thanks for the hint. I'll add this to my patch review process as well.

Cheers,
 Nik

>> +	check_err $? "Could not set port state"
>> +
>> +	$MZ $h1 -c 1 -p 64 -a $mac -t ip -q
>> +
>> +	bridge fdb show brport $swp1 | grep -q de:ad:be:ef:13:37
>> +	check_fail $? "FDB entry found when it shouldn't be"
>> +
>> +	log_test "VLAN filtering disabled and MST enabled port state no bypass"
>> +
>> +	ip link set br0 type bridge mst_enabled 0
>> +	bridge link set dev $swp1 state forwarding
>> +	bridge vlan add vid 1 dev $swp1 pvid untagged
>> +	bridge vlan add vid 1 dev $swp2 pvid untagged
>> +	bridge vlan add vid 1 dev br0 self
>> +}
>> +
>>  trap cleanup EXIT
>>  
>>  setup_prepare
> 


