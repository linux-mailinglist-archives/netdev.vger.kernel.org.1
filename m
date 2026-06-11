Return-Path: <netdev+bounces-298151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z3NkDNa8Kmr4vwMAu9opvQ
	(envelope-from <netdev+bounces-298151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:49:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E86B672742
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:49:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oo2h4jTa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298151-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298151-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 857CB31CB86B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FCE22A4E1;
	Thu, 11 Jun 2026 13:45:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B520DD51;
	Thu, 11 Jun 2026 13:45:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185540; cv=none; b=TF8qAxjAA0fBmOQaVWqtqFyrK1afu8kKC+RfOhaoUHl53j+QzlaQXDPfnLsRpIXrsDjn0ElUvMhRy2HeblEY55LtcGCCZzro5gZXsvA8Hvq3Q1CIjqQeLaOpVoSQHs1XtGewXW+kwr1iDxv33qTLjajCMACEThXIcashVPvLLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185540; c=relaxed/simple;
	bh=qudR4YOBjm4BjqJXpfuUPuDMGJQMgBi1fMXDfAiSiMw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=joegxpgYYmQh5wOVakTs3R5/DSBDsmAc1kt1xtxERcQhpMgrudHS1xD+OuNvGj5XAptkhf9GcrA0lA+og5Ve8XIOo5M1RxhjtDsqwci7A7QKa2L9KFNcbTwrLSYlqOBRjJg7mWLZUS2j8mWEbdQSiIYBh6oRwKvDjJJt4XOS13U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo2h4jTa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B5A1F00898;
	Thu, 11 Jun 2026 13:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781185539;
	bh=BWFiD8Jh2uypsKglnxEKkvz9+2QdqGDxExTLoDKZmv0=;
	h=Date:From:To:Cc:Subject;
	b=oo2h4jTa3cQgJUjJa/E+d/IY646O4T/wfsttMjPOCDfOvOTrRFsOBEgC0S6aSLKQ6
	 fm6rCOfaZvU/Rj6ExLoWNE9RQ0XGKMjYFCaxDnNAw2wg2JeRC1LWETXoItVK+5PkKm
	 +dPQcBBq48FHhkJ+z/jTfHx8TZIxaE91qHZNu60K6OXu8UBwg48mHFQBtgfCsmvZUD
	 WwzfHkcxA5daXolVB6uedJqWZx5Slt8qkiRRjBYDclgnStaG/Buhws6zzc1SuRzhZ+
	 8HC5gWHYsfTaK5WF5I9HZKj9DGNh0hJkebs0xt47SmJn7hqLVbR+WK+mgoSQEwGDbb
	 YYNgKPfKmha0w==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id CA6361AC56C6; Thu, 11 Jun 2026 14:45:36 +0100 (BST)
Date: Thu, 11 Jun 2026 14:45:36 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <aiq8AHf4_SythYxR@sirena.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CjMwuXzXB/ALh7bF"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298151-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sirena.co.uk:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E86B672742


--CjMwuXzXB/ALh7bF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c

between commit:

  f2df54ddbfb04a ("net: txgbe: distinguish module types by checking identif=
ier")

=66rom the net tree and commit:

  f67aead16e85f7 ("net: txgbe: rework service event handling")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 8fc32df8e49a44,72712cee1ab834..00000000000000
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@@ -186,25 -186,21 +186,21 @@@ static void txgbe_get_mac_link(struct w
  		*speed =3D SPEED_UNKNOWN;
  }
 =20
- int txgbe_set_phy_link(struct wx *wx)
+ void txgbe_set_phy_link(struct wx *wx)
  {
  	int speed, autoneg, duplex, err;
 =20
  	txgbe_get_link_capabilities(wx, &speed, &autoneg, &duplex);
 =20
  	err =3D txgbe_set_phy_link_hostif(wx, speed, autoneg, duplex);
- 	if (err) {
+ 	if (err)
  		wx_err(wx, "Failed to setup link\n");
- 		return err;
- 	}
-=20
- 	return 0;
  }
 =20
  static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
  {
  	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) =3D { 0, };
 -	DECLARE_PHY_INTERFACE_MASK(interfaces);
 +	DECLARE_PHY_INTERFACE_MASK_ZERO(interfaces);
  	struct txgbe *txgbe =3D wx->priv;
 =20
  	if (id->cable_tech & TXGBE_SFF_DA_PASSIVE_CABLE) {
@@@ -271,7 -267,7 +267,7 @@@
  static int txgbe_qsfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
  {
  	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) =3D { 0, };
 -	DECLARE_PHY_INTERFACE_MASK(interfaces);
 +	DECLARE_PHY_INTERFACE_MASK_ZERO(interfaces);
  	struct txgbe *txgbe =3D wx->priv;
 =20
  	if (id->transceiver_type & TXGBE_SFF_ETHERNET_40G_CR4) {
@@@ -335,7 -331,7 +331,7 @@@
 =20
  int txgbe_identify_module(struct wx *wx)
  {
 -	struct txgbe_hic_get_module_info buffer;
 +	struct txgbe_hic_get_module_info buffer =3D { 0 };
  	struct txgbe_sff_id *id;
  	int err =3D 0;
  	u32 mod_abs;
@@@ -357,16 -353,18 +353,16 @@@
  	}
 =20
  	id =3D &buffer.id;
 -	if (id->identifier !=3D TXGBE_SFF_IDENTIFIER_SFP &&
 -	    id->identifier !=3D TXGBE_SFF_IDENTIFIER_QSFP &&
 -	    id->identifier !=3D TXGBE_SFF_IDENTIFIER_QSFP_PLUS &&
 -	    id->identifier !=3D TXGBE_SFF_IDENTIFIER_QSFP28) {
 -		wx_err(wx, "Invalid module\n");
 -		return -EINVAL;
 -	}
 -
 -	if (id->transceiver_type =3D=3D 0xFF)
 +	if (id->identifier =3D=3D TXGBE_SFF_IDENTIFIER_SFP)
  		return txgbe_sfp_to_linkmodes(wx, id);
 =20
 -	return txgbe_qsfp_to_linkmodes(wx, id);
 +	if (id->identifier =3D=3D TXGBE_SFF_IDENTIFIER_QSFP ||
 +	    id->identifier =3D=3D TXGBE_SFF_IDENTIFIER_QSFP_PLUS ||
 +	    id->identifier =3D=3D TXGBE_SFF_IDENTIFIER_QSFP28)
 +		return txgbe_qsfp_to_linkmodes(wx, id);
 +
 +	wx_err(wx, "Invalid module\n");
 +	return -EINVAL;
  }
 =20
  void txgbe_setup_link(struct wx *wx)
@@@ -519,6 -517,7 +515,7 @@@ int txgbe_phylink_init_aml(struct txgb
  	err =3D phylink_set_fixed_link(phylink, &state);
  	if (err) {
  		wx_err(wx, "Failed to set fixed link\n");
+ 		phylink_destroy(phylink);
  		return err;
  	}
 =20

--CjMwuXzXB/ALh7bF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoqvAAACgkQJNaLcl1U
h9Catwf/WNKXkugbbavvlvBd5Ln993Appm77Ur2DmtvQLVxj8zVGNQwF8JD3P2RU
tlNvLVfywV8gbCsyhVprYoNDQcB/zI1iUL1nUo3fBwdV0Ycnb77XvFgNVvy+KwBu
qnQxHoxp2Z34iWa0qPs1zjc+XCUm6QM8kHwfZNBod6U/mTO3yzD+z7NxLQRYCnQC
b4y3UCekkYPmnKwq8vU6uWmQaj3n4Qy5NS1N76OebffkpvG6Hrp6QlVFCF2QHS91
RzHFPTJ4IiimznNIj+R/z7AfuQ6ePRp57737I2sN9ezkiDpqGZM6YKqLSunvXev/
wncQVWVuGbY5ac8YDIKjg1DeKZVI7g==
=dgus
-----END PGP SIGNATURE-----

--CjMwuXzXB/ALh7bF--

