Return-Path: <netdev+bounces-280046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN5YIKs552no5QEAu9opvQ
	(envelope-from <netdev+bounces-280046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:47:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B874385B3
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA7B7300B3E4
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34E331203;
	Tue, 21 Apr 2026 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fItJrilt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA72D949F
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761214; cv=none; b=eWWGUEbMbl4eGlIvppeOZSGeEsy467KHc49eGtvEsDgBxg24U6r4JE7J2Dmtt3GwBO6aVi1OG6Xq2fpZYJFPJdGhvMG2E2yQCoabnU6kTVb97r6zlVY2h27ez5J1YHFJxA1NfTaZ/+hoS8G/8dnuwPMQYNTbGgXoenvnP66sSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761214; c=relaxed/simple;
	bh=UVKjyWhi4na3bR1TrYbkxo/ZBEsE/cRVNqrrt/ZNYmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlQPnUyDVilb0d1sRjkdk1FU+RJU0q1fTkMpUWQN0cmxGLq9kbphe9gM8LxUkBKRpv5KVsX764YVOx8mrixu41+Eu7PzQgIl/ffjT7NtQr4FyHl+FGKmUy+WT9sktI7xzWwDvC2r0yCIkwzFecbvAI23UW8Txp33WL6VWoIVui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fItJrilt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so2651001f8f.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 01:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761212; x=1777366012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLQJdsAZvFdCWNDqX1fkCXL1YPXD9Vh5xaESVcWbY4Q=;
        b=fItJriltH1AAwfyYUlKQpWiV/3UsTlk0iWiwgp9y92HQZ2rzrpqM74npZIof/MVTy9
         lglHN18wLlC7MO6W6AcC0LLOxQXbtzlaoprPbQAb4P5dNbgLGvIdZDTOT/o4oEd1McJV
         1K88MdwjdU/dFjmuM1aV4V5JA5UsmMVpqNGvEaOme4DPwfGtMcX+0B2RIpDwu6izIWsC
         x8ewb1R8k68Tbym03e7LIsHsynUkEZqFa975xW1PwLYiGGCUtw3C0eyWnKrcbL1AihYW
         EEEZgFA3vPEBC/zlUY0Ghrq58aLQHDTxJ2jKLmCpKBgLVZIOmNcerIZxFmXXsoS14+vg
         BfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761212; x=1777366012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLQJdsAZvFdCWNDqX1fkCXL1YPXD9Vh5xaESVcWbY4Q=;
        b=SyRVPDYWedQWZgbG/bGfkXgguI6v6DYzmB5szB8scIZh767JrIWxu0wJr+dBRQq68a
         S8TioFZ9/at3XPcDCRC0S61jrdOzLKZ/WgbOjNhwyJ/LGKx1Bw4nWIqV6v4vMFt5gUmB
         3X95I4tJnnZtFj5MWsMrIvXJP7CKlyoEX+wkOwxVljbgiJQKNzftVuuGq/wEXaPw0Kp1
         XN2+X8o6/Vuj7fazK5ePDpKWA97pfZ+Mvq27Y0QBOA90XTZcS6RjNYAA3i+6P9wUhBrp
         HKtNZ7E4oZ3WRJMEYfyUcphb0t4GeLy5Uyf7irsFBMDwBuL8TaUpWdlabxbG0WVd7Iva
         9ElQ==
X-Forwarded-Encrypted: i=1; AFNElJ99CFya0H96IRRqghfDDjORs/mPX4fDlnZXKvGxb7Bd47UH1BcMLMbNBM/498gA+b2/w6vkS3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt1LZ/NMoyL9FHJwcfkKqTWL7cLOzs7ApPUhq7c9dETGr/dKCV
	79t0LUpBZanNy0YP52K8rg0YHTOcVf4S26xuS/nRr7kvV1rOZatOiu3D
X-Gm-Gg: AeBDiesDvW+ge+5CduLElQ3C5D/N6rkN0vXzXRgQOJN2l1Sg1VifgK/EUx1mu5NOywR
	zF9TURsFhBE6QuIKS8S/ul/uvCHDNaifhq5JgilLd/CRKv7Ii33L3LfpR0d/yINZqlJSyNP+jw7
	D0VqbYGdKZ3wxB7zv7GYrAPCkKnr+XIwH2AOHoCDuFER9NJsKUOsVzNf/VqUzFFPA3TvT9qIFF4
	hx2xwrOz62IkQL4vBYMilUcbieKIq0shVL8smFl+guCMKBWLyHz9ZT6i6N/EQ58bNrsa9uZN+fO
	vcMoGrOfnazoXIRKxAMkptI7Fn8FbWC+Xzrgl/hvH8lZqfvH2kkazufCn0T7DK66UfAS2PTF69V
	8AJjjjLyUBbNoQzQE2QRVU9iB8MREg8WE9oG8aQG47C1EPdgGw1QuGYw7oZHiBE3P6LlmiiUt3A
	ljKskicL2vSuI/9UaeRLLAGiR8IpnB2wC6lwyyvyem25onQ6iMjLFDr25sxQ0Iwox5ibf7japAE
	2kVIrV3+Xnu4/JFliXx
X-Received: by 2002:a05:6000:2909:b0:43d:7403:4b65 with SMTP id ffacd0b85a97d-43fe3dbee20mr25711540f8f.6.1776761211757;
        Tue, 21 Apr 2026 01:46:51 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:e3a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc07bbsm38374432f8f.11.2026.04.21.01.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:46:51 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] io_uring/zcrx: fix user_struct uaf
Date: Tue, 21 Apr 2026 09:47:04 +0100
Message-ID: <e560ae00960d27a810522a7efc0e201c82dff351.1776760917.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-280046-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00B874385B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

io_free_rbuf_ring() usees a struct user_struct, which
io_zcrx_ifq_free() puts it down before destroying the ring.

Cc: stable@vger.kernel.org
Fixes: 5c686456a4e83 ("io_uring/zcrx: add user_struct and mm_struct to io_zcrx_ifq")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 9a83d7eb4210..fab3693ecb0d 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -579,13 +579,13 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 
 	if (ifq->area)
 		io_zcrx_free_area(ifq, ifq->area);
-	free_uid(ifq->user);
 	if (ifq->mm_account)
 		mmdrop(ifq->mm_account);
 	if (ifq->dev)
 		put_device(ifq->dev);
 
 	io_free_rbuf_ring(ifq);
+	free_uid(ifq->user);
 	mutex_destroy(&ifq->pp_lock);
 	kfree(ifq);
 }
-- 
2.53.0


