Return-Path: <netdev+bounces-253070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s4VTN0+qdGkt8gAAu9opvQ
	(envelope-from <netdev+bounces-253070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 12:17:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA017D598
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 12:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4481B3009F9D
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EDA33985;
	Sat, 24 Jan 2026 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4qTGimv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2AC3EBF01;
	Sat, 24 Jan 2026 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769253452; cv=none; b=LZL8PKuTPwkkOSuKBeCvQqgcERAgW/kK71b6drqGq83WSa7ZWmC7Fquy0DC/RY0XpTBdXxN74//djtIb+LEQmKp+65nqpVzyQKVOxOyuic2RYU1iMotz5r+Jj5dWDF6IFN3NSlTRiowlsNKTmPe5oFGl+GpWeLs1s6n2RiMq8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769253452; c=relaxed/simple;
	bh=swTB1VV0MSkJFnpGasvXofWbJ5WKr9WceWhExY7sfgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LP+Gck+jnlW8NztlAYTRisN5aKWSZfB1ZMi7LhmamLVCEm1riLD/KKMiN9oDSt1ywKeJXXqPjtp+EIu2v/uIYdms8oI/U7N8s9mefMDGhPPtXjixkGg2H0BgOD2CfqImyDLnboqji5Ad+u7L0caQEDXUeWcyfasr71H76cBXUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4qTGimv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66E9C116D0;
	Sat, 24 Jan 2026 11:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769253451;
	bh=swTB1VV0MSkJFnpGasvXofWbJ5WKr9WceWhExY7sfgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A4qTGimvaYSWEg3+JcrUcrW/DidMRvdqHwZv0OnX4uzV3xWsTdx4UEAnSI0t0+9KG
	 8clIdpHb5H27aidBqZhV/O57JZ+PmstsVQkAuN59w3MxFo6doY7dIfJpOTHuM8YQYt
	 36z6pukf8eQUPwx5PF71ejRooJ5BBjH+tEd+EhkEmEEo33A3VcOlWBER337s10Xzva
	 bSHmtfqj5F2pmkkbVlQnvBnVaQEDxlu9oUy9W8U7dunshHqRA44JUtCsGbAJbGpS34
	 W041iqq2xMSGFzR+H/0iKyxaZwPfJgJRi5SwkoA121dox8K6k/N2UOs+SCQS8Pglcy
	 xHmQ2DtfmquBw==
Message-ID: <9255c8f1-713d-4a04-80bc-da856b8f9c71@kernel.org>
Date: Sat, 24 Jan 2026 12:17:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Geliang Tang <geliang.tang@linux.dev>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, eric.dumazet@gmail.com,
 syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com,
 Eulgyu Kim <eulgyukim@snu.ac.kr>, Geliang Tang <geliang@kernel.org>
References: <20260123030327.3041148-1-edumazet@google.com>
 <36367d05-e05f-c86b-7125-e98b529f9d0c@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <36367d05-e05f-c86b-7125-e98b529f9d0c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,linux.dev,strlen.de,vger.kernel.org,lists.linux.dev,gmail.com,syzkaller.appspotmail.com,snu.ac.kr];
	TAGGED_FROM(0.00)[bounces-253070-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,5498a510ff9de39d37da];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EFA017D598
X-Rspamd-Action: no action

Hi Mat, Eric,

On 23/01/2026 22:43, Mat Martineau wrote:
> On Fri, 23 Jan 2026, Eric Dumazet wrote:
> 
>> syzbot and Eulgyu Kim reported crashes in mptcp_pm_nl_get_local_id()
>> and/or mptcp_pm_nl_is_backup()
>>
>> Root cause is list_splice_init() in mptcp_pm_nl_flush_addrs_doit()
>> which is not RCU ready.
>>
>> list_splice_init_rcu() can not be called here while holding pernet->lock
>> spinlock.
>>
>> Many thanks to Eulgyu Kim for providing a repro and testing our patches.
>>
>> Fixes: 141694df6573 ("mptcp: remove address when netlink flushes addrs")
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Reported-by: syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/
>> all/6970a46d.a00a0220.3ad28e.5cf0.GAE@google.com/T/
>> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
>> Cc: Geliang Tang <geliang@kernel.org>
>> ---
>> v2: Make sure the list was not empty, return early otherwise.
> 
> Thanks Eric, the v2 code changes LGTM.

Thank you for the patch and the review!

> The netdev tooling wasn't able to
> apply the patch (https://patchwork.kernel.org/project/netdevbpf/
> patch/20260123030327.3041148-1-edumazet@google.com/), so Matthieu is
> planning to send a basically-identical v3 that 'git am' and the netdev
> CI will be happy with.

Just did:


https://lore.kernel.org/20260124-net-mptcp-race_nl_flush_addrs-v3-1-b2dc1b613e9d@kernel.org

I guess we need to manually update Patchwork if the sender is different:

pw-bot: superseded

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


