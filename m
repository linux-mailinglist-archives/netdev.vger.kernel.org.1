Return-Path: <netdev+bounces-245368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B646CCC5DB
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 117A2308D617
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAE6243968;
	Thu, 18 Dec 2025 14:58:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CE2CCB9
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069887; cv=none; b=oPgUW9j6U5MH4IhKq+/AyRhWmloeSX1iPg6crRnhwKhMIVSAZS5vR9ge7YSgmyqrgcbvR66Wy24zLABaZLhxs1ipvsI0WbOTxRVQgp/DJbwzpnuwnxL4CMbhmE4pSBUA+uOOnzvl1mdXXYd1knwfxx7AKFNHzFaWTTRyAHupY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069887; c=relaxed/simple;
	bh=wpxxcQLdLnbtVyYOvN2Bs7hF9G39FLwvVvSoaTp7YpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdceffEvwL3p6PYDVRFI1OTSq10UxMfR+87p0ttfXq6gVxO/k0RqU7tH+yG2EKlxh/ceoFnfn/iRS+zdItfdymeJqTeTtaFkaAr/BCUMHrQUtur8WVv/n0Xjr/5ZTGg6N2JXz9e+hqWW+ej76ErAffgNYn4ofd1YMwBFYBQVJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1611F4719C;
	Thu, 18 Dec 2025 15:58:03 +0100 (CET)
Message-ID: <64d8fa05-63a2-420e-8b97-c51cb581804a@proxmox.com>
Date: Thu, 18 Dec 2025 15:58:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 lkolbe@sodiuswillert.com
References: <20250711114006.480026-1-edumazet@google.com>
 <20250711114006.480026-8-edumazet@google.com>
 <cd44c0d2-17ed-460d-9f89-759987d423dc@proxmox.com>
 <8f8836dd-c46f-403c-b478-a9e89dd62912@proxmox.com>
 <CANn89iL=MTgYygnFaCeaMpSzjooDgnzwUd_ueSnJFxasXwyMwg@mail.gmail.com>
 <c1ae58f7-cf31-4fb6-ac92-8f7b61272226@proxmox.com>
 <CANn89iJRCW3VNsY3vZwurvh52diE+scUfZvwx5bg5Tuoa3L_TQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Christian Ebner <c.ebner@proxmox.com>
In-Reply-To: <CANn89iJRCW3VNsY3vZwurvh52diE+scUfZvwx5bg5Tuoa3L_TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1766069870122

On 12/18/25 2:19 PM, Eric Dumazet wrote:
> On Thu, Dec 18, 2025 at 1:28 PM Christian Ebner <c.ebner@proxmox.com> wrote:
>>
>> Hi Eric,
>>
>> thank you for your reply!
>>
>> On 12/18/25 11:10 AM, Eric Dumazet wrote:
>>> Can you give us (on receive side) : cat /proc/sys/net/ipv4/tcp_rmem
>>
>> Affected users report they have the respective kernels defaults set, so:
>> - "4096 131072 6291456"  for v.617 builds
>> - "4096 131072 33554432" with the bumped max value of 32M for v6.18 builds
>>
>>> It seems your application is enforcing a small SO_RCVBUF ?
>>
>> No, we can exclude that since the output of `ss -tim` show the default
>> buffer size after connection being established and growing up to the max
>> value during traffic (backups being performed).
>>
> 
> The trace you provided seems to show a very different picture ?
> 
> [::ffff:10.xx.xx.aa]:8007
>         [::ffff:10.xx.xx.bb]:55554
>            skmem:(r0,rb7488,t0,tb332800,f0,w0,o0,bl0,d20) cubic
> wscale:10,10 rto:201 rtt:0.085/0.015 ato:40 mss:8948 pmtu:9000
> rcvmss:7168 advmss:8948 cwnd:10 bytes_sent:937478 bytes_acked:937478
> bytes_received:1295747055 segs_out:301010 segs_in:162410
> data_segs_out:1035 data_segs_in:161588 send 8.42Gbps lastsnd:3308
> lastrcv:191 lastack:191 pacing_rate 16.7Gbps delivery_rate 2.74Gbps
> delivered:1036 app_limited busy:437ms rcv_rtt:207.551 rcv_space:96242
> rcv_ssthresh:903417 minrtt:0.049 rcv_ooopack:23 snd_wnd:142336 rcv_wnd:7168
> 
> rb7488 would suggest the application has played with a very small SO_RCVBUF,
> or some memory allocation constraint (memcg ?)

Thanks for the hint were to look, however we checked that the process is 
not memory constrained and the host has no memory pressure.

Also `strace -f -e socket,setsockopt -p $(pidof proxmox-backup-proxy)` 
shows no syscalls which would change the socket buffer size (though this 
still needs to be double checked by affected users for completeness).

Further, the stalls most often happen mid transfer, starting with the 
expected throughput and even might recover from the stall after some 
time, continue at regular speed again.


Status update for v6.18
-----------------------

In the meantime, a user reported 2 stale connections with running kernel 
6.18+416dd649f3aa

The tcpdump pattern looks slightly different, here we got repeating 
sequences of:
```
224	5.407981	10.xx.xx.bb	10.xx.xx.aa	TCP	4162	40068 → 8007 [PSH, ACK] 
Seq=106497 Ack=1 Win=3121 Len=4096 TSval=3198115973 TSecr=3048094015
225	5.408064	10.xx.xx.aa	10.xx.xx.bb	TCP	66	8007 → 40068 [ACK] Seq=1 
Ack=110593 Win=4 Len=0 TSval=3048094223 TSecr=3198115973
```

The perf trace for `tcp:tcp_rcvbuf_grow` came back empty while in stale 
state, tracing with:
```
perf record -a -e tcp:tcp_rcv_space_adjust,tcp:tcp_rcvbuf_grow
perf script
```
produced some output as shown below, so it seems that tcp_rcvbuf_grow() 
is never called in that case, while tcp_rcv_space_adjust() is.

```
  tokio-runtime-w    4930 [002]  6094.017275: tcp:tcp_rcv_space_adjust: 
family=AF_INET6 sport=8007 dport=40068 saddr=10.xx.xx.aa 
daddr=10.xx.xx.bb saddrv6=::ffff:10.xx.xx.aa daddrv6=::ffff:10.xx.xx.bb 
sock_cookie=101a
  tokio-runtime-w    4930 [002]  6094.187083: tcp:tcp_rcv_space_adjust: 
family=AF_INET6 sport=8007 dport=49944 saddr=10.xx.xx.aa 
daddr=10.xx.xx.bb saddrv6=::ffff:10.xx.xx.aa daddrv6=::ffff:10.xx.xx.bb 
sock_cookie=2
```

ss -tim
```
ESTAB 0      0      [::ffff:10.xx.xx.aa]:8007 [::ffff:10.xx.xx.bb]:40068
          skmem:(r0,rb4352,t0,tb332800,f0,w0,o0,bl0,d199) cubic 
wscale:7,10 rto:201 rtt:0.093/0.025 ato:40 mss:8948 pmtu:9000 
rcvmss:4096 advmss:8948 cwnd:10 ssthresh:16 bytes_sent:451949 
bytes_acked:451949 bytes_received:805775577 segs_out:59050 segs_in:72440 
data_segs_out:392 data_segs_in:72287 send 7.7Gbps lastsnd:75880 
lastrcv:167 lastack:167 pacing_rate 9.16Gbps delivery_rate 2.09Gbps 
delivered:393 app_limited busy:756ms rcv_rtt:207.343 rcv_space:107600 
rcv_ssthresh:312270 minrtt:0.055 rcv_ooopack:287 snd_wnd:399488 rcv_wnd:4096
ESTAB 0      0      [::ffff:10.xx.xx.aa]:8007 [::ffff:10.xx.xx.bb]:49944
          skmem:(r0,rb4352,t0,tb332800,f0,w0,o0,bl0,d286) cubic 
wscale:7,10 rto:201 rtt:0.213/0.266 ato:40 mss:8948 pmtu:9000 
rcvmss:4096 advmss:8948 cwnd:10 ssthresh:17 bytes_sent:1255369 
bytes_acked:1255369 bytes_received:55175665 segs_out:11516 segs_in:8473 
data_segs_out:354 data_segs_in:8038 send 3.36Gbps lastsnd:111496 
lastrcv:14 lastack:14 pacing_rate 4.03Gbps delivery_rate 2.42Gbps 
delivered:355 busy:103ms rcv_rtt:207.596 rcv_space:79779 
rcv_ssthresh:198722 minrtt:0.07 rcv_ooopack:6 snd_wnd:439552 rcv_wnd:4096
```

Best regards,
Christian Ebner


