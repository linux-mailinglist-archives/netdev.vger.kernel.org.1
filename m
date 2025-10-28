Return-Path: <netdev+bounces-233665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E64BC172C8
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C55EC4FA72B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A493570B2;
	Tue, 28 Oct 2025 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKc0SbQj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB63563FB
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689888; cv=none; b=fSl/oeuMZ1TXgZfHjPz7GfUIvl/xLinILY6nwp77tmUUSRT9hajAU2Q0LXHF/zSsk2raBI1b3pOj800T4nVthZCHsJblBJmoV5wz2zCXmHoU9phZDnEjfhMYK6fqJ/TpntCY3367Nzn13L53V5fI5OXayKH45oWMNk72543CulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689888; c=relaxed/simple;
	bh=KzitQ7RNgPpmw46N5AHz1eHhZnAYky591RQ7JagA5e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYbryhwNEV+wZLpzTB60oO/YJDYqhrNkvSRhGc0sYFiEQUiaBFsCZ2GPM/6i8BV31RIEVbrqMllvBMCp+KxOpC8ikismRk7G9L2zP1ErgR5ObTKsuFMPVFRj+xu2khqcaOWhY7yaqWDy5jJGHbQS9+9PixKD6CUjz4Eogg6X860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKc0SbQj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761689885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=giIoALAPziUptwR1VcP5QStt81efmP2tkBAqcoNfvjI=;
	b=GKc0SbQj8OF+00yuvIULQf65L5ODFXFL2CXo/WsOEHfZ+GqsLrDw4RWfoJJgcZ4P7kkQQK
	ILPo12RfA45VWXLaD/o/YSyCAMRR2QhFI0QeFBtb40w2XCnmze5eYUkDxgnLgd5hU8TdSy
	favGiv8NciKe0Yjh/NwkOjK1kWjeU+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-HoCjsqNRNFm2RlzqFDN1RA-1; Tue,
 28 Oct 2025 18:18:04 -0400
X-MC-Unique: HoCjsqNRNFm2RlzqFDN1RA-1
X-Mimecast-MFC-AGG-ID: HoCjsqNRNFm2RlzqFDN1RA_1761689883
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D74F51953985;
	Tue, 28 Oct 2025 22:18:02 +0000 (UTC)
Received: from tc2.redhat.com (unknown [10.45.224.95])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7EB0180035A;
	Tue, 28 Oct 2025 22:18:00 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2] netshaper: fix build failure
Date: Tue, 28 Oct 2025 23:17:56 +0100
Message-ID: <bda34400c9bdddd48e15526f9a8e203b1a849e45.1761689740.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

netshaper fails to build from sources with this error:

$ make
netshaper
    CC       netshaper.o
    LINK     netshaper
/usr/bin/ld: ../lib/libutil.a(utils_math.o): in function `get_rate':
utils_math.c:(.text+0x97): undefined reference to `floor'
/usr/bin/ld: ../lib/libutil.a(utils_math.o): in function `get_size64':
utils_math.c:(.text+0x2a8): undefined reference to `floor'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:10: netshaper] Error 1
make: *** [Makefile:81: all] Error 2

Fix this simply linking against the math C library, similarly to what we
already did with commit 1a22ad2721fb ("build: Fix link errors on some
systems").

Fixes: 6f7779ad4ef6 ("netshaper: Add netshaper command")
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 netshaper/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/netshaper/Makefile b/netshaper/Makefile
index 3b293604..54a6a691 100644
--- a/netshaper/Makefile
+++ b/netshaper/Makefile
@@ -3,6 +3,7 @@ include ../config.mk
 
 NSOBJ = netshaper.o
 TARGETS += netshaper
+LDLIBS += -lm
 
 all: $(TARGETS) $(LIBS)
 
-- 
2.51.1


