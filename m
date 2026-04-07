Return-Path: <netdev+bounces-276111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDQHFkI/1Wk73gcAu9opvQ
	(envelope-from <netdev+bounces-276111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:30:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 903173B25B3
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DA2230136A7
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F061F4CB3;
	Tue,  7 Apr 2026 17:30:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DCD1F5EA;
	Tue,  7 Apr 2026 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583039; cv=none; b=J6dB8owLvMw1Np7ARX4exQScDhdeWrZgD83SpuB3AXTBqAjyhYO8lH3r1XJ/5uSFTnFRDpZamw+hIN8zJu1+1iGg89EekuMZA/3Z7e/8STiOFMk3TQfMHRFf9qiGV0wyN17GNt5yV1S4Nu8GDiodoAeIkcOf9RbdR4h8KAS0NgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583039; c=relaxed/simple;
	bh=tQjVTZmd5BcBF+eRMRYSIJTOXaLpx2bY8zXTIctg6DA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fAPCB3WNy6C8ROH7phniFULyZrHpgdpauD94ZAFPnAQyIJYgpUB1grOMVJ7VcBhINlDGLJmSbm9Iwo6cWK2+cTY0DtK41laPKGFiL3GllKLpMeV8PPf3XblyxoNpBc/2vIo+tHCaF3l8mTjsXS+1OF144cLlE7KwrGuK2oqHgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wAAFp-000000000ns-1y9d;
	Tue, 07 Apr 2026 17:30:21 +0000
Date: Tue, 7 Apr 2026 18:30:14 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 0/3] net: dsa: mxl862xx: VLAN support and minor
 improvements
Message-ID: <cover.1775581804.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-276111-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 903173B25B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds VLAN offloading to the mxl862xx DSA driver along
with two minor improvements to port setup and bridge configuration.
VLAN support uses a hybrid architecture combining the Extended VLAN
engine for PVID insertion and tag stripping with the VLAN Filter
engine for per-port VID membership, both drawing from shared
1024-entry hardware pools partitioned across user ports at probe time.

Daniel Golle (3):
  net: dsa: mxl862xx: reject DSA_PORT_TYPE_DSA
  net: dsa: mxl862xx: don't skip early bridge port configuration
  net: dsa: mxl862xx: implement VLAN functionality

 drivers/net/dsa/mxl862xx/mxl862xx-api.h | 329 ++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h |  12 +
 drivers/net/dsa/mxl862xx/mxl862xx.c     | 793 +++++++++++++++++++++++-
 drivers/net/dsa/mxl862xx/mxl862xx.h     | 103 ++-
 4 files changed, 1219 insertions(+), 18 deletions(-)

-- 
2.53.0

