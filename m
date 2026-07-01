Return-Path: <netdev+bounces-303815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QhBLMzZvRWqjAAsAu9opvQ
	(envelope-from <netdev+bounces-303815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:49:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2336F1131
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:49:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b=aOOuf8X4;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="F Sfv9d0";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303815-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303815-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 358303084204
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 19:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FB1423F9B;
	Wed,  1 Jul 2026 19:42:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C0423F7A;
	Wed,  1 Jul 2026 19:42:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934940; cv=none; b=fmMWkMPKwpvt8Y+gfcesAM1pgqwuWX5FxY6W4jrE8zanRI91l+1YWp9MZD8YURTDugKSbZwO1ECwnJoHMJSuoYrGKNd0HrqyX92CM/1MAX1+lAVuSP78lTufxTbUHTiviqQs/iYM3C3fUCgiecuYhhjzYubIBipMU43dH9onaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934940; c=relaxed/simple;
	bh=duvUiJra6H1sq6gOYlnLjNAg1Sfl3oKcL1JFeqAltT0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TSP6yF5sUQSAJWJZ9jrdvpXHP0drTWYvEz2sFny1QPwoWW3nemdx3zSshLAy6bQnN4s1b5JZie3hdj9netfWhekiU4XtXwq7I5PMcqGpIWFIKioGfhCDhvZoDeuEOOqr9tAHpJNEQEIKj5bV+GBOMV2DZC9onWSg4Ad3fHuGarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=aOOuf8X4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FSfv9d0v; arc=none smtp.client-ip=103.168.172.159
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BE201400181;
	Wed,  1 Jul 2026 15:42:18 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 15:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782934938; x=1783021338; bh=duvUiJra6H1sq6gOYlnLjNAg1Sfl3oKc
	L1JFeqAltT0=; b=aOOuf8X4xJIDQD4w2sETh9g2ftGWMPoPk+yb+53cAdN7DZUm
	i/i3gV1UyttJG81U54VrtBFEXCeP/HabgzI4PRGzq6Jqfx9cKHlennpw2uTdT4IT
	OGPSlSqOodbQKEaFmRz2CSebrpuBTkmKzOwi+UsRPPpCXVVYKR3IK2AsyAjnqCLC
	jOpscOcoDZwx3xmNWjHrnmSS+Ye/DjKTl/prKCXF1kOx3z172SwWQJmixkFhmx0g
	oFceT1Q/a5oEDISnKImKZUmukVzHAr33YIL9sFFfzCKut9YaML4CAtrfmR/C7XjK
	3hVXuUS+586bpAXjTZIhNuzv7NBnqsmYgw0+Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782934938; x=
	1783021338; bh=duvUiJra6H1sq6gOYlnLjNAg1Sfl3oKcL1JFeqAltT0=; b=F
	Sfv9d0vof2r896tQSZsEnEAwKnFRINQoAfDHoDdS1oqzHcs21XMAmRSBPcODqt79
	UAQsdEEIlt65SQmzWubBKh3eXiX11VcI8331T01qmRPDEv0M9VIZd9C9JdDjphhl
	vVAcDQBP3Ho5tAmXtQTOt5jBTmWilfQIe2jpjAiB3XdNInu9DkiS9kXd96n2D7Av
	0HasrbO668ETHIXBG/dD+SNajH5y0fCsc9B/z8aDosn0v6YekKZGZp6/eqSK9Ezp
	VIHDorO55fd5PQcKT4WIYi2HC8RinjRCaWOrOstkwc6pT+tDwbktSpp7CPB04WCc
	Q1GE+jUcrRg5k9fORQ5UA==
X-ME-Sender: <xms:mW1Fal4k1KHH97RX8qQmRD707dVYxGTPPdsMcAqRduAXG2JKWuBkhA>
    <xme:mW1FatvDNmZoxN0KotHC3L18qsIXMlYivtgKP0r6r2Rmw8hJlyE8D9GuZBWPEK_US
    EzlwYLy7fKIetvmDfe5Rsw-SNl6Ij21-mB1I_GLa-L51eu-45uBRIM>
X-ME-Proxy-Cause: dmFkZTEcQge4w4sBHRY0uHSPe4IFqDnYUN2Tns4osA1e7ov62RU/KtjrvaM/pG/pfRNw5U
    9WgqleVx9+5kW2MWfNtTOhIY6ozhR/yri1GZMGHT9RAZG0Dp7IxrZjPZrLmo9skv+k1ZU/
    bZHEXxMZh3llrfZFP29O3onIDj8fE9HtzeAVz2DOMzQZJkkZ9JbZSs+bL86ngQH7LM56e2
    WLm5uo7kJxlc8BffnXb6JvjrPRq/tNV0ttrLL9f9lgJVlKx54JitZLT45Xprpx4Mfdq2Ua
    f8vAKz8PK0Alh4g0KP3E1+tGGU4qp243bGcy5AkqIg+vA/afTVEqR93dy04qfcB1ZEPGjr
    nVGrEnCRBQQblRSci2vjCaIYk9M2C52Gz+6/tcPZqTPxeHs8ib/PFj8qw+ilatRn7fQwd7
    jOqzaU+XhldTw8Ov3t2I0c10gVefLzDJVCHnJ34gZWuXvn54EbfyggUJ8bx5ouzGtAYHS/
    6BaClM9QNcvEIyGVs2YvXWOZM0tIxK7t6bBCVgrB2gD91mOjDIZJa5Fj5QtCn+C35S/n5D
    a5NpXv2KFEgyP6qxnOoZz9RagJmCPaeW5d+je+gHj8iFFSKCZAjBeoccbjmLLwnCJBNHmG
    jf0uJKOKRDALpZZivamcTUYC/6+4LCfkYKIlAB0HHHIT4LvMC2fsuHlFI4GQ
X-ME-Proxy: <xmx:mW1FajgBIYJJcrof1bvDAIK7luF2Y5644tyXiLd_lZp4_JSE2gAUcw>
    <xmx:mW1FaqE0ExHQfrGTEVDKuFa66fe0LcY2J8oXikK7Hzx6vUYLgPYMbg>
    <xmx:mW1Fai9qvBz2fCVNLsREC4VWre72CBrhi76rEx0nredBSEaqCbbVEg>
    <xmx:mW1FahxrXLe9K15wLkuUmeaLxn-Z1kfWfGaZ4fm80yydlJbUPgaPbg>
    <xmx:mm1Faoq77LztJFOGEvGAKKFNYIkMbHCHpq56SxMB5--K5Rh7Q_a87cfp>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9C4512CC0083; Wed,  1 Jul 2026 15:42:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aqzxz9K-cSE-
Date: Wed, 01 Jul 2026 15:41:39 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Cong Wang" <cwang@multikernel.io>
Cc: "Li Chen" <me@linux.beauty>, "Andy Lutomirski" <luto@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "network dev" <netdev@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-Id: <d0999427-dc53-4f8b-8026-c7d97cb31cae@app.fastmail.com>
In-Reply-To: <e396ce86-ec84-4189-9da2-98af7cfa6c41@app.fastmail.com>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
 <aicbyQIC2qEveNd-@pop-os.localdomain>
 <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
 <aixU_RccxS_BKhgX@pop-os.localdomain>
 <66eb8227-85b6-4684-a4fa-e3e17ac2fa45@app.fastmail.com>
 <e396ce86-ec84-4189-9da2-98af7cfa6c41@app.fastmail.com>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-303815-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cwang@multikernel.io,m:me@linux.beauty,m:luto@kernel.org,m:brauner@kernel.org,m:axboe@kernel.dk,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,johnericson.me:dkim,johnericson.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB2336F1131

Two small addendums to my previous email:

First, I linked these two unresponded-to emails for prior art in the
opening email of the thread:

> https://lore.kernel.org/netdev/4FCF171B.8000207@parallels.com/
> https://lore.kernel.org/all/CAEnbY+co6YLXANfeMnfBOBs8Ba_Sbdqz0Ahm8RzAhRF7MrxL4Q@mail.gmail.com/

Since then, I found one more:

https://lore.kernel.org/all/20120815161141.7598.16682.stgit@localhost.localdomain/#t

which is an actual patch by the same person that wrote the first linked
email, with replies. Hopefully that is useful.


Second, it occurred to me that regarding

> (Maybe `bind_unix_anon` should furthermore `listen` right away on
> `lfd` too?)

a useful thing to first decide is whether `bind_unix_anon` is
helpful and/or should be allowed for `SOCK_DGRAM`.

John

