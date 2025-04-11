Return-Path: <netdev+bounces-181553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E7A856F9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699324634BA
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7296F28D857;
	Fri, 11 Apr 2025 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1Gx077E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3B38FB0;
	Fri, 11 Apr 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361437; cv=none; b=Ym6B7F/12GNtit//F1L2gschjjA7mJAnJPCgtE7ZmC7OYSuTKE36953NflSN+NeU0uV0tOqGUTw4/4MdhKYQ7E/psfl/rv2gBBAj2uXOH3/dmZHvGjlF8huqsrx/+j+hYKIQMA6LQmsIAVPkaTMw+tMgro+DUdpWNqE1saOfLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361437; c=relaxed/simple;
	bh=WouuxWKXIXaHJdNjkcZzsFrXBb+9BPzw8tsW2/aQSNg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=pcDKh5IyEVbaQdXdzyPEHXpndwEe1h1ifi/Jl50veEwNrHSQ+Z7WQJ0zmAwUdlTKx+zGqZqSKbfo4y3N9e4rE7W5k9dqjlnleEMXe6c2qfbOB2QVVfPO+LAPlLh0dgV94kkUDLMrlrpQQaxHAdMhzLJMXQm/Qnaes2lluuqiIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1Gx077E; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7396f13b750so1702712b3a.1;
        Fri, 11 Apr 2025 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744361434; x=1744966234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=50hxH2EGQQWIvDNzL74QsMeOx3mDaobRYvxxKWb0q9Q=;
        b=B1Gx077EiOMS8KuT7Sler6mkNzkEVuHgsm1IPdGQHS2Dpj6QzOQLcf5bw0GHGm/CRr
         42NYg6NQCr8js0PH+QdAhm2++yK9JOBTFcStCP38Y5HozPhoZjXzD3gCSsFRaEGCEzL4
         1VjYi6YabCbRSzwHLn5kb8SSR3ny7ELfzWnr8c7IPKyZvj4FXUjhw1g1BbCdv7sRcK/L
         Ih6Dd5bfMC2i9EoAQXw33NT59LgMP4FvzEaBalaSGXdzUUb8BgssXambtAdL7nRJPNEE
         mjIi67HflloYibTRyzn3L4IydJn34eP6SMUpU9TSPQh7KKSiOLvJv7GrSTfPvL/IETiB
         c82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744361434; x=1744966234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50hxH2EGQQWIvDNzL74QsMeOx3mDaobRYvxxKWb0q9Q=;
        b=XgZAWp5F0MD1wI28P6XbAxH+hhHAc3tbxtdwEMYZNwlozU1CFshUYkyT3UdYYserOu
         XOCTDhEeN9wNYC8aXOxDDX2ilZLiCPxrgo0orw+b9iXGhdTdkNheCKT3zwnw0mDVvpy2
         WoxzHKeJs3A/SSorUGFqe53ZRgWKtwROgorXyYglysBmaxFL3XASEAC8SD5Tb/LuC7xV
         Gt0WMO9UyorIWou6grnxd2NeImo5Ml5T5wcO/B+0hvYvrhRizCSnSzC8cELZlPi6PXQf
         n+ddohF9qCw+AMsyZwUidBuEO4svCyefTlSRMoH+rU5R60cu7xO6N9OPr34xcFh/j5tq
         /dGA==
X-Forwarded-Encrypted: i=1; AJvYcCUGrLZPO47y2y0Vz3GAgr7mOBuRA3hTpFWsTxML+7Ldw88fM+mBa5N3pGitlC4jrdogMf2gwG1j@vger.kernel.org, AJvYcCVivIgu+nlj/R9zvDZN6klt1CdVw1ngo84xM4bJDjAGTPL+IbYs1mFF5lyom8jzdfk35ovnnmeCUDuX8K4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9YcqSXcW9+pUVtB3u+0JymdzynSuyopPxXb0OIbY1X0ks0mi
	kuxgkl+qulbTFj3meQCnh7dPsxsgmbzpWtLLzx+jVW6Zf73iRh9qN+lpNbWD+DI=
X-Gm-Gg: ASbGncvjzvXhyZagdaGiUzShaE5tSwTAfB5QyvgiusSwQ7Kfptq1tyAKrwZk0tbsFea
	iCfqQ+dLVquhkOt0vGWNqylIjhmqx3E4/i6/MmkYvV4OeJThTs1JkoYLnawZ4T4sczx0yfYGReY
	s0aRRLl+swQOuQMIUcDM9swfvCv2pUX10JINEm1ZLxiewip90Cfonyt+nls5ghB8dAQfwNSc/Ff
	BmJJv5L+mTVT3bVj9M8lq2xB6xpQC0BdaCfaYSijJDW2/gDTizC693w3i6OUgOE4MjSCjQ++HZL
	cxbKVWYncOadazM97/C86Wb1NncMpNRrTM5MhXjmoi4CN2NEcwOL9xpEPuw=
X-Google-Smtp-Source: AGHT+IGoQhSc3jWyvjX48sioMN0/ipXVqtYmpU0tAQlGvJv5d0IvIcki1JDH+xbY9kZ3dRhOHWHaQg==
X-Received: by 2002:a05:6a00:cd4:b0:736:52d7:daca with SMTP id d2e1a72fcca58-73bd12562d3mr2745388b3a.18.1744361434022;
        Fri, 11 Apr 2025 01:50:34 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:4fe1:c798:5bf3:ef7a:ab5:388f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e34asm975288b3a.137.2025.04.11.01.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 01:50:33 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	tung.quang.nguyen@est.tech,
	kevinpaul468@gmail.com
Subject: [PATCH net-next] tipc: Removing deprecated strncpy()
Date: Fri, 11 Apr 2025 14:20:10 +0530
Message-Id: <20250411085010.6249-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch suggests the replacement of strncpy with strscpy
as per Documentation/process/deprecated.
The strncpy() fails to guarantee NULL termination,
The function adds zero pads which isn't really convenient for short strings
as it may cause performance issues.

strscpy() is a preferred replacement because
it overcomes the limitations of strncpy mentioned above.

Compile Tested

Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 net/tipc/link.c | 2 +-
 net/tipc/node.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 18be6ff4c3db..3ee44d731700 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -2228,7 +2228,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 			break;
 		if (msg_data_sz(hdr) < TIPC_MAX_IF_NAME)
 			break;
-		strncpy(if_name, data, TIPC_MAX_IF_NAME);
+		strscpy(if_name, data, TIPC_MAX_IF_NAME);
 
 		/* Update own tolerance if peer indicates a non-zero value */
 		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL, TIPC_MAX_LINK_TOL)) {
diff --git a/net/tipc/node.c b/net/tipc/node.c
index ccf5e427f43e..cb43f2016a70 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1581,7 +1581,7 @@ int tipc_node_get_linkname(struct net *net, u32 bearer_id, u32 addr,
 	tipc_node_read_lock(node);
 	link = node->links[bearer_id].link;
 	if (link) {
-		strncpy(linkname, tipc_link_name(link), len);
+		strscpy(linkname, tipc_link_name(link), len);
 		err = 0;
 	}
 	tipc_node_read_unlock(node);
-- 
2.39.5


