Return-Path: <netdev+bounces-299632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N0qDN/d1MGohTQUAu9opvQ
	(envelope-from <netdev+bounces-299632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:00:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B868A40F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:00:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="m VmVEOR";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=fsDMmv8z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299632-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299632-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D44F7304D7F7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEFC3385A5;
	Mon, 15 Jun 2026 22:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAA2E7162;
	Mon, 15 Jun 2026 22:00:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560820; cv=none; b=LeNBuaNNajj0NI535B1jy2YPOxr6IlP8GVqSPBLch9uOWgKqxXlvuUW7N16EDL6HNppqh6tvLJwr7UkbW1QUoelZ4XsGXxQ/CsC07XzUJmwLVt2U02OUuViWuPVGzWqVOGIjc0hh/ZPbuF1qvfQ89t33Tvj0MYcoXOq7o46b8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560820; c=relaxed/simple;
	bh=P9XxLDFHqeMGTRhUDfC5zHJ1bjX28E+A9t2YdBgnULo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmcIAwtAS2Roi7PzlhRA+NA57hQbB/Cdrowj5CUKq1yrrFPy2CYNGPZ4ErCinurRrlDZxfyoaE7o2761V8usWbqUN6Lczoy+8WDXPBuhk4UyLUB4J4Bq9+yX8D3b0j6TlTtDsnsK0+TJk4vL1e8yDHwz4frEjsAmv8L8d9og0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=mVmVEORi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fsDMmv8z; arc=none smtp.client-ip=103.168.172.157
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE5FD1400109;
	Mon, 15 Jun 2026 18:00:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 18:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781560816; x=
	1781647216; bh=Kvm0JNUboIg8eJ7KwJVZkhaAicq/QT9fy1LvExWaAn8=; b=m
	VmVEORiGUinBG9ERHFYm02ZZQOTlHfyB11SDcgHgB5S3mOMUXdOaY8qk5DyzTims
	xOz/hUvBxGP5XNr0Y5Pyzrib/6xdcza4kMOw5acY4ZdhcVR6+L5iaO8JQgvy/ABA
	KRLaA/gFyMQ1pACGUqXe7R0MVfBJh+T2BVO6nj6NIv4xUZhC4MwiWihy5PqHqBs5
	qH/EJqSSdMtJw2wCthCD3zhYg/fybEqvckPiukQkINXyt5APYVExNDC6yKe/Mmwr
	zncevxTH/wRLuGs8uUAZn8JSU0zqIJrG4yzkkHgV4flF8wqWOYs4S6OQVItD60Et
	fg0OIxxs5Qc85rjyphQXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781560816; x=1781647216; bh=Kvm0JNUboIg8eJ7KwJVZkhaAicq/QT9fy1L
	vExWaAn8=; b=fsDMmv8znP7OZKpaYwIhMU5zSaOHYG0IuC9zsWCs9SrG2h5rUo7
	INrBLaoRphKNOnbX0BkqEN3+W6G4Hvh6/fU+nmcykJhJ1UZiDx9A6+cI5mEoK4eI
	GVtK5+hccEHGGK8dlzraJTIoVZUS2bHvSZy2XCFoLa06e+F1yUBiyDS2gZrpgx0M
	PQEU+rYoRAheUPPgp/Vl5PgWvJzOT51ctmsGOmKUp9uBDocOx8wh7VO4j2yXDR65
	wK0NnOEVEvJUxbPZ8jnTHA8iM35MiIqii8IPRuzLYgYgEKGBkd7IxvZ6yWbGq08Y
	gkDb5t1F0qrAR3Q7QgST86BkgXO1uaMz8Jw==
X-ME-Sender: <xms:8HUwap6BAUhjuDVpT0oQ0J4IUkqrHVbFMapEUiQ0gQ9zJlRJIEJlpg>
    <xme:8HUwap8lNbXx0lSxXMa7Vp7Som2GUuzsNEjpWzYnngouWjgYGuckV1Zneb6jFqdyF
    SiV-YV21G_ROtsOMrBJOAy44rOHNZquk3yiE3fFe5gYhh7ZS6qA9v-K>
X-ME-Received: <xmr:8HUwarG2H9RP9uzmzuO2vzxKneVgjbcaOpJmjU2KN7pocEpJv1bsUNROkreoSRde0avSIHf4HwgeUxEGOpuUkec>
X-ME-Proxy-Cause: dmFkZTEAeC7d8fxAsNbMlR0neJsYLsUtMZshbRwlQFmF6AxFfaQvHNRa59tUo+wVMejbkI
    Vrgqc16k5RuGDu/WeM+p9BvueGmVHcENJ8fZAFvAPh/xahKSlExhWjo28U3WQX5FNYMLJg
    /5LZ+xVXvRa7d1dLC4MMUoOaiFAl3soxNuOw1ZEVNRkUHZnKDGafK/6xZJ6QMfW6AfCXAu
    Y+7CV/BH97zXuhMo4XN0mio0OuQ7nq/O9UAcr0LClDw6DjM1i9qzCo/q5gNQMXhS1ikLMj
    6WDs6CLdbuawKkRs8vUk7yO3kkzxmKSNgjsGz0NT999GCM3bvhcQ6MVQ5txEBePV0O4yjI
    Vj60e0X1y5EouMFBEt34Lh62NO7ASLMaWVvSwKH0Rw8AIvNcQpakxjkhG6ygbQB7utHZPV
    xJ90xElIViArSsbc6v/s+yWvPUotNNOiEZ/ThSXwrJLtWvpfCtqx4TgIPKcYQVCKmvY3zz
    v7DQynF/lcG1FxRqEXnZsJx6krI3ArH7Q0ZqMjPwDwKVai213FMorqKfoyaB/vQ6w55PSV
    +FCa2WtQgb7sCYLAsumC7/2V68IBXksUB96KGhEL5a6SIijJqQNvxlhb7hrHmb7f7zSSkm
    hfRjfHAUaAFlrXAeh+XYHYjpTtN6vwPAIat2tvZJ3hQ4H6AVu41mbvm5x8Aw
X-ME-Proxy: <xmx:8HUwauVG0pFS91dSsWO170N1wG8b4GPtD4ibrXwa3ayQcN7ZM2GX5g>
    <xmx:8HUwan9WFodJzHJ9Cqk2CfR0ITqX9S8CLfdt-sM2g8-qJb9k20okvw>
    <xmx:8HUwar7-vjfiEPe7eTs_yhNRUXxImU7kL4RRryyzir4yzcOb6UHGhg>
    <xmx:8HUwagnt03nPxRzqY0VQH4BDxC3dprwv3KXSsk20w6trn2SCObADHA>
    <xmx:8HUwahnF7i02m0CaAsef9Ny3jYfcD6LnWYhZ4oddiU6jSCKwvKmLVu8G>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 18:00:15 -0400 (EDT)
Date: Tue, 16 Jun 2026 00:00:13 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
	john.fastabend@gmail.com
Subject: Re: [PATCH net-next 1/5] tls: reject the combination of TLS and
 sockmap
Message-ID: <ajB17YvTfkZlsAAk@krikkit>
References: <20260614014102.461064-1-kuba@kernel.org>
 <20260614014102.461064-2-kuba@kernel.org>
 <87tsr3bq2m.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tsr3bq2m.fsf@cloudflare.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299632-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 094B868A40F

2026-06-15, 20:45:21 +0200, Jakub Sitnicki wrote:
> On Sat, Jun 13, 2026 at 06:40 PM -07, Jakub Kicinski wrote:
> > TLS and sockmap (BPF psock) integration hides a lot of latent bugs.
> > Bugs which may be more or less relevant for real users but they
> > are definitely exploitable.
> >
> > We could not find anyone actively using this integration so let's
> > reject this config. Adding a TLS socket to a sockmap was already
> > rejected by sk_psock_init() through the inet_csk_has_ulp() check.
> > We need to reject the attempts to configure the TLS keys (rather
> > than adding the ULP itself) because checking prior to the ULP
> > installation is tricky without risking a race with sockmap getting
> > added in parallel (sockmap does not hold the socket lock).
> >
> > This patch is a minimal rejection of the feature. Subsequent patch
> > in the series will do a light dead code removal. Full cleanup would
> > require a major rewrite of the Tx path, we don't need skmsg any more.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> 
> SGTM until we can come up with a generic way to exclude sockmapped
> sockets from ktls and espintcp.

And possibly ovpn too.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

