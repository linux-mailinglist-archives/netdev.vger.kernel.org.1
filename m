Return-Path: <netdev+bounces-245343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9FCCCBC91
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9124302D2DF
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81F831B114;
	Thu, 18 Dec 2025 12:28:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4D4F881
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060939; cv=none; b=JGZEqYmBPLGpoB2R4L1m5wGcS6sgb5G96lGnCaHRpkzHqn1aA5FW8egMEYE8NIkFk1gJfaDZPsHocisZ7NfY/A5q0pYXlgn2kHvohbA6LwlD8dPOVTdO2b1+RQseK+gMRv4sDT62K+52mqUK6C2zlG9RSGceOx3bhrfY+FIGtEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060939; c=relaxed/simple;
	bh=+uaIBVRd4bL37XABDFQt7o35QRFd+YdqIkukVMHh454=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4KkfgZ06aEJaNyFAUSnD0BVy5woE9gBBreZfTEXzf1kT+SJphKinsbz4q++FY4YNqVManCNDllk0ipMYEd3YZViNDyF0sxR0HZu481B2tU0SmjmAVlm7faDKfsN8tLNY+K38/DuqRDzdgNZ0UGiP1DOODxZIGvhn2fKpgg8PMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E6B8848541;
	Thu, 18 Dec 2025 13:28:54 +0100 (CET)
Message-ID: <c1ae58f7-cf31-4fb6-ac92-8f7b61272226@proxmox.com>
Date: Thu, 18 Dec 2025 13:28:53 +0100
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
Content-Language: en-US, de-DE
From: Christian Ebner <c.ebner@proxmox.com>
In-Reply-To: <CANn89iL=MTgYygnFaCeaMpSzjooDgnzwUd_ueSnJFxasXwyMwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1766060922762

Hi Eric,

thank you for your reply!

On 12/18/25 11:10 AM, Eric Dumazet wrote:
> Can you give us (on receive side) : cat /proc/sys/net/ipv4/tcp_rmem

Affected users report they have the respective kernels defaults set, so:
- "4096 131072 6291456"  for v.617 builds
- "4096 131072 33554432" with the bumped max value of 32M for v6.18 builds

> It seems your application is enforcing a small SO_RCVBUF ?

No, we can exclude that since the output of `ss -tim` show the default 
buffer size after connection being established and growing up to the max 
value during traffic (backups being performed).

Might out-of-order packets and small (us scale) RTTs play a role?
`ss` reports `rcv_ooopack` when stale, the great majority of users 
having MTU 9000 (default seems to reduce the likelihood of this 
happening as well).

> I would take a look at
> 
> ecfea98b7d0d tcp: add net.ipv4.tcp_rcvbuf_low_rtt
> 416dd649f3aa tcp: add net.ipv4.tcp_comp_sack_rtt_percent
> aa251c84636c tcp: fix too slow tcp_rcvbuf_grow() action

Thanks a lot for the hints, we did already provide a test build with 
commit aa251c84636c cherry-picked on top of 6.17.11 to affected users, 
but they were still running into stale connections.
So while this (and most likely the increased `tcp_rmem[2]` default) 
seems to reduce the likelihood of stalls occurring, it does not fix them.

> After applying these patches, you can on the receiver :
> 
> perf record -a -e tcp:tcp_rcvbuf_grow sleep 30 ; perf script

We now provided test builds with mentioned commits cherry-picked as well 
and further asked for users to test with v6.18.1 stable.

Let me get back to you with requested traces and test results.

Best regards,
Christian Ebner


