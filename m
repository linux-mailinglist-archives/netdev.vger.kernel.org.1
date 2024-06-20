Return-Path: <netdev+bounces-105416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FF49110A5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9A01F23C3C
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2FB34CD8;
	Thu, 20 Jun 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9QoiZzN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57873376F5
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907461; cv=none; b=JnKJI4FJLWN/ytMwCtNU5rgHqtaDwhLX5fC6T2Bm+9+jrbrVuPDc+G3INbewiPtKgzgsizOXYER1hjuqcRlC4DT1i4rc+xtdhStHRbT+fgPTrUUIyEY5KXKkz9/IoR2WiSM6+OiRy97pQGgVqsHCv3GxVvKb681GO/Y7Q5XkBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907461; c=relaxed/simple;
	bh=iY15znjKwXj/mYMfmF3+a0bhsiOgCwhdhV8LAVnf6/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ValYHQjiH/1Zl35dcHCdPRvh46q2Ge/XQDRiUCof5y0XIQ9sC14kDf80HaDSnK5ozo2c3x/NV1soWPUZYBz/ZmhAReqTU/Tq7OuE0RG6Rx0P9GlSA2zM0A7reactaIdnajV+P6Ad9iscS0Mqjr2ypTzmZCTCfCgxWRcw8RUh3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9QoiZzN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63bf44b87d4so15315297b3.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718907459; x=1719512259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=txPbdh0UwgPW6j6zme2yNhfuJXXQO0kUOBEsBGdoZYA=;
        b=v9QoiZzN57lzQJCCCfz0AOWbSagaDStYUvrR1H4TY4PoItcKCswu7i0v82fFrV+AwM
         KmxP9NcCkIrXh+S7BkKvZKoefo7YXjYb3TSmdo6tXCPYJAOYxfYUMxwJMbuBsXq6ubi8
         T8cGcabCqejs4nwlevAMGsMC0DQ3ublsil0RQnBPuYkloi9GKLSBCvI2YjFz+rUHxkLJ
         HvNueihGWB9nI8OOOe3M+M/XTKHwVBxZWgYDS/XbrRPhVA5Ji/ji6T5omniT3Ql5D7o3
         S+5tmlQVcSM6FiFN7/q1k++sqtenTSgEPJUY75I+p2RmIOzsxUN7jbRTD3fe3zXa4IIz
         DjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907459; x=1719512259;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txPbdh0UwgPW6j6zme2yNhfuJXXQO0kUOBEsBGdoZYA=;
        b=QXfnZSXOEUHw7ewc4QP5jXIRw+p+GtCCFwtwKKuHUuvX/743xQwUM63q7uYf0QDhEw
         FYxWXY3JEOt619jPq+5OI2Fr+qLdY6eZEK8YlYBo52qR4lGEKfkZ2xjdEc+iVrZ5mjzV
         sfoD8R4BQcsJIi0logZ9szRbGL4sOkzgQK5C16UZ/tsUJHdmqVziZr4gGhw0o2ut6jd2
         CS19EqRBlmbzeUCafekhXcVKOdgaNkgRdDwB32qx0i8sfmRC2qBY2AfKfgw1API7lEuz
         vWVJDC8a3iT02ORs92WmGAq/9v+X30PXbz+sF34yQPnnx+NkL9QlCFKc35+FzslkR81e
         ddWQ==
X-Gm-Message-State: AOJu0YyM1ThChIEyDkn9y4a44eWAPCeGPXKbplKPRHRw1ndGJSYQ6peD
	LHIeY4YWYQ4YJnAoH16y8apcMIJKgNqnX1QzWNAvvp5teLgpH4KPmF8Ndm25+oAskZ8cy0SgaWk
	L
X-Google-Smtp-Source: AGHT+IF8GVDMyvGZpRp4boOIOSvfLSv3xxNhz/7qXqDIgZdXB8RVhwD0g/1O17E1anqM5aheujLEfMzdr1M=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:6cd4:2b82:abfb:6e47])
 (user=yabinc job=sendgmr) by 2002:a05:690c:30a:b0:620:32ea:e1d4 with SMTP id
 00721157ae682-63a84340c6dmr12853057b3.0.1718907459308; Thu, 20 Jun 2024
 11:17:39 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:17:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240620181736.1270455-1-yabinc@google.com>
Subject: [PATCH] Fix initializing a static union variable
From: Yabin Cui <yabinc@google.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

saddr_wildcard is a static union variable initialized with {}.
But c11 standard doesn't guarantee initializing all fields as
zero for this case. As in https://godbolt.org/z/rWvdv6aEx,
clang only initializes the first field as zero, but the bits
corresponding to other (larger) members are undefined.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 649bb739df0d..9bc69d703e5c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1139,7 +1139,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		struct xfrm_policy *pol, int *err,
 		unsigned short family, u32 if_id)
 {
-	static xfrm_address_t saddr_wildcard = { };
+	static const xfrm_address_t saddr_wildcard;
 	struct net *net = xp_net(pol);
 	unsigned int h, h_wildcard;
 	struct xfrm_state *x, *x0, *to_put;
-- 
2.45.2.741.gdbec12cfda-goog


