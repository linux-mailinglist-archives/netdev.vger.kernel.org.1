Return-Path: <netdev+bounces-293846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAdWOJi5HWrKdAkAu9opvQ
	(envelope-from <netdev+bounces-293846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:55:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E456E622E1C
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 186A3301E44F
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F573AE183;
	Mon,  1 Jun 2026 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeT+TxQR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA61737FF40
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332626; cv=none; b=ia/W8rXoG0hWSENNJTMMlFGfq1YMkKWefExytYfekQuDuMlr6NOY6yQT0v2qB7/bKxdoy7aFafsR3mr4yRZNBG3n6jxLdUVwCiVhd1lEAnAaSh0c1UGB8KSOmvjtORtlo/us5Z+IZWKZOtX4r8qhRPVuym5mSF0xM40+8GxUjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332626; c=relaxed/simple;
	bh=8zG6Il73X8XOj+y89DPMbE0wSRh913ay9W/WRMRmPj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNORK3cLjEz8U3pnSTuarb1CT7kXjW0uTirr9KYWkSzjKfSTv6HRGi8NMv1Dws2HBj8SH6SJsd6N2Zgy93dbNzIEUjJAJvYWSH3vDAXXuadtVAL/iahBnt3OnLS9oIuroiKLQ0yZ4Tj/Ux427Zwd5+64qh7yKu6vp0mhjVtPjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeT+TxQR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3A71F00893;
	Mon,  1 Jun 2026 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780332625;
	bh=8jl1Q/ZFKEpIXymFtUI6VqZghqC+lkQawLgoydOxlgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DeT+TxQRyMoVcXzm4rRxXRv9Pp5NwrR7Dnshvw2lBZHFA/L2Hz0NnV8D4pBTnZA2j
	 FGfPCKlKuB96/6SPeesJK9itvzDJAdMNSXLfX3wVjpD320Em9nuXoM9AuMFvq3eo4T
	 /uRieLuFlJs5qbMfyxqN8VR6CAWtDf0F7gkLh8TuzhM391MExtEDU5R7LEV4Kuibgr
	 JOS6kdGY+K1xwD8wJdBsr6YxSA5fAnftRlRZiAWVwI4zgl/7kH1Gv3EM6PppU3S+JD
	 TZEul+eX4eCLjCPcPCcQC/WaKm34y6lPrc7Gbk/JscY4I4zybMcut19h+7aGEAif34
	 dRWuryPPP6yjg==
Date: Mon, 1 Jun 2026 17:50:21 +0100
From: Simon Horman <horms@kernel.org>
To: Zhenghang Xiao <kipreyyy@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH xfrm] xfrm: iptfs: fix use-after-free on first_skb in
 __input_process_payload
Message-ID: <20260601165021.GZ2256768@horms.kernel.org>
References: <20260526105328.87078-1-kipreyyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526105328.87078-1-kipreyyy@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293846-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,horms.kernel.org:mid]
X-Rspamd-Queue-Id: E456E622E1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 06:53:28PM +0800, Zhenghang Xiao wrote:
> __input_process_payload() stores first_skb into xtfs->ra_newskb under
> drop_lock when starting partial reassembly, then unlocks and breaks out
> of the processing loop. The post-loop check reads xtfs->ra_newskb
> without the lock to decide whether first_skb is still owned:
> 
>     if (first_skb && first_iplen && !defer && first_skb != xtfs->ra_newskb)
> 
> Between spin_unlock and this read, a concurrent CPU running
> iptfs_reassem_cont() (or the drop_timer hrtimer) can complete
> reassembly, NULL xtfs->ra_newskb, and free the skb. The check then
> evaluates first_skb != NULL as true, and pskb_trim/ip_summed/consume_skb
> operate on the freed skb — a use-after-free in skbuff_head_cache.
> 
> Replace the unlocked read with a local bool that records whether
> first_skb was handed to the reassembly state in the current call. The
> flag is set after the existing spin_unlock, before the break, using the
> pointer equality that is stable at that point (first_skb == skb iff
> first_skb was stored in ra_newskb).
> 
> Fixes: 3f3339885fb3 ("xfrm: iptfs: add reusing received skb for the tunnel egress packet")
> Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>

FTR: An AI generated review of this patch is available on sashiko.dev.
I believe that review can be treated in the context of possible follow-up
and should not effect the progress of this patch.

