Return-Path: <netdev+bounces-135803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AA599F3F8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF9D1F23B1E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD7E1F9ECC;
	Tue, 15 Oct 2024 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="vZQVnMcC"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59161F9EAE;
	Tue, 15 Oct 2024 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013109; cv=none; b=g1vSp9dnhqU+cqH3nLpSYaYfZR+YKamPcrF6C52ZgL2Xj+RYHC6isfGS3s2VN3SOti9lUURIqV7oIPn3QLN+7FvKXwUIhNG18JnLaMrCAq//Hf6AiZzO0crTQG9OG5ef1J42XrJr+N48MLMcAyVHthT1KUTGmhHhRlHi765T5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013109; c=relaxed/simple;
	bh=ZfPRyr3qBrgmVCCihVS8rfrJptQ3sJyRe9dExuQDoK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIQIDZiyJDEkqxxfcIjv4NFLVOgURkeTtQVSjiPvGWUl6ZQW5NhophEaPSSS1Lujq8fvGuFKmF8fBW8t8AM7/X+oyvAtZAOUBOXpmgELgtAPSLNTEzvZ7muFKO7n/ZsLoODwGndeRGgObsX8jC/NQZYmGZB4ilrr2SVjgeHXUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=vZQVnMcC; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9A9DFC0003CC;
	Tue, 15 Oct 2024 10:25:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9A9DFC0003CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1729013100;
	bh=ZfPRyr3qBrgmVCCihVS8rfrJptQ3sJyRe9dExuQDoK4=;
	h=From:To:Cc:Subject:Date:From;
	b=vZQVnMcCJ5P1vWQyrZVUQ9o7yfI7I+LWp+yKxmtieyg8GCmzLTPveHrvLkg0fGAJN
	 RgY12SdW9TCjyen5bBqten83d0l+SxkU9ehJzE5TI4SasJxVE0vK/giIIcBHSI6E/9
	 ypW5Psxt9OgQibQfePcsREN/egzsVkTcz5JRJd50=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 3034818041CAC6;
	Tue, 15 Oct 2024 10:25:00 -0700 (PDT)
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
Subject: [PATCH 0/2] net: systemport: Minor IO macros changes
Date: Tue, 15 Oct 2024 10:24:56 -0700
Message-ID: <20241015172458.673241-1-florian.fainelli@broadcom.com>
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

Florian Fainelli (2):
  net: systemport: Remove unused txchk accessors
  net: systemport: Move IO macros to header file

 drivers/net/ethernet/broadcom/bcmsysport.c | 24 ----------------------
 drivers/net/ethernet/broadcom/bcmsysport.h | 24 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.43.0


