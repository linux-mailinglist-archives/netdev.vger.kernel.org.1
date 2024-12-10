Return-Path: <netdev+bounces-150805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF189EB962
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057A11622E1
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F69205513;
	Tue, 10 Dec 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxLSOj15"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FEE2046A4
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855640; cv=none; b=latNAPu4p1epfTvNaDrUwCG4qoc1jxrFhL7KW+0OU21WN6S8gaHRWM4qg6rZMRikYmsfD8VxRztcevLiW09nS5V5PgDGLlCNLqw2wGkLBwinJs6Il+L3V04liQtt+wetE5nzKlqTfn3jjBgtxyW+G/4F6lWeSYLzWSF/qrhUtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855640; c=relaxed/simple;
	bh=ibvCzsizK1RaQ7Ll1IRehDinyt0iS5BFqbdpRJIcTyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NZl1JaLorCR3s+1ZwCN75c+5Fvplzmeg6I+ZEYvr4Xdcte8gBuOuiAhSf2sf+SpTWHQFNnwevbPk9lFtDZMKExNU+dUDKriCGoN9cFYthC/k3a721xKtBtRrps6ssXIYKVPt9rPiI3Ly7GmuzmYd6jXwKpTPrJBfKiYUE5rgs1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxLSOj15; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-46692410a9aso75951141cf.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733855638; x=1734460438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xXqiIj8IXUOV3LOAytlOmI4Ng6ybFQRXpjF1KZgWC4=;
        b=DxLSOj155TUy/3YMHdImH0Tbroe/P5y5LmfSlPVOha4Wk/JROglPik5CpZNrqZQ1kG
         KRODHJ7PiyJYuDC7SJfdgRPGdgIDViyXRupPkVEo8O/iWqqAyBL7IUW5/pUU2Nt5evUz
         YnB0w543SYZWO0BHzabf6i0CFwVeZn0jq4EhMDcggBA9N/sGJ2ZBSVIYx+538ubCNh/M
         M86UyTY+7iwCWpRed8rdiUJ35Z6I3HjKlNXuLN6+fSQ2QcwSCE3tY42w6b3OMnRoWSAp
         VonpkLml/6cEJu0RrC9VuRgzoxSlNIgsOfKJgsOfvkmCVcb753juHI/9Mrd8m5tZ46/l
         NRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855638; x=1734460438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xXqiIj8IXUOV3LOAytlOmI4Ng6ybFQRXpjF1KZgWC4=;
        b=lYd46W+N1FDI90px90PFx476ZvDfdZa4eo37UnsOYNjtcJ7EUl59+7gFwSsWSdUsPs
         iJsEMBZTLhHCnKiQuEUGZTg7qz3dEGNkm8XN6qjfSC6ihyAwCR/dd7DE4mrHhNcFoZfZ
         fOP0k7S3F7nnjbZEaLhiuGkCKWUc1t20eYoK7P8tkZERdW0XWBWfJkb8Wua2gyU8FPD9
         1aXi984FW6Az/kBZE2QhkOgw6PdafnI62ekw9/VgB4LsQRJ6Fb7WJJuRO2AroQYFSmRf
         FPCnB+fsKfpVOByujewoxG/ICvB1NG3pkwSeoL6q+/EqvWfSyeVNx6K1RzPs1IWRXtzM
         VXog==
X-Gm-Message-State: AOJu0YzFGK/djATEj0rF9cjxegjFIvHkDARmStWuGPavhGMlpqFMwXOI
	lSfLjwVzNsf63DQ8puzBV3HRCz65bZe4bxhqZ0BvjxSa+4TPh/A18RNi3mn8nuaKvvjFFcWT7eL
	yYyJrn4m0Cg==
X-Google-Smtp-Source: AGHT+IHEcqHgrFK4h1+nwSA+jXs3GGkQsfOt/uZnL1OTKx8ZfiKriIf6ZO1s1tmV3+BgTjCKNkFXU7g5ltlk/w==
X-Received: from qtbcg3.prod.google.com ([2002:a05:622a:4083:b0:466:9f81:8c8c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f48:0:b0:467:6375:6884 with SMTP id d75a77b69052e-46763756f4amr116957951cf.48.1733855638303;
 Tue, 10 Dec 2024 10:33:58 -0800 (PST)
Date: Tue, 10 Dec 2024 18:33:52 +0000
In-Reply-To: <20241210183352.86530-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210183352.86530-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Message-ID: <20241210183352.86530-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] ipv6: mcast: annotate data-race around psf->sf_count[MCAST_XXX]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

psf->sf_count[MCAST_XXX] fields are read locklessly from
ipv6_chk_mcast_addr() and igmp6_mcf_seq_show().

Add READ_ONCE() and WRITE_ONCE() annotations accordingly.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/mcast.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 09622142b0705bd81491f148dde4612c0f8fddb8..5ca8692d565d5055eeebef2a547ced217d81c7d4 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1037,8 +1037,8 @@ bool ipv6_chk_mcast_addr(struct net_device *dev, const struct in6_addr *group,
 				break;
 		}
 		if (psf)
-			rv = psf->sf_count[MCAST_INCLUDE] ||
-				psf->sf_count[MCAST_EXCLUDE] !=
+			rv = READ_ONCE(psf->sf_count[MCAST_INCLUDE]) ||
+				READ_ONCE(psf->sf_count[MCAST_EXCLUDE]) !=
 				READ_ONCE(mc->mca_sfcount[MCAST_EXCLUDE]);
 		else
 			rv = READ_ONCE(mc->mca_sfcount[MCAST_EXCLUDE]) != 0;
@@ -2287,7 +2287,7 @@ static int ip6_mc_del1_src(struct ifmcaddr6 *pmc, int sfmode,
 		/* source filter not found, or count wrong =>  bug */
 		return -ESRCH;
 	}
-	psf->sf_count[sfmode]--;
+	WRITE_ONCE(psf->sf_count[sfmode], psf->sf_count[sfmode] - 1);
 	if (!psf->sf_count[MCAST_INCLUDE] && !psf->sf_count[MCAST_EXCLUDE]) {
 		struct inet6_dev *idev = pmc->idev;
 
@@ -2393,7 +2393,7 @@ static int ip6_mc_add1_src(struct ifmcaddr6 *pmc, int sfmode,
 			rcu_assign_pointer(pmc->mca_sources, psf);
 		}
 	}
-	psf->sf_count[sfmode]++;
+	WRITE_ONCE(psf->sf_count[sfmode], psf->sf_count[sfmode] + 1);
 	return 0;
 }
 
@@ -3079,8 +3079,8 @@ static int igmp6_mcf_seq_show(struct seq_file *seq, void *v)
 			   state->dev->ifindex, state->dev->name,
 			   &state->im->mca_addr,
 			   &psf->sf_addr,
-			   psf->sf_count[MCAST_INCLUDE],
-			   psf->sf_count[MCAST_EXCLUDE]);
+			   READ_ONCE(psf->sf_count[MCAST_INCLUDE]),
+			   READ_ONCE(psf->sf_count[MCAST_EXCLUDE]));
 	}
 	return 0;
 }
-- 
2.47.0.338.g60cca15819-goog


