Return-Path: <netdev+bounces-132066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB5E9904C3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225192844C7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1C02101B0;
	Fri,  4 Oct 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NlYU2A6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC3149DF4
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049644; cv=none; b=W7hVtKfv8yZ6BzoQi2kwakTbQvUYg3jh+95IUVVRBMbagDnZw+OoJHoGRMXPYTBZeVs+eSO2IQgxCeL7+gVKaBTPoiJQGegEY21oi3gfuFQmX4Xgy524DsVP+7oYBOY7oVf8q+ThV1svxgzoVAD283HW3b6Or32Vq16oJIH0Kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049644; c=relaxed/simple;
	bh=f3EfguQJLPpPL8SrF1rgrHsd7BGSneeiFOGlpBOsrtE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FpWfql3sTLXBxuLoW3NetqvNRSrs/H+r4mbZ/kadjoxgVjbq968dM9OEuiu3O/3Yc3nKhS5RKEVZyZpRf2v6043D8t/WxXZtGleMFGdYdxqYNbTnV0Ae+LWA2Mr9spgQ8JoMic4q3UAo9sxeWxJVRLBmoMfw+j4OH08+1xVruoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NlYU2A6S; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6cb4619a542so37329406d6.0
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728049642; x=1728654442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o/62yyRlRK9XJjjejC2Iw9AkEMi1WXJl6yQMMBQuZf8=;
        b=NlYU2A6SGCUWk3ny0dr1uQOMunJvFB6vs8Cbw7WD/bYJz5NMOhfa2oXG8rxRKPZN0e
         UdiXysK8aBov6OZvzY7ITbPANY70AspMNh1junhk1RBkXTjKVDyEdXB4kYbs2dFRBsNa
         ecXedgU1SAMeIPsXsriLlndzeJS+KscjqVekkJ0TIKCiAYmgSvXhALpBUI3756T6se6e
         6J5Sd7WJvQMcR0VB8HIotr2z8Rt+kHqBnT0sYsAiHN7ycBeEe73NsJ0tTU1TEAVtopjX
         A3s1qWenpY4vXJh3uNHGNjVrv+nonES37Ttf/z+6eK7OCZeVF9JMtcUTs3ml/wTU67Ws
         Pz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728049642; x=1728654442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/62yyRlRK9XJjjejC2Iw9AkEMi1WXJl6yQMMBQuZf8=;
        b=UrBvIr1iMfRK0lIEZ5ZElQpRYfI7RRap7yBfWplCEOYVoilr5R5i+CBVfDYS1KIBjP
         8qqPDEj2zstSSYbDduaxSDVR2Tp+4NRMYhB0sacb9pALz3GNBAefgvMxNafHUeYAIAat
         FKi+i+n86m1CpR7kwXSvmw2LbZkfJZxcz6Io9j9DGmYnV9kXSeYv2ji4zND/uL7JvHr4
         lJr/gH+N1l8D/xKDcz/+mKPr0gGb4dilD3f3813jibZY0zbe8bRoAH1Bmikdcq/PHl30
         2sYPa59i5tG5pL3+V0INsYAoQ5c/kyFpJzkRlY7YYvgetjpiMD+hjzPnw6n/30tkYFlR
         yuTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC7ghUHRxIrOiNRxF3b4LiBiMIyrhIohLYVDhs0lx8bgEwZ85NGKlPXdCMoNtxK8uONARGhr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfvC8g5tJ/g4OeCJYItDFvrb3jiw2NGwbJ/yzn/ASckeJNtZc2
	ZarwXujAWEFJxa3hyGgiVSQc30Vsvnh3t+1qK0Vc76Eg7u4KLCq23ueQlh8QRw0pCWy8An+SoOy
	sd+v7oHtyig==
X-Google-Smtp-Source: AGHT+IE6rpORRmWnNfWZ72zQIEWKlSUPECG6Mvz2OlNgEO8HgzrSm6sqQ1+Tk/JGfURpkHSQYi8BWNXJkjU9uA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:6214:c83:b0:6cb:664e:38f6 with SMTP
 id 6a1803df08f44-6cb9a4eaffemr26446d6.9.1728049641619; Fri, 04 Oct 2024
 06:47:21 -0700 (PDT)
Date: Fri,  4 Oct 2024 13:47:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004134720.579244-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] ipv4: preliminary work for per-netns RTNL
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexandre Ferrieux <alexandre.ferrieux@orange.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Inspired by 9b8ca04854fd ("ipv4: avoid quadratic behavior in
FIB insertion of common address") and per-netns RTNL conversion
started by Kuniyuki this week.

ip_fib_check_default() can use RCU instead of a shared spinlock.

fib_info_lock can be removed, RTNL is already used.

fib_info_devhash[] can be removed in favor of a single
pointer in net_device.

Eric Dumazet (4):
  ipv4: remove fib_devindex_hashfn()
  ipv4: use rcu in ip_fib_check_default()
  ipv4: remove fib_info_lock
  ipv4: remove fib_info_devhash[]

 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  2 +
 net/ipv4/fib_semantics.c                      | 77 +++++++------------
 3 files changed, 31 insertions(+), 49 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


