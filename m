Return-Path: <netdev+bounces-191368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F15ABB344
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 04:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D657A9ACF
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 02:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238B41E1C3A;
	Mon, 19 May 2025 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsuqJtWr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61511DED63
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622125; cv=none; b=nlKT/h+gN1S8eDZhb1Kk3Bb3GRXxDdAemFZI8S0SAwiENJd/CvY1mpOsGB+EeKklUxj+Au8ZM4p4XotFdBGk4tGWvMPeGzGTCGXPtihJits9dbu+EnUI5NeyIHUVQun6uRGJ25TNEWrM+C/HiwJRqoKbrJkHMFXy/XTnaYdHLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622125; c=relaxed/simple;
	bh=fjMbYp1OUTPpUA+isQhdpqYICCd17AJcekK61Bn+4TY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f45qohf9juP04V/eJeeIcu1iGUavW5ilnFCd2RF8oozlyH4Jrwj54dxkUUPZzq4WDvShr4wo9ILc9cnRiDUXvO6bB4ZLJbx41KcMXgHIuZI87K3dslB9K4mOj16WcuHMuXdlacVfiTKbQSZlfK4CJfeIrCSB5IiAZWuQ/Oc0obo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hsuqJtWr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2371b50cabso4313719a12.0
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 19:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747622123; x=1748226923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SiIOWkaYu6Q5NvtHbuVewPLdOWvzkt5VSs00BXd1iZA=;
        b=hsuqJtWrT+r7rFyfp6q4p2B076jErBiTumcXh3MiCUuWfOuYO8x5iTG87RScJ8I69t
         wfqPlxOB2cDPd6Bkd1qmlXaC2VPzbw40DTGdVId9SUGGbiSkdyaG9XE7MdMUzfZB9hRY
         CCQyORXj1nX57kyW7dto4nEjLu8Tu3vUyixU+CH28gbqM/RPwk8MrdZKvDrrjUkwgVnG
         rO44nAzRTLK3zVohbdArjYyTJ7NNxL0zP+EX/BlgcF/CskcEXaFVXO0iy0dcCNjmdGdi
         yjIz3DGjHZXN8owG+n4y7Z+wFs35znaUnnNIV9v4UPnHsiaWd7I1jX+OiVMkYTsrs42c
         aGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747622123; x=1748226923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SiIOWkaYu6Q5NvtHbuVewPLdOWvzkt5VSs00BXd1iZA=;
        b=XOrXIAFc7WODLesDCtmAOlFTn7A0AyMxGKqA7L4l2KAAOc9KzNq2LR7L79SJNXE84k
         qNTIJ856zp32kf7rB0KdAioq0nsrv9M5QvVsBIIQlwtmDFsqRp7pCOwHnOJnbxEFt/yg
         RCl8DR7xHO0grKrD5P0wNKcy1diPQsAgGidbM17OwWFuD8KUWk8Kup6geNpPgnLg44b+
         g+m93lcD1c3HxEyTijmUTGR5kuQwGFtyU6cfu65drLnWPSTmg/3Vn0PCrbPK9dNGjWWK
         +kwMn+f4w33ncTV3lMU9gtFg1aPDkoLgZSFTHWUzoVOrKBUP7qRkZln+/aG7tAfadGsX
         VYCQ==
X-Gm-Message-State: AOJu0YwNgGr15eeDzPlYmdEP0GUym4LTH9AeSbrD0Jwv11muuGW9u8Mv
	zphstKUBbaRGn9GKiTUvp9mgEsOJTY3u76hDXia6wanhOp1kEbjv4pMYZQbFMuL8X5keOCuo/IY
	+Hc/x1fzkAYgy+PV/GknvpUNDf/darEXVUCA0dbO6tHoDCZdekGZ6n7v0M2jkAORSX3tgkaEQB1
	GwvMk62TZ4s5NtfF+4A8ClOFlE4bg0oEQrw2Q1GaJalymcoxYufGsltGmgWUisoas=
X-Google-Smtp-Source: AGHT+IHBrwI4b9TNUkLaMgynwA2HQL/MTtdwhOuI/X1LYMxFchY6tJBRsHHTzW22QGPcgrBPKF64HUiyRaUkCYyEgQ==
X-Received: from pgmp18.prod.google.com ([2002:a63:1e52:0:b0:b0b:301e:8e96])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3385:b0:1fa:9819:b064 with SMTP id adf61e73a8af0-2170cb407f7mr14894249637.18.1747622122885;
 Sun, 18 May 2025 19:35:22 -0700 (PDT)
Date: Mon, 19 May 2025 02:35:10 +0000
In-Reply-To: <20250519023517.4062941-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519023517.4062941-3-almasrymina@google.com>
Subject: [PATCH net-next v1 2/9] page_pool: fix ugly page_pool formatting
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

Minor cleanup; this line is badly formatted.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/core/page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 974f3eef2efa..4011eb305cee 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -867,8 +867,8 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 	if (!allow_direct)
 		allow_direct = page_pool_napi_local(pool);
 
-	netmem =
-		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
+	netmem = __page_pool_put_page(pool, netmem, dma_sync_size,
+				      allow_direct);
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
-- 
2.49.0.1101.gccaa498523-goog


