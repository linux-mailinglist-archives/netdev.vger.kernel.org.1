Return-Path: <netdev+bounces-261374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDKFLcpToGlLiQQAu9opvQ
	(envelope-from <netdev+bounces-261374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:08:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D481A73A6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940F8324CC95
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FBA3D3CE9;
	Thu, 26 Feb 2026 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b="FUhIEVdP"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nohats.ca (mx.nohats.ca [193.110.157.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A23D3307
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114382; cv=none; b=GEeklzeKk1x2cKDFNZGPw4aybm7aQ1WbgdfLIaM44ds0Bso68Tgj9ByzQnssimxhML4u3ovQMJ+rj8kEZJwLeCwneh50v+y6yK4vgGsTbXsF3CIok/w5xnMTlsAICShQTT/JWD/ANH8GnmOGedjIsmi4SssSyJo7XraKLq/3ec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114382; c=relaxed/simple;
	bh=1r/8+emM2pEM6Dpvvs1rgL44IH3Bny9dzRofl/A6Kyw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=dJ/PQyWMyCbAJOiJT7MnCa2MzEp3ZJ5ZfvlK1pcS4DN/cZ3FA2wI+yYYqArw7Bnr1JqWkktTOfi/kY6bJoJK/aZ+mqPry7v1IDkgtjDG4L6vnrYgW8W+P3RlWxo1MgLZkYjUCKPUFNzXaBdRTNRSC1/4cpCxecVP5TLYBxB9AKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nohats.ca; spf=pass smtp.mailfrom=nohats.ca; dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b=FUhIEVdP; arc=none smtp.client-ip=193.110.157.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nohats.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nohats.ca
Received: from localhost (localhost [IPv6:::1])
	by mx.nohats.ca (Postfix) with ESMTP id 4fMCYF1BrFz1J7;
	Thu, 26 Feb 2026 14:51:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nohats.ca;
	s=default; t=1772113889;
	bh=1r/8+emM2pEM6Dpvvs1rgL44IH3Bny9dzRofl/A6Kyw=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To;
	b=FUhIEVdP9rOpxtlAtGONubfU6rl8fQbJLwEyYTxkO6Ymjqm9xS9ARNYpJgYF333+e
	 +okwHTKbGYj2GzxyMx4uhyV6LRXvDpWZFRVs14o4YpD4G+oi6Q76PJSp50hhI3Vwae
	 EmzLFFTeNSpCZdNcikN61VOQGS02V6qTaB/NNvz8=
X-Virus-Scanned: amavisd-new at mx.nohats.ca
X-Spam-Flag: NO
X-Spam-Score: 1.206
X-Spam-Level: *
Received: from mx.nohats.ca ([IPv6:::1])
	by localhost (mx.nohats.ca [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id wvF8vfCdoFJh; Thu, 26 Feb 2026 14:51:27 +0100 (CET)
Received: from bofh.nohats.ca (bofh.nohats.ca [193.110.157.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.nohats.ca (Postfix) with ESMTPS;
	Thu, 26 Feb 2026 14:51:27 +0100 (CET)
Received: from smtpclient.apple (unknown [193.110.157.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by bofh.nohats.ca (Postfix) with ESMTPSA id 73794184FB82;
	Thu, 26 Feb 2026 08:51:26 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Paul Wouters <paul@nohats.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [devel-ipsec] [PATCH net-next v5 0/2] icmp: Fix icmp error source address over xfrm tunnel
Date: Thu, 26 Feb 2026 08:51:25 -0500
Message-Id: <054384A9-EE12-4671-8B9F-40E2134036B3@nohats.ca>
References: <cover.1772101380.git.antony.antony@secunet.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
 David S Miller <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Abeni Paolo <pabeni@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan <shuah@kernel.org>,
 devel@linux-ipsec.org, Tobias Brunner <tobias@strongswan.org>,
 Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 Antony Antony <antony.antony@secunet.com>
In-Reply-To: <cover.1772101380.git.antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
X-Mailer: iPhone Mail (23D127)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nohats.ca,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nohats.ca:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261374-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nohats.ca:mid,nohats.ca:dkim];
	DKIM_TRACE(0.00)[nohats.ca:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@nohats.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	APPLE_IOS_MAILER_COMMON(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D5D481A73A6
X-Rspamd-Action: no action



> On Feb 26, 2026, at 05:30, Antony Antony via Devel <devel@lists.linux-ipse=
c.org> wrote:
>=20
> =EF=BB=BF
> icmp: Fix icmp error source address over xfrm tunnel
>=20
> This fix, originally sent to XFRM/IPsec, has been recommended by
> Steffen Klassert to submit to the net tree, since it changes ICMP
> behavior.
>=20
> The patch addresses a minor issue related to the IPv4 source address
> of ICMP error messages. The bug only occurs when xfrm policies are
> configured. It originated from an old 2011 commit:
>=20
> commit 415b3334a21a ("icmp: Fix regression in nexthop resolution during
> replies.")

This bug has been confusing me for many years and I slays blamed libreswan f=
or it. Thanks for fixing it!

Paul=

