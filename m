Return-Path: <netdev+bounces-199989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CFEAE29E0
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2C63B20A6
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB8B1531C1;
	Sat, 21 Jun 2025 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBL8oLAr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752229CE6;
	Sat, 21 Jun 2025 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750520145; cv=none; b=b6ph95U4i+8Y1PZxqBVLhrZeXwX+eLilWdWUXNAPGTPdPmSTQNhBZBmz+EFT8Ax9gjmECfnONTviS9r8SSCoOTWViIyEFTVuqH1uI5jNtg57Hf/FhbEXJB4jGoYZyt7vfX96s4vEDQkBXZdJR8f61eF3fh2p+G2xYsJ7GeP9x9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750520145; c=relaxed/simple;
	bh=uaqrAVHz4P77UurQRE+V0vifBS02a/slmFHXIxT4b3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdPgVO1XxSPK4dG+7oqZP7H2ARCEMMKVuMV9GCFYP36hGVYuJwsnpbeyi9NZOyxOHYxUMxiaBVGeW6XLfA6Dl3SE0/v5EACl0apIq07jX2f1uxXAzTLc5lY1wvcG7UbP+TNm1lo1UI6eREubWs4HABzP7PJyuaOvHZ/930VfPHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBL8oLAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A9AC4CEE7;
	Sat, 21 Jun 2025 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750520145;
	bh=uaqrAVHz4P77UurQRE+V0vifBS02a/slmFHXIxT4b3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UBL8oLArVeOqAbPKjTPsumI1euKNLdReRm74C0srTEOCHR2z3d9+wkvIUjkpi+O5B
	 NQAzQI9TLQpdNMbF65s0gxzKM7uPaygkOBb5oZpf9BIWc7cF1m3a+B/XSvwEfMUItR
	 8rAS0V3TI1IF7vrYZM+6Q+CCar9HGizxy5Dej19mZAFuPDMzI2RqHp3JdZViMsluSA
	 wvDtcHtApWRaONp8VzFrhPOarVTbx4TtDyWclGDIdIXzxafgNsTKXvTOpjQgpmEtyB
	 iu+EcJymhAi6zTU3OPZbCxNVVBLVTEZvOLGw6GU57lE2qch48ESWnPH7El5QKBhg6+
	 MsrfSu7HYXNvw==
Date: Sat, 21 Jun 2025 08:35:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net: hibmcge: configure FIFO thresholds
 according to the MAC controller documentation
Message-ID: <20250621083543.67459b3b@kernel.org>
In-Reply-To: <20250619144423.2661528-4-shaojijie@huawei.com>
References: <20250619144423.2661528-1-shaojijie@huawei.com>
	<20250619144423.2661528-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 22:44:23 +0800 Jijie Shao wrote:
> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_TX_FULL_M, full);
> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_TX_EMPTY_M	, empty);
> +	}
> +
> +	if (dir & HBG_DIR_RX) {
> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_RX_FULL_M, full);
> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_RX_EMPTY_M	, empty);

nit checkpatch says:

WARNING: line length of 81 exceeds 80 columns
#62: FILE: drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:306:
+		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_TX_EMPTY_M	, empty);

ERROR: space prohibited before that ',' (ctx:WxW)
#62: FILE: drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:306:
+		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_TX_EMPTY_M	, empty);
 		                                                      	^

WARNING: line length of 81 exceeds 80 columns
#67: FILE: drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:311:
+		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_RX_EMPTY_M	, empty);

ERROR: space prohibited before that ',' (ctx:WxW)
#67: FILE: drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:311:
+		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_RX_EMPTY_M	, empty);
 		                                                      	^

total: 2 errors, 2 warnings, 0 checks, 79 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.
-- 
pw-bot: cr

