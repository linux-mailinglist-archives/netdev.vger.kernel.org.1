Return-Path: <netdev+bounces-115391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C271794629F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 19:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E00E2867DA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304411AE02E;
	Fri,  2 Aug 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QULeO+ut"
X-Original-To: netdev@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E11AE027;
	Fri,  2 Aug 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620299; cv=none; b=EsVMjsYKkh8fSNgS1sjgHoAIBvOeyVLdiF/y8m5NAlm2FwIk7RxxzcRLbUwAmMZ1acJ7stRc4cfN8Eq7/lxJ86iSzjaY2MW3DU5orKHZDmeFLTRoUJlij5hV9JTfJXol7ZnK1ROk99Ar5lM8B9XnhUeJB/FR1tLkL/qR0Vr0IN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620299; c=relaxed/simple;
	bh=yC3FRVJKi3Xwt1Y61uCi0MiAs3SjdNui7AprlfgBrqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dX+qFtOaf3YjgcNkXQ49/3pIxvAvbyYtpqqKXeNGO8NhmShRQUzYGe4rvMcEaJmFRayaObbKHaiGtL7BTFoVw3EVEC7fCnKhDlTMhTVyIVssGUx6xedV6NG5jCYyTsH+Zc8AN3u2Vuah8bq3ux2NIVHU1M6qaqiYArUS0hiUVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QULeO+ut; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722620295;
	bh=yC3FRVJKi3Xwt1Y61uCi0MiAs3SjdNui7AprlfgBrqI=;
	h=From:To:Cc:Subject:Date:From;
	b=QULeO+utqLiuBPXK02gv3hMKNwwqElCpHgXUbAK6v99TJfT0ECTd+iUJFcUZISvX0
	 /uqHtKVQqA3zOFwn3muMJ4ZZtdwpcjfr8ve+08c7kANlIYtJ7Da/6807RQZZdXTe2H
	 6ojkpEoniLcoKkyKml76FBXGtqltABgnH0fCzg/6j3xiEpVF4E/moNmS1kAJJbdk95
	 +1ssDwPPCyEU0fTSZVIVRnhgfz7kYN1mL/cD4kh2fHbxW2sVeQu0ukxAZcJko8bTa6
	 mAhdojU0dsz9/kvORfYiLpEpG5C2YvUhwEB261QQXmuT7einhNLjh0xZOGRiqKnQSa
	 kU9gbcShASWcQ==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 981B73782219;
	Fri,  2 Aug 2024 17:38:12 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	David Wu <david.wu@rock-chips.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	"David S . Miller" <davem@davemloft.net>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 0/2] Add GMAC support for rk3576
Date: Fri,  2 Aug 2024 13:38:01 -0400
Message-ID: <20240802173918.301668-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the necessary constants and functions to support the GMAC devices on
the rk3576.

David Wu (1):
  ethernet: stmmac: dwmac-rk: Add GMAC support for RK3576

Detlev Casanova (1):
  dt-bindings: net: Add rk3576 dwmac bindings

 .../bindings/net/rockchip-dwmac.yaml          |   2 +
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 156 ++++++++++++++++++
 2 files changed, 158 insertions(+)

-- 
2.46.0


