Return-Path: <netdev+bounces-275505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID0gDs4X02nieAcAu9opvQ
	(envelope-from <netdev+bounces-275505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 04:17:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D653A11E9
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 04:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 025A630075E2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 02:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA31231832;
	Mon,  6 Apr 2026 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjpcCLf5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCE816DEB1
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775441865; cv=none; b=gzMhT2Y2l9yMGMEP5hred+kdMBT/2vHcO2P4pNp1asdhrBVLd4r1WSUQLXBUGRcv+H1CEFsPYPFBA7Smo+B6kNcwnmJVAEPYH2Z8+BgJyQHBwPG/Uiw+0HhUlVATN3ol/30OO3JRulZbsrAcFSghm1bvAVwLCbgu9x5XPDlmj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775441865; c=relaxed/simple;
	bh=iCB6IL77/Q/NTqAH02gKN3gak597hAOB08vjLYzyg9g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WcrGgYRHU6INMqRNiCK+sLpoPoZUY+v6gDpDwYyj53JYydhbgomGiqETuZybfHiZqprV17tQoRK+J6qWn0aFa+iXa7DTlMK+k63mCAxJFkIIB0S0VKoNa5EvStJvF4smyPXlAzpaS1Bn7278JKUwIY1BxrRaev7lJfuRBCtKVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjpcCLf5; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649278a69c5so2391287d50.3
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 19:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775441863; x=1776046663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EioxQ3NC1zrSrJKRc0dY7WjMA5THNc63GtRU8/xWe2I=;
        b=LjpcCLf5bBEmW2C2hr37dkYQMvYJjYsRiWds4bG+tu1r5VdVXrNXA/WMUbRug9Z2uw
         xAt59XdOTfJTFPLxPHcDO4aoJSEjrqiDl7txzzZZwrqGgSTHZBI/Eq5tg558uL/rVcOx
         48+qPaxPa6WgCP/f0hNHj2x7wD5yA9Xlz9T67hGI9C78G/1h6oLKk0F6Ys3EhMb3w4Ca
         i9aoiDauYdZM0RECaZLKdhj/xPV4Gn6NezQJ+i9gU7JP9Xf+Rl3xxto2PJ+DP9JMfZbj
         Z6n8PXCecjMwbyy/mOu8hprTMoAV305T+pqzFMUu8pqHvGqGnTLRUjkIjYucuZYfsXNG
         2mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775441863; x=1776046663;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EioxQ3NC1zrSrJKRc0dY7WjMA5THNc63GtRU8/xWe2I=;
        b=Onh79JPNbHpsULW/s4m9YbcZM4aZiGeee0mORAFYFBwHfdZmmNZPPw+yEubva7t821
         o06NJRMZFWAdlNaKwTaYeGeGDd0AS7uY2c+7qfxUTjlZukyxIBQ/cFl+ElIv+sIpzAnB
         EQ9cXeSIAPc4aiOZJ1GYNKkKU3ijCbbNSrUeATF85w1aPx/jBNcVJIErQ8U0oizh9w9B
         idX7xrJn9jgeHB74At2jSHB0nXEmypIYdfVzWOLg1l+NreVSliaX5GMXX+Hkec3nEdAl
         MW9zoL8glQlw1IIFZzuSO+P7UkeSN16IGBx898/3/nCfM9YCEiIADOBuxZl4unHxcBVg
         kbSA==
X-Gm-Message-State: AOJu0Yw54fw4DYM4s9SvvbaTuRKFbaNFQ9oP8TkVOfrIb1Hx+1VVYDfo
	2BKNxHLKvL49cpqwlT2VOSn3hbRxDzbu4yicM+M7BgoeGANBY0gdDWJI
X-Gm-Gg: AeBDievN5lEnw/CyV9GgprhEl7n0MwHXrRcDTjAoehw8maQpms+i/OWZyl8j/5QzhKC
	LgxmK7RUwDE0Mx6HAL2xKVSYJkzv2o+eqxTVABlqCwxGp31FgZRzOEzu/LN5dR+oP7qXLcywpbt
	6Hf3cUS3fNWxMM6bZOwZmTKDOK37bEd4/T2hYqfYrMQClf2aflk2NkVkH376nwJw4QZ4ajfW4vU
	CpIhPRU4eYP8HJvNAhJBjhIcDx9mZqJQwM4vNUI/Yy4/0AQjkTixbM0OIcXZEDAZlCHk90rfg4Z
	J6Zfsy/8mHeOU7RRCk7NNTy6JMAQV5s5D+rgx/z8ODG8Q9Nqw/CCZPk2W/BcwRG5QuHZljEPl2o
	+QtaY624/jVIozGgV1d+N/WMbeNoJmYQpufL4czDjORKAxleEjdUpocrJqIJ5VM+NGvZU/ZbgYw
	9My+Vj1h3Rcc7Zv9BpJIMP4AcpjSOQ6CCwuZ1J5ihuK33qvsRstTNAAgNH8K99VVscOKKoPoHwl
	X9UMb67wB9RIfg=
X-Received: by 2002:a05:690c:64c2:b0:798:6c28:dd58 with SMTP id 00721157ae682-7a4d3ec620bmr115452897b3.24.1775441863150;
        Sun, 05 Apr 2026 19:17:43 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff26sm49118657b3.9.2026.04.05.19.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 19:17:42 -0700 (PDT)
Date: Sun, 05 Apr 2026 22:17:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 martin.lau@kernel.org
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <willemdebruijn.kernel.2053d6bde1d3d@gmail.com>
In-Reply-To: <20260404150452.83904-1-kerneljasonxing@gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 0/4] bpf-timestamp: convert to push-level
 granularity
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275505-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85D653A11E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> 1. Design of send-level granularity
> Originally, socket timestamping was designed to support tracing each
> sendmsg instead of per packet because application needs to issue
> multiple extra recvmsg() calls to get the skbs carrying the timestamp
> one by one if application chooses tag with different tags(SCHED/DRV/ACK).
> It's an obvious huge burden if the application expects to see a finer
> grained behavior.
> Another point I mentioned a bit in Netdev 0x19[1], supposing the amount of
> data that application tries to transfer at one time is split into 100
> smaller packets, recording the last skb's timestamps (SCHED/DRV/HARDWARE)
> is no longer meaningful because at the moment timestamping only records
> 1/100 packets. In this case, only the delta between when to send and when
> to ack matters.
> 
> 2. Known missing tag issues in TCP
> A critically important thing is that we can miss tagging the last packet
> in a few conditions as the patch 3/4 explains. That means we lose track
> of the send syscall. Digging into more into how tcp_sendmsg_locked works,
> I found it's not feasible to successfully identify the last skb before
> push functions get called. With that said, if we want to make the feature
> better to cover all of these cases, we inevitably needs to place
> tcp_bpf_tx_timestamp() function before each push function.
> 
> 3. Practice at Tencent
> In production, we have a version that applies the packet basis policy to
> do the exhaustive profiling of each flow for months in order to:
> 1) 100% make sure to capture the jitter event. No sampling.
> 2) observe the performance, find the bottleneck and improve it.
> We're still collecting data and investigating how it helps us in all the
> potential aspects before upstreaming. My personal perspective on this is
> to replace tcpdump eventually. It's worth mentioning tcpdump no longer
> satisfies our micro observation in modern data center.
> 
> 4. The tendency toward finer-grained observability
> As we're aware that there are already many various bpf scripts trying to
> implement the fine grained monitor of the packets, it's an unstoppable
> tendency for the future observability. We're faced with so many latency
> reports (like jitter, perf degradation) on a daily basis. Getting the
> root cause of each report is exactly what we pursue.
> After we know which request causes the problem, if it belongs to kernel,
> we will dig into the packet behavior with more useful information
> included. This is the process of tracing down the jitter problem.
> Likewise, in BPF timestamping that mitigates the impact of calling extra
> syscalls, breaking the coarse granularity into smaller ones is a first
> good way to go. It shouldn't be the burden like before especially it's
> independent of application.
> 
> 5. Details of the series
> Now it's time to convert BPF timestamping feature into push-level
> granularity by only recording the last skb in each push function, which
> is quite similar to how we previously treat each send syscall.
> Regarding each push function as a whole, we only care about
> the last skb from each push since the skb can be chunked into different
> smaller packets. BPF scripts like progs/net_timestamping.c has the
> ability to trace each tagged skb and calculate the latency:
> 1) delta between send and each tagged skb in tcp_sendmsg_locked()
> 2) delta between SCHED/DRV/ACK. Three timestamps are also correlated
>    with the sendmsg time.
> 
> In conclusion, push-level is more of a compromise approach which covers
> those corner cases and further enhances the capabilities (like a finer
> grained observation of jitter and performance issues).

# push-level design

It it significantly less intuitive than per-syscall, which is under
user control. Or even than per-packet. As a fix for missing timestamps
I understand these two extensions, even with the unintended side
effect of reporting many unnecessary extra skbs in the common case.
As a model to advocate for, less so.

Would it help if all skbs from the same sendmsg() can still be
identified as common from the same syscall? That allows the user
to discard all but the last one (if they wish)


# ABI changes

For SO_TIMESTAMPING we would not be able to make this change
unconditionally as the behavior change would break existing
application expectations.

That is why historically we have guarded new behabvior behind new
TS options flags.

The same may be true for BPF.


# SO_TIMESTAMPING and BPF timestamping differences

A related point is that this breaks the 1:1 relationship between
SO_TIMESTAMPING and BPF timestamping. As said before, I think that
is fine as BPF timestamping can be cheaper. But we should avoid the
two forking in incompatible ways. I suggest that BPF timestamping
becomes a superset of SO_TIMESTAMPING: it must have all features
of SO_TIMESTAMPING, and may offer more.


# Documentation and testing

Please also expand Documentation and include a test.



 
> [1]: Page 29 of the slides demonstrates the picture of skb-level granularity
> https://netdevconf.info/0x19/sessions/talk/the-future-of-so_timestamping.html
> 
> ---
> V2
> Link: https://lore.kernel.org/all/20260402085831.36983-1-kerneljasonxing@gmail.com/
> 1. only handle BPF timestamping feature to cover those issues (Eric, Willem)
> 2. keep timestamping functions inline in send process (Eric)
> 
> 
> Jason Xing (4):
>   tcp: separate BPF timestamping from tcp_tx_timestamp
>   tcp: advance the tsflags check to save cycles
>   bpf-timestamp: keep track of the skb when wait_for_space occurs
>   bpf-timestamp: complete tracing the skb from each push in sendmsg
> 
>  include/net/tcp.h | 20 ++++++++++++++++++++
>  net/ipv4/tcp.c    | 23 +++++++++++++----------
>  2 files changed, 33 insertions(+), 10 deletions(-)
> 
> -- 
> 2.41.3
> 



