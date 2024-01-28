Return-Path: <netdev+bounces-66547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D183FB1B
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 00:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9622814F1
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 23:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E087642041;
	Sun, 28 Jan 2024 23:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2VcMqb+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8jtcvdht";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2VcMqb+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8jtcvdht"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90184594F
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706486203; cv=none; b=VLwTz/UZNSjSjEKu3057oxPuVT7Rp4FNvjyOw3uxg2mSGgakWslez+6Gl6KA9uAtTJKHry9sj+dKzuCBUPcTj+upxHZ5Jitm89+mZpbgxJALrABTTub8850crgX3xmE1CnDsz8PpNb56Gfn7Qq6pHtp+rkAxMDXEY0l0u1m/580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706486203; c=relaxed/simple;
	bh=2ECCXTAJ55VWtcSuAwrprAQEzOk+7D6EzBB9EfSQjag=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Uf8K0fQbNnx016OUsLvBK6QLrXI+0p69w7yxsp3AUaMAMz1udAjJyk9NUCWqYmnULJYYCQ5QHrJiWRyvSUCgL9lJClAIuBGq2KR9ODvs2K/wegrFiRVEDptNO2rf9GC+/aqgWvyKmSg+vCtvTnukJr8c4oMiLOO3fpWzqeEeQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2VcMqb+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8jtcvdht; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2VcMqb+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8jtcvdht; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38B692226F
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 23:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706486194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=zSzoOXOEbDwOCimPBtF9mraEKSNi9L55GgPCJ9MHHiw=;
	b=2VcMqb+gR+73PxPYeK1oySwLdEpl5Nmssh3MXeb3/C7uFsifj3cuzYfiQDR/V6tvRgZzwb
	d5X7B7G1VImifiYqcmo6X3DtQGjaEMx3xjadhIhwRyn0Fo99An+XsyOV1yDSxkQXC7VuCk
	7WPxKKhOmELW7W3VLjU7lH0C9FBQt7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706486194;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=zSzoOXOEbDwOCimPBtF9mraEKSNi9L55GgPCJ9MHHiw=;
	b=8jtcvdhtM0X/Y0ACPVJaFA9EKYZDTrQBmisc0wU+JVOVjBxW/d9Qk8gN1wI/EfuedxPuh5
	RaigO0APUqsN+9BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706486194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=zSzoOXOEbDwOCimPBtF9mraEKSNi9L55GgPCJ9MHHiw=;
	b=2VcMqb+gR+73PxPYeK1oySwLdEpl5Nmssh3MXeb3/C7uFsifj3cuzYfiQDR/V6tvRgZzwb
	d5X7B7G1VImifiYqcmo6X3DtQGjaEMx3xjadhIhwRyn0Fo99An+XsyOV1yDSxkQXC7VuCk
	7WPxKKhOmELW7W3VLjU7lH0C9FBQt7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706486194;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=zSzoOXOEbDwOCimPBtF9mraEKSNi9L55GgPCJ9MHHiw=;
	b=8jtcvdhtM0X/Y0ACPVJaFA9EKYZDTrQBmisc0wU+JVOVjBxW/d9Qk8gN1wI/EfuedxPuh5
	RaigO0APUqsN+9BQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 2200120147; Mon, 29 Jan 2024 00:56:34 +0100 (CET)
Date: Mon, 29 Jan 2024 00:56:34 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Subject: ethtool 6.7 released
Message-ID: <20240128235634.4ni2lbvzqjlwbgi4@lion.mk-sys.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y2pzb4b25ysjyufs"
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.95
X-Spamd-Result: default: False [-0.95 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 TO_DN_NONE(0.00)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.01)[-0.030];
	 NEURAL_SPAM_LONG(2.36)[0.674];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-1.10)[88.20%]
X-Spam-Flag: NO


--y2pzb4b25ysjyufs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 6.7 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link:
https://www.kernel.org/pub/software/network/ethtool/ethtool-6.7.tar.xz

Release notes:
	* Feature: support for setting TCP data split
	* Fix: fix new gcc14 warning
	* Fix: fix SFF-8472 transceiver module identification (-m)
	* Misc: code cleanup

Michal

--y2pzb4b25ysjyufs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmW26a4ACgkQ538sG/LR
dpXEjggArsjxZ7j3Agn3NIhcQw11Nf7hM4SVp9Avm+hwfVbKM4suPEhqHYKMEF/u
yg+H6e5V7BGOvW4agUFbQRBBEGWYkGOvpWQIcaogN5acT+oFP0gIm0uIGDP3Tjyc
Cflhsh4SHo8AwC/8PRhhvjfeg5CLwHGfZmWey+tnQxW/dJWODjg+USZWwhGFuVqw
aUyUOZN2yBz2+7K0eJHz+nVibSq/VxfoVUeXq9OD9e1xTp8TRmfx2BPNyAVupD0T
03h+HVSl+AvqJbEd19H91LXanAq4EkWcllvQ3x/mzyYCjqA8M7s9z46+JQfg1yqd
/1r9HNdYzsIIUiDQPzDCNwuDZoBhUw==
=YuDG
-----END PGP SIGNATURE-----

--y2pzb4b25ysjyufs--

