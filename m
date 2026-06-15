Return-Path: <netdev+bounces-299646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 57X5G+OBMGq7TwUAu9opvQ
	(envelope-from <netdev+bounces-299646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:51:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38C68A7A4
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:51:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="L mXpPuz";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=ID4O7D9k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299646-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299646-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 819093009899
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6BA3B9949;
	Mon, 15 Jun 2026 22:51:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0463B71B1;
	Mon, 15 Jun 2026 22:51:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563871; cv=none; b=qA7+KidzY3CgdQQvIOcTrlNn6Tel6cOZJae7m7BCEOZ5J1Ad74v+3t9h0lsps5RRQQvbPD/KRhe+RI3NmwqDd5+ysSZLt+d6CMNA+29QVjgZd+fNn6fdOnqH1DU1Theu+VNk6+5WN6eCy6tLAyOl9rtYU+wOvSI7J+KpXCcMLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563871; c=relaxed/simple;
	bh=HDHe7YkoetYyloltH6XURO2F6igGsU2azkCj/UkQD0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nW+rQO3I7MIeVrE4+wDXEzjZ99kxfsBHd5SwD4q1ncUyAOdOAUkSTeZNdmPGlI8jsXECgT0apV4yFbePhhBf7XqBp220A8QrdE7U09O3tbayxf9hd3xtJgZEBc9dqS55wqXFNDO0jDQEs4xHSYY4eZnFnF5gRrAs5Lv/cj7Z3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=LmXpPuzv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ID4O7D9k; arc=none smtp.client-ip=103.168.172.157
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A26911400016;
	Mon, 15 Jun 2026 18:51:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 18:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781563868; x=
	1781650268; bh=kLMhR1eeQ42+DWD/TLCVQ6ksLQ40rd4N/1skfaWj9/0=; b=L
	mXpPuzvfyugOX4NT7SU1KsZq/u/fXDDQZaSR5yDvGtGSok20pdqauPxxjzAg0eGm
	1QgWvRJhVN0UseGIlYeYXHCouoK+eHsPQikgNiKjW3IjWLqJdSkGSib63chtt1mL
	rC5gABXNY3Uv6XuOrYURfpZJRiZp+EVDeKp5ona689BAPuk195DQ6t9TBwF5w9J/
	aDMfub88Pqp2eovHm4we9mzwaxvZeTKIP4LzSOXpapPmYEj27/cu24Fqu7+SxRmY
	JoPy9r4LcATMCrcbfqiwWy4K92zCrrUkBjlUAwOY8vn4UPRpcwkYvY1DV/CKYeMt
	KhsL9SQdC35TRYdlQe9qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781563868; x=1781650268; bh=kLMhR1eeQ42+DWD/TLCVQ6ksLQ40rd4N/1s
	kfaWj9/0=; b=ID4O7D9kHcyOKOafP7D2hWpIGGELlmuDMt3lmlY6t5qsX6yOSDl
	0QgEFKtG7bjbyZweavtkVCPweJm+drtZ4US581kayDKaeQcvO1Z6zQ9+nEoxHblQ
	QTzgJskAnWvrkwgndFetUfNnqgkc0Qt6gDUoaAayjaQE6ZatM69MILwN+fcrplsw
	9+RcrGIBG9s+GZHwOOKO4dB9ycpbntUG+CFraeta8Xp1x/edq8QJ52odOk3/9saL
	RM1+bnxXo+z5GPYJd0fc/oa+xduB3Hh6OG762vlcJXnp+AtAuBjlg/CpOkzKwTUO
	amGT7ltHY2IpIU5lZFdjdQmucdJyn4DPdiA==
X-ME-Sender: <xms:24Ewau5tfz2KiFLESUcJYrqiddHU7lHEWMBEYSCp4f3w7a5hFIaa6Q>
    <xme:24EwapffG5r6JSRVkrom8InCBBWAIwEr8EPXGIlKmIzmIDAw-J2pX-ws3XAYYPzPy
    uXVZwhCqoi_ix2nSO9PNqDtcjRQkCQ-oarrZ9xqYP5xs3ltY1rKNQo>
X-ME-Received: <xmr:24EwastzfgBlZlneHKJEoZ6OuFY26gyHcErbUrLSaqVn7BAhCkFt5JcZZqtQgtMb-AVXBKOLcAHDXc4PmkrX0ZA>
X-ME-Proxy-Cause: dmFkZTGUhEvLyB9ig41WxJtSC1xHT3ItJlvcMxkv67VI7SLdKksztZzaEJoLX1RgraCNY5
    g26R8gAWu3mWoe1xtyMhipjz+Jk2ojUp21EEAtQZZKYU2x8r5wpBga9TC78Gvh2/5+FCqq
    od6xTmp9rOzNV8Wr8v7iV74r08b7rx7kjIZxE7UBmyjbSCwEJ0Uol6DPNjIrlCB4QV7Jii
    wobwG72iKTrrD8/XP6nYgnLennenpaoAPoHTQcQPVZp/+xENu+zCmijAdBb7MrFWVKaUIt
    FoiNDvLFxG0NkCT0mHi/TJVZ5Gz5waohMhoFZ+CTrb00q68imu66VsZ5OOY4maU4+uEQCi
    TWXFZVkkP5vYz+alkqmvDT8pkh/NIzxvOhwzwQrokoJNi5MDW6JfjvxKsLtwvXM/Ohsq/r
    V4Bcclw99iEHU5i8yuRy4iZVUimXKcmpqz+Sn+0xvfXvBAAJoRpkxxDc37FC1NSHRmA/7Q
    tBARLk9h8RA+KNnDjqVubXkDgOjkZdAkOnbflBB3UW9v2/RI4GiVy0dE7Dbx5ykEsMJDrC
    ILctSpoDoooYOBpiR/uF/VXfvKjoSV4FUo3kWYBknoKviT3QH9A7NNaVaGNZDbg0fwdZtS
    qxxp+uKDmbljHDGe4ma72n+DoghoWtHL3Y5M9XxHDvc62PgGtlwztvYQjUNg
X-ME-Proxy: <xmx:24EwahmBAsbAgr0-kafazmPtS2VuCYwN0LneJhqxFSPipMLz_4P0iQ>
    <xmx:24EwanR7sglMLWsI9zrPAeDQ0cFEly4IHOEcPlRvU-v0n7vPoFC2-A>
    <xmx:24EwavJGQzUVPPUD1ez7LlZV38Wgz5ZIXkX0U-S7HOPsUtH615_7Ag>
    <xmx:24EwapHCat8Sq3A6dG7Bhe71CCL9e-n4BeZqdVaBdbFuqP_ZNnp4Xw>
    <xmx:3IEwaj6fhtUHj23tEDnupYvaSO6SXElxBy5FFDG0WsISEOg8mry5wfGV>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 18:51:07 -0400 (EDT)
Date: Tue, 16 Jun 2026 00:51:06 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, john.fastabend@gmail.com,
	jiri@resnulli.us, skhan@linuxfoundation.org
Subject: Re: [PATCH net-next v2 3/3] docs: net: fix minor issues with
 strparser docs
Message-ID: <ajCB2uOQ7ibDtN99@krikkit>
References: <20260613165846.2913092-1-kuba@kernel.org>
 <20260613165846.2913092-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613165846.2913092-4-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:john.fastabend@gmail.com,m:jiri@resnulli.us,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,gmail.com,resnulli.us,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim,lwn.net:email,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C38C68A7A4

2026-06-13, 09:58:46 -0700, Jakub Kicinski wrote:
> Not sure if anyone would read this doc, but the API has evolved
> since it was written. Update to:
> - show the int return type for strp_init()
> - refer to strp_data_ready(), not the old strp_tcp_data_ready() name
> - direct users to strp_msg(skb) for strparser metadata instead of
>   treating skb->cb as struct strp_msg directly
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/networking/strparser.rst | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>


> @@ -123,9 +123,9 @@ Callbacks
>      should parse the sk_buff as containing the headers for the
>      next application layer message in the stream.

Last time I had a look at strp, I was thinking about removing half of
the callbacks, since they're never used. Not a big simplification, but
it would remove a few indirections when reading the code.

-- 
Sabrina

