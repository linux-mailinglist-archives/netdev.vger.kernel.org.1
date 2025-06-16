Return-Path: <netdev+bounces-198336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B81CADBDBA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E9C3B30A3
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89505238C0A;
	Mon, 16 Jun 2025 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHtsAfXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B07723815F
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116893; cv=none; b=KjUDsDjYPBvwi2cNNl70R8RwpGuV9M6aNtx/jHOtcMIUJlk7j/HAq0jO3Jc3etLAaom0efIiJnqWU7jYHzWveLBxO2xFaelWt+arYsOmVkgqbfHTxZUKgCYxeu1c4QmqZuKplE3EAtH4EVbMCXOyJ/oCqMoq2nv9URICKapSO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116893; c=relaxed/simple;
	bh=uaY0lgJw4n5rlqzVymtfQKPQdnkO6wz0wzv8Qfs/wxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoDXBRSEUKq/6kegMWrDNNOsM3k4qCWDpHhtHIoFU5Y9vLgwU1pc41nJJS0NQlZPP37epg7kVsZ6NhKYVPDZCd8+Cno1X5hTBNSkhOLsK9mlbmVKsdmaFJ0Ny+HBYRJzLozfd9wYIzzlGu4u56GyV2bXPuad6J9PHlaKE6laTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHtsAfXL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2363616a1a6so39392475ad.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116891; x=1750721691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cZG48rsu8II5n6a1CVMjmQUkjiDFw7zAXWUJnb+Vpw=;
        b=CHtsAfXL4dHZ1VqjAeqfZAoA5MyjCR4AlJBj9AEuzP3SBjlHJv3SlCawLyV/BZlFN4
         Bxj0o6OS/hFX5brDfIoP23+JPJy6jbm1bKZAJc1L5R5asSTG1aEgXhwUHVn1hB0z2UJt
         vQNqxKk2vnJ8ZdBo3MzQ1ibAmRf01vGZjuiwCVl7//lBCbRQVPaygMyZPIch4mP09Brz
         tQZIN9OREWBZVlhDaw4ciS2Mf01ZfNMfn99io3QcCT6OtMVZyYAIfqSwsdCZF9XkIJn4
         8umc50VLIL1EjjEDexKQ6/Gw1rS7s5jRacN5/sT7+cxXmVgGg0UtyRk8wBd91AQK3eQQ
         qDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116891; x=1750721691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cZG48rsu8II5n6a1CVMjmQUkjiDFw7zAXWUJnb+Vpw=;
        b=cmf6ILMHSXhg6IMywWApx36hsgMz/dzJE3sRm19bXFUz3W4YllwcBhXWAhCQhxrIpA
         CgJDfg6d+S474/DuAG7z/iHfkSLKQy77ljWbrRXPhZj1WXRhouSGrXllEkZmr9lvFnBj
         AiJnKw7iXAWJNKK23kag4sHo5+sJXuZ0h8PZ3VAm1KR2WaOmO0tsSlEHZerGh0IYZOWn
         TEh/tj7D3CLcqs8hgTSwRw+ZTikAbkYMvD9c0RyU0JixLP362302Rb6cNbH1VLgi3IrA
         5ujvAy/BQbKxRPqc7LgUM17qgSGcXcIdRsfgUBNV9/63piKiF16M1q+iQzLWapEbUB7N
         s1xw==
X-Forwarded-Encrypted: i=1; AJvYcCUKEjesklyPiUSRjtYGpWs1NruVbKfEv5T1mSexnEqVg64/0W3kvRhN3naGxIAR/7BEPUY/vCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrLXE9F/VUJhZXRt9dWF056Eme2AZ4bHg5nNJ0Mf7fMnn2pSr1
	UZKqR7SfArV1/WukZMh5YuCkYRdLX64rLMLBjQB4jnLWtYqUIjljO9s=
X-Gm-Gg: ASbGnctb6Y/dni35vKk4iy1WPUz2bGJNjH+YjoG64KTTjUO6aK7lHuLGi/VMD+Ewz4n
	zxgFg6EdxUVBHu1bpi62BWIRIZDYYlvHNFoHpiyaHCWf86ruTsfTU3xAOvyvsxl7nJnRN9uXmdx
	BkzpoGsG+YD3jNfoCRp7aO8V16dk6IKf6/YcN5BPX2TWqBeynlYYBqqSEJl8GXFq6hZMCnU0cmK
	gdVKpbztZOWeMEr8jxFs+12mlQt+UHDbxaLslZRaMb7ueWE2XuhM0phfRUR5QWo0fai097c4hjx
	BLvOe/Lf8ktoTVeDyXDC7FOPV435AShX/UY77to=
X-Google-Smtp-Source: AGHT+IGKJipGeBRdyi41G64DL/r+B4euUyH2HuPBsziZukHweHtp6j9NUtd08cAleQigHVlrmRVQ4g==
X-Received: by 2002:a17:902:fc8f:b0:235:6e7:8df2 with SMTP id d9443c01a7336-2366b14e74cmr184506755ad.41.1750116891356;
        Mon, 16 Jun 2025 16:34:51 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:50 -0700 (PDT)
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
Subject: [PATCH v1 net-next 10/15] ipv6: Remove unnecessary ASSERT_RTNL and comment.
Date: Mon, 16 Jun 2025 16:28:39 -0700
Message-ID: <20250616233417.1153427-11-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616233417.1153427-1-kuni1840@gmail.com>
References: <20250616233417.1153427-1-kuni1840@gmail.com>
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
index fd0cab5066bb..c441204e7c8e 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -600,10 +600,6 @@ int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
 	if (!ipv6_addr_is_multicast(group))
 		return -EINVAL;
 
-	/* changes to the ipv6_mc_list require the socket lock and
-	 * rtnl lock. We have the socket lock, so reading the list is safe.
-	 */
-
 	for_each_pmc_socklock(inet6, sk, pmc) {
 		if (pmc->ifindex != gsf->gf_interface)
 			continue;
@@ -2875,8 +2871,6 @@ static void ipv6_mc_rejoin_groups(struct inet6_dev *idev)
 {
 	struct ifmcaddr6 *pmc;
 
-	ASSERT_RTNL();
-
 	mutex_lock(&idev->mc_lock);
 	if (mld_in_v1_mode(idev)) {
 		for_each_mc_mclock(idev, pmc)
-- 
2.49.0


