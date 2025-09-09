Return-Path: <netdev+bounces-221345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F08B503E0
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924421C81188
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97443705BA;
	Tue,  9 Sep 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="OyAMtt8x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44333472E
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437230; cv=none; b=ZEmt2h8tPiz/kSEpSyIKm3FR0yXgZIxMM6hrqYg2y4yaYGkn5C39tIP+hhSZNDxLGc3QQZm4/FtPFlUanhdoY4uXDO5b3G3bLlurvAatBGXp/A4NZgxdjo8+vrtmxAWA9oV6xiZ/fNWWc3Dg1FhTGq6xHD840c0tUgnl1e/ItIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437230; c=relaxed/simple;
	bh=cv119VLeAcmNb/qJGh3WDTAtjju8VwUWX4BeK2sxKzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EB18eF68DlhDExahwcQcXexG92B/92HyvZ1NyJk9vOJKhbI1AGQabLG+MYFBFcTkLfc2PfY+iiRaq2vqqIMnqGfQp5NwKfSTXvUgt7tP6aWM87IZPyBPmBSqWFxfbBls3zUe+/WbSftMc/vC/0aACVtpdbuTbkcW3QpxI52J1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=OyAMtt8x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24cda620e37so12180975ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437229; x=1758042029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9Vzetl/ylsM4DVd3ZILCWxs+8BnbwOF+hp9Xl0DByo=;
        b=OyAMtt8xu1yaRjKEGqkJjH4dJwNkAGM/rmoeHhPTlRkDoW6TNyORQULyG5veAVLSB8
         uDvJKPjsX4XJm0LXytPN9Cbf/1Xyp3KIeVwGycpo368TyzcqBQ4kiws9ynmdWOe5e204
         fOF/EIJSSHmSySnL3zwJJXMyr+cESXAeM2gSuj/fsHVpqEfoDxsq7Xj1RYdvqiFK2NVq
         OyiyXx4f/NvUJ6+3EfY4pZ45/HmCWCbwUF8MuIUrS5ftEB6yb0hTsWX2OvNAtQ9CK4ZS
         Kk9LX/dwd2Dm809IZXHyMORS09kafoqllMc6BzpOhHd2tclORT98oDTjXFnDUabnVBWH
         TtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437229; x=1758042029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9Vzetl/ylsM4DVd3ZILCWxs+8BnbwOF+hp9Xl0DByo=;
        b=cjpITipapekcFOQag+sRn/TBY8A2ryLPe9Pvtpabgl77v7Ij93Ag/NghmTX3c5zc3T
         Osj61+0/Y50crrRsQapI0kvrF7EpujjNolibOEpzBAUxB1DHB3/EufonKWdgMnhTrNrz
         hU/Jc9ddIfw7BwQDMmh0aD4xH6ExkNV0QYhnQufBaVd5e9S1IbORx5h3+VSg0OP6KyWx
         6I6XEZRmwPhz9qhtvg/6MfBeoR4yGZVKb1fSiBkuqlSyNSdkkaUq6AFBUvXQd4OD/d4i
         DGyj6YZqVE2P3JAPGIq+5Ttm/paFcBPJ3a8I+k8ZwDyxZ6m9X2y5oJ/ujjQneXv25D6B
         qFng==
X-Forwarded-Encrypted: i=1; AJvYcCWKON/xs8Nm4i36XgFptEEGkhKM9k/7Do5HT1gy8i/zodu2eGYOBrxnPJKl3/mWI8xXk3fPs4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbStRDxJSCJoGvAyIe/K4k6OeJsDtooWi9KoghnK6NZ2E+8G3
	khqo7KSEgUawi0YGcqpYFo1DbZU4M+pOyq+VO5dxe5pb0b9bKswGNpyMhvcFE+NBOIQ=
X-Gm-Gg: ASbGncs5S1FBZNMM5RgSOv3XrKFk5QhpAGm9Bj8+pUu1iA34sigFYwiwkDHs+h4GS56
	AxVYt+POpARjYghx555GEysK8kQatIJfXPy0cVuum2MdQq5AoroeG/evssZGeEodOeKX0mZD4p5
	6FbfBgSo7T1XvJ/fS+pfy4VLIO5/oA+LYAXLVuOEKpE1i3+qCF0FtcPivSuMMxid02GlllFKo9c
	Pg0cDm3CmC8pbwL47cWZuxEuX3B3d2fo03nSxFqgUi2jwPrXOsJrY69gGBDzqD7cQCMUe8rv63v
	uoxitc8ZzlYwy4iCX3X1qfS8AeBaDwlFCeOPJsT7OGB3OmlrTxinulsKy4NAvajqjOULj8tclfP
	VPSIHfdLXck/zwuh6Iw1e615t
X-Google-Smtp-Source: AGHT+IEQ1t4H9Zey8QVifruYm3QmfhK9KKPPee7UJXmXearXcugjx+y3R56oCSrwvSNwqWNlw9FQ8A==
X-Received: by 2002:a17:902:fa4d:b0:24b:142a:c540 with SMTP id d9443c01a7336-2516ed668admr67582855ad.1.1757437228571;
        Tue, 09 Sep 2025 10:00:28 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:28 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 04/14] bpf: Mark sk as PTR_TRUSTED in sockmap iterator context
Date: Tue,  9 Sep 2025 09:59:58 -0700
Message-ID: <20250909170011.239356-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow sk to be passed to bpf_sock_destroy() by marking it as
PTR_TRUSTED.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/core/sock_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f33bfce96b9e..20b0627b1eb1 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -2065,7 +2065,7 @@ static struct bpf_iter_reg sock_map_iter_reg = {
 		{ offsetof(struct bpf_iter__sockmap, key),
 		  PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY },
 		{ offsetof(struct bpf_iter__sockmap, sk),
-		  PTR_TO_BTF_ID_OR_NULL },
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
 	},
 };
 
-- 
2.43.0


