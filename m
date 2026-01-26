Return-Path: <netdev+bounces-253429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGIXGUFLd2msdwEAu9opvQ
	(envelope-from <netdev+bounces-253429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:08:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F7C877FE
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07DAC300B060
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34105328616;
	Mon, 26 Jan 2026 11:08:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0F255F5E
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425693; cv=none; b=mrr90Klwv+guInwAZXvuE/K4q9hl1GZRlZhDzcWeOb2ab45kvJcM6Kru1tZXXgiswjAFpgvTprUk+yAFc+Hd3xJltqhJn9nto0ym+8G6KOjp+LUnfN0+L3+QMxQLI7n7r1ln6YtSdeR671FpNDV7WL+bWk6aXA9a/fGvP9RJ2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425693; c=relaxed/simple;
	bh=TZpctKdgiPRVLdeNwNsiWcDXND6OPI/++MMlAaiFxDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEYEa/upvAqIbVec2XfTRILJxDvzlzoosxBNHI7YXK8r5xb3FDO9ts5uJGk2FJdA9fcocEKL4Zl6c0pb9hGsdiTIqLjTJqks1aWbwSh4TPb8eqglU6pI4JetVieTbz/RwPo21UmRq7dOD6sF9umgLrcRvd2ish9r0dP29M1nEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60QB89wQ004732;
	Mon, 26 Jan 2026 20:08:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60QB89I4004728
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Jan 2026 20:08:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <086e7ceb-a1c5-4ea0-baf0-0abbe4590031@I-love.SAKURA.ne.jp>
Date: Mon, 26 Jan 2026 20:08:09 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] team: avoid NETDEV_CHANGEMTU event when unregistering
 slave
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Jiri Pirko <jiri@resnulli.us>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <7fe2645c-680d-4fbe-981b-67a041f0d9c9@I-love.SAKURA.ne.jp>
 <20260125085835.GA54633@shredder>
 <29ffd5ac-07b1-4424-ad3f-8304a28d2946@I-love.SAKURA.ne.jp>
 <20260125121551.GA83275@shredder>
 <ece4365f-906c-44e2-80c9-ab73f91f7fb5@I-love.SAKURA.ne.jp>
 <64f626f4-5432-4335-b6aa-af74b49b4a5e@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <64f626f4-5432-4335-b6aa-af74b49b4a5e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-253429-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Queue-Id: 31F7C877FE
X-Rspamd-Action: no action

On 2026/01/26 11:35, David Ahern wrote:
> On 1/25/26 7:35 AM, Tetsuo Handa wrote:
>> syzbot is reporting
>> @@ -1330,7 +1330,13 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
>>  	__team_port_change_port_removed(port);
>>  
>>  	team_port_set_orig_dev_addr(port);
>> -	dev_set_mtu(port_dev, port->orig.mtu);
>> +	if (unregister) {
>> +		netdev_lock_ops(port_dev);
>> +		__netif_set_mtu(port_dev, port->orig.mtu);
>> +		netdev_unlock_ops(port_dev);
>> +	} else {
>> +		dev_set_mtu(port_dev, port->orig.mtu);
>> +	}
>>  	kfree_rcu(port, rcu);
>>  	netdev_info(dev, "Port device %s removed\n", portname);
>>  	netdev_compute_master_upper_features(team->dev, true);
> 
> same logic as bonding, so a netdev based helper that both drivers can use?
> 

Maybe, but that will be an another patch. No need to combine a local
bugfix patch and a multiple-users cross-modules helper patch.


