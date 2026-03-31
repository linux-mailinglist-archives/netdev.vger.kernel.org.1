Return-Path: <netdev+bounces-273750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPmlLbc5zGn7RQYAu9opvQ
	(envelope-from <netdev+bounces-273750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:16:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20037371805
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F7B3115F8D
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831364508E0;
	Tue, 31 Mar 2026 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIpEWXNv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5344BCB0
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991261; cv=none; b=rlT5JOwrd7PMkbd4MY8oBl2ghy+/orshysjcndCE4jIlPmN0KQRH0fDC1IYC80y7X3IfdJ5egGWVec9L3fxz3VwJ4QWk1SrVZ2v1LQsd6d4yvTByo85JZKw9lGqzBWhcWXbK66EFaNwxU+7wdD1yQXdvSNa9+688eHLCxN94mEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991261; c=relaxed/simple;
	bh=sDNJgH/ttdk5M8DhwU5nl6fTGa/xQQGwBH0RBcQg8Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=We6xSED/3glbf3BbNyOoKNX/S4sNq1z0s3ph8xirtIz9IMWKTEONAN7jPUW9lbIrqaUjL7dkK7PhVbddi7n1jJYDUamQQBPJxkeeEnumMUvR0U5Lyg19GhmHkDnWLlPEZIriWlQjlzx5GkXfTgpqIQ8/mlWMVUObMCJtzhCuy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIpEWXNv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso14695305e9.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991258; x=1775596058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hU1F6N/ptF7KDLzfeOiGQ+wkh6yR548EBAW1ECp/d2c=;
        b=XIpEWXNvUZlHPVJ+ocAmAV4O1jWlWbcfdIUSxfCs4cxQNCrqdoT/AB52Poxq1abXpJ
         ELVDw4kdVtf0ZLVBzsWYgBIj5hTYSP3qKkGls1Xiz3sHahICIrqxQavmdslpsGPZYVql
         LLRtAuyw2gWyO6j5VHoTc/eRlybFxtWp98jQdoDt3eGEOe8uew25WdlT8Rf2KFIztKTB
         xf6fMfC792lLfrXbD2NLLsB7d3gYIK5dPcRNdAPV+7/Pn5vF2wWLrnll5CSvtPSeR+wQ
         5HKr1/Qb4pDXrTF1jsgozAjPJQeIq9QVrcy/a1IZLYGTnsbXk5o+nPU9A+4i8Y0MnYEE
         gl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991259; x=1775596059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hU1F6N/ptF7KDLzfeOiGQ+wkh6yR548EBAW1ECp/d2c=;
        b=bJhMF552jhPtOqsSnmMtJKzqndsGxXzbVxAUuP5ra5POUOQlfRQ/H+UctEgbCdK1et
         jxVj5aKbbEh/5X3V9s/cw4FP9X+TEx1QbIoOJThMaVQaZ3lEbjLVcYe0lemg8xUO1saW
         Kp9pn868JJ2QH29Ux1DzuML9EORyEnfX7uAaCuvwBKN/aY/sxijNMhRndV39gHpyv/rg
         c7A75lrsuS0V6ZifV3UtXK8dNDq4hglONsQmRCQc/GKu/MRnSUMrXmaBptbScVjrk2cG
         Yh4Turi9OBcfI3liFdqd1A8QSO9MaljRM663CSCkMYwN4i3fpA11qjCGpJFfkOyao0ch
         2wLg==
X-Forwarded-Encrypted: i=1; AJvYcCUPX0+mATrYhXxASiA9FVQtuAfgXYQs3Dm70bl0GcguAJ3yH+yuu7M4zuUXrKZyiAEeaQH2pAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1eLZj1Bu4E2bJT8xA/eWQFNOE0LZwX431QyijJxDSoqGQgB2a
	DXPJ9YGLiG9zp6uvAi5Ohe1ACCMeV7YLmBw05vNN8enbxCO77GtOsEoI
X-Gm-Gg: ATEYQzxdnV2WeCFmczeuE2P06gXcMSY8o5JnYAnSedGwXCLKmtadX9x/ugks+sddqFK
	2tMkLhVFTfDE5yICuZUeTrMIGU42UDpTGKEwC9uMbvyFbPAGQbsOPMrD0QpHS2slNy5PI67igH/
	XLckrghBFfh8tdDYZrqx3RYOg7k3PRZjsV8OjuzfMewjq/MKpvqGIqmAV8RqDlPx+b5Sc48Nb9b
	8lnQZappYtTMWx6wWrmzffCAk9SYCFjpC6Ptg38006rXBwy/QzCTKawKs5MpHUg6Chlw9roZ9TF
	MR+iVjpRgroV/eCAS4/y3nedwG4VNfBii9FIPYxtB1Gz82Yef0TkXXcBT72ZcJpNu6kRY6AEd07
	pwl7sq9h1lnBIQ3OAu6ez3q1OxMHMk1auVyXhNn/yHcB03zONDJrSWXptnYkNHeJf67HqVjLrxn
	jpMZwFrFvTGvToPvSSR5k+vjKApTME2igF3XAa4jYK0qh5NvzG0LnwBgwtL04q7zH4RnDSA+C3Q
	Bz9pzmP64L13IWnvaoXiWR0Z4gwe/q59oVUJXhi
X-Received: by 2002:a05:6000:2c06:b0:43b:8f4e:27f8 with SMTP id ffacd0b85a97d-43d1505e841mr1888498f8f.12.1774991258501;
        Tue, 31 Mar 2026 14:07:38 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2570b18sm32431393f8f.31.2026.03.31.14.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:07:37 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 v3 5/6] io_uring/zcrx: use dma_len for chunk size calculation
Date: Tue, 31 Mar 2026 22:07:42 +0100
Message-ID: <03b219af3f6cfdd1cf64679b8bab7461e47cc123.1774780198.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774780198.git.asml.silence@gmail.com>
References: <cover.1774780198.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-273750-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20037371805
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Buffers are now dma-mapped earlier and we can sg_dma_len(), otherwise,
since it's walking with for_each_sgtable_dma_sg(), it might wrongfully
reject some configurations. As a bonus, it'd now be able to use larger
chunks if dma addresses are coalesced e.g by iommu.

Fixes: 8c0cab0b7bf76 ("always dma map in advance")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index d84ad40eae49..3bf800426fd2 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -63,7 +63,7 @@ static int io_area_max_shift(struct io_zcrx_mem *mem)
 	unsigned i;
 
 	for_each_sgtable_dma_sg(sgt, sg, i)
-		shift = min(shift, __ffs(sg->length));
+		shift = min(shift, __ffs(sg_dma_len(sg)));
 	return shift;
 }
 
-- 
2.53.0


