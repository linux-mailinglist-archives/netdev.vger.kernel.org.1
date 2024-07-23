Return-Path: <netdev+bounces-112595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2B93A1FE
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2191C224FE
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D87A153BD9;
	Tue, 23 Jul 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="FusVWPXZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B2315099C
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742714; cv=none; b=GYi+avdW9ooPaWzBdomzkDZR78+q+nkEXaZXjfOkWNtxudXrHJzCpJlcv4aW9Qk8pT4of18ZxJfOYSwP4ZzoXIV+xz8W5fKFn48y0NeovgSw8XdyRbNgARUaJJ+2tWRlLk39U7y9W5r22JcZbzo4rfgeFjBPesRIkeGa5mFrj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742714; c=relaxed/simple;
	bh=H5hMLIDnwTUPW/Z8Qsq/w7gocs6sU57/wJglXCqp0e4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pd7cx8YejwHkrdW96AUzmD5sEtDfDlabKqpDE1GFYY1Rz4DqUlQO17/cg0FCPze3U1lwWOm1wZ+F9nugnZn/k15btGxcAhly3JtRdZug0kS2NMZhlkm4AeuQQXc1z1/0luMv7SuqqgD9aYCUNjv8kAECok5HBFfdNd48W2jBG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=FusVWPXZ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 87B667DCE7;
	Tue, 23 Jul 2024 14:51:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742705; bh=H5hMLIDnwTUPW/Z8Qsq/w7gocs6sU57/wJglXCqp0e4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2004/15]=20l2tp:=20don't=20use=20tunnel=20socket=20sk_user_data
	 =20in=20ppp=20procfs=20output|Date:=20Tue,=2023=20Jul=202024=2014:
	 51:32=20+0100|Message-Id:=20<88d21632787dcbcb2541cbfd090ab3f9b997b
	 807.1721733730.git.jchapman@katalix.com>|In-Reply-To:=20<cover.172
	 1733730.git.jchapman@katalix.com>|References:=20<cover.1721733730.
	 git.jchapman@katalix.com>|MIME-Version:=201.0;
	b=FusVWPXZilVjNdZ9qF637T7+f+nue+aNeVYe+mYQ5XP+pLqYSv4iy42ymWclWMaBz
	 3gmBLZdrIjKPBJzXQEzTRa1/YY+Lvw6h7tJoirsm1ubBZRjZES5HZIEsZTVMR152a7
	 v3rrAVoGGT7gOYXq2N3V7SdzhMXkknPPc8aHT+OYZmAzs/vdNZJTl34VX+vum0z1Dx
	 haOG/8o/63wx9FsC9xE/yw4qYovs2sdVWJTTUEANA3PTL+FQYoV2QkPu9sb0vW6AQ3
	 WYu+G2++f/uJ3n87hgtS6790M9gXh8fV668yWGiDsq/jOeM8oENC0li2uYT3jpLwes
	 bRY69asDV9FBw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 04/15] l2tp: don't use tunnel socket sk_user_data in ppp procfs output
Date: Tue, 23 Jul 2024 14:51:32 +0100
Message-Id: <88d21632787dcbcb2541cbfd090ab3f9b997b807.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721733730.git.jchapman@katalix.com>
References: <cover.1721733730.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp's ppp procfs output can be used to show internal state of
pppol2tp. It includes a 'user-data-ok' field, which is derived from
the tunnel socket's sk_user_data being non-NULL. Use tunnel->sock
being non-NULL to indicate this instead.
---
 net/l2tp/l2tp_ppp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 3596290047b2..0844b86cd0a6 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1513,7 +1513,7 @@ static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "\nTUNNEL '%s', %c %d\n",
 		   tunnel->name,
-		   (tunnel == tunnel->sock->sk_user_data) ? 'Y' : 'N',
+		   tunnel->sock ? 'Y' : 'N',
 		   refcount_read(&tunnel->ref_count) - 1);
 	seq_printf(m, " %08x %ld/%ld/%ld %ld/%ld/%ld\n",
 		   0,
-- 
2.34.1


