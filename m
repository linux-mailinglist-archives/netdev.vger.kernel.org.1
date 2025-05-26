Return-Path: <netdev+bounces-193354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16416AC39B1
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C75171B6B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861561D5CFB;
	Mon, 26 May 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mfx/wTjA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B41C8639
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239883; cv=none; b=WijJ+BDJdnZJn4H5BKUivgnrt285JMgzkyAHv2lMc8S1kYAgjmkaXPqSLXrX/9sXPVsySsrxD8wWom94ByZHrIfgoKAZTY8JQqfYvcLCRqsxZyDrMq/xDg9gpD05/+whRIAB9fPDma7TF8P2rNWhYcF0d/9BvAA6bmup05bJxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239883; c=relaxed/simple;
	bh=fBG7vHGzry4TkJAcFlQaxGI9UIx0HmceQmTaZEiomb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAOxKF9wBdp1502A8V+43hTJUlZAj+t3g/4F8uDn77pd4bq+R5RZaH/XttVhfngzn2mZWa4kAhlIbi7cqWCzow6XAJVLdH+svF0AcnFYg9KDKfsS8FaWoJm1zK3WIp6iJorOO1orG22o471nOFZ0p+6pA3XXqunBj75zFmKpZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mfx/wTjA; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748239883; x=1779775883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8NTdfwUwWxPbIweX0G+bBJEOhBkn0DBYb7O5T0MrIbg=;
  b=mfx/wTjARP7FsOsmRzzJ8gXBhuNSG41SKGFbqJE1A0luiR/jaKxfh08d
   vR3E7FfHwgXqXBaXG31NWcv2f9fPQVAXgSKzqPTPvcavNK1Zrnk26geiI
   VnFcJWJaWC5ylML455Lf4jbcROjmT0Byfvy55C9ImkkLXqq2MoBfSn8MX
   u4URhQmEqsGa6IZaCD55xFhksx3MoE6P9fL2eAlWyLLJBdbJ5GnZDZo2o
   9/K5fAj8lBkEqp2wRcSB8tiNIU/0AQuHjF4cmYBPD8TfptrnhTFtItNE3
   tpdCdTvx9pfOoKGZPr9kcvObQ4dz21n+6zGNPp+U6FsesuLbVp6uXxa9p
   w==;
X-IronPort-AV: E=Sophos;i="6.15,315,1739836800"; 
   d="scan'208";a="97219022"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 06:11:20 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:6455]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.132:2525] with esmtp (Farcaster)
 id 66043dc7-a75c-4380-af34-6389b45a8ed7; Mon, 26 May 2025 06:11:18 +0000 (UTC)
X-Farcaster-Flow-ID: 66043dc7-a75c-4380-af34-6389b45a8ed7
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 06:11:17 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.177) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 06:11:06 +0000
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
	<leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH v11 net-next 4/8] devlink: Add new "enable_phc" generic device param
Date: Mon, 26 May 2025 09:09:14 +0300
Message-ID: <20250526060919.214-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526060919.214-1-darinzon@amazon.com>
References: <20250526060919.214-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Add a new device generic parameter to enable/disable the
PHC (PTP Hardware Clock) functionality in the device associated
with the devlink instance.

Signed-off-by: David Arinzon <darinzon@amazon.com>
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


