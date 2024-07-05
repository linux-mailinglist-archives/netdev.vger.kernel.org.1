Return-Path: <netdev+bounces-109446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616989287EC
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933F31C20BA7
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42383149C51;
	Fri,  5 Jul 2024 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9A0KCF5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7FE149C4B
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178825; cv=none; b=hX/pZlrtrsroq16jWBUjysURd+f2dQT0doZSKHziEDksBU3pzzysRbY18f+ufarTvLUZ3nKz94bImxIBrAGpICsJLC/bnh71e5vBYdC0ZjXc5MG3pOiwrm35bf42qjhDmqnRg8ArS+io9mGUdUQqtsKMcpWaUofY4xQasy8aoII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178825; c=relaxed/simple;
	bh=3KuxEM/+l5r0XBieG6SH9ClxZdwePH/a6D/GClTvD98=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hkE9ROnwOVoUFoqm+f68tzIBhpTGOI1f6vHB7Y0OwYY7mJiJnncxXFKaH4GSDPd+JUnjjBWNppXZDawQq18YI+C2TziBKsTe27YYG/pc9gZtnWrBBa5BRZVR2xux/Oveuwaj6tSgozMnK6CQXgpbvCRaOnMmDYDmUl2PFVXwja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9A0KCF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA0BC116B1;
	Fri,  5 Jul 2024 11:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178824;
	bh=3KuxEM/+l5r0XBieG6SH9ClxZdwePH/a6D/GClTvD98=;
	h=From:Subject:Date:To:Cc:From;
	b=m9A0KCF5DGI88mmboqAZ+n6wU01PRKA49wp54/8O43iUqQrTqfYEf/imk6sG7u+xS
	 W64VAaO+JQz0f+kt2sPUQ882b/vC3Ba3dPxvfhl4hsqdYo2Cf/AL2IZobbbhXPvwLH
	 m3S7D0L3wuiW5lWZbA+9f5z2MfizZintE3gFBtgMIOlojowrmld095xS9KGFObm+QD
	 kTBFqm0XC2OPu1cEI/F2FRBc6thAHNLmJgmdBgWZw+4ZeFjzRERW/Ai4CxoTsu83Gt
	 a3heF1HtsKwtSm6XHC/W8btvyJPf+KtqyQcjmtKb4WaHpAmMxJolpOF91KbqjXSnlN
	 Q3hNpUdI1qbVg==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/3] bnxt_en: address string truncation
Date: Fri, 05 Jul 2024 12:26:46 +0100
Message-Id: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbYh2YC/x3MTQqAIBBA4avErBtQ+zG6SrSonGo2U6iEIN09a
 fnB42UI5JkCjFUGTw8HvqRA1xVs5yIHIbtiMMq0yqoOV0kRQ/RoBm0XbXXfNg5KfnvaOf2rCYQ
 iCqUI8/t+0whlDGQAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Hi,

This series addresses several string truncation issues that are flagged
by gcc-14. I do not have any reason to believe these are bugs, so I am
targeting this at net-next and have not provided Fixes tags.

---
Simon Horman (3):
      bnxt_en: check for fw_ver_str truncation
      bnxt_en: check for irq name truncation
      bnxt_en: avoid truncation of per rx run debugfs filename

 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 30 +++++++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c |  4 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 23 +++++++++++------
 3 files changed, 40 insertions(+), 17 deletions(-)

base-commit: aba43bdfdccf15da1dfdc657bd9dada9010d77a4


