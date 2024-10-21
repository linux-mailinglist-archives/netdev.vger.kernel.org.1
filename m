Return-Path: <netdev+bounces-137590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053DD9A715E
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37761F21072
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D90F1F4FD6;
	Mon, 21 Oct 2024 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wvef3+ZA"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5541F429B;
	Mon, 21 Oct 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532988; cv=none; b=PmkAYj/EEQeT/DyLkGexpru9PLwIrDwedRvfecPQLK+Fo9HaFYdnO8Pm9dRdDJS2x0WPmEHP8rVrQRlBk8EmXkaCvviVCaHdOa/lY69kX7hroWkicsK/ohNEnX25tUxmOfGtAz6VTjuBuSYmlivtfCH0Y4bHcv6jh6EcKrybPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532988; c=relaxed/simple;
	bh=mGBxfEo3fvwdyoCVC+cSHK0qhI2yCmOesExVfHIKSRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/0A7ObHeJuuMqNjAlBYoyjmPLsgrJs4pkLE/ZBZxbzQheiy4oMDNxyMXuMXGJDh0H5CwiWPOawdThd8zvxbqd/COmE+YZhLaKCau82ZsPIIuL/C2UFwAeDbjk9FHfoOkIG5OhKkNrkijbvMxU3pgFVUAS7rfyZQsQyyOtaB5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wvef3+ZA; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 75571C0005CF;
	Mon, 21 Oct 2024 10:49:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 75571C0005CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1729532978;
	bh=mGBxfEo3fvwdyoCVC+cSHK0qhI2yCmOesExVfHIKSRQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Wvef3+ZAAB76ANY940+j4fDlq+GAVTfj2+dQXbiQyzDTWMI0F5BM5kOEt+qWM6jfh
	 sV8spCMYlOrN84ov5+Fmqz7ygBUdIkGIm+3Yj9CXW7DqaoewmQ9FKFsjrfS6WG4Q2g
	 TDs9nKJudFomfxnfI8Poq2Ak4Jp/PyEJ44gTyACs=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id E995918041CAC6;
	Mon, 21 Oct 2024 10:49:37 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:),
	vladimir.oltean@nxp.com
Subject: [PATCH net-next v2 0/2] net: systemport: Minor IO macros changes
Date: Mon, 21 Oct 2024 10:49:33 -0700
Message-ID: <20241021174935.57658-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses the warning initially reported by Vladimir
here:

https://lore.kernel.org/all/20241014150139.927423-1-vladimir.oltean@nxp.com/

and follows on with proceeding with his suggestion the IO macros to the
header file.

Changes in v2:

- also removed the TBUF accessor

Florian Fainelli (2):
  net: systemport: Remove unused txchk accessors
  net: systemport: Move IO macros to header file

 drivers/net/ethernet/broadcom/bcmsysport.c | 24 ----------------------
 drivers/net/ethernet/broadcom/bcmsysport.h | 23 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 24 deletions(-)

-- 
2.43.0


