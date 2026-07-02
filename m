Return-Path: <netdev+bounces-304225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zjNxKjWFRmoaXwsAu9opvQ
	(envelope-from <netdev+bounces-304225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:35:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 117146F97B5
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:35:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="QtkK/2ff";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304225-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304225-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 311133008E28
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C037A852;
	Thu,  2 Jul 2026 15:33:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40144353A63;
	Thu,  2 Jul 2026 15:33:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006439; cv=none; b=HtMNBBoPYWEJa5s17E0QrvbhpPIhqmbO0Nej75kbpO9ZZL10ffNSH0z0AJw0QHqBuqchdy+VjQ8wQFUdwUTfeBfwE/NxWlZHVD6UBDPzVmC/qiq/+INCD05rNxQzlxZORcB2ZsvYFzwguKjQ8B96GbZwkJdjmFcNE2QHkMV/Ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006439; c=relaxed/simple;
	bh=8J7w6KtvUb8J1E7AFJuEuF9F19XQEBruHwij1pMuyQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AXmlVpxyvx0ip8f3ulfvpOpMd0nU6DdGoKR3+WpjNPBq2hIqlU5dPa0+gRL2pJ99Ed6p72IFPJVzNbvHh7yPrtXv7CD7kbh3Ahe8RTNvfr0ysNjJb8FCa2rqS3F/HfdJJYdwkZCXmKJxDBXr5KraRSdLb/R3DVGaQiKiC1SP9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtkK/2ff; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62C41F000E9;
	Thu,  2 Jul 2026 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006437;
	bh=51rouF56EmU1j9L8gb1If6ofMiucZZpjzo+NCXwNTJw=;
	h=Date:From:To:Cc:Subject;
	b=QtkK/2ffNtrEZJFd/RL+k7BkglsnSrZMu4Ab9zAfyDzxoRt9EYyKBUpc0Mz1+Q5v3
	 Ng/ApS9bP44iUSP4e/Ty+xu5pEGJ+SV6mgbly9LA8Qk01uIA3RceGiLSMRAjEYM5c4
	 vuJWX0j0pCMAED4QXGE30pd/Bx4D09/3y+QqfX32wYV0nhFansq8QojwPJ2Pcbs69V
	 9wkSJ2vK/9L+IaXrmcGGU43oT58PuUik1F04lb+l3nUHa1INZhF1G0t7urSypJ2Q0R
	 32xWBXHgkWvAkY3eYI8r3zBSKscG4nOsxmhpbPBQqgUZe7yNrP/aCn8+vAj6gPs9as
	 5nEjUkZKSXHgQ==
Date: Thu, 2 Jul 2026 16:33:53 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	David Christensen <drc@linux.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: linux-next: manual merge of the net-next tree with the vfs-brauner
 tree
Message-ID: <akaE4dbtwZthgqJc@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ifnVYB9nS3UqU3Vx"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304225-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:brauner@kernel.org,m:drc@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,m:willy@infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,aeschi.ch.eu.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 117146F97B5


--ifnVYB9nS3UqU3Vx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  MAINTAINERS

between commit:

  969076f31bf63 ("efs: Remove EFS")

=66rom the vfs-brauner tree and commit:

  eb56577ae9a5a ("ehea: remove the ehea driver")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc MAINTAINERS
index 801a4809b918a,ee4ee7b8e9470..0000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -9495,11 -9493,11 +9495,6 @@@ L:	linux-fbdev@vger.kernel.or
  S:	Maintained
  F:	drivers/video/fbdev/efifb.c
 =20
- EHEA (IBM pSeries eHEA 10Gb ethernet adapter) DRIVER
- L:	netdev@vger.kernel.org
 -EFS FILESYSTEM
--S:	Orphan
- F:	drivers/net/ethernet/ibm/ehea/
 -W:	http://aeschi.ch.eu.org/efs/
 -F:	fs/efs/
--
  ELM327 CAN NETWORK DRIVER
  M:	Max Staudt <max@enpas.org>
  L:	linux-can@vger.kernel.org

--ifnVYB9nS3UqU3Vx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpGhOAACgkQJNaLcl1U
h9AwDAgAhD92WOcGeyi+KeFhancmA8auGHar+qpwCDfZkJFTgIuggEKbGA0jkcum
4YrhDI1QqySzpxs58wiutqF/mU4BUl8pjcQfXQzuKcgqHWH+lG4LCe3uVjQ34L+4
dqjKb6kGtt8ZnltOVuWQHcUfZWYmyK5fa2Q/IZuMyzgiJRAPKNK3gu7QTMVz7drl
YS526zmQjWB+L4XAH51aQiiGHHp9arvmtvtpGYTSNhu3Wsj/3lwUgiFmABBs2Oi2
NXghZO3+HIOIw3+BmiF0cED927o+y2sEudnjY6XxT01vVxJNEUC7vIY+2EIYoN3y
D2HB8pgPxWHe//VY7htjlJ8ILrETAQ==
=UVzZ
-----END PGP SIGNATURE-----

--ifnVYB9nS3UqU3Vx--

