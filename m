Return-Path: <netdev+bounces-36474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315B77AFE7B
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 10:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4BE9E1C20A82
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7D5395;
	Wed, 27 Sep 2023 08:31:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906071B269
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:31:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E4E5
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695803510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7aIMO5UwZ/UfgDo/+bLg5FMzWKeKrf87yyew+23Pgw=;
	b=OD4Pq9DIHzsZqMRffE5u/f4ZXjJR69fbgGYFnplYtKToO6aahfMXyqXR85YZdTfURPFZou
	Xz2HCJqEflU/nj6GYzr/PZKUATw1xoV0oQ9rMqDtMzLxorMHOxi81VbLC0Cd4oH/9Y1xZp
	8FWFeSGMeiA+7lPmy5touJbeEJI7kbE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-686-P5qYI-otMkKihJinav5C3w-1; Wed, 27 Sep 2023 04:31:46 -0400
X-MC-Unique: P5qYI-otMkKihJinav5C3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29C6885A5BD;
	Wed, 27 Sep 2023 08:31:46 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 664D42156702;
	Wed, 27 Sep 2023 08:31:44 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: poros@redhat.com,
	mschmidt@redhat.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next v2 4/9] virtchnl: Add header dependencies
Date: Wed, 27 Sep 2023 10:31:30 +0200
Message-ID: <20230927083135.3237206-5-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-1-ivecera@redhat.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The <linux/avf/virtchnl.h> uses BIT, struct_size and ETH_ALEN macros
but does not include appropriate header files that defines them.
Add these dependencies so this header file can be included anywhere.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 include/linux/avf/virtchnl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index dd71d3009771..6b3acf15be5c 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -4,6 +4,10 @@
 #ifndef _VIRTCHNL_H_
 #define _VIRTCHNL_H_
 
+#include <linux/bitops.h>
+#include <linux/overflow.h>
+#include <uapi/linux/if_ether.h>
+
 /* Description:
  * This header file describes the Virtual Function (VF) - Physical Function
  * (PF) communication protocol used by the drivers for all devices starting
-- 
2.41.0


