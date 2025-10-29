Return-Path: <netdev+bounces-234099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 071AAC1C759
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44357188304A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B35D3546F7;
	Wed, 29 Oct 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvNCdqQH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4B351FD6
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759235; cv=none; b=HVvVjQ0p0kN90M/Rjq6xVGtxC/9YshWSxD39TFVCDnmp+s1uPPJUCOvyDzXtjborxhd3uwumry9zsm/5no6GmW2ABRqXhH6VW104xi1FbWfbR5weT2P8O17vXRy9BdrlTylIWy0iFFqFyRx2EdBS+P5F1V+inG0FB+BdDsnl1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759235; c=relaxed/simple;
	bh=v3PAc6bxUIbxN3K5N3FiozuktHcYx73jdbJU5Uz8rGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UYhQY5U1S0PyPGC4nPVCRBtbOOiaQA81OcBnIltdXr0eFLVUGLOwTZu5YEOKFMoNC/1HkDgSgCcenLvyXzQ1jU0LFQ4qwBZOL/Y1mCSd/fX8peSngRKt9eFMv1RxwjJl5fTOIMyP7aQB3x4obh/wCR6TsVMdFkMqhw6jv/dRkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvNCdqQH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2697410e7f9so1414325ad.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759233; x=1762364033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmJP5wJH4wv+bpMD33wfqwL3XA2NGGPe4o9uDQIRtAg=;
        b=JvNCdqQHrIMhmBPwps8wxDN+770C01fa8ZCyGB4CvjFLOjKBYeZkc575pl7bcDPRDw
         YqKbxuyd2yTE0pF9Lnugt78HFu0WKED7nnXeacPINwcTu8kaBl0E2gLItO7/xqsFH1zT
         b75U1sYAbtXVcqpXzKKi+4yPerL3dy4VV1IQDz/nparakrN+iAxCZeTl02+GFo3F4BGZ
         OVMjrG16NsP6aDtdlBi5dg83BseYUUXLdISZ22IFz1QRfz1Qxn84TbTg2WAUiSDLUhhu
         lR75Zfo6FlXheRTkZ4qe7d4AGDzSavUqVve1n8tRHUeQ0GsMFwsV9wHuA2hf7GZGC1Zv
         1CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759233; x=1762364033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmJP5wJH4wv+bpMD33wfqwL3XA2NGGPe4o9uDQIRtAg=;
        b=ZWi1zQq6JXlpBixSbUHhFsVSNtYfB2MEYta/UpMeoPLbREYVZDW9LNRDv7j8tlVXm+
         dXLV0N/X9QLqflSjgxnYAc5oLtFE2g2Ba4eC74Trwa6j8VsP7hB+iFgBu8Vn/gYUkEBA
         gjtN3WUBmLF82fi+DnbfX4UCLswmGs6RcBBgYbRFdeJSyJGxncLGQW+TifFaopDq/tbx
         AhKMPDDVNLfNKaerZYfxFrgkPVnilt3xCu1fmW1SDRMHfaVNu/sAAUk9mRu0h4XCncB9
         Eq+2vFFm4KCY/4xP+BkJJ95GovOYmBH3iZV6+Qn5AZsuu65gGP1t3TS26LlyVsDHT2wf
         djvw==
X-Forwarded-Encrypted: i=1; AJvYcCU/r8X41T4vIGe8fCLCzkva0QKlH32OLgzgjSOQ8hjEHOemXB2j2YNfjhTGHvgZaUXzPBSewz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwltMAKrZSBqOdXH3/m1p8iIwdgZZbTetW2PwBXL7ebICMTfrjR
	rERaOnTAyd/j3aKwqXhZU6z+fPlFBpxmCsvNY5YfTXF8bFy67HtvrgwZQM2884tth5mZhtZSODp
	IISX3ew==
X-Google-Smtp-Source: AGHT+IGmGM7ODbqe8WOo4C9VtFGshQ7QpUgnUTUwJhi+tgi+8ZKxEY2pFa7rz0XQ6W2TrDpHOM2d78bdiew=
X-Received: from plpg9.prod.google.com ([2002:a17:902:9349:b0:290:c5e6:74b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c4:b0:294:db65:4de7
 with SMTP id d9443c01a7336-294ee391dcamr1230715ad.27.1761759233330; Wed, 29
 Oct 2025 10:33:53 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:32:56 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 04/13] ipv6: Add in6_dev_rcu().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

rcu_dereference_rtnl() does not clearly tell whether the caller
is under RCU or RTNL.

Let's add in6_dev_rcu() to make it easy to remove __in6_dev_get()
in the future.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/addrconf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 9e5e95988b9e..78e8b877fb25 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -347,6 +347,11 @@ static inline struct inet6_dev *__in6_dev_get(const struct net_device *dev)
 	return rcu_dereference_rtnl(dev->ip6_ptr);
 }
 
+static inline struct inet6_dev *in6_dev_rcu(const struct net_device *dev)
+{
+	return rcu_dereference(dev->ip6_ptr);
+}
+
 static inline struct inet6_dev *__in6_dev_get_rtnl_net(const struct net_device *dev)
 {
 	return rtnl_net_dereference(dev_net(dev), dev->ip6_ptr);
-- 
2.51.1.851.g4ebd6896fd-goog


