Return-Path: <netdev+bounces-301765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iUmXIN4qPGpPkwgAu9opvQ
	(envelope-from <netdev+bounces-301765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:07:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1676C0DCF
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:07:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TYpysU1S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301765-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301765-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A430301E6C3
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6F433439A;
	Wed, 24 Jun 2026 19:07:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1112201113
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 19:07:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328028; cv=none; b=tduRusH6h+w7SKQXlSPq0KNfdwKoJYy9oxSYC2u3v2dUPLonSR8jtTMRZVO8VOnYiQWsiS9gWtul2jJGHIZ7B9S+Gg+XGn9WcEnaW8fbk4QB+XDwe/7BKfv9jTLJhM8SsmWE0c1B2i75j1qtb/b2o/4R08VcGGBx+CdCEBJ45P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328028; c=relaxed/simple;
	bh=8LkfFMB4XG4EiUlUUfCp5eNP3of8+WWy7c96tMRZBtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBe/jslMfNZlA9De7BdSqaIe+4ufrEept5ZXevT3uPK+BkALlLdYGgJhiKQu1nbLUm3x3NirR8NSMK3wM1yHRQDCnviLTVRF3/kn177D6k+g0f1VzL46FbyI5gbFdMLnxfMuU2oPptnjCkUclI64ud9uQLhmxupi1moGt9IINBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYpysU1S; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so14523315e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782328025; x=1782932825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DfCmQjaXvxIPY9LgYjyAuGOJaOamYtsKcoImA7m2aMQ=;
        b=TYpysU1SznbTMV35edVzJSUxPkT7JRDvjKYgwA1JHNLtU52BD6gQBBMWdHlnR9Z5c1
         SxyO++NTChhENqfcp4dB+gqyG4Rnn8USi+gbzJkx/XPGDGcFJQMccOOXYFpTilpYgL+S
         VPHwE/aqzE8L/ZCTBDwYFS1zZfKpoNPx0B7bKk7beTuti2iWeI/eNxV+wk/4F4cD7xMc
         eLC5pqIH/vFEebaBUjdZmiUxvkfBW4DO1D+4RPULlPcgsVmDNZSsNeBa/4ZPnl9RDq+v
         Fat7zr5TkeYMTdQ8I2x59RkvMahgt2fm4Hm/nrb3eERWfSGqLHEYz3RKJW/i5Ri1h7OW
         AGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328025; x=1782932825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfCmQjaXvxIPY9LgYjyAuGOJaOamYtsKcoImA7m2aMQ=;
        b=QOkHVExl4OvHsjbk2Do2QntJBtKaI6nQEPF/EP75kxMKcsGlQDAvQmG59qvcp99+Gt
         LQULKgHf6qRL4Qwhv/+3eRmajJHRVjbGtEIVf1tDrJpJfVOR1J6OMvbeCoadSqW9N0tC
         JTdSKv0EKC0hj+ccfttUgkDzJxcb74UnZVMlAFrLms1MyyTdXUJkSD+fV9BIt875Yxf+
         V4+bdkeKpZMtALNocFAlzZWmXC+t0ZubtOgKERQbr9y5tjXwVHSgGFqLnSfaO/+yenQO
         G1tJgMCY0D5lcpiFMaPngFi7BImKhKkqP+RmTVoIb6tNcVHHjdGpmeMCndEDE+H1g4wO
         n2MA==
X-Forwarded-Encrypted: i=1; AFNElJ9qK9F5MhDCm31qq1tRAehspL2gheqihvATtJXzBimwOaJnv16725LMnoJoBFkkK0O/GdbDBiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcf+VyxtUJuhdem/9KHCtnSrsQuIWHTfaaMuH8dfm+2tyZatAt
	V9REif7d1zYSq2ykXaMPnrsm7JhQsiBeOazMU5jzmRbxwUMRHeD/W4iy
X-Gm-Gg: AfdE7clwjg4uCQ1Z/7dHUuU6Lu4a3avBW1b5VaeuOnWSxdoaPKbt922rjWA2W2SCeHO
	Xdn/Kb/LGIrW6FcaNOYLak6paZYdfTL3BKTBIJ1LjsT0dh9knRwvvrx7tmQdcHqn6AMtsnclM9b
	2uoaqySno/3Ympaa96q9DSBNUgrB49yRgq2+Yx1A0ZBaameYIJv+QWSfXMFJJqDXO2BsorNZE/G
	au+lvNZL4X2pLSixxa/CCrECJjOND/JHnpcfknOhPOGG8Sxb31yGZj0d0YXfJZ5/bIG7SwZ5wmE
	WVHVKoQbz7wDUIDgR7qT0TGbrMeyS2lM+kPsS92tUXXqCrJc+M4BAaljxagoJEDrdbiiCvYSckK
	Jb54ActZRU8isJldAV4av5BijopUhpClGHVf/j8xY7AuHRFiGdyyjisAN2XyopYYnHZVPo3HZbK
	DgAZ9TzgOjiWtAN5camS0Hu6IrWg==
X-Received: by 2002:a05:600c:4453:b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-4925b37973bmr133374295e9.19.1782328025219;
        Wed, 24 Jun 2026 12:07:05 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01d9csm8843587f8f.12.2026.06.24.12.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:07:04 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] vhost/vdpa: reject overflowing PA map page counts
Date: Wed, 24 Jun 2026 21:06:53 +0200
Message-ID: <20260624190653.2893-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301765-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alhouseenyousef@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD1676C0DCF

vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
size before computing the number of pages to pin. If that addition wraps,
the code can pin and map fewer pages than the requested IOTLB range.

Reject sizes that overflow the page-count calculation. Also make the
memlock check subtraction-based so a large page count cannot wrap the
pinned page total.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/vhost/vdpa.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa..090cb8693 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1102,6 +1102,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
 	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long page_offset;
+	u64 pinned_vm;
 	u64 start = iova;
 	long pinned;
 	int ret = 0;
@@ -1114,7 +1116,12 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	if (perm & VHOST_ACCESS_WO)
 		gup_flags |= FOLL_WRITE;
 
-	npages = PFN_UP(size + (iova & ~PAGE_MASK));
+	page_offset = iova & ~PAGE_MASK;
+	if (size > ULONG_MAX - page_offset) {
+		ret = -EINVAL;
+		goto free;
+	}
+	npages = PFN_UP(size + page_offset);
 	if (!npages) {
 		ret = -EINVAL;
 		goto free;
@@ -1123,7 +1130,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	mmap_read_lock(dev->mm);
 
 	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
-	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
+	pinned_vm = atomic64_read(&dev->mm->pinned_vm);
+	if (npages > lock_limit || pinned_vm > lock_limit - npages) {
 		ret = -ENOMEM;
 		goto unlock;
 	}
-- 
2.54.0


