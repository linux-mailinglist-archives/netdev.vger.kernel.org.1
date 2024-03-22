Return-Path: <netdev+bounces-81160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B16FA88655A
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 04:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE6D1F2384C
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 03:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A233FEF;
	Fri, 22 Mar 2024 03:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ljAnzbQF"
X-Original-To: netdev@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA521A38FE
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 03:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711077388; cv=none; b=ffGB01QBpvj5z9e5CXUISG77uUjM2sU1eWRuP1tYEtVHs6P/hol6cDZgI5jNaX9u6K/Za2qV3z/879/uM6jTYYzt1Gwm6gjbWlu1sNZFKiXj3xDKddDbkhqhVa658EYPsi1hHaOcnSWkbJQNbQMQyWpC77J4KTfoheeMUTmAF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711077388; c=relaxed/simple;
	bh=jUlO3Kw9KWYDHYwozUsy8sY3NfAnzbJH6vCVFPmKrTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G70XuzrOjekYnIYc2qPv4jQJovQGwET6WCmGTBJlFmSsXtlSnPwdiLXy3umoSiyHwWALng2WTk3tELfq3AQh2Sn3EHKkOsmEpq8Be6EEJvGnA34LBjo9VPMGeAVDENj8V/yVNOawcvYlsTgwafgME9PVMEIIT9RimD65grNnZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ljAnzbQF; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=3xmL5qvYceSIg8fT71zuV0YUo/ZR/DTiLcIk/fPQPYU=;
	b=ljAnzbQF9pNHgDReMCLaeg2H7sUcmYdUMEWBwK79Vr2mwFrDIeXOwKwYqkhlKu
	+z5taivBeACJMeVgGlvixc6XDG1Zzszr3agOJO/JW9Iwcmfh683ttYSussWE6urg
	2Sa1NFBIqIAAtf0NAqLVJmRHKoCMkxJH72j8YA/GG35cc=
Received: from [192.168.31.59] (unknown [27.154.103.75])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDXf1b59_xl+OmXBQ--.19274S2;
	Fri, 22 Mar 2024 11:16:10 +0800 (CST)
Message-ID: <94d400d8-cb71-9f3a-32ad-a2492c1a5bd8@163.com>
Date: Fri, 22 Mar 2024 11:16:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] tcp: Fix inet_bind2_bucket_match_addr_any() regression
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org
References: <23b5678b-1e5a-be6c-ea68-b7a20dff4bbc@163.com>
 <20240321045533.8446-1-kuniyu@amazon.com>
From: Jianguo Wu <wujianguo106@163.com>
In-Reply-To: <20240321045533.8446-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXf1b59_xl+OmXBQ--.19274S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4fKF47JrW5JrWrurWxZwb_yoWrKF4xpF
	1UKa15Kr98tr1rJr18tryrCr13Kr48AF17C343JryYka4DWrnIvF48tr1ak3Z2va10gFs5
	KF4fZw1akanxJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRruc_UUUUU=
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiRBupkGVOB9WH6wAAsz


Hi Kuniyuki,
Thanks for your reply!

On 2024/3/21 12:55, Kuniyuki Iwashima wrote:
> Hi,
> 
> Thanks for the patch.
> 
> From: Jianguo Wu <wujianguo106@163.com>
> Date: Thu, 21 Mar 2024 11:02:36 +0800
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> If we bind() a TCPv4 socket to 0.0.0.0:8090, then bind() a TCPv6(ipv6only) socket
> 
> Please wrap each line at <75 characters except for logs/output like below.
> 
OK.
> 
>> to :::8090, both without SO_REUSEPORT, then bind() 127.0.0.1:8090, it should fail
> 
> [::]:8090 is easier to read and the recommended way.
> https://datatracker.ietf.org/doc/html/rfc5952#section-6
> 
> But please keep the netstat output as is.
> 
>> but now succeeds. like this:
>>   tcp        0      0 127.0.0.1:8090          0.0.0.0:*               LISTEN
>>   tcp        0      0 0.0.0.0:8090            0.0.0.0:*               LISTEN
>>   tcp6       0      0 :::8090                 :::*                    LISTEN
>>
>> bind() 0.0.0.0:8090, :::8090 and ::1:8090 are all fail.
> 
> What do you mean by all fail ?
> At least, [::1]:8090 would fail with the current code in this case.
In my test, 127.0.0.1:8090  succeeds, 0.0.0.0:8090, [::]:8090 and [::1]:8090 are all fail

> 
> 
>> But if we bind() a TCPv6(ipv6only) socket to :::8090 first, then  bind() a TCPv4
>> socket to 0.0.0.0:8090, then bind() 127.0.0.1:8090, 0.0.0.0:8090, :::8090 and ::1:8090 are all fail.
>>
>> When bind() 127.0.0.1:8090, inet_bind2_bucket_match_addr_any() will return true as tb->addr_type == IPV6_ADDR_ANY,
> 
> Let's use tb2 here for inet_bind2_bucket.. yes it's not consistent
> in some functions like inet_bind2_bucket_match_addr_any() though.
yes, inet_bind2_bucket_match_addr_any() use tb, so I use tb here.

> 
> 
>> and tb is refer to the TCPv6 socket(:::8090), then inet_bhash2_conflict() return false, That is, there is no conflict,
> 
> Also make it clear that the TCPv6 socket is ipv6only one.
> 
> 
>> so bind() succeeds.
>>
>>   inet_bhash2_addr_any_conflict()
>>   {
>> 	inet_bind_bucket_for_each(tb2, &head2->chain)
>> 		// tb2 is IPv6
>> 		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
>> 			break;
>>
>> 	// inet_bhash2_conflict() return false
>> 	if (tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,
>>                                 reuseport_ok)) {
>> 		spin_unlock(&head2->lock);
>> 		return true;
>> 	}
>>
>>   }
>>
>> Fixes: 5a22bba13d01 ("tcp: Save address type in inet_bind2_bucket.")
> 
> This is not the commit that introduced the regression.
I will remove this.
> 
> Also, you need Signed-off-by tag here.
OK.
> 
> 
>> ---
>>  net/ipv4/inet_hashtables.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>> index 7498af320164..3eeaca8a113f 100644
>> --- a/net/ipv4/inet_hashtables.c
>> +++ b/net/ipv4/inet_hashtables.c
>> @@ -830,8 +830,8 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
>>  		return false;
>>
>>  #if IS_ENABLED(CONFIG_IPV6)
>> -	if (tb->addr_type == IPV6_ADDR_ANY)
>> -		return true;
>> +	if (sk->sk_family == AF_INET6)
>> +		return tb->addr_type == IPV6_ADDR_ANY;
> 
> This fix is not correct and will break v4-mapped-v6 address cases.
> You can run bind_wildcard under the selftest directory.
>> Probably we need v6_only bit in tb2 and should add some test cases
> in the selftest.
How about this?
I add a new field ipv6_only to struct inet_bind2_bucket{}

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 7f1b38458743..fb7c250a663b 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -96,6 +96,7 @@ struct inet_bind2_bucket {
 	int			l3mdev;
 	unsigned short		port;
 #if IS_ENABLED(CONFIG_IPV6)
+	bool			ipv6_only;
 	unsigned short		addr_type;
 	struct in6_addr		v6_rcv_saddr;
 #define rcv_saddr		v6_rcv_saddr.s6_addr32[3]
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index cf88eca5f1b4..5fc749f8f2b1 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -110,6 +110,7 @@ static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb2,
 	tb2->port = tb->port;
 #if IS_ENABLED(CONFIG_IPV6)
 	BUILD_BUG_ON(USHRT_MAX < (IPV6_ADDR_ANY | IPV6_ADDR_MAPPED));
+	tb2->ipv6_only = ipv6_only_sock(sk);
 	if (sk->sk_family == AF_INET6) {
 		tb2->addr_type = ipv6_addr_type(&sk->sk_v6_rcv_saddr);
 		tb2->v6_rcv_saddr = sk->sk_v6_rcv_saddr;
@@ -831,7 +832,8 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const

 #if IS_ENABLED(CONFIG_IPV6)
 	if (tb->addr_type == IPV6_ADDR_ANY)
-		return true;
+		if (sk->sk_family == AF_INET6 || !tb->ipv6_only)
+			return true;

 	if (tb->addr_type != IPV6_ADDR_MAPPED)
 		return false;

> 
> 
>>
>>  	if (tb->addr_type != IPV6_ADDR_MAPPED)
>>  		return false;


