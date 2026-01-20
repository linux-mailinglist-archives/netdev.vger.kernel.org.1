Return-Path: <netdev+bounces-251604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBU6Ojbfb2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:01:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 610224AF2A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E79FC50ACDE
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B447A0C6;
	Tue, 20 Jan 2026 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0pQsLXak";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xT+/+ihP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0pQsLXak";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xT+/+ihP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611234418D2
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937105; cv=none; b=tyaIz2zfY5HbhmfIgtKS0/8H8b7+H+f8/ThqT7cOC74b+bsAsYwG39l7ydGpzn6VuLcXGdRsEhjeixZ7Vte4cjrNfbpsPxnvYxCmPx2HXacYZm3zNEZnG1mmLrzjiFYj4Ia1fQRV7lP9BtCWAXGLhFLPjoJvvEe7T3YTIXJLKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937105; c=relaxed/simple;
	bh=4bX/mQ7QGh+bsrmjRcU2XkTtFX6nZjakQrEeRn1qzlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKrmW29VXNemsPF+uopNFN0IZhnIkg4VRbFAy4TiptyJrCVqRGckqGmiVeKtIwJNBXZZ+c2HmhupJ+wrNZnsXZsf4csDdtpZL+eEtukQRvWbMgPbXd3Ci3kNHfCd4SfLpo/k9F1TrciWmv8GWyih5X1NYB4ZYCV0pIjdtl+W6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0pQsLXak; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xT+/+ihP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0pQsLXak; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xT+/+ihP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2CA6D5BCC9;
	Tue, 20 Jan 2026 19:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768937101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxBGR4zZTejpTEPHfW1rYgP7AuX3Smyq6eE2tYmdeMM=;
	b=0pQsLXakjD532CsxCG/ffwBcfgbECp8nRJ6xhIJrmCG2yn3dOArdka+pzvFBJBn7f3AZOI
	T6DFVha/EKfL8LurUVaNNOYFeaK3tU2ISKjeAge78WwBnGLpX5KKe/oXvLDYJXj523eRiU
	3+tEEX/ozSbxxBrHBC9CGcZpSyT8o8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768937101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxBGR4zZTejpTEPHfW1rYgP7AuX3Smyq6eE2tYmdeMM=;
	b=xT+/+ihPYMslSCgaPZ63JvLSVfflqFycZG4KlmtllyPR9GoKrP2eOlwjbcqoOewK3rlGs+
	9kCXU2stnlo5k1CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0pQsLXak;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="xT+/+ihP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768937101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxBGR4zZTejpTEPHfW1rYgP7AuX3Smyq6eE2tYmdeMM=;
	b=0pQsLXakjD532CsxCG/ffwBcfgbECp8nRJ6xhIJrmCG2yn3dOArdka+pzvFBJBn7f3AZOI
	T6DFVha/EKfL8LurUVaNNOYFeaK3tU2ISKjeAge78WwBnGLpX5KKe/oXvLDYJXj523eRiU
	3+tEEX/ozSbxxBrHBC9CGcZpSyT8o8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768937101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxBGR4zZTejpTEPHfW1rYgP7AuX3Smyq6eE2tYmdeMM=;
	b=xT+/+ihPYMslSCgaPZ63JvLSVfflqFycZG4KlmtllyPR9GoKrP2eOlwjbcqoOewK3rlGs+
	9kCXU2stnlo5k1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADD993EA63;
	Tue, 20 Jan 2026 19:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g5V+J4zWb2nnAwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 20 Jan 2026 19:25:00 +0000
Message-ID: <061a4df2-2ccd-449f-a21b-4ffa03be4533@suse.de>
Date: Tue, 20 Jan 2026 20:24:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next v2] selftests: ipv6_icmp: add tests for
 ICMPv6 handling
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260107153841.5030-1-fmancera@suse.de>
 <20260107153841.5030-2-fmancera@suse.de>
 <72d45fe9-c058-4944-b7a2-260b7259096f@kernel.org>
 <1660abed-e6ad-4657-8736-599ab9114f68@suse.de>
 <604c7b1d-f366-4faa-9abd-bae8ae73b561@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <604c7b1d-f366-4faa-9abd-bae8ae73b561@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-251604-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,fcnal-test.sh:url,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 610224AF2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/8/26 4:20 PM, David Ahern wrote:
> On 1/8/26 4:24 AM, Fernando Fernandez Mancera wrote:
>> On 1/7/26 5:41 PM, David Ahern wrote:
>>> On 1/7/26 8:38 AM, Fernando Fernandez Mancera wrote:
>>>> +icmpv6_to_vrf_based_local_address()
>>>> +{
>>>> +    local rc
>>>> +    local lldummy
>>>> +
>>>> +    echo
>>>> +    echo "ICMPv6 to VRF based local address"
>>>> +
>>>> +    setup
>>>> +
>>>> +    lldummy=$(get_linklocal dummy0)
>>>> +
>>>> +    if [ -z "$lldummy" ]; then
>>>> +        echo "Failed to get link local address for dummy0"
>>>> +        return 1
>>>> +    fi
>>>> +
>>>> +    run_cmd "$NS_EXEC sysctl -w net.ipv6.conf.all.keep_addr_on_down=1"
>>>> +
>>>> +    # create VRF and setup
>>>> +    run_cmd "$IP link add vrf0 type vrf table 10"
>>>> +    run_cmd "$IP link set vrf0 up"
>>>> +    run_cmd "$IP link set dummy0 master vrf0"
>>>
>>> run_cmd "$IP -6 addr add ::1 dev vrf0 nodad"
>>>
>>> makes the VRF device the loopback.
>>>
>>>> +
>>>> +    # route to reach 2001:db8::1/128 on VRF device and back to ::1
>>>> +    run_cmd "$IP -6 route add 2001:db8:1::1/64 dev vrf0"
>>>> +    run_cmd "$IP -6 route add ::1/128 dev vrf0 table 10"
>>>
>>> and then this route add should not be needed. This is how fcnal-test.sh
>>> works.
>>>
>>
>> Oh neat! Thanks.
>>
>>>> +
>>>> +    # ping6 to link local address
>>>> +    run_cmd "$NS_EXEC ${ping6} -c 3 $lldummy%dummy0"
>>>> +    log_test $? 0 "Ping to link local address on VRF context"
>>>> +
>>>> +    # ping6 to link local address from localhost (::1)
>>>> +    run_cmd "$NS_EXEC ${ping6} -c 3 -I ::1 $lldummy%dummy0"
>>>
>>> -I vrf0 should be needed for all VRF tests. I suspect your current
>>> passing tests are because you have a single setup step and then run
>>> non-VRF test followed by VRF test. Really you need to do the setup,
>>> run_test, cleanup for each test.
>>>
>>
>> You are right here about the cleanup, although the tests are passing
>> even if the cleanup is properly done or if `-t
>> icmpv6_to_vrf_based_local_address`. I don't see why they should not pass.
> 
> Without ::1 on the vrf device there is no valid address. ie., ::1 is in
> the default vrf and dummy0 is in the VRF so it should not be allowed.
> Something is off.

Yes, what is off is the setup but see comment below, please disregard 
the test file I created.

>>
>> I am changing them to use `-I vrf0` because it makes more sense.
> 
> I should have asked yesterday: how do these tests differ from what is
> done in fcnal-test.sh - ipv4_ping and ipv6_ping? Those tests cover
> loopback, linklocal address and global address combined with vrf and no vrf.
> 
> 

Sorry for my late reply. About fcnal-test.sh - ipv6_ping, I didn't know 
this existed, sorry. The main difference is that they do not use -I ::1. 
Indeed, if `-I ::1` case is added for pinging a configured local address 
it fails. Both, vrf and no vrf.

I am preparing a v3 adding a scenario to that test instead of creating 
new ones.

Thank you very much David for all this feedback,
Fernando.


