Return-Path: <netdev+bounces-292585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IVDMj33F2q5WAgAu9opvQ
	(envelope-from <netdev+bounces-292585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:05:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA6F5EE370
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09308300187C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B804935E1AE;
	Thu, 28 May 2026 07:59:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442CB359703
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955180; cv=none; b=PvX74+RV9sjlMPP7SRQ9Ln4jG6e/VbbzDbbWzBQMrGncsiBoni0PdmnzpokL/neDWmh9tcdTliQJC3ITq26+QJ95LFXTnyQS5e/gYU5G7tPUwKObsHRJos9+Gk6i6oR+UsfhqRpJDF74ToJjwp+aR2cubnVPQab6sCcbdJnt0+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955180; c=relaxed/simple;
	bh=mFjB4CESgntP7N+FFVHlYwrEkAUwNjJQOBKNF8wVBBk=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EqJNefPQSJILJ3644p9MFGknnlqUaqxygl56MakJ4bFdytKd1t3XT5onHdy1UqKEOeA+mRGJPvuCfkoOy+/O1VOY7fSUR5loUMxYxO30OqRYS3103cYaZtgjSjqeME8L1/dNwaM9sH9tZvYeeijtci6+7OboMhweNhJH8HVMUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shinnytech.com; spf=fail smtp.mailfrom=shinnytech.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shinnytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=shinnytech.com
X-QQ-mid: esmtpgz13t1779955160tefa1e03c
X-QQ-Originating-IP: wbzZo67sKEQ+ggapJEw0x4zBiFbsvI47BgCVPYoI/oo=
Received: from [192.168.0.218] ( [58.32.25.94])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 May 2026 15:59:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9761158138187529335
Subject: Re: [PATCH net-next] tcp: fix spurious connection aborts due to
 TCP_USER_TIMEOUT and zero window
To: Eric Dumazet <edumazet@google.com>
References: <EDFF6E75FB9C46D0+ac77bc6c-2057-dfc5-4541-05679f6a6bce@shinnytech.com>
 <CANn89iK_MvaXcVufptM_k+4Jq8zUEGBXPG0frR62m1+J6QqY=A@mail.gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org
From: chengzhi <chengzhi@shinnytech.com>
Organization: shinnytech
Message-ID: <7A785EFD99B22B64+e829f413-c848-f035-95ac-52caa576200b@shinnytech.com>
Date: Thu, 28 May 2026 15:59:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iK_MvaXcVufptM_k+4Jq8zUEGBXPG0frR62m1+J6QqY=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:shinnytech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Nuk8bQLQf5MZSyyuZ2KdqyzCWTtoDZPsH+s723NV1+ePzy7tVuX8VVgA
	vn0qwTC8NG58ymu3YZ0EOAGIiA5Y4PSFnTqTj5UoOrniF+EP0X4tKOwsyZBC322Dki3InhM
	Fxb0D3UubBEIeJisdKJd9I26bNfyDc7R8dDtPf4TtZScQX7pRVhzdAy2+3A0bPvlYPBVHM9
	Tn9f8UqjH96WdJRYrl2LDiMSevaXPN/OCpVfF5Lq3mkvHbMTvI45zfrviuseYc6sF+5v9wm
	2OpI5IqLDwIA2Egiye+p8h/Uuw+14dcl3rgr/sZmuhO/y+R9lAxhXxBj4Hh8flLiWO3nMCX
	u6z496B4Z3MYzO5xgz6E0J4pHqBAjQYtR6dzopz0KwkmpmhJ9qeq1q9KXLoBjgYBmKz0wgg
	WKLtf6WxIDN5grzwWfHZowrkXFDCUpCsSneGdopKtWOJx/lvmzUxBfv1tD4GEePJaLvdfNy
	5tmV+wEnv57eN+0cLmGf9rFVnf9oofG/ez91OJFtzC9S2tP14Ho63qdCesuWPTMMQwPNu+Z
	dCiz8E0oX7LZFzWdMdCpggqmywAkirCqBGHsylDKpVAOYiZ5TLL/udtK0ct+VIASnyrffDn
	Td3eCD4Fw9G/UffGiWWWWxbm5TmREZtGYJmMiV7A7dJ5s9JA+9J3dQ4tGs5sJCX9qQN3qtv
	0Z17vOSZem2hp280gtLswV6qiboqiDAEyhJmbMD+x6rwGC4Rb8l74DP7S2iKb2vTQ6Fa/Yp
	rVQDpfiKLDLnI3ZqGj4povY4eMax1S78xhppQFwXZBUXNAsaaqLj3Cc9rmUkOxZFXh670YH
	hhZCrbDQFgS+ctJcGREHGzFaIchaGb6AK8Zqa6qLzNWNAzt9PRNdCmSt4cJjk+aANENHNfi
	rnWxznpokSp0OK3zSGKpNJtfPjgutyOtB0vVe4BpPVfqQwUm+R7/c/CmJNGCuWagKOy+21o
	Gy6zXUje725z1Q74OMJjV/2+yI1SmC51e2YbA+H7NuGsmGAcf7NWWGOwE
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292585-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[shinnytech.com];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengzhi@shinnytech.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7EA6F5EE370
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-5-27 21:40, Eric Dumazet wrote:
> On Wed, May 27, 2026 at 1:16 AM Zhi Cheng <chengzhi@shinnytech.com> wrote:
>>
>> Under certain conditions, a stale icsk_probes_tstamp can lead to an
>> unexpected connection abort during a zero-window state.
>>
>> The exact sequence leading to the timeout is as follows:
>> 1. A zero window occurs. icsk_probes_tstamp is set.
>> 2. The window opens slightly. tcp_ack_probe() is called because there
>>      are no in-flight packets. However, icsk_probes_tstamp is not cleared
>>      because the window is not large enough to fit the tcp_send_head.
>> 3. Packets been sent, and RTO is armed which overrides the probe timer.
>> 4. Subsequent ACKs consistently acknowledge packets and the window
>>      never fully closes. Because there are now in-flight packets,
>>      tcp_ack_probe() is never called again.
>> 5. As a result, icsk_probes_tstamp is never updated despite the
>>      connection no longer in the zero-window state.
>> 6. Much later, another zero window occurs. When probe timer triggers,
>>      tcp_probe_timer() evaluates the extremely old icsk_probes_tstamp and
>>      immediately aborts the connection due to TCP_USER_TIMEOUT.
>>
>> Fix this by explicitly clearing icsk_probes_tstamp in tcp_ack()
>> whenever prior_packets is non-zero, ensuring that the probe
>> timestamp is reset when exit zero-window state.
>>
>> Fixes: 9d9b1ee0b2d1 ("tcp: fix TCP_USER_TIMEOUT with zero window")
>> Signed-off-by: Zhi Cheng <chengzhi@shinnytech.com>
>> ---
>>    net/ipv4/tcp_input.c | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index de9f68a9c0cf..02de64881b76 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -4365,6 +4365,7 @@ static int tcp_ack(struct sock *sk, const struct
>> sk_buff *skb, int flag)
>>          tp->rcv_tstamp = tcp_jiffies32;
>>          if (!prior_packets)
>>                  goto no_queue;
>> +       icsk->icsk_probes_tstamp = 0;
>>
>>          /* See if we can take anything off of the retransmit queue. */
>>          flag |= tcp_clean_rtx_queue(sk, skb, prior_fack, prior_snd_una,
> 
> tcp_ack() is TCP fast path and  icsk_probes_tstamp was not yet touched
> in TCP fast path....

icsk_probes_out already been touched in the fast path, maybe it can also
be refactored out to the slow path?

> 
> diff --git a/Documentation/networking/net_cachelines/inet_connection_sock.rst
> b/Documentation/networking/net_cachelines/inet_connection_sock.rst
> index cc2000f55c29879a12c0e4d238242b01cee18091..dfb2ecb4c1621f2eac2f3183ed63057af90dba76
> 100644
> --- a/Documentation/networking/net_cachelines/inet_connection_sock.rst
> +++ b/Documentation/networking/net_cachelines/inet_connection_sock.rst
> @@ -45,7 +45,7 @@ struct icsk_mtup_int                search_low
>        read_write
>   struct icsk_mtup_u32:31             probe_size             read_write
> 
> tcp_mtup_init,tcp_connect_init,__tcp_transmit_skb
>   struct icsk_mtup_u32:1              enabled                read_write
> 
> tcp_mtup_init,tcp_sync_mss,tcp_connect_init,tcp_mtu_probe,tcp_write_xmit
>   struct icsk_mtup_u32                probe_timestamp        read_write
> 
> tcp_mtup_init,tcp_connect_init,tcp_mtu_check_reprobe,tcp_mtu_probe
> -u32                                 icsk_probes_tstamp
> +u32                                 icsk_probes_tstamp
>           read_write          tcp_ack
>   u32                                 icsk_user_timeout
>   u64[104/sizeof(u64)]                icsk_ca_priv
>   =================================== ======================
> =================== ===================
> ========================================================================================================================================================
> 
> An alternative would be to clear icsk_probes_tstamp in a less hot path.
> 
> Perhaps:
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index f063eccbbba340b39abc79b5541adca369d63d7c..751a407f64c2ba90e7b72d48942506870a994a2e
> 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1631,6 +1631,13 @@ static inline void tcp_reset_xmit_timer(struct sock *sk,
>                                          unsigned long when,
>                                          bool pace_delay)
>   {
> +       if (what != ICSK_TIME_PROBE0) {
> +               struct inet_connection_sock *icsk = inet_csk(sk);
> +
> +               if (icsk->icsk_pending == ICSK_TIME_PROBE0)
> +                       icsk->icsk_probes_tstamp = 0;
> +       }
> +
>          if (pace_delay)
>                  when += tcp_pacing_delay(sk);
>          inet_csk_reset_xmit_timer(sk, what, when,
> 

What if data received during the zero-window state and memory pressure
causing ICSK_TIME_DACK armed by __tcp_send_ack()? I don't think it
should clear icsk_probes_tstamp in this case.

Maybe checking packets_out directly?

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 98848db62894..f91c7202365e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1622,6 +1622,11 @@ static inline void tcp_reset_xmit_timer(struct 
sock *sk,
                                         unsigned long when,
                                         bool pace_delay)
  {
+       struct inet_connection_sock *icsk = inet_csk(sk);
+       struct tcp_sock *tp = tcp_sk(sk);
+       if (tp->packets_out)
+               icsk->icsk_probes_tstamp = 0;
+
         if (pace_delay)
                 when += tcp_pacing_delay(sk);
         inet_csk_reset_xmit_timer(sk, what, when,

