Return-Path: <netdev+bounces-142053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C699BD3A3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56772286478
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A481E5735;
	Tue,  5 Nov 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPf6qtUy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360781E285D
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828652; cv=none; b=NzgZ3mRkXd6YoEGstN+Dw/RYvnXWeqYU+OhtNlEZt3Ed3aGuF6vkqEL6eWnGr1gyjukbZ3r9SzNcXPJBhQyokUs+bDn05veMVGSnb98omb2NHAJ5c3ZDQ4f0tZ7rRItW1G5bjglshqarF5S6iZBKMElomMAYMtZgLvXqfPtoPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828652; c=relaxed/simple;
	bh=BeIr3Swz6ajsUdtnjxoFYHeaIUKCRo8so4bAz3l2jRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bEMy4DCSId4xyyiBdpPwZpL48DyCl1cSvIlG5luU29hya58w/E2Eka2Kk/by7p9g3WK0jCkhKKlZIm5pRxN7NRpeDIp5mYzePXqjRpcV+L2NNxTvJfLFrYCnQ3oNCSeBQepCX+otU8uTIsJwRR2JZ6I94nkWnZB8SIED9h0o6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TPf6qtUy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8794f354so59192337b3.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730828650; x=1731433450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8T44iTpXK8QSzLP5+uA52EIN8x9vg0thB5TAGN/oVc=;
        b=TPf6qtUyqk/EIzI8i1ndUR2zmRUq/Vadfc8cUSyfuGHIbnlQD8HhEcsYJ0MFf4+m16
         lGTWXKTxYXc1pBqDzjUkTQqrvHbiDJwkO5zTy2DdfD/O5qrFXfAmavKW//DJL0mh9hcg
         baxHT1DBfqJ0yT0F12SWH7sd+qd6NMMcUKdHwjPTbzB60UhalBXwWq2i2MilQgY8zIgs
         ORmoP+ILAoUozqD2mlfSZivT8TLawebUvewgOxi/XTBbU0wbIMAF/tRM2X02Dt3kmfxr
         bnG7qeckU8Zb47rckOUIYlIymBZ1eOTFPnUo5d+D1S90l/XnY/dtexfqOsQDZe3A49eD
         YOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828650; x=1731433450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8T44iTpXK8QSzLP5+uA52EIN8x9vg0thB5TAGN/oVc=;
        b=BSjPe093xTgz2nQ1nMB65hy9TsBlQsYMuRh4BG3tLw2uNVQIgjcPW+K++ImVHcl4Yq
         el+Un9G+YxM7teZrTDBV2BBPIZs8tX6uM3TouIgvZ117eEtm8HpItGuY2RSX6laxKezf
         Z87lE63ZoapkmsyB7SZpBMGS9lPAQhNgqQK8j332jCcI+4NCWFiZ1Q9S7TBh6BKxqJyD
         ee0H4aF+4ifspecqZJbLzYZmG/9EUAZHmNlYGdSDXxoE+KLHuahPvXKUCFxdu60oEqTr
         pNVR7lGEl1hJV+MxCfFdV/IqsSXLeB/9m+ZEvHOPX2UcxMBA5/0rEVuxT1KWrVV55Uz+
         jZPA==
X-Gm-Message-State: AOJu0Ywet7hWaJ0b0ljDthonlwCDRLZHF7Eo7OliZ7GjY6sMovvPkWZm
	6lJs0GSK65J9opwPezS3yWuqM7OH64OWCE57BR5AsJGQG8TzoYW5/u+3eLnmBdBEP61Qrz1LsDm
	Nqb+6gF+l3w==
X-Google-Smtp-Source: AGHT+IGPB3ka1XsWxjty6yUf492L+j915SKA9lvENGEeB6KNQOJjD01wq9//1Usp7DruI2iLog0gvXAtZXpT4g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:838d:0:b0:e30:cac7:5b70 with SMTP id
 3f1490d57ef6-e3303408237mr16380276.11.1730828650077; Tue, 05 Nov 2024
 09:44:10 -0800 (PST)
Date: Tue,  5 Nov 2024 17:43:59 +0000
In-Reply-To: <20241105174403.850330-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105174403.850330-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105174403.850330-4-edumazet@google.com>
Subject: [PATCH net-next 3/7] net: add debug check in skb_reset_inner_network_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Make sure (skb->data - skb->head) can fit in skb->inner_network_header

This needs CONFIG_DEBUG_NET=y.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 75795568803c0bfc83652ea69e27521eeeaf5d40..8dafd1295a6e921e9fba69b730286ea28fdc5249 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2957,7 +2957,10 @@ static inline unsigned char *skb_inner_network_header(const struct sk_buff *skb)
 
 static inline void skb_reset_inner_network_header(struct sk_buff *skb)
 {
-	skb->inner_network_header = skb->data - skb->head;
+	long offset = skb->data - skb->head;
+
+	DEBUG_NET_WARN_ON_ONCE(offset != (typeof(skb->inner_network_header))offset);
+	skb->inner_network_header = offset;
 }
 
 static inline void skb_set_inner_network_header(struct sk_buff *skb,
-- 
2.47.0.199.ga7371fff76-goog


