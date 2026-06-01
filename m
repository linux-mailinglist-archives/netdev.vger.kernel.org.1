Return-Path: <netdev+bounces-293725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNXxGHN0HWp8bAkAu9opvQ
	(envelope-from <netdev+bounces-293725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:00:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F1561EBC8
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F5C13009098
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE35368D6B;
	Mon,  1 Jun 2026 12:00:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A736348C66;
	Mon,  1 Jun 2026 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315249; cv=none; b=DdPKamJF6OT6/Zf88mvqxGjCZwWCZxa8v2kxHBQbFtVTa6zV6TDV8UDbK05HVgxgnLHkb7Z4vJPwDQZC24X1huD7yInQFMMa/+biuehNPLqCe4VJ8q8RfpYTKAn+YWrZAuaLFGUa0nu6ueu5nRokPhlfYSLqLnzXCW1xE4JbkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315249; c=relaxed/simple;
	bh=s//3fKl0E7I5s8qjeLdZk2A8Doabxg/plPyKTj/66G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWDiSK+tkFfBmhVacwYWA9ewNJqfkbKxcpR6fS1HN2zUb6bKdw03J8g4WDTt8LC9irJNeKQegaky+1pMTMzlVbv5eS28zDNxOxIdQ7ibGMzBUc9Um5vGbnInAsEGHaiU5TVNnHUNqe5Ydpi31Gy40v30OHt/ipQOOP1dUxUoyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [129.217.186.245] ([129.217.186.245])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 651C0IPl003115
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 1 Jun 2026 14:00:18 +0200 (CEST)
Message-ID: <db5b7f7e-135c-40f0-a740-057bc6623e6c@tu-dortmund.de>
Date: Mon, 1 Jun 2026 14:00:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        hawk@kernel.org, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
 <2affe9f4-56a7-4482-931f-9d98cfdf09fd@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <2affe9f4-56a7-4482-931f-9d98cfdf09fd@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[tu-dortmund.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293725-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 01F1561EBC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 09:46, Jonas Köppeler wrote:
> On 5/27/26 3:54 PM, hawk@kernel.org wrote:
>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>
>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>> excessive NAPI scheduling overhead and qdisc requeues.
>>
>> Accumulate BQL completions and flush them when a configurable time
>> threshold is exceeded, letting DQL discover a limit that bounds actual
>> queuing delay to the configured interval. Coalescing state persists
>> across NAPI polls in struct veth_rq so completions can accumulate
>> beyond a single budget=64 cycle.
>>
>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>> completion.
>>
>>    ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>    ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>
>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> 
> Tested-by: Jonas Köppeler<j.koeppeler@tu-berlin.de>
> 

Thanks for your testing!

However, I have issues reproducing.
I run bare metal (without virtme) with v6 + your pktgen patch
and I am on the branch pktgen-and-benchmark, commit
"results: add veth-bql measurements":

1. ping fails with 100% packet loss ~20% of the times with --pktgen.
   When this happens the avg ping of this run is mistakenly set
   to 0.0 ms, which distorts the results.
   I fixed it locally by rerunning when this happens.

2. pktgen runs with > 3 Mpps even with --nrules 10000, see log below.
   I see that this is because of qdisc drops.
   I also tried pfifo and sfq but with the same result.
   I spent quite some time on it but I do not know a fix.

Do you have an idea?
Thanks!


The raw log:

sudo ./veth_bql_test.sh --pktgen --duration 2 --qdisc fq_codel --no-bpftrace --tx-usecs 100 --nrules 10000
INFO: Setting up veth pair with GRO                                                                                                             
INFO: Threaded NAPI enabled       
INFO: Installing qdisc: fq_codel  
INFO: Loaded 10000 iptables rules in consumer NS
INFO: kernel: 7.1.0-rc4-patched-20260307+
INFO: BQL sysfs found: /sys/class/net/veth_bql0/queues/tx-0/byte_queue_limits
INFO: ethtool tx-usecs set to 100 on veth_bql1 (rx side)   
INFO: Starting ping to 10.99.0.2 (5/s) to measure latency under load
INFO: Starting pktgen queue_xmit on veth_bql0 (threads=1 pkt_size=64)
  [5s] BQL inflight=1 limit=17 watchdog=0
  [5s] qdisc fq_codel pkts=27417 drops=6591520 requeues=14115 backlog=0 qlen=0 overlimits=0
  [5s] softnet: processed=27960 time_squeeze=0 multi-CPU(6): cpu0(+5) cpu1(+121) cpu2(+33) cpu3(+116) cpu4(+27641) cpu5(+44)
INFO: Ping loss: 0% packet loss
INFO: Ping summary: rtt min/avg/max/mdev = 0.127/1.818/2.703/0.761 ms
INFO: pktgen results (thread 0):
Params: count 0  min_pkt_size: 64  max_pkt_size: 64
     frags: 0  delay: 0  clone_skb: 0  ifname: veth_bql0@0
     flows: 0 flowlen: 0
     queue_map_min: 0  queue_map_max: 0
     dst_min: 10.99.0.2  dst_max: 
     src_min:   src_max: 
     src_mac: 0e:aa:4e:05:95:89 dst_mac: c2:e5:a3:4c:2a:7f
     udp_src_min: 9  udp_src_max: 9  udp_dst_min: 9999  udp_dst_max: 9999
     src_mac_count: 0  dst_mac_count: 0
     xmit_mode: xmit_queue
     Flags: NO_TIMESTAMP  QUEUE_MAP_CPU  SHARED  
Current:
     pkts-sofar: 6516031  errors: 102854
     started: 12246566004us  stopped: 12248535234us idle: 0us
     seq_num: 6516032  cur_dst_mac_offset: 0  cur_src_mac_offset: 0
     cur_saddr: 10.99.0.1  cur_daddr: 10.99.0.2
     cur_udp_dst: 9999  cur_udp_src: 9
     cur_queue_map: 0
     flows: 0
Result: OK: 1969229(c1969229+d0) usec, 6516031 (64byte,0frags)
  3308924pps 1694Mb/sec (1694169088bps) errors: 102854
TEST: veth_bql                                                      [ OK ]
INFO: Results: /home/simon/repos/veth-backpressure-performance-testing/results/selftests/2026-06-01T13-24-51


