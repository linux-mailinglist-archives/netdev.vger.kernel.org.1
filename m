Return-Path: <netdev+bounces-167453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEE0A3A5AC
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1757A329C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46D2356CE;
	Tue, 18 Feb 2025 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DykMx13S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584A2356C2
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903577; cv=none; b=lkWJxcgQOwrNFNg92/j6E6pGWOzy73P+1zLbV9QNQ91vgIlhvvyjIgivhEvIKH1RG2cSQsLcmAxs2VI0LC1duoAkx5Isfz+cxQD06RcxPEoGFUHCC6LzuTjOgCRI+PWLtAm3u5JqGoyAAlnHJjYvF4kRMHxPkxlDOOLd8UmnVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903577; c=relaxed/simple;
	bh=dkxOWERFU1sVRTdDubommMaOy392H2WDK0zyxNjNBtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rU/Hyq8ghphKWHX8N3FhV8UUnd7/E5aK1F47+XwtcB/ahwToPSZXjG5vJSNi7up/gHsiuhwG9VFE94QOJC15wjppXrT9hGEBUB4rPHEy93V+4n/5wvV0G41wbUQd3+yy5QV5+Hlo8j6BnHUN5J/6wmA1ygLkcFpCNKH78jfXqrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DykMx13S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739903574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GVyq+GOSNOo0iyInEkmtqNV6kcoyYMj/3PVF57fvTeA=;
	b=DykMx13SlYIOFoWEMWqpprNi3W0YvekZxu/DOaQRy8KfHe1hVvQypJmD3sKuoplKH0Z4IB
	qkqqzJ7kQ6oqIyVcmLrrkhnU7F+p6uZl1FboUOmmDibzoi9eeD/hVRTtDXABxOv1R/5bfc
	kAnMzk8x+aqucUWET2Hxj07koijBwoc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-IX2OjAXyMvOgOyGkYEiTpw-1; Tue,
 18 Feb 2025 13:32:47 -0500
X-MC-Unique: IX2OjAXyMvOgOyGkYEiTpw-1
X-Mimecast-MFC-AGG-ID: IX2OjAXyMvOgOyGkYEiTpw_1739903566
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CEE0190F9C8;
	Tue, 18 Feb 2025 18:32:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.155])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BADDA1956094;
	Tue, 18 Feb 2025 18:32:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v2 net 0/2] net: remove the single page frag cache for good
Date: Tue, 18 Feb 2025 19:29:38 +0100
Message-ID: <cover.1739899357.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This is another attempt at reverting commit dbae2b062824 ("net: skb:
introduce and use a single page frag cache"), as it causes regressions
in specific use-cases.

Reverting such commit uncovers an allocation issue for build with 
CONFIG_MAX_SKB_FRAGS=45, as reported by Sabrina.

This series handle the latter in patch 1 and brings the revert in patch
2.

Note that there is a little chicken-egg problem, as I included into the
patch 1's changelog the splat that would be visible only applying first
the revert: I think current patch order is better for bisectability,
still the splat is useful for correct attribution.

Paolo Abeni (2):
  net: allow small head cache usage with large MAX_SKB_FRAGS values
  Revert "net: skb: introduce and use a single page frag cache"

 include/linux/netdevice.h |   1 -
 include/net/gro.h         |   3 ++
 net/core/dev.c            |  17 ++++++
 net/core/gro.c            |   3 --
 net/core/skbuff.c         | 110 ++++----------------------------------
 5 files changed, 30 insertions(+), 104 deletions(-)

-- 
2.48.1


