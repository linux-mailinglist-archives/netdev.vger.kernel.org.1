Return-Path: <netdev+bounces-75000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C32867BA3
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C494B337E8
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EAD12C807;
	Mon, 26 Feb 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2DdBzC0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D63712C81C
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962678; cv=none; b=Dl8cqgi+woXZh6LerruMZyF97lPZfMZaXU1ki8ZrjEoMkhnP30hcMd5/l8LbXz685Nu3HZMU3idwPooQYzcaUuwj3KshVbfLb7Fth2iBh62dl+MtwHlyhxdnBTK+SiP20CuSHIgnWz11vwEzkH+tabDDlgpswl3PVQ4CcqioJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962678; c=relaxed/simple;
	bh=cokDySyTLD9bsJfeTw0Aa6mecrQS+AjYbPLW/OKfm/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fEi9NVA+FyTsGQ+LgervkCjOaMRhaKmynSEUsriWsUPaire78JWri0Nrk8ARVApMEQRwNHntTVx45A7FW++7C3Y+98bpXVWOtKvb2xkFA1Vt0oULHdUB11T8qv1J74HfvfoL7xoEjNXyVkaSo3v6zUFg3kZjPNKi99JHSI2PDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2DdBzC0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso53315497b3.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708962675; x=1709567475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q8CfLdQCm6NCOMyz0tfeU9JjvhZ1c596wmePMgrWbqo=;
        b=X2DdBzC0GSEOuDae3YLAiAmkbp/MwmV+BZtyF4O4FieNA+ngrv8+qoKdJfV54nzFjm
         9PbrSc8rjwk36sRD45LxvWjj/jJpwfB3YTTgXXVEnvCLlnLLEncJFNAIEwTDvvYC5YDy
         LfIQqJpX/ITCtX24+TVFbgV0ACgp/huDaqJfJmHVU97ydQ62pii0V130fIO5KMeEQ3IY
         bUbPcA+h3oWyAp09vMGaJh7kQGiaGNioEyXWL80+50L2+y9l3zn0755+Mn4tFzvoQVlQ
         sS3O3VqYMKPu5Egorgsrjl1NF1bbmg2iP4oGFt8GsWYDaJm0tMns0GpXml96CBdJD8lX
         dIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962675; x=1709567475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8CfLdQCm6NCOMyz0tfeU9JjvhZ1c596wmePMgrWbqo=;
        b=OW2ii144cm95xbDVEZXCrg/hGUOkyENIKUZ31vCZp6yWPiPmGyhv1U8jZzcwx5Sz5E
         RlAD6A72VoZ9qmoQ5fIHGa62zXPlqzKh+GB2tvlP3JU75lVnpxRT9Lv+931r2i3Ee5TQ
         /xIsPKkbgHlJOfw9UYxDzjkMJrHkwpHJIEq3w7ZaVdPUK9Og87CQUWO/6E8jT5k73m8R
         FKObtwgqQV8BrmFfsmyQ4RymbhIapkdMkHlQMppHHktZeyN2fxr8rnsPOq3aS1cp5fPQ
         vCow7vkY+JMKlK/H3wXioevX5CC4gScBBEvBGShaEQ2XbPMTAeXbfTuixMLfMnVI0jAZ
         j9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWfmoNSS0RHkoVVeMV627yr/u5mb9elwpGPoD3Cs71jkeNh1DqN5n5Far8ZTWnHOdTQXWgf9wFFau+wzMp16WZ6RCYH/sBm
X-Gm-Message-State: AOJu0YyEoDeMREBxyl3JyAZ2f14puOAciWeHlMCOqq+2S6yuoa+xYBxo
	yldUXMd5EAdh3Y2ZaqTcKTEbz5UwyqcAmlFUOeD7FtdKH+O7Y3DEqjehCmqILXcecslVdBVo1T+
	NIg7qBiekSw==
X-Google-Smtp-Source: AGHT+IFKsl9B4UrhZvOyKQdWAmAtigFEgCBf342IcERZWPBUNgHnN3rHy2NWHCBdJ4nVD3MFoO5Cvwh0iqvG3Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:8a11:0:b0:dc6:b813:5813 with SMTP id
 g17-20020a258a11000000b00dc6b8135813mr264480ybl.9.1708962675577; Mon, 26 Feb
 2024 07:51:15 -0800 (PST)
Date: Mon, 26 Feb 2024 15:50:49 +0000
In-Reply-To: <20240226155055.1141336-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226155055.1141336-8-edumazet@google.com>
Subject: [PATCH net-next 07/13] ipv6: annotate data-races around idev->cnf.ignore_routes_with_linkdown
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

idev->cnf.ignore_routes_with_linkdown can be used without any locks,
add appropriate annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/addrconf.h | 2 +-
 net/ipv6/addrconf.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 30d6f1e84e465e06a88bbbffaee70fdbd4ec5dd3..9d06eb945509ecfcf01bec1ffa8481262931c5bd 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -417,7 +417,7 @@ static inline bool ip6_ignore_linkdown(const struct net_device *dev)
 	if (unlikely(!idev))
 		return true;
 
-	return !!idev->cnf.ignore_routes_with_linkdown;
+	return !!READ_ONCE(idev->cnf.ignore_routes_with_linkdown);
 }
 
 void inet6_ifa_finish_destroy(struct inet6_ifaddr *ifp);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e5e40a37af18e18ceeef75248b205d1ad575802a..86992c1701485834662ec1a11d78576b211fdfab 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -566,7 +566,7 @@ static int inet6_netconf_fill_devconf(struct sk_buff *skb, int ifindex,
 
 	if ((all || type == NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN) &&
 	    nla_put_s32(skb, NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
-			devconf->ignore_routes_with_linkdown) < 0)
+			READ_ONCE(devconf->ignore_routes_with_linkdown)) < 0)
 		goto nla_put_failure;
 
 out:
@@ -935,7 +935,7 @@ static void addrconf_linkdown_change(struct net *net, __s32 newf)
 		if (idev) {
 			int changed = (!idev->cnf.ignore_routes_with_linkdown) ^ (!newf);
 
-			idev->cnf.ignore_routes_with_linkdown = newf;
+			WRITE_ONCE(idev->cnf.ignore_routes_with_linkdown, newf);
 			if (changed)
 				inet6_netconf_notify_devconf(dev_net(dev),
 							     RTM_NEWNETCONF,
@@ -956,7 +956,7 @@ static int addrconf_fixup_linkdown(struct ctl_table *table, int *p, int newf)
 
 	net = (struct net *)table->extra2;
 	old = *p;
-	*p = newf;
+	WRITE_ONCE(*p, newf);
 
 	if (p == &net->ipv6.devconf_dflt->ignore_routes_with_linkdown) {
 		if ((!newf) ^ (!old))
@@ -970,7 +970,7 @@ static int addrconf_fixup_linkdown(struct ctl_table *table, int *p, int newf)
 	}
 
 	if (p == &net->ipv6.devconf_all->ignore_routes_with_linkdown) {
-		net->ipv6.devconf_dflt->ignore_routes_with_linkdown = newf;
+		WRITE_ONCE(net->ipv6.devconf_dflt->ignore_routes_with_linkdown, newf);
 		addrconf_linkdown_change(net, newf);
 		if ((!newf) ^ (!old))
 			inet6_netconf_notify_devconf(net,
-- 
2.44.0.rc1.240.g4c46232300-goog


