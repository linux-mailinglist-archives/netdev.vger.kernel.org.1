Return-Path: <netdev+bounces-227175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFE6BA97FC
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B1F172BE1
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4956830BBA7;
	Mon, 29 Sep 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WfqSoM7t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8936430BB82
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154976; cv=none; b=iSolO/yfQwOWIZxx4gyBYvKO/emEqXqaod1rd5qYbtu4DThRGCC2vfLru3bwetMxv9kwPYarTXOmHhBEYRFhnU1SKUm6T3YXDLhQlzNr8HM1Cp1UYfW3eYu7jdb5RQ8BHt6qy5j6a9VWT/CsghgO5dQvZ1me5me28PGEa8V2W98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154976; c=relaxed/simple;
	bh=WtN0LBKA4Q0OXAASaJXgPYZ/nUWDRKNFBvYJoEj3+k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQWcvjMqhX+sed8/ix0J3v864Ss2Yj18EFH0xQYP6ravh1cqAZvPFcDOnY83UV8JcbbTkQ6pcYisLOTr19K3H4z/Jv3EIIodpovOPQJz1XOk3vEx/xFCm22FeEA94TyOwZiT6fhhcixLIFmcP0Am4udru1gSe6v6/9Z1EgHGVLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WfqSoM7t; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fbfeb097eso6799237a12.2
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154972; x=1759759772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWICciJCc2GVtLybkgatiELu642Kp+aREm8IDje95mw=;
        b=WfqSoM7tPDxS0vOzMrjxrFY920kToicROrJZaqag1+A9W/TmCcE7KtpaIS6tyKBYH6
         1z3p1IP6xeB+mp4oSLraDifsNRsPjz0Xl2npZjX8IH6LlfXgQ3PBZjl+K26g/hw+ErOI
         6Bd4BAbF27q5dZlLi1VJqSwsW9jSShPhECQQjce+R3xCW8W7neqNJ9c3rDCeWyhlNkdU
         Ou1/vqvHsFtmg+OrYI+SNQZMTiDxgWMrGsrVwssJH2/pJRbKe5dRidjnso71jUA29Cn1
         uKoW63MjD1Z18+0o+Wd/C2B/dNQTUS0sPMW+NzYKevnzIOYlJLe/gXWVb2yvzcvT2P3E
         JcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154972; x=1759759772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWICciJCc2GVtLybkgatiELu642Kp+aREm8IDje95mw=;
        b=sOwRtD2SSJIUGZEvl2HAtO6qDSvXnuWZ4FkWob6mAbXaYDrkfr6LnA2PdhhfkGiF4K
         OA//lM1lTffUUHZf/9FFh/s48VhFTHp1NJPgw7RBojxEzf8wJEYLtPzlfOU0sB7oG5Pl
         BePLgv2XOCby8b6+gEtRmpWcTarID027vfeXf2pQvgaAPPbbIOHfOgK1gQ7oGXg3f0hZ
         6aSIkMxPNO4L8teM4jY4hRVmjD+PFCiHlxI+kba1e1cl7Njwyp2fzNYwG3fg5IHfkHDC
         5iH/M2ZnAnRnwC7HiUK/4OzA3U/oReW68zAOT3P32tlOzqiIvqrzOgualYY6Po1ZvEyd
         RAFg==
X-Gm-Message-State: AOJu0YxVucxcKtwaT5bp424KS+vCT2teRmfa2vfhsDXH4pxOjpwq3hhX
	5egwpwXQUZ4Fy02yzi62AtT1sk3KCNWPdA/m6cU98uBxNF0ciWmTnpTP4/6Y1kqgs5djhHKF2R7
	ZAjH7
X-Gm-Gg: ASbGncuodhh4sfkGumzXN8DviS8qC3P2nP0BOp3+iGvaerg2GEn92cF+AS8htwgMMtG
	e4Ngg7SyL1NOpnzQ/yi32MgHS5lm+ZtJL3F43SKS3E1EQhrCp/JMfZvL/FnyLm0/jXtolaSpB30
	XG4apu+AoycjarvJt+pAoa3EBhGgyPp/4Jg6DJu/dc0PXu1KaYKqzXz65wGaw0VV45KisB8dqT7
	dQ7Xp58jE371Vc9Kba9ldDDjETAXT+kO34QQ+zyVN6hPUfjxHK8Y3mnFYvNI+H2IkkOknOL1iBk
	++Yw54Zfl/CmtN3NJtRAuqCn4YSanQr7CSLU+dDns1BJcACO6ZUhOCKUBuhvPG6ncRxstxgIUQG
	NAAYB9Tibzr3kdC9WPYXiXNGhdLW2NcbZTTmoDoj6KZXDWGlb42zrJMg7wFJwCA/7yzoSCWPfJL
	mR4jplUg==
X-Google-Smtp-Source: AGHT+IG/0nem7TlMMXBZgEjvTZSXPTMFOfrgWOH2FBs+3SNRi6CLU7oYRSoBXIqV9xTIw2UZW9XefA==
X-Received: by 2002:a17:907:9447:b0:b2d:28fd:c6bd with SMTP id a640c23a62f3a-b34ba450e21mr1723632266b.36.1759154972455;
        Mon, 29 Sep 2025 07:09:32 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f945d90adsm149317066b.87.2025.09.29.07.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:31 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:13 +0200
Subject: [PATCH RFC bpf-next 8/9] bpf: Make bpf_skb_change_head helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-8-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Although bpf_skb_change_head() doesn't move packet data after skb_push(),
skb metadata still needs to be relocated. Use the dedicated helper to
handle it.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index c4b18b7fa95e..7a5ee02098dc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3873,6 +3873,7 @@ static const struct bpf_func_proto sk_skb_change_tail_proto = {
 static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 					u64 flags)
 {
+	const u8 meta_len = skb_metadata_len(skb);
 	u32 max_len = BPF_SKB_MAX_LEN;
 	u32 new_len = skb->len + head_room;
 	int ret;
@@ -3881,7 +3882,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		     new_len < skb->len))
 		return -EINVAL;
 
-	ret = skb_cow(skb, head_room);
+	ret = skb_cow(skb, meta_len + head_room);
 	if (likely(!ret)) {
 		/* Idea for this helper is that we currently only
 		 * allow to expand on mac header. This means that
@@ -3893,6 +3894,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		 * for redirection into L2 device.
 		 */
 		__skb_push(skb, head_room);
+		skb_postpush_data_move(skb, head_room, 0);
 		memset(skb->data, 0, head_room);
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);

-- 
2.43.0


