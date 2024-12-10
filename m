Return-Path: <netdev+bounces-150803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBD59EB960
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FEC28280A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D541DE2B4;
	Tue, 10 Dec 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgUBpkq0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B09DF58
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855638; cv=none; b=R+8o4ed966m1EKI8VH2Kg/Qi5urT8i+5udwSp1Ufhyg2FgtwlN7Ej6VHpf+JKHRExH5MIyJfxe2AoDECXQ0OQk6RBqibkseCW5WcEZPSMPtL96tur2wi64mOAKktubp19pSSnvXVSFKDAA7Wd3o0iyVaoZDbF9BkTyPkP0usIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855638; c=relaxed/simple;
	bh=W1we/a5FNtdhD6fuveY6jnhVCDwMzJfdH56SmQB8mVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MNYkqbSBbEZIKrMGkPGl38qA7amlSnLxFCgQCy8mIXd3mefw/uWUqmSYgDbdVWSVphGctBwgO96NNdtkp4K2/siqTMiJONGfEKenV7eWyGQPnQQX6acnBn2dpiU2KStIjgm/2nbwcoFa0FeR10x5IV3RiI6m9VlRv10r0DSlbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zgUBpkq0; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-46767adf257so39333351cf.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733855635; x=1734460435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWc+s/WSUYTIjlPArhBZuBmijOlGPM+r9wGnMc/lmIw=;
        b=zgUBpkq0rEIUbWRlh/I8m+pz0sJ2HzjcJwP65SeSI07tqxH82KjAgZSEE++noDfPnU
         ksP1xTJRpTQ1hLt8DqaLatOEwC2XkI0grzjjSylEnRdzgWchAyUkWEBS8vElJjoSgKa+
         yuYzg+9w4+Hwy6SeSE7Ktr0j808WmoDFjpamHeOFw8at3dNWj9ZJn4gjqyC3baylcj6j
         b8zH/pi5NeJY1aHAMn73n1l5rYRnZeC7SgxY8/b89dJPdXnEWmI/EZeJOdKLyb3MAv7t
         F4ke5KQ/n9/eUv2EUIAtWDXrLJ8v+P8UN+uuiABqK3pd4qiqxYIG5psCNGU4aPanZfAf
         XA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855635; x=1734460435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWc+s/WSUYTIjlPArhBZuBmijOlGPM+r9wGnMc/lmIw=;
        b=dVFOSJ+Gst4DwIoDmhgmp+UcTexw8k4S8F1JlJC70LkHm7RoI3KdsOnglb686KtBCo
         bXLeNYyMyX1NFtEF9ZZDX9PzzBwssM48WU7DOfBrd5TJdVkWK0TquVcUtGkabiUG+ECg
         hi6k2I1SghpzRPeyaNZ5o3nzxDLyruQXLY3A3fRfu6qd5XjWpe9BFEevIBc5jkpNQNNt
         CqhbElSGPnT8g3m/GcN4l2ZAMBG7pyOrvniM91EJMDy3UibXA+eRLXaXSgukx5PCW+s1
         bisVyreQD9AfKP1ieomFnyR8iziMrU3cg3HvMAJJxb4F3J3aS5Pu9yS+pUOBXfUckIWF
         rL/A==
X-Gm-Message-State: AOJu0Yx8jIMww+F8XaVTVvBZapiqlpPo7D6I5ivPqSdbegVQoEvm9jNI
	ZZWM3FcFn0uPPvzkTcBS/mRES1vg5ZWYso8LSmgDrzJ9TJU84hqGMRVVUmyVbBSM5YBWTZ9MDGf
	RM5ZiaN/ykw==
X-Google-Smtp-Source: AGHT+IFB7FL75HJfe/wS1szXthJu2KaL6oO9B1kov4JTa7/wQv5GOs1RR5l4v/WbfPQdt6nxMSE8OFifCVRi7g==
X-Received: from qtben9.prod.google.com ([2002:a05:622a:5409:b0:467:6e70:8713])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5886:0:b0:467:5734:d094 with SMTP id d75a77b69052e-467752b9aa0mr67986481cf.28.1733855635488;
 Tue, 10 Dec 2024 10:33:55 -0800 (PST)
Date: Tue, 10 Dec 2024 18:33:50 +0000
In-Reply-To: <20241210183352.86530-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210183352.86530-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Message-ID: <20241210183352.86530-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] ipv6: mcast: reduce ipv6_chk_mcast_addr() indentation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a label and two gotos to shorten lines by two tabulations,
to ease code review of following patches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/mcast.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index b244dbf61d5f3969c8886a999166ad5ef68b746d..afe707b6841d1ce84f11cc588200615b504a591d 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1021,29 +1021,31 @@ bool ipv6_chk_mcast_addr(struct net_device *dev, const struct in6_addr *group,
 
 	rcu_read_lock();
 	idev = __in6_dev_get(dev);
-	if (idev) {
-		for_each_mc_rcu(idev, mc) {
-			if (ipv6_addr_equal(&mc->mca_addr, group))
-				break;
-		}
-		if (mc) {
-			if (src_addr && !ipv6_addr_any(src_addr)) {
-				struct ip6_sf_list *psf;
+	if (!idev)
+		goto unlock;
+	for_each_mc_rcu(idev, mc) {
+		if (ipv6_addr_equal(&mc->mca_addr, group))
+			break;
+	}
+	if (!mc)
+		goto unlock;
+	if (src_addr && !ipv6_addr_any(src_addr)) {
+		struct ip6_sf_list *psf;
 
-				for_each_psf_rcu(mc, psf) {
-					if (ipv6_addr_equal(&psf->sf_addr, src_addr))
-						break;
-				}
-				if (psf)
-					rv = psf->sf_count[MCAST_INCLUDE] ||
-						psf->sf_count[MCAST_EXCLUDE] !=
-						mc->mca_sfcount[MCAST_EXCLUDE];
-				else
-					rv = mc->mca_sfcount[MCAST_EXCLUDE] != 0;
-			} else
-				rv = true; /* don't filter unspecified source */
+		for_each_psf_rcu(mc, psf) {
+			if (ipv6_addr_equal(&psf->sf_addr, src_addr))
+				break;
 		}
+		if (psf)
+			rv = psf->sf_count[MCAST_INCLUDE] ||
+				psf->sf_count[MCAST_EXCLUDE] !=
+				mc->mca_sfcount[MCAST_EXCLUDE];
+		else
+			rv = mc->mca_sfcount[MCAST_EXCLUDE] != 0;
+	} else {
+		rv = true; /* don't filter unspecified source */
 	}
+unlock:
 	rcu_read_unlock();
 	return rv;
 }
-- 
2.47.0.338.g60cca15819-goog


