Return-Path: <netdev+bounces-258746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPK6Ign1kGkCeAEAu9opvQ
	(envelope-from <netdev+bounces-258746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 23:19:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D494513DB24
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 23:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D3D5301457F
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 22:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEBE312826;
	Sat, 14 Feb 2026 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGyW9r/Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF53148A6
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771107590; cv=none; b=kFEw5xc4Czm5UwiXalikhkPAXtgKRQiGaIHq1x3nTbt6QyqDfyowOf0be5ghaDsYZpl3vxJQ3lU2zhiog8hQd986F/2aSF16j1Fu2tV2IknT8bo10nvT7nWwcN78Y74aP+Svzz00Fe06QSX/QmlwK/hctuZaStRcExEO+1OkbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771107590; c=relaxed/simple;
	bh=zvgYwbndzjuLdn+N1S5WxooWnhAkhdeY9CsN2L6FyGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tgd/2NyAeOYIXydrUVkc6fuBdvmtxX6LBns/ccm3QppAuHhtiPK7jlB41B2bkeyOltn5gexJiRMBQC+NBf5mB6ZyT/o8XqVzxbz8EIWKEB9dCvZoHwv3RBTGy7Rv0nu+Iy2EpB/+460kNGBHYQXLHind/ChoIhBxrAPmznEh3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGyW9r/Z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48370174e18so13276405e9.2
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 14:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771107587; x=1771712387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IfWuWXCGCqCd6Ahs+RwT6PL0vAxh8vICPMFNyO+e8dk=;
        b=gGyW9r/ZI8r8fJP/pcWI+rDrKEGARFCDRoFZwydWXNoI3RSSD96OMOmpDWZtNhoTAU
         Lbrd0tDnH5ZqCrGfVrfzTq+g35/BxDVnCFzsXfNOVSWq4mwIXWEIxZu35PRP7fAHjQgB
         8TLWUWiDuySiiTz6i6rujX264PrFZVniBsXUHXdeWkZNIPhfcKx+JDvQDD2itoEhgkss
         N8ENIsvmHgDyOopWySQKfLN6lsY4I04eyHWvRbFAV6UmlkLdUTBDqYZWytdkoljX8QJh
         P+rXECqfFpUP2h8UM9w0vcEFYIjFCsT5CuE9dB/y0hYvhRIkbZbo3ZQXFw1pP4eLM4dc
         +jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771107587; x=1771712387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfWuWXCGCqCd6Ahs+RwT6PL0vAxh8vICPMFNyO+e8dk=;
        b=ka+q5uyJ37Y2k390bzRft6cfiy9dO0K+s6R9LLfDzcdpO+efcurDJ8pAzBY/DLakV9
         mewwa2Ot/Oh1mxcLUJwqOddXLcgBknHaZSHo7pwq/q4LG2trTJVWYIgw1FAHvi9XDPtW
         Don+CChp3UFRityDcdQFrCOIjVGSaMyWO7B1gPQM40hVuAhgRJWFkG70ZfNArWqhJsFj
         OcO1U5Cs7Ddgetwxs5K2NAhsENZ11HmRayOX6ODat4SarU4szklw/jBj9usIVCcbOLyd
         CpVc9sJVQz0JPB0U2mDiw6DrnJYe8All8DrvfYZOf1uHtngGoY5LxEsvSoNRfajov4ho
         Zb2g==
X-Forwarded-Encrypted: i=1; AJvYcCVGoDX3hka+ozqotVWgmjzb/tvrBh7Rjq0JVrTu0en82TcLPb0rsuEWeXQGjEAJp2GqMIQyD7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3VPrmhrifTdASae/1Bp8urKzuFY8UT50kQT0Y0xmAfHqCfW0
	vzAJMEiETLasi0BlIFs/kclheWpcDdoSE6VDdmFrpK8zS84Qa4NwJgsoTDNnKA==
X-Gm-Gg: AZuq6aKEeXN+7GsXsaD/bty1w4qs12+k9GY0UF0lbvToUPPOuUCw3Au5CIAAbegsM3a
	iV4uVHT1DrpUPNwEJhJNulUAZBSrV03JOY88i1E3940mvXOXhkDrQP5c5oTjW9bya+OrfJxnYzT
	lhuGOwVHhbWpA6CB2+5iMTpJhumSPwWB7qr9yh/3shUeth9g5Totfogce3YnBcpP1v3EgWPZXmm
	zy1zTyYm0QR6pB383wd2bNZ1uk4n+003wYMb/iipYxU56Eit2qNVXBjnA+xEyhkk6GCgyBABRKE
	j3raKRQn1ffgF3Dt1W8REF3N1XtW0lX6y/CrW5t79Yv26invJ3yE+v1p+VmO+mK32iVkrBdoNgU
	g4TNT+o88AJ9XjRwcXK7MwpdJ2MabufMAvp82PgYWwR8cBvvvwWCq2tt6xroMSR4zTNmoU3k1R2
	QiWvy6zGQmSNviYzG+UJ4zfi0uDZxOBpKOAIhQlDTgpW+8vCfr6YJxbOBl4K6xXwj9dBFUyEUHL
	xNXigPblvmWaWUsCi2BqGDqO5ZC2g==
X-Received: by 2002:a05:600c:8189:b0:482:f12f:f35e with SMTP id 5b1f17b1804b1-48379b98ff9mr60265975e9.12.1771107587038;
        Sat, 14 Feb 2026 14:19:47 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm82462235e9.10.2026.02.14.14.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:19:46 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] io_uring/zcrx: fix sgtable leak on mapping failures
Date: Sat, 14 Feb 2026 22:19:32 +0000
Message-ID: <de01fd4111d3f89ddbddb70bdd427c741f0cda46.1771091730.git.asml.silence@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258746-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D494513DB24
X-Rspamd-Action: no action

In an unlikely case when io_populate_area_dma() fails, which could only
happen on a PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA machine,
io_zcrx_map_area() will have an initialised and not freed table. It was
supposed to be cleaned up in the error path, but !is_mapped prevents
that.

Fixes: 439a98b972fbb ("io_uring/zcrx: deduplicate area mapping")
Cc: stable@vger.kernel.org
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 69567e19b4ca..006e1bfefa5f 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -288,6 +288,9 @@ static int io_zcrx_map_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
 	}
 
 	ret = io_populate_area_dma(ifq, area);
+	if (ret && !area->mem.is_dmabuf)
+		dma_unmap_sgtable(ifq->dev, &area->mem.page_sg_table,
+				  DMA_FROM_DEVICE, IO_DMA_ATTR);
 	if (ret == 0)
 		area->is_mapped = true;
 	return ret;
-- 
2.52.0


