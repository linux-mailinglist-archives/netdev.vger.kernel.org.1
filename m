Return-Path: <netdev+bounces-283919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBo1IBS8+Gnh0AIAu9opvQ
	(envelope-from <netdev+bounces-283919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:32:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C72224C0B7F
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 102A93017787
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E6F3DE45C;
	Mon,  4 May 2026 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+ub/wuF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BE3A5E92
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908753; cv=none; b=BTGT+U30tRI90OqKzu+BJtlA9ZTD7kl3x5eCFBbjUyyGka39bp9Q78iMUy4ZeaxYj5+fN8a2hHzSmpeHCBwd7Ulxqarmyp8dyl9G4BCwwv3zY0uOhcIMiwB6KL4Of/fzRU3dGUIgV361r7UqAY513pmxKBZY4JS9npiyu27E3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908753; c=relaxed/simple;
	bh=k1ewJ1roSUoSNejuZkGXBC145lI54uDg4itlUu+kA8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dRnxg/pA0RJ+8fniVjm9qYjNgGsIxU/qU1Kaj1thCO5P8xfpprP2+jra/dG+rM877OURSSnicZLzBtIMhNR5RDBm2PuGx+jv8c4HmEds4EqWElbiFlHVdvw9rTgAzCshLBzHoSo4BYdQcjhuMMYVsSPM7aPyCsyFq6Z0YzpK2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+ub/wuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40DCC2BCB8;
	Mon,  4 May 2026 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777908752;
	bh=k1ewJ1roSUoSNejuZkGXBC145lI54uDg4itlUu+kA8o=;
	h=From:To:Cc:Subject:Date:From;
	b=R+ub/wuF40u3t90N422uJPdUP3NU92XMSDWcoS7vRSf91BUIYrVXJcy1KA4NqpeQC
	 HYUo0GpJs51oO71j+37BVbG8HgmHGjhuUIzpXgCu9bo1RuxRyVXZqAC0PhaKwbj7c4
	 F9jhtSHERUGocpNi9qRgYxO6ZdspkQDRU14BkPFuc/xTe6saQPN63A0TaCsH7xlZCe
	 KOcXEQOcuYffMaqWvITi63UonkbJULRdsx4qp1lGLtGgO3vWmOBzRHrcQRGLQqooPZ
	 cG/x+kCVOhV3uH9nzZrr4x4LUNIaKAX4sH3MXPxK2gNFVsR3yRazlIOoN+8UJHtozy
	 x4QHMyeXs+kwA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org,
	Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 0/5] Fixes for mv88e6xxx for 6320/6321 family
Date: Mon,  4 May 2026 17:32:22 +0200
Message-ID: <20260504153227.1390546-1-kabel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C72224C0B7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283919-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,waldekranz.com,vger.kernel.org,ericsson.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Five fixes for mv88e6xxx for 6320/6321 family, for net-next, without
Fixes tags, as per Andrew's request last year, see
https://lore.kernel.org/netdev/20250313134146.27087-1-kabel@kernel.org/

Marek Behún (5):
  net: dsa: mv88e6xxx: fix number of g1 interrupts for 6320 family
  net: dsa: mv88e6xxx: allow SPEED_200 for 6320 family on supported
    ports
  net: dsa: mv88e6xxx: define .pot_clear() for 6321
  net: dsa: mv88e6xxx: enable .rmu_disable() for 6320 family
  net: dsa: mv88e6xxx: enable devlink ATU hash param for 6320 family

 drivers/net/dsa/mv88e6xxx/chip.c | 15 +++++++++++----
 drivers/net/dsa/mv88e6xxx/port.c | 15 +++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h |  2 ++
 3 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.53.0


