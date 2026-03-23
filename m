Return-Path: <netdev+bounces-270520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FqQIz43wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:51:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 145432F239A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB4933073FAB
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE553A9D89;
	Mon, 23 Mar 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnE+YAS/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B13A3E70
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269847; cv=none; b=t7n4ZGPZH5KiPDABH5llha5EBvtjs6bapzSQnKpW6liEipwKs0qKTwN4drmoihYMnSTfu9PYmGNpuM5O1qCtY9I6lQLtVBiPeugXA1ectUqqc0HmEGKkg32/lCcU9SouY8o+khbahKhqIH+kmjUmlNVebycgaXrevIJJCr8q+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269847; c=relaxed/simple;
	bh=2SmnGuEGYS0lHFyxteSbdOVpCzxolY43MXskhvzwewY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVZMJ3jFajL7CmqdT5/XBsgyPFUHCOr73jp2oR7mm8JJKBxxIqsTwYsO+uCoawq7/1o85ELsVyl8ixig6vVbpC3N+V5wLgMcgHeVlRTjyRpB3fQVzRZb7VeojnCn19HU9/qV9WwzxBUfvxUIxZkmMt+SGoO8k2H4xIMDdGKdBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnE+YAS/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b4f48c47cso2115947f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269844; x=1774874644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2a1DxYxHBbFODjYjAGjCSfgL6Y1ZzU7PYwbmxXmy+k=;
        b=AnE+YAS/CQsaqG4csI8eFHWmzXKl7zzqxQuigs4exedUjzmesS2aO3abCu1XjNbKjv
         QZKlnr+tNwY/SxyumFElialHLpb26PA0qQ8G6N7vKAwM9lsVFGecahfMuXN6i3D0puOk
         QGCWeKtt8Wm9LH/xkvxkDeKPLRpSQan2T6A4E2xu7tLaZcBo+AGX4zEZ9NAAksEdSjGZ
         N/Q/wD1mxrxW/yoWPFKsbZNE2oBiI+5S2IzIBddqF0DPeGoRlFp96oyME3T7AJQ2Fq+W
         7kpSCXbHZdk7fdtNzbzI3iUmxZ73BRmqMpHWovW0i6TZZKHoGluwc3daDY4lA6JguEgm
         izHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269844; x=1774874644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2a1DxYxHBbFODjYjAGjCSfgL6Y1ZzU7PYwbmxXmy+k=;
        b=ewhvGzhIBvA37P+4ek6AW7Z60v8pS4E9NY19kHeNhy53jglmNf+35leCxfuGiRkUjv
         1OcA6TEkcQIb5W+rp9qn+E+NhWKE64QS/NFoldFm6c4lpMY/c99s61I4RdFGB7Wr38I0
         nBzmBkEod8RZ+LtbmJtuE4mss29wzsLyRL4tdYV2jDwstAnDAaG0OhSTtEKekuG41z5n
         1Jr7fXHIoQ8gHtv5QJ9dF13wTnm+xyUqQOxbtDFITBIH5coWMXKmaT4cov9bJiMaZe8/
         oq9HOJPagz1P8+FGf1P5nTNP4lwSB5mI18I/6H7rG4HfISbWKsl+29ocE5Z1yWNsNrR8
         f5fg==
X-Forwarded-Encrypted: i=1; AJvYcCVCSpRxEwah+HVB6iq6Y4eYr0mhBDTQbdACacL42iamz52hl2E7mwPZ8iUxbhG95dYaNXmqYk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ZvAFevkQfVnY1Mmil4zg6Yaa9VZYdBgcRhPNrVorZ9VOwF4I
	23SOAHzqgnAebRHYiZY7imDvjol0ooJD0Wv6vyTqN2SpoGeFBI6V4gKQ
X-Gm-Gg: ATEYQzw5a8odrPlv4L1akpj4DKXegnwYIzxpLQQVMOSHAUi/Yxz1WUFpk0bz0z9KuCJ
	tjN+Nzmrdid9lH0blq7cF4l36Wu2THtIz0oMhTTBnBWx4oZLoe3PTAZj6H9yZVjfczlYi5NhNrL
	Ym64LwfCH0mU2AaaSsodEA+dZtPZFwCJOkUJQUwuztYqQObT0K5qarqrypkzBCFLqmK103H1kq+
	Fnwyl0a//9fdwn3aJDKGGfiVwZ45hNBj2j4p73DerxDnAANZZuyhD5UJj200R6OHlGxJavVkBqa
	d9IVgqPa5TRkabS/fFPxiROnjht/wmx08tWLrH0LpnxqCNmg7GFNIUfEoPq29cJcgdPNsnRtFo/
	xXQEdiQSA1RQ/tJSgwGqlhtG7pNNjHqcfPgFJlTf4KaGOMkMXnjhl/dLbft0v/EbidO2YVeC2at
	6l/hO952FaZ1Ou9jYYLRcY5lWthX7Cbcw3ySjb4cZ9fp3pWo3jCLJ7XeXUcN93XV3Y10OUu2erT
	VmT2kqyzw==
X-Received: by 2002:a5d:5f55:0:b0:43b:5037:7ef3 with SMTP id ffacd0b85a97d-43b6424ec4emr19569617f8f.20.1774269844434;
        Mon, 23 Mar 2026 05:44:04 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:03 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 02/16] io_uring/zcrx: fully clean area on error in io_import_umem()
Date: Mon, 23 Mar 2026 12:43:51 +0000
Message-ID: <3a602b7fb347dbd4da6797ac49b52ea5dedb856d.1774261953.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774261953.git.asml.silence@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-270520-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 145432F239A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When accounting fails, io_import_umem() sets the page array, etc. and
returns an error expecting that the error handling code will take care
of the rest. To make the next patch simpler, only return a fully
initialised areas from the function.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 8c76c174380d..5739ce14d8ea 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -207,22 +207,26 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 	ret = sg_alloc_table_from_pages(&mem->page_sg_table, pages, nr_pages,
 					0, (unsigned long)nr_pages << PAGE_SHIFT,
 					GFP_KERNEL_ACCOUNT);
-	if (ret) {
-		unpin_user_pages(pages, nr_pages);
-		kvfree(pages);
-		return ret;
-	}
+	if (ret)
+		goto out_err;
 
 	mem->account_pages = io_count_account_pages(pages, nr_pages);
 	ret = io_account_mem(ifq->user, ifq->mm_account, mem->account_pages);
-	if (ret < 0)
+	if (ret < 0) {
 		mem->account_pages = 0;
+		goto out_err;
+	}
 
 	mem->sgt = &mem->page_sg_table;
 	mem->pages = pages;
 	mem->nr_folios = nr_pages;
 	mem->size = area_reg->len;
 	return ret;
+out_err:
+	sg_free_table(&mem->page_sg_table);
+	unpin_user_pages(pages, nr_pages);
+	kvfree(pages);
+	return ret;
 }
 
 static void io_release_area_mem(struct io_zcrx_mem *mem)
-- 
2.53.0


