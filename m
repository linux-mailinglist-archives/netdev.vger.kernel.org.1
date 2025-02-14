Return-Path: <netdev+bounces-166570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1A6A36785
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC3D3B348E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E211DAC95;
	Fri, 14 Feb 2025 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tYClZI4n"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36361FC0FC
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568443; cv=none; b=uYR69cXpoNRePoRoN92KkrGPnhkhIgiJ3jIthCVOcM1MzRr9sugzylqWIN16pTdFt3gOMu216RtGzS77Dh+2koRwDJsRSB5dIdPPyKQKFK/bvFqhHq1pCzu+3h1q5UkVEFYpz6m4t+o7YOYZ2smNfUqbUfSs79nFBJ4tPC9o2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568443; c=relaxed/simple;
	bh=LxTLhoBJdoXXGNY+yZ5eiK4g2XkgRoKuBiTWWjJhl8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g9KNDh0zRJiMDRzoUl1obwP8BSjPV8y1vKm7JawZmzUh6YKTpcWB8dibKn/T8G8iR5mSuWxBESNqlHh9NbwbuUJdE4gEa4z0SIT0jt4196IxhzIRao4lv8/G2uwWxLspm9EHSgMwYxX2tUvxUsOSma8cQIiN/MQ1f1IZ6k7EUIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tYClZI4n; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739568429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2HvK3KACg1xo76IcMN6cxcxvRYECoBQVtmolGvFTK1Y=;
	b=tYClZI4nrW6qzqwOUtHUbrpRwlUlqGd1xbU8QJUnu2VYx4QTEQqZU2ybGzaDuysOGPWdSY
	ZL88KRHTlveVifmWbCD0g+dx9nx81rMlHWMn/oHwPt7YZMzM0F6SwLExjYBgzakh1jXF9h
	hAHc5Jb8psp1CVjpQbOVRTrFn9Ohdek=
From: Sean Anderson <sean.anderson@linux.dev>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 0/2] net: cadence: macb: Modernize statistics reporting
Date: Fri, 14 Feb 2025 16:27:01 -0500
Message-Id: <20250214212703.2618652-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement the modern interfaces for statistics reporting.


Sean Anderson (2):
  net: cadence: macb: Convert to get_stats64
  net: cadence: macb: Report standard stats

 drivers/net/ethernet/cadence/macb.h      | 130 ++++++++--------
 drivers/net/ethernet/cadence/macb_main.c | 190 ++++++++++++++++++++---
 2 files changed, 235 insertions(+), 85 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


