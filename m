Return-Path: <netdev+bounces-271256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOl7Blzlwmm/nAQAu9opvQ
	(envelope-from <netdev+bounces-271256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:26:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D7B31B7B9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45BBD3082876
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B3F3BED40;
	Tue, 24 Mar 2026 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paj7Kt5z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936803B38A9
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379382; cv=none; b=oKROvKM0lMS9c/ESL8oj/TI+rkt51dxQi+IBYmfUyVslEnUOHAMa0kogNgcC88+/JgtkvGZkI4YQx20Ti/q/+3BYuOgA1g7BKDo1F4y6j39iZn8v4K5ErXM0Q9GbopBvfoS+t2ZxOG34Py+K2Nn0rqh5+HAFOuRzyITf0zwB/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379382; c=relaxed/simple;
	bh=fTuQNWUzWDbINCxBORfSuUo2qq+x1vcH9Vu8CGY+h5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZrnGQdRZMJKO/79NN1JD53bbOJeaeJ8pPo0SIxDJoQcnTyajveFNU0v7z5jrNsQgDabxBx0mHIIxi4UvQdZWIifVl4yfMUvVlNsRyhtIhBttK3JYav6vHigx6yL8agfSnm6/fEasuk7OVfNtfa0Bv8JtzQolxDTpg+G7xLGHgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paj7Kt5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C2BC4AF09;
	Tue, 24 Mar 2026 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774379381;
	bh=fTuQNWUzWDbINCxBORfSuUo2qq+x1vcH9Vu8CGY+h5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=paj7Kt5zjTrZMqipnVMHXKk8y6eYuEzGueUfi4Pk3TEpTPvpdp+mI+oEy34VeaX7Y
	 IL5XGtc8xdILB9moRrEpg3h3mmHsUU1ZL9yywNBNAFLf/l5MoBkf3EH/gjOypHVaXX
	 Hxq+etB7gT3bKHTI0YqACsHPk7BU/lS7KyBeks4872t0vpdcftIFA2auE/0JmULklr
	 gv7fZDTaMz75ceCnoB2dMACP4jzl39Dhw0Ldha3hysrdxxAkowhqgl0evN09CUUfH9
	 LCf2p/seuKrggNEbXu6mcL/gtQ6BhN1N2dxL0xe+i60nGTFC+WFgWRrf9xLR1J91Aw
	 s81xVsSNY8wCg==
Message-ID: <bcb5939f-4846-4b81-9031-ca8053a303e5@kernel.org>
Date: Tue, 24 Mar 2026 13:09:40 -0600
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
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, petrm@nvidia.com,
 lirongqing@baidu.com
References: <20260324155521.525292-1-idosch@nvidia.com>
 <20260324155521.525292-4-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260324155521.525292-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271256-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70D7B31B7B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 9:55 AM, Ido Schimmel wrote:
> vrf_rtable_release() and vrf_rt6_release() are called as part of the VRF
> device's ndo_uninit() callback. As such, an RCU grace period passes
> between the removal of the VRF slaves and the closing of the VRF device
> until these functions are invoked.
> 
> Therefore, it should not be possible for any concurrent RCU readers to
> try and acquire a reference on the dst entry while we are potentially
> releasing the last reference via dst_release().
> 
> Given the above, the synchronize_rcu() invocations in these functions
> seem unnecessary and only add unnecessary delay when deleting VRF
> devices. Remove them.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vrf.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


