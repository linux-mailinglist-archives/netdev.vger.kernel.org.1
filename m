Return-Path: <netdev+bounces-287369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPAZL2PTA2ol/AEAu9opvQ
	(envelope-from <netdev+bounces-287369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:26:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D43652BDE2
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4579230CD4F4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4F435CB73;
	Wed, 13 May 2026 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Ta7qu+hx"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27093655FB;
	Wed, 13 May 2026 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635384; cv=none; b=uVCTPoobqmEg7vSY5f40WGQP83Ec7MtPKlLEtPaQTBIHSilop7UrcUOBIztMjaFOCcTfYZYX9WE4i56fuBxvfKvHUbzfmAfkQT6zYoInKGzXSHEF74v6Cta0/N2OCwS8Gp4J/2w/muxY0AOp0zaw0N6Na4zlRu4sPqFQZMex3mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635384; c=relaxed/simple;
	bh=jr5Fjpj0PLNA9p0a/StfO4+Wy2mlhAYarKhCCWsJzTI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sed4Re1xk068D97snGITcQ1Y50N+QIfVoP7xLi1Hl9VjAoTwTW41K3nC6hpq5tHSNeOY34+17SzDpRy6oj3H2VYETJbrf17nPumIr8dHzqU+hxxsitqRIexRepxHmjQ/LrCTnriDqAIh4or6YKVklM6k/wxmscr4IUz4tK1xQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Ta7qu+hx; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1778635378;
	bh=jr5Fjpj0PLNA9p0a/StfO4+Wy2mlhAYarKhCCWsJzTI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ta7qu+hxrV5mABfJhIA5J1ROih6RXuUsFG9Mep45ZgcCtnkCK8GNOii0cA0M64jTa
	 +gEbrmQWTtsuyKQ7MWtMHKu2AkcxaYx7bW5pSXxcer5H786m9rQ1VoLtWX9CGLU7JI
	 caHJ8KCzmXYqnrEC+3lU0iQI/NBqlSRtFZaLip0IpL9Itxbai+YvaTXkSKMADZO/c2
	 CWmhok3n2EMmSzbkLnw9mrPRYifn6WdHnsW3plYzb7NtxBSY+VGA2biQpErF/hrvDp
	 m16YfiXILXqmWweMwcqHpR1915uQYji1r9bM0K5JS+Sdfih9gAdgyq4UGgX9q2EuN0
	 rfrDRacZV8fHg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 13F406008E;
	Wed, 13 May 2026 09:22:57 +0800 (AWST)
Message-ID: <f770a0af82fce258aa3d6866d00f5a6bd1a97f47.camel@codeconstruct.com.au>
Subject: Re: [net-next v41] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, Adam Young	
 <admiyo@os.amperecomputing.com>, Matt Johnston <matt@codeconstruct.com.au>,
  Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Huisong Li <lihuisong@huawei.com>
Date: Wed, 13 May 2026 09:22:56 +0800
In-Reply-To: <aecf0ac6-0dcc-4b7c-bcd7-dd78082161a0@amperemail.onmicrosoft.com>
References: <20260510163228.443778-1-admiyo@os.amperecomputing.com>
	 <9f4d364ebbbbbb697fcee022991a546e60692f11.camel@codeconstruct.com.au>
	 <9519a497-c10c-4abc-bcf9-414467f74ba3@amperemail.onmicrosoft.com>
	 <71b7c8f40efc25fadb0aede6be888986364f2d53.camel@codeconstruct.com.au>
	 <aecf0ac6-0dcc-4b7c-bcd7-dd78082161a0@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2D43652BDE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287369-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codeconstruct.com.au:mid,codeconstruct.com.au:dkim]
X-Rspamd-Action: no action

Hi Adam,

> > Adding the skb_linearize() there is unnecessary, and creates ambiguity
> > about the structure of the skbs that we're dealing with in that path.
> >=20
> OK, I get it now.=C2=A0 I was thinking that the Fragmentation was a likel=
y
> part of the progression, as default MCTP packets are so small.

OK, beware of potential confusion; there are two separate concepts here,
"MCTP fragmentation" and "skbs that have fragments".

"MCTP fragmentation" is implemented by the MCTP core, and splits large
MCTP messages into smaller packets; each packet being a separate skb,
with its own MCTP header.

Your transport driver does not need to care about this; it is only
concerned with transferring those individual skbs.

"skbs that have fragments" refers to the possibility that the data
represented by a skb may be held in scatter-gather format, rather than
(or in addition to) the skb->data buffer.

Your transport driver does not need to care about this either, as it is
not claiming to support fragmented skbs, so all of the skbs that reach
->ndo_start_xmit() will be linear.

> Yeah, I saw those, and was processing through them.=C2=A0 I have found=
=20
> similar type issues running against Codex.
>=20
> Some of the issues I found are due to the interactions with the PCC=20
> layer, and need to be addressed there.=C2=A0 It leads to some edge condit=
ions=20
> that are, for me, impossible to produce right now. There is one change=
=20
> it suggests which I thought I had already made.
>=20
> If those changes are going to cause significatnt changes, I will=20
> probably also integrate your suggestion on how to deal with IRQ-safe=20
> stats posting.

OK, sounds good.

Cheers,


Jeremy

