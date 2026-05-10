Return-Path: <netdev+bounces-286322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFB3EfmqAGrhLQEAu9opvQ
	(envelope-from <netdev+bounces-286322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:57:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DC0504F3D
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76EC3300D45A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE7337AA94;
	Sun, 10 May 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQV28pKR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B224886A;
	Sun, 10 May 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778428563; cv=none; b=mE2H/aDgerJw/46cuCclykpwH7BYNCSHE8tc8lT8VKuNj9DqnOlewI0gAwnd4uL+laMCtgJNiAiLoXFsXuaTXNHKwZxU4Gu7iBrU20t7kRS905Fpl6UFIa6eu72rGo83D5FpIDI7PuqboAyd/j2v4KfWmkcis7DJfwxzYH5crDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778428563; c=relaxed/simple;
	bh=DKRMHWxdi6z+PAalXzDlkXlxQgstpqQcwYevUkauWbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkTu1LeU8cpIPOTEgdTljrwIdyfDdLOeHN7VANXS9pY+8D5t6t0cRiSuPUHhfl7PhVliHX+VrlLd69oxCAjs0sEMBnASU8Y97q+GSK9PXMHsulM1ObzXEm/1OVlWr8lPzIyQFBsOl2XbTc09vwQqkUCSWyYtTGo4Tpd2SyvqH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQV28pKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39C4C2BCB8;
	Sun, 10 May 2026 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778428563;
	bh=DKRMHWxdi6z+PAalXzDlkXlxQgstpqQcwYevUkauWbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RQV28pKRGyDtX8i8VLG4sjdOuBLsPPcrUVVYrl352AtpEoubl4CNANLQx/Wf9Wzq6
	 lCFz97ts4Y5vV/K87QW49Aoecb+DxmBhb63CJgaRz+xlP5wTnrzTPZwhSlbNJ9LnRi
	 fG7zQOexvq40qsX8RaPbA0cHIHph+4+SGXNG57ogcAP2ISHTSYvDuys11ngPjAmivE
	 2CB4w3VqCGvQw8xJUIjBIWPsmrU8GETuJOpKlaz7qD5+tEU5yAwpL8EQN2NhrIqSoo
	 4n5qVQowTdegnsvN90dbX2DpQFhWmAUbOzGZ2G7zXfP8eo04wo6ri57JwpfYkxBQcR
	 cZaamJMnxrLzQ==
Date: Sun, 10 May 2026 08:56:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Simon Schippers <simon@schippers-hamm.de>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
Message-ID: <20260510085602.57c7a081@kernel.org>
In-Reply-To: <f459b95c-80d5-4e05-84b2-f574c92724de@kernel.org>
References: <20260505132159.241305-1-hawk@kernel.org>
	<20260505132159.241305-4-hawk@kernel.org>
	<ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
	<8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
	<e3a91545-13cd-4f87-8375-d707865bdbca@schippers-hamm.de>
	<6a597dbd-70bf-4b14-b495-2f7248fd3220@kernel.org>
	<20260508190626.4285fac0@kernel.org>
	<f459b95c-80d5-4e05-84b2-f574c92724de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D7DC0504F3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286322-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[schippers-hamm.de,redhat.com,vger.kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, 9 May 2026 11:09:51 +0200 Jesper Dangaard Brouer wrote:
> On 09/05/2026 04.06, Jakub Kicinski wrote:
> > On Thu, 7 May 2026 21:09:09 +0200 Jesper Dangaard Brouer wrote:  
> >> Not against being able to modify VETH_RING_SIZE, but I don't think it is
> >> the solution here.  
> > 
> > Was it evaluated, tho?
> > 
> > It's obviously super easy these days have AI spew no end of complex
> > code. So it'd be great to have some solid, ideally production-like
> > data to back this all up.
> > 
> > VETH_RING_SIZE seems trivial, ethtool set ringparam  
> 
> No, unfortunately we cannot just decrease the VETH_RING_SIZE. 

To be clear - I said may it configurable with ethtool -G
not change the default.

> The reason is that XDP-redirect into veth don't have any
> back-pressure and would simply drop packets if queue size becomes
> less than the NAPI budget (64). (Yes, we use both normal path and
> XDP-redirect in production). 

Doesn't this mean you have a queue which is not under BQL control?

> My benchmarking shows that an optimal BQL limit is dynamically
> adjusted between 17-55 depending on veth consumer namespace
> overhead/speed, when balancing throughput and latency.

Testing with prod-approximating traffic pattern and load would be great.

