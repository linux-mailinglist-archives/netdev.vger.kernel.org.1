Return-Path: <netdev+bounces-226157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C520B9D112
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C14172F42
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DC72DEA73;
	Thu, 25 Sep 2025 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RUmY27mI"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42D25487A
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758765131; cv=none; b=gT7WeL6Tq+Ejfzt7mT8GJgQymOoogobqslVIoy7HQrKoOIkzlzEKIGNvmgx/9hCE63lx6GviQk0vtHimqglOpjwAGncWwegl9j+N62Jnb2ZPK2GIoQRpRnS/bzyA6wTwLJl5TbSZZ2ysmV39q5qrobSrkmjFPRsuSjsfs/E33qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758765131; c=relaxed/simple;
	bh=Hmte3WOiRjRo380ZLWpKNE0N2ZBN2LOqtZQ1Rqe94x4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FovmqU9t3kAPlU+fSiQ+VBVrtZCf0bavZKSk9vwLNKD+UeUCgsSdQ/8gb7VOpIrZeX5m6ohHKRYMMrrb31Yu9wlbt1lUYZBO6DK0dPMDyIPMvUnzJEfx052Bg7PM0U+vriV3GGykWwme+S6/H3QpnExNUgH/Tb0iHxVnM/Ayk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RUmY27mI; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a02bf61e-bb72-41fa-b8c3-0efbd3738aeb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758765125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzF0EKfxrFefgtjiDdlptwr6Elo99QeNwkgwDVtTzEE=;
	b=RUmY27mI8T/30dw4ISVypMox7Coc2aMsVZ2C3muXZfUTEbcFY/Q0I+pKhb+fBxVvIuCDsq
	Mlb1R2qy93KaGswoR2tqSkiHpX1Iq4ar2Fk60j91Di2swRSkdDZL+veQl7bxaJosKVGtYz
	uDKuthk99qSmS72XhWTvZPpEnx3xeDc=
Date: Thu, 25 Sep 2025 09:51:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
Subject: Re: [PATCH net-next v5 3/3] inet: Avoid ehash lookup race in
 inet_twsk_hashdance_schedule()
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, kuniyu@google.com, kerneljasonxing@gmail.com,
 davem@davemloft.net, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250924015034.587056-1-xuanqiang.luo@linux.dev>
 <20250924015034.587056-4-xuanqiang.luo@linux.dev>
 <20250924175527.4642e32a@kernel.org>
In-Reply-To: <20250924175527.4642e32a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/25 08:55, Jakub Kicinski 写道:
> On Wed, 24 Sep 2025 09:50:34 +0800xuanqiang.luo@linux.dev wrote:
>> From: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
>>
>> Since ehash lookups are lockless, if another CPU is converting sk to tw
>> concurrently, fetching the newly inserted tw with tw->tw_refcnt == 0 cause
>> lookup failure.
>>
>> The call trace map is drawn as follows:
>>     CPU 0                                CPU 1
>>     -----                                -----
>> 				     inet_twsk_hashdance_schedule()
>> 				     spin_lock()
>> 				     inet_twsk_add_node_rcu(tw, ...)
>> __inet_lookup_established()
>> (find tw, failure due to tw_refcnt = 0)
>> 				     __sk_nulls_del_node_init_rcu(sk)
>> 				     refcount_set(&tw->tw_refcnt, 3)
>> 				     spin_unlock()
>>
>> By replacing sk with tw atomically via hlist_nulls_replace_init_rcu() after
>> setting tw_refcnt, we ensure that tw is either fully initialized or not
>> visible to other CPUs, eliminating the race.
> This one doesn't build cleanly
>
> net/ipv4/inet_timewait_sock.c:116:28: warning: unused variable 'ehead' [-Wunused-variable]
>    116 |         struct inet_ehash_bucket *ehead = inet_ehash_bucket(hashinfo, sk->sk_hash);
>        |                                   ^~~~~
> net/ipv4/inet_timewait_sock.c:91:13: warning: unused function 'inet_twsk_add_node_rcu' [-Wunused-function]
>     91 | static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
>        |             ^~~~~~~~~~~~~~~~~~~~~~

Oops, I introduced those build warnings in my changes and missed them.

Thanks for pointing this out—I'll fix them shortly.


