Return-Path: <netdev+bounces-75752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F05786B0F7
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EBE1F26998
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B8714F99C;
	Wed, 28 Feb 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5MaXO/k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D8158D81
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128506; cv=none; b=aahr17FkLsKChSMRS0AiqDK2q0fdMPab7ozVrldq6flEhPxEhSyU3il+Dpv7n7yIFrdMYmSBVxeUMWE7vkPXNscgSucNYTi/2+OKzFUAPzcN3EM4KiVjfAV94fFtwfaw0WOxxCl5JwVHgTDONktTtoOExFF2vNwTYPJbwgdA7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128506; c=relaxed/simple;
	bh=2YzrzM7iR7CdeEyyZ+xAwDhYy17DBcnlq4xaYTXDaK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hy1ZzDBWiGoU4qVSTk2305LH2CzKW1V8+S0mSdjs0Tl5dl/Oi+FFAu+5ILM2uBQ1VLWqZZrPG0OaDRzgrJsyEtW4V5h/Kh3SmVLDyKvgyz2ygHyZEpk/CL0LadcrciNFtdNMlYVQjs1UjGLydUdxmoz7Lnn9d0WhKG2qEHvFWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5MaXO/k; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607e56f7200so51249227b3.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128504; x=1709733304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ux2I2RIzDi5uA7HnqdhVbRUV2suJ02PPtfk5GugwbHw=;
        b=d5MaXO/k618VSsws/bw8FgShGiWtSkbOkT10Oi3tz94BVPnX8Y4S+NufKyOV7UsDuj
         BBOg2SuEuzlF6799reIJHwlQzoFMr32gdLI3JrLw8AitCM+4njbYRGZ3hU7WhHp2i8Jk
         fShj3wvx2CbD/L2BrtYObl7ixlQx60p1GFHe4yC/wEXzjz6DGSGdn63q7+H2vAObUjkb
         cOvD4l9gLF5My6IrVaoL1YeMiqkTDohT0kCBYOZxF6l4n4Usky1xnNok4N4Y0tQfqTtF
         +xnwZeAdnh5VvI6wdPj2n8+xgwEW6U5BAwVaFcT85qjx6psP+5Pw7Hv1hAy/iPFq7xKl
         bVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128504; x=1709733304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ux2I2RIzDi5uA7HnqdhVbRUV2suJ02PPtfk5GugwbHw=;
        b=GIh4Xg6dSPNJKXYU1eE2xtVWD+/xoC3sEYn2vSbAxIzDo0+nKzdVcpy/be4m3OBCH8
         WUrPep3XgcbHvXX53DZT6vNM1QGhRhsX+R7X/9A2YmMqxRufM+Kxu7ewUuWe3KcatIe4
         a2iU0ZMJ3rXu1W6FdK+oAA62NSrWh1qqbr4a5lvDguduWL8rCR34aTX5wT5a9MrLxzox
         uxFKm9UPT2WPvzPMfIlEGknC3w/kCe50UU2hZAikqwDwz8k4nQpNrSLwWVTWOLeQ6rgW
         BiNLmc004J6ef3YQ5IZvZxuA3bo3+Dwkd/sY7Oj0+rUN9NLM4MrWbd6BNuGPoh3rIeYI
         OHAQ==
X-Gm-Message-State: AOJu0Yy7Uijc9KfgygUPnSg/WfvvkudkhfWBepJqXP7Odk0wYq72bDG/
	ghkZZGxy8A0228rJN3Srv2yKRMiztWWTbe3feTJgmGNmVzOoqCMOjnY18Yv56BXrogXVbStoV9W
	sbRbDz4ABHA==
X-Google-Smtp-Source: AGHT+IHFZ9ROAOO7LhhNpH/68QnH0mX8upS+4elYgpXD2SJsiY+NMC7UOfZr7IEIEKipvDYrq32VPOkF/eerjQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1001:b0:dcd:b593:6503 with SMTP
 id w1-20020a056902100100b00dcdb5936503mr147299ybt.2.1709128503786; Wed, 28
 Feb 2024 05:55:03 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:36 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-13-edumazet@google.com>
Subject: [PATCH v3 net-next 12/15] ipv6: addrconf_disable_policy() optimization
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Writing over /proc/sys/net/ipv6/conf/default/disable_policy
does not need to hold RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/ipv6/addrconf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 865fb55d0a2c7084cb80a704ad4fb2d97938bab4..20f327bc13340dfa2613f780b741c30294e50bc9 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6692,20 +6692,19 @@ void addrconf_disable_policy_idev(struct inet6_dev *idev, int val)
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


