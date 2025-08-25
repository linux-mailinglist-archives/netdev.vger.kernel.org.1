Return-Path: <netdev+bounces-216387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FC9B3363C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C0A3ACEE3
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D40259CBF;
	Mon, 25 Aug 2025 06:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CE+vAcO5"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1D28F4;
	Mon, 25 Aug 2025 06:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102328; cv=none; b=jWkW2f+C9vcMfpAgzVvkzTDfwv+JbFjPC/X3KoBgRddgZvE4lD+rVh/MJ3dMKa3/yVBNehZ/L0v3uHI/TPg4SRcKZbC+EzyHD7DRdNkbJUV51t4O+cYh6BRdoHgDTBwPdxzVuksus8N6g1t2PhodgsDXAm6odEtJlNq1zMDS+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102328; c=relaxed/simple;
	bh=hES61pxyW+aLa3EIYC28d/SDsB12oM5371Zu/Ui2IcA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EZEME6zfHkOskw2NGeLT+RRPvxVVp8vbzyzdLFI1MQLUf1sW+0wtWahlalbOlQWcTTgQMN3t7dWgZoTBoIza6C+CTRbkVkGSCGYTqhq0CYHDBaoo0d63xDWgFYdD1vj9PYSxo6WUewZ2zxQ1MuenGHOTdtSDAtDVio7gIVakjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CE+vAcO5; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756102321; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=cT+ygFc4zTp7J/tI7KMliEmaerRfctw68x2RPKh9M54=;
	b=CE+vAcO5kMoSVDM/SiyOJj/CF81Hw1/f1WNCl5Ga5E5c8kEfdxbFaGhhCAkZmoakLp7rKDMutZAj+cKVqC70fPaWU6aRWL0gm4O5dCIwkvySpGkkqoj9Nw+MKyXemVr18rFPISAneAzD9lHJCZDCst8BFD26OsnpBvrQLL0lwi4=
Received: from 30.178.83.31(mailfrom:mii.w@linux.alibaba.com fp:SMTPD_---0WmRfxZb_1756102301 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 14:12:00 +0800
Message-ID: <c8cafeaf-f36c-4eed-9ed1-7e2c2068e162@linux.alibaba.com>
Date: Mon, 25 Aug 2025 14:11:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: MingMing Wang <mii.w@linux.alibaba.com>
Subject: Re: [RFC net] tcp: Fix orphaned socket stalling indefinitely in
 FIN-WAIT-1
To: Eric Dumazet <edumazet@google.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ycheng@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250822060254.74708-1-mii.w@linux.alibaba.com>
 <CANn89iLYHdtAFSjSW+cSN0Td_V3B+V05hHnGeop5Y+hjWEt_HA@mail.gmail.com>
In-Reply-To: <CANn89iLYHdtAFSjSW+cSN0Td_V3B+V05hHnGeop5Y+hjWEt_HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/22 16:53, Eric Dumazet wrote:
> On Thu, Aug 21, 2025 at 11:04 PM MingMing Wang <mii.w@linux.alibaba.com> wrote:
>>
>> From: MingMing Wang <mii.w@linux.alibaba.com>
>>
>> An orphaned TCP socket can stall indefinitely in FIN-WAIT-1
>> if the following conditions are met:
>> 1. net.ipv4.tcp_retries2 is set to a value ≤ 8;
>> 2. The peer advertises a zero window, and the window never reopens.
>>
>> Steps to reproduce:
>> 1. Set up two instances with nmap installed: one will act as the server
>>     the other as the client
>> 2. Execute on the server:
>>     a. lower rmem : `sysctl -w net.ipv4.tcp_rmem="16 32 32"`
>>     b. start a listener: `nc -l -p 1234`
>> 3. Execute on the client:
>>     a. lower tcp_retries2: `sysctl -w net.ipv4.tcp_retries2=8`
>>     b. send pakcets: `cat /dev/zero | nc <server-ip> 1234`
>>     c. after five seconds, stop the process: `killall nc`
>> 4. Execute on the server: `killall -STOP nc`
>> 5. Expected abnormal result: using `ss` command, we'll notice that the
>>     client connection remains stuck in the FIN_WAIT1 state, and the
>>     backoff counter always be 8 and no longer increased, as shown below:
>>     ```

Thanks for your suggestions, Eric. We will prepare the packetdrill test
and resend a series of two patches.

> 
> Hi MingMing
> 
> Please prepare and share with us a packetdrill test, instead of this
> 'repro', which is the old way of describing things :/
> 
> - This will be easier for us to understand the issue.
> 
> - It will be added to existing tests in tools/testing/selftests/net/packetdrill
> if your patch is accepted, so that we can make sure future changes are
> not breaking this again.
> 
> Ideally, you should attach this packetdrill test in a second patch
> (thus sending a series of two patches)
> 
> Thank you.
> 
>>     FIN-WAIT-1 0      1389    172.16.0.2:50316    172.16.0.1:1234
>>           cubic wscale:2,7 rto:201 backoff:8 rtt:0.078/0.007 mss:36
>>                   ... other fields omitted ...
>>     ```
>> 6. If we set tcp_retries2 to 15 and repeat the steps above, the FIN_WAIT1
>>     state will be forcefully reclaimed after about 5 minutes.
>>
>> During the zero-window probe retry process, it will check whether the
>> current connection is alive or not. If the connection is not alive and
>> the counter of retries exceeds the maximum allowed `max_probes`, retry
>> process will be terminated.
>>
>> In our case, when we set `net.ipv4.tcp_retries2` to 8 or a less value,
>> according to the current implementation, the `icsk->icsk_backoff` counter
>> will be capped at `net.ipv4.tcp_retries2`. The value calculated by
>> `inet_csk_rto_backoff` will always be too small, which means the
>> computed backoff duration will always be less than rto_max. As a result,
>> the alive check will always return true. The condition before the
>> `goto abort` statement is an logical AND condition, the abort branch
>> can never be reached.
>>
>> So, the TCP retransmission backoff mechanism has two issues:
>>
>> 1. `icsk->icsk_backoff` should monotonically increase during probe
>>     transmission and, upon reaching the maximum backoff limit, the
>>     connection should be terminated. However, the backoff value itself
>>     must not be capped prematurely — it should only control when to abort.
>>
>> 2. The condition for orphaned connection abort was incorrectly based on
>>     connection liveness and probe count. It should instead consider whether
>>     the number of orphaned probes exceeds the intended limit.
>>
>> To fix this, introduce a local variable `orphan_probes` to track orphan
>> probe attempts separately from `max_probes`, which is used for RTO
>> retransmissions. This decouples the two counters and prevents accidental
>> overwrites, ensuring correct timeout behavior for orphaned connections.
>>
>> Fixes: b248230c34970 ("tcp: abort orphan sockets stalling on zero window probes")
>> Co-developed-by: Dust Li <dust.li@linux.alibaba.com>
>> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
>> Co-developed-by: MingMing Wang <mii.w@linux.alibaba.com>
>> Signed-off-by: MingMing Wang <mii.w@linux.alibaba.com>
>>
>> ---
>> We couldn't determine the rationale behind the following check in tcp_send_probe0():
>> ```
>> if (icsk->icsk_backoff < READ_ONCE(net->ipv4.sysctl_tcp_retries2))
>>      icsk->icsk_backoff++;
>> ```
>>
>> This condition appears to be the root cause of the observed stall.
>> However, it has existed in the kernel for over 20 years — which suggests
>> there might be a historical or subtle reason for its presence.
>>
>> We would greatly appreciate it if anyone could shed
>> ---
>>   net/ipv4/tcp_output.c | 4 +---
>>   net/ipv4/tcp_timer.c  | 4 ++--
>>   2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index caf11920a878..21795d696e38 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -4385,7 +4385,6 @@ void tcp_send_probe0(struct sock *sk)
>>   {
>>          struct inet_connection_sock *icsk = inet_csk(sk);
>>          struct tcp_sock *tp = tcp_sk(sk);
>> -       struct net *net = sock_net(sk);
>>          unsigned long timeout;
>>          int err;
>>
>> @@ -4401,8 +4400,7 @@ void tcp_send_probe0(struct sock *sk)
>>
>>          icsk->icsk_probes_out++;
>>          if (err <= 0) {
>> -               if (icsk->icsk_backoff < READ_ONCE(net->ipv4.sysctl_tcp_retries2))
>> -                       icsk->icsk_backoff++;
>> +               icsk->icsk_backoff++;

We agree with your perspective. Futhermore, as mentioned in the raw
text, we would appreciate it if you could clarify whether this cap is
just to prevent overflow by using a huge value, or if it should be set
to a specific meaningful value.

> 
> I think we need to have a cap, otherwise we risk overflows in
> inet_csk_rto_backoff()
> 
> 
>>                  timeout = tcp_probe0_when(sk, tcp_rto_max(sk));
>>          } else {
>>                  /* If packet was not sent due to local congestion,
>> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
>> index a207877270fb..4dba2928e1bf 100644
>> --- a/net/ipv4/tcp_timer.c
>> +++ b/net/ipv4/tcp_timer.c
>> @@ -419,9 +419,9 @@ static void tcp_probe_timer(struct sock *sk)
>>          if (sock_flag(sk, SOCK_DEAD)) {
>>                  unsigned int rto_max = tcp_rto_max(sk);
>>                  const bool alive = inet_csk_rto_backoff(icsk, rto_max) < rto_max;
>> +               int orphan_probes = tcp_orphan_retries(sk, alive);
>>
>> -               max_probes = tcp_orphan_retries(sk, alive);
>> -               if (!alive && icsk->icsk_backoff >= max_probes)
>> +               if (!alive || icsk->icsk_backoff >= orphan_probes)
>>                          goto abort;
>>                  if (tcp_out_of_resources(sk, true))
>>                          return;
>> --
>> 2.46.0
>>


