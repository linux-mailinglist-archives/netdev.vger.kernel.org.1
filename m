Return-Path: <netdev+bounces-164594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517EFA2E669
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E47188612A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCFA1C07C4;
	Mon, 10 Feb 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFlBih/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93C1BC064
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176090; cv=none; b=r/wmY59LY6w1c8IdnJDIVvcrqjG9h93/N6U7Ymr62392Z6+MuIS1oPudikSFRkYsDFWG/sF67XYmshbj4OXNxf6C+9xAI4iX0W6wUCPLmU80VvuwwIgM2yP3HnDoU/QtDx5PK1uP93EvR8jXFY6lGfORwRVn7HOsuvb39hruYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176090; c=relaxed/simple;
	bh=jhACoiKQ3aSvjs+pkiXHJUz6f4bjCQTk8gPucaIHiTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oz+TlbncI2UdCyf7G09UtLmR4QsgglDJwOdZxo9smTeEnrnQ3+wZ4R7D0K7PgauTaM1sJ+fzmVjW6f0JJ1LxxqcL2dpGMkB54IBrLOYbAoJz1dfJEDGuunUzu22X7a5HjzgQJkbIvz+E6CtoMGEYMWBYQ2OvSJUmouWsm7pJI/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UFlBih/R; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e4237b6cf0so54049356d6.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739176088; x=1739780888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nRFw9RpF6aMD8n6oflODQC64uRr8iptWae9j/dkj4Tk=;
        b=UFlBih/RQ0wWQWWBp09hDYJtXsk820+eDSFx5r3vGuLnCc2v9NCUnItYvVyX9zUTOu
         5RCzRkwRq+Ct7bM1+X+nlQJM9B2ZoDjMwXIvoZYPdELynnyJgtYIwgPlqPgJsue+KV+T
         NHWFQO4PGq3mqqsBnK91rLXX4wPKcHU+2/jG9uLSVhFhLKxlI49WxFn1PSzZjH22UFeZ
         9cxkAmkMZo67V7HDKGbhM4xAEgqwsblOKzx7aG/C5IWeNQcXV+6AIwI4fkqeNrNRPVy0
         8qqTi7pTpYt8SOAvGmOK5ToGU++fie/8ZOxgZAGlYiECmr/+zrj3RxqFGKG2F82NqZ48
         r1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739176088; x=1739780888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRFw9RpF6aMD8n6oflODQC64uRr8iptWae9j/dkj4Tk=;
        b=GgI5G5YpHv3CvhM+L3Pr7opMMkx9DBb3D/fMwsh3DvUL+Rqf46a+tUA3+zhksJMI3V
         ZYaqDeWGMYlJWzLcWyb1koLv2Wnc1LkpXetn9j7eAPiMdQ75XWSoHn8FwJfar9LdquMv
         W0ZnGi1y7l+91XV/2Xfzf+3l1Ja1mJa55/I2S2a2MY0CxZq41wPJWcXhDjTOmNfMDrDc
         gJ0dll7AZhJ2tr+7jTM9dJJ4icCUy1j5Nfg8dgN61oNQ82ordTnuGJF/hPXP+wJzAhto
         hEOfsHPFO5F59Zwm/VLKzYOkU99gTJYBwvnIJEn+IrOJi7r01PNY1hD0KsU2iEQjK4BW
         Actw==
X-Gm-Message-State: AOJu0YwGV1zS8W45QSupxboTz/VQ/CmqDqjdUodllgwJDqrsdj6AWDvh
	sOJk+o0BzusbJL7Q4KWu4+NKYLtPwWwNpOKSokpTc9QUAsfwLC4XV48WKmLTfFo7fPGHgG1opM5
	heKmTx8G1qQ==
X-Google-Smtp-Source: AGHT+IHYnObeT6JOXAT55/9IyPa3I3Gn2ywwTnFn6i2+rK2PLxozBBHW7l3CsuH43dtgBZFrdDthpoi6zpXjbg==
X-Received: from qtbbq25.prod.google.com ([2002:a05:622a:1c19:b0:471:982f:82fb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:986:b0:467:5144:8374 with SMTP id d75a77b69052e-47167a457afmr190482681cf.25.1739176088070;
 Mon, 10 Feb 2025 00:28:08 -0800 (PST)
Date: Mon, 10 Feb 2025 08:28:02 +0000
In-Reply-To: <20250210082805.465241-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210082805.465241-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210082805.465241-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We have many EXPORT_SYMBOL(x) in networking tree because IPv6
can be built as a module.

CONFIG_IPV6=y is becoming the norm.

Define a EXPORT_IPV6_MOD(x) which only exports x
for modular IPv6.

Same principle applies to EXPORT_IPV6_MOD_GPL()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/ip.h b/include/net/ip.h
index 9f5e33e371fcdd8ea88c54584b8d4b6c50e7d0c9..1e40c5ac53a74e1c20157709e49edf2271e44fe3 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -666,6 +666,14 @@ static inline void ip_ipgre_mc_map(__be32 naddr, const unsigned char *broadcast,
 		memcpy(buf, &naddr, sizeof(naddr));
 }
 
+#if IS_MODULE(CONFIG_IPV6)
+#define EXPORT_IPV6_MOD(X) EXPORT_SYMBOL(X)
+#define EXPORT_IPV6_MOD_GPL(X) EXPORT_SYMBOL_GPL(X)
+#else
+#define EXPORT_IPV6_MOD(X)
+#define EXPORT_IPV6_MOD_GPL(X)
+#endif
+
 #if IS_ENABLED(CONFIG_IPV6)
 #include <linux/ipv6.h>
 #endif
-- 
2.48.1.502.g6dc24dfdaf-goog


