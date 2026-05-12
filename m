Return-Path: <netdev+bounces-286935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIKEG4KYAmoauwEAu9opvQ
	(envelope-from <netdev+bounces-286935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 05:03:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14EF51921C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 05:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E5003052B56
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6354378830;
	Tue, 12 May 2026 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qn48XRVi"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5134F383325
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554800; cv=none; b=SeIAx61GEeLx6xyv73PnFmvNOU7bhgrfp3PoHB3pUIa+zxsCWTxG/AfvDDKVVrHC5UeKuSU5wqn5eWn/TrTp40Gm+CbrqE6qw5Jpp64XiBaWt58w89zuAHATp2/qYCZe7ISPXOhEr0MX4Gf7vXQjIKZ8VVuAgiWYDEPsIy5z3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554800; c=relaxed/simple;
	bh=JhpW2oLnsp+cHZSVAOb2zeeYn5TQyM7DdQhGOiyM1po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFx1iGY2iKBREstbXCiZxuOKdRp0GOD0KuRONHdnteoZvqYr9/ymdnGaTCK1+SHxop4+Iw7qOtCsStNLAbqOhPqe+IHAmqd4CwjMMjY0BzpiB/tZHqhFuiEh6zQ9Pvy7doyADzroZXGQuUj1mLIF64RZXyfpzbJqXaNF1eAH/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qn48XRVi; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <47b7dc3c-7092-49fe-b849-6847b73df86d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778554787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGNV/YJpEn+sge8vj57aYddAEttZNzqCrydxjg3s/MA=;
	b=Qn48XRViZV3QR/2bV55pzmxbfYlU4fpwsUevkFv0aG/p1C4tc0ZbOMPUgvwLxI5Q/kbFBE
	/cOK2D4Op6Iid4DewpSVIW/kNzjJ0o+ShH7U4Yum+fMdZJgsEeErHGWU3uQ4i6TnTXzWLo
	ZeENjlI4qWB/lO1k/6dr2C7vLorlkGA=
Date: Tue, 12 May 2026 10:59:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 0/2] net/tls: fix UAF when TLS_RX is set on sockmap
 socket
To: Jakub Kicinski <kuba@kernel.org>, xw x <v3rdant.xiang@gmail.com>
Cc: jakub@cloudflare.com, sd@queasysnail.net, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 Jiayuan Chen <mrpre@163.com>, Daniel Borkmann <daniel@iogearbox.net>,
 john.fastabend@gmail.com, bpf@vger.kernel.org
References: <20260511155210.32926-1-v3rdant.xiang@gmail.com>
 <20260511161320.358cfaad@kernel.org>
 <CAFFJMPzw8pcwX9g7iv3F=FpHQyovUgZZ28P7XfH3gmiay-JfpA@mail.gmail.com>
 <CAFFJMPwtWZDrD0=hANXk2cdZGt2ArQEWROGRswKPyiZ+FrG1XQ@mail.gmail.com>
 <20260511190644.23334e6d@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260511190644.23334e6d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C14EF51921C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286935-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cloudflare.com,queasysnail.net,davemloft.net,redhat.com,kernel.org,vger.kernel.org,163.com,iogearbox.net,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lpc.events:url]
X-Rspamd-Action: no action


On 5/12/26 10:06 AM, Jakub Kicinski wrote:
> On Tue, 12 May 2026 08:10:03 +0800 xw x wrote:
>> On Tue, May 12, 2026 at 7:13 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>> Just to check - how much of this code or the patch do you understand?
>> I think I understand the root cause. Based on Jiayuan Chen’s
>> feedback—that we should deny TLS_RX attachments for sockets already in
>> a sockmap—I've prepared my patch to do exactly that. Do you see any
>> issues with this approach?
> I mean.. I have no proof that real users of the TLS + sockmap exist
> but I thought that they did.


Sorry, my earlier advice was wrong on this point. TLS_RX + sockmap is
intentional.

And there are public discussions about combination of KTLS with SOCKMAP, 
e.g.
https://lpc.events/event/2/contributions/105/attachments/103/126/ktls_bpf.pdf


>> On Mon, May 11, 2026 at 10:13 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>> I think sockmap + TLS_RX has no useful semantics(fix me if i'm wrong).
>>> sk_skb sees ciphertext and the TLS keys are pinned to this socket, so
>>> redirect is meaningless. And both sides racing on sk_receive_queue is
>>> what produces the UAF.
>>>
>>> The fix should be to reject TLS_RX when the socket is already in a sockmap.
>>>
>>> Note TLS_TX + sockmap remains useful and unaffected.
>> Additionally, my changes seem to trigger a failure in the
>> test_sockmap_ktls_tx_no_buf test. Specifically, it attempts to set
>> TLS_RX on a socket that is already in a sockmap within
>> init_ktls_pairs. Since I didn't author this test, I’m not sure if the
>> TLS_RX requirement there is essential for what’s being tested. I could
>> use some guidance on whether the test should be updated or if my
>> approach needs adjustment.
> Your report is narrowly for the verdict-only case in sockmap.
> But you're banning all TLS + sockmap.
>
> I think we need a similar workaround in sk_psock_verdict_data_ready()
> as what e91de6afa81c ("bpf: Fix running sk_skb program types with ktls")
> added for the full sockmap path. Or selectively ban the verdict only


Agreed, sk_psock_verdict_data_ready should process tls like sk_psock_strp_data_ready.

> format. But that feels a little less clean. Dunno.
>
> Please, do not repost this until 24h have passed. Maybe Jiayuan Chen
> or sockmap folks (who you apparently didn't CC?) have some comments.

