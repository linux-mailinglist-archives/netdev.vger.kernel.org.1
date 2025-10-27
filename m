Return-Path: <netdev+bounces-233200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF69C0E67E
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7E9A505F77
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C1306D5F;
	Mon, 27 Oct 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlxsaICD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6A19ADBA
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574165; cv=none; b=TuZ9fGIiMlCzSAHDRAi6L6F5W5Cn5u3aVZa+X+dHGLLo0+inct076eG/1k6WXEYlf3ry9LWECL5OUg2bdL9SjXwtysLAqfYRDStrjl7XMM4I+HWG3ne0eSFHTNGe+bRsjn2kmTx2JUx5kYBkRFnj7x+CJv30crtZC75i5B2Vl1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574165; c=relaxed/simple;
	bh=ohFeWLqPsM8ga2STusY4gb1aFRLI4XhV6ujvnxl2FGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sd93OHeGr6YDdSzGm6DvkYhHwP/PvHB1VnY2xA75PlkbbK2t3PxW0T6lkNR0+EmDYU3e89Jn9RCG5Nrg4jTqYKYFQhPjs22EmpSthsODi/enEcON+vYqHElyGSskrohdib2T6S5DQX5Bq3zk2KMvoeCW89pwOoIWdnlM4wiVeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlxsaICD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761574163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pRPv3WhCuVa4kMdSJmgycflYd8utKoBdcV1pgALpUJE=;
	b=OlxsaICDSQMyRNbwxT03hgM5v3/4p3p+JHj8ovczH9960zy0cXJSMt7amPBMGFloCFKjVq
	xhkw0Ai4TJwKTUh1+9sV98hdlrbC1Dq1rYy9BIdFdLWX0vtAYtVlVta9u/5Gu4jC5Abqjd
	HguG8AHlFBjo2BdWLZ8jt7Mipi3oonI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-3wjmptQJPqKuBaEbV15d-w-1; Mon,
 27 Oct 2025 10:09:19 -0400
X-MC-Unique: 3wjmptQJPqKuBaEbV15d-w-1
X-Mimecast-MFC-AGG-ID: 3wjmptQJPqKuBaEbV15d-w_1761574158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B48D31808997;
	Mon, 27 Oct 2025 14:09:17 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.43])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E13AB1800452;
	Mon, 27 Oct 2025 14:09:13 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] dpll: zl3073x: Fix output pin registration
Date: Mon, 27 Oct 2025 15:09:12 +0100
Message-ID: <20251027140912.233152-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, the signal format of an associated output is not considered
during output pin registration. As a result, the driver registers output
pins that are disabled by the signal format configuration.

Fix this by calling zl3073x_output_pin_is_enabled() to check whether
a given output pin should be registered or not.

Fixes: 75a71ecc2412 ("dpll: zl3073x: Register DPLL devices and pins")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 93dc93eec79e..f93f9a458324 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1904,7 +1904,7 @@ zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
 		}
 
 		is_diff = zl3073x_out_is_diff(zldev, out);
-		is_enabled = zl3073x_out_is_enabled(zldev, out);
+		is_enabled = zl3073x_output_pin_is_enabled(zldev, index);
 	}
 
 	/* Skip N-pin if the corresponding input/output is differential */
-- 
2.51.0


