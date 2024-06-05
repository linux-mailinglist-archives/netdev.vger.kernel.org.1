Return-Path: <netdev+bounces-101013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6488B8FCFC2
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DAC1F26CBB
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131DA194091;
	Wed,  5 Jun 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPveB5Pt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E6194089
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594414; cv=none; b=YIcBsIAfBOUvg8YNfCSco+TPBcaCQ1y58PffTY6dEfw2Quxo/7N0lpVBl7wwc5vL0rLWjFfpee824GrMDfa6asszB8fubu10i1416kRiQhW9sS9ffahWVJ4Ah3S3YIoZk6oQJPvm+daqjIXrjAsjtWkRD/QIuhmTudkRjOYRsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594414; c=relaxed/simple;
	bh=NWp1yGhPmvkZnfw+2z9/SPuFKJOd5FE42krpWSufYh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dkVtCG8PkBg/FObwDBeXYlZLltDXTA1bwzTODPzkVSOen5z9/lK3u9EdByZrc3N+ZP7HWoeO7kpN7nSAgGyFURN6Ivj8+r4zmx9TarGZFVzsN+20ipcmzYqn1DIOOidSJr8H1VlpTH+1fnC6uMJZKSMtAOIV7xYlR7gbPDY2vqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPveB5Pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6065CC3277B;
	Wed,  5 Jun 2024 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717594413;
	bh=NWp1yGhPmvkZnfw+2z9/SPuFKJOd5FE42krpWSufYh0=;
	h=From:To:Cc:Subject:Date:From;
	b=JPveB5PtuuXLg++gBsfCYSi07EYWzuyuKGeqt47XkR7uZd8V6eoJe9zIC2OJOjYbU
	 Nu4mzD1u84JbZZogD47Zc2dJiJJ2dG2m+quhcQr977XizJoMU7oHhXt9Ww+99xn8a6
	 7BZMtRuKd5RfHCVVqIFEAEsKqDrLODG/COM9v1sFB4pitj3DmH89d/U8Qj1aHBMyIn
	 zda4H/RxfPilq/voqMqplujYY/MyFZBCyT/25eVTti7Gb2SHRovfmawKLj1HNvRGZo
	 AXObFRK357MZRp9UFgm+/9MffFNC5ajsPNjbv9dAKo7H9fCb5AnfLqWhV9axLKpESk
	 bztzJ10lmvYqA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next v3 0/2] Fix changing DSA conduit
Date: Wed,  5 Jun 2024 15:33:27 +0200
Message-ID: <20240605133329.6304-1-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes an issue in the DSA code related to host interface UC
address installed into port FDB and port conduit address database when
live-changing port conduit.

The first patch refactores/deduplicates the installation/uninstallation
of the interface's MAC address and the second patch fixes the issue.

Cover letter for v1 and v2:
  https://patchwork.kernel.org/project/netdevbpf/cover/20240429163627.16031-1-kabel@kernel.org/
  https://patchwork.kernel.org/project/netdevbpf/cover/20240502122922.28139-1-kabel@kernel.org/

Marek Behún (2):
  net: dsa: deduplicate code adding / deleting the port address to fdb
  net: dsa: update the unicast MAC address when changing conduit

 net/dsa/port.c | 40 +++++++++++++++++++++
 net/dsa/user.c | 97 ++++++++++++++++++++++++--------------------------
 net/dsa/user.h |  2 ++
 3 files changed, 89 insertions(+), 50 deletions(-)

-- 
2.43.2


