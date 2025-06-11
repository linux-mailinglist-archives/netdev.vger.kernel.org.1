Return-Path: <netdev+bounces-196485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D119EAD4FAC
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C307ACB40
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A3F25C83E;
	Wed, 11 Jun 2025 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LZyKL+/n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25825C834
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633891; cv=none; b=cxRPjNg8mwnxAXfApo/1zrEqiUkyW027zUe8vSGt90p6i+Q+JjO5Eq9seMQ9KPj6IyuYEss/Bocaq2VI3LsZ9Nk7DdEnaWEtg+tPSyqLRxldAT0TiU+AVF6ATcMnckkgyyio49TtFVLZu8t28gL4gTzwSPICYSlFxXT6nELj6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633891; c=relaxed/simple;
	bh=tPzeYxMklWfSNwE/FSJEm2TflXcxF7/3qKph1efgiqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yu5Eaw99/qFnXSnbTtx5wtRH/rxqHQ3znBbg9mm+CxZ1NpYTxwv6W/CXYIlfGmWFmXoocCR1Kk26pERSZ9SHMpYpVnS1IynDIJqKndIoDKLgd3Av105RDZx3YF6xE1dAq+jv5pLMKe7DnQLvQo9mNZ9pjVTQCvaX6qsFf+ofAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LZyKL+/n; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749633890; x=1781169890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/oLmxDZ3j7ZnfjqmKc+n2Qaa9t2FjdWDpoye9QaCGJ8=;
  b=LZyKL+/ntU+/jcXm/Y+8JPRSkEoH12nto39yvX/VexDmqVzygo3zlsFD
   fHFHBqHprRKC+eMCKL9G2J74SRnyx1lEhH8B9NOY+0ihVMz291RVGx7Fm
   f1KerUnFiJ+rnG9yfb8PgN0y+HCAjdiXnQqnIaaxeUFgUSAwwqnmdc6hM
   337JkKluUp7UMnZ5cThShD3K1Oyff3K6a1AuWlTEJsAtk549AOz4t5YgY
   UzpIMV3+fKkE3I/Xh/IjAX74o4994LeO1nW+MN4A7bwI8GtQaQEn+TD2A
   tZl/yWvbamJ9W2NUm2JAcxFIhB3mZs/ftBE/nH6+VBgFvgtDDhm9BVSxG
   w==;
X-IronPort-AV: E=Sophos;i="6.16,227,1744070400"; 
   d="scan'208";a="508253898"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 09:24:47 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:6875]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.30.39:2525] with esmtp (Farcaster)
 id 01b8b994-1438-478c-869c-e0a4205b1afd; Wed, 11 Jun 2025 09:24:46 +0000 (UTC)
X-Farcaster-Flow-ID: 01b8b994-1438-478c-869c-e0a4205b1afd
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:24:45 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.176) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:24:32 +0000
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Richard
 Cochran" <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
	<leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH v12 net-next 5/9] devlink: Add new "enable_phc" generic device param
Date: Wed, 11 Jun 2025 12:22:34 +0300
Message-ID: <20250611092238.2651-6-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611092238.2651-1-darinzon@amazon.com>
References: <20250611092238.2651-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Add a new device generic parameter to enable/disable the
PHC (PTP Hardware Clock) functionality in the device associated
with the devlink instance.

Signed-off-by: David Arinzon <darinzon@amazon.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/networking/devlink/devlink-params.rst | 3 +++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 4e01dc32..3da8f4ef 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -137,3 +137,6 @@ own name.
    * - ``event_eq_size``
      - u32
      - Control the size of asynchronous control events EQ.
+   * - ``enable_phc``
+     - Boolean
+     - Enable PHC (PTP Hardware Clock) functionality in the device.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 0091f23a..63517646 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -520,6 +520,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_IWARP,
 	DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
+	DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -578,6 +579,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_NAME "event_eq_size"
 #define DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_ENABLE_PHC_NAME "enable_phc"
+#define DEVLINK_PARAM_GENERIC_ENABLE_PHC_TYPE DEVLINK_PARAM_TYPE_BOOL
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index b29abf8d..396b8a7f 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -92,6 +92,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_NAME,
 		.type = DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
+		.name = DEVLINK_PARAM_GENERIC_ENABLE_PHC_NAME,
+		.type = DEVLINK_PARAM_GENERIC_ENABLE_PHC_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.47.1


