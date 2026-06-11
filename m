Return-Path: <netdev+bounces-297897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O8jbHmQeKmr1iwMAu9opvQ
	(envelope-from <netdev+bounces-297897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:33:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BD966DD58
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:33:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yeah.net header.s=s110527 header.b=f73FPpF6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297897-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297897-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yeah.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B559430C8D13
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D2522A4EE;
	Thu, 11 Jun 2026 02:32:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58E1799F
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:32:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781145131; cv=none; b=Cp1w9mb8KemecEXJJYWUAy3YSU+Hh5v0udqStRuZouv/7LAJXV9uw+qXEWypIrr7xmxTCUNudT1kezPRVf6fdoReyWAQy77Dox7tJkk5LX6CaBbDS8NWKz+BSALP/ogp7ln7lLNV9H9HxpgU6x93ivyumLsA+v4DUVrTmtpkh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781145131; c=relaxed/simple;
	bh=OOGdPaAKxe83CY8p6rMk+739TREsOTY/EfRFF0i0uDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVqeT2sOwv0q9RudzdHslCDo9aW3ofaZQpF2kMUxmq0OwTKWSJYXGXDuKzeU0Lw1W+4iNlYU+8B4AQ8gk/xMUCiRv8zdYYQY8yucIbuHlbnsSjn8kthSo2WKMAZWkeY8WrKmGLZhK7//OTqwk3jjbxLccT3bKZQnBH7G3iGEY4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=f73FPpF6; arc=none smtp.client-ip=1.95.21.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=PZnwqos67DlFuI5bHh0M36Ub1Y0ZW/i+pDDuk4H36NI=;
	b=f73FPpF6r7Dn56WI9SBVnUloaXIhU3Bqx8lSir2ndVJScsXXSK4g28b9Iawjx5
	F8JPV2rsVPiO7DZ6Sag6zhAuGySPRappffACpNPe9/bPvY7LLiUcuNNq3ezzPsVI
	Utrm0ckWCw2PkoXi97OvA+0igcXmm57mpZ42lTI056K1c=
Received: from [100.70.221.233] (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPA id Mc8vCgBX9kKoHSpqyXwyAA--.294S2;
	Thu, 11 Jun 2026 10:30:01 +0800 (CST)
Message-ID: <92935c00-e0be-4591-ac44-5978c7804d57@yeah.net>
Date: Thu, 11 Jun 2026 10:29:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
To: Willy Tarreau <w@1wt.eu>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Zhouyan Deng <dengzhouyan_nwpu@163.com>, Florian Westphal <fw@strlen.de>
References: <20260302205527.1982836-1-edumazet@google.com>
 <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
 <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
 <aiaOor1JLLu5Xn75@1wt.eu> <90cb7e92-2451-4c67-9f35-6ff96b7efd77@yeah.net>
 <0e89ceb5-a2ae-4e7c-8fe2-5b6a89ba6ac5@linux.dev> <aibaZyz4MT8Ixt0N@1wt.eu>
From: xietangxin <xietangxin@yeah.net>
In-Reply-To: <aibaZyz4MT8Ixt0N@1wt.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgBX9kKoHSpqyXwyAA--.294S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFWxWFWfWr4DArWUArWUurg_yoW3Xw4DpF
	WrKFnrtrWkJry3twn2k3WUWF1YvrZ3XrWDWrn5K3srA3s09ry2qF48tr4j9ayjkr4kCrW2
	qayjqrnrt3s8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUUUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiIgqWymoqHar8wQAA3+
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URL_NUMERIC_IP(1.50)[10.0.0.1];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297897-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:w@1wt.eu,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:pablo@netfilter.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:dengzhouyan_nwpu@163.com,m:fw@strlen.de,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yeah.net:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,netfilter.org,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,163.com,strlen.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[yeah.net];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37BD966DD58



On 6/8/2026 11:06 PM, Willy Tarreau wrote:
> On Mon, Jun 08, 2026 at 09:14:26PM +0800, Jiayuan Chen wrote:
>>
>> On 6/8/26 8:51 PM, xietangxin wrote:
>>>
>>> On 6/8/2026 5:42 PM, Willy Tarreau wrote:
>>>> On Mon, Jun 08, 2026 at 01:51:49AM -0700, Eric Dumazet wrote:
>>>>> On Sat, Jun 6, 2026 at 4:06 AM xietangxin <xietangxin@yeah.net> wrote:
>>>>>>
>>>>>> Hi Eric and netdev,
>>>>>>
>>>>>> I noticed a significant TCP performance regression (QPS drop) when using
>>>>>> iptables MASQUERADE with the `--random-fully` option, and I have bisected
>>>>>> it down to commit 165573e41f2f66ef98940cf65f838b2cb575d9d1
>>>>>> (tcp: secure_seq: add back ports to TS offset).
>>>>>>
>>>>>> Here is the benchmark environment and test results.
>>>>>> Environment:
>>>>>> - Client & Server: 2 VMs
>>>>>> - Server: Nginx listening on port 80 (HTTP), and ip 10.0.0.1
>>>>>> - Benchmark tool: wrk (short-lived connections with "Connection: close")
>>>>>>
>>>>>> Test Commands
>>>>>> 1. With random-fully:
>>>>>>     # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE --random-fully
>>>>>>     # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
>>>>>> 2. Without random-fully:
>>>>>>     # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE
>>>>>>     # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
>>>>>>
>>>>>> Test Results (QPS):
>>>>>> 1. Parent Commit (7f083faf59d14c04e01ec05a7507f036c965acf8):
>>>>>>     - with random-fully:    18145.74, 15006.39, 15716.67
>>>>>>     - without random-fully: 18556.36, 16339.22, 21506.02
>>>>>>
>>>>>> 2. Bad Commit (165573e41f2f66ef98940cf65f838b2cb575d9d1):
>>>>>>     - with random-fully:    11074.76, 10383.20, 10164.81  <-- (~35% drop)
>>>>>>     - without random-fully: 17310.75, 20279.85, 18399.48
>>>>>>
>>>>>> Is this performance degradation an expected side-effect of the security fix,
>>>>>> or is there any sysctl param we should tune when `--random-fully` is
>>>>>> required for high-concurrency short connections?
>>>>> Hi Tangxin
>>>>>
>>>>> I do not know why that patch would affect MASQUERADE performance.
>>>>>
>>>>> Pablo, Florian, do you have an idea?
>>>> I suspect it's because MASQUERADE can shuffle the ports around and
>>>> break the end-to-end mapping. With host-based ISN the increments
>>>> remain positive regardless of the ports, while with port-based
>>>> increments if you shuffle ports around, two consecutive uses of
>>>> the same port can end up showing a decreasing ISN, and some
>>>> outgoing SYN will get an ACK instead of a SYN-ACK, then send an
>>>> RST, and a SYN again, causing a degradation.
>>>>
>>>> I'm not saying this is necessarily what happens here but based on the
>>>> commit message description I suspect that this is what's happening
>>>> here. There's always a tradeoff between ISN secrecy and reliability
>>>> unfortunately.
>>>>
>>>> Willy
>>> Hi,
>>>
>>> Willy, your hypothesis is 100% correct!
>>> I captured the packets during the benchmark on the bad commit,
>>> and the trace perfectly shows the "SYN -> ACK -> RST".
>>>
>>> Here is the key snippet of the packet trace (Client: 10.0.0.2, Server: 10.0.0.1):
>>>
>>> // 1. First connection closes, Server sends last ACK(410615916), entering TIME_WAIT.
>>> 12105 08:54:39.128861 10.0.0.1 -> 10.0.0.2 TCP 80 -> 47824 [ACK] Seq=3315216203 Ack=410615916 TSval=273827652 TSecr=370383870
>>>
>>> // 2. ~200ms later, next short-conn reuses port 47824 via MASQUERADE --random-fully
>>> 47637 08:54:39.332281 10.0.0.2 -> 10.0.0.1 TCP 47824 -> 80 [SYN] Seq=559739866 TSval=4137539723 TSecr=0
>>>
>>> // 3. Server is sends a ACK with the old connection's expected ACK(410615916).
>>> 48591 08:54:39.337692 10.0.0.1 -> 10.0.0.2 TCP 80 -> 47824 [ACK] Seq=3315216203 Ack=410615916 TSval=273827858 TSecr=370383870
>>>
>>> // 4. Client receives the unexpected old ACK, responds with RST, and has to retry the connection.
>>> 48600 08:54:39.337799 10.0.0.2 -> 10.0.0.1 TCP 47824 -> 80 [RST] Seq=410615916 Win=0
>>>
>>>
>>> Are there any architectural recommendations we should consider here,
>>> or is this considered an acceptable trade-off for security?
>>
>>
>> It's classic PAWS problem when packets go through NAT/Gateway.
>>
>> Can you test the performance with following different two configs (client) ?
>>
>>     sysctl -w net.ipv4.tcp_timestamps=2
>>
>>     sysctl -w net.ipv4.tcp_timestamps=0
> 
> The thing is, nothing forces a server to use PAWS to distinguish SYNs,
> and some OSes only apply the spec to the letter (at least Solaris in
> my experience). The spec basically says that PAWS protects against
> duplicate non-SYN segments, and duplicate SYNs while there is a
> connection. So while Linux (and other OSes) nicely covers the case
> of the transition from TIME_WAIT to SYN_RECV, others do not always do
> it.
> 
> Regardless, while I hate it when we play borderline games with TCP for
> the sake of supposed security issues that can only be demonstrated in
> a lab, we must admit that masquerading remains an issue when the same
> port range is shared between multiple hosts, even with PAWS since there
> is no reason for multiple hosts to have the same clock.
> 
> Willy
Hi Willy, Jiayuan and all,

Thanks for the excellent analysis. I have verified the suggestions
and captured detailed traces.

- using `tcp_timestamps=2` on the client completely restores performance
  because it sets `ts_offset = 0`.
- we found that recalculating the `ts_offset` in Netfilter
after NAT port allocation also completely fixes the regression.

Here are the detailed test results, packet analysis, and a potential fix:

1. Test Results with different tcp_timestamps (on commit 165573e41f2f)
- With net.ipv4.tcp_timestamps=2 (ts_offset = 0):
  * with random-fully:    21198.8,  20754.97, 21598.64 (Performance recovered)
  * without random-fully: 21561.6,  22531.71, 23119.88

- With net.ipv4.tcp_timestamps=0 (Timestamps disabled):
  * with random-fully:    12018.82, 10098.1,  10714.86 (Still suffers)
  * without random-fully: 18409.88, 20951.87, 24635.95

2. Packet Analysis: PAWS Failure due to Non-monotonic TSval
I captured the traffic during the regression. The majority of the "SYN -> ACK -> RST"
cases occur because the new SYN's TSval is smaller than the TIME_WAIT socket's TSval
(confirmed via the TSecr in the ACK).

Client -> Server 24870 → 80 [SYN] Seq=3540240581 TSval=2294041168 TSecr=0
Server -> Client 80 → 24870 [ACK] Seq=2293248269 Ack=855605690 TSecr=2846236456
Client -> Server 24870 → 80 [RST] Seq=855605690

When Conn1 (local sport 10000) and Conn2 (local sport 20000) are both mapped to the
same external sport 30000 via `--random-fully`, their TS offsets are calculated
as `ts_offset1(10000)` and `ts_offset2(20000)`.

If Conn2 reuses the TIME_WAIT slot of Conn1 on the server, there is a chance that
`ts_offset2 < ts_offset1`, which breaks the TSval monotonicity for the same 4-tuple.


3. A Potential Fix: Recalculating ts_offset in Netfilter
I wrote a quick demo patch to update the `ts_offset` inside `tcp_manip_pkt` using
the newly mapped port. The results show that performance is completely restored:

- With Netfilter Demo Patch:
  * with random-fully:    21966.86, 21113.68, 20763.9 (Performance recovered!)
  * without random-fully: 19306.86, 20018.69, 20288.24

Since I am not an expert in netfilter internals, I am wondering if recalculating
the `ts_offset` during the NAT mangling phase is an acceptable approach?
-- 
Best regards,
Tangxin Xie


