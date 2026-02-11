Return-Path: <netdev+bounces-258169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEaMNyHii2kVcgAAu9opvQ
	(envelope-from <netdev+bounces-258169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 02:57:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C8112096B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 02:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E59308104A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 01:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A652D595D;
	Wed, 11 Feb 2026 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN1v05Kh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198242D4806;
	Wed, 11 Feb 2026 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775000; cv=none; b=tqldzTXXYgW98brfJ+HYdc2nvzzviNqhYzWIVVL8O10OOz2SkQK0DeoqyxyK4ATGZjw9bv9gLjFCPyOZho3OeHglJUalKEMfFV4G5rgbDtSxb97Fuh/0ozOFhPqpCvID23wk0KSj7b4eWib81ulYxRfxxuf2F0nOo+wmdumc+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775000; c=relaxed/simple;
	bh=BMY9+yKdeAiBkeAYgMFch3HHKhcWuWYgHyr8mhgMM1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hu/Xp8XsxKq+8U7B4xMdPJ1PN0APtcPMPrNtjnKA9cB2iN1/tKcknwVKPsTPjDGgbZ1zJJ3zApPdmvKoYBOLYFYorsAz1o349yOfBcmo+PWtNShc+j8OyhHwWSmyDdaqxXk1MvnSmI238KxEivoIPwagGVEQIYGqVSFNcoHpl/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN1v05Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3947C116C6;
	Wed, 11 Feb 2026 01:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770774999;
	bh=BMY9+yKdeAiBkeAYgMFch3HHKhcWuWYgHyr8mhgMM1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NN1v05KhlBhfgpDMAO4i6qxV4EfwOA80jEm81MpnglwxPREGtJNB0Lq5Z3ETCSbrC
	 AI9Io/w5UYMNE4GZm6FHIvLFv7MlvOpzLRksEHgp2JrF7OGcKaGotwr0qNMT40dCzu
	 I2uEQElwTfLNCQIf7uY57zlN3aVdjD4u1HsUCSDC2mWlThh6YQ9QvcP0PE/KELYNxu
	 zsHUM1N3qgoWE6zc6mbak+MkDdcbd8GePhWYgkxx+ZnW9hlAbJZoBdfCHuaQEGMJmR
	 u96gJCrNpvW5EjjVV3Ih2r/p99hgdVKjHh4aKGo79CTr+wOVuZlCV/ULP+sI0EBxfA
	 PKldZe73yRz3w==
Date: Tue, 10 Feb 2026 17:56:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
 donald.hunter@gmail.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/9] selftests: drv-net: gro: use SO_TXTIME
 to schedule packets together
Message-ID: <20260210175638.123782b2@kernel.org>
In-Reply-To: <willemdebruijn.kernel.743811e01cc@gmail.com>
References: <20260207003509.3927744-1-kuba@kernel.org>
	<20260207003509.3927744-7-kuba@kernel.org>
	<willemdebruijn.kernel.743811e01cc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258169-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 83C8112096B
X-Rspamd-Action: no action

On Sun, 08 Feb 2026 21:39:38 -0500 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > Longer packet sequence tests are quite flaky when the test is run
> > over a real network. Try to avoid at least the jitter on the sender
> > side by scheduling all the packets to be sent at once using SO_TXTIME.
> > Use hardcoded tx time of 5msec in the future. In my test increasing
> > this time past 2msec makes no difference so 5msec is plenty of margin.
> > Since we now expect more output buffering make sure to raise SNDBUF.
> > 
> > Experimenting with long sequences I see frequent failures when sending
> > 200 packets, only 50-100 packets get coalesced. With this change
> > up to 1000 packets get coalesced relatively reliably.
> > 
> > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Does this require having FQ installed? I don't see any qdisc config
> in the GRO test.

It's a bit of an opportunistic optimization.

I initially intended it for for the "long sequence of packets"
test. But I failed to get AF_PACKET+FQ to cooperate sufficiently
to queue all of the packets in the same bucket. Otherwise FQ "sorts"
the packets, and breaks what the test is trying to do :(

Oh, and as mentioned in the commit msg - this improvement is intended
for HW-GRO, which may have very low timeouts. The test already
configures timeout for SW GRO to a very high value, so don't think
we would gain anything from setting up FQ on veth/netdevsim for the 
SW test.

So IDK what to do with this patch. Maybe I should just drop it?
It _seemed_ useful, but I don't have enough datapoints to do a real
comparison of how much it improves reliability.

