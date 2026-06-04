Return-Path: <netdev+bounces-295027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id el7MALPiIGp/8wAAu9opvQ
	(envelope-from <netdev+bounces-295027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:28:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B3A63C808
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:28:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=KrWP+IIM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295027-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295027-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B693026C0B
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA22366065;
	Thu,  4 Jun 2026 02:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7E355F49
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 02:26:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539975; cv=none; b=QfWt+X7BisS9aVSPbOBLTf4oThrjd3ZvOrXSUwT3KI4H/XhHQuDjvE3+h3hhMt02u92hL4Sga/Cr+p5XftjlTswQJDRx2e//IR3R6zlqpn8mGRmdFEWN/vMHIo9SP+GO51na3mmapEwwRw7mc/ET10DhgLxlL+CvRaGTpoF2ang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539975; c=relaxed/simple;
	bh=vo5d2Rz+OMJtdC8E2fXPcPkOIaK+UTosLWwyDrbRv2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVb/k85kmgji9uTi8ZPCq1bM+gxnNTgbx/RjG2crnzI3lRrv0O5spDeKMGQnthtc20qEE23zwSFJRn/hh53QjO7SjcHn/RkdGj2bwIxSGLZSYWMnGR7hRt3zBiafXpPnzmG3TpOA/hitF1zHC/cu1YNzdSLYj8313jXVOnQ90Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KrWP+IIM; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=q7dfpRGkIM0vHE+fWfYvavOJ8hSy9IKDXn738A5Uv4g=; 
	b=KrWP+IIMFS9xQZDpAUEWfav/uYPbAGrdVWhZJ49/49/G9CGTgrE/cPltshS/HuEIt3Npn6UnTLd
	B1Sf+/64/HeKea52YHJEYeH7pS/NnPSW0NFwjyDE8HEKNGOxQX5GBPTHb4KKJKcRIK3+aXT6rzMIN
	1ta1WwmR5SwMQwyo/pNwbY6CI28wHolV8d6Kooe3nWZIlynjImqTjX+zU1rTmFktagf0UHOw5WPnG
	yvkcy9aXZKjrmF4Su3nr3Kp8KFm+WdCS6c3VAhI5JZ4T5/t4cmZ4udsyR1VklfQfLmNgHpH+6YxmE
	YX0H5LYZ5cJVNo7w+ausQhg/BO2tdp0APUFw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wUxmO-002Dgn-1l;
	Thu, 04 Jun 2026 10:25:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Jun 2026 10:25:56 +0800
Date: Thu, 4 Jun 2026 10:25:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, steffen.klassert@secunet.com,
	andrew+netdev@lunn.ch, kuniyu@google.com, jlayton@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: protect egress device access in the output
 path with rcu_read_lock
Message-ID: <aiDiNDlUaRSHWURI@gondor.apana.org.au>
References: <ahveCu-zzFlpeVut@v4bel>
 <20260602154523.GA537996@shredder>
 <ad40bbe0-f79c-4fd9-9670-5dab01a8e57f@kernel.org>
 <aiAk2Q-yNs6It6g4@v4bel>
 <aiDUqIC7N1GXtICR@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiDUqIC7N1GXtICR@gondor.apana.org.au>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295027-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:imv4bel@gmail.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:jlayton@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46B3A63C808

On Thu, Jun 04, 2026 at 09:28:08AM +0800, Herbert Xu wrote:
.
> xfrm_output_resume is supposed to run with BH off so there is
> no need to acquire the RCU lock.

OK only the ones that actually come from crypto offload run with
BH off.  So perhaps add the RCU lock to the other callers of
xfrm_output_resume (ones which are not really resumptions) instead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

