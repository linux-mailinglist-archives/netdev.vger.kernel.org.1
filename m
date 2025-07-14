Return-Path: <netdev+bounces-206590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A105FB039D1
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5DD189A35E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1859623E335;
	Mon, 14 Jul 2025 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNHdiavv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C123D2B4
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482897; cv=none; b=hTwZauJTv9ODznjT0CdxW9FqQ7Apl90D8pGfWg+LAqcbyqw6SipeFnWo55jcUwhMUc7mF2zvlOX54RBT37GbPX0y2cR9fU9XxkOP//9YYhD0kxI3x6BgNUhRB+HBG4TAO0YqSpCtZrSistgPNtiKZ0F7tMUSR0tp6RfmlfmsTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482897; c=relaxed/simple;
	bh=U07cQxAmAHW0l8o/qdYSoRO4Bi1qjKGeW+p5fMARMQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuzcgjGtb+zN/QEhVxnYcQENrGt4zrt1jlwwxiQHyqZCzTQBTmVZWPuEnbjLE5Bp92fXukVFGyWarwRECOx/Tqf7I4v0xdQxOo3E3r4/NOkbpU/kQele7z9QgAJDsWMXYtIqXd3fe0iuHfAzIbSecBZQvjHsoHkbJ3Ak4kHuvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNHdiavv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752482894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwtbBiuZ1OgDvhN1Fwx3QN8iamrnQZ8Wagomy6Ufebc=;
	b=KNHdiavvbLUjqbw9ddbFPOThO5SCCagNCA2ZKB/ncO9nYRP1fGY9YxwGEcDIciAPtCn3Nw
	YjLKIQpDj0zHNxZjmS9ozd683fe2i4R3gcA+7CHDDn/JKqQwxsrIOKSTXVVEOBHcVKpR0c
	x/anfDhw/RbqA++ppuozwGLEPMuQJjA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-9hQ_uzYyPzGEpOhpKRDbcw-1; Mon,
 14 Jul 2025 04:48:11 -0400
X-MC-Unique: 9hQ_uzYyPzGEpOhpKRDbcw-1
X-Mimecast-MFC-AGG-ID: 9hQ_uzYyPzGEpOhpKRDbcw_1752482890
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4EF91808985;
	Mon, 14 Jul 2025 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3EF51803AF2;
	Mon, 14 Jul 2025 08:48:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jonah.palmer@oracle.com
Subject: [PATCH net-next V2 1/3] vhost: fail early when __vhost_add_used() fails
Date: Mon, 14 Jul 2025 16:47:53 +0800
Message-ID: <20250714084755.11921-2-jasowang@redhat.com>
In-Reply-To: <20250714084755.11921-1-jasowang@redhat.com>
References: <20250714084755.11921-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This patch fails vhost_add_used_n() early when __vhost_add_used()
fails to make sure used idx is not updated with stale used ring
information.

Reported-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3a5ebb973dba..d1d3912f4804 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2775,6 +2775,9 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 	}
 	r = __vhost_add_used_n(vq, heads, count);
 
+	if (r < 0)
+		return r;
+
 	/* Make sure buffer is written before we update index. */
 	smp_wmb();
 	if (vhost_put_used_idx(vq)) {
-- 
2.39.5


