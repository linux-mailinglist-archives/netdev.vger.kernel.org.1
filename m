Return-Path: <netdev+bounces-155987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F22A0486A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF92C3A65B5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3018C924;
	Tue,  7 Jan 2025 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J74lyIaS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605AD18E750
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271526; cv=none; b=Dp2TW49T8M0mnmFfFEovSjv9shVCF+byTfso2wkc8ksuka3AvmXnDvhCcq9EPXP3wE4/ing0OIJclz5KWNOHDxpnX78xPeul8hMsORlsepAoR/mwKx1pp5w17lvhlbyCkitLo0vv0CigRjgTfe4zOC0hzA1V5zzKE8gxX6c9hHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271526; c=relaxed/simple;
	bh=FeWLCRIJSynfSqJYBMEnPDrSf1/Yq5W6089igqo+zJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TrVn1YDKfPWPNB82x1SjjxVzxMDBuVMxS1WjwIOzQyvn8K6pOdQiHVh5hcRR3CrltS3sV8a6+0FVygAYy2Nz9BEtj3SreISq/02airlbP64mNztOXIl+CI6/XnsuBv0SU97yd+4j2xPaW9vBg6LoE3M1KgqY635U/NrRxbcRRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J74lyIaS; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-4b11b247407so1014860137.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 09:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736271524; x=1736876324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQf5Rn3U0tejDnmzZj+gGv2suCDKUxoYIgY5TsACDAE=;
        b=J74lyIaSJydfmoJChyqXSbmQn2TGJHdQmJ6g6t+pfsIzDezXc7RAl9WRZA2C22tO0M
         RZ9ZhRP7wp598kVUuy6TOaA1vnNw2W864h7yIIyXZ0nSr0JQxa/v2fnuXVRWaJXGO+e+
         Pd2RfNsaqAufzDDEm56z1hshJOrO1shcfigoROVFTIOYgbD3NElBprgeom4y6SZsTyAK
         06zghFP7TpPpWNGJuOieBaWj7cAQXtRLjvEPjI6L041NVef0I+/aryTvQpHLPoK2xp8J
         8vCtsK2UGTplJ3YaU9SWRgeYvMLYA5BWkqBc7KadWl0DgzGUJiQSxGZXtXlY7qIvPLPB
         +KJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736271524; x=1736876324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQf5Rn3U0tejDnmzZj+gGv2suCDKUxoYIgY5TsACDAE=;
        b=WOS8PKPx6gwk5V5PxDRwexmzdRhYG1PoFMLzvAXdBSWiGwnRkwuhNP7K56HJkNtIBt
         7ORvjaf4F8JYecgTo9tWrftfsC9nUebao9Ojrmv8R2vl/LbrQMawOvl4qtTazkplvdqo
         7BjdDowYKI+FPE4gE2UucmpE9Xmf/LJ+v98C55kSJXPHPSSguDRGa88sqWKayzPIBriR
         E3ZMebbnw9CYzTucCHRAMm2vOBopa4t0WGhQZ0DxCM4xiL/atgZ0kK4Fl5XecV7B5R2m
         QcUYvnXx7KsPaOmyRTLmHlx1eeVmXiWCJftbpMnYhCEaxQk1/3b8V/+w6DQwAb0tabt+
         UF7g==
X-Gm-Message-State: AOJu0YxrNxj16jn9eh2T2oqOgt7b8KQXr36sXoIHSkUaB+P3BoygyQBt
	yhPqVwcaDW5eFlMiHe/vFaFvj4DCrnyc74BMn9Bt05OQ2pqEDl5LRywNdVRhqHPEXj+6LVGtfME
	S1L3Y2Vc6jA==
X-Google-Smtp-Source: AGHT+IHMYSktWYBj/911l6Rv1c6+xVTTKhgM1F+kwsGtNI0RHoF3IpMtDrgBR42uRvL8aRBon8doZyPZT5gGPw==
X-Received: from vsvg17.prod.google.com ([2002:a05:6102:1591:b0:4af:e0b1:8690])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3fa5:b0:4b1:130f:9fbb with SMTP id ada2fe7eead31-4b2cc488b98mr57416090137.26.1736271524223;
 Tue, 07 Jan 2025 09:38:44 -0800 (PST)
Date: Tue,  7 Jan 2025 17:38:36 +0000
In-Reply-To: <20250107173838.1130187-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107173838.1130187-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250107173838.1130187-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net: no longer hold RTNL while calling flush_all_backlogs()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

flush_all_backlogs() is called from unregister_netdevice_many_notify()
as part of netdevice dismantles.

This is currently called under RTNL, and can last up to 20ms on busy hosts.

There is no reason to block RTNL at this stage.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9e1eb272e4feaf40dc87defd54d691634e0902e5..ef6426aad84dc00740a1716c8fd4cfd48ee17cf3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11526,8 +11526,10 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		unlist_netdevice(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
 	}
-	flush_all_backlogs();
 
+	__rtnl_unlock();
+	flush_all_backlogs();
+	rtnl_lock();
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
-- 
2.47.1.613.gc27f4b7a9f-goog


