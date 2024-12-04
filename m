Return-Path: <netdev+bounces-148845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B0B9E3462
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B496CB2A9AA
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623E18F2E2;
	Wed,  4 Dec 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzmjPUNe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F718E750
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298449; cv=none; b=meMT9izunecYXpcPn2VBETbWqvSpKsimhZDMGwMDGUslbGCTC5R/RoG4kiUx/MO2tjyLiRtS7Yc37RZ1dVAqqmbA8HK3faquTPRfVKJ1A/iGUNtOWKrOf79UIt6hgQGk3R1oI0mjjUIbsR0UnUdCyAkxXhMerLfFdZJcHR8sywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298449; c=relaxed/simple;
	bh=xPmCsKpMpyS+IEf8Bve9mFZNuarXhCK8VeBON/LWLlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAvIMYbJMoPfl9aw8RniZvoy9qO7ZnSvcr5ccyNGv+EPG52+JcWSwIjbyTnxQsz/znReky5goLC5f3Xu2qK1inul6FCMuBl+HCmd+ySCRn+AfIUVooSOGTToUt5Gg+dj1ToqO4x1CUODmryHDyAjYopZgii64u3hPk0810l+lks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzmjPUNe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9ysnB8wbhWhwEUuu4La2Q5hcuWjOlDcwGDAFBtqHkY=;
	b=RzmjPUNeag9W4L4PPVm8+tr+Ay57GpMzCBgonO+q6VOBbMN7I9AWmKpwoetx/O7R21OBTb
	cf79P++Ive8JBLgM6K+tie+6LwQv30a1zH3fGewzwdV8618LFfFgKpXrZpr8z2eBT8tSRb
	+SrE+tvqcpHKTl+CbC4QrHkXfh5C5p8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-hl0F6zMpMsmkZEde4NIExg-1; Wed,
 04 Dec 2024 02:47:23 -0500
X-MC-Unique: hl0F6zMpMsmkZEde4NIExg-1
X-Mimecast-MFC-AGG-ID: hl0F6zMpMsmkZEde4NIExg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B12EF1955F3C;
	Wed,  4 Dec 2024 07:47:21 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 542371956048;
	Wed,  4 Dec 2024 07:47:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH net-next v2 01/39] ktime: Add us_to_ktime()
Date: Wed,  4 Dec 2024 07:46:29 +0000
Message-ID: <20241204074710.990092-2-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a us_to_ktime() helper to go with ms_to_ktime() and ns_to_ktime().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/linux/ktime.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 3a4e723eae0f..383ed9985802 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -222,6 +222,11 @@ static inline ktime_t ns_to_ktime(u64 ns)
 	return ns;
 }
 
+static inline ktime_t us_to_ktime(u64 us)
+{
+	return us * NSEC_PER_USEC;
+}
+
 static inline ktime_t ms_to_ktime(u64 ms)
 {
 	return ms * NSEC_PER_MSEC;


