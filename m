Return-Path: <netdev+bounces-117609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAA094E854
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC0E1C209DA
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888031474D3;
	Mon, 12 Aug 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="swmuNEHl"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5AE4D8D1
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450491; cv=none; b=Mj2eFWlUfB1sjw8aGNVR+boZKsey2EIMDQnblTIUrQKmlTK8x856D4QD6U77fVabwXti5AlS8Dcnuzsmk1QzqJ2EdcwxRzrV1u1ULc0JYjC9Iq5J2hIah25LxlDECnSHcWfViE9m6nY9V5x8AIoHbXYbf9DyZywpe4tdL17FLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450491; c=relaxed/simple;
	bh=0DVxX2nhRCf7YWnC4ho0dzf4AHaV4sX4yPCXiKOOuDA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=ZknxfydwczPCOlNez+HHRhwnRDrXhyVYGSE7nBcOEdvUzlhYYdvlz08HkOLaLa1ejAWogPmsQsNmNNDrcViOuW26EGbQZAxzE2odVhHEYCPtjl8+/5f/23cq+nHyExlOiYpB40AmcN+1d1G202/35iUNAbxu7x7cV/zEgE7ZOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=swmuNEHl; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:e533:7058:72ab:8493] (unknown [IPv6:2a02:8010:6359:1:e533:7058:72ab:8493])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id C90D27D51B;
	Mon, 12 Aug 2024 09:14:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723450482; bh=0DVxX2nhRCf7YWnC4ho0dzf4AHaV4sX4yPCXiKOOuDA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<6730f50c-929d-aaed-0282-60eb321f8679@katalix.com>|
	 Date:=20Mon,=2012=20Aug=202024=2009:14:42=20+0100|MIME-Version:=20
	 1.0|To:=20Cong=20Wang=20<xiyou.wangcong@gmail.com>|Cc:=20netdev@vg
	 er.kernel.org,=20davem@davemloft.net,=20edumazet@google.com,=0D=0A
	 =20kuba@kernel.org,=20pabeni@redhat.com,=20dsahern@kernel.org,=20t
	 parkin@katalix.com,=0D=0A=20horms@kernel.org|References:=20<cover.
	 1723011569.git.jchapman@katalix.com>=0D=0A=20<0ed95752e184f213260e
	 84b4ff3ee4f4bedeed9e.1723011569.git.jchapman@katalix.com>=0D=0A=20
	 <ZrkEofKqANg/9sTB@pop-os.localdomain>|From:=20James=20Chapman=20<j
	 chapman@katalix.com>|Subject:=20Re:=20[PATCH=20v2=20net-next=206/9
	 ]=20l2tp:=20use=20get_next=20APIs=20for=20management=0D=0A=20reque
	 sts=20and=20procfs/debugfs|In-Reply-To:=20<ZrkEofKqANg/9sTB@pop-os
	 .localdomain>;
	b=swmuNEHlzYf38qmtXvXqO9UzapXKXDXKfWKCTXYQmxbEiZmGl4HWvNMZ7Eye5zJEm
	 wElebG2EXU4Ka/SjPRMMb/YSkE1brEUnLkBKfCy6ybJ0LqdvYoU9ncR9x2T9TufvlY
	 LH4NuutN++oNBFvuhW2hyzNeRLY0qEFixtdCOdrCSFq41zyeytL5vWPhUElb6B1KKy
	 mWm4o2rKS7h5i5jgnMGygnD6O8WtKG+iWH8PWmAzXludqeypKdz7hJ71M7eYtN1moI
	 vecQRX9DA669OgeAgHumM0jVW/3FRr6JpXCfXJ3Al3VDLT9ORNMwow3Wl2c+Pdg3/i
	 HykQeVd8eGKPA==
Message-ID: <6730f50c-929d-aaed-0282-60eb321f8679@katalix.com>
Date: Mon, 12 Aug 2024 09:14:42 +0100
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
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH v2 net-next 6/9] l2tp: use get_next APIs for management
 requests and procfs/debugfs
In-Reply-To: <ZrkEofKqANg/9sTB@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2024 19:36, Cong Wang wrote:
> On Wed, Aug 07, 2024 at 07:54:49AM +0100, James Chapman wrote:
>> diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
>> index cc464982a7d9..0fabacffc3f3 100644
>> --- a/net/l2tp/l2tp_core.h
>> +++ b/net/l2tp/l2tp_core.h
>> @@ -219,14 +219,12 @@ void l2tp_session_dec_refcount(struct l2tp_session *session);
>>    * the caller must ensure that the reference is dropped appropriately.
>>    */
>>   struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id);
>> -struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth);
>>   struct l2tp_tunnel *l2tp_tunnel_get_next(const struct net *net, unsigned long *key);
>>   
>>   struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id);
>>   struct l2tp_session *l2tp_v2_session_get(const struct net *net, u16 tunnel_id, u16 session_id);
>>   struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
>>   				      u32 tunnel_id, u32 session_id);
>> -struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth);
>>   struct l2tp_session *l2tp_session_get_next(const struct net *net, struct sock *sk, int pver,
>>   					   u32 tunnel_id, unsigned long *key);
>>   struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
>> diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
>> index 8755ae521154..b2134b57ed18 100644
>> --- a/net/l2tp/l2tp_debugfs.c
>> +++ b/net/l2tp/l2tp_debugfs.c
>> @@ -34,8 +34,8 @@ static struct dentry *rootdir;
>>   struct l2tp_dfs_seq_data {
>>   	struct net	*net;
>>   	netns_tracker	ns_tracker;
>> -	int tunnel_idx;			/* current tunnel */
>> -	int session_idx;		/* index of session within current tunnel */
>> +	unsigned long tkey;		/* lookup key of current tunnel */
>> +	unsigned long skey;		/* lookup key of current session */
> 
> Any reason to change the type from int to unsigned long?
> 
> Asking because tunnel ID remains to be 32bit unsigned int as a part of
> UAPI.
> 
> Thanks.

It's used as the key in and potentially modified by idr_get_next_ul calls.


