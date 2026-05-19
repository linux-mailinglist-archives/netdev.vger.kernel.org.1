Return-Path: <netdev+bounces-289607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJT9NcLJDGrAlwUAu9opvQ
	(envelope-from <netdev+bounces-289607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:36:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C8F584C2A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30037302A4C4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D6E3BD63B;
	Tue, 19 May 2026 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Syds0zMU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C53BB680
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222937; cv=none; b=JKDl/vcpFkEwP+EIPWQ5ml3F2F6VSZn/TLS07/2ZOzKQEW304/tvzrGGtrpZOKGsWyzoV6qa4NxxpVXYtsG5aeOKkNQSsHNwupa5cxa83wYgdd9jnWwpbayF+E4aUctnsQjGAp5EXAR6tFApdhc3Zvisk/81WlByM0YWCH4aeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222937; c=relaxed/simple;
	bh=5nJqDD/dXtl9IILNdZwN304brhy7+urj60vJWRhs4Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXNjbnUxe88PJFlXShqt5kObKizR3VnscO+kLPM6g9K4WmmQZvYS53nGOqNInF331INHODl1/P6CiAQo/XeY/RVbQQBnhLA0Eq18cbbbygn0Zc6iHk4h7IInkUeR7zwoGND6Ga+EHKDPsIYqFOaTtW1EiX1jR6YV7nJ6cTijYvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Syds0zMU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so19957745e9.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779222934; x=1779827734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2iG1hz81YAuxXAiaPdaZ3OGfdkiju2FjT0lpwqJRqQ=;
        b=Syds0zMUNLUQH1tYRXypJNoepH1zZksTSknTM4XtDa9kmqg87iNHufLDAJIy/a9xxx
         lsegPg/0b2LYqktvO6Unryvegju0ik3q49nvfnTwsUTEZMfqnbm0t5Kn+c/gTmvOAjfL
         A9OZ8cx8ykCfAIWwtCTzxAI9WJPTmWBhpOLn/D7yOeYB3wOC0y9p6at61my2c4PPkhXr
         kklHwscHjEu5G+eOLdRYUO7oJcJuivtJnh3sP3Ve+SYbMVGQ9TQQzeKssET+t2186nKN
         OfnOpTWHI0iy2RWpevHB4Ir5ra+MObQobOhb8tbTkWLrtCKdK3qDNgwZ6+PNDaTAar1K
         V1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779222934; x=1779827734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2iG1hz81YAuxXAiaPdaZ3OGfdkiju2FjT0lpwqJRqQ=;
        b=tJauBBfH0qv9KzSqliNE2UD4d4BrOS6fs54CQszvirhTCbVwXU6pf0iyoOOyZb+HIX
         6wb5+W1/hzcTKPsccDmLS3b9lk3abAiHS369roomt2KhC5OT4nWZR6PL8pCNdsHDfIOI
         4qHDsWEDxzT6uu767GM1QxYFA54fSgAxi8CRtzO4O/F61oBraZ9f0joI+vcyVt6EP87E
         ddcCcPbnvcOM5T/Gp5bOAudtenzAl5JLUkfpbjQIjFKkEUbVtPus3vhICfizAXkUYJ8A
         EBaPODbBfMl0hApRz2CgX8drgZ7pshs12QldMp1glE0cRUD05O9KozWdpmWNEUhXZHiT
         uQvQ==
X-Gm-Message-State: AOJu0YyNYBxvyLtxOnI8e+R9w1jQ+rqPUaL32y8oQaCiFlbUivvjr8Az
	fLCcJqNUIYV+He6Pr6rrRk9bIcA+SmdaZfikkIN0/l6C0bLS37uAsX1XnnZB7vTyJVY=
X-Gm-Gg: Acq92OH2+lK30mwNA2dUcgQ4BTEQvnljJ6VJhSouerNfKJoeYbHXFYGh+5J3VuQn/x3
	f4afX0hM10x6mrirf0kxGYIaoCXUElf7fnVC90t7ccNkuDPSBg9eb11ggsPN68TtV1P8ZCyVHt7
	cMomqVt6egbBXzXtGIbQR9pZQcUO4ev+APK4zwV4/1e5CFaYCGCPc2+D67slyLf+ok5O6JFGluj
	luutXwDzHzdsALe+dXORKxxZZOWv+4n3/rZUNvsjGx7yGRrNzD7WWs814e6Y0XilgZ5jbNo7gOB
	vBiqFYEgwc0FJEuq9ED9sH7f3JvCQdyq3OzAwOtWZ9w/5qzufxk3hw9gzeqYU3vUNTGJcxHz8PJ
	DsCC1MJYtWtJud+mg4Z2Kq9aYJfBBIapk5BVe1wlIDYLfFDRs8autI1fYruSDnm8wFFisT+Lum3
	MahbtK0kuiJSeDbaKIvmPFIVpqdUTp07L9T4VyMWoU/UzKfJYewrgZ9feCapqN+mZdLWExDtTHI
	8TC0xpCohU=
X-Received: by 2002:a05:600c:5298:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48fe60e51d1mr328374555e9.2.1779222934041;
        Tue, 19 May 2026 13:35:34 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c744sm177738225e9.3.2026.05.19.13.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:35:33 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	sdf.kernel@gmail.com,
	kaiyuanz@google.com,
	almasrymina@google.com,
	bobbyeshleman@gmail.com,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v2] net: devmem: reject dma-buf bind with non-page-aligned size or SG length
Date: Tue, 19 May 2026 21:35:30 +0100
Message-ID: <20260519203530.66310-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-289607-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 52C8F584C2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
PAGE_SIZE multiples without checking:

  - tx_vec is sized dmabuf->size / PAGE_SIZE, and
    net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf->size
    before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =
    N*PAGE_SIZE + r (1 <= r < PAGE_SIZE), sendmsg() at iov_base =
    N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one past.

  - owner->area.num_niovs = len / PAGE_SIZE while gen_pool_add_owner()
    covers the full byte len, so a non-page-multiple non-final sg
    desyncs num_niovs from the gen_pool region for every later sg, on
    both RX and TX.

dma-buf does not require page-aligned sizes, so the bind path has to
enforce what its own indexing assumes. Reject both with -EINVAL.

The size check is TX-only (only tx_vec is sized off dmabuf->size); the
SG-length check covers both directions.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Changes in v2:
  - Reframe commit message around the kernel-side OOB instead of
    "real exporters already page-align", which read as the OOB being
    unreachable and undercut Cc: stable (Stanislav Fomichev).
  - Hoist the SG-length check out of the if (TX) branch so it covers
    RX too; RX has the same num_niovs / gen_pool desync on a
    contract-violating exporter, just without an OOB. Keep the
    size-multiple check TX-only (Stanislav Fomichev).
  - Drop bool todevice; compare direction == DMA_TO_DEVICE inline to
    match the existing call site at the tx_vec[] assignment
    (Bobby Eshleman).

 net/core/devmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 468344739db2..4f71de44c0fb 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -241,6 +241,11 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	}
 
 	if (direction == DMA_TO_DEVICE) {
+		if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "TX dma-buf size must be a multiple of PAGE_SIZE");
+			goto err_unmap;
+		}
 		binding->tx_vec = kvmalloc_objs(struct net_iov *,
 						dmabuf->size / PAGE_SIZE);
 		if (!binding->tx_vec) {
@@ -267,6 +272,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		size_t len = sg_dma_len(sg);
 		struct net_iov *niov;
 
+		if (!IS_ALIGNED(len, PAGE_SIZE)) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "dma-buf SG length must be PAGE_SIZE aligned");
+			goto err_free_chunks;
+		}
+
 		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
 				     dev_to_node(&dev->dev));
 		if (!owner) {
-- 
2.53.0


