Return-Path: <netdev+bounces-235277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8935C2E708
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FFCD34C074
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706FB314D04;
	Mon,  3 Nov 2025 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="P21xn0uz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8B2FE582
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213288; cv=none; b=Uocx6sFHhcf8LURH7tKDzlDVjKUbFS4i+BUxcbDjTZXsJ70rw3DLrLGDKQGI80JUuNezB2GfkpsCYnvQ3LyNiAE36IDegMLuzKLa0xlaabfjEGIKDceHrUJ9p37Umc45VWxREv9xc8SOGAYbvuzA7k0zcZ+p12tWPfKrFIchv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213288; c=relaxed/simple;
	bh=ghVssMHpC0oIaoHxmpGAC4MvW7BGjfefvp/Kx9Ztgyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJfQu5HwG0Up3Z2pNYYYcDKFAY60NNi/E5FswkBNr4eRG1TBOB8j9hCfr89q5LzI1lYrHbAhwEU19ELboMk4kGQdOXd7F3TDp9PD3ZetHZROLZLzUzbecX0zt5VPZJds1VBCMcRIGH++eIE9VNdj5s+RAyez2FQVsGmJFwNlFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=P21xn0uz; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-44f98e6e38cso629847b6e.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762213286; x=1762818086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJZomHf0c02I8GzHr7Yy4RcFy4+yacK3SUBYlgxmabs=;
        b=P21xn0uzF4ija33YFqzrjY6gZpjlBuIm0Yd3WeLMNEu8MDclaoDV463ZIPjwHgolT/
         G9jVKT2uY5QmdEFw/EVwHyaRJIKVPoZ6MdG6ljCkwAOFqh2EzrHWB19rxmV8rA1atz+3
         1fhqxyYlCtyTCyNCXFxDZtm1z4oIK4mTY6rDhOqXc1L1WXCdu3Ua+wj6wzQtp/nEI2R1
         SgmGYOe6ugzdprZVOMGMoRtUJoOGjRKX0ZoIxx8IKnKrskUhPgp/MU1139p+xUcf0gXH
         F9rWV7jO2Ld0WNOrSz7MuoFg2ghaBshu6dOY3X2sexDFcwhOXguyM9PZktYr0M3VOWzs
         sw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762213286; x=1762818086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJZomHf0c02I8GzHr7Yy4RcFy4+yacK3SUBYlgxmabs=;
        b=iiFDzOn0vxnzdoMoL/wL4s9gFAGfeQevSHLf7vVqL/nEDp5xMTY32z9Y9vIUc3Bkfy
         bcTP//E7fxAcV73wTRNUVwHvcGkqnn0QJ8YC7d25AYYGuO1BYt6xYnw2p1Hg0unkRBiL
         HeNfA36Dik8CUEeOony+fcU1u3oLGXkSgC8XKJ+CTg2z7Bal1c1QaT+ks0C8A4OFOHl1
         bGPGh2FZX/w5dFfZjLgIfsMLBIcv+pu5Ed2kD8+EoiwKPoD2gcJk7LTZVjbhIw14hke4
         bOyazapFve1mNljgHgrXtgrCc8kJ4QerxHReivwMG0vj2g5urpHSs+TaRq/CnLhatEyL
         CRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTroKmduTDsSvmSbfIt0SPDDo4guY5vknVtJ60fTHBEgBKu6AaJ+TdYVEDFODIBqMHjPxs6xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpA4Hklo85cTPvoL8+tynyL/o3T5vcB62JqhF7t8nylYYLkj/C
	z4h4BCFLmvw1drkohPXMQhJH30e0HD/g4xt5j+n71ffV5YYAUuxjv/cYOvyg/wmkhBA=
X-Gm-Gg: ASbGnctJ78ZS2vbtSHqq5o/sZGIq4/bRhnGOFEW7rNYSCD0DXukZC/bajQRInI6jCxW
	70FLQ6lke2UjoQpRMMQJ0+TSCwpe4yLZfWjDJt9zM7pTS0kdO2vyu+6YArEOnpyZrz0xJaYgzqw
	0IHC+dTHGZA8ogJGCr5xwXJ8Bs55k4bjK5cG9zm5KC5u9VlLb47bhx7uADV7sfd3hliXvDQPhNk
	i1qcA9kM2WH5KAFhXTBYQbzBZSDCxSffVB/G2iFMmzMSGYoltRmRbgxw884/4epPrW5+p7aaQY1
	O6iFRO/95dDFfQ+Ibmy4AB0a2X8oMOoUWJ7xCt5uzE46n0OGtLIgGS29RMhvLghjAM5KHDgO31/
	1N2tP+Wfk+mg3peKHlF77RqI5KyqqxwJnjW3tXrPZMzXzwxivkouDspT0R2WF5OhPZgxpIfZluP
	Mi54tDKOy3dON126D0K8tPUu/uQh0PXA==
X-Google-Smtp-Source: AGHT+IEiZd3I0fAenzcHsaLz76lpEyfCzW4bC9sOkV7QwBXstFUq7jyruycEvC0760mGwh724CLJDw==
X-Received: by 2002:a05:6808:c2a6:b0:44d:ba18:2d26 with SMTP id 5614622812f47-44f95f357c4mr6113457b6e.43.1762213285942;
        Mon, 03 Nov 2025 15:41:25 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dff46fa5afsm536183fac.5.2025.11.03.15.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 15:41:25 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 06/12] io_uring/zcrx: add io_zcrx_ifq arg to io_zcrx_free_area()
Date: Mon,  3 Nov 2025 15:41:04 -0800
Message-ID: <20251103234110.127790-7-dw@davidwei.uk>
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

Add io_zcrx_ifq arg to io_zcrx_free_area(). A QOL change to reduce line
widths.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index ac9abfd54799..5dd93e4e0ee7 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -383,9 +383,10 @@ static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 	ifq->rqes = NULL;
 }
 
-static void io_zcrx_free_area(struct io_zcrx_area *area)
+static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
+			      struct io_zcrx_area *area)
 {
-	io_zcrx_unmap_area(area->ifq, area);
+	io_zcrx_unmap_area(ifq, area);
 	io_release_area_mem(&area->mem);
 
 	if (area->mem.account_pages)
@@ -464,7 +465,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		return 0;
 err:
 	if (area)
-		io_zcrx_free_area(area);
+		io_zcrx_free_area(ifq, area);
 	return ret;
 }
 
@@ -523,7 +524,7 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 	io_close_queue(ifq);
 
 	if (ifq->area)
-		io_zcrx_free_area(ifq->area);
+		io_zcrx_free_area(ifq, ifq->area);
 	if (ifq->dev)
 		put_device(ifq->dev);
 
-- 
2.47.3


