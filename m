Return-Path: <netdev+bounces-220119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49434B4480E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1968A1C82A9C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E07293C42;
	Thu,  4 Sep 2025 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="uZuF1dRg"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498D285CB2;
	Thu,  4 Sep 2025 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019997; cv=none; b=LBEq9Sf5u/5XdCRcgSvZY5bAulsvjNYtG5nF8QHusSPUQULgNNYzmbGWbBSI+KAHvqAtXutlZfZhfI9yNom3POsmhnJ3aNcQ+OfODiWPHtCS6zzwn1FRSb0QmDEA/15tto0AamcJ+z+aX6ZVFmL5F4e074vb5cFeUvoBuN3Fx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019997; c=relaxed/simple;
	bh=QiHIY+KGsOBc9vvFNqr/YKh5r93V7JQ/OZJ1YrLv16M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMfVEFB7jaPLbLpGwfo/dEZxL0Pzo///nyHpb2ZUMfQOYZXxBDJD7dqcLwQBGMQqRQ2wn+GldVWuvtuIDam+mLtGWaOg6yYfkJJcxTh+Dy+din9J9psxWuBRx4VsxjnKOWfSaEO6YTytwtkfHQmI7BJ/ipXhS7GSYXXVI8bT7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=uZuF1dRg; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4E95BC000567;
	Thu,  4 Sep 2025 14:06:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4E95BC000567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1757019995;
	bh=QiHIY+KGsOBc9vvFNqr/YKh5r93V7JQ/OZJ1YrLv16M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZuF1dRg/704uBqbSQ/uQxjs1BSpOFYEe4nDbjx+aB96kZYGMowW9+CAEaKwJX6gO
	 GQ9WkFnFRLb8Or+Kk5lLJKWqS3FYNdPcWbfSwhK1TKRYFuQyVRy/8sZGFWZteWydv1
	 rxvciWxxURtiuOKt7up6cfuees1PpGrE3r0AtwoM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 07D7418000530;
	Thu,  4 Sep 2025 14:06:35 -0700 (PDT)
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
Subject: Re: [PATCH v2 4/5] arm64: dts: rp1: Add ethernet DT node
Date: Thu,  4 Sep 2025 14:06:34 -0700
Message-ID: <20250904210634.222845-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822093440.53941-5-svarbanov@suse.de>
References: <20250822093440.53941-1-svarbanov@suse.de> <20250822093440.53941-5-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Fri, 22 Aug 2025 12:34:39 +0300, Stanimir Varbanov <svarbanov@suse.de> wrote:
> Add macb GEM ethernet DT node.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

