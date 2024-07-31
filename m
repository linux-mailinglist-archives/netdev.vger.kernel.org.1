Return-Path: <netdev+bounces-114398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6190294259D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 07:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F1028601D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 05:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96860282E1;
	Wed, 31 Jul 2024 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DgbWrk4X"
X-Original-To: netdev@vger.kernel.org
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [178.154.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26F1805E
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722402095; cv=none; b=BOeRp5z9TpFLme4WpU+vtstfTXj35r2OnPnVS9Te8ZQ6qnzxWH2w+PpmJOrIRH9USNCgEr1TGjLPk3qr/M3U/k5lZFX7ywZFLETVPCDojYBrL0ZEh5fLhKqYfvwXYaVAKRp7U5rJ97iX4KCD5Bhf8I5A1W/eF1+K/UE/QCGLnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722402095; c=relaxed/simple;
	bh=us1Sqamgk0WwEE5daT8sWu5uRpLHAlEQI/r5jzRZXxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMTeD9ppYPo4WWiaCTjgUnmL1igDEvyXQVYGgIM82TCkZuTY1qPFlUYtL3TxmBFzwa63R06rJOFtRMmYsKn9sORApyxkf5dJ4jzKPd3oshizzjR31/+FxMLuKKoyM6OijXB6kbiiTTxhKmmt/niJIaKnIn/mwzJBcs9wFjPPWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=DgbWrk4X; arc=none smtp.client-ip=178.154.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward200a.mail.yandex.net (Yandex) with ESMTP id 72B1767401;
	Wed, 31 Jul 2024 07:54:18 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2789:0:640:f3da:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 69AD860D11;
	Wed, 31 Jul 2024 07:54:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7sNVbBxIWa60-rPptLQc3;
	Wed, 31 Jul 2024 07:54:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1722401648; bh=J8EwQBkcSTdrsmEeI8exxNgh424gbAD05v0aJfSCzHc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=DgbWrk4XDqMNX8Qy/ts2+2NlY7amrBVBHu4uUdMyIQk27cJF4cODJdArjKq1mAuS/
	 Zhxcx9Li9TDS8QXjKY6NgUyN5yyM+Q/DaRpWdrU1NIi8vDfxOh+ogyYGXheNwvGCEJ
	 xQ/NJ2h6QDrd92FnmV8Gxfr5KzHLvcoNLYsPuPxQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2] net: core: annotate socks of struct sock_reuseport with __counted_by
Date: Wed, 31 Jul 2024 07:53:46 +0300
Message-ID: <20240731045346.4087-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730170142.32a6e9aa@kernel.org>
References: <20240730170142.32a6e9aa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to '__reuseport_alloc()', annotate flexible array member
'sock' of 'struct sock_reuseport' with '__counted_by()' and use
convenient 'struct_size()' to simplify the math used in 'kzalloc()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: style (Jakub), title and commit message (Gustavo) adjustments
---
 include/net/sock_reuseport.h | 2 +-
 net/core/sock_reuseport.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/sock_reuseport.h b/include/net/sock_reuseport.h
index 6ec140b0a61b..6e4faf3ee76f 100644
--- a/include/net/sock_reuseport.h
+++ b/include/net/sock_reuseport.h
@@ -26,7 +26,7 @@ struct sock_reuseport {
 	unsigned int		bind_inany:1;
 	unsigned int		has_conns:1;
 	struct bpf_prog __rcu	*prog;		/* optional BPF sock selector */
-	struct sock		*socks[];	/* array of sock pointers */
+	struct sock		*socks[] __counted_by(max_socks);
 };
 
 extern int reuseport_alloc(struct sock *sk, bool bind_inany);
diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index 5a165286e4d8..79f2456e27a5 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -173,9 +173,9 @@ static bool __reuseport_detach_closed_sock(struct sock *sk,
 
 static struct sock_reuseport *__reuseport_alloc(unsigned int max_socks)
 {
-	unsigned int size = sizeof(struct sock_reuseport) +
-		      sizeof(struct sock *) * max_socks;
-	struct sock_reuseport *reuse = kzalloc(size, GFP_ATOMIC);
+	struct sock_reuseport *reuse;
+
+	reuse = kzalloc(struct_size(reuse, socks, max_socks), GFP_ATOMIC);
 
 	if (!reuse)
 		return NULL;
-- 
2.45.2


