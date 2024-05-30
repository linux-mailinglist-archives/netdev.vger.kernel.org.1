Return-Path: <netdev+bounces-99492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3EA8D50EA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066C01F24B5B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196F3BB2E;
	Thu, 30 May 2024 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQmh31We"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059E45BEF
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089680; cv=none; b=pDZoejVaueR/Fl9HZBVE3tLPw1MbDuDQreULi+UDgYH4CkteLwyMc0GKUcRVFtNeFErwdhai2JVycY4dYOs6TfW0OLkjEEnDu0bEpKCvI727TgMeGjAE/bD+EOvNwdFFIuo09Ex+NVAIGUtG8B3aE9JeNBV5cZ2EollgdwebTy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089680; c=relaxed/simple;
	bh=ae0UZHN5C5u60tzG0EO7fRASvkFDo7KngxLc/NjlSjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tB8vxf/jh9QPEZPxnxR+RvgLnTlDVratedB23zJCAM8wrTntghPBLmCu29CCKYsqpk/BTpu4YIK+etyoqHGmwSG7oXdg5Wi4i08jj3AFKrqerUwoKn3/GJV/IEGgtd9HCifcPgcDRGz7TnrVPwjjPpaqdlA3ezFSeQkGhOd+jk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQmh31We; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717089677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NRuc/cGOrwWiqdl2MJE6Tlnnm8j9pDoDDCIEzj9ZG7Y=;
	b=cQmh31Weah9d1BzJI9QZZInV0EmGQ9B272+GdxYJlqaBonmQy0FJr+5WE7BmxLkncs6I56
	gLsZdB282bhg0dXRn+eAvVCqhtHn7H749BpCfC3vYtEdKnyxcV0NUUQ5QLTMUoyMMYASRd
	+j+mLo/2Nx0h1aPqHMPMl+gd/Cnbt9g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-uk4w2-qMPvmMgGv8_pO7fg-1; Thu,
 30 May 2024 13:21:14 -0400
X-MC-Unique: uk4w2-qMPvmMgGv8_pO7fg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21D4B3C025AC;
	Thu, 30 May 2024 17:21:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 028674026B8;
	Thu, 30 May 2024 17:21:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] dst_cache: cope with device removal
Date: Thu, 30 May 2024 19:21:00 +0200
Message-ID: <cover.1717087015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

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


