Return-Path: <netdev+bounces-135690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA9899EE7C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3E31F273CA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAC31AF0C2;
	Tue, 15 Oct 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrWSwo1U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169AB1AF0B6
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000617; cv=none; b=uuVGXa9ilXIEloYjUfzjYM+4Rb2nmvHYeUeF+YheH5DSmlWeFZICW9TNVtVl8gT8cK99mhHEYtJJVlmqsV0QyPJCP5cUaMPg29zPLMf+R6wLq7zdI59j71Y26TrW+zyleXiw/3YRBXQkJ2lNgmVg1VH6nVALMwkDEcVtpqgu/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000617; c=relaxed/simple;
	bh=hzjyVKiMEK7o/MkoWuV9NPDsbmnMSRaNYWFBWidLsLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGdSiNV+dtrV1Kebyl/DCrugBkQnVaOgPXBTmNPOyLNFhxOMqM82QJW+0Miqzh8Np6qcaRX6TBTcqkE40Nfg/YeE8GkVmDNXVYvmHmM/L48OSKKb+ROmoWTNkGS5MPAxn/tFYmhjXMGR5fLEZAcOCRriqwgBL4pHLhyF61AXBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrWSwo1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729000614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cJuW/lIJTyrbV7NpVcyI1HzN779Z0hNFw3YsExR+ltU=;
	b=MrWSwo1U1xqBxySKau4EPqDDNSIgG/YBMOo68YPNuOkgCVCM1R+kl45KeeLhiWfDE4eWoz
	7KXaytPkBU7nPz3XLWbRWCuLOFyQdBVBzTVmtnJxNOPBT1OwNz/AkTllyka4NJ5ldug0CJ
	dL9iVkZI1XKt/eMjPUqnt4/P1vlW/fE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-Bqk1wIAkO2W1ervTX_13kw-1; Tue,
 15 Oct 2024 09:56:53 -0400
X-MC-Unique: Bqk1wIAkO2W1ervTX_13kw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 489B21953961;
	Tue, 15 Oct 2024 13:56:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.244])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84ADC19560A3;
	Tue, 15 Oct 2024 13:56:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wenjun Wu <wenjun1.wu@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH iwl-next] virtchnl: fix m68k build.
Date: Tue, 15 Oct 2024 15:56:35 +0200
Message-ID: <e45d1c9f17356d431b03b419f60b8b763d2ff768.1729000481.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The kernel test robot reported a build failure on m68k in the intel
driver due to the recent shapers-related changes.

The mentioned arch has funny alignment properties, let's be explicit
about the binary layout expectation introducing a padding field.

Fixes: 608a5c05c39b ("virtchnl: support queue rate limit and quanta size configuration")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410131710.71Wt6LKO-lkp@intel.com/
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/avf/virtchnl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 223e433c39fe..13a11f3c09b8 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -1499,6 +1499,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_queue_chunk);
 
 struct virtchnl_quanta_cfg {
 	u16 quanta_size;
+	u16 pad;
 	struct virtchnl_queue_chunk queue_select;
 };
 
-- 
2.45.2


