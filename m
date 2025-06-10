Return-Path: <netdev+bounces-196296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87DAD4135
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BE1189E734
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DCA24DD10;
	Tue, 10 Jun 2025 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="wHU2T4Ah"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED224679E;
	Tue, 10 Jun 2025 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749577478; cv=none; b=k/YXBpZW9iarJ75lj/7s3cgQE6DaQmz5qNvYkqHZoXkGYrH5KsEtsb0jNMIjdjORDo3anFXj7TvMYzkMkOk10exYPGqiqgSDSU/uHIbHfkg58Q1m9cf7dMwGhnzsrTArPfpDhSjmnEnzUvxEwe52kzvYFWOE3p9VQuqL8q79ZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749577478; c=relaxed/simple;
	bh=+1O4an3QKZuYhfwV1G3gJ76TSLyl39tyLqh63DnqSsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KltE/ubBY6uNiu7F9rCxAzBNufuzv5rsHtyoQXZi20h4tu8KDmDFZc2XcD1lWTw2p0KMfm0mGe8tLv/yyoH22RGmcTWzoX2Xia49M0kU6+lbAZkxZ20Jo8Qhq5wzrBeODz9aqlzOo1va8ApbInHcjuvjDNMbkl9R2y7+QzD3dM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=wHU2T4Ah; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E44B7C0000F8;
	Tue, 10 Jun 2025 10:38:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E44B7C0000F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1749577119;
	bh=+1O4an3QKZuYhfwV1G3gJ76TSLyl39tyLqh63DnqSsA=;
	h=From:To:Cc:Subject:Date:From;
	b=wHU2T4AheHRtAljwFpoJF/yRA1NP9jpG8YTLg1h8DzwaIPUC3bhJdXM0/b1mrTiqb
	 qv7SXPQOBixKQaq6iCOsaiIAd8iHfmaw76hMSMrpVjuAYp10KVHdQXYNWLwWmh9UJB
	 GDMG4x4sqQvEOF/vT9vd6ao6kETN1ExNZcg36j5E=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 850E01800051E;
	Tue, 10 Jun 2025 10:38:39 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM ASP 2.0 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/2] net: bcmasp: add support for GRO software
Date: Tue, 10 Jun 2025 10:38:33 -0700
Message-Id: <20250610173835.2244404-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches add support for GRO software interrupt coalescing,
kudos to Zak for doing this on bcmgenet first.

before:

00:03:31     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
%guest   %idle
00:03:32     all    0.00    0.00    1.51    0.00    0.50    7.29    0.00 0.00   90.70

after:

00:02:35     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
%guest   %idle
00:02:36     all    0.25    0.00    1.26    0.00    0.50    7.29    0.00 0.00   90.70

Florian Fainelli (2):
  net: bcmasp: Utilize napi_complete_done() return value
  net: bcmasp: enable GRO software interrupt coalescing by default

 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1


