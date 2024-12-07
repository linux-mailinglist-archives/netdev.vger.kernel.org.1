Return-Path: <netdev+bounces-149901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6989E80FF
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E0A281678
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6647C14E2CD;
	Sat,  7 Dec 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acBTLjIh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103114D29B
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733588583; cv=none; b=loZx1PaxEi3mXlHsUOq8sIInFHhAxB/t9qt2ghHvStv7iyew6dpfe0oIZ3AQiEggvTDWEuIWifWYEwUwBOZtwVNCw7rh3M58L4iuoN31g8sF4ZVnn5MRpBRtkftjQVmGl+s7s2lM+E1Fm9nVsPyToHt5fz9vpq0dPiTaV+r3+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733588583; c=relaxed/simple;
	bh=LWVBJx/mHg8fZ1laWBOVoZRo452ecAG52axAib24ye4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XE4GYG3RSEJsx3AvjGSFk4jYVd1MTtP1h9wKlxGg06yBSvBU+6Cla67YRZWFhpsouBOgfKRokuhG+BqV4mcCjd5PJGsBYM+czmYHbxxmYGmX2jNDqCrQyaRtUwdmHpB+FKSIPtnWYESkCEcE4lQJK8U2vRu0OoumycMJIpUiwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=acBTLjIh; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-46752894cb6so7257991cf.1
        for <netdev@vger.kernel.org>; Sat, 07 Dec 2024 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733588581; x=1734193381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/x1yWtZsJ79zjjGA9KqHWwyoR7sBywej0TPCqjBT9o=;
        b=acBTLjIhVylqyZXiIsKxpXTUugrU8AGbdfBu0XsEVPnsT+4h5yJLQ/8BkwjFtEeksT
         a48MstAwdHlyM9xKegr5hhKGVkXEo8fW4i4kMRF6aGJjp0qeFBeY/qfXw0iI/WrC+FWY
         lXzOFA4lE48Hpgtg8j8IVWZVFFdwQ+lxkLmIOby1WOI+2BTTz7DekmXDkKmkozU5Lxn8
         fgTCAiY0c65PFsY9wJV03B1tJVt3WEUV+C/DwQUjA3nIoOIARf/h2qwFN1WOkVPbj7tH
         LjwOjcQHZWqbfQn27+SKvJEDsaQSRNltu52HUiiczZiCLB65zP16XFPa3igDyvlAK3Jo
         88nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733588581; x=1734193381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/x1yWtZsJ79zjjGA9KqHWwyoR7sBywej0TPCqjBT9o=;
        b=CwZQ3s2Z6znKggzm8uuvTFIG5kGkT9U3/nAGgwBuFp+Bo6Geweh/s+tN4zEPRg+i6L
         +Wgyp1NN8L4w/ILuR/c+0aWxJzfXRHF46uHkWQYUsWq6IM5H6g1n6pDksALnA+ghMLPQ
         cmGrTViqp/k64cBrb5SI1nPtnKBSjCABOXaVoI5qRfoI3QqaNLlhnSP+sr8hyM4Vjv5h
         PuorKf/ANBoc/xY0krSyUYFsekdN7oqSsRGiGwIoUTXkU6oeGoTih3hrDSqmr+ylXjs4
         vn7w4VlvLO0R9/IqJRYvRAHoVBtOvLjMxgYnJDo4LWMdQTcozj++nx/xrDaAVwE6apWY
         VCDQ==
X-Gm-Message-State: AOJu0YyYaTxY0dNLmMUEtQzS1BSaQx8bHXY1RJCJH1M1LJCEKGzUHPWt
	QJWQ8N3hweZcyUVg//OVZXL2ZzIx/OwUEHvk4efQc9CLMH7bXdMF/lhnEgy/FNE4gWIw1vbc66M
	y+VkJ+h244A==
X-Google-Smtp-Source: AGHT+IGPFXO99oeW/46E/PjopjTUg28FlFK/IZpvFaKVndaMdib/6t2Ahpkwcql+uyFkY7aBjCgd/fe5vm6spg==
X-Received: from qtbcp6.prod.google.com ([2002:a05:622a:4206:b0:462:bcd3:319d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2294:b0:460:a928:696f with SMTP id d75a77b69052e-46734cfdd5amr117105931cf.29.1733588581031;
 Sat, 07 Dec 2024 08:23:01 -0800 (PST)
Date: Sat,  7 Dec 2024 16:22:48 +0000
In-Reply-To: <20241207162248.18536-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241207162248.18536-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207162248.18536-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] rtnetlink: remove pad field in ndo_fdb_dump_context
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Roopa Prabhu <roopa@nvidia.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

I chose to remove this field in a separate patch to ease
potential bisection, in case one ndo_fdb_dump() is still
using the old way (cb->args[2] instead of ctx->fdb_idx)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/rtnetlink.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 2b17d7eebd92342e472b9eb3b2ade84bc8ae2e94..af668b79eb757c86970b2455d9d820c902699a13 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -181,7 +181,6 @@ void rtnl_kfree_skbs(struct sk_buff *head, struct sk_buff *tail);
 /* Shared by rtnl_fdb_dump() and various ndo_fdb_dump() helpers. */
 struct ndo_fdb_dump_context {
 	unsigned long ifindex;
-	unsigned long pad;
 	unsigned long fdb_idx;
 };
 
-- 
2.47.0.338.g60cca15819-goog


