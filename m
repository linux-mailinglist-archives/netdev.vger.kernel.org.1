Return-Path: <netdev+bounces-255677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tHaRG0rDf2lvxQIAu9opvQ
	(envelope-from <netdev+bounces-255677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 22:19:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BCCC743A
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 22:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C70A730056CE
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 21:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242DF2DC35A;
	Sun,  1 Feb 2026 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGJnk0oK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72C28CF52
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769980743; cv=none; b=MnPkExnVV1FNfCe4HS8Xv/o4CIMRtGd2U8EzmU0DWR27USNQ/5jNd+aiFqhpcqwKEcrN0BY/WOCwDMZaOwwVVXVNgkT9xFxI4s3aYS8azhm7kVIRZ1zcG495wDvm4JDP66v5R4BYAdz/oAHBqNymR7hYgt9YSLd3AQ7Ka7jidAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769980743; c=relaxed/simple;
	bh=4tAKjceAqndRpc+ZomLK/YujbZ/N+W+Q94sN7KsxBnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/4TTBJ6RoDZvrBY6kI2UNwlbxn8014PM0+h47h9YptwUbA94hI2dzhx7Zw0GfAhxuAD/sd6VdJYfTdf3pedXOX6H4nWlJoP7Gyoe4k+c9JPQcUU0k5YlQkF4ILzFlYoLp0SchAPvL5ivfmMYfUSa/nnA8IJjpf3/Ggjc84aJmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGJnk0oK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-482f2599980so8528135e9.0
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769980740; x=1770585540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ld7WbI1rQlFVF5lIZMpr5m89ydDvu85IcZ6bvRMoGqg=;
        b=YGJnk0oK2caR9QDCyiC4D6xI6XivYxXF95jjOyDzgezuUEFKDJVuCKaOuK3ZjfEC/A
         /MsPHz+VKvN5M7z9tNLGyh/0w4gDvv5VDgpdIVgVuFMnrTdg2cC4Tw4Wpy5AAYlFksqH
         bPj/lkT5ILmXSZ74JIowkL7b8g9dspY3wrzME9kFxjjGj4Xs9Rrsq24vASzl6y/Rx8DD
         lcQYJrPpTsUBApGU17HVUpyMYdzzw6cNMOP/IpPJjYPR8Ak4F/M8t9GrtLdLykC76WUE
         CcXSR9E1Im/RrlBWxhq46AkplQ8jh06Zk852r/+1YXC2zYLF39VdAlMuIae3O9trCmQj
         l7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769980740; x=1770585540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld7WbI1rQlFVF5lIZMpr5m89ydDvu85IcZ6bvRMoGqg=;
        b=INEDVqhzalvkuLXURx8DzxnXh/mfJ9Fb2y60sikd9ELpImJ5/ZzPGh+68O9HmOWhhS
         aF9MDuMMYY1NjrkqIANbJ3vIsNLJLXiJLu+4h4e3H8cHYH2G3CLGbw8k4HARIZQKZ9eg
         PhquW5urSlO5DiUBVwo7vIXM/0H2tY+s5v8al5+6Z4tOVgYAl5eCQlMmAgb52IvQZbpe
         MMqJCXc6G12XhlpM8+9oVkSJc0H/29noxufowzKI3GxUrPCKgIqKACBNDMqtcdh15CWN
         QVpuIDpzzaWOPBCnlyzeOgR27rBkmWedbyZw4jfU+ig5PMZOpBOqbCXfuCzJEn+xh/zq
         NLJA==
X-Forwarded-Encrypted: i=1; AJvYcCXSAD3o+e/ASuiJjdXQByLIvKVF5+ViIwe8m3UHKJpMHcC4AV2kSLdYNhUw35TfYGRaIVfbQfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJqg2xpFdV32PYqbA3X9fG8E5Ww1zhZbYiN+/l1QVdz6XI4vJ
	LB426zUmGclwTZD+Tf5vy6x5qMEqO7bdHXZrn6jOVOged+QRADCnB8wt
X-Gm-Gg: AZuq6aIOLsE4y3xQsf+TyAsi44ad99TSOnQWRA153HpTiEYwrhyhxjn5wfeAOVyrO/4
	uoZa8CR4NwK1llsnNGXabw5Ob1Qk5/INmw3Yd+2dWTiRLSkV+sl72SCTrotuj1uTkMUfI2ngTTF
	jchqt/IQYByEN4LCL4ck7GxGx2D5olH/XGQx8gk7XHkKnvKY+7s+giR1lJ4/uEc13eCiAEMKkwy
	1p4qdTjul4fjiTu2ksc+6/ptmJrPsnDFj7kYcexsSqK1+gJjE9UVBAt8duUG6+InVKbjy1hKONs
	M4KGpTQ1Z5JJAJgtGLnk9plVMCAWAnbhvvzSEDXxW0glAuak8VSyNa/grIN9V5T8viaeZuedNfU
	8YGoEYDznm2915ke3I6UlWuty1KnOUtrItBio+OctORafzIa6bu4DcIq7j/sRjdZGj3QoRgGwiM
	txyImfVqLmrhhyNrE3fKjw11Dq5MdUxKjBO3la7l7xx1XkwTIrzubSOZekOusVLmBaELTnYjCw+
	+5GrO7qltWgir2s2Q==
X-Received: by 2002:a05:600c:34ca:b0:480:3b4e:41ba with SMTP id 5b1f17b1804b1-482db48d595mr111497185e9.18.1769980739829;
        Sun, 01 Feb 2026 13:18:59 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm443704085e9.4.2026.02.01.13.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 13:18:59 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 1/1] io_uring/zcrx: fix page array leak
Date: Sun,  1 Feb 2026 21:18:53 +0000
Message-ID: <8b46043155b3abd8a6421c6aa9a61064d1d430e4.1769962652.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-255677-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9BCCC743A
X-Rspamd-Action: no action

d9f595b9a65e ("io_uring/zcrx: fix leaking pages on sg init fail") fixed
a page leakage but didn't free the page array, release it as well.

Fixes: b84621d96ee02 ("io_uring/zcrx: allocate sgtable for umem areas")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 8a9df72bc094..0c4b339f712e 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -209,6 +209,7 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 					GFP_KERNEL_ACCOUNT);
 	if (ret) {
 		unpin_user_pages(pages, nr_pages);
+		kvfree(pages);
 		return ret;
 	}
 
-- 
2.52.0


