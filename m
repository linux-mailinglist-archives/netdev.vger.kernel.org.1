Return-Path: <netdev+bounces-254192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP4qOXjoeWkF1AEAu9opvQ
	(envelope-from <netdev+bounces-254192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:44:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 608969FA17
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D38A3009B2B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0BF2D97B9;
	Wed, 28 Jan 2026 10:44:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48929B78F
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597046; cv=none; b=asgHi6+5rKf75suq3Y/Aq9ppmoNQRFTAgJQD8jyOLmL/U01IdgGO0Mfl86hUBXfT9Ixg1RnbEKqaZmNWp/zkjCPAMrNyOglTMi0qDkWnNH7xt7tAObrjvvHOSmf0vNIqoG/2WnHhmnUx3LAXMKhjLEnxQZeK3aX2L0RJFVcNido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597046; c=relaxed/simple;
	bh=FNRCAWh+CuHM+pPc1M86BGYXZ7Bpa3pTdXUTnKlPNzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YARk+21RQoKRLuEnUX7HMWcQKQYaKfZYCqlsyCVYtTzHARZMQrvZVlxz2zAs5UbPa9zKZOSop9xoTmf+oRDGZnIHcJOxcaF1G49QkWzGINGBtG3jXn6TwNziykHMAoKO2i9/dZrgcwrJkaD7OvobA9mgUXW3T8YVQeT34ihf0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60SAi4TK010117;
	Wed, 28 Jan 2026 19:44:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60SAi49M010113
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 28 Jan 2026 19:44:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
Date: Wed, 28 Jan 2026 19:44:02 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Ilan Tayari <ilant@mellanox.com>, Guy Shapiro <guysh@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Network Development <netdev@vger.kernel.org>,
        Sabrina Dubroca <sd@queasysnail.net>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
 <20260128102404.GC12149@unreal>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260128102404.GC12149@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254192-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[I-love.SAKURA.ne.jp:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 608969FA17
X-Rspamd-Action: no action

On 2026/01/28 19:24, Leon Romanovsky wrote:
> I think this can work, but IMHO the more robust approach is to ensure that all
> states and policies are removed when the NETIF_F_HW_ESP feature bit is cleared.

The transaction will become complicated, for dev->features manipulation
function can fail.

> 
> Would it be possible to handle this in NETDEV_FEAT_CHANGE?
> 

Is there a guarantee that xfrm_dev_event(NETDEV_FEAT_CHANGE) is called
regardless of other callback functions, for it can return NOTIFY_BAD ?


