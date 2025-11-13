Return-Path: <netdev+bounces-238284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DBFC56FEB
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 930794EB3EF
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729EE33557B;
	Thu, 13 Nov 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6oc9gFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD27337680
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030789; cv=none; b=BetXWiX77hs1Q50rSwou5wqDtS2UAHsgieXSVvF5s6pwMJQnD8yGGdHtee0mt+HEtagSZkRo/mX30cYDgOgX5WZkbmQVyj8MlxhH2asZCMTsjRfXoVtpqG/G3UdJpNzfsf45gJTRtIMSlotc83x8kvMlDb7f50Zea7NsXhy9vkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030789; c=relaxed/simple;
	bh=MB459NgRBJTpj8ZVa00h50/fi42AOTxG1P5e1Mzw0ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6TF9uFnu4QnnoMrLPnJRPZ+bjBk1/oqi3RpW12BKwOKnBgM2V2nki4brVuibHyDzbwi2kY6QlZPxfW2Pj6LzJrGs73S5ZshTeD1PTptWOX7nMB1kDN38kxfoZN4QKpgg8jDEa638bjHWq6yBU7nEWHn8xAIXwtkhdlhkPE1p0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6oc9gFF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so600822f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030786; x=1763635586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5miRC+rORpYyD9zhfM8G6TTIhPXZRB5wvOWpVBzGlM=;
        b=f6oc9gFFVGSDxrHfYZxKP6Iu0xNNUFIvQmcsmH4YTFE5mVQa0G9mCtIJJAzR4XLoNc
         UCUZWLWxTtO3JCjnUmj1Ng7fguyx1LOosnUV2bqrpG1YE82vkdFAxWu8VJP2bbKIFp7w
         RFqS5rqG7A0Ts3CsAh2OHtkAV3FrJMUsajovt1Vvd7qbT8n9n58mf1tydui8j50N4pYb
         zZly7wD3jpQn8C47qRGKTQAXEpY2335h1b2ZyfiJzr9UCHQ2ohKdPxc0Lpn8tnzmN7Ob
         Xf2Sd05w4Q2TA73oo0G1L2fpFRz5rtb3/IWhEE5DtUP0Q7YxcPRqqMTQZQtjyTRwQwVo
         5kMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030786; x=1763635586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e5miRC+rORpYyD9zhfM8G6TTIhPXZRB5wvOWpVBzGlM=;
        b=md+RSiI7EfpVdEU0uH+TrBdUiBjH88i3l1zVCu0D0VupbGUyMNDVV1KduKCiaNVVHK
         RTPP7ia7HimOxdXWbr1QwguIOIGt0okFFguN+bQspptlkMSIc5qQwTakFrNbzXq+4xNx
         SuPkX7l1PWnFm3YX+PBZfTGhA4SBPJeRqZytuovwYE2APQWbOtaYIRlgBp3Lg/S+PZAU
         y/3tBZpp9twUd8PASiPv2uDh5Mjvcvk0c2g0xeLLpWzVlYhOArsTz8d4oTu5i3QGE2Wj
         z3xbTdeuFxDoRmvtbb4bjUftO+ptHNmqRJrVofxJsPlR8bhJvhv17T7dLPzLMz2xMB9b
         wEhg==
X-Forwarded-Encrypted: i=1; AJvYcCXuS+gEVWleAn9Rq7UIGAONyp2WDe1mI4tw6dKlB0j2CLQUyVOqFZc+gNWTZV/TUHson2/48E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOF85Ij3BnNHT3XpNQStjmpcMrP8qfcLrElpLTWJXDOKjK5HS3
	7Xinhpsl8Ce3A6d6HgMf0muu0Zoed9iRnn13L+RK6iFiv1aTA8Kvb7ol
X-Gm-Gg: ASbGncufQEnoljPw8d6kyErxmy+d8vTeiqZq3rd8AI0ERgbrOK8wwPpCrLfWKH27JZ8
	A4zFPh9VCLkFIHmOv1mLbTqeeyY/1nq7NyfgkUld/ieyEHD9BPRWqPM8enHHYtGdXrgoouz8T3i
	yAhsVdlBR35tyDxtrUqP9Bfcr//hP/uzSPrxYVUNl9R0IE34zrmw7dkcbkFG9HG/a8V5xz5pX3N
	aTfp9biT01XUks09C7DAyilnaYPqZU5aSAX8rAtzu2rjDpFFXb+sXMC/hajHi4hA1Vc7ve6ZFi5
	vGLfIxCgmgYJ9sPIxMvfdcOU0ydSaOJSxFcnK1SUYmLP3seCPbX7GsSfC616QSUa5tI1OQnNR2q
	nqfIYBg+4jSsikNng/WL1sHfNgPeFvwrc3nCCwpYsMzWuIw3J3qdVwLP7EYE=
X-Google-Smtp-Source: AGHT+IElO6NSXxpixZ4zTY/0RhwvJ17n4EkEfbJdPC54BjOF0k46b0LyQbn6ImZ7vD/9+bUocUwBMg==
X-Received: by 2002:a5d:588a:0:b0:42b:4177:7135 with SMTP id ffacd0b85a97d-42b4bdaa6e4mr5841911f8f.41.1763030786018;
        Thu, 13 Nov 2025 02:46:26 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm3135210f8f.10.2025.11.13.02.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:46:23 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 01/10] io_uring/zcrx: convert to use netmem_desc
Date: Thu, 13 Nov 2025 10:46:09 +0000
Message-ID: <023f56bc9528ce17d28f03f0bc25d60dea074b15.1763029704.git.asml.silence@gmail.com>
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

Convert zcrx to struct netmem_desc, and use struct net_iov::desc to
access its fields instead of struct net_iov inner union alises.
zcrx only directly reads niov->pp, so with this patch it doesn't depend
on the union anymore.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index c57ab332acbd..635ee4eb5d8d 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -696,12 +696,12 @@ static void io_zcrx_return_niov(struct net_iov *niov)
 {
 	netmem_ref netmem = net_iov_to_netmem(niov);
 
-	if (!niov->pp) {
+	if (!niov->desc.pp) {
 		/* copy fallback allocated niovs */
 		io_zcrx_return_niov_freelist(niov);
 		return;
 	}
-	page_pool_put_unrefed_netmem(niov->pp, netmem, -1, false);
+	page_pool_put_unrefed_netmem(niov->desc.pp, netmem, -1, false);
 }
 
 static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
@@ -815,7 +815,7 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 		if (!page_pool_unref_and_test(netmem))
 			continue;
 
-		if (unlikely(niov->pp != pp)) {
+		if (unlikely(niov->desc.pp != pp)) {
 			io_zcrx_return_niov(niov);
 			continue;
 		}
@@ -1082,13 +1082,15 @@ static int io_zcrx_recv_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			     const skb_frag_t *frag, int off, int len)
 {
 	struct net_iov *niov;
+	struct page_pool *pp;
 
 	if (unlikely(!skb_frag_is_net_iov(frag)))
 		return io_zcrx_copy_frag(req, ifq, frag, off, len);
 
 	niov = netmem_to_net_iov(frag->netmem);
-	if (!niov->pp || niov->pp->mp_ops != &io_uring_pp_zc_ops ||
-	    io_pp_to_ifq(niov->pp) != ifq)
+	pp = niov->desc.pp;
+
+	if (!pp || pp->mp_ops != &io_uring_pp_zc_ops || io_pp_to_ifq(pp) != ifq)
 		return -EFAULT;
 
 	if (!io_zcrx_queue_cqe(req, niov, ifq, off + skb_frag_off(frag), len))
-- 
2.49.0


