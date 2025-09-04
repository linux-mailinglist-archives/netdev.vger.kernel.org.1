Return-Path: <netdev+bounces-220120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28776B44812
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6A4A034C6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162CF296BA9;
	Thu,  4 Sep 2025 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="o5vf+xlP"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4728DB59;
	Thu,  4 Sep 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020043; cv=none; b=lGgJSBS5/2w1yf7rgCwqPXyXsFCADFC19Pjjg7lwrM0l6VACCmgWSiWUgmTFOP9/S2lMrLG63bGRBwa7Nz/OVrve8O7mTzYCWwJcvez+SVq7yHS13WndgSAp9pMFfmAPo379HlqrKJL9UltMvbP8TY0BPml2znZ+DPaFCHHg9iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020043; c=relaxed/simple;
	bh=KWs842YIwx84jxEQtrZjfQRc721UeJjZ01BLLEITP/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ol5MM5GAbh8l/iMJHMdEdPoX46gY3wAepKv3MatHksHhyBsvc/pplBapN+sCdZW2sC5Tm5+CL06UdNafuLG17mO4KLCiOEzcnO+NWAQwv0pxz5UuuNhNk372eFOUIwqg5nYSB/4Pse28tkxlClzKjbKG/e7ugQwH8J+s/V8wRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=o5vf+xlP; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 778ACC000567;
	Thu,  4 Sep 2025 14:06:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 778ACC000567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1757020009;
	bh=KWs842YIwx84jxEQtrZjfQRc721UeJjZ01BLLEITP/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5vf+xlPXoi6sNt+jwuxhRc99f9NSialibLrj/a7dNJ7EkDNJ2p2LXPqjVbITgGtP
	 2BX84SCduB6y8ih9Z+cL+C8gE8wcTpETO2dx3t+5rks/wBPli9bC5MwqgDF2zFHF9E
	 jEO/+n94kmhLTzPLIm48QqR32Qmz7udaQRK1U5m0=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 322AD18000530;
	Thu,  4 Sep 2025 14:06:49 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Stanimir Varbanov <svarbanov@suse.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 5/5] arm64: dts: broadcom: Enable RP1 ethernet for Raspberry Pi 5
Date: Thu,  4 Sep 2025 14:06:48 -0700
Message-ID: <20250904210648.222946-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822093440.53941-6-svarbanov@suse.de>
References: <20250822093440.53941-1-svarbanov@suse.de> <20250822093440.53941-6-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Fri, 22 Aug 2025 12:34:40 +0300, Stanimir Varbanov <svarbanov@suse.de> wrote:
> Enable RP1 ethernet DT node for Raspberry Pi 5.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

