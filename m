Return-Path: <netdev+bounces-279681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJenNijj5WnfowEAu9opvQ
	(envelope-from <netdev+bounces-279681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:26:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E074281BA
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E140E30098AA
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE623845DD;
	Mon, 20 Apr 2026 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDEjtn7s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21E214204;
	Mon, 20 Apr 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673572; cv=none; b=UyRVQWtdzNTT8VoR37N7hZ9Nbq5Fy8bugEy4TndjtGxkcTW8ARWah1Z6vbOKa87RtbbcWBUku9aJiH3EEtguU+nQfTNTpYgJ0/k9WWatasy5jBMZNXeI98bsF7aRzdYiRAypBapvpCBEbh+MHIngASYBsgr5jh3hhWP6MChUXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673572; c=relaxed/simple;
	bh=hatqTacSUEjbtlKRMDm5wqYoQ4FvRrpWBAKeel5SoHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jptx6k7Ozf9sO0AGgA+FYO3uBkWswXp3QqhDQDAXKLewjtMMajP5IaQ6vS+K+EImAwz7oPIxSZfsM09nHOedLC+mO+lPyZsMz63Ml7/BU674tZhsWqCPu5o/te44saeANMNFVnmxhq/dchT3z/+8E1YuOA1Xf8qgjaCMDAdkXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDEjtn7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130EBC19425;
	Mon, 20 Apr 2026 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776673572;
	bh=hatqTacSUEjbtlKRMDm5wqYoQ4FvRrpWBAKeel5SoHg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KDEjtn7sF7+FeuU8A2B0AeQPixQcZu4kMVTqOh1v1Dc0N6zlhBYLzS5h4RTC6/YGb
	 mXQC+xMWUKinU10S8ToOJUU19q4RC0FKWR3GJ1M28v6fCz+9KLn3mH1h2KSsH1qEbl
	 DeN88tOQ/hYnbL1e4V5+4TTSFsM0b5unveFIWMR6oxNxZIGTLArVT7N4BF+r5dDWd3
	 R+ajOnR6750VZF99dyW/cHlJ8bSqO3EiwuArC4FyhNyTf9bV3QYwYwj06mwNpL+Fqz
	 y6y0+nXwF+lniQKHheHmbJ6wGkiiUjtWmADlcxSwIhQkPo+KGdZpX0S02vC+grHm0t
	 0W2NOkMnYA7XA==
Message-ID: <54abe469-dc16-4ed7-a90e-c7ffd419d91e@kernel.org>
Date: Mon, 20 Apr 2026 10:26:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 1/1] mptcp: hold subflow request owners when cloning
 reqsk
Content-Language: fr
To: Yuan Tan <yuantan098@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 dsahern@kernel.org, martineau@kernel.org, geliang@kernel.org,
 daniel@iogearbox.net, kafai@fb.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, caoruide123@gmail.com,
 enjou1224z@gmail.com
References: <cover.1776149210.git.caoruide123@gmail.com>
 <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
 <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org>
 <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
 <05a19f8d-360e-41d1-bc8a-0b4caab3d354@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <05a19f8d-360e-41d1-bc8a-0b4caab3d354@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279681-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fb.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79E074281BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yuan Tan,

On 19/04/2026 11:51, Yuan Tan wrote:
> 
> On 4/16/2026 11:48 AM, Kuniyuki Iwashima wrote:
>> On Thu, Apr 16, 2026 at 10:45 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>> Hi Ren,
>>>
>>> On 15/04/2026 11:31, Ren Wei wrote:
>>>> From: Ruide Cao <caoruide123@gmail.com>
>>>>
>>>> TCP request migration clones pending request sockets with
>>>> inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
>>>> subflow_req->msk, but the cloned request does not take a new reference.
>>>>
>>>> Both the original and the cloned request can later drop the same msk in
>>>> subflow_req_destructor(), and a migrated request may keep a dangling msk
>>>> pointer after the original owner has already been released.
>>>>
>>>> Add a request_sock clone callback and let MPTCP grab a reference for cloned
>>>> subflow requests that carry an msk. This keeps ownership balanced across
>>>> both successful migrations and failed clone/insert paths without changing
>>>> other protocols.

(...)

>>>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>>>> index e961936b6be7..140a9e96ad58 100644
>>>> --- a/net/ipv4/inet_connection_sock.c
>>>> +++ b/net/ipv4/inet_connection_sock.c
>>>> @@ -954,6 +954,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
>>>>       if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(nreq)->tfo_listener)
>>>>               rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
>>> (Maybe TCP with fastopen could be this other user to call
>>> rcu_assign_pointer()? (net-next material))
>>>
>>>> +     if (req->rsk_ops->init_clone)
>>>> +             req->rsk_ops->init_clone(req, nreq);
>> I think a simple direct call is better.
>>
>> #ifdef CONFIG_MPTCP
>>     if (tcp_rsk(req)->is_mptcp)
>>         mptcp_reqsk_clone(nreq);
>> #endif
>>
>  Thank you very much for your suggestion. We will use this approach in
> the next version of the patch. Would you like us to add your
> Suggested-by tag?
No need to add a Suggested-by tag: this tag is used when the whole patch
idea has been suggested by someone. That's not the case here: we only
proposed a small modification in the code, without changing the idea.

https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


