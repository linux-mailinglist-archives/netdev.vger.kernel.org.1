Return-Path: <netdev+bounces-251610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO1JGPnpb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:47:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFB34BB89
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B4CCA05FE2
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7088547D936;
	Tue, 20 Jan 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xl/VhU/8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fdIKl0IJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xl/VhU/8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fdIKl0IJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D4C47CC94
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938303; cv=none; b=gsG02kTu2Xix0HXYpmPY3/hQz4fzGQ6NysRPWmjO1sC4E51FsYUpBnxwFVw1/5yPCYCleMq9/qnC7vtrMUuOFIgGzJYex8nbH5VaXJq1gBIyzyKyhQDZFac3wiCis8JSVMsOyMTEsOhX+NQnuQ/t6x1DRtBeMDwKmeAKLAhoqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938303; c=relaxed/simple;
	bh=fnHTYKoRmjsneSKmJmk5uNghMHCy+6dx8CZiiPq1vYQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N/5pa9t7AG2VXvvISqxr8XJrKZo6WqPuA48J15DbgjzYPajTLkBO5SX2pq/K5C2aMr2uFK+9Mc+vOETcR4j2870VBiWrnd6KkXRn7/3MkQl3KCULmYChoEsrQeR/uaVA9lbkBcj3WryflcElKKdaZU6PR1pxjAsgrtFgoLbqxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xl/VhU/8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fdIKl0IJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xl/VhU/8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fdIKl0IJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A39925BCCF;
	Tue, 20 Jan 2026 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768938298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oB8L91jGPNcK38t02Oh2/Lp/HdtpKCMAVWKjAGV+TL4=;
	b=Xl/VhU/8WQ8msMdAlcXAdo0sZQqQzDPjRU2TCD7Q4qGqDxPzX1qYsajKPls2CmwUEr7K89
	g8YyjNn3x2X72Yeq9ZOHcfufoSMgYERzvKfSvq7rjT4NOqeyjpbgYmP3/ITZZg5oiJ9Exu
	89WBKizi6v69SyB6SZt/F++CNXbW3E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768938298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oB8L91jGPNcK38t02Oh2/Lp/HdtpKCMAVWKjAGV+TL4=;
	b=fdIKl0IJS7zT6/o4a94BQx+6ccxZN2f9fCaIc1af1Cr8eRp7bfQJAkQhD/HSNIWjy8JdIE
	qyXa9i5NQ7RL8iAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Xl/VhU/8";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fdIKl0IJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768938298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oB8L91jGPNcK38t02Oh2/Lp/HdtpKCMAVWKjAGV+TL4=;
	b=Xl/VhU/8WQ8msMdAlcXAdo0sZQqQzDPjRU2TCD7Q4qGqDxPzX1qYsajKPls2CmwUEr7K89
	g8YyjNn3x2X72Yeq9ZOHcfufoSMgYERzvKfSvq7rjT4NOqeyjpbgYmP3/ITZZg5oiJ9Exu
	89WBKizi6v69SyB6SZt/F++CNXbW3E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768938298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oB8L91jGPNcK38t02Oh2/Lp/HdtpKCMAVWKjAGV+TL4=;
	b=fdIKl0IJS7zT6/o4a94BQx+6ccxZN2f9fCaIc1af1Cr8eRp7bfQJAkQhD/HSNIWjy8JdIE
	qyXa9i5NQ7RL8iAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A7BF3EA63;
	Tue, 20 Jan 2026 19:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BGtJBzrbb2lwFgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 20 Jan 2026 19:44:58 +0000
Message-ID: <f22691c9-63c6-444a-899f-adac93a2bbbf@suse.de>
Date: Tue, 20 Jan 2026 20:44:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next v2] selftests: ipv6_icmp: add tests for
 ICMPv6 handling
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260107153841.5030-1-fmancera@suse.de>
 <20260107153841.5030-2-fmancera@suse.de>
 <72d45fe9-c058-4944-b7a2-260b7259096f@kernel.org>
 <1660abed-e6ad-4657-8736-599ab9114f68@suse.de>
 <604c7b1d-f366-4faa-9abd-bae8ae73b561@kernel.org>
 <061a4df2-2ccd-449f-a21b-4ffa03be4533@suse.de>
Content-Language: en-US
In-Reply-To: <061a4df2-2ccd-449f-a21b-4ffa03be4533@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251610-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,fcnal-test.sh:url]
X-Rspamd-Queue-Id: CBFB34BB89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 8:24 PM, Fernando Fernandez Mancera wrote:
> On 1/8/26 4:20 PM, David Ahern wrote:
>> On 1/8/26 4:24 AM, Fernando Fernandez Mancera wrote:
>>> On 1/7/26 5:41 PM, David Ahern wrote:
>>>> On 1/7/26 8:38 AM, Fernando Fernandez Mancera wrote:
>>>>> +icmpv6_to_vrf_based_local_address()
>>>>> +{
>>>>> +    local rc
>>>>> +    local lldummy
>>>>> +
>>>>> +    echo
>>>>> +    echo "ICMPv6 to VRF based local address"
>>>>> +
>>>>> +    setup
>>>>> +
>>>>> +    lldummy=$(get_linklocal dummy0)
>>>>> +
>>>>> +    if [ -z "$lldummy" ]; then
>>>>> +        echo "Failed to get link local address for dummy0"
>>>>> +        return 1
>>>>> +    fi
>>>>> +
>>>>> +    run_cmd "$NS_EXEC sysctl -w 
>>>>> net.ipv6.conf.all.keep_addr_on_down=1"
>>>>> +
>>>>> +    # create VRF and setup
>>>>> +    run_cmd "$IP link add vrf0 type vrf table 10"
>>>>> +    run_cmd "$IP link set vrf0 up"
>>>>> +    run_cmd "$IP link set dummy0 master vrf0"
>>>>
>>>> run_cmd "$IP -6 addr add ::1 dev vrf0 nodad"
>>>>
>>>> makes the VRF device the loopback.
>>>>
>>>>> +
>>>>> +    # route to reach 2001:db8::1/128 on VRF device and back to ::1
>>>>> +    run_cmd "$IP -6 route add 2001:db8:1::1/64 dev vrf0"
>>>>> +    run_cmd "$IP -6 route add ::1/128 dev vrf0 table 10"
>>>>
>>>> and then this route add should not be needed. This is how fcnal-test.sh
>>>> works.
>>>>
>>>
>>> Oh neat! Thanks.
>>>
>>>>> +
>>>>> +    # ping6 to link local address
>>>>> +    run_cmd "$NS_EXEC ${ping6} -c 3 $lldummy%dummy0"
>>>>> +    log_test $? 0 "Ping to link local address on VRF context"
>>>>> +
>>>>> +    # ping6 to link local address from localhost (::1)
>>>>> +    run_cmd "$NS_EXEC ${ping6} -c 3 -I ::1 $lldummy%dummy0"
>>>>
>>>> -I vrf0 should be needed for all VRF tests. I suspect your current
>>>> passing tests are because you have a single setup step and then run
>>>> non-VRF test followed by VRF test. Really you need to do the setup,
>>>> run_test, cleanup for each test.
>>>>
>>>
>>> You are right here about the cleanup, although the tests are passing
>>> even if the cleanup is properly done or if `-t
>>> icmpv6_to_vrf_based_local_address`. I don't see why they should not 
>>> pass.
>>
>> Without ::1 on the vrf device there is no valid address. ie., ::1 is in
>> the default vrf and dummy0 is in the VRF so it should not be allowed.
>> Something is off.
> 
> Yes, what is off is the setup but see comment below, please disregard 
> the test file I created.
> 
>>>
>>> I am changing them to use `-I vrf0` because it makes more sense.
>>
>> I should have asked yesterday: how do these tests differ from what is
>> done in fcnal-test.sh - ipv4_ping and ipv6_ping? Those tests cover
>> loopback, linklocal address and global address combined with vrf and 
>> no vrf.
>>
>>
> 
> Sorry for my late reply. About fcnal-test.sh - ipv6_ping, I didn't know 
> this existed, sorry. The main difference is that they do not use -I ::1. 
> Indeed, if `-I ::1` case is added for pinging a configured local address 
> it fails. Both, vrf and no vrf.
> 

Correction: only on no-vrf scenario, as vrf scenario uses `-I $VRF` it 
is fine.

> I am preparing a v3 adding a scenario to that test instead of creating 
> new ones.
> 
> Thank you very much David for all this feedback,
> Fernando.
> 


