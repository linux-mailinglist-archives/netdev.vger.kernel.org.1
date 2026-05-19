Return-Path: <netdev+bounces-289426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Mm8IzJQDGqTewUAu9opvQ
	(envelope-from <netdev+bounces-289426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:57:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0870C57E27B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85224311D44F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220644B8DDC;
	Tue, 19 May 2026 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htxrhS/5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7694BCAA0
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191090; cv=none; b=YJuXoe2ysdT27tVXVsewLXGeYNGnLSFqbj/c+txN4dkbOopko3z0L0++iBoGKr9UzFQI5Rfuz7IH3WYeiOm3vcoKyELF81wsXW81/+fqC1tZ4DMg5AY/hynzfNDh8CudrYd7FpYxdZLqZ9hXYMluDd0OXBhh7OKNSRFJ8F7XTkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191090; c=relaxed/simple;
	bh=Y3xqOgjH1o9XHlnyDP3109/v/LdXpPptC3GMlqM4Vtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUnQB5DcIiBuvMhun1N3kaC9TchxDTu3aYKlSfMJCkXIB2gt1ZyT9AxP3w8YGM/K6/l+6xtqK4DA1nFAxjCf5sqBhS81PRwrWUKDkHQPYSOZpq6xUznfemgPCxAeyHcucMeSbPtNEGHJiP5w8XDNk5yfbWP+04GZOJ+hxyGBH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htxrhS/5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490229aa522so2371065e9.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191086; x=1779795886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7bcIYJHQHfN/yava3FrJgf+nwAM4HviXB//xeIs4sI=;
        b=htxrhS/5T+xtgowtCAq2zMdI7jkaUTpUA0j8hg+ee9hXQ5tJSpI+ab2zDDC5WvbhFc
         RqFa10yB2XgDYoaajSDk0kbQpeqtor2iQa90GBwgWUvBStFRDPtR9uz2n4InD1GuJPBd
         gyJQu07A6OxfcgCWWGcmEtuPD2kKPBtDJrH9uEVR0YS0w/EhgfKJMuEIXrIlP4e8wdPB
         5kMLkc/Y4h4fkeqGTF3VdXQPsdo14CfRrRv+GxjP5REJBItjaxpEeYyfeRv6EV5c7aVX
         9rKY5Xcdc8hWqKXcqdMeqL6+LfTsqkY3lfCdjTUe9KzL2hWtkoBAo4UMLfMVTfM6iDnw
         tKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191086; x=1779795886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7bcIYJHQHfN/yava3FrJgf+nwAM4HviXB//xeIs4sI=;
        b=oBT93Ci1z3mtqQtuekJB/UwmxhX6GJb0vtFr9j+2ZNll9wnFBSS6ipB2RLXLbKtYFj
         OMjDW9S6roHpiRROf036KyDxq066hiKxMdj8Z/QOPVjqnEN0faG+KqPK4PFUEhaF7gxw
         hf9rtAesxTVcsPDCr/UCEk4FqSfmAKRgc3ffShOenm0amXFluD/gqH+X1qRJuKHuom+z
         ftyXguUUTAOv3lSWa8eoLm3THogBIUHBNmibzdU/wRurY9Fkgec34qFHWjE6zNfuWeNs
         clcJKlw3cW//znw9mWLzeL/UYtfAcEUALSTBbBUbreRB4V9F3BZXPkxUic+mz15qlnUo
         451g==
X-Forwarded-Encrypted: i=1; AFNElJ9t+LBfFKdtIpioL8N/9T6DRuEfb2faw2dHnZ9oXXLoX3C9/c0KJMeeIadITnffw5EA7cz2r/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybrp9C8WUWbkt0fPxkGLueyqvWPu/DcR2woi/Do1Ff+4zVNqn1
	9orurLm+8pEUh4bcp2RJfqVB3L35J3UVPOGxWV7hx8VUiYqnzEwOlFnF85/QFA==
X-Gm-Gg: Acq92OEIq8Nn1Fog4seY6jqbR+UzZmlG3qLTjFraYP6jt8YYbbuO/OTDzxe9xb7Tqlm
	tSkPJ9decJ4WwoyumIcoPRx8eIKLwl5uofNt7uHQeKQnu/62eCpRuG3H8b4aY912JGKyLqvO7xp
	jKerT+Jcyqud9xuWmDBcnpKvcdIruHXjyvZAywjrb0USg/jrCvQhkvslglFiNJLZXm7u4e9cy+l
	4G+F0BOQREgwpPIC5Sj3yK246IbRdjGX+3kDSRbxuGwsFyf0PKxmp+Q+JLPWFR5wVgFAHmDi1Y0
	rzjzFCAAoa877i7c0IKyRy5NXWib+yxFrKbZmjO+Fqzrle0g56XlcfgKfYv5W9bpwi+oqblCa6z
	nS+9JudY2U8esii1lnAYWF4TbjHOzsahC2k7kKwsRnZ97x6OrXIz6oHR7o/m/BuQIEj1FPWZlkE
	onKcjULa1uwdlCSXQX8vnB68KXasNSpEaBXEYx3e0c1SD9H3QP3wIc/Xp0yB5nq5VjJVd0ZYlU9
	al+rrafboL3uHeyiwM5qIWExH21LA==
X-Received: by 2002:a05:600c:608b:b0:48a:58ae:9933 with SMTP id 5b1f17b1804b1-48fe61ed232mr306210185e9.18.1779191086308;
        Tue, 19 May 2026 04:44:46 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694f2csm323392445e9.4.2026.05.19.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:44:45 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 4/8] io_uring/zcrx: reorder fd allocation in zcrx_export()
Date: Tue, 19 May 2026 12:44:30 +0100
Message-ID: <1513a3f4ae7161692ca6e991b9f01278a6bc60e4.1779189667.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779189667.git.asml.silence@gmail.com>
References: <cover.1779189667.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289426-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,warwick.ac.uk:email]
X-Rspamd-Queue-Id: 0870C57E27B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bertie Tryner <bertietryner@gmail.com>

Currently, zcrx_export() allocates a file descriptor and copies the
control structure to userspace before the backing file is created.

While the operation returns an error on failure, it is cleaner to
follow the standard kernel pattern of performing the copy_to_user()
and fd_install() only after all resource allocations (like the
anon_inode) have succeeded. This aligns the code with other
fd-publishing paths in the VFS.

Signed-off-by: Bertie Tryner <Bertie.Tryner@warwick.ac.uk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index f4440881960f..24a9ebbd9d8f 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -699,19 +699,10 @@ static int zcrx_export(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 {
 	struct zcrx_ctrl_export *ce = &ctrl->zc_export;
 	struct file *file;
-	int fd = -1;
+	int fd;
 
 	if (!mem_is_zero(ce, sizeof(*ce)))
 		return -EINVAL;
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	ce->zcrx_fd = fd;
-	if (copy_to_user(arg, ctrl, sizeof(*ctrl))) {
-		put_unused_fd(fd);
-		return -EFAULT;
-	}
 
 	refcount_inc(&ifq->refs);
 	refcount_inc(&ifq->user_refs);
@@ -719,11 +710,23 @@ static int zcrx_export(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 	file = anon_inode_create_getfile("[zcrx]", &zcrx_box_fops,
 					 ifq, O_CLOEXEC, NULL);
 	if (IS_ERR(file)) {
-		put_unused_fd(fd);
 		zcrx_unregister(ifq);
 		return PTR_ERR(file);
 	}
 
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		fput(file);
+		return fd;
+	}
+
+	ce->zcrx_fd = fd;
+	if (copy_to_user(arg, ctrl, sizeof(*ctrl))) {
+		fput(file);
+		put_unused_fd(fd);
+		return -EFAULT;
+	}
+
 	fd_install(fd, file);
 	return 0;
 }
-- 
2.54.0


