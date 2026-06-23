Return-Path: <netdev+bounces-301325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZfO/AGJcOmpV7AcAu9opvQ
	(envelope-from <netdev+bounces-301325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:13:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F516B6250
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:13:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=r91+eaR0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301325-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301325-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A69D8300A748
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF3736E489;
	Tue, 23 Jun 2026 10:08:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD5236BCDA
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:08:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209318; cv=none; b=DSY2pi9e9r6Uz9PwrZ9XSPD9ERlSz1LmxAuD/6zoUcZk3ECz/qYbJQaxXqMMrsobsmVJaSNxBk5J8JKMpDIrKUh8DQ7WdIXteBxrkZ+VD3TpXWBQyzI4eGcK5RiQBjaLjKIiMwy6Z5GV4gsk2ubUpI59XBy2JSkrJWGx/ZwJhuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209318; c=relaxed/simple;
	bh=pZkGyJopL74VE7VjsYav1R6gjjaDsoahje4YVAHTnSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZeIgOgOzisFoRFf1qdZH2Kb4TZUSNADzszIdv/+xm1z0n2RenJZVh+ARRSLXo52qfvaqyDARmQI3/HEPPh1/t580V98SDpbD3mB1GNmuwSqDaZ3tkSTPNvCsraa+Ue0ARPWZM3GaEh7Qd5jqsnXzYFzBKs3oE3lkzHpDaPY5bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r91+eaR0; arc=none smtp.client-ip=91.218.175.186
Message-ID: <3953e554-9bc4-419e-ac9f-aea3b9fd7b80@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782209313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFD9Jph6crM5nRNftF28H4XfKyHcXZ2YzNtJaYuppo4=;
	b=r91+eaR0Nr0qBjKAaIQNfjey8g1pvhMtE6060+u+/4sxIjmf49565VJ6VfPj5dZttupYHV
	zM/D7QCVFqHmq5f8eB7nx1yxlVJkJ0tTpdeMbsvP18UebzM5PUE2LIGyk6uMLXgmqXAH2w
	Dd2HaygB9kXSGGrslxF8VMxUS+tbKDM=
Date: Tue, 23 Jun 2026 18:08:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net, bpf: check master for NULL in
 xdp_master_redirect()
To: Ido Schimmel <idosch@nvidia.com>, Xiang Mei <xmei5@asu.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Jussi Maki <joamaki@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Weiming Shi <bestswngs@gmail.com>, Ido Schimmel <idosch@idosch.org>,
 David Ahern <dsahern@gmail.com>
References: <20260620201531.180123-1-xmei5@asu.edu>
 <7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
 <CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com>
 <20260622155854.75977aac@kernel.org>
 <CAPpSM+Q4O704OaUAXqKpL6ffvudTfqzzLzLExziUExgvxQWmxw@mail.gmail.com>
 <20260623065218.GA378121@shredder>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260623065218.GA378121@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301325-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:xmei5@asu.edu,m:kuba@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:hawk@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:joamaki@gmail.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,m:idosch@idosch.org,m:dsahern@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,vger.kernel.org,gmail.com,fomichev.me,redhat.com,idosch.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42F516B6250


On 6/23/26 2:52 PM, Ido Schimmel wrote:
> On Mon, Jun 22, 2026 at 04:34:06PM -0700, Xiang Mei wrote:
>> On Mon, Jun 22, 2026 at 3:58 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>> Can you double-confirm that this triggers on current HEAD
>>> of linux/master ? I thought commit 2674d603a9e6 ("vrf: Fix a potential
>>> NPD when removing a port from a VRF") was supposed to prevent all the
>>> torn master fetches. Adding VRF folks to CC.
>> Yes.
>>
>> We have triggered the crash on 56abdaebbf0da304b860bed1f2b5a85f5a6a16a0,
>> which is the latest for net.git, and 2674d603a9e6 was applied. We can
>> still trigger the crash:
> 2674d603a9e6 was only for VRF ports, so it doesn't help with this case
> (bond port). Also, the problem that 2674d603a9e6 fixed is a bit
> different. We had a NULL check after netdev_master_upper_dev_get_rcu(),
> but the issue was that this master device was not necessarily a VRF
> master.
Agree, it seems that 2674d603a9e6 only focus on VRF side.

>
> Looking at __bond_release_one(), assuming that
> netdev_master_upper_dev_get_rcu() returned a master device, I believe it
> must be a bond because you have a synchronize_rcu() after
> bond_upper_dev_unlink().
Right, synchronize_rcu() only guarantees that the master device is not freed
while our RCU reader is operating on it, but it does not guarantee that
we can successfully acquire the master device. We still need NULL check 
here.

