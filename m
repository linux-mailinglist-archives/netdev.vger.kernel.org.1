Return-Path: <netdev+bounces-181619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35E8A85C7B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDAD445193
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D3238C2A;
	Fri, 11 Apr 2025 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEPEOpiS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174F208A9;
	Fri, 11 Apr 2025 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373374; cv=none; b=tFYRLmVvt9HyICjaAoY7OvLG3pzVzVFcUM8cHqomTaWMgL9d5z678scty4H0eFvGruwhlFo23DR7ZYyoV0eG+dX1+s19qGL9tmVkUSfxfD/WgmWsS0VM30NIPCLpjKADrWfOJzC9XgpUe3ljcH8IlXtvg1PfLHwOL+cozYjiuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373374; c=relaxed/simple;
	bh=7Y3T42TY8jeBkPagaZuEY97yKOmPKtye3l4SE91TQ8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qi4QPSsuud9EZrcQOI9WLKWHx9KvbEGYVdsU+AF/TkjSrmyq/towtGJayzp6a59UGKkATr3tvYLcmR3RiB+7dX5CTKUoQHNFNBJLuzxaO6mn7HSA0t5lvQGOSmDvM297Y15wXjkeJqMObvhNdhzP2voTgvx7IwxCxidLI83Fz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEPEOpiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CA2C4CEE2;
	Fri, 11 Apr 2025 12:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744373373;
	bh=7Y3T42TY8jeBkPagaZuEY97yKOmPKtye3l4SE91TQ8Y=;
	h=From:To:Cc:Subject:Date:From;
	b=eEPEOpiS6HTn+jKwQabURYl1TAIUAY364eEAnlONIcyHt//8SatHqPVzbC1AdPAU+
	 alD44aoOOsbj/LalIrlufSehdK/LMVzSaMX7uBUcjCu3VA3IQWJ5kVNtHhPhFwElIT
	 OMIyG63Bcuo8Y8b8okVmOUFXJA4dTjh1XcFnzkO2MZj87hFS8SZmTJWAeFwm3ixjlC
	 VUCXV/wfsfVTZZeQ+eL1M07QuVsuBsjBE1nqthXKdTLVl72XbK6rjK5U1l80Io5+Wv
	 Hackz1MbL55/oP6io5kO3mcuOilMprFR7zVdSWBSoIlP+9nuJV7zp00kE/3DAOXsU6
	 QpjEWWhxhFk+g==
From: Michael Walle <mwalle@kernel.org>
To: Saravana Kannan <saravanak@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH net-next 0/2] net: ethernet: ti: am65-cpsw: Fix MAC address fetching
Date: Fri, 11 Apr 2025 14:09:13 +0200
Message-Id: <20250411120915.3864437-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MAC addresses can be fetched from a NVMEM device. of_get_mac_address()
will return EPROBE_DEFER if that device is not available yet. That
isn't handled correctly by the driver and it will always fall back
to either a random MAC address or it's own "fetch by fuse" method.

Also, if the ethernet (sub)node has a link to the nvmem device,
it will fail to create a device link as the fwnode parameter isn't
populated. That's fixed in the first patch.

Michael Walle (2):
  net: ethernet: ti: am65-cpsw: set fwnode for ports
  net: ethernet: ti: am65-cpsw: handle -EPROBE_DEFER

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 27 +++++++++++++-----------
 1 file changed, 15 insertions(+), 12 deletions(-)

-- 
2.39.5


