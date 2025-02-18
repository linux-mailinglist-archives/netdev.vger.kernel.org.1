Return-Path: <netdev+bounces-167542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD607A3AC09
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 23:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D2CC7A1B34
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31EC1C700F;
	Tue, 18 Feb 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLbFDYQx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5282862B7
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919272; cv=none; b=ZyY+QQi/fc4n6fiM6q6YhW+KecHUOjkbQAb7CUn0pEyJGHjc31xnUgmMbnytU0dJvdHmxMJugS77XwC3WaVb3SL1pfft0RSvzrO3R8i0soQttKuYRzVZChagD0nw1IRgu6subqE8DLFQiWE5rGL4dSG+FF+GGGD5qG7k0UEnnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919272; c=relaxed/simple;
	bh=2Z+iAKldtK49TUcibsmIuqNSBrRM3fPUu3QNvb2X+sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLR0F4R6Q5ejDUqw1boNbPyQqvem2iWKzZf8rCUhj0aZT1aQzxPlMRdUISgilqcMjlsIZg0qhvG+LzzBBlCd14cAVcaiyWg48RJWcGbFsMJxFLpbyvKR2a+fx5Ybt//XBTbNNraJ6BONG4svLj8QFGgVaLAWnNqWP93lqA9N2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLbFDYQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB36C4CEE6;
	Tue, 18 Feb 2025 22:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739919272;
	bh=2Z+iAKldtK49TUcibsmIuqNSBrRM3fPUu3QNvb2X+sE=;
	h=From:To:Cc:Subject:Date:From;
	b=YLbFDYQxy+eCaWWFW6fXzixclLryVtKOD5vXr8tl17Ai331p0tI/Fzr6TurN88Ue/
	 jdGVilEjMt4Vpkf4KKWZALDeCDldJ22/GSR4fI+P/4mDrSwAKNiybQ71U2P5cbHtkv
	 EhIm/qaFeeSwVyS1gFIFQLykS5Ihf83gg3mNcvHX/HPJyIdaDaz0JJ9GpRIr/UH4+f
	 8K2mH0hsevRp5pwX8k5IpKdGesPwGhwPjNo0hHsoC1FLlJJlh+uOBMtDHOSlwB/q2h
	 I5aA6nnVz43F1TWgWp8RP8TtebBNdO+E1rYN0CeWw7TiWNrcEoqCrou9iTQmofaG0C
	 mYPJ/vJcrR3ZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 0/4] selftests: drv-net: add a simple TSO test
Date: Tue, 18 Feb 2025 14:54:22 -0800
Message-ID: <20250218225426.77726-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Add a simple test for exercising TSO over tunnels.

Similarly to csum test we want to iterate over ip versions.
Rework how addresses are stored in env to make this easier.

v4:
 - [patch 3] fix f-strings on Python < 3.12
 - [patch 4] fix v4/v6 test naming
 - [patch 4] correctly select the inner vs outer protocol version
 - [patch 4] enable mangleid if tunnel is supported via GSO partial
v3: https://lore.kernel.org/20250217194200.3011136-1-kuba@kernel.org
 - [patch 3] new patch
 - [patch 4] rework after new patch added
v2: https://lore.kernel.org/20250214234631.2308900-1-kuba@kernel.org
 - [patch 1] check for IP being on multiple ifcs
 - [patch 4] lower max noise
 - [patch 4] mention header overhead in the comment
 - [patch 4] fix the basic v4 TSO feature name
 - [patch 4] also run a stream with just GSO partial for tunnels
v1: https://lore.kernel.org/20250213003454.1333711-1-kuba@kernel.org

Jakub Kicinski (4):
  selftests: drv-net: resolve remote interface name
  selftests: drv-net: get detailed interface info
  selftests: drv-net: store addresses in dict indexed by ipver
  selftests: drv-net: add a simple TSO test

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../testing/selftests/drivers/net/hw/csum.py  |  48 ++--
 .../selftests/drivers/net/hw/devmem.py        |   6 +-
 tools/testing/selftests/drivers/net/hw/tso.py | 241 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/env.py       |  58 +++--
 tools/testing/selftests/drivers/net/ping.py   |  12 +-
 6 files changed, 305 insertions(+), 61 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/tso.py

-- 
2.48.1


