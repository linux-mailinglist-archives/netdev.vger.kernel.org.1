Return-Path: <netdev+bounces-257283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOb3H8XbhGkV6AMAu9opvQ
	(envelope-from <netdev+bounces-257283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:04:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F96F64B8
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CC3C3010DAF
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD0A305047;
	Thu,  5 Feb 2026 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJXepR00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800828C869
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314690; cv=none; b=J8UWbSZn8/E4IZ2uU0fCyxHJebSNPxa+dSU6VtQuGCclZZCpW4+UG3kTOY03sUuaVdMj4/DJqwC3Dx2SLeGSD+vIZvEiMryS1E1hyBOjGHYqvQdc7AU0f642WdWhjiqvswVNO8lzRYrvAqfIcoENb7q/iJbv5TJrj+WHeJAlts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314690; c=relaxed/simple;
	bh=hRREcuqUBPsZcxZ3S25elriMROdIzvwpOjRUL0Djdec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLMxEEykmgQletuCdG1arhRvwR53+OobFuSoEzVDqfKlecID/p2N9y9KJzqtAnnUsiY6++suStoWv5O2VY2aYSKWr+XQAFPaZGuwtsbjAAcrKBDjiVLx0T3QAqd1ED0XM76dWdgSe57osDLNHuoUNkaIneMP3/O3FxNlqnAXSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJXepR00; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso1010041f8f.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 10:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770314689; x=1770919489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tzyb9dTmR1mpIk8oF584sKimNUfLAb6TY7/PYKotmuA=;
        b=JJXepR00UQ+EbsUv0TRtE/RX97JqjSfaP9utxIh+tQkJ4bVdDjGWZqzq1v3+ULFbnN
         vFVF7yYVpirzG0RiRDml1CgCQhp1PjJvftBlRGm6DqfKkSCg+S7QIwFuDpgoT5OhHbdc
         60yCWI1EkekEBOunbUnpgfQkgHygq0FUlceM+keARuXX4PQXKq3JYDYjpLgNjGL4DrE0
         sliLcNvBgZTnKL2WlXO3j0nsk2+zG7vcz3rxXKX9ym7Uc9rg54FdcJZ8TVh+kGEnnVUb
         4+9/u4uChPDhl/QpUCK+f3vxOv4AcqNhUsqVuZnmSxZm4c5+3+aT4RPjJ1ZUlS4rO30j
         Sqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770314689; x=1770919489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzyb9dTmR1mpIk8oF584sKimNUfLAb6TY7/PYKotmuA=;
        b=rbYObHlwtpuTn6vOniWvrif2BUmeS87+3s8+e2Qmu8w24dsDw9vufWQTOjr6FOSgFc
         6sPwl8wkTVFuQDF6MqZ0fqAkfqhiAxh3rsHI+7T8vtyuRzRZsFQIOR9BiOyaXkO+ZjRe
         jI6JumdjE10Vu2MhinzLgTnFetohcJp/A32qAqXhurmNT5uEpBQACtIxXT5w+SeJby7M
         1i9MMPlOFkaQAUSVCT8xhjEInXHz8GLoAVXenFW3vkZaRpYhWWRAPKxLSi56fdGBPXGl
         +JLSQxvuhEnh2gu77i6cBkMnT/c2d04g3yNqdwKwctQn2v5WLqsnhxgCnHLma0gZsE0S
         9b7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxlcChI4msB7u25C47Fj+aB6CdbRCzKowfCrIN57wabkfn138jJp6HEl/54T/MgpyHNFUn6Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJn0rayZniFSvIsCdUVK8bB0K2i3q1qKqqPMJrCJy+68SkBWw2
	tWr6Wwic77ULCStodKFarLHKblXlZy+uGAJddqcZI1HgCAMPVY5nQIhh
X-Gm-Gg: AZuq6aJHk6sTUGEZHYuEeeomkiGg9Btrwj0FqzV5U8wkNTfcOKBSOmQF8XUXi1MEzIR
	AI7QimdCLUCENSJpEzD+dI+IcW3GNUwINuvCi4hYqLIA556ko0GY+dAdryvI2EPR17hVzgt2FRJ
	CaFuyVW0F6Q7FmictPV1kL95D+0RInSsTZOT9+IeZlkn8lmk8iURAh9TxQ6BQN8U3mr/uekJRza
	/muyj4ReG+6zqLzcse9Y0HJCtQ/JOtdkcWmxmSvR+ab7X+jiInlGCVj9BThflFsPmZAplPw81th
	T+Wqbqx1sMKJhiKMGcGmlgs+knT4GSmX2Kf/QdxFzGMG7aBmOWG6cWlnRLql2eXpBNsUQMvG1t4
	py0oL1+8Cm1tsCh+s6zfETJgDloSMrJfgDg4tEsPlKyPTLb9aGJmyzkLged5vVe/1+8C7lkFFDP
	7sZha8EEzvnS3k7pN7gnUwM8gnfsp8G1di6apLMcc5W5133ACFPelcQrHO5q+pSLmrrecjlKKey
	rgtY1VuU/pbtK3I8Q==
X-Received: by 2002:a5d:584a:0:b0:431:808:2d32 with SMTP id ffacd0b85a97d-4362904b903mr225923f8f.7.1770314688625;
        Thu, 05 Feb 2026 10:04:48 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618058473sm15460469f8f.22.2026.02.05.10.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 10:04:47 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 1/1] io_uring/zcrx: improve types for size calculation
Date: Thu,  5 Feb 2026 18:04:43 +0000
Message-ID: <ebd70ad4ce36d8487ac994ed464b97aa08d8ed3b.1770314615.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-257283-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 11F96F64B8
X-Rspamd-Action: no action

Make sure io_import_umem() promotes the type to long before calculating
the area size. While the area size is capped at 1GB by
io_validate_user_buf_range() and fits into an "int", it's still too
error prone.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 8a9df72bc094..6a6e2f8d6133 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -205,7 +205,7 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 		return PTR_ERR(pages);
 
 	ret = sg_alloc_table_from_pages(&mem->page_sg_table, pages, nr_pages,
-					0, nr_pages << PAGE_SHIFT,
+					0, (unsigned long)nr_pages << PAGE_SHIFT,
 					GFP_KERNEL_ACCOUNT);
 	if (ret) {
 		unpin_user_pages(pages, nr_pages);
-- 
2.52.0


