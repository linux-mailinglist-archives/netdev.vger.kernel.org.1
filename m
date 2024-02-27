Return-Path: <netdev+bounces-75365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BFB8699D3
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70211F21BC0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7614EFFB;
	Tue, 27 Feb 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXuM6jQZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BE14DFF0
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046144; cv=none; b=VF7W+JrFhm4bgfORyM7Y+qbygWRcSl2jS0zwVcsYFBPZHtRH3hZbeDR1SNLoBTbSbRegBEL9thVhuX70iXZaMpwv79uHygDKAG/XvizxrBKU1yEOwsPsvOwYTbxFmLxNbP33/ouXxQIQQoybnNKcsZo4AoPVr2Xt7Cb0rM79wpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046144; c=relaxed/simple;
	bh=8bRikHRwm7Se3WlFwHPpx8npd5rbveoKhRH1KAaMLt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k7DlAx0RJFdb3mlZMFkZ1HhW3Y1DU024kmf+Cj4XC2G4tvMbKyrQntkV5SgFhD9bFkshy4QDkgCvlgucNo4sDOWFamIeIkewcbkBNtr9LnZ56dum1SqeVJC5PBk5Xsdlp0EGfT+YfLA6W6ADcWkdhXQgDaTyaABerx+kWe6xdzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXuM6jQZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso7833905276.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046142; x=1709650942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sK7UJg7rV89yZgATS98YoVrpG63epGGs1gsUV1nYAkg=;
        b=tXuM6jQZfpJZFeWzlPWcYZqCksl6K/V5JGEg1uvjtS4U8GQEmsCNJJ0vgUuJJ2s6H/
         CKUl2e5vGD+LytcIunjOPQ/ymk2TWjODvT59tGBX7FnEN104ru0y5yV8/cAaxfPjo+9O
         mHUGOzGEVygN4yCGxPD2JWQE1qk81LU7mucdBWSLx7b4eRJ5thwF1tkDWD3XaWUQW2De
         Ak/ZfOrqnpxatvXZaX/35ZcPLts++v6Do6jDIsLVHE53CPFW/+Iwj7l3XcnopseblpUd
         cxIhL+kar0sXDS3nxSrPAusKc3Eru88NtlH8/mngvj0E2MS1/YZ7MsbiEoeYENgJOTW6
         WSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046142; x=1709650942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sK7UJg7rV89yZgATS98YoVrpG63epGGs1gsUV1nYAkg=;
        b=Lb8iv0LeXjOZi1GuvxwMx3834LTazz+V0pgnPGlV/tTAAceF04iH0RqDNoyggKyRqO
         4nC4PKBcSDimGYVc/sfzdTokwQlvWdD0J/ISHTo3Kjx8aXAF9Et7tvRLSFeyDhAKYJEZ
         GAvDQ09N9QYwHKRNCF4L9JoC5jvE31cWmYwMzB7dNBYt9A4u2odSxWU8sRucCnCB5S3m
         Cq4jN9imLQk4YzR9LYDpzMcp9VzBjKD8Fx4rEm6tO+MYJFl7ggG4Gh4HUH3+uGisuitO
         2FLDImqXXnS/eODjoMSD79tTFlqnKDy12kFo+tefYed2xm4UEiLlNMKqSKbfUcnqcUsJ
         8icw==
X-Forwarded-Encrypted: i=1; AJvYcCXNKTJg4CQ1B25iHBF15QUtXhX6kYjFDfp/xkWAQa9GjpC5ipN5T0tCdb2xDJkK8sq09zn8CjDNmmrk1aCIfzxzQX5UCyDD
X-Gm-Message-State: AOJu0Yy66cIHW2Pd2giK7sVRbEgc12s6ZrTw2jKRMNXMWVq5ESIyeScQ
	Y7A8c0hnWBC7OPvkDWnRxJLcKWhnu0xn2Nca0bnjyViGSzaG7aZ4geQcYU1wF3Nl+yR3yWsFvAA
	/IkmkZlutvw==
X-Google-Smtp-Source: AGHT+IFvYdXPREqrXMx8pq52pMpBtzXFpakWv7R3XYTXQiS884lmrWSXwNKEBpBCwymqgI9y2VDpHR4+3kN9AA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:8602:0:b0:dc7:63e7:7a5c with SMTP id
 y2-20020a258602000000b00dc763e77a5cmr89630ybk.11.1709046141922; Tue, 27 Feb
 2024 07:02:21 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:57 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-13-edumazet@google.com>
Subject: [PATCH v2 net-next 12/15] ipv6: addrconf_disable_policy() optimization
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Writing over /proc/sys/net/ipv6/conf/default/disable_policy
does not need to hold RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 392e64df991a4005736883af128cd82ac3895167..d198365b1ac669a1158c44c1c9d050ede276d638 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6691,20 +6691,19 @@ void addrconf_disable_policy_idev(struct inet6_dev *idev, int val)
 static
 int addrconf_disable_policy(struct ctl_table *ctl, int *valp, int val)
 {
+	struct net *net = (struct net *)ctl->extra2;
 	struct inet6_dev *idev;
-	struct net *net;
+
+	if (valp == &net->ipv6.devconf_dflt->disable_policy) {
+		WRITE_ONCE(*valp, val);
+		return 0;
+	}
 
 	if (!rtnl_trylock())
 		return restart_syscall();
 
 	WRITE_ONCE(*valp, val);
 
-	net = (struct net *)ctl->extra2;
-	if (valp == &net->ipv6.devconf_dflt->disable_policy) {
-		rtnl_unlock();
-		return 0;
-	}
-
 	if (valp == &net->ipv6.devconf_all->disable_policy)  {
 		struct net_device *dev;
 
-- 
2.44.0.rc1.240.g4c46232300-goog


