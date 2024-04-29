Return-Path: <netdev+bounces-92203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EAC8B5F24
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 18:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA76C1C20E42
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D7384A58;
	Mon, 29 Apr 2024 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CimBZnQd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E52651B6
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408592; cv=none; b=QgjcZdm52J05QmIX9a7HkWVOY+U3Mrm6aFU0QM4IRM9Rl3oZH6cnUSSxD79rqc9U16TIt+vwHDsTZEbMV4Gvl8fk1vjEzk0lgXbWHAnPLYqjFRKtA1AI2selUv+m8+iPyh41fopErKHKjFHeg7NcOggoqYG2oPA5yMZz3biF2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408592; c=relaxed/simple;
	bh=qNYWoIkDTXXgVBG0bLf7X8oAnqk0mrvTwQ5msR9vI9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fIfJ//m3TBA2W5LnDyd+JXijZLOuPtjke/YfySYIcoDeoWePLoBbg5pu95dIvRo5imNZJHYdDsWWGZKPwVTLWHEJsPk4VPELGkrjuImR9s45wl1Dbwya1CrzHhTK2pOi+UG1ami4sWQ/3JP93BSuNifbjMTvoj3YXAi7Tol3RGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CimBZnQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B575C113CD;
	Mon, 29 Apr 2024 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714408591;
	bh=qNYWoIkDTXXgVBG0bLf7X8oAnqk0mrvTwQ5msR9vI9k=;
	h=From:To:Cc:Subject:Date:From;
	b=CimBZnQdnEtm0WPbfTwQE/m/8X/wzfYLKVNxVG3QSLwwrA1bEKqtweUQc0KBpN1/X
	 3yI3XYtczPD9fzxAuNPxa4JQhZS8PA2SgM4M5c3+NOHTK0BpBlBSt/lVX2o8kE8FwB
	 BhtTTF3edXGXgK+i/hLmvlJfcnuqbm4rP3Q0nVma5Cigl4lG6vVN6hcYfQvIq3NRil
	 424CUlvms8Ffk9YU4LbRlLDEopkI7Hsfhp7dgVyS36x50O2w/kC0A6yjiyMOggffMN
	 3MJeTH0nSd1K3GE4lWC79klMuNOhvV34A28RSLxG7hBnvLmsniKBRUPH7sllG6JZpS
	 kYWrUoBdLy2Gw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 0/2] Fix changing DSA conduit
Date: Mon, 29 Apr 2024 18:36:25 +0200
Message-ID: <20240429163627.16031-1-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Vladimir, Andrew, Florian et al.,

I'm trying to implement conduit change for the mv88e6xxx driver and have
encountered an issue when changing the conduit for a DSA user interface.

The first patch refactores/deduplicates the installation/uninstallation
of the interface's MAC address and the second patch fixes the issue.

Marek

Marek Behún (2):
  net: dsa: Deduplicate code adding / deleting the port address to fdb
  net: dsa: update the unicast MAC address when changing conduit

 net/dsa/user.c | 136 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 84 insertions(+), 52 deletions(-)

-- 
2.43.2


