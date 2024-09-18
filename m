Return-Path: <netdev+bounces-128840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D597BECB
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690A51F21AB9
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469DF18A6AE;
	Wed, 18 Sep 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="R0mEqYIW"
X-Original-To: netdev@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60E2AEEE
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726674186; cv=none; b=a8ojx+QchZVtdO0/nv1tYL+viiQg6CL5/wdDOcUF3j158LSj2FQxovNMBdF2HllbIkl6nBmAigBjm6uP6uA5HhUIPx8+le2v/N7P4zFMm/wMZm1C0Ra01GSR13SzSNO7R3HC3N58Ve+adfEnPgD1tnX6LVwwNlC/xU0Bjs1Yp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726674186; c=relaxed/simple;
	bh=ugdjfkGVfPSYNdwgNA1Mxd/mWen0l5L081PvLX6r0uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n76DVp8APaiCvfE8GGz8ppLxHzhTo38ZEa56hs1GWBT69PPp/Z2bukdt2CbRSTqRkKzUZ8mph3FARcD+F9JWzkvmKnCcNEMgVMPe8enf4SaxNdctmelx2X+qtsNh9qkNwOgDM244fx8jaN5lJJ/xnK7eKDUh23k39IWi+Tjseio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=R0mEqYIW; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:3483:0:640:1715:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 4024560D3A;
	Wed, 18 Sep 2024 18:42:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qgP9AJ9oGuQ0-o31xOhqP;
	Wed, 18 Sep 2024 18:42:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1726674173; bh=+db3sYT+9aqvCEG+ywQNHRMxo5XRJkMHMg0vKv7/Xl0=;
	h=In-Reply-To:To:From:Cc:Date:References:Subject:Message-ID;
	b=R0mEqYIW5aWweVP/NO898RN/27x9BBGt+w0KrGP2u6fyz31XHnXyJrC9D/pdhqUwm
	 w6YVFrhVZvCorz2ND5dVGjfre2LZqzuMlk7YpyeUYkC7LwCK8IjLbxavN4zSrl9weK
	 zM8bhOMvy6z27n9EroWb0/iwOU8ag9W67lAUI6KE=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <37597ead-9c2e-44d4-9c72-ee0bf1d2a946@yandex.ru>
Date: Wed, 18 Sep 2024 18:42:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net] net: sockmap: avoid race between
 sock_map_destroy() and sk_psock_put()
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org,
 Allison Henderson <allison.henderson@oracle.com>
References: <20240905064257.3870271-1-dmantipov@yandex.ru>
 <Zt3up5aOcu5icAUr@pop-os.localdomain>
 <5d23bd86-150f-40a3-ab43-a468b3133bc4@yandex.ru>
 <ZuEdeDBHKj1q9NlV@pop-os.localdomain>
 <1ae54555-0998-4c76-bbb3-60e9746f9688@yandex.ru>
 <ZuHJQitSaAYFRFNB@pop-os.localdomain>
 <9c8146a5-c7fc-40ae-81bb-37a2c12c2384@yandex.ru>
 <ZuTaGwM/8bTdWx1h@pop-os.localdomain>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 xsDNBGBYjL8BDAC1iFIjCNMSvYkyi04ln+5sTl5TCU9O5Ot/kaKKCstLq3TZ1zwsyeqF7S/q
 vBVSmkWHQaj80BlT/1m7BnFECMNV0M72+cTGfrX8edesMSzv/id+M+oe0adUeA07bBc2Rq2V
 YD88b1WgIkACQZVFCo+y7zXY64cZnf+NnI3jCPRfCKOFVwtj4OfkGZfcDAVAtxZCaksBpTHA
 tf24ay2PmV6q/QN+3IS9ZbHBs6maC1BQe6clFmpGMTvINJ032oN0Lm5ZkpNN+Xcp9393W34y
 v3aYT/OuT9eCbOxmjgMcXuERCMok72uqdhM8zkZlV85LRdW/Vy99u9gnu8Bm9UZrKTL94erm
 0A9LSI/6BLa1Qzvgwkyd2h1r6f2MVmy71/csplvaDTAqlF/4iA4TS0icC0iXDyD+Oh3EfvgP
 iEc0OAnNps/SrDWUdZbJpLtxDrSl/jXEvFW7KkW5nfYoXzjfrdb89/m7o1HozGr1ArnsMhQC
 Uo/HlX4pPHWqEAFKJ5HEa/0AEQEAAc0kRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5k
 ZXgucnU+wsEJBBMBCAAzFiEEgi6CDXNWvLfa6d7RtgcLSrzur7cFAmYEXUsCGwMFCwkIBwIG
 FQgJCgsCBRYCAwEAAAoJELYHC0q87q+3ghQL/10U/CvLStTGIgjRmux9wiSmGtBa/dUHqsp1
 W+HhGrxkGvLheJ7KHiva3qBT++ROHZxpIlwIU4g1s6y3bqXqLFMMmfH1A+Ldqg1qCBj4zYPG
 lzgMp2Fjc+hD1oC7k7xqxemrMPstYQKPmA9VZo4w3+97vvnwDNO7iX3r0QFRc9u19MW36wq8
 6Yq/EPTWneEDaWFIVPDvrtIOwsLJ4Bu8v2l+ejPNsEslBQv8YFKnWZHaH3o+9ccAcgpkWFJg
 Ztj7u1NmXQF2HdTVvYd2SdzuJTh3Zwm/n6Sw1czxGepbuUbHdXTkMCpJzhYy18M9vvDtcx67
 10qEpJbe228ltWvaLYfHfiJQ5FlwqNU7uWYTKfaE+6Qs0fmHbX2Wlm6/Mp3YYL711v28b+lp
 9FzPDFqVPfVm78KyjW6PcdFsKu40GNFo8gFW9e8D9vwZPJsUniQhnsGF+zBKPeHi/Sb0DtBt
 enocJIyYt/eAY2hGOOvRLDZbGxtOKbARRwY4id6MO4EuSs7AzQRgWIzAAQwAyZj14kk+OmXz
 TpV9tkUqDGDseykicFMrEE9JTdSO7fiEE4Al86IPhITKRCrjsBdQ5QnmYXcnr3/9i2RFI0Q7
 Evp0gD242jAJYgnCMXQXvWdfC55HyppWazwybDiyufW/CV3gmiiiJtUj3d8r8q6laXMOGky3
 7sRlv1UvjGyjwOxY6hBpB2oXdbpssqFOAgEw66zL54pazMOQ6g1fWmvQhUh0TpKjJZRGF/si
 b/ifBFHA/RQfAlP/jCsgnX57EOP3ALNwQqdsd5Nm1vxPqDOtKgo7e0qx3sNyk05FFR+f9px6
 eDbjE3dYfsicZd+aUOpa35EuOPXS0MC4b8SnTB6OW+pmEu/wNzWJ0vvvxX8afgPglUQELheY
 +/bH25DnwBnWdlp45DZlz/LdancQdiRuCU77hC4fnntk2aClJh7L9Mh4J3QpBp3dh+vHyESF
 dWo5idUSNmWoPwLSYQ/evKynzeODU/afzOrDnUBEyyyPTknDxvBQZLv0q3vT0UiqcaL7ABEB
 AAHCwPYEGAEIACAWIQSCLoINc1a8t9rp3tG2BwtKvO6vtwUCZgRdSwIbDAAKCRC2BwtKvO6v
 t9sFC/9Ga7SI4CaIqfkye1EF7q3pe+DOr4NsdsDxnPiQuG39XmpmJdgNI139TqroU5VD7dyy
 24YjLTH6uo0+dcj0oeAk5HEY7LvzQ8re6q/omOi3V0NVhezdgJdiTgL0ednRxRRwNDpXc2Zg
 kg76mm52BoJXC7Kd/l5QrdV8Gq5WJbLA9Kf0pTr1QEf44bVR0bajW+0Lgyb7w4zmaIagrIdZ
 fwuYZWso3Ah/yl6v1//KP2ppnG0d9FGgO9iz576KQZjsMmQOM7KYAbkVPkZ3lyRJnukrW6jC
 bdrQgBsPubep/g9Ulhkn45krX5vMbP3wp1mJSuNrACQFbpJW3t0Da4DfAFyTttltVntr/ljX
 5TXWnMCmaYHDS/lP20obHMHW1MCItEYSIn0c5DaAIfD+IWAg8gn7n5NwrMj0iBrIVHBa5mRp
 KkzhwiUObL7NO2cnjzTQgAVUGt0MSN2YfJwmSWjKH6uppQ7bo4Z+ZEOToeBsl6waJnjCL38v
 A/UwwXBRuvydGV0=
In-Reply-To: <ZuTaGwM/8bTdWx1h@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+CC Allison

On 9/14/24 3:34 AM, Cong Wang wrote:
> On Thu, Sep 12, 2024 at 06:59:39PM +0300, Dmitry Antipov wrote:
>> On 9/11/24 7:45 PM, Cong Wang wrote:
>>
>>> I guess you totally misunderstand my point. As a significant sockmap
>>> contributor, I am certainly aware of sockmap users. My point is that I
>>> needed to narrow down the problem to CONFIG_RDS when I was debugging it.
>>
>> I've narrowed down the problem to possible race condition between two
>> functions. "Narrowing down" the problem to a 17.5Kloc-sized subsystem
>> is not too helpful.
> 
> Narrowing down from more 30 millions lines of code to 17.5K is already a huge
> win to me, maybe not for you. :)
> 
>>
>>> So, please let me know if you can still reproduce this after disabling
>>> CONFIG_RDS, because I could not reproduce it any more. If you can,
>>> please kindly share the stack trace without rds_* functions.
>>
>> Yes, this issue requires CONFIG_RDS and CONFIG_RDS_TCP to reproduce. But
>> syzbot reproducer I'm working with doesn't create RDS sockets explicitly
>> (with 'socket(AF_RDS, ..., ...)' or so). When two options above are enabled,
>> the default network namespace has special kernel-space socket which is
>> created in 'rds_tcp_listen_init()' and (if my understanding of the namespaces
>> is correct) may be inherited with 'unshare(CLONE_NEWNET)'. So just enabling
>> these two options makes the kernel vulnerable.
> 
> Thanks for confirming it.
> 
> I did notice the RDS kernel socket, but, without my patch, we can still
> use sockops to hook TCP socket under the RDS socket and add it to a
> sockmap, hence the conflict of sock->sk->sk_user_data.
> 
> My patch basically prevents such TCP socket under RDS socket from being
> added to any sockmap.
> 
>>
>> So I'm still gently asking you to check whether there is a race condition
>> I've talked about. Hopefully this shouldn't be too hard for a significant
>> sockmap contributor.
> 
> If you can kindly explain why this race condition is not related to RDS
> despite the fact it only happens with CONFIG_RDS enabled, I'd happy to
> review it. Otherwise, I feel like you may head to a wrong direction.
> 
> Thanks.


