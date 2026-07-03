Return-Path: <netdev+bounces-304458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BVm3Gqh9R2q4ZQAAu9opvQ
	(envelope-from <netdev+bounces-304458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:15:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B089670083D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:15:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm1 header.b=nMtHNJGD;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="M o0aVtu";
	dmarc=pass (policy=none) header.from=johnericson.me;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304458-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304458-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49CA33001876
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23239E6CD;
	Fri,  3 Jul 2026 09:08:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7634388F;
	Fri,  3 Jul 2026 09:08:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069729; cv=none; b=nCdWLTwOEMTr34huiqTDMhfwth7JFLWDGR3WUOaqZ5vXNIO9mpy7sVTZMcEkRpfma2moIjrnfE+K2ehYDT3Ck78H1wNneZoljDj284L4o7IUZnU8hc/pUs6ngGW2ZJnn4LVPhgCDZx9Vvs3GifDaCA4ByQk62ktbAtFEfTkztyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069729; c=relaxed/simple;
	bh=IhZorfJZ92D/jj1k1qSWkBGjEKejmUoaMcY7YmrTyMQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RiMbsNXCTHtOGmG8jNDGnlWabsGqoWaPhAw7Ro/5LasDdiXR7nSO6LJu0ho+I0MANFxcMu/M+GKlToDz/e3oJX6RccX++VBqNhtKcdO9bjkoa/Ch9p1dET1QihwAZWrC1reV3eSaRGT1uWSDoPnkFE7VreMtORXI8UEhWcSCYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=nMtHNJGD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mo0aVtuo; arc=none smtp.client-ip=103.168.172.154
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8248D1400082;
	Fri,  3 Jul 2026 05:08:46 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 05:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1783069726; x=1783156126; bh=xWggPPeqBNhyXn2tiQj/uHlQsZcXGRrD
	NcJ687LiA5M=; b=nMtHNJGDwa+2iHtB1HfUx9rrs954bf/ue/LjZilEdDjtQhtP
	oKBn7wIUUWxa3/xBV2flkR9709HxyoLCyyUITefDnKwj5faPhM2Jd4pUXMu0g+li
	/l1Sdw+DHrG6T5lJqGH2AzNKjkiPJtasCQC1NSPo7N0LiDDBjvJXJwSANj62BrM4
	AA3pcgiC3/JnoA7ZkYCJAYsLEWH8s07l3sCBWCTwk+T7g1BMngJ1YealsU8xDyKy
	s0//40ksK6B+RrieJmHJPRR0m9xTby2RSyT92ckwNwhoak/JRRBmZsZW0pdCAzhj
	hVR2x02SWxTdfe+lOci2mlCWty32mmzoTnugjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783069726; x=
	1783156126; bh=xWggPPeqBNhyXn2tiQj/uHlQsZcXGRrDNcJ687LiA5M=; b=M
	o0aVtuoUyjCcNNOWzuNWNOni2M7jQtnLmJVK+AqgUhG+MPHvc9n4v7HMZX0NBbDq
	P+eJzdAkTfcPqrz/mD57/9vPew09CZIbTmAaOCqxMVOtVHhBMotlXdFU5c8C+vLx
	9gq6DVc8tq13KZt2+B8DqnfRKvjYo7eeZhOt3SsPDdxxZ8w8n2kahvauRylI1WGi
	WAvCHWaNsIkYeNCK2fOoey8+Lm92syoYCLwM7MFmUlLRYJFlV8v5B+NNFjVW9UBY
	7UsOwNcvs93OQ8jKgE655QZMN2+re2PUXKO6FY9DENdD88ZkigmqItT36X/QAd5U
	swLNNHYkmjsN4KIq4HOow==
X-ME-Sender: <xms:HXxHahF0HJQAXOV9hU3XpGkQqdAhNHSSYWOeaycyPOt1Wc70lPYIMQ>
    <xme:HXxHahKFnzlsmDWNfrExocT24iQ04qb5meXAlmyhcF4Stnna-9Hjnr7IobCZ2rpzb
    mM2ItDbzOefEhQzlEXmTQPB0wIUkUSg1zpmsPhEx0cJvEOk5TB9rA>
X-ME-Proxy-Cause: dmFkZTE9IFqDC8YXRPa10JXycFKzQIwZ0JrOSP+WilrHdi0p1yLri/cZvPGIhMrUbnlE9T
    7U5k4EH3IA0o8BWmmh5PCzdyH2bvel7c48hLV9x5P/DjhcWSsPFnDsUU4BbD23e7KW4fw6
    t8//3QYd4LB6q/21mA8B2ChrIaq9hppBqkzPG/W27VVt/f2P69sXNb3K2CdI2K+c1Oc7Ar
    SrzDf2PO18B/YaLA/2gTkf7QNLbUQ8hUyiLY7jBeSel/upgSWeKJHI9pgdbb7oTJ+YhRPf
    0Mnuc3MDZoekBP2x172pmJUk0AznKHjl/8MPQsPeOa/eMotZ4aenYo4NOvoCvJRfyJvpXh
    7LE4binvgjkxnihKry77feEg6a6ludXJYJg1Gsw1gMALs1qKhHGsSocao3hM7Z0UzGPbXN
    pHg4+4fsMpfy2cWqLPfiZGltoYf583FlC8g47iZ/Oleu/XPjlggOwWLoKxET8nMtUdkuAn
    kSO46ujB5dfhYDlXQ0SDaio858EIMO5L4/QRoOkocOTeF4sGuDF4azJrfJOGINIPe5rYej
    5efSmMcKL9PKc9JDjR8MFRTMgcfWqSf7kstbru8V5eMqHLaPHBg+RIu5uINl3oVEvDNXhi
    QGlh+qUZATFpzF+eTzA8Nq+t3dUQqYQLr4eqZzQNqtqWv8n/b5qcsd3+zmeA
X-ME-Proxy: <xmx:HXxHagkvS8rYtFXbmbU0QaW8vXSdP0VZBG0ivUpC66hvFpuYuu5o3Q>
    <xmx:HXxHak8R8PJEvJI2yqHbEihvuhuzxn8VJfP5Cm9L04kNciej3xe4lQ>
    <xmx:HXxHahkwahPfCMycNd7yO5AD8lwX_AHe2mq22EIWnSxUdyWN1Ku37A>
    <xmx:HXxHaik5xeO3jYk6s7KV56Ij5gYvlh8bl-KLmN0HB0zl90SEvF4YOg>
    <xmx:HnxHalf1uOO1HnyRO5e2vKLmxjs64iAnMVis03LqN1j2Ew6-U996R4QU>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D056A2CC0083; Fri,  3 Jul 2026 05:08:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aax20nD_6aQV
Date: Fri, 03 Jul 2026 05:08:16 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Christian Brauner" <brauner@kernel.org>,
 "John Ericson" <John.Ericson@obsidian.systems>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Cong Wang" <cwang@multikernel.io>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Simon Horman" <horms@kernel.org>,
 "David Rheinsberg" <david@readahead.eu>, "Andy Lutomirski" <luto@kernel.org>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "network dev" <netdev@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 "Paul Moore" <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <7acb650b-a0de-4244-861f-4dda70ca8993@app.fastmail.com>
In-Reply-To: <20260703-umgehen-auftun-anlagen-826bf59dfcb5@brauner>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
 <20260703073948.2541875-4-John.Ericson@Obsidian.Systems>
 <20260703-umgehen-auftun-anlagen-826bf59dfcb5@brauner>
Subject: Re: [RFC PATCH 3/3] coredump, net: remove `SOCK_COREDUMP`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:John.Ericson@obsidian.systems,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:cwang@multikernel.io,m:kuniyu@google.com,m:horms@kernel.org,m:david@readahead.eu,m:luto@kernel.org,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:mic@digikod.net,m:gnoack@google.com,m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304458-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,johnericson.me:from_mime,johnericson.me:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B089670083D

On Fri, Jul 3, 2026, at 4:11 AM, Christian Brauner wrote:
> I don't think dragging the bowels of net/ into fs/coredump.c just for
> the sake of getting a purely internal SOCK_COREDUMP flag out of the way
> is the right way to go.
>
> I suspect the saner thing to do would be to introduce a primitive for
> connecting to an AF_UNIX path-based socket directly instead of this
> weird dance here, no?
>
> int kernel_unix_connect(const char *path, struct socket *socket, unsigned int o_flags, int type)
>
> then my kthread changes would collapse this into:
>
> scoped_with_init_fs()
> retval = kernel_unix_connect(path, socket, O_NONBLOCK, SOCK_STREAM);

That works for this case, but the destination I am trying to eventually
reach is being allowed (in userspace) to connect to unbound sockets by
their fd --- no path, no abstract socket name.

    unix_connectat(int fd, const char *path, struct socket *socket,
                   unsigned int at_flags, unsigned int o_flags,
                   int type)

is a mouthful, but it would work. Still, there is a subtlety about the
retry logic. When one does something like:

> connect(..."/dev/fd/N",...)

it will repeatedly re-lookup "/dev/fd/N" until the timeout is reached. I
consider that pretty terrible --- the rest of the program could race to
change what that file descriptor (number) refers to. Therefore, I think
table stakes to make a good `unix_connectat` is to make the
`AT_EMPTY_PATH` case not re-lookup the socket.

(making a sockfs file descriptor work is separate, I already have the
patch for that, I can include it.)

> The two helpers also make no sense to me and force a bunch of cleanup on
> the caller as well.

I am fine with `unix_connectat`, but just for reference, me breaking up
the steps is because I generally like the decomposition of `fverb`
rather than `verbat` system calls, since the latter would typically be
used with `openat` or so. It seems the `kernel_*` "syscalls" generally
take `struct path` rather than strings, which seems good and in the
spirit of that decomposition, but then even `struct path` is overkill to
refer to a socket. So putting all that together, the final composition I
had was:

1. string path (from /proc/...) -> `struct path`
2. `struct path` -> `struct sock *`
3. connect to `struct sock *`

So I quite liked those 3 orthogonal knobs, vs an all-singing-all-dancing
`unix_connectat`. (I suppose making it `struct socket *` would make it
slightly less internals-y?) But again, anything that puts us on track to
being able to connect to an unbound socket without procfs is good enough
for me.

> I'm not sure why we would go on altering all kinds of LSM hooks as well.

That's in the commit message, it is because without `SOCK_COREDUMP`
those are all dead code. Instead of removing them in this commit, I can
just keep those flags, or remove them in a separate commit. Fine
with any of those.

John

