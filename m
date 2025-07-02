Return-Path: <netdev+bounces-203495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFED8AF628C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149254A7D99
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7872BE649;
	Wed,  2 Jul 2025 19:24:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07221A3168;
	Wed,  2 Jul 2025 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484279; cv=none; b=ScUL/87W7Dm6G8fDZy/F/5rzXZLm9Am62XrURk4XV2NynWiiOfCzKjoPzsH2YuggwUXmRf40ttSv+7dLtu0bUUC+pmPqhFwUFqW/rPvTBUy6S9fZz683uQpoTjOAG7DQlpBSp+TUoZv/URkdMk6REJNelgnt/fWD/zMByfbFKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484279; c=relaxed/simple;
	bh=jvEbGYznqavDKeu+EVGcLdm/deEpOPpJJ3GPdl62APU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgYCjImmnuK8V0f8Ylq1BGVeN2dEWx0cj1970i0BU826h2f0g9nbfPp1fDx5mrFBXG3HQkDxo5FHY9ry7ZjHqnHF5OotgBLDDk7rU1h41k3uHnIt3Wsl2rv4gzz7GeZqpwfqiJ4qosZOJnUTEcTLfzxy6JZq/PJ1mf4KK8fe5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uX34G-00080j-UX; Wed, 02 Jul 2025 19:24:29 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Su Hui <suhui@nfschina.com>,
	Simon Horman <horms@kernel.org>,
	Lee Trager <lee@trager.us>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 1/6] eth: fbnic: Fix incorrect minimum firmware version
Date: Wed,  2 Jul 2025 12:12:07 -0700
Message-ID: <20250702192207.697368-2-lee@trager.us>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702192207.697368-1-lee@trager.us>
References: <20250702192207.697368-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The full minimum version is 0.10.6-0. The six is now correctly defined as
patch and shifted appropriately. 0.10.6-0 is a preproduction version of
firmware which was released over a year and a half ago. All production
devices meet this requirement.

Signed-off-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h | 4 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 9c89d5378668..e2b251eddbb3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -15,10 +15,10 @@
 /* Defines the minimum firmware version required by the driver */
 #define MIN_FW_MAJOR_VERSION    0
 #define MIN_FW_MINOR_VERSION    10
-#define MIN_FW_BUILD_VERSION    6
+#define MIN_FW_PATCH_VERSION    6
 #define MIN_FW_VERSION_CODE     (MIN_FW_MAJOR_VERSION * (1u << 24) + \
 				 MIN_FW_MINOR_VERSION * (1u << 16) + \
-				 MIN_FW_BUILD_VERSION)
+				 MIN_FW_PATCH_VERSION * (1u << 8))

 #define PCI_DEVICE_ID_META_FBNIC_ASIC		0x0013

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 1d220d8369e7..cdc1e2938a64 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -582,7 +582,7 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 			running_ver,
 			MIN_FW_MAJOR_VERSION,
 			MIN_FW_MINOR_VERSION,
-			MIN_FW_BUILD_VERSION);
+			MIN_FW_PATCH_VERSION);
 		/* Disable TX mailbox to prevent card use until firmware is
 		 * updated.
 		 */
--
2.47.1

