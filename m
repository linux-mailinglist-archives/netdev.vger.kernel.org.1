Return-Path: <netdev+bounces-200827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D53AE70AD
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509451BC514E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12072EE97D;
	Tue, 24 Jun 2025 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbvRqzSE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA34AEE2
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796800; cv=none; b=dPFsnUp7ZelTL3lXS38vvL/g1a14oXtfxZOcqiJLYoDvEg+CF+34IJVCX5+9ceTvHMyjyrEz1s52hCccAYsv0HzNGBhFcpofGdyXaQcg4mtaEL+XCzZzhBaPKWk2lU+hIKllQdgmUy5nov3Ev/3XiUfmClNym6JtzA5XaLfvcu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796800; c=relaxed/simple;
	bh=qWCadS6zpwKHoPD1VXARS19acm6wvIxhJCs81GwvxkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDfqJXrywtrkSJ2eNVTCuTvvE8gOX57WHNnUQjGI03EZ9y06py9RLP2gDeWM+EWKlFdrMvhP/bRL5qKOcUlY1WTremcOHia3Ypbhv+QVG6MqlZgHK8NIAsKDxb8mBymfV85kRKj9iu/Ktk2kEKNfRN/4AaFjYrDhtDAP9gJWMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbvRqzSE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747fba9f962so150677b3a.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796799; x=1751401599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k81/zZet7xKjKoA4z4lBq2BMh0YbuTVBolDHqaFUO0=;
        b=nbvRqzSEoPmIKkf8/JIVTBCGD5DhaQURqV5UoB0yqYLwaPDMz67hA8GGK04v6LyGsL
         NciR/uS0+l/IUo3EFLhkHt5Yj68PuXhAu07MVgadl0KFT+PnWzPfK3EVqNAHDLdnlI7m
         pYWswd2+GxH7dFQqmQOOlHSHbse9+0+Tze9iVkLJqRy4lNqlO3+ylEMlaKLwQuZHDkGa
         0qIfe/wBOswbx5U/B0x673IdJ7ij79wakqmUx0JOZbSWRR5j0cywwmNmfIZ6oR3gC9a8
         mUgKTDCfm7Bicn5HmKBUIurG3qnsqEmSjqZhCA8tovrZUQVfyzCsX4su0n8C6UR8Fmiy
         ryEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796799; x=1751401599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k81/zZet7xKjKoA4z4lBq2BMh0YbuTVBolDHqaFUO0=;
        b=Nst5FgTbK+aIy/S3tZFGS/LitirobqXc5elRZ9C1tfR79da2UMuKrvctUIAWIK/ElG
         L3RzMzJcHBrfecOl/mke+yp+GoTw2hj7HE5wvyImvA5OeFBa4W8CHKykArO1vAjlevW1
         PQiFUXMVBjfXb9RBdlRtqVxsv5o2TYWiz0y4EzSX7c1AKuqvtViAq1fd4HtUk9q/T7ON
         lCR199TXfqlJrXkpwH9WJhU+9Gsm39iorF6pF7XuHZJuT+OjDDjdC3ixTioNaj7viAQo
         2duW2SWEvvnl91naNRDiq4QXiObdwXlnYemkn8QyjiIsxpxELJN/OBb1GA4VoUOfD3R8
         Lz4A==
X-Forwarded-Encrypted: i=1; AJvYcCVE6aDMF/jp3B02S9Ug4VmJTiTu/d0gPBxNugA0BaCmrvt6PgIpkyPQhX81E9nw8KOphDkXA20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYhNguQSCzlAfmDY6wP0+WtmASrs6N4HpdMJPnypdbIKnvGHg
	fkjawAg9I+GeYHOzKX+xEYwf5M7HJriPlDhzMbUlxSPW/MKBxoZ5hMs=
X-Gm-Gg: ASbGncucD9MclY9Lc0fhX4eOourx84JFi3g0ZGl9DEQqpIcBoRi6xNTEMnKXUgkz6aD
	ULgRBGBjmSXrpwlb960EEZGAu0tCwb0KpiFvih4EkWlb17TgreGPJuz4uGtgY/OBWIW2LLW8dxa
	7gTlJtke90cKaviapNquP1Xan6C9yXxlbOW+3okskMXrapDvD8LtbJssIC7AP4wxMWAxWPS1Xp7
	LJJcjCq73jS33L2MZMDGgwb6008AHINFB46waqQ1ymGc1IY8/pgii22kOBAvUMWCt+6n9sScH0j
	H5L1EeebGDFh4czlQnQzUckpeo+s7K6Lwkf5r3s=
X-Google-Smtp-Source: AGHT+IHWH23nHbGXJCzS5rJjY+SzICoJhOw1iY94ClOsjoK3QoOYt2adcqzGWn8rKYVhVgw4ZZhEIQ==
X-Received: by 2002:a05:6a00:698f:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-74955d9b95emr5723844b3a.9.1750796798687;
        Tue, 24 Jun 2025 13:26:38 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:38 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 10/15] ipv6: mcast: Remove unnecessary ASSERT_RTNL and comment.
Date: Tue, 24 Jun 2025 13:24:16 -0700
Message-ID: <20250624202616.526600-11-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624202616.526600-1-kuni1840@gmail.com>
References: <20250624202616.526600-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Now, RTNL is not needed for mcast code, and what's commented in
ip6_mc_msfget() is apparent by for_each_pmc_socklock(), which has
lockdep annotation for lock_sock().

Let's remove the comment and ASSERT_RTNL() in ipv6_mc_rejoin_groups().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/mcast.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index af322a455346..dc363a6c0b7a 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -605,10 +605,6 @@ int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
 	if (!ipv6_addr_is_multicast(group))
 		return -EINVAL;
 
-	/* changes to the ipv6_mc_list require the socket lock and
-	 * rtnl lock. We have the socket lock, so reading the list is safe.
-	 */
-
 	for_each_pmc_socklock(inet6, sk, pmc) {
 		if (pmc->ifindex != gsf->gf_interface)
 			continue;
@@ -2880,8 +2876,6 @@ static void ipv6_mc_rejoin_groups(struct inet6_dev *idev)
 {
 	struct ifmcaddr6 *pmc;
 
-	ASSERT_RTNL();
-
 	mutex_lock(&idev->mc_lock);
 	if (mld_in_v1_mode(idev)) {
 		for_each_mc_mclock(idev, pmc)
-- 
2.49.0


