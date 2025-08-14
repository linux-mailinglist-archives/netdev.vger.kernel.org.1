Return-Path: <netdev+bounces-213540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED30BB2589A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D921891EE4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3E22AD13;
	Thu, 14 Aug 2025 00:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j6HQjTqi"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52F2FF671
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132897; cv=none; b=tGYIkNFmfwhUG+2v6OzWoojzKMKaC8IDg+eeXwyag9Wqi0wvD/RPPcWUWqPOrR8SDx02HkkLQMjqa2J4eFDVIoJTbHXXvCHakbYFpWAmGDc+2JSxxlvoGUP2xI7CxYcWZyhyqF4ZO1Ic8ygs2Sh7HQxlZRjAzZIH8W835Iud1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132897; c=relaxed/simple;
	bh=JydQgnfv1smbfa7kiZsNg0dRzfJLvvk2h3GZdX1R0Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUQK4zXk+FJTjtQR48lPHKK5+wyO7kE6oRMyA3Et/B4JJRG8g4EGSMCJ9CP4zzgYeTIeNLeI8x4kZnmzUQ5F5RWM+np74EH18sg6wjapIwR9+kF6cGy/OuKRDZcXyDdQs4SqY2HmOXP/tnV4VuPjHnzQ++Vs0V/IkW4x79aM5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j6HQjTqi; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6c8fa06-c76c-49e7-a027-0a7b610f1e9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755132890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdHhV4i8i+lWGHS2gl9FLlu2TgUgJbbs4bD/Zxld7c4=;
	b=j6HQjTqifsSO2Uppl1+E8juWlz85WB6Puvvo38zR0af1UA37Dw9SimZLmZuB9dm1eOcmBg
	ClajNZt92ETnf/J4hcXbQq43iGyGJsz35Oj+8z3oHgpyWVoPyIp+xlvpV5UK78DWgLMmi1
	7Au6epSZeq1y5zb1TVkFgVNw6Q6r0ZU=
Date: Wed, 13 Aug 2025 17:54:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>,
 Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-13-kuniyu@google.com>
 <w6klr435a4rygmnifuujg6x4k77ch7cwoq6dspmyknqt24cpjz@bbz4wzmxjsfk>
 <CAAVpQUCU=VJxA6NKx+O1_zwzzZOxUEsG9mY+SNK+bzb=dj9s5w@mail.gmail.com>
 <oafk5om7v5vtxjmo5rtwy6ullprfaf6mk2lh4km7alj3dtainn@jql2rih5es4n>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <oafk5om7v5vtxjmo5rtwy6ullprfaf6mk2lh4km7alj3dtainn@jql2rih5es4n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/13/25 1:53 PM, Shakeel Butt wrote:
> What I think is the right approach is to have BPF struct ops based
> approach with possible callback 'is this socket under pressure' or maybe
> 'is this socket isolated' and then you can do whatever you want in those
> callbacks. In this way your can follow the same approach of caching the
> result in kernel (lower bits of sk->sk_memcg).
> 
> I am CCing bpf list to get some suggestions or concerns on this
> approach.

I have quickly looked at the set. In patch 11, it sets a bit in sk->sk_memcg.

On the bpf side, there are already cgroup bpf progs that can do bpf_setsockopt 
on a sk, so the same can be done here. The bpf_setsockopt does not have to set 
option/knob that is only available in the uapi in case we don't want to expose 
this to the user space.

The cgroup bpf prog (BPF_CGROUP_INET_SOCK_CREATE) can already be run when a 
"inet" sock is created. This hook (i.e. attach_type) does not have access to 
bpf_setsockopt but should be easy to add.

For more comprehensive mem charge policy that needs new bpf hook, that probably 
will need struct_ops instead of another cgroup attach_type but that will be 
implementation details.

