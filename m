Return-Path: <netdev+bounces-94492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96BA8BFB19
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACC51F22FA6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2369A7C08F;
	Wed,  8 May 2024 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRkEitQ4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895692836D
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164750; cv=none; b=a/IqTMJW4A9kiOlb69EclUDI9GL2s27dUCdYr1/BTQcK+BY8LM4XwJyl+2zFbmqXn7yd0O/cFsiuupCrNsO56u011JYwvb+eqCLd1S9Idkg4dk0CoHkw6al2FL5iaH1TaawK/Agme+OgTvlLDGKKEYld1DniJAJoUK6G0EkY9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164750; c=relaxed/simple;
	bh=YXNybCmdD0cX90rP7knyBn3ABtTb/ix7lSNzwC7WBXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZSIFOWpBPJtk33+62GO6+AholFt+4ddY6m5hxotUUBDxiEbe09AufGkFjzqjnPbDbpoRbwIcBU3U1UmG0M7puTjzJAvLRgzXpo/8AKo9CseV9SQA1b4cwVRn2z27wOwrXHonIs6O8ul5z+vp+RJirrWjPcekm4/AJ6Ejiwv2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRkEitQ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715164747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rljQqv49klU+q6EQwFWdfti7B1JNGp/+41eQrpaWnqQ=;
	b=HRkEitQ4lQIYC5Cq88StgBDpdB2cJqSIPxRRkzmZPfD9XAmCHciqT6tRublA4fO/YgMKlB
	itiSu7GYqeK4OhZ4O4vRlR1XVddgv5LGuAwRhcNoMPyhoJF5vVZn2ByvOQOiQzVp1WLPs8
	HkvO1FAOn7EK47/8d6xSKyBmh5W85pU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-ycAsKtVSOKO8zYkMXE5fCA-1; Wed,
 08 May 2024 06:39:04 -0400
X-MC-Unique: ycAsKtVSOKO8zYkMXE5fCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D52A93800094;
	Wed,  8 May 2024 10:39:03 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.192.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B23AC2022F10;
	Wed,  8 May 2024 10:39:02 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2] man: fix typo in tc-mirred man page
Date: Wed,  8 May 2024 12:38:52 +0200
Message-ID: <83c969899db103576310bf3837595ab32984c8b4.1715164702.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 man/man8/tc-mirred.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
index 46d894ce..6959e3e6 100644
--- a/man/man8/tc-mirred.8
+++ b/man/man8/tc-mirred.8
@@ -37,7 +37,7 @@ receives. Mirroring is what is sometimes referred to as Switch Port Analyzer
 (SPAN) and is commonly used to analyze and/or debug flows.
 When mirroring to a tc block, the packet will be mirrored to all the ports in
 the block with exception of the port where the packet ingressed, if that port is
-part of the tc block. Redirecting is simillar to mirroring except that the
+part of the tc block. Redirecting is similar to mirroring except that the
 behaviour is to mirror to the first N - 1 ports in the block and redirect to the
 last one (note that the port in which the packet arrived is not going to be
 mirrored or redirected to).
-- 
2.45.0


