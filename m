Return-Path: <netdev+bounces-226553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F832BA1E41
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 00:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87613189F30B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 22:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C834A2EB87C;
	Thu, 25 Sep 2025 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WRr/VrMM"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8DE2EA141
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840757; cv=none; b=GCAa/x/ExRzuvgAFZsb6Obg2rNr1LdKV6PQN+fP+q7PTwhLOMs2Jy9JWdu78BglUtRe2w3BRjrIYhx7U/eBdmKl0z/QVF7WzR6I8MAooMsQS0nKmx0oTgfgBQtTPmn1LWYJm9qGzcOmQqyoxxJAW+G3hWO+F6lChQIqZAfonaks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840757; c=relaxed/simple;
	bh=WAhznanMPPV/x114vb48C2Gr3rmdf6qAcqaxBQcdmSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxQ7KXJM9tlDDyOQKchpLf5qBDbpiEsUpyX9nxVAuT5HZ09moMuB+tUWwh1DAMKAo+dbnZQn61IqjCawsfzv7l9sqyK7Gu9/b486daEUlLvNcz/k0DAnwVZ6/91RgYmTKPEeTIESYxyNnMR6ghdTPJ3sifSmkWUfQKuPk3Ju424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WRr/VrMM; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Sep 2025 15:52:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758840753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5PdRgr2LdN4klqylePHdp3EBaqIkD3v5fZq2WXytDfk=;
	b=WRr/VrMMacTgquKV2I7vxs2MyEY45aYG3BfHOwNY77afxfwKRRpBD1YU1D5wuc8fOht6FL
	/idQmrYth7jV5oTtwq0CkrTcrtmf78gznJZcm0nRv1RDWQsXts9mW7oomiAKGwVa5/pcvb
	CYxmmd8bNZsQa3Ebe1dkW7b7ixe8D6o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v10 bpf-next/net 3/6] net-memcg: Introduce
 net.core.memcg_exclusive sysctl.
Message-ID: <vu55dawwasbnogwqsdjomwci3nstz6pcl7a3l7pp5gouo5ijv3@cw2msu4ks4aa>
References: <20250920000751.2091731-1-kuniyu@google.com>
 <20250920000751.2091731-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920000751.2091731-4-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 20, 2025 at 12:07:17AM +0000, Kuniyuki Iwashima wrote:
> If net.core.memcg_exclusive is 1 when sk->sk_memcg is allocated,
> the socket is flagged with SK_MEMCG_EXCLUSIVE internally and skips
> the global per-protocol memory accounting.
> 
> OTOH, for accept()ed child sockets, this flag is inherited from
> the listening socket in sk_clone_lock() and set in __inet_accept().
> This is to preserve the decision by BPF which will be supported later.
> 
> Given sk->sk_memcg can be accessed in the fast path, it would
> be preferable to place the flag field in the same cache line as
> sk->sk_memcg.
> 
> However, struct sock does not have such a 1-byte hole.
> 
> Let's store the flag in the lowest bit of sk->sk_memcg and check
> it in mem_cgroup_sk_exclusive().
> 
> Tested with a script that creates local socket pairs and send()s a
> bunch of data without recv()ing.
> 
> Setup:
> 
>   # mkdir /sys/fs/cgroup/test
>   # echo $$ >> /sys/fs/cgroup/test/cgroup.procs
>   # sysctl -q net.ipv4.tcp_mem="1000 1000 1000"
> 
> Without net.core.memcg_exclusive, charged to memcg & tcp_mem:
> 
>   # prlimit -n=524288:524288 bash -c "python3 pressure.py" &
>   # cat /sys/fs/cgroup/test/memory.stat | grep sock
>   sock 22642688 <-------------------------------------- charged to memcg
>   # cat /proc/net/sockstat| grep TCP
>   TCP: inuse 2006 orphan 0 tw 0 alloc 2008 mem 5376 <-- charged to tcp_mem
>   # ss -tn | head -n 5
>   State Recv-Q Send-Q Local Address:Port  Peer Address:Port
>   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53188
>   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:49972
>   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53868
>   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53554
>   # nstat | grep Pressure || echo no pressure
>   TcpExtTCPMemoryPressures        1                  0.0
> 
> With net.core.memcg_exclusive=1, only charged to memcg:
> 
>   # sysctl -q net.core.memcg_exclusive=1
>   # prlimit -n=524288:524288 bash -c "python3 pressure.py" &
>   # cat /sys/fs/cgroup/test/memory.stat | grep sock
>   sock 2757468160 <------------------------------------ charged to memcg
>   # cat /proc/net/sockstat | grep TCP
>   TCP: inuse 2006 orphan 0 tw 0 alloc 2008 mem 0 <- NOT charged to tcp_mem
>   # ss -tn | head -n 5
>   State Recv-Q Send-Q  Local Address:Port  Peer Address:Port
>   ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:49026
>   ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:45630
>   ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:44870
>   ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:45274
>   # nstat | grep Pressure || echo no pressure
>   no pressure
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

