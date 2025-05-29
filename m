Return-Path: <netdev+bounces-194228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB2BAC7F92
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A0C9E56AB
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA71DA62E;
	Thu, 29 May 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH/unGs9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C3210FB
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748528440; cv=none; b=ELqRKpWXc/ahmAXGaReLm5r7p8444c3RRKLMkhcRI7BW7c285xVGoiwVapF4+GODaaKwlohkcfa3gEahWJctxzO8oNbY/Suw/zgIUrgV2sIvUSjvUcJwQ+UXzKrxaZyDDODJ2VPBFBnxyRMc0aumo3C/uYVrC04dXliomsQGVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748528440; c=relaxed/simple;
	bh=7bweCS5XWA47Mdw1kdfgVewbdjYrY0QP5NPoolHSgTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RO2+OPFWj+54N4H7nHONKVm1a7zlg5XKOr/DUOU6h7b1faBr9agfWLzjHTtzs1fnAlXKmimp2NZfNdVaDWZavBaXwSjEQlVfxcHXsI2XbNSmuTnQrOpvQjPxFobxH+Ek9PNoRQYpnWiVP5KBfImlZKeqFj45eiWuVuob+gZLh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH/unGs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8346BC4CEE7;
	Thu, 29 May 2025 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748528439;
	bh=7bweCS5XWA47Mdw1kdfgVewbdjYrY0QP5NPoolHSgTw=;
	h=From:To:Cc:Subject:Date:From;
	b=fH/unGs9EipW80OJI6Cm4AHyFYvYO8XX40zE3xDcM5zCcDn+siYth616LCVECCXFk
	 1QPcJ/IpINqTL5oWRiBac6o2ZU3sE2MQpTx0bGNpt1UmC5ePkhh3pDNvKG+7Y6ZmCp
	 J00tfcDv6fFBpYXLdKPniIyDK2Ku+omCpxhH4gnMFBwB29snhc4BkXuEH+5YC7chCz
	 qOghdVKLB6DOUAQbsEQWfoDfpm4Nlrbcun3NJ/O+IwRQN1OQi8WyHTYCuYJ28uvy/H
	 WjpW2ppu9Ob4ZBVqgLYhEXeLpD7wOL27k91MeySKKfRw8MA723LJXlW2KugMbjJftu
	 vEuJsYlwwMiTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: mkubecek@suse.cz
Cc: danieller@nvidia.com,
	idosch@idosch.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH ethtool 0/2] module_common: adjust the JSON output for per-lane signals
Date: Thu, 29 May 2025 07:20:31 -0700
Message-ID: <20250529142033.2308815-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got some feedback from users trying to integrate the SFP JSON
output to Meta's monitoring systems. The loss / fault signals
are currently a bit awkward to parse. This patch set changes
the format, is it still okay to merge it (as a fix?)
I think it's a worthwhile improvement, not sure how many people
depend on the current JSON format after 1 release..

Jakub Kicinski (2):
  module_common: always print per-lane status in JSON
  module_common: print loss / fault signals as bool

 module-common.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.49.0


