Return-Path: <netdev+bounces-109914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D490F92A429
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E115B20AE0
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ECD13AD0F;
	Mon,  8 Jul 2024 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="HdCVbyr/"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6384E13A400;
	Mon,  8 Jul 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447025; cv=none; b=CjJQFBp7BQ7ZahmjCg0AtCz3aloGWlG0O79XZNKj6ehA240dFoAwkuYyx+Gk4FJqOSKnGGlTP88SO1omKr13aQuDqtOnuDUUfsyRIZxf+BW53LBxckyQkkXrqXU4AuZ7VtljIMMJ/jY5QwWZt9YSkHl1rNd/7wire/7QrSnOp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447025; c=relaxed/simple;
	bh=qQB5jmiieWyiL7crIJzqQevemxMQaJz5FAAaFGbXwKE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=hliqcTd5i7XPuvFJn3fSE3OesZ9RrGHfVhaNrSZfnfhvlGQizIlppqae1U8KIjl6Vl2DZeEvj/+/7WhgiGV/sZ3C0+JrQR2yIjbGiGjP8MmHp5+4b6pJ/uqS/hg5FJ7ijyx2ojA8aSVBqYvfnFSKo9urILqWxxZozw4Hh91bYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=HdCVbyr/; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:e181:9992:7c46:d034] (unknown [IPv6:2a02:8010:6359:2:e181:9992:7c46:d034])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 46C487D926;
	Mon,  8 Jul 2024 14:57:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1720447022; bh=qQB5jmiieWyiL7crIJzqQevemxMQaJz5FAAaFGbXwKE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<a65127e4-544b-27e6-a1e1-e20e5fb4d480@katalix.com>|
	 Date:=20Mon,=208=20Jul=202024=2014:57:02=20+0100|MIME-Version:=201
	 .0|To:=20Hillf=20Danton=20<hdanton@sina.com>|Cc:=20netdev@vger.ker
	 nel.org,=20linux-kernel@vger.kernel.org,=0D=0A=20syzkaller-bugs@go
	 oglegroups.com,=20tparkin@katalix.com,=0D=0A=20syzbot+b471b7c93630
	 1a59745b@syzkaller.appspotmail.com,=0D=0A=20syzbot+c041b4ce3a6dfd1
	 e63e2@syzkaller.appspotmail.com|References:=20<20240708115940.892-
	 1-hdanton@sina.com>|From:=20James=20Chapman=20<jchapman@katalix.co
	 m>|Subject:=20Re:=20[PATCH=20net-next=20v2]=20l2tp:=20fix=20possib
	 le=20UAF=20when=20cleaning=20up=0D=0A=20tunnels|In-Reply-To:=20<20
	 240708115940.892-1-hdanton@sina.com>;
	b=HdCVbyr/sESYRlL6ctYK7IaT+8mna1yGitopRzjpKY1rFPwkEk/U4uZ4HldLDXp+Z
	 69V/TWz7RCtd4v79cPZM4L8cjKt0o3Xge7gvNux85/eeBxFaAbtTYdjqpj9ol7Xdhj
	 VzN0zn2x0ssL79jgC+PZlptZS1GKsii5QeZy/hdbIJIeAH7BbUuEA3gMiZThG53xi7
	 +DZwmETm/e8dpQKl6GOSWTFlTcpEr5mrYAg16WX46EJRxZy3uJq6nE73dAHd8cB6s+
	 H2LVCvTRsQIsvUYUPYLPXiS7FtyMBX0tzeA7CCudvCx5qXQElIdT89rsGi/w7J6WuP
	 YE80sGtT6cDkw==
Message-ID: <a65127e4-544b-27e6-a1e1-e20e5fb4d480@katalix.com>
Date: Mon, 8 Jul 2024 14:57:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Hillf Danton <hdanton@sina.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tparkin@katalix.com,
 syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com,
 syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
References: <20240708115940.892-1-hdanton@sina.com>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next v2] l2tp: fix possible UAF when cleaning up
 tunnels
In-Reply-To: <20240708115940.892-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2024 12:59, Hillf Danton wrote:
> On Mon, 8 Jul 2024 11:06:25 +0100 James Chapman <jchapman@katalix.com>
>> On 05/07/2024 11:32, Hillf Danton wrote:
>>> On Thu,  4 Jul 2024 16:25:08 +0100 James Chapman <jchapman@katalix.com>
>>>> --- a/net/l2tp/l2tp_core.c
>>>> +++ b/net/l2tp/l2tp_core.c
>>>> @@ -1290,17 +1290,20 @@ static void l2tp_session_unhash(struct l2tp_session *session)
>>>>    static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
>>>>    {
>>>>    	struct l2tp_session *session;
>>>> -	struct list_head *pos;
>>>> -	struct list_head *tmp;
>>>>    
>>>>    	spin_lock_bh(&tunnel->list_lock);
>>>>    	tunnel->acpt_newsess = false;
>>>> -	list_for_each_safe(pos, tmp, &tunnel->session_list) {
>>>> -		session = list_entry(pos, struct l2tp_session, list);
>>>> +	for (;;) {
>>>> +		session = list_first_entry_or_null(&tunnel->session_list,
>>>> +						   struct l2tp_session, list);
>>>> +		if (!session)
>>>> +			break;
>>>> +		l2tp_session_inc_refcount(session);
>>>>    		list_del_init(&session->list);
>>>>    		spin_unlock_bh(&tunnel->list_lock);
>>>>    		l2tp_session_delete(session);
>>>>    		spin_lock_bh(&tunnel->list_lock);
>>>> +		l2tp_session_dec_refcount(session);
>>>
>>> Bumping refcount up makes it safe for the current cpu to go thru race
>>> after releasing lock, and if it wins the race, dropping refcount makes
>>> the peer head on uaf.
>>
>> Thanks for reviewing this. Can you elaborate on what you mean by "makes
>> the peer head on uaf", please?
>>
> Given race, there are winner and loser. If the current cpu wins the race,
> the loser hits uaf once winner drops refcount.

I think the session's dead flag would protect against threads racing in 
l2tp_session_delete to delete the same session.
Any thread with a pointer to a session should hold a reference on it to 
prevent the session going away while it is accessed. Am I missing a 
codepath where that's not the case?


