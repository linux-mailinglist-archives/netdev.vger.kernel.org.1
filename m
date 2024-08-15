Return-Path: <netdev+bounces-118759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C11952AE6
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C980282928
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3755C19AD87;
	Thu, 15 Aug 2024 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="WeFcBGqI"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8482317A5A6
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710122; cv=none; b=n45/BkigGdHicy5dD0JppUz8ALmJayDHVhu4J/wt/8kD8K+qr1PTEjH460tcOyBJSqLDLmR0aONl77ZtggS2lQ+BOPZGplg1MmDFRKXEgjVAM0pfs+6xgmeYn6roq1vMlxI+CBWABuYog9KrUhAifZqAWrH6fM4YNhfVvF6Gi/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710122; c=relaxed/simple;
	bh=/k262+9nm7PnWr5YMPw3eKUPZw3IyomYZig0AX68kqs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=Mj0wFEylMgZIH5+cW63wnYvcOo4uIlh+4xUkW2nMC895w3qYhtC+5pxfV/YKUs3q4ayaOvqkZ36LbxjXl2lvbIo677EP4Ek2gN7BBE2theXWVIpncP/laIczdagGsiKaeXQQ/8TmBhjbsntxXZi0CoqGrQJbRQ6EJOesM9/+cto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=WeFcBGqI; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:e533:7058:72ab:8493] (unknown [IPv6:2a02:8010:6359:1:e533:7058:72ab:8493])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 902727D8E0;
	Thu, 15 Aug 2024 09:21:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723710119; bh=/k262+9nm7PnWr5YMPw3eKUPZw3IyomYZig0AX68kqs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<af59ddd7-97cf-c91f-5d46-31675bd586ae@katalix.com>|
	 Date:=20Thu,=2015=20Aug=202024=2009:21:59=20+0100|MIME-Version:=20
	 1.0|To:=20Cong=20Wang=20<xiyou.wangcong@gmail.com>|Cc:=20netdev@vg
	 er.kernel.org,=20davem@davemloft.net,=20edumazet@google.com,=0D=0A
	 =20kuba@kernel.org,=20pabeni@redhat.com,=20dsahern@kernel.org,=20t
	 parkin@katalix.com,=0D=0A=20horms@kernel.org|References:=20<cover.
	 1723011569.git.jchapman@katalix.com>=0D=0A=20<0ed95752e184f213260e
	 84b4ff3ee4f4bedeed9e.1723011569.git.jchapman@katalix.com>=0D=0A=20
	 <ZrkEofKqANg/9sTB@pop-os.localdomain>=0D=0A=20<6730f50c-929d-aaed-
	 0282-60eb321f8679@katalix.com>=0D=0A=20<Zrzx0RimFyQw063m@pop-os.lo
	 caldomain>|From:=20James=20Chapman=20<jchapman@katalix.com>|Subjec
	 t:=20Re:=20[PATCH=20v2=20net-next=206/9]=20l2tp:=20use=20get_next=
	 20APIs=20for=20management=0D=0A=20requests=20and=20procfs/debugfs|
	 In-Reply-To:=20<Zrzx0RimFyQw063m@pop-os.localdomain>;
	b=WeFcBGqI1uvDIATE/AvAL26Uy11My0H484Hh6faWg+9SJeQEjOTUrrvEc7fTvBu8l
	 y19Qt5WLcLsmwvUHEob4h6xfNW1JRX9rH5IVmKGRN4j7QSHlzcNjNqGrE4V31GuAcb
	 V0r02X7HaLgwiHw/R3XfFqIS2UtoytSz7YByO0rbHTutoIRhakkpLeS8RWROLzRLI1
	 OvrijIBQ+1x+4XOQNtvUtTQ7/LEAsjQYPKfI/Skr7VrKqnPrcy+dL9YFcvF6U4aKKV
	 fnEbk6GaZLrjeRbV1OJzdaBKMpzfwmB48gdizcb0ZRItuyjbbynO2TbPD98QmXXZ4V
	 aP4E4wvQEh5Jg==
Message-ID: <af59ddd7-97cf-c91f-5d46-31675bd586ae@katalix.com>
Date: Thu, 15 Aug 2024 09:21:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com,
 horms@kernel.org
References: <cover.1723011569.git.jchapman@katalix.com>
 <0ed95752e184f213260e84b4ff3ee4f4bedeed9e.1723011569.git.jchapman@katalix.com>
 <ZrkEofKqANg/9sTB@pop-os.localdomain>
 <6730f50c-929d-aaed-0282-60eb321f8679@katalix.com>
 <Zrzx0RimFyQw063m@pop-os.localdomain>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH v2 net-next 6/9] l2tp: use get_next APIs for management
 requests and procfs/debugfs
In-Reply-To: <Zrzx0RimFyQw063m@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2024 19:05, Cong Wang wrote:
> On Mon, Aug 12, 2024 at 09:14:42AM +0100, James Chapman wrote:
>> On 11/08/2024 19:36, Cong Wang wrote:
>>> On Wed, Aug 07, 2024 at 07:54:49AM +0100, James Chapman wrote:
>>>> diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
>>>> index cc464982a7d9..0fabacffc3f3 100644
>>>> --- a/net/l2tp/l2tp_core.h
>>>> +++ b/net/l2tp/l2tp_core.h
>>>> @@ -219,14 +219,12 @@ void l2tp_session_dec_refcount(struct l2tp_session *session);
>>>>     * the caller must ensure that the reference is dropped appropriately.
>>>>     */
>>>>    struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id);
>>>> -struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth);
>>>>    struct l2tp_tunnel *l2tp_tunnel_get_next(const struct net *net, unsigned long *key);
>>>>    struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id);
>>>>    struct l2tp_session *l2tp_v2_session_get(const struct net *net, u16 tunnel_id, u16 session_id);
>>>>    struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
>>>>    				      u32 tunnel_id, u32 session_id);
>>>> -struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth);
>>>>    struct l2tp_session *l2tp_session_get_next(const struct net *net, struct sock *sk, int pver,
>>>>    					   u32 tunnel_id, unsigned long *key);
>>>>    struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
>>>> diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
>>>> index 8755ae521154..b2134b57ed18 100644
>>>> --- a/net/l2tp/l2tp_debugfs.c
>>>> +++ b/net/l2tp/l2tp_debugfs.c
>>>> @@ -34,8 +34,8 @@ static struct dentry *rootdir;
>>>>    struct l2tp_dfs_seq_data {
>>>>    	struct net	*net;
>>>>    	netns_tracker	ns_tracker;
>>>> -	int tunnel_idx;			/* current tunnel */
>>>> -	int session_idx;		/* index of session within current tunnel */
>>>> +	unsigned long tkey;		/* lookup key of current tunnel */
>>>> +	unsigned long skey;		/* lookup key of current session */
>>>
>>> Any reason to change the type from int to unsigned long?
>>>
>>> Asking because tunnel ID remains to be 32bit unsigned int as a part of
>>> UAPI.
>>>
>>> Thanks.
>>
>> It's used as the key in and potentially modified by idr_get_next_ul calls.
> 
> idr_get_next() takes an `int` ID. So the reason is not this API, it must be
> something else.
> 

l2tp doesn't use idr_get_next; it uses idr_get_next_ul which takes an 
unsigned long. An int isn't big enough for a u32 tunnel ID value in 
32-bit architectures without potentially going negative.

The previous code used an int tunnel_idx as input for 
l2tp_tunnel_get_nth. This is replaced by l2tp_tunnel_get_next which gets 
the next item from an entry given by a key where key is a tunnel ID. The 
next item is a tunnel with the next highest tunnel ID, hence going 
negative would cause problems.


