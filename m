Return-Path: <netdev+bounces-235281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067FC2E728
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 745B34F0CAD
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C433431D387;
	Mon,  3 Nov 2025 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="1PCtj9qC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34B31BCA6
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213294; cv=none; b=fQ+oD4yyH98CDvUvn9eKN/WU/8yhRFvYaLgMKu67ChW+ibnCjdhJ8ugTQXvH9sMvN8OHF8dOc59FJ/jsotiuG6k9Xw1QOc1uwSoRXMslqumUiqeXE/RqNi3p8olzOv+11Jn4RPeEyedB+e0SSacpBndpmHrNy3h/jGkv2KUsiFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213294; c=relaxed/simple;
	bh=RtN5gjrmQIlUZkZCw0u0g89U/qJDqD0LaWtEgAKlR4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8ECHPaVVUTDP1Dw6D9lo7i44gTnANsB9zLu4la8JFN42Qawff9fTdmLbKVDemj24p7197bixpEgHqkGY5bKXOF6W1NTmWN+kDX1+Y3wveXfjz6R4H/s+OvmkCmSAv+Dw7cHdbwz2inhzqQ+y8bOYZqk8xMViFXDRgROAOowTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=1PCtj9qC; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-30cce892b7dso2584493fac.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762213292; x=1762818092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spZaZ0BQVbN2cYL13O6nJp6uxw5etopLFoexoflwJGc=;
        b=1PCtj9qCbT2tErLr9r3Z3GBCQU+UpK8iaEqKaen8lbcVz0iYtiqrFTmYlPpzuZliUa
         x6YNbGOI/CpzZbqRM+o8ZqNUpfWQ3MXTKiwwzT2KB48oaAPYTqHIu1QiSHNByg0vhXbE
         TYZ6Z1uCJKhANdG1odSMtGzmCyreCAc2ZfexG5N4oiiakHyjzRUMd3wasBjqGBx1aNRK
         gSbhede1puEV8ty06EI3ut7j+SgQP5fwE5ja3+AjkNGoc9YBkhAUkPcJ8FAMNKrAGuDP
         ikQ6FKWkvQNC2GTTLg4KkKp2tut1xYJyXlrtgDiTeN83Q/5CTOTJwtvj5dA6oh+nOYA5
         tjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762213292; x=1762818092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spZaZ0BQVbN2cYL13O6nJp6uxw5etopLFoexoflwJGc=;
        b=t79tsLZV4EFt6bnhUIXZDg/dJgruyn9p1FQ9k4pJk4kKRhe0QPfWDUu0323rB6Eq4h
         Ie1RHRQkx4xMKDd6CvXSL7KPOm0yp2WakW7q8vucvRvqZMvdGMDf0xmxUl8eV0Ntp+h0
         wk7BqVZdnWsq2H2aI3RtnIlh1lRfTrD3OmMlNvFZyqYQ+rnZzg7U1JmJcJ1vSaFSgCKJ
         jQTd3MTQMV7cwOQSn9N0mtDfCYp0Ln61iqdgDsqkdw7DUpOccFuLRH+HrqrLKdn5QWB6
         A+3Gz9OyISVrqQbRbzJDM6D/vWQzUK4KQK76h09lDfwnZ7phaIEFWGL5YTFmNyxE0EyE
         j0yw==
X-Forwarded-Encrypted: i=1; AJvYcCWyeFddbsmw+Zm/MJfNxaYAocxG5mOSMk6oWeDdvRyZWF0r4FWnd7leUgMjfKo6fmz0HBsvMUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdZq9WJtVW/iiOCejLwweyt3vgzPnOgEj6i9CP0erOyJGqCpIa
	/7PflMc0n5bFcPk/IE1EnlQ/+cPEMWuQ3jTDXjrDaNlB5dwneSSeNySEwTLET3d4fx7Q5ivyjDc
	CKARt
X-Gm-Gg: ASbGncstUQlwp7fCDvMbyeylQPa/84jRUOkx123owi56p5NKa694VbEHXPJWeVNZwvq
	ObGcqQSYBHKJeo8gzleNdK7zejOxBtU/aBpxDuqAURgBz9gGF2wIPBaBBB+dk4v9c8mS1hfGZle
	61Ky1kYbAziYssdCykwV3IxLNESJ6+0wcsmB78pPlaPmKhB+7orCpsVpifKC8ZoYTVJcrqnoYXH
	50wtdzhJpOcmN7CW4jK75hFHJVsYCiBgH/cWcnr9GxkDnNALr1ApFdFwFc99iqQae8SP3Ay9wxY
	OMss5CbjywyYh/MWUtV91eGb9CAspXudyoCGf/y/KuOpShn7kgk/LZKvv6fQL0NRwiEK9bmxRuD
	ojQqYO7rz0nSad10CizznPLtbFwVM0nkfKVNHEKIj67qNbSQoX2Tzt/M4tG+BWTkVpdtDbP8UwJ
	fkz1xPcfDJ/o5rY3pA6AUqtAlac2js3xGEgxJcswW6
X-Google-Smtp-Source: AGHT+IH/gxAckKE/c2j6H9PecKKD6Sd58xg0p9LAJO0mlwtwELK1rAHcQapI7HbXpt1nllwoqZGtGA==
X-Received: by 2002:a05:6808:228f:b0:441:8f74:f3d with SMTP id 5614622812f47-44f95fde215mr7406492b6e.55.1762213292045;
        Mon, 03 Nov 2025 15:41:32 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656ad40e2f5sm459675eaf.10.2025.11.03.15.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 15:41:31 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 10/12] io_uring/zcrx: move io_zcrx_scrub() and dependencies up
Date: Mon,  3 Nov 2025 15:41:08 -0800
Message-ID: <20251103234110.127790-11-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103234110.127790-1-dw@davidwei.uk>
References: <20251103234110.127790-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding zcrx ifq exporting and importing, move
io_zcrx_scrub() and its dependencies up the file to be closer to
io_close_queue().

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 84 ++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 00498e3dcbd3..e9981478bcf6 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -544,6 +544,48 @@ static void io_put_zcrx_ifq(struct io_zcrx_ifq *ifq)
 		io_zcrx_ifq_free(ifq);
 }
 
+static void io_zcrx_return_niov_freelist(struct net_iov *niov)
+{
+	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
+
+	spin_lock_bh(&area->freelist_lock);
+	area->freelist[area->free_count++] = net_iov_idx(niov);
+	spin_unlock_bh(&area->freelist_lock);
+}
+
+static void io_zcrx_return_niov(struct net_iov *niov)
+{
+	netmem_ref netmem = net_iov_to_netmem(niov);
+
+	if (!niov->pp) {
+		/* copy fallback allocated niovs */
+		io_zcrx_return_niov_freelist(niov);
+		return;
+	}
+	page_pool_put_unrefed_netmem(niov->pp, netmem, -1, false);
+}
+
+static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
+{
+	struct io_zcrx_area *area = ifq->area;
+	int i;
+
+	if (!area)
+		return;
+
+	/* Reclaim back all buffers given to the user space. */
+	for (i = 0; i < area->nia.num_niovs; i++) {
+		struct net_iov *niov = &area->nia.niovs[i];
+		int nr;
+
+		if (!atomic_read(io_get_user_counter(niov)))
+			continue;
+		nr = atomic_xchg(io_get_user_counter(niov), 0);
+		if (nr && !page_pool_unref_netmem(net_iov_to_netmem(niov), nr))
+			io_zcrx_return_niov(niov);
+	}
+}
+
 struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ctx,
 					    unsigned int id)
 {
@@ -699,48 +741,6 @@ static struct net_iov *__io_zcrx_get_free_niov(struct io_zcrx_area *area)
 	return &area->nia.niovs[niov_idx];
 }
 
-static void io_zcrx_return_niov_freelist(struct net_iov *niov)
-{
-	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
-
-	spin_lock_bh(&area->freelist_lock);
-	area->freelist[area->free_count++] = net_iov_idx(niov);
-	spin_unlock_bh(&area->freelist_lock);
-}
-
-static void io_zcrx_return_niov(struct net_iov *niov)
-{
-	netmem_ref netmem = net_iov_to_netmem(niov);
-
-	if (!niov->pp) {
-		/* copy fallback allocated niovs */
-		io_zcrx_return_niov_freelist(niov);
-		return;
-	}
-	page_pool_put_unrefed_netmem(niov->pp, netmem, -1, false);
-}
-
-static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
-{
-	struct io_zcrx_area *area = ifq->area;
-	int i;
-
-	if (!area)
-		return;
-
-	/* Reclaim back all buffers given to the user space. */
-	for (i = 0; i < area->nia.num_niovs; i++) {
-		struct net_iov *niov = &area->nia.niovs[i];
-		int nr;
-
-		if (!atomic_read(io_get_user_counter(niov)))
-			continue;
-		nr = atomic_xchg(io_get_user_counter(niov), 0);
-		if (nr && !page_pool_unref_netmem(net_iov_to_netmem(niov), nr))
-			io_zcrx_return_niov(niov);
-	}
-}
-
 void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 {
 	struct io_zcrx_ifq *ifq;
-- 
2.47.3


