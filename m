Return-Path: <netdev+bounces-228449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDC4BCB2DF
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 01:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1F7F4E295A
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 23:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331002868B5;
	Thu,  9 Oct 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UJsaYFwk"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D0285C81
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760051628; cv=none; b=l7ml0NWi/g7Y/VM6lXSy9aQE9NqfIvihCEZ5XSMtSDGFmnYqMF6Gl/sfoRRZ1sK2u5p/X+cukisOrf4EU4FtGtkZC0fFpkNR9vVFwQy5N+NVeU2u5Map1aJgeiOJsot3vTw5Tda2YyO8pO954+xNmkSATugREwYbCkTzNoNAs+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760051628; c=relaxed/simple;
	bh=2Y0woEVwkK7zUi85xgMTPid34hQ9lUkcWc6b5sXKuMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjnLonrRQqhFK/e18rdJFGBTqgQVk1Sw+0e0nXlCP3lY5inH8eNr16GL1Jlzv+dqLG/XpFUyPLpqrhIUdg1kjlW7PUvipXhRP+4PR32cxajlBjrlaSjutXg64mKGkET7HtwsFDw1x7QDuAb/TNNwX0CJbU2Mq1xZWgehJPavq/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UJsaYFwk; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 Oct 2025 16:13:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760051622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DQjiBqehILJ3vCh8LnmqIJaTLowKlfThsD3H8p1fN3k=;
	b=UJsaYFwkL9rS2+AlemnXK/put4W99dsmzVmz34fbv0+I8AtfpBmAq+JOdygCqczwEE/PuA
	w2C5QFvIhKy1E5YRRWilWBaPGzZfC9FkMeKynTYmL9xlj1yDBhE3hKYwykC450HnxrsQ2K
	65x0LksMHRwvvl326p1YmqKGgdgEzRs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next/net 3/6] net: Introduce net.core.bypass_prot_mem
 sysctl.
Message-ID: <25xfv3p3nwr3isf46jcqhgawkgnbks7u4qofk3g43m6pctriss@35fwcsurb2i6>
References: <20251007001120.2661442-1-kuniyu@google.com>
 <20251007001120.2661442-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007001120.2661442-4-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 07, 2025 at 12:07:28AM +0000, Kuniyuki Iwashima wrote:
> If a socket has sk->sk_bypass_prot_mem flagged, the socket opts out
> of the global protocol memory accounting.
> 
> Let's control the flag by a new sysctl knob.
> 
> The flag is written once during socket(2) and is inherited to child
> sockets.
> 
> Tested with a script that creates local socket pairs and send()s a
> bunch of data without recv()ing.
> 
> Setup:
> 
>   # mkdir /sys/fs/cgroup/test
>   # echo $$ >> /sys/fs/cgroup/test/cgroup.procs
>   # sysctl -q net.ipv4.tcp_mem="1000 1000 1000"
>   # ulimit -n 524288
> 
> Without net.core.bypass_prot_mem, charged to tcp_mem & memcg
> 
>   # python3 pressure.py &
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
> With net.core.bypass_prot_mem=1, charged to memcg only:
> 
>   # sysctl -q net.core.bypass_prot_mem=1
>   # python3 pressure.py &
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

