Return-Path: <netdev+bounces-106875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB0917ED5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA391C20ABC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF417C22E;
	Wed, 26 Jun 2024 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cRIEn1au"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C11B17B50B
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398949; cv=none; b=lBdJ+9kEELOFe5lOTWGOyTQ0Kd2cTN6mOqjmow3jCFD1LfoWGx4mSZd6aawfMT6blky78qWGIe64bkUOaaFFxX7kqHXszO/jMBKQkYOsiTNuV030QQdgoCkmtxGnYzQG5hRJGvzn1fQCptl8rfviFOfoz5eaY2NTeB1Gm6NTZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398949; c=relaxed/simple;
	bh=s80ccFh24RTi0NFrkbQBnZRyBYDTkV5PszrdrACiOEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+kyGggVzFVrNWwjaSUdxHjhUnjPrEWWTAUDBx6RHo3JR1dO8enacheQmS/gcI6THD9wmX3E2pvQvGm138iZhSyQZZ7Fcon2TVvySkyg1flHbrImP2LwfmjKRF1jPsd0G2D6mlFZUR8FsDokTUgO6dxHr/NZO/kosgjk3QoKD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cRIEn1au; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sMQCq-001C4Q-Ii; Wed, 26 Jun 2024 12:48:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=K9tSH4kUxI6gI0hHetHcegtKDhrXdFy25jrZNgtW1zE=; b=cRIEn1au20jc2VYLURXP7Ruj8z
	n4vve4W+gGO34k3IUxDjbdshbxbojCyGqlKbKjqxlAg4y3dwrNs/NzMC+PhYpP7PuKaMLZF9dcaMA
	d7cbUA9Qk4mdyyYpjPJQvlogqLXZCmYH4jpXf0CerUVW2E4wTxZ/zck24WasgRllONfrMiYXGBYLo
	bU1W+6ZAbDj40NaPqhXbtlkyzez5LJT2VHADaKzSYBMrVD382mWK0oJZBDxKAqVgSxt+3fcRfflqx
	r0lpwHHZIuaQCoSSJiC5niXyxj5xxzP24AXrG05j0kpb81jqSxjPzEvCdOgpSz7gVCuNJskxI52FD
	OuYmWxzw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sMQCp-0000w7-B3; Wed, 26 Jun 2024 12:48:51 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sMQCS-007QQ8-Ta; Wed, 26 Jun 2024 12:48:28 +0200
Message-ID: <c550e27c-6a45-4219-98d8-f6d237c0674e@rbox.co>
Date: Wed, 26 Jun 2024 12:48:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under
 unix_state_lock() for truly disconencted peer.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <2d34e8df-cbb0-486a-976b-c5c72554e184@rbox.co>
 <20240623051906.79744-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240623051906.79744-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/24 07:19, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Sun, 23 Jun 2024 00:43:27 +0200
>> I gotta ask, is there a reason for unlinking an already consumed
>> ('consumed' as in 'unix_skb_len(skb) == 0') skb so late, in manage_oob()?
>> IOW, can't it be unlinked immediately once it's consumed in
>> unix_stream_recv_urg()? I suppose that would simplify things.
> 
> I also thought that before, but we can't do that.
> 
> Even after reading OOB data, we need to remember the position
> and break recv() at that point.  That's why the skb is unlinked
> in manage_oob() rather than unix_stream_recv_urg().

Ahh, I see. Thanks for explaining.

One more thing about unix sockmap. AF_UNIX SOCK_DGRAM supports 0-length
packets. But sockmap doesn't handle that; once a 0-length skb/msg is in the
psock queue, unix_bpf_recvmsg() starts throwing -EFAULT. Sockmap'ed AF_INET
SOCK_DGRAM does the same, so is this a bug or a feature?


