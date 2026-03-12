Return-Path: <netdev+bounces-267071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP0ODM/DsmmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:46:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD193272DB6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 313A23006B73
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5681E307AE3;
	Thu, 12 Mar 2026 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TN6CDgQL"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E261400C;
	Thu, 12 Mar 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323211; cv=none; b=K9RoLmfgY74ACONBFn39QZWrn/iMkc4z6k97phIj/iJ+NgnkWOx8xFelB5yZDJOPobD+evWRW0f9BicyzeZHE+tgA5PbvstS9+x3eqXy8h1I5mffHSbk3MrJdLPNxQsiACUlSz+jSi61vpwJBXVpxp06HXeaGTOLoLSC5mBNGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323211; c=relaxed/simple;
	bh=VK+7gafAHvTyxfKIFSUbNi+SG4lYk3wkyix1ctNBytM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbWQCnK89h0jE0jieC+sehA4MqCmE3ebKYs0UfFbXSNLJlvjbrg5cjgHsxk2GE+zc+OlOQ5KY55GCJDQg3e3nq7yMXNlWPdGhq5j4LQjjZH/NZs6jp9/bMiYy+q0lvoolN6Co6N6iEQfoShhuhkhROn8GNkeeKzzSjt/6tka5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TN6CDgQL; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=xHSnv9tLXFW6xHAI8kdqvBwlRENeG50Atlr+18B0An0=;
	b=TN6CDgQLnHeBopCB2VSgbxrGIx+MSBtDkP2/zVa/qQsdnu63uKxkjdT/WqD4EZ
	2UZ1YaT94KJSjyDJ4zbSMHqxMP94AhgbjXzC8q6Qv6C+8WJuxQj6NWA8Bqzl5sMn
	ZrrQ65gP667wms6puerHh5ZrtLPCiFpOKkSSg0EIVqlDQ=
Received: from [IPV6:2408:820c:b60e:ad20:2092:3bb3:8555:f4a2] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXXmmUw7JpG7FeAg--.2565S2;
	Thu, 12 Mar 2026 21:45:57 +0800 (CST)
Message-ID: <e00bace9-3826-4308-b083-9bd10682425d@163.com>
Date: Thu, 12 Mar 2026 21:45:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] tcp: remove redundant memset in hot paths
 with CONFIG_INIT_STACK_ALL_ZERO
To: Eric Dumazet <edumazet@google.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260312124807.186341-1-jiayuan.chen@linux.dev>
 <CANn89i+urEcFJkOsE9_3nOzVa2Ee1sFb26vrNnJV-jW2z76y2w@mail.gmail.com>
From: Jiayuan Chen <mrpre@163.com>
In-Reply-To: <CANn89i+urEcFJkOsE9_3nOzVa2Ee1sFb26vrNnJV-jW2z76y2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXXmmUw7JpG7FeAg--.2565S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFW5Ar1xGw43Gw13JryfCrg_yoWkZFbEgw
	4Yyr1qy34qgrWDta1Dtr4Durs8K3yDta4jv348Xw13urs5Ja18Ja4vkr9rZ3W7Jr4jvF9F
	krs0vF4rXry2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUhSdPUUUUU==
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbC7BUdxGmyw5UBRAAA3o
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267071-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrpre@163.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD193272DB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/12/26 8:53 PM, Eric Dumazet wrote:
> On Thu, Mar 12, 2026 at 1:48 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> Modern compilers with CONFIG_INIT_STACK_ALL_ZERO enabled
>> (-ftrivial-auto-var-init=zero) automatically zero-initialize all stack
>> variables via `rep stos` in the function prologue. However, the compiler
>> cannot eliminate explicit memset() calls on those same variables,
>> resulting in redundant zeroing of the same memory region.
>>
>> Replace explicit memset() with `= {0}` initializers for stack variables
>> in TCP hot path functions. With `= {0}`, the compiler recognizes a single
>> initialization and generates only one zeroing sequence, whereas a
>> separate memset() after declaration always produces a second `rep stos`.
> No sorry. It seems you missed
>
> commit cfcceb7a39fc10a6f896af8229bf81d96acb22cc
> Author: Keita Morisaki <kmta1236@gmail.com>
> Date:   Wed Mar 4 20:15:17 2026 +0900
>
>      tcp: shrink per-packet memset in __tcp_transmit_skb()
>
> No need to resend your patch, I do not think it is a good idea.
Thanks. It seems this patch for __tcp_transmit_skb only saves a few bytes
of memset.


