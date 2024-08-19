Return-Path: <netdev+bounces-119732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3AE956C6C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58097281F3E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6E616A920;
	Mon, 19 Aug 2024 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCqyE7xu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA1716C878
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075317; cv=none; b=sXXB2V354sROPXTOHvJ6cXzZKvQsNw/gvMRbMOPxyPlH9bVRS38hnh+O0Xts3x/z0jLzqIxTPwjDZ2EJGFUpqZGCy9fWWFQYNCVeslxLRfMfgph7dlJkQSNYqwYW8cPzuKGlOigctjybLrbSSXFPcBBoFG3S7LJBWUByghDYyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075317; c=relaxed/simple;
	bh=Y4hGCxetNt73Skor044rWJoEoVzYYo8TWAjMP7ACwhk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pI0MY7BDLeomoHoZnnOvOFxaMUZ2X9PsSKhv3KJINYqKM196MCYvrpWcB2MtFu20uEFfqeNBj47by1fRpf34V/RQ6bqAhkAPG6e06wprw5rETSn9VEcImY7UNIosbTzfBFkYX5TKNszMRtcOoTOoctibIMVyFEjh+a0P4rJU5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CCqyE7xu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e6c47daf7so7676487276.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724075315; x=1724680115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvqGpM0h/qdAIJol5Gfs5tJe3uKQPYkBiwYr36sgwxg=;
        b=CCqyE7xuVoUhV5N18wGTeIEjZ8zpn8ygo+iUPMvI25ZTv3ZTRCX6VwwMLEU8NqmMuK
         Dy/guw1cCkGkRcnx/aVFb1GiuZURNd/7C4VnuRZVNjg/N4QBliusbmMFjWz/H5stC65W
         z8VeDYs5Ejr8soNP962j/nyiNdGftAvDHxCwiB2fIkgFyCWHWoc8/fiMds9PD8f1Waqe
         UrfiqDioabIFT+Qo4N3ODEQLrHxSSb6hqNYJAXEBftg0EML8pUc17qpT6hNLoHjzPiE7
         2gSf4mY0yvh58C9xmBfOeTI7WLUgAskXmsW8v9FvBxiM8e0h6L4b2eWLpN+Ck4PrWWEB
         iAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724075315; x=1724680115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvqGpM0h/qdAIJol5Gfs5tJe3uKQPYkBiwYr36sgwxg=;
        b=H+7JtPYTzpHiDUw3MM7nabjoCbKKcvk8dAqYw4xmj7kuGoXxKzbpC5nIWF82xoLp07
         xbg5fzhF1rjh0ySQT14QIx/zp7tlMivXpC2aCP5jBKnacYNX26cZTsQxtKyWVmWRkGPo
         33OZqi/iK9wGdx5saw8pqZyjO7Psn/Rawco6i8PUUAwb34XVNnLxkIXhFxK6janjuOnu
         VrWLGgC9iwVgvQ60W3aXyE2RTOvNoat1ajwnB1D0XkhUlUADSEjGH0LUU9J4y+zqzGEY
         qHgPTdblq0HkbcBZJ2ujxgnyGQF/n3AM3DKyXjIpZ7pMDuKCmOX2R7CL+4kIXHPsmeM9
         52xg==
X-Forwarded-Encrypted: i=1; AJvYcCUqpbaLu/mfrsrAgG2wFWxPaO3mbGG7HA88cVUQdgr+c9yPHL882WlGdUfuQ4X/xREe38GfmcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSmUelqnBiPSgs3DItX0lpnEx9+7pAsW/7EOtvONgJ9xMJT2E2
	+X0RDv+OUdUHT6hktYMbadysymRF47oSc13PCrrmH2B2xaVvrm9FDBe1wC8fxmPmeOlbXj30gNx
	16POBNJEtbg==
X-Google-Smtp-Source: AGHT+IGZD1gVPENYM7CgflaCSnYb2hogtEPle4dFrn5tc1whAmMf65DMlq0XmVGhYB98vWzfFV68mWuuXRVELQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:6950:0:b0:e0e:4598:f17d with SMTP id
 3f1490d57ef6-e1180f5fc25mr15777276.9.1724075315102; Mon, 19 Aug 2024 06:48:35
 -0700 (PDT)
Date: Mon, 19 Aug 2024 13:48:27 +0000
In-Reply-To: <20240819134827.2989452-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819134827.2989452-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819134827.2989452-4-edumazet@google.com>
Subject: [PATCH net 3/3] ipv6: prevent possible UAF in ip6_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Vasily Averin <vvs@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"

If skb_expand_head() returns NULL, skb has been freed
and the associated dst/idev could also have been freed.

We must use rcu_read_lock() to prevent a possible UAF.

Fixes: 0c9f227bee11 ("ipv6: use skb_expand_head in ip6_xmit")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vasily Averin <vvs@virtuozzo.com>
---
 net/ipv6/ip6_output.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 1b9ebee7308f02a626c766de1794e6b114ae8554..519690514b2d1520a311adbcfaa8c6a69b1e85d3 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -287,11 +287,15 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		head_room += opt->opt_nflen + opt->opt_flen;
 
 	if (unlikely(head_room > skb_headroom(skb))) {
+		/* Make sure idev stays alive */
+		rcu_read_lock();
 		skb = skb_expand_head(skb, head_room);
 		if (!skb) {
+			rcu_read_unlock();
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 			return -ENOBUFS;
 		}
+		rcu_read_unlock();
 	}
 
 	if (opt) {
-- 
2.46.0.184.g6999bdac58-goog


