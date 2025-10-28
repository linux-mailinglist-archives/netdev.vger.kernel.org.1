Return-Path: <netdev+bounces-233416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C719AC12C70
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B41804E29F0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9062877EA;
	Tue, 28 Oct 2025 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhkyLGFq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9B4286430
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622728; cv=none; b=NDtegEXPlp7ftckGyPxgVq87atbu4sWK483PScAEte2nXAPqHOVkV2/bjh4L0nqnMAkgtNg6IJOxznESOELxplqPwJ/2q3abcNlK/duvxljAsPbw3EaoY0F9D16JRC/P+tndicDJ+uyGP9dahhig3E0k7ixh5bwmb8VuQAu4iGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622728; c=relaxed/simple;
	bh=lMkxWJRB0pW3+0jNQ22uJ8kM1ejkiTsrmfAvBlkxpMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DsFCqhpHUn9OeS6cuYGCfVL8Qs/k0WH2Qd+fggO0I4xLuP/O6uxezn1GbMi6f/+7v4kCnr1rQyRk5lUCZc+dqtogwF/vl66sebgDJOrRCYF8AyBpvROQlfq6ibF2zkN5eBwZQnaNJiMT4rx4/wmM2V6c16AdLEk9blG4JVWeDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhkyLGFq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6cf40b2c2bso9557009a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622726; x=1762227526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z/yrfQuoScbli5rrFHZZ48kvscr05776S9Kn+raQJo=;
        b=EhkyLGFqP1VXohwsoX2ugbbCkoDeJNAg1AqwwOuozMIEaOiMSU5mhaxSqWeXyvsNrx
         dmgmpLEJUPCkYL+r3fHdeWkXUOJG+WG97HMRQ9/IAnxekPUmtTk7jNMVvRZhJfx7h+AC
         J4Eto8kgVA622buIZe/uUWHbwpDAhOEAvTbuQAKFzbvFfxoaSKduCB+I31inox0e3C9+
         U0qywy0XqDqNPljl+0Ewl48t9D48yb+1UWI/rxbLo+QeWmKuZ7TBy4oAh/NWD7tSFpGo
         Ko9UKnBq/PDaF7EbVsBAN3/u0vZXaQXqv/WW/7vHknWXybD1W7ZY5thX13Y/tV6HHECU
         VAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622726; x=1762227526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z/yrfQuoScbli5rrFHZZ48kvscr05776S9Kn+raQJo=;
        b=CKu/1XMdnYo4s2yEmw5gJH/wEQU1CoTikBwD0GvKp65wxJhiyP3Vc9JZNuotOaSKEQ
         iHXnViNbwHBVRXCJ76gPnhHEX7RVbEGOPQpRpfvGyXG/BpqPbCElpfJJccjN/m9v0By3
         IQ+j0F6y6QjWbnrhPF4Tw5eSQTZxF1nkHsb1vpcuxmyr0ZL2EIp15CtpMEBPXrSsTxiM
         PSd18OHF3iCKLsEKw5mtqPdPJVNKTWD41ZRzIaLUMqW2qURKS6jj0H/xiH/5MSk6CKAr
         uua9eelEgAYgqObtr85k5aRSIVEuD7r4A6vuPaHEM712Sj9mNDwdNmhxBHCj3Sjz/oDJ
         vgig==
X-Forwarded-Encrypted: i=1; AJvYcCWgv2ezMEf26BPHcv2H7vZRTJTKka99WAX74AgC99sG2y1IVs6noEO8EjDZetHT7GAtl0jyY/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+JU2J9UxCGrgg6VRpt+Tn0Zjbq5pcvlLlTFwaEbQCqG3OlX9
	wsCau1QrWF4xHJ9yIl0vkvlOvMmMdTl/Xq4rgBVf7NlqOmL6dR2u9FPk3Kq09Oo3idxykikpKOl
	ctG2Evg==
X-Google-Smtp-Source: AGHT+IHIefzWNKMkDCEhgAY3xb4aiUu0F6aAzgcGi9/IsTTww2AvxwD8jgLTNiit9JZLnrlpNOpxeDcQjsM=
X-Received: from pjbsq12.prod.google.com ([2002:a17:90b:530c:b0:33d:4297:184e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3c8e:b0:334:9bdc:16af
 with SMTP id adf61e73a8af0-344d1da616amr2545653637.1.1761622726176; Mon, 27
 Oct 2025 20:38:46 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:37:08 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-14-kuniyu@google.com>
Subject: [PATCH v1 net-next 13/13] mpls: Drop RTNL for RTM_NEWROUTE,
 RTM_DELROUTE, and RTM_GETROUTE.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

RTM_NEWROUTE looks up dev under RCU (ip_route_output(),
ipv6_stub->ipv6_dst_lookup_flow(), netdev_get_by_index()),
and each neighbour holds the refcnt of its dev.

Also, net->mpls.platform_label is protected by a dedicated
per-netns mutex.

Now, no MPLS code depends on RTNL.

Let's drop RTNL for RTM_NEWROUTE, RTM_DELROUTE, and RTM_GETROUTE.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index afe5b0b70b23..0ee161703759 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2803,11 +2803,13 @@ static struct rtnl_af_ops mpls_af_ops __read_mostly = {
 };
 
 static const struct rtnl_msg_handler mpls_rtnl_msg_handlers[] __initdata_or_module = {
-	{THIS_MODULE, PF_MPLS, RTM_NEWROUTE, mpls_rtm_newroute, NULL, 0},
-	{THIS_MODULE, PF_MPLS, RTM_DELROUTE, mpls_rtm_delroute, NULL, 0},
+	{THIS_MODULE, PF_MPLS, RTM_NEWROUTE, mpls_rtm_newroute, NULL,
+	 RTNL_FLAG_DOIT_UNLOCKED},
+	{THIS_MODULE, PF_MPLS, RTM_DELROUTE, mpls_rtm_delroute, NULL,
+	 RTNL_FLAG_DOIT_UNLOCKED},
 	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes, 0},
 	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes,
-	 RTNL_FLAG_DUMP_UNLOCKED},
+	 RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 	{THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
 	 mpls_netconf_get_devconf, mpls_netconf_dump_devconf,
 	 RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
-- 
2.51.1.838.g19442a804e-goog


