Return-Path: <netdev+bounces-131873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8198FCAC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 06:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E60F1C209FB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 04:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A984962E;
	Fri,  4 Oct 2024 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="FS2e6Ay3";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZsHChlBT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jj1k5W3V"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE6777117;
	Fri,  4 Oct 2024 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728015148; cv=none; b=B5E+3JmX9QM+KrbzWBfoovn4Y8KThMCIBsRXmQdcwHkqoWqRdU4wdpcM9cJGQxgqKzdYCodi8WuR0V3m3jfgPVXXxyBZvVUYDZpel02AY/FsjMMxRqjQJC5YBvqOmc852yJRaKy9dJzaVN62+feTr9mevqhm+JvjMYsrpmfVSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728015148; c=relaxed/simple;
	bh=B31Mkons8hVN2qdjdVwaCtXp3RZ+4hvJnET2H9fYdTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEKj3JtIBc/QuxRY0F2YGWpj8XfguW2aljrZncTVebe1EcQfX0oy7+VbgtYzvuKYeoQycy81ICLSdgh/Jw3xfqAAObIav/2oznOQtFA9IxWE8K2hAFMY0NtHR4h++fOxpN6ptuyJqwKq4km8HL+7vqCaZ4YyF6kUm6bn46sJ5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=FS2e6Ay3; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZsHChlBT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jj1k5W3V; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6BA961140247;
	Fri,  4 Oct 2024 00:12:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 04 Oct 2024 00:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1728015145;
	 x=1728101545; bh=2r0rT23pyzNvoOWF6CsSNG48Bqqp/sBTZE4ykZf73TU=; b=
	FS2e6Ay3HakOihowwEJmVA8rqoWmujXjhK26yKtc3sCRU2fW/r2tEWKrui3iOI28
	1e1LNeRMbL4dqA1sWD5Yz2xeCkCxeuM1vNvfKqnqpI6fAsPA6SKiKoC9TFpqP6Ne
	3aJMqrZ/iSpA8rvgvDOAiZOCLoGCeXC1hqDTvfbFCks=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728015145; x=
	1728101545; bh=2r0rT23pyzNvoOWF6CsSNG48Bqqp/sBTZE4ykZf73TU=; b=Z
	sHChlBT5LqqF1a8iYCM7v/4L9pp5irAqV8mqdtblZ+5LWdytyUa/CuQoklHUeLdB
	t3OgPL8OxAycs/eV2ZDflHDpIsU27ooLXsW7CAMjOBh9HC0xjIuQfy2USRMHP0Hy
	4wrY0HcPg7jhnwvVtdJWhq3kXNsia3AzpxV26h9GCsojiJhaCjGBfWfj6AL9opb/
	0B5m7VP5oRexm3zmi+njtY8M8QPlOMGDTTIbo6Nee6cOEXkJG6p/dzZKiGjKWUa1
	hIBSOpZ2eJSiBVTIUmBInHDmrmMtQT5Kz7jRRn2RCKcmvgcsmjnMGJhareMtxmAS
	iYRWR3bBeLNYMXAQ2lOjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728015145; x=
	1728101545; bh=2r0rT23pyzNvoOWF6CsSNG48Bqqp/sBTZE4ykZf73TU=; b=J
	j1k5W3VZYkNyIe91rfVJtdfyOuixkix1cKG3dY0fKj0hPw3DDb1uxfd6YKexjZmV
	fiq4AtP1pUBO238Szv/OzEEbhN11F4y2iCDd2MUvpNyreT2QE3fXgI5j/ETm01xc
	syB+s6QOzEsipXog+DEVEA1nAvuiwQVGxpZV0aYsCXFxN8S1072PwyG53PrZscLr
	3g1XcuDDmlbC2JDOjl8dkchwBeiLpZpLCIuDIEM9Jaiql+ePn61UuVFPxQEDgPiy
	RpSdjteayEdEOI+DpuipdDX0PZ2kuN/mZVGJilWKMcohVnSag4r7QRKDorw9Yfcr
	xoPPoQpu60od3yZWUngSQ==
X-ME-Sender: <xms:KWv_ZnwfEv8hv7dyCGrs1gsPMCBHlft14cOaFox913clTBIpdnJPMg>
    <xme:KWv_ZvTrRrksm2F5sA1lqvGwimz0BpxXa2xl3K3Ob0PTnb0rymkZQ-2VENcrDXsmi
    LqrIu3motYQ7UTPsNU>
X-ME-Received: <xmr:KWv_ZhUHgK9diU1ZcD93gXo_vQH5624Xfdwfb7oxvh3ZFFw0YXIWnSO3OIDdMls2DtjZJSYjrxfqffeITqjL6bCj0jVkRUXtUcROYgABMZj5FCx57w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnh
    gvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeekudek
    feffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthho
    pedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhpihhtrhgvsegsrgihlh
    hisghrvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
    pdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhoghgvrhhqsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepghhrhihgohhrihhirdhsthhrrghshhhkohesthhirdgtohhmpdhrtghpthhtohep
    vhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KWv_ZhhOH8JXlQfv-xvsfo-L8Oq6t1DIAX4VR6I1vGQb4DWFALbxSQ>
    <xmx:KWv_ZpCU4dF1Zo0A-nszRXD7s5LIYc0aqY7bt5Lyix4-ZJcVYzuKtg>
    <xmx:KWv_ZqI9LF7g91Fb1I4hXxR4LtmgYbGLsCD77YNIPlpXsvPi_sosTQ>
    <xmx:KWv_ZoBbK5hJyCk_5-ZykpjB2dLoEam2ox5iWt5r5OEruYB8JXyYmQ>
    <xmx:KWv_ZuL8tC2A_yheYWstNhr1T5w0FW91lioSIAPwfOV9GEtqYCcj7GtG>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 00:12:24 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 2AF26E3D83C;
	Fri,  4 Oct 2024 00:12:24 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] net: ethernet: ti: am65-cpsw: prevent WARN_ON upon module removal
Date: Fri,  4 Oct 2024 00:10:33 -0400
Message-ID: <20241004041218.2809774-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004041218.2809774-1-nico@fluxnic.net>
References: <20241004041218.2809774-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

In am65_cpsw_nuss_remove(), move the call to am65_cpsw_unregister_devlink()
after am65_cpsw_nuss_cleanup_ndev() to avoid triggering the
WARN_ON(devlink_port->type != DEVLINK_PORT_TYPE_NOTSET) in
devl_port_unregister(). Makes it coherent with usage in
m65_cpsw_nuss_register_ndevs()'s cleanup path.

Fixes: 58356eb31d60 ("net: ti: am65-cpsw-nuss: Add devlink support")
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index cbe99017cb..f6bc8a4dc6 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3652,13 +3652,13 @@ static void am65_cpsw_nuss_remove(struct platform_device *pdev)
 		return;
 	}
 
-	am65_cpsw_unregister_devlink(common);
 	am65_cpsw_unregister_notifiers(common);
 
 	/* must unregister ndevs here because DD release_driver routine calls
 	 * dma_deconfigure(dev) before devres_release_all(dev)
 	 */
 	am65_cpsw_nuss_cleanup_ndev(common);
+	am65_cpsw_unregister_devlink(common);
 	am65_cpsw_nuss_phylink_cleanup(common);
 	am65_cpts_release(common->cpts);
 	am65_cpsw_disable_serdes_phy(common);
-- 
2.46.1


