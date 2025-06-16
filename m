Return-Path: <netdev+bounces-198340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E8BADBDBC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D20176298
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AF023B603;
	Mon, 16 Jun 2025 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/bgB05F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF723B615
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116900; cv=none; b=bXUmG86xNnOl0NITS6Ewqd8o/ZvAZfpOIAoZVxTdttGNoNgoBgfgIKBF7IHO4l0yJCV+4XPPkzvTk5mqTYB0ZorxcDlgz4qB5rwpkQGAu4c+EMnFC6iv8a6ZkDSx4Yvr3E0f/3rjXXCBfl/K9fYfB/x7XoqzcmwoWeBNpc7Ult4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116900; c=relaxed/simple;
	bh=j3MwJPnnXdEgSwMmnaz//285VeQmMRx5hMJRFY4eUmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oo1hT82XU+Sq8LsneIo7jO/LJFnHz4XYZdMc/V1C8VNf4qZ6TdoV+2w5P0ajKFlQNR+Qo/5fIw9n0Oknk3Kb+ciF1uQuo1zb0SGCDIGplloNFX47+M2yvpH5Szs4GPnrDCVQMpN+dmR/LyqkqwH+8JnvJhcGyG6JKveln9nYL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/bgB05F; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2366e5e4dbaso19789875ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116898; x=1750721698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuzbjsS7sm302d5GNKWLUffu44bgJ1U1ctSy1vAFhnU=;
        b=V/bgB05FmnDLuBZLUnCrmeOCqvQUFLTQSZaOlYG0RWRVSG9UODj9AiMlyFRJ1I4uwG
         ZebV3ymxL9jxe9QkiAc/dQz955SVE6WHQIKi/vNV+FzR8G2qknlALZf0FJd64JZYxbfQ
         lPT3DQYTTQWHPdOFSez2NcVwcOx1WFmT9G4BS4x3pj2VJDIbN4U/YAFbltaEIWgmcUAw
         fSoOshrtffwVojVDSIPE+JUzNXUOnp6qgZpNyQV4zoGBpqAd3DV8Srrq86HLAdV3VPPC
         VsaJYaG36Na50VCTBuSnGgXCvReT45G5Q4Qdrn3qpOEWCYqMVCVO+eLfcBcXlvMHVlnk
         Okzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116898; x=1750721698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuzbjsS7sm302d5GNKWLUffu44bgJ1U1ctSy1vAFhnU=;
        b=QjY16LVIv9AKa3mstwbF4mi5HmsZyUCHePjXg9eR/Ty4BtD86Qy4KamQUb7wFyLxXQ
         fKIToktyPWNa96FVY8dRjm9NCp30mPLndh0layvwBS6QFoqJReiLiuz75/t6+Y1mYG8h
         b0Ck7fDHmlfj0OR00YDLAOgRtaw0kMtoYtf62QTdyJWr8xOlV047oUp9mqTaPdq+r3R/
         5SrThTntvKxkiPVhE5NV5C02GKcEl/xdIUy2OR+gwlnaCA+oCnnws3O9hne4qN8ryMP/
         Ii4kzi+BNOL0y08t+pC0ouQkWFA+f8j43JIsgIjPV/YNpOycpdXJndW2Oi4UiAycvDB9
         Fcsw==
X-Forwarded-Encrypted: i=1; AJvYcCXLv8tMWv+cL4AsO6qOXpNODb/dTXPknDxO+nuU7FEJO1EgGV9F1x+9Qpe6kQSbfp7GLeThy8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxlFAjvXoV52Gcdhh+ugvGqNMLgFW75Ltp7qtJu5SQZFvH9bLZ
	wahT6d5J/lBQs72N29e0RjImLEqTbLAOnse6eZMekW4Xe51A/vMkD5Xiz8Sil/tX+HcE
X-Gm-Gg: ASbGncvj0qTWDb2ZWq4mtspB6P5lvYnb5LYJlLTJndAYXWgYeWZbVf6IfqPOd7/KuZr
	qWSgbIDwDhvvipWpua8olDR/h+ktCml9u61yEGfzq8zyOHZ9qHhgUFsJDuAoTCFQOpdE54biTvb
	+Y5/eXDkGiQrAOMfpxTvV15zmeGJN/LlNsAhxX/+SeU7xWf2PLY4K1v8U9FkzPA/xKw7Mpnax/h
	1OWu/1kJedyvSg96FG5/drgkESHV5jiyA0M1IVnooUWOJdIN+h5Uz2JOHjZoSNK0SfUHQcpHlAR
	gjTAqLEaNReIzBzpwVKrSAZ+ITmoScAzU5GcLb0=
X-Google-Smtp-Source: AGHT+IEkDWasOwrPD0Unvf4T2qCSV1anfMas+vWGSKvQjFMRvfo9kZs3gjDAJVWlP45X8wDeGSGXHQ==
X-Received: by 2002:a17:902:cec4:b0:231:9817:6ec1 with SMTP id d9443c01a7336-2366ae551a4mr164105575ad.17.1750116898196;
        Mon, 16 Jun 2025 16:34:58 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:57 -0700 (PDT)
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
Subject: [PATCH v1 net-next 15/15] ipv6: Remove setsockopt_needs_rtnl().
Date: Mon, 16 Jun 2025 16:28:44 -0700
Message-ID: <20250616233417.1153427-16-kuni1840@gmail.com>
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

We no longer need to hold RTNL for IPv6 socket options.

Let's remove setsockopt_needs_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ipv6_sockglue.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 702dc33e50ad..e66ec623972e 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -117,11 +117,6 @@ struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 	return opt;
 }
 
-static bool setsockopt_needs_rtnl(int optname)
-{
-	return false;
-}
-
 static int copy_group_source_from_sockptr(struct group_source_req *greqs,
 		sockptr_t optval, int optlen)
 {
@@ -380,9 +375,8 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net *net = sock_net(sk);
-	int val, valbool;
 	int retv = -ENOPROTOOPT;
-	bool needs_rtnl = setsockopt_needs_rtnl(optname);
+	int val, valbool;
 
 	if (sockptr_is_null(optval))
 		val = 0;
@@ -547,8 +541,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		return 0;
 	}
 	}
-	if (needs_rtnl)
-		rtnl_lock();
+
 	sockopt_lock_sock(sk);
 
 	/* Another thread has converted the socket into IPv4 with
@@ -954,8 +947,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
 unlock:
 	sockopt_release_sock(sk);
-	if (needs_rtnl)
-		rtnl_unlock();
 
 	return retv;
 
-- 
2.49.0


