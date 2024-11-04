Return-Path: <netdev+bounces-141697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0847F9BC0D5
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2491C2202F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170481FDF9D;
	Mon,  4 Nov 2024 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOoG7ES0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8E1FCF4D;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759116; cv=none; b=Oa2XA7XKTzBUJbpWnyT9kySYH+7OY/ZndbwdzJ7e5nV41zjJSKGUO4WNaJXtWICVhkedYEnOUwD55/W1QAj6OHK+YH2IepNVhJR5JSRyOsW/SNou/lybF9HUDZkYI+4nBPKSGWpBK8nzYF6JJ7zKnnA0lKlMXUQyBWV9joFDPBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759116; c=relaxed/simple;
	bh=SYkQAm7kUlBnBqUrrg5KuYlujl0t24HE3q4rjHVtoXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OyBbj1/LieNQzMCparAPoiGpv4H6Ev5iu1Endu5877soR7Nsy/jhaSnkZTMaDIyp6T+CSAQbeYAWJEHxpaiJ9YKKEz6ilVRoQ32OgFcHF4Q2tS3uYJB3zMLK8EWdElSYtdNOXowrjcBB0rXifh8hH2daybOeb+PvWkQWxfoUq3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOoG7ES0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8444BC4CED5;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730759116;
	bh=SYkQAm7kUlBnBqUrrg5KuYlujl0t24HE3q4rjHVtoXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOoG7ES09cAlznEN+5Ej1UobVzhHeFLAnWwbnTdRfQ0hK0DWsCjyetIuhsxo9w9NY
	 lXTUxNXdl8MCbDj0cfrdBhKTJLfJswtgvn3X+Uq/sK0h20A1N4unoV1WAU25iFS5MP
	 A1Su7CxrTWpfqfqyDQefew4C13t56Kx/oMRQNcIQh2A6UtvLbv6Kg2Nsy2vqMi5pcM
	 hFuQ6V4HqOzB49VF6XfiE7KpOQdjoued9JL2Rhr3SZxmlqlxmtqYLJygEwe5i4p54e
	 ckVD/KZ1HgMiAN7XhgzWax17cBGrMxdA7m0Ia4SJOrf7KbO5WYxvk/8gBd36QgspkA
	 6x3QjIgfqmQnA==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RFC 3/5] rtnetlink: do_setlink: Use sockaddr_storage
Date: Mon,  4 Nov 2024 14:25:05 -0800
Message-Id: <20241104222513.3469025-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104221450.work.053-kees@kernel.org>
References: <20241104221450.work.053-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=kees@kernel.org; h=from:subject; bh=SYkQAm7kUlBnBqUrrg5KuYlujl0t24HE3q4rjHVtoXk=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmanocePQqraHY/v1Chh9Na63DdwhLJm2ePzTrRJ/DA8 d3Of6ZLO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACaifYLhf9Esz0zhv0deBjNc 2xuyPpgz/HjZumO9KxrzHyzRVol1Oc7I8Puuxt3CnVst78atqOKvC3xmcFRTtVdi9TeNRu75Vq8 P8gIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Instead of a heap allocation use a stack allocated sockaddr_storage to
support arbitrary length addr_len value (but bounds check it against the
maximum address length).

Signed-off-by: Kees Cook <kees@kernel.org>
---
 net/core/rtnetlink.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f0a520987085..eddd10b74f06 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2839,21 +2839,17 @@ static int do_setlink(const struct sk_buff *skb,
 	}
 
 	if (tb[IFLA_ADDRESS]) {
-		struct sockaddr *sa;
-		int len;
+		struct sockaddr_storage addr;
+		struct sockaddr *sa = (struct sockaddr *)&addr;
 
-		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
-						  sizeof(*sa));
-		sa = kmalloc(len, GFP_KERNEL);
-		if (!sa) {
+		if (dev->addr_len > sizeof(addr.__data)) {
 			err = -ENOMEM;
 			goto errout;
 		}
 		sa->sa_family = dev->type;
-		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
+		memcpy(addr.__data, nla_data(tb[IFLA_ADDRESS]),
 		       dev->addr_len);
 		err = dev_set_mac_address_user(dev, sa, extack);
-		kfree(sa);
 		if (err)
 			goto errout;
 		status |= DO_SETLINK_MODIFIED;
-- 
2.34.1


