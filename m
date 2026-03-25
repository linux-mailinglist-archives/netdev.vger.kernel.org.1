Return-Path: <netdev+bounces-271511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFprI4DXw2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:39:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ADD32503A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E471A3244663
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE893D34A6;
	Wed, 25 Mar 2026 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXEOFkd0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5883D3308
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440501; cv=none; b=hsCr1W+FunAFYSo4Ke7tN7l5eNjRhU9Dp40MRJKuXDaZTzq1dMxklYRopcJT/jxMOcZytSNEXef88Txji5lcOXiIw04bEc1MvP1pdsNSfkEyFfI6b6opKqQlCFs5bqpm609Q/oFpcZaLOwIgdnPdNhtWI+G9BQ8g9cA/9b9dPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440501; c=relaxed/simple;
	bh=/kN/uNIofHDrbzYJpnMhcPxipapG1wEa9AygHEJJxcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDKF35d46hgbVOdNU/c1pgh8b3e+fyaOw0a10tajkyMnGY1UqGinE3UXHw5qZ3yBj1u8qeL7+N+omrYS5xQqll6V7tqJkUW6Sj/JZUHIiO5SMO+V+9aHo4nSydmi7BcRYnXh+ZpuQoEZJe0M3uceLiXDlHYnw+a1GldPX1B1yFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXEOFkd0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso4244112f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 05:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774440499; x=1775045299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEG1hWxQAEwGv/inzSaw0nBixQ92O1cAUgSliNc3738=;
        b=CXEOFkd0BmDeWvbqplY5EP9Cj8MfiF3e8hNy19UIWu7dFnLVLU04uIxE0OXb7wYl2n
         yG2fHAGEvuNnuViM5+Sg8lvpvVal9m00IxrSOUjOVcPcIxUKj/q1e08lrEczT6kALOfG
         tUnJLUl8lh23CMM7JGqXQT+0ECqc99/A63c44+RdfDg1JhSULQSVEOUE7gbPOzoB6mKx
         M1tW5BWX9OPXcRXsBQ0h32ILdWXhJrFIbLGaaASrLs6LUIqqSRIvoC4oWrbgparOB5D5
         d5UOZB68ngpmTnSAxEjBLFj0LNN/zGXFvpkVUdurqSzMESd2ahURNiP4tF+kT1F9XD4t
         CGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774440499; x=1775045299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEG1hWxQAEwGv/inzSaw0nBixQ92O1cAUgSliNc3738=;
        b=isfqsgjDhz3uHt+XgdTRWKPyID0JhVneDSLh7pqm4LYyyzBGMIHa4kIWyRi1cafeFP
         vcNDLnh3t+f5OdhHRrtzb9skco3w+EZsfE9lMgNXs3DAc2ZrkCNv6g35kFbuWpN57GlI
         7q4yzWDC7SkMyw8VgL1ZuwHmSvXFGerme83MkSPPUXtKYitOFDBIRAqh15qf1MBMwCFX
         k0rUAPoWNju02idOx7P5NJsqJH+w66hhCkRyahSxwY6vquQXcHhFcO9cLOa3Mq7vve5A
         J18GRr5wH7hpepEtkdzaXWeNxAp5Rsv8aMnyFAwWN8u5sj6YSyQ/7ItQOI0XrNBNJcwP
         GYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0zuiSaQX5XMWTYfKMXcxdC85BADDeOHzzUajzR8/OJUab9VD39NkHRmFQIiG1R4dtjZRWc+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDGKM88rHiUlS77HMAr4y/dOvoOTDXQ/Mm+J2rEwx6071ywtWS
	jsrW1AAbLhRBuQdeSeJidXHHh9Rx23pLaJRv54gkgHHEUcYRKvrG+nHNvtU27Q==
X-Gm-Gg: ATEYQzxYmxHHv8blXf5ANKW699eSt6xnBeeIJgWhSkXWpFqpzFTXwtVorH5m0UkMfXT
	5O9xuKjvc4OPiaI/9JW5nLkkWxq47F5bFR1Z0BBsiyyLmPFotbgDV0M9bYhfbC9cPWhtBr7MB2Z
	3TyqcCLM/ptdBcNWymtz8CoSMvGQhrex9oTKudRR/53YkH3dYbMK73GuqMUL2qMtvlsSb2NVt7K
	fGKApVULJL8elDw62zhIU+YTWUW+VBaHzzAewqOkpWCaP3sRv4uSgO873jl57HzO7PHiS+ztEcX
	pwVSsRJfVPnlECsQ/K98ArklwD6jzR3APXhpvzAJDeGNB+V801xflV4Crk8Jju7jr1+Omle3fDe
	liZYCfSBAtSS9F5YuYEb76ti2fjmICKdvQeGPpbXlxKdfuJBX/O1Eq9rkSaRiFMBfd5AeSMvf9Q
	xtjeqDc5fuiNGq5km4GWstHP13RADoIaWRO8FIBPYdNbEygewrbTlGMNlMl2vJjlgWVYx3QJ/7Y
	Ki/f6pwi3oj3VvO+xoH
X-Received: by 2002:a05:6000:4305:b0:439:beee:43b5 with SMTP id ffacd0b85a97d-43b88989dd9mr4622333f8f.3.1774440498896;
        Wed, 25 Mar 2026 05:08:18 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm48618289f8f.2.2026.03.25.05.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:08:17 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 2/4] io_uring/zcrx: don't clear not allocated niovs
Date: Wed, 25 Mar 2026 12:08:19 +0000
Message-ID: <5c21ff99757647c8e72d44714a8d9d36410bacef.1774439286.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774439286.git.asml.silence@gmail.com>
References: <cover.1774439286.git.asml.silence@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-271511-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: F2ADD32503A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that area->is_mapped is set earlier before niovs array is allocated,
io_zcrx_free_area -> io_zcrx_unmap_area in an error path can try to
clear dma addresses for unallocated niovs, fix it.

Fixes: 8c0cab0b7bf76 ("always dma map in advance")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 695398d2f2e0..fc6199edad34 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -289,8 +289,10 @@ static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 		return;
 	area->is_mapped = false;
 
-	for (i = 0; i < area->nia.num_niovs; i++)
-		net_mp_niov_set_dma_addr(&area->nia.niovs[i], 0);
+	if (area->nia.niovs) {
+		for (i = 0; i < area->nia.num_niovs; i++)
+			net_mp_niov_set_dma_addr(&area->nia.niovs[i], 0);
+	}
 
 	if (area->mem.is_dmabuf) {
 		io_release_dmabuf(&area->mem);
-- 
2.53.0


