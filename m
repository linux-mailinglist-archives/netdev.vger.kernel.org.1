Return-Path: <netdev+bounces-123550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0803D9654F3
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084FC1C228D3
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FC3136337;
	Fri, 30 Aug 2024 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok+XC3Pp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3241F13632B;
	Fri, 30 Aug 2024 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983348; cv=none; b=nh8gJoVDslX3TXLtmjNmm5JCx3vRbm8XVJEPUAPXvR32+9kQrsPpMhyp5c0rh6/tP00pWe0+KfBXj6DzwwNTJnSA4jyRx/FDLQrA5EOrc1O6b39HEOJ7D2x7rcKCWjhqzK2J6qpVZ1hEOApTNHvfy3z8tMb/8BIVUjwhLpWIA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983348; c=relaxed/simple;
	bh=OWM1Yfv0veEuuMTI6s3R2O/gIarAsPk1rPh9uwCGfKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vncq1mlJimSiJkMIS0GBY//2UHJJQ+pVXQhYm3xlFvBp9f9pqxUQvn238RUZ0AUafejSTp+d4Ji1unql0uegrUSJkU1kze+qbuLzUdfFd7r29Dz1zVXGwdbBAADAG4H8lytb0k5brAFY60RaqFAXUSn1eIQfEO0kw0YKO5re7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok+XC3Pp; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-715cc93694fso1195352b3a.2;
        Thu, 29 Aug 2024 19:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983346; x=1725588146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S15bsrAtKng24cEfr8xI1U+gVP6EbG/MdhFsVmoJxV8=;
        b=Ok+XC3PpKMr6kvBc8Vf+npPmyto+BzSlVg5Oae626MYNhsRAW+7baQ0SBoB4JLQow0
         F3lVvTJTlEEQqoQ08FOyOdjgQAppFjizr6Ogqu/aannfofgxoDYT5VdhUYk6wZDoLti3
         oEfD94IawAc4vwlUoffp84sMkhwTwoAjO1WccYwNvSHDtxffjXuzMjAqRuTpQXFngzx3
         QlEniDfzz1dkcSqOmzc17AwQh35RJ7+oGXplkHTrAQbvDC5DKb1U0ac9SkZhm7ehpFGF
         +MWo+d38Klyoxzq5f3Senjf20lA8uuIs7hMYxdb5ccoc3TRnhki7acmKVtimpUzRWpnF
         bGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983346; x=1725588146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S15bsrAtKng24cEfr8xI1U+gVP6EbG/MdhFsVmoJxV8=;
        b=EwQEwQTaP3VlloNsYD7mAPsgjvnVY+MnpwUyyJvizkjr9S9jBkcz+E8hKCxJJ6WXgb
         j4Z2T+9XQBlf2l4KPMKNuADUgIbo1X8aJbASpxJptPEHdAIP5MUscKKtOB9Y67hYO4tq
         Fk27EsE8RYiX2X+OW6rjPITMtPx7c6snMMKpPJTpZG7jD1Zpa5h2oPzD4DgyfQFe1OQq
         0VIJJZ+fk+ipLA4XnVGuwRZSh0tZ6TW2N5FuYtkRUXqKybyRv804hOPG+FdTvfNhtzUk
         /MJFdk15CdCRoTJolR48J5CXmb1RY5pvNoeSPhDZjUC8tZwyMTywExZ4B1jBXD46bwNk
         +uHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe9/URXpAfbxaUSUg5E9engsCz6ed7628W0XraWyzo1xz0xbNhIBWUd4sPhPV/V8GuIhwx9MSZ@vger.kernel.org, AJvYcCVqaEAgSBbPAxMdqFAw8yXV4OvXsUcpRN7Yvh7t8G7NIq2ZyqQBbRvjVjyYPZLU4IGmgTwb5x+nkY0b73s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1mw/U4qgtNagLya0VMVjx2qF4D/kgdoZrjXeA91iEjbVOQX3
	kBbeQJV9jz7rhQTb/CEvxTAwGMumULUSBDp8a/6sGKj7EaGWV373
X-Google-Smtp-Source: AGHT+IFpbCZIiwTD17FymKoKtocUjHWfH/6+9Drmx4DPOrX3Yzq29x88AvQykQz3hgBSZuiButrarA==
X-Received: by 2002:a05:6a21:4a4a:b0:1c4:c3a1:efbc with SMTP id adf61e73a8af0-1cce10b17a1mr3685420637.39.1724983346149;
        Thu, 29 Aug 2024 19:02:26 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:02:25 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 02/12] net: skb: add pskb_network_may_pull_reason() helper
Date: Fri, 30 Aug 2024 09:59:51 +0800
Message-Id: <20240830020001.79377-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function pskb_network_may_pull_reason() and make
pskb_network_may_pull() a simple inline call to it. The drop reasons of
it just come from pskb_may_pull_reason.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/skbuff.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cf8f6ce06742..fe6f97b550fc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3114,9 +3114,15 @@ static inline int skb_inner_network_offset(const struct sk_buff *skb)
 	return skb_inner_network_header(skb) - skb->data;
 }
 
+static inline enum skb_drop_reason
+pskb_network_may_pull_reason(struct sk_buff *skb, unsigned int len)
+{
+	return pskb_may_pull_reason(skb, skb_network_offset(skb) + len);
+}
+
 static inline int pskb_network_may_pull(struct sk_buff *skb, unsigned int len)
 {
-	return pskb_may_pull(skb, skb_network_offset(skb) + len);
+	return pskb_network_may_pull_reason(skb, len) == SKB_NOT_DROPPED_YET;
 }
 
 /*
-- 
2.39.2


