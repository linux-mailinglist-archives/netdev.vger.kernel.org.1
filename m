Return-Path: <netdev+bounces-238289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B60C56FF1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88879345F9E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45B33CE85;
	Thu, 13 Nov 2025 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYFgmwsm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5D33D6CC
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030797; cv=none; b=ClRvWnT5y13/Gc0xJElBMlFIBV7UT6K2OwZqsyPiCKnm6sJBn3npDQnRhynHYQDaRaTvwWnKfLgt7hNw60sOKwhZffObq74ByWHwFzYFFx9QULFrEKmFFohogJHGFrfuVCCzU47dWHXRpl5t7lJRg8WgUPJo25BGWRIuC3l3cu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030797; c=relaxed/simple;
	bh=T5ARdCmLzDS8EubwDtXv1dlZe11yRBbRU9AjfJTvFOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGeKU0BqRmuX5N8Ldjptc4P8VmWFbTmTf6MaC7dj26ymfIlr84SAcsKGluIrUfsoSIPUxlHz1FBpuF0WjKrHRqNla2hGmArY8yEOcbS5Ng3A8b14kGXfKQvMvZdeC15I1GJWdkQwP45u1muCboD3L89ZLGOrfDTaT3TzYAraKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYFgmwsm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so4756025e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030794; x=1763635594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq0DxcVWz5wBoNb5zy8fc3ru217Ai8VYBXV9DxFBjg8=;
        b=jYFgmwsmbLdugetxGccRaUE3xPmSthOhGxbhS9v0B82vC9ucKJ53pDim362qlx3JLn
         QbC+HbQpXu5lzgG9/wVsFPd3STJAiw1J4HaI9b2kJC3CpSCOWmugF6YwKYboTZMxVwL+
         bkBGDcxTErzrAvPKDGRmUtqQ65Oh3ycoQGRHP1zW9QKvMP+cziJHFzw23S0K9HHXc31a
         ndsdA8bOOSlYTN2B40fjDEJLgtuIfnmkTg+1zljksu/S8A4zBDGR/8yU1GhGkgdTFn4Z
         ynaEs3+VzqGE8FUVEjs87ec/1lumwxRzxUm4gHIs/aln2tlKcVWocd2oUiIl2vhQ8CN5
         5pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030794; x=1763635594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iq0DxcVWz5wBoNb5zy8fc3ru217Ai8VYBXV9DxFBjg8=;
        b=D3DPSJ7j3E/+1C+nVWiC3pz6anubJhtil+z2aovySGtrGfMvqQC2YI0m53sqHgIM+Q
         4QMHaCMxz8koVE2B6Buuq9z9AyYIVlp6HmJYeNza4G2zq7QjbiCj4hrhllrRIdvV0I+2
         VTLy9gBDQZk36wYhKq2P2CCJTZRP1cxQdtzZ+avMzcffrKaukkdtPuPJPcMlj9Uhz1AA
         7MPuGURblfFlYzHO4wj+Gud4wF/5JH5qRytnukfVs3V/IKzTI+NfSFDjZmsYedvjp6DU
         opFHIIaKdHL2biK1x0cUJ7piH68ZTKIndFKsOEawlegobBYHxbaJE9HUXtDqub6odDZ+
         yj7w==
X-Forwarded-Encrypted: i=1; AJvYcCVI5ZqQAh8hZ3Or3IB3roEn8nRQ5GySCczT/xFuL0le+ftj2Zk59eABifMFxFGt63UeVaimYIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrzdoKoRdB1OKsYM+FVXduG3cKfzrvV+KK8huqKYm0Z6eW9Qf
	Zi/qf5kV+VG/nkvNLnvugnDVhLYfE0B7/Q8wGLfTkYlGuvYWKl2IprRmT9Q9nw==
X-Gm-Gg: ASbGncsEstHVAMI96dCPV5qFPalkBojJbgcaNp/AiEsgPnzsK7ERPLPsEydt3f6oLY/
	Nfj5N/sqHRbNwsuFvmf5U1CkTsaTVzUHzYN4E4zRWPS3JH1HP7RA1iioJlg76LFFCvKlmxGxxEf
	A07iraG+6r782PgNMN94wL97bqTDJDMieP4ySgIZtpHl7m4klxrKpWppZD4LmYrogwR6FuZ/gvl
	1Z+Th9OPtohXc/1cHxt3IUky75nA5sjxtnR6CnEA9bJlRp/L27EtLIK1oU3yEotocV9vwYcRb0p
	MfvWlx+0LQDZRpF1gCZiCH8ku3VXVGhIOAfhBmCqvhQbNaIgyTBeWPHujrrVphtPe85GwL7Iz/K
	pw+W5IsZOVS0xLTNmJCNNidsDIyFM36pAfhWqruMlZtlzBLoUl08ZyZw03BY=
X-Google-Smtp-Source: AGHT+IFro3r8kn2LP2fzj9CTei4EdVgjCR7DWxoMvhdKbJtgxhI9vxnfI7/7CC67GBSUcS38s6KY6A==
X-Received: by 2002:a05:600c:a06:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-477870b3d70mr59519195e9.31.1763030793403;
        Thu, 13 Nov 2025 02:46:33 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm3135210f8f.10.2025.11.13.02.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:46:32 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 06/10] io_uring/zcrx: count zcrx users
Date: Thu, 13 Nov 2025 10:46:14 +0000
Message-ID: <a33f43735cf25517a377c2c1868296b06dea4e31.1763029704.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1763029704.git.asml.silence@gmail.com>
References: <cover.1763029704.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zcrx tries to detach ifq / terminate page pools when the io_uring ctx
owning it is being destroyed. There will be multiple io_uring instances
attached to it in the future, so add a separate counter to track the
users. Note, refs can't be reused for this purpose as it only used to
prevent zcrx and rings destruction, and also used by page pools to keep
it alive.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 7 +++++--
 io_uring/zcrx.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 08c103af69bc..2335f140ff19 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -482,6 +482,7 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 	spin_lock_init(&ifq->rq_lock);
 	mutex_init(&ifq->pp_lock);
 	refcount_set(&ifq->refs, 1);
+	refcount_set(&ifq->user_refs, 1);
 	return ifq;
 }
 
@@ -742,8 +743,10 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 		if (!ifq)
 			break;
 
-		io_close_queue(ifq);
-		io_zcrx_scrub(ifq);
+		if (refcount_dec_and_test(&ifq->user_refs)) {
+			io_close_queue(ifq);
+			io_zcrx_scrub(ifq);
+		}
 		io_put_zcrx_ifq(ifq);
 	}
 
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index f29edc22c91f..32ab95b2cb81 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -55,6 +55,8 @@ struct io_zcrx_ifq {
 	struct net_device		*netdev;
 	netdevice_tracker		netdev_tracker;
 	refcount_t			refs;
+	/* counts userspace facing users like io_uring */
+	refcount_t			user_refs;
 
 	/*
 	 * Page pool and net configuration lock, can be taken deeper in the
-- 
2.49.0


