Return-Path: <netdev+bounces-305597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UijAFCp1TWqe0QEAu9opvQ
	(envelope-from <netdev+bounces-305597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 23:52:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D552371FE2E
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 23:52:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wvLeRaoV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3PLKqf7t;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j3O4vwcz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="DvO/SAWd";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305597-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305597-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98FF2301C411
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 21:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A248097B;
	Tue,  7 Jul 2026 21:52:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239BB48034C
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 21:52:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461128; cv=none; b=XZ+dH2FNPr/9eofu343hYHGYwV1u+16fRi0spSdat8TFehcccJkcSP/qpH7mpT9zW6i2W4fqFAeJS+1Wz/YA49VezwGPHujLioi204oeFn7CyAjmI1WBRVPJuquBlUXhkTOExYtNkmQnvUhgPFMZqNd40F4CEsHY+7AQJS8gb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461128; c=relaxed/simple;
	bh=8mTkz4/P8ZSHKR6OML3GXFOVoaJs2VNGfzeEWySzUuE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=obykPNqIehUGulikc7mPcfuyFcIsXdm3TX+fUllBv3MwHQId2YuzSjWWgUOTjhqP2pcP3s6XU4o+Kini13Rl0qdDYdC2rvOs31r2yKfTBmXFA1CbukHxc/0tjRpeavs0d5ioKH2OG5LIU3R1sHPRTheHLcj6IC69TvaLBkIEdDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvLeRaoV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3PLKqf7t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j3O4vwcz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DvO/SAWd; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04F6075978
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 21:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783461125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=hipsIS3Xi+ag/5FVrs8Vn8eabaTZxhYogA2qLVQzoCE=;
	b=wvLeRaoV6UXSbSJmB3y+l7Zl81ej9SrrcJtsGAccOfwKInR3A6KxiNsuHptLKmyQh7DaeE
	4aIcvzprh1TSPOmCKhxToHsW2c4MhlpFb0Q+jLnSZzP3XJz9VmEmxiOlITWEMr0zczm8O9
	h70/DRSyfpcafs3u1at+T9R28z7QO5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783461125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=hipsIS3Xi+ag/5FVrs8Vn8eabaTZxhYogA2qLVQzoCE=;
	b=3PLKqf7tF/lM4TqViPczESQovlRtF9IlJEiLu6hWsfUnuV3AECB2qpH+mCh5cBLw+yK2RN
	OG/gWkkTP5zMldDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783461124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=hipsIS3Xi+ag/5FVrs8Vn8eabaTZxhYogA2qLVQzoCE=;
	b=j3O4vwczAAEdJ4xwOXdwwjtBcXtUnJRPsY+dAVirlhRQQskrhIrG3+TIwntrMaj9nuy8QP
	7UOp+Xs4TmBYwNwzxFIxLUXs0OpoF0IAqxde/Na+opw5TF8pWNbSUbaILuZ3Glv11wemWS
	5HTSGUM3crjqprmSLAOYSzM4/iD9Y+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783461124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=hipsIS3Xi+ag/5FVrs8Vn8eabaTZxhYogA2qLVQzoCE=;
	b=DvO/SAWd+L0UdaOeZrV6E21lqUUpEeypIu1vPSsZsS4fFafVDFzHeDsLAKM9FWyX2CUSKc
	2RsgezmVXhaAtcCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D221F779AE
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 21:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O2qGMAN1TWrtFQAAD6G6ig
	(envelope-from <mkubecek@suse.cz>)
	for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 21:52:03 +0000
Date: Tue, 7 Jul 2026 23:51:57 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Subject: ethtool 7.1 released
Message-ID: <bhfxnig4se5gbfjxwzzb6tt4jr6s3p5ydnzfgnqbyd7ggimfkr@lynnpitschmv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nk7lzkjjmqajpnap"
Content-Disposition: inline
X-Spam-Flag: NO
X-Spam-Score: -6.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305597-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER(0.00)[mkubecek@suse.cz,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkubecek@suse.cz,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.cz:from_mime,suse.cz:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D552371FE2E


--nk7lzkjjmqajpnap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 7.1 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link: https://www.kernel.org/pub/software/network/ethtool/ethtool-7.1.tar.xz

Release notes:
	* Feature: track TX pause storm events (-I -a)
	* Feature: update doc for ETHTOOL_PFC_PREVENTION_TOUT tunable
	* Feature: RX CQE coalescing params (-c, -C)
	* Feature: allow hex dump of all pages (-m)
	* Feature: qsfp: support newer SFF-8636 compliance codes (-m)
	* Feature: sfpid: support newer SFF-8636 compliance codes (-m)
	* Fix: document --disable-netlink in help output (-h)
	* Fix: add missing newlines in FEC output (--show-fec)
	* Fix: sfpid: fix 10G Base-ER module detection (-m)
	* Misc: clarify 10000baseCR link mode in man page

Michal

--nk7lzkjjmqajpnap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmpNdPkACgkQ538sG/LR
dpXEUwgAvZUaarfHYgPs0TAS3cA/uK8MSsv8GcShhae1EIddHtGmpdO4XWcYbjTl
/GGQZQQv8zaN62Ub5O1SfBbh7DonevS9tayk2BYdEdMAX+rNIRDSQc6k38g5+PcD
BcLJUVI24Xuzmy87EuMRG6RFRhWpbTine78F7UF4f5wxxg1lMPCSIU4D2i6ST4hN
7kl9bN7ppz2/3/fipLqEDmC8L25Cm7L3TNUDa6q+dMSKvRLfbzKqgX6ZlqEr9KPE
0sH2ie/604jmxiBnIiut1Nnu3VNMrt3M7MwXfTrrzsKed/WOCLFFS4797Cix4D1V
RMpwqSGwgo8irYvDych3XrJ0BcDW6w==
=25VG
-----END PGP SIGNATURE-----

--nk7lzkjjmqajpnap--

