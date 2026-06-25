Return-Path: <netdev+bounces-301959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mZJJI9wrPWqyyQgAu9opvQ
	(envelope-from <netdev+bounces-301959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:23:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5FC6C61BC
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:23:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yeah.net header.s=s110527 header.b=lW6UpjAy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301959-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301959-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yeah.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A03D33004D0C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA203324B31;
	Thu, 25 Jun 2026 13:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96923C516;
	Thu, 25 Jun 2026 13:23:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393814; cv=none; b=kG4zWH80Bn8Y5BJLmIN9ZDALRPgsbTV95DfcVJEZvb6WK6yP/W/ktpg7uWllZxK4LFfjE29wqMo/cBD6A13nk/JNw6/sEpJWdveOmq+3bdr+Ud0PGYRdQX4tRyYamoijAk23+Zj8atxsE27IdH/yXMztmZfw3tuGlkuyw2+aVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393814; c=relaxed/simple;
	bh=+tkMH6jyKTm8lPIHgKIXG9i6uma37p5YMiK6CXfUI4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYNH0VdX6oU2W9FrS+0P7NOnvJYVga2CiLpK+fbfXWwNaTU16il6bYIiWzhMOdcKjqZDqUAF6jI5F8deyrEaVPh4w417IYtB7uDnM6r6g1nfSJhBqH4S5ML4Dp8E3lqpOGBivWtPvqceU47lG7Q4eI1dw1N8EeQd8/BrgcIFwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lW6UpjAy; arc=none smtp.client-ip=220.197.32.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=N+RBk4CiZmBuhtTLrDyIBUQwhv4MJJ7hR5rq2loSkBU=;
	b=lW6UpjAyBa5AtGIyhNborrH7g6cn7viMVK6HzaZCEagdEDpV6kXzZlO70HUOlD
	ucc734YYGT3Uy0kL4/UOJg0r2R31CmQ56c4qUDZfTlKUr9liEmqqRCH/KN5s2CXv
	XCHH1U1yPIGVmfJLIn89WG2PdjNNt4NHj9SxcEoEr4eHs=
Received: from [100.70.221.233] (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgDXVwiXKz1qtchAAA--.42358S2;
	Thu, 25 Jun 2026 21:22:33 +0800 (CST)
Message-ID: <585bc5ca-8348-49e6-bbce-acbf6b99d912@yeah.net>
Date: Thu, 25 Jun 2026 21:22:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] TCP connection deadlock under simultaneous bidirectional
 ICSK_ACK_NOMEM (OOM)
To: Menglong Dong <menglong.dong@linux.dev>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, jmaloy@redhat.com, menglong8.dong@gmail.com,
 kuniyu@google.com, horms@kernel.org, willemb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stable@vger.kernel.org
References: <b8a3b4eb-b75d-4cbd-ac1c-9b0a606a932a@yeah.net>
 <g7DvITFWSiW9AoI49uyghw@linux.dev>
From: xietangxin <xietangxin@yeah.net>
In-Reply-To: <g7DvITFWSiW9AoI49uyghw@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Ms8vCgDXVwiXKz1qtchAAA--.42358S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr17Xr13ArW7AF15tryrZwb_yoWrGw1Dp3
	s3JFyxKr4ktryvkr4Iyr17GF1UJw1rAF45Jr18Wr1xAw1Yvrn2qr17tr40kr9rGrW8A347
	CrykXFyDtr4kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUUUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiIBnaD2o9K5lHWgAA3U
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:menglong.dong@linux.dev,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:jmaloy@redhat.com,m:menglong8.dong@gmail.com,m:kuniyu@google.com,m:horms@kernel.org,m:willemb@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stable@vger.kernel.org,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yeah.net];
	TAGGED_FROM(0.00)[bounces-301959-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yeah.net:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE5FC6C61BC



On 6/8/2026 7:55 PM, Menglong Dong wrote:
> On 2026/6/4 16:22 xietangxin <xietangxin@yeah.net> write:
>> Hi all,
>>
>> We have observed a TCP connection deadlock on stable 6.6 under heavy stress testing.
>>
>> 1.Both Peer A and Peer B enter the ICSK_ACK_NOMEM branch in tcp_select_window().
>> After commit 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze"),
>> Both peers freeze their rcv_nxt and set rcv_wnd = 0.
>>
>> 2.Prior to freezing, both sides had already sent out flight data.
>> Since both sides are dropping incoming data packets due to OOM, rcv_nxt stops advancing,
>> but the peer's seq of subsequent packets continues to grow.
>>
>> 3.When Peer A receives Peer B's Zero Window ACK,
>> the packet's seq is far ahead of Peer A's frozen rcv_nxt.
>> Both peers drop each other's packet, also no Zero Window Probes are triggered
>> because snd_wnd is never updated to 0.
>>
> 
> Hi,
> 
> The problem you addressed is already fixed in this commit:
> 0e24d17bd966 ("tcp: implement RFC 7323 window retraction receiver requirements"),
> which hasn't been picked to the 6.6 branch.
> 
> That patch doesn't have the Fix tag, so I'm not sure if it will be picked
> to the 6.6 branch. Just CC the linux-stable :)
> 
> Thanks!
> Menglong Dong
> 
>>
>> Simplified Packet Trace:
>>
>> Assume Peer A's rcv_nxt = 1000, and Peer B's rcv_nxt = 5000 initially.
>>
>> Time  Dir      Type        Seq   Ack   Win  Len  Status
>> ------------------------------------------------------------------------
>> T1:   B -> A   [PSH, ACK]  1000  5000  3000 100  (A hits OOM, rcv_nxt=1000)
>> T2:   B -> A   [ACK]       1100  5000  3000 200  (Dropped due to A's OOM)
>> T3:   B -> A   [PSH, ACK]  1300  5000  3000 200  (Dropped due to A's OOM)
>>
>> T4:   A -> B   [PSH, ACK]  5000  1000  3000 100  (B hits OOM, rcv_nxt=5000)
>> T5:   A -> B   [ACK]       5100  1000  3000 200  (Dropped due to B's OOM)
>> T6:   A -> B   [PSH, ACK]  5300  1000  3000 200  (Dropped due to B's OOM)
>>
>> -- Both sides are now in OOM. B's Seq is 1500; A's Seq is 5500 --
>>
>> T7:   B -> A   [ZeroWin]   1500  5000  0    0    (Dropped: Seq 1500 != 1000)
>> T8:   A -> B   [ZeroWin]   5500  1000  0    0    (Dropped: Seq 5500 != 5000)
>> T9:   A -> B   [WinUpdate] 5500  1000  20   0    (Dropped: Seq 5500 != 5000)
>>
>> Should we relax the sequence check in tcp_sequence() for zero window ACK?
>>
>> Any feedback or guidance would be greatly appreciated.
>>
>> -- 
>> Best regards,
>> Tangxin Xie
>>
>>
>>
> 
> 
> 

Hi,

We observed a throughput regression (dropping from ~1GB/s to 100MB/s)
in our test environment after commit 0e24d17bd966
("tcp: implement RFC 7323 window retraction receiver requirements").

When the rcv_buf reaches the pressure triggers tcp_clamp_window().
then rcv_ssthresh is strictly capped to 2 * advmss.
Subsequently, even after the user completely consumes the data and releases
a massive amount of free_space, tcp_select_window() is still heavily
suppressed by the clamped rcv_ssthresh. As a result, the receiver advertises
an extremely small window (Win=23) to the peer.

The sender cannot transmit any new data segments, until the sender's RTO timer
expires and triggers a slow-start recovery. This 200ms silence window slashes
our bandwidth by 90%.


No.   Time           Source       Destination  Info
-----------------------------------------------------------------------------------------------
1045  08:16:06.8005  192.168.1.9  192.168.1.10  [TCP ZeroWindow] 57334 -> 6666 [PSH, ACK] Win=0
1052  08:16:06.8013  192.168.1.9  192.168.1.10  [TCP Window Update] 57334 -> 6666 [ACK] Win=23
1055  08:16:06.8036  192.168.1.10  192.168.1.9  6666 -> 57334 [ACK] Seq=2999704568 Ack=2416286095
=========================== 200ms  SILENCE (RTO WAITING) ===================================
1088  08:16:07.0056  192.168.1.10  192.168.1.9  [TCP Retransmission] 6666 -> 57334 Len=1448
1090  08:16:07.0060  192.168.1.10  192.168.1.9  [TCP Retransmission] Len=2896

-- 
Best regards,
Tangxin Xie


