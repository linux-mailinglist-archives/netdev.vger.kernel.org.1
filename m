Return-Path: <netdev+bounces-256194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBnrMai1gWkrJAMAu9opvQ
	(envelope-from <netdev+bounces-256194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:45:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B210D658F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BFA430241B7
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32222395DBE;
	Tue,  3 Feb 2026 08:45:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from b2412.mx.srv.dfn.de (b2412.mx.srv.dfn.de [194.95.235.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E88395DA6
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.235.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108310; cv=none; b=CrwqWq83kARMtWaNC01Is6FLQHyFkYasmpYu77/n5zgjm9TFNECHB7G3dTHcbLE+b0bJpC4FLIJjlWiKyMo18o+s6o/R7LpUHB7U7/a8RqgTenv2i5U26bhULnEhFxA24Jk6yJmPy5SfJKgCRj4tmNkgFrDwkNJvcXsSHz47ZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108310; c=relaxed/simple;
	bh=cJpqgIenyiyOxPSekoOEzAxk2xItdzdV/2wEW2fiyxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGeiOknceoLBlYVd2iz23RLDtFRD8NRRjuSaFSqEs5Aj4yJ07XrgZ3BYZGAkQksbKPQ2G3XSqZ7k/wzwhVk+kK6nTG+O4Q+AsTFiy7beJMzhZmlN0pCbc/NixIZQrWFbbs70fYEiML+o8S0U1oFYIjrL84TxxTS6hmIZMqSBClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-osnabrueck.de; spf=pass smtp.mailfrom=uni-osnabrueck.de; arc=none smtp.client-ip=194.95.235.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-osnabrueck.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uni-osnabrueck.de
Received: from vm411.rz.uni-osnabrueck.de (smtp-auth-1.serv.uni-osnabrueck.de [131.173.16.143])
	by b2412.mx.srv.dfn.de (Postfix) with ESMTPS id 5EBF71C018F;
	Tue,  3 Feb 2026 09:36:25 +0100 (CET)
Received: from [IPV6:2001:638:508:fe02::35] (unknown [IPv6:2001:638:508:fe02::35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: kelmenhorst)
	by vm411.rz.uni-osnabrueck.de (Postfix) with ESMTPSA id 1CA8D30056C3;
	Tue,  3 Feb 2026 09:36:25 +0100 (CET)
Message-ID: <f1137fcf-1778-4811-9211-4beb95db3a32@uni-osnabrueck.de>
Date: Tue, 3 Feb 2026 09:36:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: tcp_bbr: use high pacing gain when the
 sender fails to put enough data inflight
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org
References: <20260202101454.89445-1-kelmenhorst@uni-osnabrueck.de>
 <CADVnQykLpW+GV6sSG5py1J+WTZFM-=JObhYS7Pwd=9ut1GY1BQ@mail.gmail.com>
Content-Language: en-US
From: Kathrin Elmenhorst <kelmenhorst@uni-osnabrueck.de>
In-Reply-To: <CADVnQykLpW+GV6sSG5py1J+WTZFM-=JObhYS7Pwd=9ut1GY1BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[uni-osnabrueck.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256194-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kelmenhorst@uni-osnabrueck.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uni-osnabrueck.de:mid,uni-osnabrueck.de:email]
X-Rspamd-Queue-Id: 3B210D658F
X-Rspamd-Action: no action

> AFAICT this patch does not look like a safe solution, because there
> are many reasons that the actual number of bytes in flight can be less
> than the target inflight. Notably, it is very common for applications
> to be application-limited, i.e., they don't have enough data to send
> to fully utilize the BDP of the network path. This is very common for
> the most common kinds of TCP workloads: web, streaming video, RPC,
> SSH, etc. It does not seem safe to increase the pacing gain to
> bbr_high_gain in these common application-limited scenarios, because
> this can cause bursts of data to arrive at the bottleneck link at more
> than twice the available bandwidth, which can cause very high queuing
> and packet loss.

Absolutely, app-limited and contention-limited sockets exhibit similar
characteristics in terms of inflight bytes. My understanding was that
BBR uses high pacing gain when the socket is app-limited anyways, is
that not correct?
For example, bbr_check_full_bw_reached returns early if the socket is
app-limited, so that BBR stays in (or is reset to) STARTUP mode with
high pacing gain. This behavior actually gave me the idea to fix the
contention-limited socket in a similar way. But maybe I am missing
other cases where BBR reacts differently to app-limitation.

> But if you have further results that you can share, I'd appreciate it.

I separately sent you the arXiv link to our paper. Due to a conference
submission policy, we are not allowed to advertise it on a public
mailing list yet.


Thanks,
Kathrin




On 2/2/26 17:22, Neal Cardwell wrote:

> On Mon, Feb 2, 2026 at 5:15 AM kelmenhorst
> <kelmenhorst@uni-osnabrueck.de> wrote:
>> This patch addresses a robustness issue of TCP BBR when run in Virtual Machines
>> - a common use case considering modern web hosting.
>> Prior experiments in AWS VMs (https://ieeexplore.ieee.org/abstract/document/9546441),
>> and our recent measurements in a controlled setup show that VM-based BBR senders
>> heavily underestimate the available bandwidth during periods of CPU contention.
>> In our configuration with 10ms periodic timeslices, BBR already degrades in VMs
>> with less than 70% CPU time share, and the throughput continuously drops with
>> decreasing CPU shares until it is bandwidth-independently capped at 10 Mbps for
>> CPU time shares at 35% and lower.
>> Considering the common use case of BBR in (resource-limited) Linux VMs, this
>> issue could potentially compromise the robustness of the Internet's transport
>> layer.
>>
>> In contrast to Cubic, BBR is very sensitive to off-CPU times. This is because
>> pacing evenly spreads the target inflight over the RTT, essentially assuming
>> that the CPU is available during the whole RTT. If this assumption is not met,
>> the BBR sender cannot achieve the target pacing rate and concludes that the full
>> bandwidth has been reached, even though the throughput is far below the actual
>> bandwidth limit.
> Thanks, I agree this is an issue worth working on. And I appreciate
> your contributions in this area, as well as the work of others who
> have worked on the challenges of BBR throughput in VM guests.
>
>> This commit detects the problematic condition in bbr_update_gains() by
>> comparing BBR's current target inflight (bbr_inflight() * tp->mss_cache) with
>> the actual number of bytes inflight (tp->bytes_sent - tp->bytes_acked), and
>> applies high pacing gain (bbr_high_gain), until the inflight deficit recovers.
>> With a higher pacing gain, BBR can send faster when the VM does have the CPU,
>> so that the target inflight volume can be achieved despite off-CPU times.
>> Re-using the constant STARTUP gain can only solve the issue up to a certain
>> point, but avoids complex algorithm changes.
>> Effectively, the patch solves the degradation problem for most critical cases:
>> with 10ms periodic timeslices, BBRv1 is robust for CPU time shares of 35% and
>> higher -  instead of 70% and higher when using the original code.
> AFAICT this patch does not look like a safe solution, because there
> are many reasons that the actual number of bytes in flight can be less
> than the target inflight. Notably, it is very common for applications
> to be application-limited, i.e., they don't have enough data to send
> to fully utilize the BDP of the network path. This is very common for
> the most common kinds of TCP workloads: web, streaming video, RPC,
> SSH, etc. It does not seem safe to increase the pacing gain to
> bbr_high_gain in these common application-limited scenarios, because
> this can cause bursts of data to arrive at the bottleneck link at more
> than twice the available bandwidth, which can cause very high queuing
> and packet loss.
>
> On a broader note, before making such a significant change to a CC
> algorithm, we would need to see a broad array of test results showing
> that the change is safe and performant in a representative set of
> scenarios: multiple BBR flows, shallow buffers, deep buffers,
> policers, application-limited traffic, BBR coexistence with CUBIC,
> performance on wifi paths, etc.
>
>> We can share further results of our measurement study upon individual request.
> Yes, if you could please share further results, I would appreciate it.
> I'm aware of your work here:
>
>    POSTER: Clouded Comparisons - On the Impact of VirtualMachines on
> TCP-BBR Performance
>    https://dl.acm.org/doi/epdf/10.1145/3744969.3748455
>
> But if you have further results that you can share, I'd appreciate it.
>
>> Signed-off-by: Kathrin Elmenhorst <kelmenhorst@uni-osnabrueck.de>
>> ---
>>   net/ipv4/tcp_bbr.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
>> index 760941e55153..ca6361931491 100644
>> --- a/net/ipv4/tcp_bbr.c
>> +++ b/net/ipv4/tcp_bbr.c
>> @@ -1011,6 +1011,13 @@ static void bbr_update_gains(struct sock *sk)
>>                  WARN_ONCE(1, "BBR bad mode: %u\n", bbr->mode);
>>                  break;
>>          }
>> +        // overwrite pacing gain in case the sender fails to put enough data inflight
>> +        struct tcp_sock *tp = tcp_sk(sk);
>> +        u64 real_inflight = tp->bytes_sent - tp->bytes_acked;
>> +        u32 target_inflight = bbr_inflight(sk, bbr_bw(sk), BBR_UNIT) * tp->mss_cache;
>> +        if (real_inflight < target_inflight) {
>> +                bbr->pacing_gain = bbr_high_gain;
>> +        }
>>   }
> Just a note on style: before your next patch submission to the Linux
> netdev mailing list:
>
> (1) please read the netdev FAQ at:
>    https://www.kernel.org/doc/html/v6.18/process/maintainer-netdev.html#netdev-faq
>
> (2) please run ./scripts/checkpatch.pl on the patch to catch and fix
> style issues (./scripts/checkpatch.pl shows: "total: 7 errors, 10
> warnings, 0 checks, 13 lines checked")
>
> Thanks!
>
> best regards,
> neal

