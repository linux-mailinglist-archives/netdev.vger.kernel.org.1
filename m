Return-Path: <netdev+bounces-148478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7B39E1CE1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E46282082
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921701EC019;
	Tue,  3 Dec 2024 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="W5pj16qL"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE71EB9E5;
	Tue,  3 Dec 2024 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230794; cv=none; b=nVAwNGyt2USmyNp+gpAEyrlDMYFQJWRffkcxEI+dEyO96H+cAZ6bNzki89LDNX8TuFd6ZwMQcZW/zkCsuRlkhORumjIaez1VY7svCtGh0e26J7YeRZ30ZmV3FZWVRUO5lg/+a0bMy6mvT0fP0z8BeLDS5f1LE0NpCTqMDB+a9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230794; c=relaxed/simple;
	bh=cF1iOYXgx7EUZBi/kFYrkWmAEw8t0MrdXPp2O/hCa+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WaJPbSPI6cVvjl9BksCdiDtHeIZbTrodFnk9ViJplYaU1LJIxKGd4LH5oHff44pBqsBJtaiDIo7y1GqXRVPth4RETBl2GZUb/yRu3kzhEIdQ/zRiIbt7Sd6WtA21+tqAFazcf1rZHm52VwRbw9ph1RVLVrDY/wF2Vx8+1alerwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=W5pj16qL; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 12ACE200E1E1;
	Tue,  3 Dec 2024 13:49:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 12ACE200E1E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1733230194;
	bh=to687Gkwrc1hnQQoEgmLYx3ysEJ7wdMxa7NT5CZGMhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5pj16qLcx3onLyITgvmUxxBF+/kBPdXGh3BXyvsDk9NgQb6UjAMvN5MrcBxtIICA
	 tLD0w1u1t6A+uM3G0FHtMT8KFQECKvCw28N2AOUPgjqnS9KPLwCRkFR9Msaqp8/R8u
	 /5MA47R/mEX4e8C4C53Nhs/0avUxgWuXbq4zpB70zDWBXmwTc6VKDxpy76Fi9FB8Xg
	 bEhcC6TluGpbfPEiJ3Ui2QZr+kMJtC3SOXra7d5SLT48f5rrxjokooTes5W0Luc9Rr
	 5JUQm9q+Evkeeuk5MyUcsGmwr8dbh/s5yyD5ARoFjoGqCpWfgYTxjUyxusIix9ARQi
	 jD3DkyKgm0gxw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [RESEND PATCH net-next v5 1/4] include: net: add static inline dst_dev_overhead() to dst.h
Date: Tue,  3 Dec 2024 13:49:42 +0100
Message-Id: <20241203124945.22508-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203124945.22508-1-justin.iurman@uliege.be>
References: <20241203124945.22508-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add static inline dst_dev_overhead() function to include/net/dst.h. This
helper function is used by ioam6_iptunnel, rpl_iptunnel and
seg6_iptunnel to get the dev's overhead based on a cache entry
(dst_entry). If the cache is empty, the default and generic value
skb->mac_len is returned. Otherwise, LL_RESERVED_SPACE() over dst's dev
is returned.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 include/net/dst.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/dst.h b/include/net/dst.h
index 0f303cc60252..08647c99d79c 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -440,6 +440,15 @@ static inline void dst_set_expires(struct dst_entry *dst, int timeout)
 		dst->expires = expires;
 }
 
+static inline unsigned int dst_dev_overhead(struct dst_entry *dst,
+					    struct sk_buff *skb)
+{
+	if (likely(dst))
+		return LL_RESERVED_SPACE(dst->dev);
+
+	return skb->mac_len;
+}
+
 INDIRECT_CALLABLE_DECLARE(int ip6_output(struct net *, struct sock *,
 					 struct sk_buff *));
 INDIRECT_CALLABLE_DECLARE(int ip_output(struct net *, struct sock *,
-- 
2.34.1


