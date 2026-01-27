Return-Path: <netdev+bounces-253740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LRyDL5reGlSpwEAu9opvQ
	(envelope-from <netdev+bounces-253740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:39:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CF090C6D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DED13004D8A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AADC32E757;
	Tue, 27 Jan 2026 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTjuNJts"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA4227BA4
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499576; cv=none; b=P1bjKgu2RYcSCmUjAoVhhKs3zIGF7DvUZqPV+p3NRVecETdYV+6rY4yf7gj6b2DgaK3NJrFAHeyME9y+CuTWbvJ4rVVtFZViF4B50edL9yrz5Nt1UvO8kREOUNA5ovYLeo3as7cY77/wMxL447SsYpdEPFee87/GM1/5qRXBQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499576; c=relaxed/simple;
	bh=eHi/F5rgbKOLh7VbcqHDYhy9AXrHcsfvJc2Mvm/kcHo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UqNFugdrc3kNMb6cEbjqBn7z8hK94kxCTywx2xlmuJZmRjGe0F/5/94lU/vPNUNAMNHfXVuIYVoOlNXq5RKATLNjS0sSOn8qAK01gE9Nv6qVsrFJMf7M2TjJxc/BvxniJ+m3Xaj/IldZWK6A9KlrMoQFFPSZTpTSWpaTOkfOO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTjuNJts; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769499574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bwBEw1zd5t7ZpgQXNt7Oa6aG6SzuHHJ86eogm7XJGHU=;
	b=NTjuNJts+kPRYjQ4SY9N+9pqaVLJAKtrPDtmplUvIK81f7nhMmbLrEVgWp3LU58sSNFTnj
	BVX5vAjxYRpbl0LUE4y84W5I1hfhof70OdUe8e9Z8t9gtdhBOamM+qzfE1AazIR/WZNyRT
	CpcwXMcfQqETWGkKpS3Pa4Zd0wCAJVI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-2_lOBWUsNrWB4IwVkR7Cmw-1; Tue,
 27 Jan 2026 02:39:30 -0500
X-MC-Unique: 2_lOBWUsNrWB4IwVkR7Cmw-1
X-Mimecast-MFC-AGG-ID: 2_lOBWUsNrWB4IwVkR7Cmw_1769499569
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DA661944B17;
	Tue, 27 Jan 2026 07:39:29 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.73])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A25081800665;
	Tue, 27 Jan 2026 07:39:25 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: remove impossible check in VHOST_GET_FORK_FROM_OWNER ioctl
Date: Tue, 27 Jan 2026 15:39:11 +0800
Message-ID: <20260127073921.175981-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253740-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lulu@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 50CF090C6D
X-Rspamd-Action: no action

remove impossible fork_owner check in VHOST_GET_FORK_FROM_OWNER ioctl

Fixes: 7d9896e9f6d02d8a ("vhost: Reintroduce kthread API and add mode selection")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index bccdc9eab267..889481c92236 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2338,11 +2338,6 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 	if (ioctl == VHOST_GET_FORK_FROM_OWNER) {
 		u8 fork_owner_val = d->fork_owner;
 
-		if (fork_owner_val != VHOST_FORK_OWNER_TASK &&
-		    fork_owner_val != VHOST_FORK_OWNER_KTHREAD) {
-			r = -EINVAL;
-			goto done;
-		}
 		if (put_user(fork_owner_val, (u8 __user *)argp)) {
 			r = -EFAULT;
 			goto done;
-- 
2.51.0


