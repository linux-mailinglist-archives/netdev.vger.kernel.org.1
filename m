Return-Path: <netdev+bounces-97843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E448CD7C8
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4E3286370
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DADD125DE;
	Thu, 23 May 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MJ2PHart";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mGPtWeVj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MJ2PHart";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mGPtWeVj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9C7482
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479619; cv=none; b=SGH+c2g+6GKLuWLN2Pc1L7Q0bRjwlNp8a/8DbZVaVlRbZkfNhfK7lNyzmN/wV/pWaAo9j6LhhQBwFVkjW2Fz4JrZGnVuoh7o0HXTy03SZUTyn954NVd3Hx9KZODa+d5gY0B429fPvTiBdXwnmPUmKLL4zJiZtgIrt1VrM1F1txw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479619; c=relaxed/simple;
	bh=/3OKY20na3bNL4i2dzBRMRhFFBL0HsCX/sPr4/Q88Ik=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iY6IMALr+6sx6JPPOwSREMPkW3j/N5rwJeXKcqgjhxSZUjD2m6egszvh28KRCw9zh2ZT/+ShcynZnPCVlcrDjsPH3WET7o+ZmZB/9QD1AlrA+U2quw2gt8Wu9BpfnwdLtQGFoClcXOVL1VUHaP4OT3qtNJgehsMLdF1H4z/59rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MJ2PHart; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mGPtWeVj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MJ2PHart; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mGPtWeVj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6183F2225D
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716479615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HvggI/ARWFpKNg/6KcLHp4Wsa5cJ3gmNTpZKmsF3X/Y=;
	b=MJ2PHart5uBEGa1w0E1pGCDFErLmPM2ZwmnlrMZiHn1xMMi0UkuQgrL3esJSXhtD6nx+wX
	I6MoLnMwUT7nkNqLlzgPxgtSQTsBU6E+/J5UaWZT/zB60+8xdMvpyYznxTIs3cToR0YPFw
	EhlXlHQ1zCqNVKdzJ0mI4zDah2fA7qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716479615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HvggI/ARWFpKNg/6KcLHp4Wsa5cJ3gmNTpZKmsF3X/Y=;
	b=mGPtWeVj4nmWgDgJlaMfJVaptsh5WJ+9wSIBrrb8w5eaUIfx6MCeNlbnAManUxetLh1KtM
	dydoi5cker+AjcCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716479615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HvggI/ARWFpKNg/6KcLHp4Wsa5cJ3gmNTpZKmsF3X/Y=;
	b=MJ2PHart5uBEGa1w0E1pGCDFErLmPM2ZwmnlrMZiHn1xMMi0UkuQgrL3esJSXhtD6nx+wX
	I6MoLnMwUT7nkNqLlzgPxgtSQTsBU6E+/J5UaWZT/zB60+8xdMvpyYznxTIs3cToR0YPFw
	EhlXlHQ1zCqNVKdzJ0mI4zDah2fA7qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716479615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HvggI/ARWFpKNg/6KcLHp4Wsa5cJ3gmNTpZKmsF3X/Y=;
	b=mGPtWeVj4nmWgDgJlaMfJVaptsh5WJ+9wSIBrrb8w5eaUIfx6MCeNlbnAManUxetLh1KtM
	dydoi5cker+AjcCw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 4B48020131; Thu, 23 May 2024 17:53:35 +0200 (CEST)
Date: Thu, 23 May 2024 17:53:35 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Subject: ethtool 6.9 released
Message-ID: <jylgitumxz72a2hfzsujnwvxpkuzcw3wcwebodthtpvtkfgmlp@rfoix5dyh2bg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fb523oqqbfwmlde2"
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-4.58 / 50.00];
	SIGNED_PGP(-2.00)[];
	BAYES_HAM(-1.68)[93.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -4.58
X-Spam-Flag: NO


--fb523oqqbfwmlde2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 6.9 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link:
https://www.kernel.org/pub/software/network/ethtool/ethtool-6.9.tar.xz

Release notes:
	* Feature: support for rx-flow-hash gtp (-N)
	* Feature: support for RSS input transformation (-X)
	* Fix: typo in coalescing output (-c)
	* Fix: document all debugging flags in man page

Michal

--fb523oqqbfwmlde2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmZPZnoACgkQ538sG/LR
dpXyoQf/aEpq8zipFN/e8WlFjbE2MY047T+2SSpaKsV+S+xN4FL9l1R2DvUbjYni
2OfMAzu89PivC7ID83M4A+RLr/xqjrylvQzisbN2NDHdzF28nHHP2r7TsteizDAj
Wr3nRe2kqrEOigabtEvCBM8dMGbOw8yhoB64p3dtjTeDN1Bs/dgAxrBxQX2Y94iA
TiQzWKnNjenQt+DWqqVXB10dBO0pYVo+mhRlQevgqAlw971Axhvw683AsGZMs+rb
D/RHTYVMnSN13C0RhdkXxO4JPeuT5WsDekAUUbrrUT7WcGUYHEkgep1lcwuAEYGE
3UYF/7HGRB5EPwp35N3aH+dotvI22A==
=ZlIE
-----END PGP SIGNATURE-----

--fb523oqqbfwmlde2--

