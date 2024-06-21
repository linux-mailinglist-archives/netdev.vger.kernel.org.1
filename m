Return-Path: <netdev+bounces-105766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCDE912B3B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE8C1C2139A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D85015FA65;
	Fri, 21 Jun 2024 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="U9FiBSII"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D7010A39
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986917; cv=none; b=R/ITpsmFwqNsM1GHDMwGeIUfeNUdgUly6/z3N1TEdYFSLELBMDcc42ANKUqMFikcZCZpkrP2mTBYNCiv8lUxj7BpbqNmmGbXCy4y5S+2Mwp+CL0qYrz5++C6v1H2abGEHTfTyYCujla4vCATzpYa2Tq9Za1BqquUUxeB4wFLez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986917; c=relaxed/simple;
	bh=W9/1aN5XOM9LlPfkaczUZMVgDp9ghbBMUCwpF6c+RBY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=drO1+ugpymbOpzId9dUpWQuxdXYD6TquL05tDDakRtlfEf+UWmhG+3mjRf7REwuXEUbPV2f8mwx4Y7Ix6iVtB0mYFhWvY7OmBIruUHkfNx8trlSMQI+1e89MiGH1q+rNRNHntqy0fQrGLm4rTg39XvWC9whH0Px9kLY4O4nk6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=U9FiBSII; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:e181:9992:7c46:d034] (unknown [IPv6:2a02:8010:6359:2:e181:9992:7c46:d034])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 263EC7D853;
	Fri, 21 Jun 2024 17:21:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1718986909; bh=W9/1aN5XOM9LlPfkaczUZMVgDp9ghbBMUCwpF6c+RBY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<e24ecc91-8fb4-fbd2-374a-2d1af2d8d3d7@katalix.com>|
	 Date:=20Fri,=2021=20Jun=202024=2017:21:48=20+0100|MIME-Version:=20
	 1.0|To:=20Simon=20Horman=20<horms@kernel.org>|Cc:=20netdev@vger.ke
	 rnel.org,=20gnault@redhat.com,=20samuel.thibault@ens-lyon.org,=0D=
	 0A=20ridge.kennedy@alliedtelesis.co.nz|References:=20<cover.171887
	 7398.git.jchapman@katalix.com>=0D=0A=20<22cdf8d419a6757be449cbeb5b
	 69203d3bb3d2dd.1718877398.git.jchapman@katalix.com>=0D=0A=20<20240
	 621125940.GE1098275@kernel.org>|From:=20James=20Chapman=20<jchapma
	 n@katalix.com>|Subject:=20Re:=20[PATCH=20net-next=202/8]=20l2tp:=2
	 0store=20l2tpv3=20sessions=20in=20per-net=20IDR|In-Reply-To:=20<20
	 240621125940.GE1098275@kernel.org>;
	b=U9FiBSIIH7Bd8zlnaHDLtPi6+jcvyCKWliSJUfoHhUD8R5EiZhCNKA6Hb0qZ8Tntv
	 sZ3nJDTNgBtyWxHoRyCidNhM3d+WyhdUorOz2Z46Ly0/0wc4BmIbB3QgfaM7UfVMvx
	 p99GwBX94zlFB3leDtwrOarV4pcfAOWgq5d8Mgf0+WRdBYqqkMsGRswOtEm5gpyI4W
	 oItKdv32B8d/CCW5Ztt9dzLPGSNf8Ifh3f/OePX9/QA3SQUcVeauM3MS6R1Aq8OM0X
	 EbMFanuJw2SEVqDDerw9kZ7fOSiLdKeJHtibhyxyQDUh1VuuKpg0VX9jeF9LAKwzjJ
	 l6YGxqXdbenyg==
Message-ID: <e24ecc91-8fb4-fbd2-374a-2d1af2d8d3d7@katalix.com>
Date: Fri, 21 Jun 2024 17:21:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, gnault@redhat.com, samuel.thibault@ens-lyon.org,
 ridge.kennedy@alliedtelesis.co.nz
References: <cover.1718877398.git.jchapman@katalix.com>
 <22cdf8d419a6757be449cbeb5b69203d3bb3d2dd.1718877398.git.jchapman@katalix.com>
 <20240621125940.GE1098275@kernel.org>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next 2/8] l2tp: store l2tpv3 sessions in per-net IDR
In-Reply-To: <20240621125940.GE1098275@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/06/2024 13:59, Simon Horman wrote:
> On Thu, Jun 20, 2024 at 12:22:38PM +0100, James Chapman wrote:
>> L2TPv3 sessions are currently held in one of two fixed-size hash
>> lists: either a per-net hashlist (IP-encap), or a per-tunnel hashlist
>> (UDP-encap), keyed by the L2TPv3 32-bit session_id.
>>
>> In order to lookup L2TPv3 sessions in UDP-encap tunnels efficiently
>> without finding the tunnel first via sk_user_data, UDP sessions are
>> now kept in a per-net session list, keyed by session ID. Convert the
>> existing per-net hashlist to use an IDR for better performance when
>> there are many sessions and have L2TPv3 UDP sessions use the same IDR.
>>
>> Although the L2TPv3 RFC states that the session ID alone identifies
>> the session, our implementation has allowed the same session ID to be
>> used in different L2TP UDP tunnels. To retain support for this, a new
>> per-net session hashtable is used, keyed by the sock and session
>> ID. If on creating a new session, a session already exists with that
>> ID in the IDR, the colliding sessions are added to the new hashtable
>> and the existing IDR entry is flagged. When looking up sessions, the
>> approach is to first check the IDR and if no unflagged match is found,
>> check the new hashtable. The sock is made available to session getters
>> where session ID collisions are to be considered. In this way, the new
>> hashtable is used only for session ID collisions so can be kept small.
>>
>> For managing session removal, we need a list of colliding sessions
>> matching a given ID in order to update or remove the IDR entry of the
>> ID. This is necessary to detect session ID collisions when future
>> sessions are created. The list head is allocated on first collision
>> of a given ID and refcounted.
>>
>> Signed-off-by: James Chapman <jchapman@katalix.com>
>> Reviewed-by: Tom Parkin <tparkin@katalix.com>
> 
> ...
> 
>> @@ -358,39 +460,45 @@ int l2tp_session_register(struct l2tp_session *session,
>>   		}
>>   
>>   	if (tunnel->version == L2TP_HDR_VER_3) {
>> -		pn = l2tp_pernet(tunnel->l2tp_net);
>> -		g_head = l2tp_session_id_hash_2(pn, session->session_id);
>> -
>> -		spin_lock_bh(&pn->l2tp_session_hlist_lock);
>> -
>> +		session_key = session->session_id;
>> +		spin_lock_bh(&pn->l2tp_session_idr_lock);
>> +		err = idr_alloc_u32(&pn->l2tp_v3_session_idr, NULL,
>> +				    &session_key, session_key, GFP_ATOMIC);
>>   		/* IP encap expects session IDs to be globally unique, while
>> -		 * UDP encap doesn't.
>> +		 * UDP encap doesn't. This isn't per the RFC, which says that
>> +		 * sessions are identified only by the session ID, but is to
>> +		 * support existing userspace which depends on it.
>>   		 */
>> -		hlist_for_each_entry(session_walk, g_head, global_hlist)
>> -			if (session_walk->session_id == session->session_id &&
>> -			    (session_walk->tunnel->encap == L2TP_ENCAPTYPE_IP ||
>> -			     tunnel->encap == L2TP_ENCAPTYPE_IP)) {
>> -				err = -EEXIST;
>> -				goto err_tlock_pnlock;
>> -			}
>> +		if (err == -ENOSPC && tunnel->encap == L2TP_ENCAPTYPE_UDP) {
>> +			struct l2tp_session *session2;
>>   
>> -		l2tp_tunnel_inc_refcount(tunnel);
>> -		hlist_add_head_rcu(&session->global_hlist, g_head);
>> -
>> -		spin_unlock_bh(&pn->l2tp_session_hlist_lock);
>> -	} else {
>> -		l2tp_tunnel_inc_refcount(tunnel);
>> +			session2 = idr_find(&pn->l2tp_v3_session_idr,
>> +					    session_key);
>> +			err = l2tp_session_collision_add(pn, session, session2);
>> +		}
>> +		spin_unlock_bh(&pn->l2tp_session_idr_lock);
>> +		if (err == -ENOSPC)
>> +			err = -EEXIST;
>>   	}
>>   
> 
> Hi James,
> 
> I believe that when the if condition above is false, then err will be
> uninitialised here.
> 
> If so, as this series seems to have been applied,
> could you provide a follow-up to address this?
> 
>> +	if (err)
>> +		goto err_tlock;
>> +
>> +	l2tp_tunnel_inc_refcount(tunnel);
>> +
>>   	hlist_add_head_rcu(&session->hlist, head);
>>   	spin_unlock_bh(&tunnel->hlist_lock);
>>   
>> +	if (tunnel->version == L2TP_HDR_VER_3) {
>> +		spin_lock_bh(&pn->l2tp_session_idr_lock);
>> +		idr_replace(&pn->l2tp_v3_session_idr, session, session_key);
>> +		spin_unlock_bh(&pn->l2tp_session_idr_lock);
>> +	}
>> +
>>   	trace_register_session(session);
>>   
>>   	return 0;
>>   
>> -err_tlock_pnlock:
>> -	spin_unlock_bh(&pn->l2tp_session_hlist_lock);
>>   err_tlock:
>>   	spin_unlock_bh(&tunnel->hlist_lock);
>>   
> 
> ...

Hi Simon,

It's "fixed" by the next patch in the series: 2a3339f6c963 ("l2tp: store 
l2tpv2 sessions in per-net IDR") which adds an else clause to the if 
statement quoted above. Sorry I missed this when compile-testing the 
series! Would you prefer a separate patch to initialise err?

James


