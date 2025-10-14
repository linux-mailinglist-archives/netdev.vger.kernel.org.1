Return-Path: <netdev+bounces-229196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE9FBD9141
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F14D403E32
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CAE30FF09;
	Tue, 14 Oct 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="whrYiz/X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958E30FC3F
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442222; cv=none; b=QvPzA36JcFfHf3/F/COFMyGPmIYMNMGzTWDq1iGKj7vbm0sUiw+ukVPvHMUezH2LTnzBHsl3xZs12kQ1i1bxkTqlXUiohodANHjHND4NTz+f0EjOg/ryR4ErmNEvuZpU+ZgBOeBjVT8WXhJxFvmIPRWvPC9+GoKjrW5SHPyl5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442222; c=relaxed/simple;
	bh=9Anz8SdWCHj//cI708iSDs2qphpPgNV3XK3W9CnyRRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PE+UShS4Rl0Qr9SU1D7Lv165kp+IbMuhnGRD1RpxYq9UBP5l0YZc2bq+HCxD6SaSlqazMvwiF6P9soS6zPVcgEmwxLYz2KoSuGE0ON4tNhPkJZuXvgwpGWkZP2adL2qKKjHnrhuLgmZUZNflrOgz61ZlPmUK5TlfSy1ch2465Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=whrYiz/X; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3d80891c6cso948710166b.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1760442218; x=1761047018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzi/ei+DoEPQ0UXsEb+6ZYb7S4ThZhfVu5KSSSvXqaE=;
        b=whrYiz/X92bu0MLAMI7oDBmG4J8MsyotukbZ+P9yvz3KFXjkRjiet6ecHeVRQCe7nk
         ZG30hDJPH4FeW9jPnBO4TCFnRZw0anVkNwUTWCMzrk6JowQL1/W9vrvsauMs9BZCjFfH
         7/xwgtIQO+RGWny2R9IgouA1UdCOf4qUcYCse2KhGH4X35rHLuVfnzGb8XmnKC/rjxBZ
         P5c1sFZGxGe/nsba18UqhxbpvFquIdq8ohZAnTFPSI9jEAp2dfXdkD0lm6lfRCbwbnKN
         xWJsqK/ht+fs7XVhe0AoBjLEEi2ZprMmC5Xqz0vnMnoIqAWtr7IUt0kzn2XPvVp16LSg
         +MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760442218; x=1761047018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzi/ei+DoEPQ0UXsEb+6ZYb7S4ThZhfVu5KSSSvXqaE=;
        b=KdT5LrIp+Lt7Xtbxs3Egu5ShyF9N3/3lksKlYTSS4cRrpbcSJr1wwRdKI/DjVhdaL2
         9RT0C+IYlkqvH4ZEtlUO3syN7Z38d3J6lIfRb/uoTYDaAGyWA0cjx9ktIxLyr5I97cEp
         P0uIsDTdK2NEWUhCXvIsgjKxCn8WvI4poHrgXug/nClyF2soUqUAqYb/h1T+NQBkC6zJ
         pTSR2n6d5Qe4zuLpBdP4wOICWrJA9/7Mj5MyQHHlbUhJXwZTq4EXegexiYMhreQ0FsXp
         lNczmc7dLcw4ztKJI89R2AQtYKHjFknPQ6XR/KwgBLrrno1VIjlKuCdaraN1YYeXebXF
         ssdA==
X-Forwarded-Encrypted: i=1; AJvYcCX8wLRmBR73ZN6I7TUSsEq8hh/CwgrVw7AVgT5gIvOOsZkR4j0tyFnycMVLUTs8fk0pCHTWYVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJi6IJGUc0emqz8AmUbTKrLZmtRqWb2dolJ3yobRipFAnqbyI
	xtMGVgzYoJBMSZ24w9+I4NZGbpDnBXqi8q3d41M3YQfvkYehgWsnUvdjNq53jGyknBA=
X-Gm-Gg: ASbGncubScIYYuzpxTZ6IEOTS8BhhoEHiewKawizWbXIhNShPKKV658wdR3jkoedIfq
	32PZWmjwVc1fHMfl2+o22mu/kWlx0d7RYPig0iU42Fjg44FBtWZ25vFLkzYg4m0/s/W2A3+tcNQ
	BTbGSrADIea9rqK/CptJL4yK6xbLhhqR/jsfwS7fSjy/iHLsgOnP8O9elSDBkMw6JD8f5iajCMW
	swsqEfEcbnsVkHowEQkfuaAsLvQJ0CfeT2gYfxYrJjcvvgUv6lpBZ1xQoXv4KmxFEUwhN+yodLu
	Oh3Il6tEueRrLzhgQwifGoVxqRskiUPCyzcOLog6KZRV3a+/XbeS+tpDFWYMx4tvON6hylNmfqw
	AQ5BmeiWjGscCFTenHBJOrWLsNswf+Zb8vlP/fvmveHIzi2WqFHhGkKr8iz7WctkRULXbKOxKeA
	dMgnwOxiCg/LMf3g==
X-Google-Smtp-Source: AGHT+IGZy8B5qcY5omdqnsSW8uejd8MU/DWT1dZAEfS/f9Fb8Rfos0k20W7zR+hFEx57vClHrSnnPQ==
X-Received: by 2002:a17:907:8694:b0:b40:7305:b93d with SMTP id a640c23a62f3a-b50bcbe2701mr3007302166b.2.1760442218015;
        Tue, 14 Oct 2025 04:43:38 -0700 (PDT)
Received: from VyOS.. (089144196114.atnat0005.highway.a1.net. [89.144.196.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c129c4sm1150091766b.41.2025.10.14.04.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:43:37 -0700 (PDT)
From: Andrii Melnychenko <a.melnychenko@vyos.io>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] netfilter: Added nfct_seqadj_ext_add() for ftp's conntrack.
Date: Tue, 14 Oct 2025 13:43:34 +0200
Message-ID: <20251014114334.4167561-1-a.melnychenko@vyos.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was an issue with NAT'ed ftp and replaced messages
for PASV/EPSV mode. "New" IP in the message may have a
different length that would require sequence adjustment.

Signed-off-by: Andrii Melnychenko <a.melnychenko@vyos.io>
---
 net/netfilter/nf_conntrack_ftp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_conntrack_ftp.c b/net/netfilter/nf_conntrack_ftp.c
index 617f744a2..555ff77f4 100644
--- a/net/netfilter/nf_conntrack_ftp.c
+++ b/net/netfilter/nf_conntrack_ftp.c
@@ -390,6 +390,8 @@ static int help(struct sk_buff *skb,
 	/* Until there's been traffic both ways, don't look in packets. */
 	if (ctinfo != IP_CT_ESTABLISHED &&
 	    ctinfo != IP_CT_ESTABLISHED_REPLY) {
+		if (!nf_ct_is_confirmed(ct))
+			nfct_seqadj_ext_add(ct);
 		pr_debug("ftp: Conntrackinfo = %u\n", ctinfo);
 		return NF_ACCEPT;
 	}
-- 
2.43.0


