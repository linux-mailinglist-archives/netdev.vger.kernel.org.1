Return-Path: <netdev+bounces-298068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JNs9CV+MKmrIsAMAu9opvQ
	(envelope-from <netdev+bounces-298068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:22:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5E670CF1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:22:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b=KGuVgiYi;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=JplgW21Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298068-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298068-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45E5030639C6
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA103CBE6D;
	Thu, 11 Jun 2026 10:21:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AD03BED16
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:21:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173310; cv=none; b=ZNZDbKbJ7utvP2gghnc2fWPw27cusQew/ziauKscV4bRpbclBBLPxDuvhyDzmBNU8kWn1ccWK7qSonGpq1K9HiJJ45qVkQX5fhEnBafRIIjnWXRgLj2mcFsCYWJ/7LfZHPdOEw+FOX2k9uo29tFjEOpZKWT0YZd4zeAImYcqHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173310; c=relaxed/simple;
	bh=5Fh3yUSWla2teZsx66gS0mlwXAjX6SCuBxt9JxpEbjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWM61n/jsipXDKOYiVk3Z9puK7iY/Rd6059Vu7sq49S3TYdy7CHX0HAklz3s9bq0N3aElP0wQTZ4GSFM3d0qt0HhYwh+daXQvYYg+L0GKPY6AfkmftU3z5ts7Q2K7wJRSBmS4TAKSmMXKCz3ZHtKy5b0BxurEDVmvcFeJ/zhi4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=KGuVgiYi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JplgW21Z; arc=none smtp.client-ip=103.168.172.155
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1615140006E;
	Thu, 11 Jun 2026 06:21:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 11 Jun 2026 06:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1781173299; x=1781259699; bh=b4gkn/olpJ
	ZtE2RQ3fsTwoC8R5UsHu9KBFtdrdo8OHs=; b=KGuVgiYiaBJFcNZZeyiPwCvLlf
	PCPz6l01OQPkeM/bhgDFcz4em1dJw9+16efqE9RDAEK4JilDxcJ7AgCPinWyQh/C
	wh8iGXdZZlAlEapub3nMKYG0JxUZJ1WUylKbNqoFSklK9N212EzBDw7uPE0t4jRL
	bL/f6ybZ7fog73I23obpWnQywwEBTCanWO8PdglQ0ZcMZTrBQuCeqVQBSxdiOQAn
	RhRkYNe7BwRjgngSlycahGIuud/97zuqULnneYR4JWFwY5s8uQ4PssFoSjnMtKpf
	xKHkaM92AkUSPW7CI12u2/cidvVJZEyNLqzj1nFNi/dxKoWF8TQvJGiABGGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781173299; x=1781259699; bh=b4gkn/olpJZtE2RQ3fsTwoC8R5UsHu9KBFt
	drdo8OHs=; b=JplgW21ZSO2ylhVJw7u/FbGQYk2zYVK0gHiRalDNFSXVya6X1z1
	64XU6P6eCcuYz6Cm6mi+rX11qIJxtnYOFgVuL3xA76sZfbMvQzUwd8fygvHYSIxT
	8QHq9kOpPQekDO4y3axsC7Mb55L8Jup1Wsz+KmrFnaNKlWF4Ds4h7rv+d216pw02
	fMP6pclg7P7lu8H0jc+JfrnY82IePh2A/luId61Fsk9auT6pFtvLeXnz5+LPDj9D
	kQfWcPVR9tvO4jiRWP9TOPGhXp3/h7KDsUe2I5LzwlJeDCMCGCAReVSek20FPQnL
	F0/EsKs4dysUdfB4iS9sN2gVoUscCkRjwRA==
X-ME-Sender: <xms:M4wqauQQmiHgC59ihyoJgjrD8WJj0Qu0Rb-8y6gPkVPmH6upLhRPWg>
    <xme:M4wqagXwwXuTv3fb_0_vB-pVbVgQbXzdnKig35wZT3uqYySl4WCMLSNk_eguYoJES
    4QMR-WmF15_gERMkblOqSpqx_EPWkZQARHb7lYclSagFYjDF3jT7Hw>
X-ME-Received: <xmr:M4wqagTpef0yrPhJ_p2yR4MTfXQEO3jqW5PBp_C6AmPpvQiODcT_Z9QQ6J_K-2j0EUXbx6SCzibkb6noLcfuDn8>
X-ME-Proxy-Cause: dmFkZTE7H49We0yuzpQIXe1vTvUnVUMIwgbHdYWaLR4UVoBpPGGHqsOR2Ws2zbaG7nrKLl
    M1YOn+MWK79gfE0w/68XvDMyGnJzkjTL/UYo2HwU8YB4bFndMVKE4sc4y4ygRLf3Zu0pQt
    dPH+cdJjuFwnBJ0bgVaflWEjDXTXYAtfqodMB7Q3qEXtx0dgTOCCtsuzRMcynCotyYvuUP
    /uh/iuco+ViVYhB2Fk1LFVoX81CN/gOYq0q5a8m0bXb/jmaKkDRaRFJnlg4dezhJoEpP6L
    rXZzLBv5UrUoTF7tkWGRek2c0VhR2ZHIHoTdPKIpuEmSVAFawcVlO3AzaXPukoSX+Cc9OB
    t0RTr57FJYFC0fL65Lb7MLBSmiNJMp1Weu6cvpktE2FMNdtp1SIMnIHNCWVrtTSSmzEByt
    CdRnxdIpPo8FxomQAbOxqx/EbB1ED8DcnX98aeI159n+5Ba+Qm3lWoR/W7p+kvfS4UIqdt
    laHhnXHSg6Jtb6xJqs3D7L4qzzPfUdtAB7dxSD4AV12D3PJBrGGYN62FqHdDF01SyhJ2A5
    PlaptEEr5UqTuUoHwRFVGAgFhuQcsLUSnM+NmgKhZG54ZboCaDqLfNZ74jBKDwZeWy6cnK
    hj0H4w22M1z8FMyroLfP38Z32tYmGs3cX0FDxonEUn9r7G0vEcVNAOe3JGkg
X-ME-Proxy: <xmx:M4wqag3QZuy1ciLj0rdRW4Bl5LbVB4t_ajRGumHNJVCjFXax-gmsCw>
    <xmx:M4wqaocbzHQ96ZyLgd2IC9Tw_qC5mVkh0Wn0GqTLqmsTv2Yj_Ip7Pw>
    <xmx:M4wqagN6GWf5kNRtV99yzrsuGE9e-VWyr2wkgb6tAIYYXdd5ceTI9w>
    <xmx:M4wqakUO_HHolenNxXdeyH5NGL5b0VhEAeAD5SSgkmgwxpCGyoq1YQ>
    <xmx:M4wqavFUH3snr5TR1cU3bBXk7xujHqMNUf9B96MM-4odPVDKilA1CilO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 06:21:38 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 0/2] net: remove tls_toe
Date: Thu, 11 Jun 2026 12:21:32 +0200
Message-ID: <cover.1781165969.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,chelsio.com,gmail.com,kernel.org,davemloft.net,lunn.ch,google.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298068-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:ayush.sawal@chelsio.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim,vger.kernel.org:from_smtp,queasysnail.net:dkim,queasysnail.net:mid,queasysnail.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9B5E670CF1

This series removes the tls_toe feature, its single user (chtls), and
cleans up the EXPORT_SYMBOL()s that no other module requires.

Driver changes only compile-tested.

v2:
 - fix small issues in the docs clean up
 - also remove NETIF_F_HW_TLS_RECORD (Sashiko)

v1: https://lore.kernel.org/netdev/cover.1781013810.git.sd@queasysnail.net/

Sabrina Dubroca (2):
  tls: remove tls_toe and the related driver
  net: remove some unused EXPORT_SYMBOL()s

 Documentation/networking/tls-offload.rst      |    7 +-
 arch/s390/configs/debug_defconfig             |    1 -
 arch/s390/configs/defconfig                   |    1 -
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |    3 +-
 .../ethernet/chelsio/inline_crypto/Kconfig    |   12 -
 .../ethernet/chelsio/inline_crypto/Makefile   |    1 -
 .../chelsio/inline_crypto/chtls/Makefile      |    6 -
 .../chelsio/inline_crypto/chtls/chtls.h       |  584 -----
 .../chelsio/inline_crypto/chtls/chtls_cm.c    | 2336 -----------------
 .../chelsio/inline_crypto/chtls/chtls_cm.h    |  218 --
 .../chelsio/inline_crypto/chtls/chtls_hw.c    |  462 ----
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 1836 -------------
 .../chelsio/inline_crypto/chtls/chtls_main.c  |  642 -----
 include/linux/netdev_features.h               |    3 +-
 include/net/tls.h                             |    1 -
 include/net/tls_toe.h                         |   77 -
 include/uapi/linux/tls.h                      |    2 +-
 net/core/stream.c                             |    1 -
 net/ethtool/common.c                          |    1 -
 net/ipv4/inet_connection_sock.c               |    6 -
 net/ipv4/inet_hashtables.c                    |    2 -
 net/ipv4/tcp.c                                |    4 -
 net/ipv4/tcp_ipv4.c                           |    1 -
 net/ipv4/tcp_minisocks.c                      |    2 -
 net/tls/Kconfig                               |   10 -
 net/tls/Makefile                              |    1 -
 net/tls/tls_main.c                            |   17 -
 net/tls/tls_toe.c                             |  141 -
 28 files changed, 4 insertions(+), 6374 deletions(-)
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/Makefile
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
 delete mode 100644 include/net/tls_toe.h
 delete mode 100644 net/tls/tls_toe.c

-- 
2.54.0


