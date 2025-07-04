Return-Path: <netdev+bounces-204234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F8AF9A88
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 20:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038697B9F55
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECCE1F4C8E;
	Fri,  4 Jul 2025 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9ooHb8J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A331386B4
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653366; cv=none; b=Tv6HPKJLUCLoxg1tLZvgfVDlQ8mu15zVQtx9DQO4rgE2WGFRKhtnnx9MhS7L1D75Ugdmms62GgkSPi25eYaeqFiFfC/1vmhRu46BllXa6qvy6vuVaDQ41gDVlX5c052rx8yIo/04ThTWJgQdpQldXLMo+HrKOmTzh58jaJLXQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653366; c=relaxed/simple;
	bh=0JDOS5w39GHYVPU6Q1btfFoTrva5ZjTvleJYBGHXofc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOcC0aE/DIeMYnS7SL9wq4qyUkngJMW8RRmlAyGGwVjqT9RxL2gkEnUFHGvQCNEXqVXh2NTOTn10OMODars0w9Og6/WgBvs1ToIwn0FSAeiCwpavJHy57KlC6t/HLnUDJkezZz9V5TcFkWJaNOgNOolSyJzfxqjKpj54bh1sS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9ooHb8J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751653363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rTIOjfvRH4KTJEolSOIYnKAU7C9JxqZD1p5vlyh71M=;
	b=J9ooHb8JYn+8E4gw64PsMGQyMPo3BoMPZuI5/mPRnQ663LSiTtvB0houxbyGC4hZ2Vxe0b
	7Q15ONgM+fnXSBxt44hJ/7dA0LIQYptsaLjywB0kcyRX1irVCBxl9CC4LJQ4GYn7/cpJP9
	DHXtMSd9Bp3mQTeRBxpg54hovIa+gwY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-_v74VjYMMW-6Htz78WvBWg-1; Fri,
 04 Jul 2025 14:22:40 -0400
X-MC-Unique: _v74VjYMMW-6Htz78WvBWg-1
X-Mimecast-MFC-AGG-ID: _v74VjYMMW-6Htz78WvBWg_1751653358
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80E00180135B;
	Fri,  4 Jul 2025 18:22:37 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.37])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 240AB19560A7;
	Fri,  4 Jul 2025 18:22:29 +0000 (UTC)
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
Subject: [PATCH net-next v13 03/12] devlink: Add support for u64 parameters
Date: Fri,  4 Jul 2025 20:21:53 +0200
Message-ID: <20250704182202.1641943-4-ivecera@redhat.com>
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

Only 8, 16 and 32-bit integers are supported for numeric devlink
parameters. The subsequent patch adds support for DPLL clock ID
that is defined as 64-bit number. Add support for u64 parameter
type.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 include/net/devlink.h |  2 ++
 net/devlink/param.c   | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 63517646a4973..a1fa88670754a 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -423,6 +423,7 @@ enum devlink_param_type {
 	DEVLINK_PARAM_TYPE_U8 = DEVLINK_VAR_ATTR_TYPE_U8,
 	DEVLINK_PARAM_TYPE_U16 = DEVLINK_VAR_ATTR_TYPE_U16,
 	DEVLINK_PARAM_TYPE_U32 = DEVLINK_VAR_ATTR_TYPE_U32,
+	DEVLINK_PARAM_TYPE_U64 = DEVLINK_VAR_ATTR_TYPE_U64,
 	DEVLINK_PARAM_TYPE_STRING = DEVLINK_VAR_ATTR_TYPE_STRING,
 	DEVLINK_PARAM_TYPE_BOOL = DEVLINK_VAR_ATTR_TYPE_FLAG,
 };
@@ -431,6 +432,7 @@ union devlink_param_value {
 	u8 vu8;
 	u16 vu16;
 	u32 vu32;
+	u64 vu64;
 	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
 	bool vbool;
 };
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 396b8a7f60139..9709b41664aae 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -200,6 +200,11 @@ devlink_nl_param_value_fill_one(struct sk_buff *msg,
 		if (nla_put_u32(msg, DEVLINK_ATTR_PARAM_VALUE_DATA, val.vu32))
 			goto value_nest_cancel;
 		break;
+	case DEVLINK_PARAM_TYPE_U64:
+		if (devlink_nl_put_u64(msg, DEVLINK_ATTR_PARAM_VALUE_DATA,
+				       val.vu64))
+			goto value_nest_cancel;
+		break;
 	case DEVLINK_PARAM_TYPE_STRING:
 		if (nla_put_string(msg, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				   val.vstr))
@@ -434,6 +439,11 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 			return -EINVAL;
 		value->vu32 = nla_get_u32(param_data);
 		break;
+	case DEVLINK_PARAM_TYPE_U64:
+		if (nla_len(param_data) != sizeof(u64))
+			return -EINVAL;
+		value->vu64 = nla_get_u64(param_data);
+		break;
 	case DEVLINK_PARAM_TYPE_STRING:
 		len = strnlen(nla_data(param_data), nla_len(param_data));
 		if (len == nla_len(param_data) ||
-- 
2.49.0


