Return-Path: <netdev+bounces-129250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0397E7C0
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 10:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AE21C211BD
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 08:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FFF1885B9;
	Mon, 23 Sep 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a3AsZs9j"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1271918F2F6;
	Mon, 23 Sep 2024 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080810; cv=none; b=Mr/xf//V2BNyz22YyfqU6ddLuSeE+qgAys2JBB39lEt7wAf4+Nz9HKxBXt85aoIv/MQxLje0jwxffpjxI9eMeUVBZAdpn7I6E4xs/EzSyjkJAEf+PH7102GoSJET2nSmQC3JrRiyu8I43TWKkLWJDxi0vhe0BF7J0JAauyN+3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080810; c=relaxed/simple;
	bh=4cagTvxyf5nQtU00W2lYYphEd348c7zNz4qoHxvOrBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X39BDDoqA1EQw0nvq7kwrwQ+/kPW/DBJ/RXSwklNu7iFGdBmp1U9mBrTunQgpKTEah6LdO9LLOyQRv701xSFl8aKS1sQ2rUMVEnWrRj6L87hIlzEg8ioBj4cWsppZHoxitgIZ95UNSO8UXcB91M7T9gPWk532mfv5VhS1I4IzyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a3AsZs9j; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727080804; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Pmg7gtnDrUcCwM5y+HvLHiVMVM0N6B0Ika/sf6X8dYI=;
	b=a3AsZs9jDa9a3m2OQunhv289puh8s2j6D096zd/j49hZQWPCPfc+DxShcbl6X8R0pQKrXGoGGLD9i32DF9BzKCe7/csf1An7BPOXk8lTGPJQ5hf2byelnekON9CWaFMMUum3T+nqZoWvPycKX7XvLhtJIwRH+dtEdLRhUAKFRso=
Received: from 30.221.128.119(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WFW1XBx_1727080803)
          by smtp.aliyun-inc.com;
          Mon, 23 Sep 2024 16:40:04 +0800
Message-ID: <dd4ff273-2227-4e5a-ba11-2ca79035b811@linux.alibaba.com>
Date: Mon, 23 Sep 2024 16:40:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net/udp: Add 4-tuple hash for connected
 socket
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20240913100941.8565-1-lulie@linux.alibaba.com>
 <CANn89iJuUFaM5whtsqA37vh6vUKUQJhgjV9Uqv6_ARpVGFjB2w@mail.gmail.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <CANn89iJuUFaM5whtsqA37vh6vUKUQJhgjV9Uqv6_ARpVGFjB2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eric, sorry for the late response.

On 2024/9/13 19:49, Eric Dumazet wrote:
> On Fri, Sep 13, 2024 at 12:09 PM Philo Lu <lulie@linux.alibaba.com> wrote:
>>
>> This RFC patch introduces 4-tuple hash for connected udp sockets, to
>> make udp lookup faster. It is a tentative proposal and any comment is
>> welcome.
>>
>> Currently, the udp_table has two hash table, the port hash and portaddr
>> hash. But for UDP server, all sockets have the same local port and addr,
>> so they are all on the same hash slot within a reuseport group. And the
>> target sock is selected by scoring.
>>
>> In some applications, the UDP server uses connect() for each incoming
>> client, and then the socket (fd) is used exclusively by the client. In
>> such scenarios, current scoring method can be ineffcient with a large
>> number of connections, resulting in high softirq overhead.
>>
>> To solve the problem, a 4-tuple hash list is added to udp_table, and is
>> updated when calling connect(). Then __udp4_lib_lookup() firstly
>> searches the 4-tuple hash list, and return directly if success. A new
>> sockopt UDP_HASH4 is added to enable it. So the usage is:
>> 1. socket()
>> 2. bind()
>> 3. setsockopt(UDP_HASH4)
>> 4. connect()
>>
>> AFAICT the patch (if useful) can be further improved by:
>> (a) Support disable with sockopt UDP_HASH4. Now it cannot be disabled
>> once turned on until the socket closed.
>> (b) Better interact with hash2/reuseport. Now hash4 hardly affects other
>> mechanisms, but maintaining sockets in both hash4 and hash2 lists seems
>> unnecessary.
>> (c) Support early demux and ipv6.
>>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> 
> Adding a 4-tuple hash for UDP has been discussed in the past.
> 
> Main issue is that this is adding one cache line miss per incoming packet.
> 

Thanks to Dust's idea, we can create a new field for hslot2 (or create a 
new struct for hslot2), indicating whether there are connected sockets 
in this hslot (i.e., local port and local address), and run hash4 lookup 
only when it's true. Then there would be no cache line miss.

The detailed patch is attached below.

> Most heavy duty UDP servers (DNS, QUIC), use non connected sockets,
> because having one million UDP sockets has huge kernel memory cost,
> not counting poor cache locality.

Some of our applications do use connected UDP sockets (~10,000 conns), 
and will get significant benefits from hash4. We use connect() to 
separate receiving sockets and listening ones, and then it's easier to 
manage them (just like TCP), especially during live-upgrading, such as 
nginx reload. Besides, I believe hash4 is harmless to those servers 
without connected sockets.

Suggestions are always welcome, and I'll keep improving this patch.

Thanks.

---
  include/net/udp.h |  3 +++
  net/ipv4/udp.c    | 17 ++++++++++++-----
  2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index a05d79d35fbba..bec04c0e753d0 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -54,11 +54,14 @@ struct udp_skb_cb {
   *
   *	@head:	head of list of sockets
   *	@count:	number of sockets in 'head' list
+ *	@hash4_cnt: number of sockets in 'hash4' table of the same (local 
port, local address),
+ *		    Only used by hash2.
   *	@lock:	spinlock protecting changes to head/count
   */
  struct udp_hslot {
  	struct hlist_head	head;
  	int			count;
+	u32			hash4_cnt;
  	spinlock_t		lock;
  } __attribute__((aligned(2 * sizeof(long))));

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index aac0251ff6fac..dfa8b3c091def 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -511,14 +511,16 @@ struct sock *__udp4_lib_lookup(const struct net 
*net, __be32 saddr,
  	struct udp_hslot *hslot2;
  	struct sock *result, *sk;

-	result = udp4_lib_lookup4(net, saddr, sport, daddr, hnum, dif, sdif, 
udptable);
-	if (result)
-		return result;
-
  	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
  	slot2 = hash2 & udptable->mask;
  	hslot2 = &udptable->hash2[slot2];
  ·
+	if (hslot2->hash4_cnt) {
+		result = udp4_lib_lookup4(net, saddr, sport, daddr, hnum, dif, sdif, 
udptable);
+		if (result)
+			return result;
+	}
+
  	/* Lookup connected or non-wildcard socket */
  	result = udp4_lib_lookup2(net, saddr, sport,
  				  daddr, hnum, dif, sdif,
@@ -1961,7 +1963,7 @@ EXPORT_SYMBOL(udp_pre_connect);
  /* call with sock lock */
  static void udp4_hash4(struct sock *sk)
  {
-	struct udp_hslot *hslot, *hslot4;
+	struct udp_hslot *hslot, *hslot2, *hslot4;
  	struct net *net = sock_net(sk);
  	struct udp_table *udptable;
  	unsigned int hash;
@@ -1975,6 +1977,7 @@ static void udp4_hash4(struct sock *sk)

  	udptable = net->ipv4.udp_table;
  	hslot = udp_hashslot(udptable, net, udp_sk(sk)->udp_port_hash);
+	hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
  	hslot4 = udp_hashslot4(udptable, hash);
  	udp_sk(sk)->udp_lrpa_hash = hash;

@@ -1985,6 +1988,7 @@ static void udp4_hash4(struct sock *sk)
  	spin_lock(&hslot4->lock);
  	hlist_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &hslot4->head);
  	hslot4->count++;
+	hslot2->hash4_cnt++;
  	spin_unlock(&hslot4->lock);

  	spin_unlock_bh(&hslot->lock);
@@ -2068,6 +2072,7 @@ void udp_lib_unhash(struct sock *sk)
  				spin_lock(&hslot4->lock);
  				hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
  				hslot4->count--;
+				hslot2->hash4_cnt--;
  				spin_unlock(&hslot4->lock);
  			}
  		}
@@ -2119,11 +2124,13 @@ void udp_lib_rehash(struct sock *sk, u16 
newhash, u16 newhash4)
  				spin_lock(&hslot4->lock);
  				hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
  				hslot4->count--;
+				hslot2->hash4_cnt--;
  				spin_unlock(&hslot4->lock);

  				spin_lock(&nhslot4->lock);
  				hlist_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &nhslot4->head);
  				nhslot4->count++;
+				nhslot2->hash4_cnt++;
  				spin_unlock(&nhslot4->lock);
  			}

-- 
Philo


