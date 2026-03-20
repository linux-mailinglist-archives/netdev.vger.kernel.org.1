Return-Path: <netdev+bounces-269895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNabCTMwvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:32:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6802D99EA
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B1E2301B900
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CED37E315;
	Fri, 20 Mar 2026 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXGqWT9u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83337188D;
	Fri, 20 Mar 2026 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006208; cv=none; b=fg1mA1j9vlUtse6rQ9ybaAugC7vMyC9031yoxxwqH810n7qw/9Cn/gGv1ShZaspLemGtEADkNCWdiHG156acPpFi3q155voSN+NpP89QibgeiLetixiPM5VkBKlcS3zuR7ZgGIRlvVbaFHCY+jLNekj5bnXnEdrAUWWkxu+M0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006208; c=relaxed/simple;
	bh=uefXC7O5QyHCc1dmEJ0Ci/CRYvinsKqWLMxd9Spuvww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NojrB7LnUFBJZQSMPr2itqgGcUVZ1QHlas0xmnEfAJK2qOnBwV8tst4JyihiozZqRltYZqo8XwykAeTvQNYWtq5DGumVuvTZUT8XVN8/nfLdNiADw0euxc12dXNO8QzRKEfO2sgMgUIjQPLp8XksTf5PAbeL0eV3H9HOCJZJiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXGqWT9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380ECC4CEF7;
	Fri, 20 Mar 2026 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774006208;
	bh=uefXC7O5QyHCc1dmEJ0Ci/CRYvinsKqWLMxd9Spuvww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AXGqWT9ulE0HL83dnktYmika+XCmbu00SWfq6RMd5tMwLhErvmXUjR5gz7/MbCpBR
	 CA/z5vBD8s38lUJ7awwzFpN7bqXN8gWcsr+MiZX/aw0EZ4mVd7dd+Faw9WQBwKCafG
	 tsb4ddyHobcuD4glhK+3NTBjEk04Saijwe4jImALj/2yqqgs7og72H1NQeYWGiX9Lz
	 5/5kmNtWbk0M3721D7Yqus4dSB0k78k8CdjHsNNxrPLNRI6QpfJ0DOoT4yHVvC/7AO
	 mRdpOFFpYGYjlsVjKk1aQAQfUcBxZG4MRimY6reA1eY6dRL7priXS53/0082hBgz9T
	 p1uH5RQxoWrgg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 hch@infradead.org, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com,
 calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 0/2] configfs: enable kernel-space item registration
In-Reply-To: <aYxL7d4MxbepGnKb@gmail.com>
References: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
 <878qfgx25r.fsf@t14s.mail-host-address-is-not-set>
 <-6hh70JX5nq4ruTMbNQPMoUi6wz8vmM2MQxqB3VNK3Zt97c-oxWOo3y0cQ7_h6BSfcp78fR9GmzxcTQb_WB-XA==@protonmail.internalid>
 <ineirxyguevlbqe7j4qpkcooqstpl5ogvzhg2bqutkic4lxwu5@vgtygbngs242>
 <875xakwwvz.fsf@t14s.mail-host-address-is-not-set>
 <C6V44SxiJH8NxRosmbshR-sfcBisrA5yWQpDmfQXe5vOX3uI6SM-r7wwUr7WxfPMS5ETUQ9GYDlptRs911A_Qg==@protonmail.internalid>
 <aYTWbElo_U_neJZi@deathstar>
 <87qzquuqsx.fsf@t14s.mail-host-address-is-not-set>
 <aYnnHJ2TQEcD_xMS@gmail.com>
 <877bsjvhqv.fsf@t14s.mail-host-address-is-not-set>
 <aYxL7d4MxbepGnKb@gmail.com>
Date: Fri, 20 Mar 2026 12:29:58 +0100
Message-ID: <87o6kirb61.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269895-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,infradead.org,evilplan.org,wbinvd.org,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	NEURAL_HAM(-0.00)[-0.953];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9F6802D99EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi Breno,

Breno Leitao <leitao@debian.org> writes:

> On Wed, Feb 11, 2026 at 08:53:12AM +0100, Andreas Hindborg wrote:
>> Breno Leitao <leitao@debian.org> writes:
>>=20
>> > On Mon, Feb 09, 2026 at 11:58:22AM +0100, Andreas Hindborg wrote:
>> >> Perhaps we should discuss this at a venue where we can get some more
>> >> people together? LPC or LSF maybe?
>> >
>> > Certainly, I agree. I=E2=80=99ve submitted my subscription to LSFMMBPF=
 with the main
>> > goal to discuss this topic. I wasn=E2=80=99t planning to present it th=
is, given it was
>> > a "overkill"?, but I=E2=80=99m happy to do so if that is the right dir=
ection.
>>=20
>> I'd appreciate if we can get some people in a room and force them to
>> think about this. I think it is a good idea if you submit a topic. If we
>> don't get a slot, we can see what we can do in the hallway, and if that
>> does not work out we are forced to make a decision between the 4 of us
>> participating on list. At least nobody can say we did not try to collect
>> input and opinions then.
>
> That is an excellent follow-up and direction, let me submit a topic in th=
ere.

I did not see a topic on list, did you submit?

At any rate, I did not receive an invitation for LSF this year, so I
will not be able to meet up in that venue.


Best regards,
Andreas Hindborg



