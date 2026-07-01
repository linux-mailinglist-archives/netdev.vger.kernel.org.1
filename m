Return-Path: <netdev+bounces-303489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oB3cBVC5RGpQzgoAu9opvQ
	(envelope-from <netdev+bounces-303489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:53:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE16EA5A4
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:53:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b=EnPWGn5e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303489-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303489-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6D8630A477E
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 06:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C233B1EFC;
	Wed,  1 Jul 2026 06:50:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B1395243
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 06:50:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888646; cv=none; b=BLfH04kuxG0hywrNOwn70apmk33T79s2lKhh7Nju8fU0q8j4D6OaQgCgu8DobVy/Vbvsmn4KFoxLPDFxGJeVI/N5DFIqdh2wPL9wA4CSuHloz5DfcvhmbXehv9D2swwdL4x1UlbScNYuykq3ANe52dqBKSflEr/3pTe9J1Gx1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888646; c=relaxed/simple;
	bh=BW2E2MltUrh8Ffu3za+NXtLmFNG73i8yFckczgf4Yq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kc3zHGSANPP1NlZfl+pcw22qJMm1OsxiNjBucnNqRJu4Z5zv77YHd7fq3j9n5Su5ZduJuLpF/jODC/cNKPEwqa2zeWHFkAM4vTkWQWx+J8du4zQhYydDqd6M/RUAqkAQQxqmP0PorULUGEANRBgEU27W7FUxMXxwQ6sIJSu1dZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=EnPWGn5e; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84592b55832so133425b3a.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1782888643; x=1783493443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5gFr0Ah0wwlFvOzu82oC3eo89DUP3i2jLIZB/ISzek=;
        b=EnPWGn5eWM5Vszy3q5fnn3a4VP990p4di9T8yOyuvSy4OGFGlugqR49A99C2alHckW
         fQVDh3Ii/JotmEF2Ds+iGDxV5A6UPSwxBZMdx9XEzA97WRnK9QOO4MHyFyeqHel8Z0Gy
         haJjSZsq3S463I2tfcwpibZtMo3tY+gO4y/72UDb308hm6hMhOZl+8j4GEoNUoEjo3OT
         ysHTtMVpEzHMv4YbouBj1Z0YSENrLu8LJuv+Xxt9uXraeUuNh9SKOs7oFb8qcWYKlOzf
         oPTl37mdHmQS4DLo3v1f/X/NiOBwO6ECu/xS1PKHOnETl+JoDKWNNqS/2Ew9d1HdhzhI
         RPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782888643; x=1783493443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5gFr0Ah0wwlFvOzu82oC3eo89DUP3i2jLIZB/ISzek=;
        b=pU/3pYQXzFMLGU87Fz0veKjla6ZUP9mWU0L8lSMTcq1UzLMmnviK+iM3e6FDaKxt9q
         dd4/3W6N4ixoC1CusluZzRFv1/4eXpiBYzlRxNSdc6uBNH5KuCv9wOYH0R3NF9m4mU/j
         Mpc0jk8J0EWujFSYBBxrcGlT46KPihxCcC05MBYT4f9/H+9n1DyYYFyDgZ4pweEC/cZV
         lXVQ5En6bbkFbBm71Z2yHNPtd4uu8m54qr9YlyoJKxY/6mK7e2HQh+NDLAeU0j/27Th7
         pw3KxPm2Z30pIJ8x70gPGBUf6Da/dybzeRoolDqjGC9yIBqiP9h9vqjgglvHT1EJzdhW
         eafQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqp7jjoYUTKAgrLwdJU3u4DEMNzxew4WYiojxM3CtHc7bd7Uu2nfNpX/xwcv+nolnUHkcMwm+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWMDj0OPuZvYjLEQjtSVdfncc9SHg6sTwOCupLe/g9TbeUw5tB
	//CblNQWRPQgbQxnE3bR62skN7hiDICfL+H+3oNFcYFNcSGDa2ZK/VAb6XhlqDLBwJE=
X-Gm-Gg: AfdE7ckLxtTXB0zKud6P5tXCXG3cA0ef2MtIr4jh2zXntI07/s6b0kWRGtcNdTXsB/L
	yGXt4RHzU5OEfs0uVwZRvlNmXmQlSg9H7lyQT/909bCReUzD24bVYaqashAnnFVqsTl6RC8flA7
	DLY57sGM2YebBE9jpIiKja0Miik6MLbmJHggmw1jKKGNIlWvMmaI/GmolOO0CVvXngLUlr945DS
	XveSQCDBlmyZusf/10JO4/n/qzxUDohYhlatl8y9kixK5zZ/+xEJEGAoLxReo10KO6d4ALUFMjn
	2VtUDO+33bsgJfLzba05vsJSCUrbKT8jLDfJC7hVcZylYWwnUhcYXWrCmqeOfU5pvJ223QraL5h
	5Po/VLNQVCdvNogpdy6JFUqKuaWoUfmJB7H8wxjTyRWn0sHUUguwERfokUiFhiHCy/zCm5wPE3d
	Hh4q84jpcrces4XUqeLHZqz4hsVEmwZn8oRyihhN9GlWzNGMqvPiXwStMWwYOB1GfxGD/x5fHFK
	4bP99TD6XKzYDp1aK7IR6zwRkyGmGT++Rb9MfJwcSY=
X-Received: by 2002:a05:6a00:4652:b0:82c:6f07:299f with SMTP id d2e1a72fcca58-847c06f7ccemr322704b3a.14.1782888643573;
        Tue, 30 Jun 2026 23:50:43 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8479ff8c6f8sm3289531b3a.1.2026.06.30.23.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:50:43 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: skalluru@marvell.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] bnx2x: fix null pointer dereference in bnx2x_free_mem_bp()
Date: Wed,  1 Jul 2026 12:20:26 +0530
Message-ID: <20260701065030.381836-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:skalluru@marvell.com,m:nihaal@cse.iitm.ac.in,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nihaal@cse.iitm.ac.in,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,iitm.ac.in:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BFE16EA5A4

In one of the error path in bnx2x_alloc_mem_bp(), bnx2x_free_mem_bp()
may be called with bp->fp uninitialized. And so, there could be a null
pointer dereference in bnx2x_free_mem_bp(). Fix that by adding a null
check before the only dereference of bp->fp in the function.

The issue was reported by Sashiko AI review.

Fixes: c3146eb676e7 ("bnx2x: Correct memory preparation and release")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only.
Thanks to Simon Horman for pointing out the Sashiko review.

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 5b2640bd31c3..25ee45cb7f3f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4712,8 +4712,9 @@ void bnx2x_free_mem_bp(struct bnx2x *bp)
 {
 	int i;
 
-	for (i = 0; i < bp->fp_array_size; i++)
-		kfree(bp->fp[i].tpa_info);
+	if (bp->fp)
+		for (i = 0; i < bp->fp_array_size; i++)
+			kfree(bp->fp[i].tpa_info);
 	kfree(bp->fp);
 	kfree(bp->sp_objs);
 	kfree(bp->fp_stats);
-- 
2.43.0


