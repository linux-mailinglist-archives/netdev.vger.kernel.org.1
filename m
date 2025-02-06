Return-Path: <netdev+bounces-163651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E51A2B25E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5496188B9DF
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A11AB50D;
	Thu,  6 Feb 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX7LqGOI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1E31AA1C9
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870533; cv=none; b=n9KvZjKqPeVGLz0I1/3AxARdLMO35/7LyCgeL6Zb5E8Wbw26H1H8PPdBjgDRXGdzA8Wl0C78WDN+6gJ3KL47Vv4KgOejy7iFSbloCN4lpGIvGMC0TJ+q03o9rgy4pQDJ6rTnmQsavyBIVQmjVery4DamLg0W5rQf+AxUAoAGVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870533; c=relaxed/simple;
	bh=dEiafCPXwSJw2hpR+G4l/4Ri6UiKr2phshgRUbM70lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzSiCit77v5gXFgrz6nQCrSvr7QgJQgHlGMDJ6cZFridgXipR0Rp7tCJaphtMnVrv8CaJv43jgP+Z18fz7VkY+bFDQkCurs5ciLnBN4RpfX+SKhlVTFGhC2+aMe8McYPdE/0fHfrovy2mjjd9heX3gaFoCpsHYBZmH00esyRl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX7LqGOI; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467a63f5d1cso11456911cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 11:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738870531; x=1739475331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwE+P57qMwDKQ7jYnp6u+xaB8jdbcIZvlmw2uIYpCFI=;
        b=ZX7LqGOIVnqg303MQ8YiQ/l0wWv42HeiSEyaSAx/bYVKO9jbzLkdebBN/YcHmEE/XZ
         CkQO704c27JorjpRWQ1oF7aDaD6rolLvy/Vr+MLvD8n2zciW3BLVBC7H5KGb/zR9iDJt
         uKE2jBBKCEBuWI2ZLZa4Tjd7VsyE24ut5ZoDt9A0/zu8vR4nsX3XYyF7i2bReezj2EFY
         Tsbn53V2Bv4ExPFRD6ZsyRfLKNUmeP0qBCK98LbyQu/rSsRf3t3q66dC8VcoHkRZ3HRB
         fWEdE2KsRe1nXeEOFEQxB4IIS2dXUQIoFCeQxdhahJeCAETKkQxYsK/5TgbxC/bKy0Eg
         xTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738870531; x=1739475331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwE+P57qMwDKQ7jYnp6u+xaB8jdbcIZvlmw2uIYpCFI=;
        b=DRplmecd1dOORsvP2aQ6qBtAUybcJ+U02qZw9WUdXOXzcdMe5nLWPk4X4iwD7gPlYq
         W2STLuQaAe5htMkXy1OrPhw+Zn75y0cLQ/qXAQPZq5g7MbZD7J34W5c9La+1TJcXlRqa
         2tIGsL7J+wfEde2j0KaYPsKBhmA787eH9UmX4wOg+xTjjgzrB44OeOiDXZzgb9+ZovTe
         zhnXAQRlRCcSsoCB3o9cGfG7dP4zrHMQldjOnpG0XnLArbVCQzFWosG6XurRLXtRSgko
         CBMNRY6YwRRfoK0NuM8vo6e/Z3l9czKnnCHerM+UBCFZbt1aXO5q2caaeQnxWgXp8FpG
         qd+Q==
X-Gm-Message-State: AOJu0YxzwDFij/1PosK+gDhdkJ+00A94C8Aq5H74yGz0Zuxda/Gzf4+5
	uTdXTlw5qj3al08uRL7eWyjY5dw9+ukZgaIXz2acFsBqLMemuOS4kui2Mg==
X-Gm-Gg: ASbGncuiHEl3bjfd6Co9rujXwKAvfVIZkeSksVmjVd6bgevTWgw88GUcbM52tt9SkwG
	E6giGsEt3vGy0Ot4J+VxSM7ZYkZvmRBt907KRZB9N8arfOt5/JO2LWUq81r48GdDgPftMZjAL7X
	2nEpHeZsf5LyjgyxWvXbsg0LbNtqW1Mtk13ER8bOD5KKOr6oauvD3pcRuLZvEPaTGHAfz+r5F5n
	nZwDHmlPsHpOL8Cyn3C8WzPhukrLEbDxBCXQlhWXHE7+iw9wjy16YYCE8HHOzZhikgS2jHljiej
	vK5AyJujPZYtzWihP9OmSy7jcHtyocHY9v7tajf76uQv+0VIm7l45IiXX4TBYMq1niUpT3co0Cn
	+i+NRhqvf1A==
X-Google-Smtp-Source: AGHT+IF2Kdtm6TQRYUGdFJqix/o+8tep8q7n89xTivZbaWkewmrVAF5DZeY89pCIKJz44yy/79XTKw==
X-Received: by 2002:a05:622a:256:b0:467:7109:c783 with SMTP id d75a77b69052e-4716798aeedmr7922301cf.3.1738870530663;
        Thu, 06 Feb 2025 11:35:30 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492accc2sm8349301cf.30.2025.02.06.11.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:35:30 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 5/7] icmp: reflect tos through ip cookie rather than updating inet_sk
Date: Thu,  6 Feb 2025 14:34:52 -0500
Message-ID: <20250206193521.2285488-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
References: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Do not modify socket fields if it can be avoided.

The current code predates the introduction of ip cookies in commit
aa6615814533 ("ipv4: processing ancillary IP_TOS or IP_TTL"). Now that
cookies exist and support tos, update that field directly.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Tested with ping -Q 32 127.0.0.1 and tcpdump

The existing logic works because inet->tos is read if ipc.tos (and
with that cork->tos) is left unitialized:

  iph->tos = (cork->tos != -1) ? cork->tos : READ_ONCE(inet->tos);
---
 net/ipv4/icmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 094084b61bff..9c5e052a7802 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -429,7 +429,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	icmp_param->data.icmph.checksum = 0;
 
 	ipcm_init(&ipc);
-	inet->tos = ip_hdr(skb)->tos;
+	ipc.tos = ip_hdr(skb)->tos;
 	ipc.sockc.mark = mark;
 	daddr = ipc.addr = ip_hdr(skb)->saddr;
 	saddr = fib_compute_spec_dst(skb);
@@ -735,8 +735,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	icmp_param.data.icmph.checksum	 = 0;
 	icmp_param.skb	  = skb_in;
 	icmp_param.offset = skb_network_offset(skb_in);
-	inet_sk(sk)->tos = tos;
 	ipcm_init(&ipc);
+	ipc.tos = tos;
 	ipc.addr = iph->saddr;
 	ipc.opt = &icmp_param.replyopts.opt;
 	ipc.sockc.mark = mark;
-- 
2.48.1.502.g6dc24dfdaf-goog


