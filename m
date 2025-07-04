Return-Path: <netdev+bounces-204235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2AEAF9A8C
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 20:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15EA542DA6
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C911C2F8C2D;
	Fri,  4 Jul 2025 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMOHcrLx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F68F222561
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653374; cv=none; b=aZCg6D2F9Ovo7P+X0j+rl5swPNocaUBjKn04xwWtwO0b4nV6gLbeKsPDurA6hbKwsGu/BIATR1heg/HKPpYWG6D+5gvoZSfN/vzMiJVLONlz9n8cqOxwNwfToEYKiXwONHA5XDEFWMwA/+qwRu7W2BNI7pESCmsq3f9UxSSBhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653374; c=relaxed/simple;
	bh=jOhkZDTZzB322zWihp6coOxH7lruUF0QENVH2a6RZT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVB79V2oSysYgtj9Ee3lTfbMw1PsQc3DpzqozpDzFQPIkn1kfDjuzFf1nKEANm+a73Nd2qzuraoW0jJRg3DzHg2crahsKNyVALyV91rszpGuAjp3jc+c501f6rmtbQje2rax+NTJR9tXIqCNkixquzcGoXsPBGr7mxGbkBTFJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMOHcrLx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751653372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWTdHqWFWol1xVe1O6PuV7Z5hlHOPZ2EPMdjKJHoQAA=;
	b=GMOHcrLxKx6UAKjCx3xx+wNhJFclDh5oAKPGaXRApsPj4Xm6WZrjPcT5PxeSrLL+jiLTBC
	EVOBVq27da2c2ACAElS71T5zqbB7k+aT01sFgzhsD7Jqo+qNI6/0m2wMFyMOARuPJnfh2P
	Z+KIxtNeBToaKuAllL42YLNrZBHK+Xg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-gedcbrLAMVaGr0l-tyuaqA-1; Fri,
 04 Jul 2025 14:22:49 -0400
X-MC-Unique: gedcbrLAMVaGr0l-tyuaqA-1
X-Mimecast-MFC-AGG-ID: gedcbrLAMVaGr0l-tyuaqA_1751653366
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 831C61955EC1;
	Fri,  4 Jul 2025 18:22:46 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.37])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32DC919560A7;
	Fri,  4 Jul 2025 18:22:37 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v13 04/12] devlink: Add new "clock_id" generic device param
Date: Fri,  4 Jul 2025 20:21:54 +0200
Message-ID: <20250704182202.1641943-5-ivecera@redhat.com>
In-Reply-To: <20250704182202.1641943-1-ivecera@redhat.com>
References: <20250704182202.1641943-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a new device generic parameter to specify clock ID that should
be used by the device for registering DPLL devices and pins.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/networking/devlink/devlink-params.rst | 3 +++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 3da8f4ef24178..211b58177e121 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -140,3 +140,6 @@ own name.
    * - ``enable_phc``
      - Boolean
      - Enable PHC (PTP Hardware Clock) functionality in the device.
+   * - ``clock_id``
+     - u64
+     - Clock ID used by the device for registering DPLL devices and pins.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index a1fa88670754a..c8ec40780fffe 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -523,6 +523,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
+	DEVLINK_PARAM_GENERIC_ID_CLOCK_ID,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -584,6 +585,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_ENABLE_PHC_NAME "enable_phc"
 #define DEVLINK_PARAM_GENERIC_ENABLE_PHC_TYPE DEVLINK_PARAM_TYPE_BOOL
 
+#define DEVLINK_PARAM_GENERIC_CLOCK_ID_NAME "clock_id"
+#define DEVLINK_PARAM_GENERIC_CLOCK_ID_TYPE DEVLINK_PARAM_TYPE_U64
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 9709b41664aae..41dcc86cfd944 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -97,6 +97,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_ENABLE_PHC_NAME,
 		.type = DEVLINK_PARAM_GENERIC_ENABLE_PHC_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_CLOCK_ID,
+		.name = DEVLINK_PARAM_GENERIC_CLOCK_ID_NAME,
+		.type = DEVLINK_PARAM_GENERIC_CLOCK_ID_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.49.0


