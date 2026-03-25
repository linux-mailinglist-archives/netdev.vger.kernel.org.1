Return-Path: <netdev+bounces-271582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BqxD8zyw2mSvAQAu9opvQ
	(envelope-from <netdev+bounces-271582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:35:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 307E2326D9B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58FBA3014902
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4476B3B27E0;
	Wed, 25 Mar 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzNd2dB9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261A283FEF
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448252; cv=none; b=QgpPn0i7iic9X+TlZE3kL/Ge1K2X7bdJeq+VmUaikAU3a5ntWe4RjUa7gjnEbXR7AKTAtu+a9EEePv1uiaqZyocbHK6BRuRPMfNZ+hz1/LR8xLN7q5l0mxTcyDsXu6O7rf3Hm16pWtpwRCgQ9qHIj1AZtoLpcFmg/rpDPB3CYMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448252; c=relaxed/simple;
	bh=reqoWvvs/jnOmBUCHX4ic7GiW2p3z38KMaXoSlHfU1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qa+kfve9gFp8uasz4ATTh7bZEkgyGdTrshLyAh3xMgcPl8yvFy0gp9WDh5XxtQFYb82+G6SIrYI7cmjMOfqnc0NWc3veRrMHY7xX2VX88lN3aMW3CIa4/zij5kFn2RRb8D+MwUOdVc3B+OQUBUE/dhbjVh7HgJGPgM58DdwTNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzNd2dB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68151C4CEF7;
	Wed, 25 Mar 2026 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774448251;
	bh=reqoWvvs/jnOmBUCHX4ic7GiW2p3z38KMaXoSlHfU1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dzNd2dB9NYMoT1YOalL4Lccb0TihiRpw9ShnJ9VT2IiyrY4dN8fpvwC72J1fGLTb9
	 IOIZKbxaxeXIjg5gevNYGIhLs12x2dZhhu5zyzmOvV4IeYjmaIH9NpI3cvs9EJ0BcZ
	 Ki4wTn18XJiq3xKsztsQtvfQibzO4t6MinuSXpHzIORe8yPBQpldmy+wRXdVh6HL45
	 IbxsqQrxm0hAf0J3lkBjDBa/Yxjp0o8Sbj+bqGDvj4zGzEfMvb+YQxr2XzpZCmrept
	 87xJc+7cIwa99+GmGft3QXftXSErgS6MA7eYq5cARqq05EdOUG4G/meS8WOgngSvF4
	 LdRUh/2Ivbeqg==
Message-ID: <1ea4c187-9c1f-4e15-b472-07a82abd3260@kernel.org>
Date: Wed, 25 Mar 2026 08:17:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] vrf: Remove unnecessary synchronize_rcu()
 invocations
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, petrm@nvidia.com,
 lirongqing@baidu.com
References: <20260324155521.525292-1-idosch@nvidia.com>
 <20260324155521.525292-4-idosch@nvidia.com>
 <CANn89iJ9hD3vBiViEz886sVwuqQVbaocnE0UJHZMhchFHKiM-w@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iJ9hD3vBiViEz886sVwuqQVbaocnE0UJHZMhchFHKiM-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271582-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 307E2326D9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 2:39 PM, Eric Dumazet wrote:
> On Tue, Mar 24, 2026 at 8:56 AM Ido Schimmel <idosch@nvidia.com> wrote:
>>
>> vrf_rtable_release() and vrf_rt6_release() are called as part of the VRF
>> device's ndo_uninit() callback. As such, an RCU grace period passes
>> between the removal of the VRF slaves and the closing of the VRF device
>> until these functions are invoked.
>>
>> Therefore, it should not be possible for any concurrent RCU readers to
>> try and acquire a reference on the dst entry while we are potentially
>> releasing the last reference via dst_release().
>>
>> Given the above, the synchronize_rcu() invocations in these functions
>> seem unnecessary and only add unnecessary delay when deleting VRF
>> devices. Remove them.
>>
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
>> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>> ---
>>  drivers/net/vrf.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>> index bfc9ea91ac20..75edb8eba87f 100644
>> --- a/drivers/net/vrf.c
>> +++ b/drivers/net/vrf.c
>> @@ -753,7 +753,6 @@ static void vrf_rt6_release(struct net_device *dev, struct net_vrf *vrf)
>>         struct rt6_info *rt6 = rtnl_dereference(vrf->rt6);
>>
>>         RCU_INIT_POINTER(vrf->rt6, NULL);
> 
> We could argue that the vrf->rt6 clearing is not needed,
> or should be done before the RCU grace period mentioned in the
> changelog started ?
> 

AIUI Ido's point is that the synchronize_net() in
unregister_netdevice_many_notify() occurs before the ndo_uninit call
making the synchronize_rcu here unnecessary. There is also a second
synchronize_net after it.

I get your point about skipping the clearing the poiniters.

