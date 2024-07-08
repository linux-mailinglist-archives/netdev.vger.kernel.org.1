Return-Path: <netdev+bounces-109811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A82929FD5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3D71C20D30
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9967346F;
	Mon,  8 Jul 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="HbnVZgRC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1831E13ACC;
	Mon,  8 Jul 2024 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433194; cv=none; b=hnQkFGA7W1aFx0CxiPch+GxIXwzUjEVWrMCpvaqZB2QbOQEARsaworR0CWUnvJa6aVlWZVmB5xqsCqpzBijHMRrPepnPILYvfa6m13v+xNlVuuwHBS3USYiYCv1eqPmxSsRpxDgdAGVpZn1MpZWOOXuks4cQVmdQQO/UomUTjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433194; c=relaxed/simple;
	bh=dxHrFPe2Oclcjmv0GLPO4gTX01NRE6R2X4oSLDjQhko=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=JKark3fg+Gv34DrjEVP9sVk8D7YZWhKJOfM1CQt2qFgCqx4UyD1nqinNkOKffpTgJ9eR/aCi6pguA/u+4BjNL9q+rd0pF8k0YnoBx5Zc+y9EiYvILfJV2ZFo49wVErmmAcMeS8UI16Q8dphn+0qsWzIPBVBUZWG2jHjtEa+hkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=HbnVZgRC; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:e181:9992:7c46:d034] (unknown [IPv6:2a02:8010:6359:2:e181:9992:7c46:d034])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id B47167D926;
	Mon,  8 Jul 2024 11:06:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1720433185; bh=dxHrFPe2Oclcjmv0GLPO4gTX01NRE6R2X4oSLDjQhko=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<cfee59ae-4807-f384-b525-ce47fa4135e6@katalix.com>|
	 Date:=20Mon,=208=20Jul=202024=2011:06:25=20+0100|MIME-Version:=201
	 .0|To:=20Hillf=20Danton=20<hdanton@sina.com>|Cc:=20netdev@vger.ker
	 nel.org,=20linux-kernel@vger.kernel.org,=0D=0A=20syzkaller-bugs@go
	 oglegroups.com,=20tparkin@katalix.com,=0D=0A=20syzbot+b471b7c93630
	 1a59745b@syzkaller.appspotmail.com,=0D=0A=20syzbot+c041b4ce3a6dfd1
	 e63e2@syzkaller.appspotmail.com|References:=20<20240705103250.3144
	 -1-hdanton@sina.com>|From:=20James=20Chapman=20<jchapman@katalix.c
	 om>|Subject:=20Re:=20[PATCH=20net-next=20v2]=20l2tp:=20fix=20possi
	 ble=20UAF=20when=20cleaning=20up=0D=0A=20tunnels|In-Reply-To:=20<2
	 0240705103250.3144-1-hdanton@sina.com>;
	b=HbnVZgRC6k6bL5IzcY0F2hUALh6H0tiQ3R2NYZipLKTBxDacmi5dEgs834RxG70u8
	 IrtEpz/hMGslrB2sPVguDSAu9MIlqIrQujX/dmL0jjip8PmYPwA1ESLKpp4lwfpQZw
	 pCqdqBg4sZsDrFenOwCGFR94SyrB8+9hsVJDertZ04jD7K7NUmPK6lRGaVpoUhiyUT
	 EmItYLpzWRzeEjFKnnAc0ZV3tJTHBop2hSRJs/9LyivRPjbErjh8A6zaaMTgWTMhTT
	 JqxYIJofXvJ2IRmjvZHkbInS909hoYvlyWZDayXHLkGp+wWBlOKMj26KI5iGntN6wy
	 jlJbGX1UBz+Qw==
Message-ID: <cfee59ae-4807-f384-b525-ce47fa4135e6@katalix.com>
Date: Mon, 8 Jul 2024 11:06:25 +0100
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
References: <20240705103250.3144-1-hdanton@sina.com>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next v2] l2tp: fix possible UAF when cleaning up
 tunnels
In-Reply-To: <20240705103250.3144-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/07/2024 11:32, Hillf Danton wrote:
> On Thu,  4 Jul 2024 16:25:08 +0100 James Chapman <jchapman@katalix.com>
>> --- a/net/l2tp/l2tp_core.c
>> +++ b/net/l2tp/l2tp_core.c
>> @@ -1290,17 +1290,20 @@ static void l2tp_session_unhash(struct l2tp_session *session)
>>   static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
>>   {
>>   	struct l2tp_session *session;
>> -	struct list_head *pos;
>> -	struct list_head *tmp;
>>   
>>   	spin_lock_bh(&tunnel->list_lock);
>>   	tunnel->acpt_newsess = false;
>> -	list_for_each_safe(pos, tmp, &tunnel->session_list) {
>> -		session = list_entry(pos, struct l2tp_session, list);
>> +	for (;;) {
>> +		session = list_first_entry_or_null(&tunnel->session_list,
>> +						   struct l2tp_session, list);
>> +		if (!session)
>> +			break;
>> +		l2tp_session_inc_refcount(session);
>>   		list_del_init(&session->list);
>>   		spin_unlock_bh(&tunnel->list_lock);
>>   		l2tp_session_delete(session);
>>   		spin_lock_bh(&tunnel->list_lock);
>> +		l2tp_session_dec_refcount(session);
> 
> Bumping refcount up makes it safe for the current cpu to go thru race
> after releasing lock, and if it wins the race, dropping refcount makes
> the peer head on uaf.

Thanks for reviewing this. Can you elaborate on what you mean by "makes 
the peer head on uaf", please?


