Return-Path: <netdev+bounces-93020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161848B9ADC
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E481C21566
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC7C7C09E;
	Thu,  2 May 2024 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsFHLyGR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD61CD39
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652967; cv=none; b=FKtCMK0+ADW54luVWJ3/09tKOfdx/HiScuwjclhagK+/erxncta9kKDMlywjTkF5WignZNobLR5btkpKfVWPtRYyLKC3oqnv6p+ZRbzFsCBQYuWGndVCPw07bTvHN+WpuF+qtZn9yQcMonnInfn3afEmykSZb8lEzmdkdPys6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652967; c=relaxed/simple;
	bh=hHAzsJjZ7ihWWLNkAshgqQuvzJEG6FNOnGY5lRZdVZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K38og7ccGXP0w+L6M41LQtQOcxGySoj1Eo/13m9vwEdJYNQvuZhz4cBKCZ12JO6RS+Xxs72n/FBygxvMhKu4AEo4hCulhYfOke9A8J/Xy4lTlwmmjDeb20j1sze5GuB4M9D46rCnGDN01vb3rKmeL+93EBAtgQJdMmNVivqG1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsFHLyGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36058C113CC;
	Thu,  2 May 2024 12:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714652966;
	bh=hHAzsJjZ7ihWWLNkAshgqQuvzJEG6FNOnGY5lRZdVZg=;
	h=From:To:Cc:Subject:Date:From;
	b=jsFHLyGRxDzxe8pP0121VqEd82HMROhXfLhxLwM2mXWAjeSTPYBJ+3A3NGYYV6S/E
	 zwmj1GiKsKTm7SKRLkOT04imZkOFlrb6B2baA8ZfPWcvkCNdnM1VYY2bwzaKZjHjWt
	 qU1L7H3i3JOEZ+0VyYdvJVdYhAJvPiqY7pWRnvfk4bRc2Pvle+mzqtrntCI4ygN1Oq
	 IoIyeLoWSVQpH0aV65WLNHTfIrLesz/5sgnUx0aTZTTxG9R3NQbbreWMi+fbD5ZlJD
	 ZDRuyFeoizCO55wsflqs/xOxh3i3xHnrvGWjZp4QfBbLspgvF/VoMFteOIZYJB5Vp9
	 vVQverzAlKKoQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next v2 0/2] Fix changing DSA conduit
Date: Thu,  2 May 2024 14:29:20 +0200
Message-ID: <20240502122922.28139-1-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
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

Cover letter for v1:
  https://patchwork.kernel.org/project/netdevbpf/cover/20240429163627.16031-1-kabel@kernel.org/

Marek Behún (2):
  net: dsa: deduplicate code adding / deleting the port address to fdb
  net: dsa: update the unicast MAC address when changing conduit

 net/dsa/port.c | 40 +++++++++++++++++++++
 net/dsa/user.c | 97 ++++++++++++++++++++++++--------------------------
 net/dsa/user.h |  2 ++
 3 files changed, 89 insertions(+), 50 deletions(-)

-- 
2.43.2


