Return-Path: <netdev+bounces-214656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B25EB2AC84
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4347B0889
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEC12571BC;
	Mon, 18 Aug 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="maSQ1Lw/"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EA62550D5;
	Mon, 18 Aug 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530415; cv=none; b=psjrVZti7j/s/wJ394BkdxdRdmqFev5R5cJmB5p8kom2D28XdvGqR/1zNQM4djDKvnchnOjYaDBgKICrsa7WVed7Wj0pktztJlVpEgVYxao3v/ROp5Q4Ld1G8aho0wlxtHw7j0PFVEmBK0z/0LJVV8umZ4U7IeSwL8UIxxrCwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530415; c=relaxed/simple;
	bh=Z6k9OoEzvVJHICmTc0rywQMHoOB5Bpgv7yvaBBbim/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TD9hkFMB8XHZjo6z3zUb7gTdsJ3opyVqFQRbNPBg1K/EMLLhCNwFWqWwku64NV9kK+w2K8R38hIQgcT9qF+GwcW1HMhxjw3zh6peQV8r75ZFZ0fBW0MpXPKAnmanG+hCuVD2HA2jHpP0TBEFmSCOBgQiLQgJl/2RgnY5JIETt8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=maSQ1Lw/; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755530413; x=1787066413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XMYejQHNqpjFbERCaP8aLdVx7eISvzwexSyDRnFQHOA=;
  b=maSQ1Lw/+2Jb/jAjFAtLkGIPY3CXu+fWrxCGWQVUnpFXmfcN3K9wsYmL
   TCHSoKJ7UgEqVYOjnGIxzBkc6DV2IMWwVAIl5jtMU9dEZuJJIyOoNE9s8
   SU0wVJeBd6mIN57fMjWboj95yiHzi1jKqfVhpsOEJxL8I2NbZbg6CBXkT
   xPwzmZYx4GfgsV6LX3vVQEH6miY3be+99tlUzvtsZC3NHJCn0A+yHKK9k
   npmqMZISF/WSksglOCpyKCBAsXWCN5Fg7PT13fEc0YiUtPcoIo07oE6hO
   uNspByDJ0Js5aUMfCjmWbhoVuFp9d1mMhpzsGL2hMk4YpMwFLSJfh+u4g
   g==;
X-CSE-ConnectionGUID: GvNU4AY7ScqpFe9ijYZcyA==
X-CSE-MsgGUID: NOYTGUURQ1qeT1MfdGWN1Q==
X-IronPort-AV: E=Sophos;i="6.17,293,1747699200"; 
   d="scan'208";a="1310829"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 15:20:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:42477]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.244:2525] with esmtp (Farcaster)
 id 8a5d81ca-8000-47fd-9d85-193fbc95c6eb; Mon, 18 Aug 2025 15:20:11 +0000 (UTC)
X-Farcaster-Flow-ID: 8a5d81ca-8000-47fd-9d85-193fbc95c6eb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 18 Aug 2025 15:20:11 +0000
Received: from b0be8375a521.amazon.com (10.37.245.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 18 Aug 2025 15:20:08 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
Subject: [PATCH v2 iwl-next 2/2] igbvf: remove redundant counter rx_long_byte_count from ethtool statistics
Date: Tue, 19 Aug 2025 00:18:27 +0900
Message-ID: <20250818151902.64979-6-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250818151902.64979-4-enjuk@amazon.com>
References: <20250818151902.64979-4-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

rx_long_byte_count shows the value of the GORC (Good Octets Received
Count) register. However, the register value is already shown as
rx_bytes and they always show the same value.

Remove rx_long_byte_count as the Intel ethernet driver e1000e did in
commit 0a939912cf9c ("e1000e: cleanup redundant statistics counter").

Tested on Intel Corporation I350 Gigabit Network Connection.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
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


