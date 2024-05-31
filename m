Return-Path: <netdev+bounces-99746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C61748D62FC
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB61E1C25C05
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41909158D83;
	Fri, 31 May 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+uxIFp4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8785158DDC
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162013; cv=none; b=kxQWDDgneSLLvMrbRQqKOXGP4SSshnojnnJpHolsNr7jEE1/xB33aipqaOHILAjf9UYzm532bjUPoDvkOKXMFVrNCw4OYKz9ft6/UYVvrw27ECUp/yNmx64qT7s6awajJuNSeir0lstUkzjssl0MuZbi6NTWCgEqyW6X3GZni6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162013; c=relaxed/simple;
	bh=S7Ez0x/plhpNBOQHackP9m2qwmb/z6nZyGyoGelixuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=us+yhX7HV2JlhGpGWMKodYjZVOPn6Bl/sDw54eqJH+eaXbC15Fsl2L7HM2fAB/nz9pdkcEVWXJ7/t9BMzduDnxeOeN/LzDmA1BV4emEekZEp0aLojW7gqRdRlVv0qQcdn5lQsv4waXx9kIrLpU/jf+NxodBLxPkRxqBjQ5vVoeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+uxIFp4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa7464759cso1038171276.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717162011; x=1717766811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6h/URa9gK6v6WpLVrHOMrZgQ0nFMWE+/WiPoMgIwXU=;
        b=B+uxIFp4579ADy9EszHbf61CnSC7K+Cr22fKyGNoRkZm8Dkvv3xmGDyC738j9cwXm0
         +qCuwvHfe/nZQ6sFJRud3YJBNdwzEOOV5GbyRIZMvNVj0Rs4MSIqrDpengRqcHR2IoD+
         2fUSrnK5Uva/tu5JAuV/u+jkUNgqhY2RZRLFgSBG1/vHJf/C7T7TQ5chJC22yigtyqps
         bEtoEKq7upDjei792zrP4cHl3uwFQTdSKevTytMI5VL0E5OkQsr/SQ4DDdUSkPwVX3f2
         BCrRkMswlEEqFWRiypipHtWvotVJOZFDSTEzKs+LvWlkZYC3HiG9UikmqkYCfSxSbfes
         XUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162011; x=1717766811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6h/URa9gK6v6WpLVrHOMrZgQ0nFMWE+/WiPoMgIwXU=;
        b=rWdItmgGfcNgubZuotQn/OkntbHcmH6A7ECuYJXD7dLokhDxjzhlNClJWMmWHoboTY
         RLieCpLSrtftjw/L+4JiKSEsSlU5CaAdTbPbprxL9RHG4KUiqj/Qpcq3iQTNAQmj9QoV
         wHyYmUJWgyicNWhCu90Zei8XCYbPokznakH0tS0z5S2c/MUCwtZKLj0aNcdhhsgJ81Yb
         PNT4ZzcJgmKQ5mARNrGOfgDLnpbGaxo8IMB7M2nvViNS1yY2qn39e6hkHf6SN88Bc7fd
         HSPqTT3xjfvENbtqVeTyh/ct3LVUCibGoaBjRFwtnyJisN3JPLV7/ib1KnjdayVkpTHx
         /arw==
X-Gm-Message-State: AOJu0YxlXLHiD3oTTTuPYkXuS/+Dhk3eb8AuPJnuzuMidWUZUoV2Nys2
	D10IHy2TiPzOaFcwtjP/G2yxQWNfC8bUieQ5XnqhYxuPSFjOqBkcseMX+v2sIiCPsrFlgIoPDCu
	BDDQASAQZqg==
X-Google-Smtp-Source: AGHT+IFTNisGR56JV++aSTSk+8T6k4GBzTke99E5yMKE9thDdLSZrvpI/Ipy1Dfndt+zJP5fs7G6rtI7GVi/Pw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b85:b0:df4:920f:3192 with SMTP
 id 3f1490d57ef6-dfa73da3c27mr139462276.8.1717162010983; Fri, 31 May 2024
 06:26:50 -0700 (PDT)
Date: Fri, 31 May 2024 13:26:36 +0000
In-Reply-To: <20240531132636.2637995-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240531132636.2637995-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531132636.2637995-6-edumazet@google.com>
Subject: [PATCH net 5/5] net: dst_cache: add two DEBUG_NET warnings
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After fixing four different bugs involving dst_cache
users, it might be worth adding a check about BH being
blocked by dst_cache callers.

DEBUG_NET_WARN_ON_ONCE(!in_softirq());

It is not fatal, if we missed valid case where no
BH deadlock is to be feared, we might change this.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dst_cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 6a0482e676d379f1f9bffdda51c7535243b3ec38..70c634b9e7b02300188582a1634d5977838db132 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -27,6 +27,7 @@ struct dst_cache_pcpu {
 static void dst_cache_per_cpu_dst_set(struct dst_cache_pcpu *dst_cache,
 				      struct dst_entry *dst, u32 cookie)
 {
+	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
 	dst_release(dst_cache->dst);
 	if (dst)
 		dst_hold(dst);
@@ -40,6 +41,7 @@ static struct dst_entry *dst_cache_per_cpu_get(struct dst_cache *dst_cache,
 {
 	struct dst_entry *dst;
 
+	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
 	dst = idst->dst;
 	if (!dst)
 		goto fail;
-- 
2.45.1.288.g0e0cd299f1-goog


