Return-Path: <netdev+bounces-144050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E635B9C5626
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF4228C892
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D4722460D;
	Tue, 12 Nov 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="drEJllAw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKGw3kQD"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C0215038;
	Tue, 12 Nov 2024 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408956; cv=none; b=sSKyh4+QwMvJkaFFfoA7YgFpY4g00eIbZM+zvK3gpko8VtgxaD3NMG28098hmMc4hRYKWhDmlaBICAB/+LqmH1JKdIift9lNCiHX3g7DdBmyLgs1sRix8N55kh15IvHuBOaT08hWt1COK3s4AiBBMJ89smq0vR8c9Sb98J8AFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408956; c=relaxed/simple;
	bh=/0Cf1a5yIfHywCfB6n9mecjUfSbhNZKyuEH7CWiT2cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQriKwyqfxpHFMJ5qEctS9JnDo0pZ/Y2I5N2ylD5Dgdufm3vND3XFSyuwXvg6f7fMVtbsKIHnjuDe9RPSP8070yBWeLJpmSWQekjr5ktrYuWhomjAvhq2aORfta1WalbtzqBd7M3K0iQxuqvWhe0i7cujX2ap6E1qTS83IYTR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=drEJllAw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LKGw3kQD; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 65C0B2540150;
	Tue, 12 Nov 2024 05:55:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 05:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1731408952; x=1731495352; bh=HmzwMlBWFw
	m21e1s6L71Z2FjShDjZvh1v3y1PTdDnbg=; b=drEJllAwZeqbTChnOLK8gjAdfn
	xXvFRhFgoN4t5P8U+MKbzpNn/y87IQUJEeT4H6CAsxqV98hkFl8KUicECALoLLt6
	qJwbzjJNS6t8adePK+YbqFznFXWfT2/Ag6IWQm9BZ7uVV2SqHTpDVQGM1c410pZU
	w1JfuO2WttN9fIm84LnWvnh/keOBI2jZvZIl00+E8oGrVdZBDm2X/HHtcrIXhBxs
	/2IEiETLbJFtFxL0kEXMltPiDpVhS4HhAAMvlylOmQBx1xYKm30AK5HfS94VUzYD
	sPAN7OOKSR7CiXROW/rhfxIA1xR84uz4HM3N+elZKRPexBvErpg1TlIuY8Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731408952; x=1731495352; bh=HmzwMlBWFwm21e1s6L71Z2FjShDjZvh1v3y
	1PTdDnbg=; b=LKGw3kQDBipsVdFQ5wMEpAcQCLQoqNpOgG+sO5NQ4zQ3HeYK/6i
	1lpcD/2K4q0R5RhqJq4wl+PRKnmD4dQla7RVn9frXeygWhLamgi+fkmlbVS0cRx8
	gscf4KxKceZTVGzbqx5Rke6VMT1uWX3Q2uPMUarRrCXBD8qtvLDLNteQ2ea7TkPO
	GMySxHrP9XKduC6LZ/p8kKkUvkqBqz+wpR8POKx2Uoykk9/vW+qfVcdueZlHE+yw
	IyTymuXe9X9lOL38pUTH12teSMCy19fQs2l8p0KfBAePsRQxE2dLEtkEq0/zoSas
	EMS5P6lmCxZbv8bbLOtcTvk9OF21lP9yG+g==
X-ME-Sender: <xms:NzQzZ089Fqg0VgF69gUi8YzOWzpZMf7dMEJ2FsUMBXGzvBkieZf6oQ>
    <xme:NzQzZ8swV9t1exiJ3au1rFzXWNJGuxolzZYW3hv68yTgDg9xUrRDHyxEzRRzT_mEK
    RvLf737L_F-5bu41fo>
X-ME-Received: <xmr:NzQzZ6CAeraNCDZ6zNjj0R7xDoDJtwRmlHtmGD6utTJDBZ1LKAjER15ESDsgTLmsGran-2qpg9Bp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhs
    uceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrh
    hnpeegheejueehgeekjeffjeehhfejieelfeduudfhgeetieegueehvdeftefhgffhtden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhish
    htrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegr
    nhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrlhhishhtrghirhdvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishesfigutgdr
    tghomh
X-ME-Proxy: <xmx:NzQzZ0fwG1o3KNzHBKedhU3mqMnwKrXxTfpFuM6NzY-g1QwrLy6r_A>
    <xmx:NzQzZ5PcfMfI9t5B21ZyXTVs6gozguQzVw3Jp-sKVAl08OHSvDubqA>
    <xmx:NzQzZ-mYwHBuu_V3peiskB0AxH1C3DlTAKlWYeNOU0FS-pF1slmEEw>
    <xmx:NzQzZ7sCzIKjsq5TH-sX7mNvbEfARmJhzcRflgpXSy756XWLXjf5tw>
    <xmx:ODQzZ8eD6o3TqXKriidLJ5UhW073HBqy_xxhzDpbAoupBRGya4GLuLGI>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 05:55:49 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	andrew@lunn.ch,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/2] include: mdio: Remove mdio45_ethtool_gset()
Date: Tue, 12 Nov 2024 20:54:29 +1000
Message-ID: <20241112105430.438491-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

mdio45_ethtool_gset() is never called, so let's remove it.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/linux/mdio.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index efeca5bd7600..c63f43645d50 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -173,22 +173,6 @@ mdio45_ethtool_ksettings_get_npage(const struct mdio_if_info *mdio,
 				   struct ethtool_link_ksettings *cmd,
 				   u32 npage_adv, u32 npage_lpa);
 
-/**
- * mdio45_ethtool_gset - get settings for ETHTOOL_GSET
- * @mdio: MDIO interface
- * @ecmd: Ethtool request structure
- *
- * Since the CSRs for auto-negotiation using next pages are not fully
- * standardised, this function does not attempt to decode them.  Use
- * mdio45_ethtool_gset_npage() to specify advertisement bits from next
- * pages.
- */
-static inline void mdio45_ethtool_gset(const struct mdio_if_info *mdio,
-				       struct ethtool_cmd *ecmd)
-{
-	mdio45_ethtool_gset_npage(mdio, ecmd, 0, 0);
-}
-
 /**
  * mdio45_ethtool_ksettings_get - get settings for ETHTOOL_GLINKSETTINGS
  * @mdio: MDIO interface
-- 
2.47.0


