Return-Path: <netdev+bounces-304276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5SN1NTHdRmokewsAu9opvQ
	(envelope-from <netdev+bounces-304276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 23:50:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D379D6FD109
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 23:50:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm3 header.b="t y2DgKd";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=BhXyxlsg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304276-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304276-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D9533015609
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 21:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCDA3B14AA;
	Thu,  2 Jul 2026 21:50:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBD3AFCFD
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 21:50:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029020; cv=none; b=JrM25KTWfxsXbQ7/Kod2ozjPOIv8naqxmn+pt1PL4zka81x5cI/Bkm5KW9A049ljidH9qUkdYYammsb8PjDvMuhx4HwxgELKS0bdbnsv5YWoqekjI9T0bsH1FumDlseZccdLmzTralfdBeiJnh+nSrV849DVHwGlun3dborhOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029020; c=relaxed/simple;
	bh=x6MA67vlRFjczPNkgY5TFczlie5G/uWMELnU2RQy+eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+lB12jDvqHAjLNGAAVCJrKghQe8dt/+w7J2aLkgxA0XQjnEc2qY2vFnekf2P3pFy3MKwoAin7Vagrfeim9Woz3SRTqOpbKiCAhXy57rpvoRmljIlRFlVaJ90LZ+mvHYgeKqTkiXBlRtka3qZNSIORE3cojLwYGaHapcF18cSWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ty2DgKdx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BhXyxlsg; arc=none smtp.client-ip=202.12.124.147
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id A17571D000E7;
	Thu,  2 Jul 2026 17:50:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 02 Jul 2026 17:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783029016; x=
	1783115416; bh=RqdaJU3y72AdTevTt/ImBcstt0+4Pa0P8qxSJ8eLou8=; b=t
	y2DgKdxbK8DCH0GUR0rmjkQUOD0akNGOzJREpsEbBsoINNTWPnb5kC2ZHTv8ZeUT
	TES5ebjxzwu4Q7d7iCKzYuCQJmh51ItY/hTio6zgVnEPElXLgQ4w4MIyOSl2DJ4E
	yD0OuYUskiT4WvCeA5wGxULywfJC4t4cjKz+JnfJh9lYUH/WgF7pTNcbgLbQ8m9t
	hRZmbvm9IQdUiEi5535PxfZ9LfrDTBuYXy4NMDtE2raoSnLsD2XXyxGanTfWtu1q
	n8Slvd8fV/kQc3AENqN4razaxEoZAyuKtH/yYU3s3IsaABPcz6uNb8JSv/NgnUKU
	AvQEv4avY4hSQc6icFADQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783029016; x=1783115416; bh=RqdaJU3y72AdTevTt/ImBcstt0+4Pa0P8qx
	SJ8eLou8=; b=BhXyxlsgtJlh8dTUJyNQK2JgVIW31NEdGbsUyikP8rfCoN+3b5o
	ks9/xLNxx2vgvoAK6BqOc9BLYKp0MaXKZ75zflus3yXn0m1ga5foon5t4j5XLyou
	6+V8/Zb13A3MoFf04HyY0Q6pss158OZDgwZkYTdNVXPN8Uh55nXEL0JFUDGVa0rU
	FlaaVe1GnypX+dDtfzzFiGL93t01IuH0hGY/xn44PBWT8L6MC2l+zKwJ/WPTLzn6
	jbmpIAZQDfUM6Na8QWlP8XXxDzYz5WqGGeRepeCE2afZYNuxbU8uklIA+vQ9T6RJ
	tHZq9MdAcp+WaOH52mHkWn1DjGAe5kKYREw==
X-ME-Sender: <xms:F91Gau6rVIYwEph9MdTGFwR9omU2Plwc3LqrXWcwCb-iOpz0f5ht4Q>
    <xme:F91Gam8DVrYar2Q7BUDr-bzis4-OFrrEiiHTy9UxlpVnbHvyKi0oXutI6a7jlhjkC
    T-tT7FBVhmjTx33q2jLx3g1tLcm4Qnx6etV8I6Ud59ILDKOLyGRvoI>
X-ME-Received: <xmr:F91GajrulelNP6DFWMiEw4xWMEmtUtvApfBBSY1LQVfIoYUJpKqa4pzQ4_E>
X-ME-Proxy-Cause: dmFkZTEPRVIA/z/jYnrTSVJwJiMOy6vxPXJHDEGtiffUNgrKH91P0A+0h8Z/CCWAF86VyC
    nxu6YGbqh58m1r0M1TOPPM/9mGyPpgznWmcOXK/Ct6Tw9+XfUZozTRyDcKjfaLMyQvb/hI
    mrnDCC4udqEd6G675eLdkZDmN3wtk0h/s3N1f4CrW3ZZIzV9c3y9YeGfxtxtPfTE4++SQw
    mPgCpYKoG4Oqj1Cx20pRKkSg0uHmmrZ2xi+gAcLRSjSkl32G1DgI7Cok6KcNqivmm+pQQ3
    HzHAk9QMu27zESUxd9TBC8slU7DkQO97wTBFUftRuJv9DcYnX08mfnvDqnzlVDgDGYYwYR
    L8g/Xhdlc02ywHEj7kSQcA0hi/WTrxw6NCilRxgGVb59x+wZSPfGvIlhHg4ufqjM2PHQLM
    BhIjJ7/6iGtCS1RLCLydOMSeX30A3lYhS0BdxnPmuByi8iJfoB1OmZEm1uE5lnxO0bK2bo
    loXAwgqljOZqNIRlG6r+gTNItKia9LdJNZPbPXmkRapnjaZan6/hmvjs//BbRBtjavkI9W
    uwON6ir3YTyZSRq8alAN3MytEc6WvRFIA5wMCCtheGATjx1WadTUTmv9w57+gCBqbkkpTW
    WPPSdDPdFH+5DKtqJ8TKvDd9jyvaifR78vT0I0NE3vkT4Vye0IjZdh66NQ3Q
X-ME-Proxy: <xmx:GN1GanqoP4e1znVclXuAVkRCpiOdye0jlu1hE1-3cbB7uDOwQe_ZYw>
    <xmx:GN1Gam3mLgzvd3sQQhBGympz-AP_cIvhy8TlUHsqQbQ1mon1uSkQng>
    <xmx:GN1GalEIMiYaG79VWO41JbaVg-3TaBD4f2SJzk_B0rVRZZNbqQfXxA>
    <xmx:GN1GahGhNaIRWnTQeg2SmYkg-0ae4Xwt9Bh4E4eckmx6I2FSXq1_SA>
    <xmx:GN1Gas4fMD5pAPVPqo3HV5Mgw0jmWYp3FNTE-An1UNy_FVltgdbebZ2b>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 17:50:15 -0400 (EDT)
Date: Thu, 2 Jul 2026 23:50:13 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, edumazet@google.com,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net/tls: Consume empty data records in
 tls_sw_read_sock()
Message-ID: <akbdFcQP7oTp_n3s@krikkit>
References: <20260630191551.875664-1-cel@kernel.org>
 <akaoXcfamBp8_mYe@krikkit>
 <0a03d16e-d4ce-422d-9492-3e31d910d8e5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a03d16e-d4ce-422d-9492-3e31d910d8e5@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304276-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim,krikkit:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D379D6FD109

2026-07-02, 15:52:49 -0400, Chuck Lever wrote:
> 
> 
> On Thu, Jul 2, 2026, at 2:05 PM, Sabrina Dubroca wrote:
> > 2026-06-30, 15:15:51 -0400, Chuck Lever wrote:
> >> A peer may send a zero-length TLS application_data record; TLS 1.3
> >> explicitly permits these as a traffic-analysis countermeasure (RFC
> >> 8446, Section 5.1). After decryption such a record has full_len ==
> >> 0. tls_sw_read_sock() hands it to the read_actor, which has no
> >> payload to consume and returns zero. The loop treats a zero return
> >> as backpressure (used <= 0), requeues the skb at the head of
> >> rx_list, and stops. rx_list is serviced head-first on the next
> >> call, so the empty record is dequeued, fails the same way, and is
> >> requeued again; every later record on the connection is blocked
> >> behind it.
> >> 
> >> tls_sw_recvmsg() does not stall on this: a zero-length data record
> >> copies nothing and falls through to consume_skb(). Mirror that in
> >> the read_sock() path by recognizing an empty data record before
> >> the actor runs, consuming it, and continuing.
> >> 
> >> Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
> >> Signed-off-by: Chuck Lever <cel@kernel.org>
> >> ---
> >>  net/tls/tls_sw.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >
> > Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> >
> > I think tls_sw_splice_read() suffers from a similar issue (returning 0
> > even though more data may be available). Sashiko agrees, and also
> > found a few more pre-existing issues.
> 
> Do you want a v2 series with those issues addressed?

I'd be ok with this patch going in on its own, and the other issues
being addressed separately. If you have time to look into those,
that'd be great.

-- 
Sabrina

