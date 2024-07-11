Return-Path: <netdev+bounces-110902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F80592ED95
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 19:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6816A1C214DF
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9405169AE3;
	Thu, 11 Jul 2024 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXZdqOOj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D542AB5;
	Thu, 11 Jul 2024 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718214; cv=none; b=TpcBtF6Km4xgq9USE2iigjCi6ZushG3qRRvU7l9weu9ZEyJqZVKwNFUg+dHZuTEi+jcjk2Q1lLkzJ8nNy90oAP1exznRX4pWrW3YFi4gMYLH9+C6cwU4yDZWgizljYtBWC5FQbyqI6SIJLEz09JZ9tjLMiR0HQVFS4d94q1M0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718214; c=relaxed/simple;
	bh=ZjODE9du+l2tlogfzAH2XBZ8zzThaPkwpHjdjbXzZ2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WXuyPHoyvA2afJh6X4WOupoqhECntDzkOMwqCqCyuBv4lQkA78bL2c5NeMc7kH78dMwBgCsFc+VHtZwFnSK1gvfZv9GXpA3eUfzy46V5/3otUhoH+XaWRccvC6nuM0co3kOZV511tzjdeY1Xp6G1jzUnEAf19lSTfwTICPLWkMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXZdqOOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C19C116B1;
	Thu, 11 Jul 2024 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720718214;
	bh=ZjODE9du+l2tlogfzAH2XBZ8zzThaPkwpHjdjbXzZ2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=UXZdqOOj8ddzCSYwYikAKwa8SLEHPyX33qiB2TCchjc4Qzw5MvHEUOeSjF0qQ56PR
	 merLHAEGGP2ruqgi7fP/MJEjy0CanhI5unXVZjMq6iDIl5TrPzuT4TlxHhclbI2ZP5
	 8lgTVG7mCVyDXux1fOUGm7aM0VnExgbE1sY85gSt2uNSi1zrkQsxfdJwN0rOz1Pcol
	 nNuM4dd78mTNFVx4BU6CFsZhNNRL1xA+Qtu/89YIigL+3Oumbhh4lS3LyOzW3xwWA8
	 EkgC8JWmQsi7K6WjFXmBlwTqxcu6NCd3KOn7hMc5zROGyReFZBbyV9afLG9NgBHZSX
	 vXS5xjKAoexIA==
From: Kees Cook <kees@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] net/ipv4: Replace tcp_ca_get_name_by_key()'s strncpy() with strscpy()
Date: Thu, 11 Jul 2024 10:16:52 -0700
Message-Id: <20240711171652.work.887-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=kees@kernel.org; h=from:subject:message-id; bh=ZjODE9du+l2tlogfzAH2XBZ8zzThaPkwpHjdjbXzZ2Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmkBOEhbRNdvlw/GB0dPfSbNkwMF0ZFuFleqrPl +odepzX0v2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpAThAAKCRCJcvTf3G3A JkTND/9r/ctN0UPYXIadXEYAygCB/n29KT75M/ILNe6JkHVHQh9BiZjQ4SBZM7dVowOjU11PkRE eHuiqS5ce54EOca22vrZs003/+ZCHUKyEPxu/8mvNqLHjo5nGfhwL48fI1Crl32ao1Agvp7gzcI RXB6YfjgBKJc+AahVTBmaUMKWTqJe8XXiPCBie4uN5xt7qMwUbFzk07+TBiDLXkhHnUyghQY0Ix aKJFXWDtDpjoqX6j492FYkz8P0AjzrHyBkjP8COare0ZHlx0+g0s+HjAUN/Qz4UlVUimxwkaxJj vZ3SRsiFboMVZVXOoTp6f4BbL8z6eKLGEXL32yQ128O+dfX/VdEx64O7+5Q0qFait3UTCdm8sSV GA7668NUAnyKlb8RXYxqjO5fH89ygoHPaIkKc667w8WJo4/7nLbc8pdXnqwphntVaJPCegcOfan jD9QP9klXgyEuPDjfzmPfFeBW+aOQv26OHiExE5HF//uYAWkfXeNJ7KHQKsVGpibNhBdixPPzLF iL+HyzevNMfxF1c7YZQgzkBpw++9Q3WYllq5q8RaWLNWxxNuDnqdJ1irCDDWna90uALGolighXc jLTS0rhuY/wb7Xd46Dj0T0e2OsDzZgCJfeAx128aRxKqIML+pModWw73xWvynqymklQIqHOOkar r9c0usl1erH/n
 Zw==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace the deprecated[1] use of strncpy() in tcp_ca_get_name_by_key().
The only caller passes the results to nla_put_string(), so trailing
padding is not needed.

Since passing "buffer" decays it to a pointer, the size can't be
trivially determined by the compiler. ca->name is the same length,
so strscpy() won't fail (when ca->name is NUL-terminated). Include the
length explicitly instead of using the 2-argument strscpy().

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 net/ipv4/tcp_cong.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 28ffcfbeef14..2a303a7cba59 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -203,9 +203,10 @@ char *tcp_ca_get_name_by_key(u32 key, char *buffer)
 
 	rcu_read_lock();
 	ca = tcp_ca_find_key(key);
-	if (ca)
-		ret = strncpy(buffer, ca->name,
-			      TCP_CA_NAME_MAX);
+	if (ca) {
+		strscpy(buffer, ca->name, TCP_CA_NAME_MAX);
+		ret = buffer;
+	}
 	rcu_read_unlock();
 
 	return ret;
-- 
2.34.1


