Return-Path: <netdev+bounces-301835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YzVKBwyRPGq7pQgAu9opvQ
	(envelope-from <netdev+bounces-301835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:23:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 725C66C25D2
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:23:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HiOavYNd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301835-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301835-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77E1E30075C0
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95EC3A3E68;
	Thu, 25 Jun 2026 02:22:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAF19C54E;
	Thu, 25 Jun 2026 02:22:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354127; cv=none; b=Ww2vG61Jcja/1CEXIqUrnuSKlu8hAEw1YHEkR5FEQhHkyGywekGIZ+tAFuzKsYAoW4Va/sbV9+f0y+VV5dSrG9TdVFKWqF4+bdnAj3dFn7xJoFOSH/n+N0Dt0/7fsrq+fZxHxc17giW/b3ZcViPO7H3AmiBJ1+6Bt6ABg0dkznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354127; c=relaxed/simple;
	bh=mrCD9REILvQ7ytkuNxk1sAWwsznOhzIhvtqZMRthRkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcZSS94YN3GCNclWDVrWr3a/9zceOhFvkRi+6L6MV/d15TbM1vhM7/CQ0jd37XWOXRSuGpZD1jf6B5QTMwTHBCWSemSyxLuny6BixUz1oU1lu8/S8XmQl+1HlompDGGM4Kl+UnkzsOhyjZsME7DlZiG0exifZrh6xRkb76eYHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiOavYNd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE40A1F000E9;
	Thu, 25 Jun 2026 02:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782354126;
	bh=UlrC4XUDtorWQW364JN0VeT9+sVnJidBJZvQBFd/jWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HiOavYNdbdkx11uI3Z7iAu3Qr+Vw+lNFKBH5kxQwAHLtGi8sTYQFSblscjPerahV8
	 3SXc/H+XSsYx1QjjkBQHPtR0TOS/H7pdRKXl9va4pzL60yYe9X6oDu8VIpy5VzmIhl
	 oeG8ZSGjblxHCO6ixyCLeGbenNyIKRcA4sFj04cqHth2B6vUcuW5ozkPtax89wo0W9
	 J69L2VeRA5/9TcOwUMS+Qbff5CiZKPWH6Ip8JydeUXavGLwDx7Bqf5f3FUWJzIafrG
	 vpA6AE+Zz65Bj+JmhZWhZHRRlOAfN1JbjPPcsI8uUs74hlPbVJCJF0l1qTQ70hwkRc
	 2sx0qwAn3VAfg==
Date: Wed, 24 Jun 2026 19:22:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: fix missed le32_to_cpu()
Message-ID: <20260624192205.4485cd61@kernel.org>
In-Reply-To: <b375d36c-112e-4662-b538-fd10fa927ecc@bootlin.com>
References: <20260622143707.497198-1-ben.dooks@codethink.co.uk>
	<b375d36c-112e-4662-b538-fd10fa927ecc@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301835-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:ben.dooks@codethink.co.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[codethink.co.uk,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codethink.co.uk:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 725C66C25D2

On Mon, 22 Jun 2026 19:51:39 +0200 Maxime Chevallier wrote:
> Hi Ben,
>=20
> On 6/22/26 16:37, Ben Dooks wrote:
> > The print in ndesc_display_ring() sends the des2 and des3
> > to the pr_info() without passing them through the relevant
> > conversion to cpu order.
> >=20
> > Fix the (prototype) sparse warnings by using le32_to_cpu():
> > drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17: warning: incorr=
ect type in argument 6 (different base types)
> > drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    expected uns=
igned int
> > drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    got restrict=
ed __le32 [usertype] des2
> > drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17: warning: incorr=
ect type in argument 7 (different base types)
> > drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    expected uns=
igned int
> > drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    got restrict=
ed __le32 [usertype] des3
> >=20
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk> =20
>=20
> I agree on the principle, but this isn't a fix so this'll have to wait
> until net-next re-opens :)

Humpf, why are we not seeing this on x86 allmodconfig ? =F0=9F=A4=94=EF=B8=
=8F

$ make C=3D1 W=3D1 drivers/net/ethernet/stmicro/stmmac/norm_desc.o=20
  DESCEND objtool
  CC [M]  drivers/net/ethernet/stmicro/stmmac/norm_desc.o
  CHECK   drivers/net/ethernet/stmicro/stmmac/norm_desc.c
$

