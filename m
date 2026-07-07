Return-Path: <netdev+bounces-305524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OLyoFhAlTWozvwEAu9opvQ
	(envelope-from <netdev+bounces-305524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:10:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95571DB29
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:10:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jk9WV1lS;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305524-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305524-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFA8930146B2
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D957430CFC;
	Tue,  7 Jul 2026 16:08:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A983DC4A0;
	Tue,  7 Jul 2026 16:08:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440534; cv=none; b=s62LW5rNo1hZDyNRrVIfLUwVvsSYMQ9bUkVt/JoF9CwvxpiUS3NB680EkByCUOU744R0hh9uDwsH4TTZrR3HzRdMsDH+tQ6KCyDXGVGzUUJkCx3GtlNhskiCns7XYWFf46b4dtbGKU/J34QFPU9lGn3aYVLn0uOxmY+inYprw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440534; c=relaxed/simple;
	bh=xtHMEG1TCejI8D4pEoh7MRQLg5UbMQHhYQUdiHQHI3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIGnKRVHI2kjIc/PjrUXlqUCCgC5RPaEDMJf6GwYxm7tfV6z2sfqE3GCwhWZmvYeWletH7ooCAoXEE1WuRsrqFDYkm1P5RWBy4xBfKVQUFoZKOJ6YKOrC3s8x8VAMFH9RsZ2oDS7TC6yw0VYZsViWSfxYfKWhIObkLDihhPejhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk9WV1lS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640491F000E9;
	Tue,  7 Jul 2026 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783440533;
	bh=xtHMEG1TCejI8D4pEoh7MRQLg5UbMQHhYQUdiHQHI3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jk9WV1lS6vKOQaZZbkVIjbi/Ew2VREc4kAnJoUPb7NkCB85HnllzL5Ra0XyuRKQ1/
	 CVg/6rPW0AAjyNUq17snGujS0X8Ot+xQWqhdM7f8e0AHWx/BberVp1t4ydXlXJYTCh
	 CsBmaWELwJ18mqbcY6Wsvz7tfzhBRx3VCixAPWOANcUDJkh3n+6Kcm2Blvppq5njXR
	 FzNoWstQnv44+lDVAUQx48fS4949T2qsc8605vQfMXTqsZscWL18Av++X1G7azR8Tv
	 8Rc+CBVgv8I5Ra1HY5MD9fK+YtU3mKi//17qZkSXXoYzQXhPkVhtposnj8atD6lXjd
	 eGP0NQvu7/MWA==
Date: Tue, 7 Jul 2026 17:08:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: nfc: samsung,s3fwrn5:
 add S3NRN4V and clk-req-gpios
Message-ID: <20260707-purr-pucker-b9e8dd8dc9c0@spud>
References: <20260705190621.128257-1-jorijnvdgraaf@catcrafts.net>
 <20260705190621.128257-2-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22Mwl49F0l+F6eKI"
Content-Disposition: inline
In-Reply-To: <20260705190621.128257-2-jorijnvdgraaf@catcrafts.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:jorijnvdgraaf@catcrafts.net,m:krzk@kernel.org,m:david@ixit.cz,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:conor+dt@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305524-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,spud:mid,microchip.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD95571DB29

--22Mwl49F0l+F6eKI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--22Mwl49F0l+F6eKI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak0kkAAKCRB4tDGHoIJi
0hLiAQCalXgHa4e8d6O5afFL59JI421HoDHDPn7f0Z/b2dxWGgD/XW0WuSId5uve
i4mcqO4b3vUScmWctGMq9EeyXOODxwo=
=gEEu
-----END PGP SIGNATURE-----

--22Mwl49F0l+F6eKI--

