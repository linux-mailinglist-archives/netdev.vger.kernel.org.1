Return-Path: <netdev+bounces-102276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A45B90234A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887421C20CF7
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8171C13E8BD;
	Mon, 10 Jun 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="c/1kVaTk"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DCB13F439
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027642; cv=none; b=Xr0Qy2SvKEoy4HUmWEQqF6b6zMJoVesE7LaJ/jGveZZ1zAZFAF7SrFUikUJHovN5plpZu+qJD6KW1KtPmhKt2iGFF6utWOrySiIXdJtcbtIBhNsRDZuly8EhCeKBLFa3F6GKdemIV6YjBMJhnpLwXp0gDa+cXfIgKu/CHWLjPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027642; c=relaxed/simple;
	bh=74HK80MEePRdBu/CJ8AWteV04hOrE5VPTJnLpfkxP0U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hy4bj39Tf311QIVRP54d9YxS6/Cdq6RHzE6er/GQr830155/qqeSxMOPZLWspW8E8bhQWdngJgu4UylsBHblg9HPkAM0MArkdNd/XcyYzQ8PaXb/eAq1zg0N3illkHZwTskRL0ny8iN/AOOf16cI+McWRNej5spDfai/Br1t+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=c/1kVaTk; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9ggrr3gfy6DdjOUxlCn1DQ4KnkSY3muvBcae+kinbxk=; b=c/1kVaTkj852Iy9ZtZX3D6ugmz
	Pb0kym5Mw+I/Zmf+aRsfR9sXL5azYQhWdr4FtBKmsAR6yFnMTAgfEKgalbxs7BXFDYgGXpZtfrIbM
	JkZjJo6NOLsJmFoq3JMziI7/Hsn5QCOR5l6+zt/wviZBkULFCw3qWdIVRlCWF2odpbGVlzg4rOM/s
	V5i4Wi6lNAQ43yh+nr0k+hla7vpZBTBdIWXMvJT3JjYqSlOm1oV94DHPl71zTo4Rq+ZapCzl8xtEM
	E86aXJfABQAcyN9+F6RJxtMcnknzlSfzTM2rNW9Sz4wxLzcSyGmwyuezn0wT2ZTVzwM9hFOgnCN+F
	mKsEWksg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sGfSy-000NlW-SP; Mon, 10 Jun 2024 15:53:44 +0200
Received: from [178.197.248.15] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sGfSy-000Lju-0K;
	Mon, 10 Jun 2024 15:53:44 +0200
Subject: Re: [PATCH net] net: check dev->gso_max_size in gso_features_check()
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, razor@blackwall.org
References: <20231219125331.4127498-1-edumazet@google.com>
 <21ccf1acce6f4a711f6323f9392c1254135999b8.camel@redhat.com>
 <CANn89i+T6oYTNrjeQ4K7D1kYHTQgwJ1uJxCn0LY0ADPEg_bGbw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b3b738a0-0480-5b8b-3af0-b11dc214d7e2@iogearbox.net>
Date: Mon, 10 Jun 2024 15:53:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89i+T6oYTNrjeQ4K7D1kYHTQgwJ1uJxCn0LY0ADPEg_bGbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27302/Mon Jun 10 10:25:43 2024)

Hey all,

On 12/19/23 4:02 PM, Eric Dumazet wrote:
> On Tue, Dec 19, 2023 at 3:42 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On Tue, 2023-12-19 at 12:53 +0000, Eric Dumazet wrote:
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index 0432b04cf9b000628497345d9ec0e8a141a617a3..b55d539dca153f921260346a4f23bcce0e888227 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -3471,6 +3471,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>>        if (gso_segs > READ_ONCE(dev->gso_max_segs))
>>>                return features & ~NETIF_F_GSO_MASK;
>>>
>>> +     if (unlikely(skb->len >= READ_ONCE(dev->gso_max_size)))
>>
>> Since we are checking vs the limit supported by the NIC, should the
>> above be 'tso_max_size'?
>>
>> My understanding is that 'gso{,_ipv4}_max_size' is the max aggregate
>> size the device asks for, and 'tso_max_size' is the actual limit
>> supported by the NIC.
> 
> Problem is tso_max_size has been added very recently, depending on
> this would make backports tricky.
> 
> I think the fix using gso_max_size is more portable to stable
> versions, and allows the user to tweak the value,
> and build tests.
> 
> As a bonus, dev->gso_max_size is in the net_device_read_tx cacheline,
> while tso_max_size is currently far away.

We noticed in Cilium which supports both BIG TCP IPv4 as well as BIG TCP
IPv6 that when a user has configured the former but not the latter, we get
a performance regression. Meaning, kernel creates larger super packets for
IPv4, but later hits the lower IPv6 dev->gso_max_size limit. :/

Given tso_max_size is far away, would sth like the below fix be acceptable?

Thanks,
Daniel

 From 65260578ffda2969acfa5109eeef0484b7dd9193 Mon Sep 17 00:00:00 2001
From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 10 Jun 2024 12:52:22 +0000
Subject: [PATCH net] net, gso: Fix regression in BIG TCP v4 when BIG TCP v6 is not set

[ commit sg tbd ]

Fxies: 24ab059d2ebd ("net: check dev->gso_max_size in gso_features_check()")
Bisected-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
  net/core/dev.c | 9 ++++++++-
  1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4d4de9008f6f..495457891191 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3502,7 +3502,14 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
  	if (gso_segs > READ_ONCE(dev->gso_max_segs))
  		return features & ~NETIF_F_GSO_MASK;

-	if (unlikely(skb->len >= READ_ONCE(dev->gso_max_size)))
+	/* Both GSO max sizes need to be checked e.g. for the case
+	 * when BIG TCP is enabled for IPv4 but not for IPv6. This
+	 * is checking the limits supported by the NIC (tso_max_size).
+	 * However, the latter is not hot in net_device_read_tx.
+	 */
+	if (unlikely(skb->len >=
+		     max(READ_ONCE(dev->gso_max_size),
+			 READ_ONCE(dev->gso_ipv4_max_size))))
  		return features & ~NETIF_F_GSO_MASK;

  	if (!skb_shinfo(skb)->gso_type) {
-- 
2.34.1

