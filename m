Return-Path: <netdev+bounces-168616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B8A3FB08
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB48E4433BA
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F521516D;
	Fri, 21 Feb 2025 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAqR+Rxb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087E215163
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154471; cv=none; b=AuiA6lVAmopvfxMvrkzIQwZOk62FKcP3gvuXW2oTBUdPEdu741ppBosS3TZy6ZEJHfDPpaiNfgecvtKaHH+zYyT8ujwb96rGEe4BeJ6l2+bwtGg0PXNC8VYKjJIsUXfd5y+DUE1zydUf1baBDYCFhDS6alZKksYi0mDddpZBmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154471; c=relaxed/simple;
	bh=hLxk2Ic4xyTQDKeXAxbqDq8niaFTtdHTs3PNwXmNuwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYdPtLWX7zyozQJh7OB5rf1b1sgS8E6Bhhnz2VG2H7M5xtUXvfOEyApFAVJJOUbKbu4paMj9UnK9Ib/ZBGhISTjFNJS3FJCfWGZKYguBg+FQmxmPblN1iEbv2fRC1M+XDGN4oaTSIoVDexyN5DhQeQtJ+yVw8kQ7BvDaPyBLfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAqR+Rxb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740154467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c1WB965ckxf2wQP2lFTjkhbk5jOg6ny1d5eOCbOADhQ=;
	b=DAqR+RxbMCQhRpHmNeAu6lbTP5cZcYptrBm3UgQucyY2rkg/1/nvoKWqKt/fljcdh2SzNQ
	oaKFe74WZDwBiTTC6KqXy17dEdhyw9EWVhgOt3zU9vJAprE05Ukam7XXMuEbYD5Wb45Wba
	+TVmkPKzDYpKC9HP5/UssSOOgGFcD8U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-wzI8wtNpNdS2ceE8dJxj-A-1; Fri,
 21 Feb 2025 11:14:26 -0500
X-MC-Unique: wzI8wtNpNdS2ceE8dJxj-A-1
X-Mimecast-MFC-AGG-ID: wzI8wtNpNdS2ceE8dJxj-A_1740154465
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C064180087A
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 16:14:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.47.238.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10011180035F;
	Fri, 21 Feb 2025 16:14:23 +0000 (UTC)
From: Mohammad Heib <mheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net] net: Clear old fragment checksum value in napi_get_frags
Date: Fri, 21 Feb 2025 18:14:05 +0200
Message-ID: <20250221161405.1921296-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In certain cases, napi_get_frags() returns an skb that points to an old
received fragment, This skb may have its skb->ip_summed, csum, and other
fields set from previous fragment handling.

Some network drivers set skb->ip_summed to either CHECKSUM_COMPLETE or
CHECKSUM_UNNECESSARY when getting skb from napi_get_frags(), while
others only set skb->ip_summed when RX checksum offload is enabled on
the device, and do not set any value for skb->ip_summed when hardware
checksum offload is disabled, assuming that the skb->ip_summed
initiated to zero by napi_get_frags.

This inconsistency sometimes leads to checksum validation issues in the
upper layers of the network stack.

To resolve this, this patch clears the skb->ip_summed value for each skb
returned by napi_get_frags(), ensuring that the caller is responsible
for setting the correct checksum status. This eliminates potential
checksum validation issues caused by improper handling of
skb->ip_summed.

Fixes: 76620aafd66f ("gro: New frags interface to avoid copying shinfo")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 net/core/gro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 78b320b63174..e98007d8f26f 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -675,6 +675,8 @@ struct sk_buff *napi_get_frags(struct napi_struct *napi)
 			napi->skb = skb;
 			skb_mark_napi_id(skb, napi);
 		}
+	} else {
+		skb->ip_summed = CHECKSUM_NONE;
 	}
 	return skb;
 }
-- 
2.48.1


