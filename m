Return-Path: <netdev+bounces-270186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBG6Mo5evmnxNgMAu9opvQ
	(envelope-from <netdev+bounces-270186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:02:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD32E44E5
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22A68301CC68
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 09:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A63176E0;
	Sat, 21 Mar 2026 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RDigaEKD"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C12DC32A
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774083724; cv=none; b=RkEw0Tc2VTaRV3PoYicqpp1GNebcSStO5VuwUqsMmwVvB8jZTsxig41VQoU6swTzWnBi0Ba/QFiq3D2+dqPvi5uYsaElgDzpDvi02cW+7Ph4jgmerm2mUZxuy11kdaFQBVz8kKx5C9p5a2yUN/mWXY6InZ/UOv6nJoZHOFK3XlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774083724; c=relaxed/simple;
	bh=TuiqVMoOCtdMNv0Um84DH+AlpKkmPZWmjkeCcttZuok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwetohUPMD9omFhPjCN+tzeiD6GVr9gREClWtC10Jxrhb6hkH/e7fEL69kjV6TLkOreVwA2GIj28ztnRrmm+ORM/T2jaK95/fZPt09rFfi6hvNKKy/Gx8GKpW/CjznUsXVD70l95kL1o+Z7IFO8jIiUk5JaNK1QM0i3rZBEbCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RDigaEKD; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=kV/JHbBAupFbHUTa8gIBV5gRynjWD9ko+gM17FAzHU4=;
	b=RDigaEKD+8mG8f0JWaSjaT9SawJbqk9KsDj5FiTfgo5Vkyaib5/naGVz/dOkm2
	Rii78pfnWA5ctEWlWw8BK8+7HpW7zS8Iha2TfyyH4lxmUTlIa5xeYhzUrNuz8Opn
	V+CuvVTrkvRnbocM4wXTv7WkNfk6Kj2xf/pN/iFLpl71c=
Received: from [10.54.29.171] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHLaRXXr5pFpoyAg--.2365S2;
	Sat, 21 Mar 2026 17:01:12 +0800 (CST)
Message-ID: <8509360a-21b8-4d28-8999-67a82796b8b6@163.com>
Date: Sat, 21 Mar 2026 17:01:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tls: reject attaching TLS to sockets already in sockmap
To: Xingwang Xiang <v3rdant.xiang@gmail.com>
Cc: kuba@kernel.org, jakub@cloudflare.com, sd@queasysnail.net,
 davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
References: <20260321033027.4044119-1-v3rdant.xiang@gmail.com>
From: Jiayuan Chen <mrpre@163.com>
In-Reply-To: <20260321033027.4044119-1-v3rdant.xiang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHLaRXXr5pFpoyAg--.2365S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArW5Ar17JF48ZFW3Kr17KFg_yoW8trWfpF
	Z5Aa1F9F4kGFW0v3Z5AayIqr4xurs5AF4UGFyrX345Zw15urySyFyftayj9F48KrWrAryY
	vr90gr48Z3Z8Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9qXLUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbC7Bi3X2m+XlhoNwAA3S
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270186-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrpre@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44DD32E44E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/21/26 11:30 AM, Xingwang Xiang wrote:
> When a socket is first inserted into a sockmap with a verdict program,
> then TLS is enabled on that socket, the TLS strparser's saved_data_ready
> callback becomes sk_psock_verdict_data_ready(). This function calls
> tcp_read_skb() which drains ALL skbs from sk_receive_queue without
> updating tp->copied_seq when the BPF verdict is SK_PASS. This leaves
> tcp_inq() returning stale values, causing the TLS strparser to think
> data exists in the receive queue when it doesn't.
>
> The result is a WARN_ON_ONCE(!first) in tls_strp_load_anchor_with_queue()
> when tcp_recv_skb() returns NULL, and Use-After-Free when
> the strparser's frag_list points to skbs that have been unlinked and
> are now owned by the sockmap subsystem.
>
> While sk_psock_init() correctly checks inet_csk_has_ulp() to prevent
> inserting TLS sockets into sockmaps (blocking "forward order"), tls_init()
> does not check for an existing psock, allowing "reverse order" setup.
>
> Fix this by adding a check in tls_init() to reject sockets that already
> have a psock attached (i.e., are in a sockmap). This mirrors the


Hi Xingwang,

Thanks for the patch and the detailed analysis of the problem.

However, TLS is designed to work together with sockmap — the TLS 
send/receive paths
(tls_sw_sendmsg, tls_sw_recvmsg) extensively use sk_psock_get() to 
cooperate with
sockmap for verdict and redirection. Rejecting sockets that already have 
a psock
would break this intended usage.

Also, could you try running the sockmap_ktls selftest
(tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c) after applying 
your patch?

I believe it will fail, since that selftest specifically exercises TLS + 
sockmap
combined functionality.

That said, the bug you described is real and worth investigating. It 
would be very
helpful if you could add a reproducer for your scenario as a new test 
case in
sockmap_ktls.c. That would help us better understand the root cause and 
find a
proper fix that addresses the issue without breaking the TLS + sockmap
integration.

Also, pls use [PATCH net v?] or [PATCH bpf v?] (if you think it is 
related to bpf/sockmap).


Thanks,
Jiayuan



