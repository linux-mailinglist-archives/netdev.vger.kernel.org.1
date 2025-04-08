Return-Path: <netdev+bounces-180058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4809BA7F5C8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8FD3ACF59
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F8E218821;
	Tue,  8 Apr 2025 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xin0VCS9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GhWVs7fC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xin0VCS9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GhWVs7fC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376BA17993
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744096656; cv=none; b=qgG80m39eJ6qIMm0eud2SNcNBXEoG7u/uiZAA+Arwo7ZO2z3TB/c3Y7KXgbOgtdzouVwgRoTyFv1FH7q71DOShzR8XxutB0667bSmSe1qDSP5oTaJhX//khKe22ng5w03FhVGn6BM8CQgSU1D6OMH5NDMdUHH1ZBAy9I03azDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744096656; c=relaxed/simple;
	bh=QTdoIvmkOxDamRIzJFhASzWqZdupOM6TwgIjCzmESSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e0FqGQsbednsWUb9eGIlz8Zq2nT1S8nL8RYmZqbpKJGCxQnFK5aO7TXHUxp1uMHLxgM4Va+fDOObI8r8uD7qQaueXtl27R3GU7o0w9jctV0vY6w7b6YO1ep3lMd8Ghfh9NtuqdNq6E/AdPP2j4v/s6YwiaPqOOCqqge/sEzr3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xin0VCS9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GhWVs7fC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xin0VCS9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GhWVs7fC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 528522117F;
	Tue,  8 Apr 2025 07:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744096653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ht+9V9yO8Ri8H6Blkr5Rk308TLOG7JdKgPss3qBgN5Y=;
	b=Xin0VCS9ubMoxHl1pwuOq3iVmvkWRZsDeAAwrJl0JwsDtffGi6y2lLa8WNumS6Wgv4VSKV
	6ZqwnZ4hWP2c5sfXvXwG6DOqeAbR0xrxVciHkbbH2j5smnKm1hl0fQwVxwvTo4QdjZKDFY
	OCwJnth+GHi40FUQYrTDdWti2+7W+IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744096653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ht+9V9yO8Ri8H6Blkr5Rk308TLOG7JdKgPss3qBgN5Y=;
	b=GhWVs7fCcloNL68KmMCkz+99YSJux84uVKC+GoniCCee3mZfJeIqQVSarMOhzwuDAMLtND
	5F16G2S5fDzpYNAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744096653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ht+9V9yO8Ri8H6Blkr5Rk308TLOG7JdKgPss3qBgN5Y=;
	b=Xin0VCS9ubMoxHl1pwuOq3iVmvkWRZsDeAAwrJl0JwsDtffGi6y2lLa8WNumS6Wgv4VSKV
	6ZqwnZ4hWP2c5sfXvXwG6DOqeAbR0xrxVciHkbbH2j5smnKm1hl0fQwVxwvTo4QdjZKDFY
	OCwJnth+GHi40FUQYrTDdWti2+7W+IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744096653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ht+9V9yO8Ri8H6Blkr5Rk308TLOG7JdKgPss3qBgN5Y=;
	b=GhWVs7fCcloNL68KmMCkz+99YSJux84uVKC+GoniCCee3mZfJeIqQVSarMOhzwuDAMLtND
	5F16G2S5fDzpYNAw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 40DFB20057; Tue,  8 Apr 2025 09:17:33 +0200 (CEST)
Date: Tue, 8 Apr 2025 09:17:33 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: ethtool 6.14 released
Message-ID: <ltlaedje4eys37rgc2y44pvn6vbohbtjr37eq32vqlisphtrlq@g4dnwkeclpuo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k7kacctjhrldny7x"
Content-Disposition: inline
X-Spam-Score: -4.25
X-Spamd-Result: default: False [-4.25 / 50.00];
	SIGNED_PGP(-2.00)[];
	BAYES_HAM(-1.35)[90.52%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 


--k7kacctjhrldny7x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 6.14 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link:
https://www.kernel.org/pub/software/network/ethtool/ethtool-6.14.tar.xz

Release notes:
	* Feature: list PHYs (--show-phys)
	* Feature: target a specific PHY with some commands (--phy)
	* Feature: more attributes for C33 PSE (--show-pse, --set-pse)
	* Feature: source information for cable tests (--cable-test[-tdr])
	* Feature: JSON output for module info (-m)
	* Feature: misc RSS hash info improvements (-x)
	* Feature: tsinfo hwtstamp provider (--{get,set}-hwtimestamp-cfg)
	* Fix: fix wrong auto-negotiation state (no option)
	* Fix: more explicit RSS context action (-n)
	* Fix: print PHY address as decimal (no option)
	* Fix: fix return value on flow hashing error (-N)
	* Fix: fix JSON output for IRQ coalescing
	* Fix: fix MDI-X info output (no option)
	* Misc: code cleanup in module parsers
	* Misc: provide module_info JSON schema
	* Misc: add '-j' alias for --json
	* Misc: provide AppStream metainfo XML
	* Misc: update message descriptions for debugging output

Michal

--k7kacctjhrldny7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmf0zYgACgkQ538sG/LR
dpV6vAf9Hn4t9pS/CPyehqUR/J4O/zTAO6fCszXwhKtbL0N6lmNJFIDKXrMXjDCY
4SUzHuL7PmduIRz2fgsazUfajiRlTJmIwMC6BmVR6AuYbTQNPzI18aotfKDqvVpd
JyZolDVPT4mxYnuOeee/ACJXaQ2aa4li4tsw2YqZKB9VLw4cN09grZ4XsSp//sOn
EDym5LBrnseM8ZTDk7rj37F8JzxBgXb9KmRbLWD+Nu+DHWmaJMiKEYsRbTPrYFfg
vu1TBmE9mWIBKiEjSPlfLWfD+b73ixqGmZ0xAbQMK2cCUIXW4CQzf+7WJDB/LeiB
M7HQXnWaRb0fp14gW4S/tRXxqegp9w==
=c1Ix
-----END PGP SIGNATURE-----

--k7kacctjhrldny7x--

