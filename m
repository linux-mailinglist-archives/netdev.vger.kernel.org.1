Return-Path: <netdev+bounces-99491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB68D50D9
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49751F23221
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72A446B4;
	Thu, 30 May 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQLORztO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7115A2D05D
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089512; cv=none; b=SSoP0cCY1kF0oza+H6snqVvrBjwd2aUVQMakySCqe5y7Ahegx2uIaE1BtrR6pD/kxNoSuXxhMRBmjWmGK2LQ+6g1uPuCSdQBIJQXOzs+0qexGyFdh4H57jGYrSMhxhQox3iWa/wOSg38dl/Dz8sOGXHA3Oen3wRTTM6MKG7PK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089512; c=relaxed/simple;
	bh=ae0UZHN5C5u60tzG0EO7fRASvkFDo7KngxLc/NjlSjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fVFhGN0Q29ANMXOc3YU5BqdpLDUX3vnoeMOZDucZrF3yN6SbN5R1U3tIpOAMAcehAkTA8oOLqVf+pyNBG4SiW7ycuUD8HOer3zjTueAss3Ia7im6t8Ma9WcJ91w+5CqIBzbqcGaAG38DNSCRzPDFP3zo/RsUSbPhai8bU7HpreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQLORztO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717089509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NRuc/cGOrwWiqdl2MJE6Tlnnm8j9pDoDDCIEzj9ZG7Y=;
	b=UQLORztOndrEjACoPYL8Gke6T6AFegz7veGqjayHY30b8oaWoa6IHh1f0T6VcMerInUEl2
	gQkTB+qbeECHvF7ibIib04iDTqCUhfU/Ungq1BkV94oscoKxw7hkOeFJtKF4EHehhEUtW5
	qOaXst6e+fOESbZr/z7vxScPsCmX4CM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-8JhZ5tYjMMiNogBQgb94Nw-1; Thu, 30 May 2024 13:18:25 -0400
X-MC-Unique: 8JhZ5tYjMMiNogBQgb94Nw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38CA685A58C;
	Thu, 30 May 2024 17:18:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 329E840C6EB7;
	Thu, 30 May 2024 17:18:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] dst_cache: cope with device removal
Date: Thu, 30 May 2024 19:18:08 +0200
Message-ID: <cover.1717087015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Eric reported a net device refcount leak and diagnosed the root cause
as the dst_cache not coping well with the underlying device removal.

To address such issue, this series introduces the infrastructure to let
the existing uncached list handle the relevant cleanup.

Patch 1 and 2 are preparation changes to make the uncached list infra
more flexible for the new use-case, and patch 3 addresses the issue.

---
Targeting net-next as the addressed problem is quite ancient and I fear
some unexpected side effects for patch 2.

Paolo Abeni (3):
  ipv6: use a new flag to indicate elevated refcount.
  ipv4: obsolete routes moved out of per cpu cache
  dst_cache: let rt_uncached cope with dst_cache cleanup

 include/net/ip6_fib.h | 3 +++
 net/core/dst_cache.c  | 8 ++++++++
 net/ipv4/route.c      | 2 +-
 net/ipv6/route.c      | 4 ++--
 4 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.43.2


