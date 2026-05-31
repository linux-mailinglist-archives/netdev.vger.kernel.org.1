Return-Path: <netdev+bounces-293369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCLfNjGJG2rMDwkAu9opvQ
	(envelope-from <netdev+bounces-293369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 03:04:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45061614151
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 03:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F6123048555
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 01:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0BE246770;
	Sun, 31 May 2026 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAvMMyEJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A341509AB
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189343; cv=none; b=V2lply6WBi6Lo5yq5zyUIKNSHDLAt7pDXOw+dfln1qwaWpjgwwOWeD2rAByt0I4OrrjN1/oHMe/KX6k1mQt1p68Y7nS1UM2x7xOuT2QA5LjIFtYhfv6jIOmCDoIadH6HM8xq9HLRWZOgmBGdJidr4vXxlv4j+P1bp+Gly7wNO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189343; c=relaxed/simple;
	bh=vsb+QThfs2Jw6QSiFQtsk0PMTT4LF7TO2lj9pLcB1Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qp3vPB7kdsx8ewuoft7h5MAcIdNJRnM3KSOwBucAneoLvDhhQ9/j/M96v/rFwIDx3et9owYztHj9fC0nJVTMDXdNP4wq1SgK9PkzIcqvRFrQTXhLTZCMVOE2I3OsYnsOkUghCqzR5uh9bbI4XM6jO1+nObUYMTQAvvWXmSb3Nmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAvMMyEJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490a765f47aso1309265e9.1
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 18:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780189340; x=1780794140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcbBqWTkzkDxwNMdgJ7xVJp7N/TN/+GdHi920u4savY=;
        b=YAvMMyEJ51N9vhC53xnEEhMm64qQqG1nVXXeYsDkF8PoTdCjhLyZnmzfCSYThtdoy1
         xQsUDvOWfjZEmUxZMrd9oIqvRZNrBe6DS3VWZlDIMcgXjpn2cJcdJNnFBr/XqhB96PJU
         HBSmZ6TBf4E9VdaAhL/aQODtYVa6xsf9T38CbwVsI4S3+2yt0zjO8SndLk/jA/1OffH2
         ZaVds/eSQ4VuDx11SuHsFijcAuRxyQ4YsPRgmLwekBU/X7ylJBNUFqTSL0pxA7dPhDq3
         +oBnDHnZnJl5UV9B+7sXOzS0EcMnC8BefxAnlSrPj8VyAxLHQjRV3k3PD5oBoLo4cQgo
         GZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189340; x=1780794140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BcbBqWTkzkDxwNMdgJ7xVJp7N/TN/+GdHi920u4savY=;
        b=gfAklyl6WHtrfdtr8z+zZthOMhfAnTPq6eKm5CmC7hrCtXOKNNJWEH8KojKL5aJCqL
         cZXjMW8hF4yMYmFPBFsv/Ts3L4gkdoqnxt43joHVQKQFlYuqjRbWKaibb4hCvHxaJWoh
         +8LsPl9S4B8jBeuDXB72MO1pzo1NSsa3yuHwFIMKbbuQLr2EFXrkP8sgyIDBa1PeSFHl
         P19WqDlcNgdpW+t3Sf/vNUoVrF2dQkCaOQUp5ZI3rneW1LYBuRkb7gjj7xRI4VsBzKYN
         cKfX++UTWw7YslArmyj9W9PyQwpXMeaqIhGqCNCiyqy3XqpDmxiYWLQQdcwclQRb7+zi
         Zq9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9eez0Z0PUZYkQIwotTFQGRSOcf0vL3LDLvMnXdQ5iEM1V/mXhJhr1dproVGOZ7bVqhtZuZorY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMjJGJZVtcGw+0eRpYJ8kjjn0+s7+hUIkS9E3mcJEFld+TG3A
	DMuQ3lccCBWfm16ss3rRuvxNdMG+CgiwXsSC0LrYVtFHhRtjSNb4CbtX
X-Gm-Gg: Acq92OEnNdAv56EAigHWqcMKeAqTZo7pamegV4whHwdVO/FfM7PjVuijcxZ0EKqD6nk
	iYZz1hQ3YKyqsia3uABeSOPv5yixNmbsn+ITzXYuhActLon6bhS8qPnE9pA1UDrIT7YYVbkQr+/
	3gO30oLOvrQ1B8M3FI9LnujlUx/3bxdtS3zSUMF8Mt6ZimpyQp+q5DnFMY2l8nSnJV8lUk38qk+
	hlUwBj0aoWgPWtiLH22btG66LDIDfo6/tv0W5klsf6TzKeegHaNpU5Sg8cRLJUUyXrjkOAY7c9N
	gVdvOT7+RcIJbjMZ8UzZtSX3/ZQ97+9RU2iXpQWpuzMebXXBucFife/EZbxpJVkMj3s4fRzRoSv
	eZV9ugsVcBB6jRHYbUqUkcK3/F04BS2KsE8Wv2YoeGb2EEtHdIt474/cIVPOgAMmpMNnyHSGrSP
	F7E92Kcm3//4+MM1aLaHTHWjKEIP3UyQ==
X-Received: by 2002:a05:600d:8648:20b0:490:9d5c:a3e0 with SMTP id 5b1f17b1804b1-490a29215ebmr71216825e9.9.1780189339981;
        Sat, 30 May 2026 18:02:19 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909c103908sm45297445e9.22.2026.05.30.18.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 18:02:19 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	patches@lists.linux.dev
Subject: [PATCH 1/3] tee: fs/splice.c: remove unused parameter "flags" from "link_pipe"
Date: Sun, 31 May 2026 01:01:05 +0000
Message-ID: <20260531010107.1953702-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531010107.1953702-1-safinaskar@gmail.com>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293369-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 45061614151
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove unused parameter "flags" from "link_pipe".

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/splice.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1a..59adbc2fa4d6 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1849,7 +1849,7 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
  */
 static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 			 struct pipe_inode_info *opipe,
-			 size_t len, unsigned int flags)
+			 size_t len)
 {
 	struct pipe_buffer *ibuf, *obuf;
 	unsigned int i_head, o_head;
@@ -1962,7 +1962,7 @@ ssize_t do_tee(struct file *in, struct file *out, size_t len,
 		if (!ret) {
 			ret = opipe_prep(opipe, flags);
 			if (!ret)
-				ret = link_pipe(ipipe, opipe, len, flags);
+				ret = link_pipe(ipipe, opipe, len);
 		}
 	}
 
-- 
2.47.3


