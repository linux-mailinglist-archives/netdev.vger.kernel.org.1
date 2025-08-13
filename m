Return-Path: <netdev+bounces-213242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089FDB24349
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7073A89AF
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925102E9752;
	Wed, 13 Aug 2025 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XFSwHDlx"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034552D663D;
	Wed, 13 Aug 2025 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071590; cv=none; b=oKY31aiAjydu//Lnu2i2VpwlFmNI9TYZFL4HDSMFR7EojvUWbfCq0apQE3p6vmih42xr6pMrwgvbY6LXV0JVK7Iyu6dUDs1G7mXAc2FmslH/1Q60YaUWzQ6Vf+GQyka+pos43o0uihvyKre2c7zPr0Dwa5CPStBFgA4YVqfWz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071590; c=relaxed/simple;
	bh=mC7+1scHvVN01Ratoae6Ma3WssKjLZeML0ZDX5QH/Jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKvv5t7xDQ1tsRCS6pFtjizQdjZ/8fwPi741GpvwrTXytmnc8SpxJMt+Yzlqs6iLJv1MwB5PRAd1fwBvUPt7TWQ/na31WE+e2aKjZVvhCo3PZrqjU0o3CL8QYPBDmxYhK8Dsszf0YGJGShnwsesDepoItyUIj5mTQkprlXNfWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XFSwHDlx; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755071589; x=1786607589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xsW2gkaKHutRZdC4N3bM+pd59a4BhzwYQTJta5k2tx4=;
  b=XFSwHDlxb0UGZybxC+1zdkgwXRoKI0EwQObSElHzVN0hL2LRx0h/f+sw
   3IWrk0QT05gMpj6cMtX8RCT4EMHoEqP/VlwMmPeiBtBj7hDXWy11No6/J
   FDKBGgnrJFyH1ZWLUIWhoTpIF89E6nuxuHqabyzJHFIsxrC4onxvrqY5f
   W+eduOUCc8p6a0Yl8O9f3oKUG3Jw1sdlI22RtPkD5q3O3xq9DX9PNBkCy
   9qsvpjIgUpdvf30g4KUDdW67f+3y2zJuyCtgPtLrKI3HBBCA4D1pY2o4d
   +DGY8L8e4KYzlU0HMItmBH1EK0M2Zxlzo0VTLaoCJpG6ItpHzv9tNCu6m
   Q==;
X-CSE-ConnectionGUID: OkofuCaJTiCtcTq87+dEAQ==
X-CSE-MsgGUID: ouDRRQDdTFayBMqx/djIMw==
X-IronPort-AV: E=Sophos;i="6.16,315,1744070400"; 
   d="scan'208";a="988935"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 07:53:06 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:65328]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.75:2525] with esmtp (Farcaster)
 id 8e9ae4e8-78a5-4d0e-a086-e6ffcd9c0947; Wed, 13 Aug 2025 07:53:06 +0000 (UTC)
X-Farcaster-Flow-ID: 8e9ae4e8-78a5-4d0e-a086-e6ffcd9c0947
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 13 Aug 2025 07:53:05 +0000
Received: from b0be8375a521.amazon.com (10.37.244.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Wed, 13 Aug 2025 07:53:03 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH v1 iwl-next 2/2] igbvf: remove duplicated counter rx_long_byte_count from ethtool statistics
Date: Wed, 13 Aug 2025 16:50:51 +0900
Message-ID: <20250813075206.70114-3-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813075206.70114-1-enjuk@amazon.com>
References: <20250813075206.70114-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

rx_long_byte_count shows the value of the GORC (Good Octets Received
Count) register. However, the register value is already shown as
rx_bytes and they always show the same value.

Remove rx_long_byte_count as the Intel ethernet driver e1000e did in
commit 0a939912cf9c ("e1000e: cleanup redundant statistics counter").

Tested on Intel Corporation I350 Gigabit Network Connection.

Tested-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/igbvf/ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index c6defc495f13..9c08ebfad804 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -36,7 +36,6 @@ static const struct igbvf_stats igbvf_gstrings_stats[] = {
 	{ "lbtx_bytes", IGBVF_STAT(stats.gotlbc, stats.base_gotlbc) },
 	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },
 	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base) },
-	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },
 	{ "rx_csum_offload_good", IGBVF_STAT(hw_csum_good, zero_base) },
 	{ "rx_csum_offload_errors", IGBVF_STAT(hw_csum_err, zero_base) },
 	{ "rx_header_split", IGBVF_STAT(rx_hdr_split, zero_base) },
-- 
2.48.1


