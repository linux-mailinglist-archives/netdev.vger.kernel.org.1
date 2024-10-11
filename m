Return-Path: <netdev+bounces-134548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CD099A08F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A5C1C216BC
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4543220FABE;
	Fri, 11 Oct 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu45pac7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929020FA9C;
	Fri, 11 Oct 2024 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640639; cv=none; b=kTyl2IgecFr7QTtP0PmWLhJ4MMcI0OOJ2E43rEsvt8mQ6jkzRSFkt8m/yjkyitn+NbSuhT230o6auIa9JDuhHHqM4AP4ijZmk+V/Si2K02+qtraNMCLxAvzfw4s+BIIK71jQU8fCTP4Rqec3EUmSx/7lSMxLuOTEH3CyjkniuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640639; c=relaxed/simple;
	bh=Rz/W9QlH6CCASPfisYQo2Uxdr9sj88V+CDnZpNAOLWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CgBtZFnMANesP8Y20oUq+pDa8o+1r/gsalTXyMRWPn37tGWWLKWtnENhCqhriuNQHyTMDkCCqdNXlBzrXPWNiY3UevGic2lAR7QWKBWvQ912I5dhrUxoulPxJ6k89gu9xGHFHMMEhNV2nA1TyV+5BtT9ZPfAJ2HHWHxBBjsVcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu45pac7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0D7C4CEC3;
	Fri, 11 Oct 2024 09:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728640638;
	bh=Rz/W9QlH6CCASPfisYQo2Uxdr9sj88V+CDnZpNAOLWY=;
	h=From:Subject:Date:To:Cc:From;
	b=Uu45pac7QlRCjDze5nXkdD3zdJRa8iASemsM6nXnwldHPXwQ5b4L/JUsH+wbmbNDw
	 oDP2kOGu7RArTS+Fb33fCO2Gv8DpZAkRZVi1H9NwVfXsU605YwWCA9/aebTPMNdYql
	 EFW9ycJ7FMxOw64JIHx2n9Wkg0EZ+u4yHVWMsFwwDO4dQoZU3OLiFiw04z5TmlqAlU
	 1ixVxAF0QTTeo83suulLa4SEDDi4zKY3gCc4Hy4P38PkPbr/U7KLysbkQS9eF7SY50
	 nJ4kZdICJgqAyx53rkUtiB6EOM6EVQsfqBH9gHUQJt2oesInVFBGMPKWm0lmz552IV
	 0DWKPXb3dXhCQ==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/3] net: String format safety updates
Date: Fri, 11 Oct 2024 10:57:09 +0100
Message-Id: <20241011-string-thing-v1-0-acc506568033@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHX2CGcC/x2MywqAIBAAfyX2nKBW9PiV6FC22V62UAlB/Pesy
 8AcZhJ4dIQepiqBw4c8XVxE1RWYc2WLgvbioKVulVRK+OCIrQjnRzOu7WB0tzX9ACW5HR4U/90
 MjEEwxgBLzi/82WLDaAAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>, 
 Carl Vanderlip <quic_carlv@quicinc.com>, Oded Gabbay <ogabbay@kernel.org>, 
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, llvm@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.0

Hi,

This series addresses string format safety issues that are
flagged by tooling in files touched by recent patches.

I do not believe that any of these issues are bugs.
Rather, I am providing these updates as I think there is a value
in addressing such warnings so real problems stand out.

---
Simon Horman (3):
      net: dsa: microchip: copy string using strscpy
      net: txgbe: Pass string literal as format argument of alloc_workqueue()
      accel/qaic: Pass string literal as format argument of alloc_workqueue()

 drivers/accel/qaic/qaic_drv.c                  | 4 ++--
 drivers/net/dsa/microchip/ksz_ptp.c            | 2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

base-commit: 59ae83dcf102710f097aa14de88ea5cb1396b866


