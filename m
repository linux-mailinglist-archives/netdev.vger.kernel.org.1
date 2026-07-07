Return-Path: <netdev+bounces-305316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5RLGMJq0TGrboQEAu9opvQ
	(envelope-from <netdev+bounces-305316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:11:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC0718EFE
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:11:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm3 header.b="L d0wWe9";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=QJREVmts;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305316-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305316-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63D7030184D0
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC11386543;
	Tue,  7 Jul 2026 07:58:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68176175A91
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 07:58:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411112; cv=none; b=bw0YIkFwCIhLttkx7k4KmpcwYNnYQGJGZoVxWKqC2DzYP1zym9jfcM3GhSk/9laoyRujAKp6MqPJMTm83fXwetJiHY/JN3mrN2wLLyKV9j7ZjcZxPZK0sRLzL/B8ZJDmBBQWyJEEgKmZBHt1s1SMN8gfaZCcHohhEkmAkiqcMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411112; c=relaxed/simple;
	bh=iU/qiWmVqc8mJ4kMWloLnEMZPtFCZP6TrUTpLpQ815k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNnezHOgn34GaA5m8YuVlZAOvUYHriS6P0K7Uwss1bSaCrqhvIt1JwHPOqaeWIbHMAwaWKkp+v3HVCU2yO/Hqjml/huTN5GOj8RdOykpfQa8Fg4WATUQMV8dVnaYNlw7qKil821nfsths6+EfUpXukM4odGVYzqPgDSQYqExa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Ld0wWe9D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJREVmts; arc=none smtp.client-ip=103.168.172.150
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F5B9EC00C0;
	Tue,  7 Jul 2026 03:58:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jul 2026 03:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783411108; x=
	1783497508; bh=eJwZUoiS1FO5f6Y8aS9IeirTJ0PEY9A1ZMp5FQTjB7E=; b=L
	d0wWe9DZOKTzYGTsH7Z7X7NrIO1r4mvYnw5vIr+Gs7Boqd8veAT0RKquQGzf2HwX
	kEvTL4llAAw62meDbTHV08TnS2jM2PiUrN5v22dw+MPL6bwj2hOlYYa2ARJFuob5
	beUPcYfaQGFLhSobLtSbY7LEuuAau+bvzhToMgWSfVVDxKUlZw/VaQ3odEiv7hid
	avilACRtmuolo1kD6nqkUlP5RAHpaZ5A7p7kJadZ7USUtsh2Hp3nHrTN4pb8HU9L
	+albiQ5vtJotR9BOZKoVF6cQ3peXm0HiuxKd6w5yOzx31Q89HWEE3j7ApNuuBL3u
	QjQYHuNvXCl/x9fpRxGXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783411108; x=1783497508; bh=eJwZUoiS1FO5f6Y8aS9IeirTJ0PEY9A1ZMp
	5FQTjB7E=; b=QJREVmtso+boEN6IzeOrR000lYyE9NURF8PIuwit1xpBltxcp7a
	bEzbo9gSbStRC6wFC9oIHq2sjsWWIw4RtRzhDdVjWxe6qT5ZJqMk8mp4fgvIc2i6
	Yafq8AHcNuuBR4/ivgVVXKhfUkg0Nj4Ul3GxFVj+I3wAr0f9T0nNpiGgs2td5yZM
	ndRR4YZTU7WSzErKnnTtEKTb8M6tNswXKkQaJOLLwfVIxLRyuKVHbTrU1GL9Gi5e
	R33s/5NAe7pDF8fTNHzZqRC1+2HU4BN5MOOyrhXAJQnCMmZcbqMR+f3957YeUgul
	sd5hcBXt2Pjc1Oek4V5BcjTUSDvbku84DZg==
X-ME-Sender: <xms:pLFMagMtilv31kzD1RMgeR3tC4lKZKdjaiTR9u9aDNT0uolNDI8MJg>
    <xme:pLFMamDXcsW_UESAfenir2kcQPdNW_CmNiDNGAp02CmbXl_QanneqhwCpO15tr_yt
    rmrHLYdJ0pGha9a4Z89bt-n2Y7Schkh7YwDt7PecWP--iKj5l4s3Q>
X-ME-Received: <xmr:pLFMatexcp8xaLix6OJxVes6bkOkx5nw2oEq_AqIfwDiNldwq_TIRMwOqsU>
X-ME-Proxy-Cause: dmFkZTERHFx1yKfx12fcH1oZ/ZaGDI7QF68G+4py/16YMDHSaIO4gl37BLVla8k1DERMXL
    XRspa9RtuFiZbel8idESlESFqtB9hUEbFBJCvt2O47hMVfEitJOKyNHEnLMp0z5h+CLkKq
    fWnUPXeKDTjfeyKCnjWZdb5S0vA/mWcD0Ikwv2Hi58LFZbUIFeJiEvJexdoNzWPHQuUwmg
    ZklndqFGfB+6njln5WMq+hqiu0V7h1n6v1xE/pgPtMoN38JDfIZl1L2q77ZB5Z4rHN3YOL
    3UTj+sr1DiQFd/vhfODKISEe6Hc4IEctNMEeCKHli2rsIBQwsBn64nMFC8PY0zjUOqkOte
    R8OV79x5fOpjIqgAbCTG0xDDcX/GWtaR4BvkqoGLlnWQobkwp8CC+HOzrsWthOWix4614w
    HVQ5XZ86wAE4YAENX2om19V3i3YUjnZ8jbVvTCW1eJommZmq6I+bHln0hKfy3gTJ7PRlWN
    dkJvQ6TjY19KdKoeYFZMLEy+u7BTMwX/nc1NsNInsF+K71ebJvC0dD5pLiQL02XvKhQ1e4
    k8mPSjs6Pt1I7/6eoHJ873jrRGoae0jUHHhdc5FbwFCYJsU76z6aE68XNfzcnm/NUX6yl3
    LFDoB67TD33uyRofO43i32Pf7SzoU3aCyRdWj8WFxNIniazHSw6WizxhxtTQ
X-ME-Proxy: <xmx:pLFMalMAusi8HYH7fsXCi1LHQov6wYbXFIYQVj9GaRiqFV_aWd2zQA>
    <xmx:pLFMatJDPwJfmaImh4C5a8WBPHbbalpEPMcqdRgWBDMovizxFPJd3A>
    <xmx:pLFMalKKLk4jO2zQ57O6j5q08FOh8JgArcKdhs6_ZI0ichfu0cct-w>
    <xmx:pLFMan7hcTxlMVIJb9CVWoPU6cjXcGbJOrFRKZoIWlgDtvaMEg8lmQ>
    <xmx:pLFMarI6ABlxOtIgnszDJD2MtEXKP9IZ2WNKHVWcUOzo9ox7Ggl-0G7K>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:58:27 -0400 (EDT)
Date: Tue, 7 Jul 2026 09:58:25 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, edumazet@google.com,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net/tls: Consume empty data records in
 tls_sw_read_sock()
Message-ID: <akyxoZTzhNl7XCEG@krikkit>
References: <20260630191551.875664-1-cel@kernel.org>
 <akaoXcfamBp8_mYe@krikkit>
 <0a03d16e-d4ce-422d-9492-3e31d910d8e5@app.fastmail.com>
 <akbdFcQP7oTp_n3s@krikkit>
 <d036b6fa-4f53-444c-b376-83e122982f1d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d036b6fa-4f53-444c-b376-83e122982f1d@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305316-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:from_mime,queasysnail.net:email,queasysnail.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DFC0718EFE

2026-07-06, 15:16:21 -0400, Chuck Lever wrote:
> 
> 
> On Thu, Jul 2, 2026, at 5:50 PM, Sabrina Dubroca wrote:
> > 2026-07-02, 15:52:49 -0400, Chuck Lever wrote:
> >> 
> >> 
> >> On Thu, Jul 2, 2026, at 2:05 PM, Sabrina Dubroca wrote:
> >> > 2026-06-30, 15:15:51 -0400, Chuck Lever wrote:
> >> >> A peer may send a zero-length TLS application_data record; TLS 1.3
> >> >> explicitly permits these as a traffic-analysis countermeasure (RFC
> >> >> 8446, Section 5.1). After decryption such a record has full_len ==
> >> >> 0. tls_sw_read_sock() hands it to the read_actor, which has no
> >> >> payload to consume and returns zero. The loop treats a zero return
> >> >> as backpressure (used <= 0), requeues the skb at the head of
> >> >> rx_list, and stops. rx_list is serviced head-first on the next
> >> >> call, so the empty record is dequeued, fails the same way, and is
> >> >> requeued again; every later record on the connection is blocked
> >> >> behind it.
> >> >> 
> >> >> tls_sw_recvmsg() does not stall on this: a zero-length data record
> >> >> copies nothing and falls through to consume_skb(). Mirror that in
> >> >> the read_sock() path by recognizing an empty data record before
> >> >> the actor runs, consuming it, and continuing.
> >> >> 
> >> >> Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
> >> >> Signed-off-by: Chuck Lever <cel@kernel.org>
> >> >> ---
> >> >>  net/tls/tls_sw.c | 11 +++++++++++
> >> >>  1 file changed, 11 insertions(+)
> >> >
> >> > Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> >> >
> >> > I think tls_sw_splice_read() suffers from a similar issue (returning 0
> >> > even though more data may be available). Sashiko agrees, and also
> >> > found a few more pre-existing issues.
> >> 
> >> Do you want a v2 series with those issues addressed?
> >
> > I'd be ok with this patch going in on its own, and the other issues
> > being addressed separately. If you have time to look into those,
> > that'd be great.
> 
> patchwork shows this patch continues to be marked as "New". Is there
> something I need to do to help move it forward?

I don't think there's anything blocking it other than the length of
the maintainers' backlog.

-- 
Sabrina

