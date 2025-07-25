Return-Path: <netdev+bounces-210001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA31B11D1F
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 13:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C38174CD1
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 11:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621442D322E;
	Fri, 25 Jul 2025 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="bqT/XbqL"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA52E5B31
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441653; cv=none; b=BFs7uFQwAn1q/mpY93dd4yC/9hUQqFg3E+Bgb1Ja9G7EqUUQcduvarEuchvTJn6kLs0tKzQF8qoYHi8q3bYssksnUo/ryzYdTjzetJKkfkycOL4QtxAPe1FJPPH3zttqZPFaoUL2CcBXS9Ctva3VKnJ58BxrogMFtCe2EHenPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441653; c=relaxed/simple;
	bh=l8vYAD73oewnfbB3xtuvJIUkDF8Orp2DJNOmB+aC2wM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=px8UNRIdZH/0H6u98+FoEkfj/CWOq1a2G/8gV4GcsEpX/OVCPzPdaJYSXNawg2XQMkS/5+b5cHE2FVQq41a3Z1JFcmmWM95udk7nMdkfYq/z7Hx003uRy9cLFBpy/sTLHZwIo3MwYZflyeIG1UG6/RTkBoud0BAb4MI5ccTY/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=bqT/XbqL; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1ufFk3-00CISR-Rc; Fri, 25 Jul 2025 12:33:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=GBWMxEBkLjBpX9r0Nh8MBs3pkGruI/3+UiA9Y/CYdgI=; b=bqT/XbqLdRKZ9vKzRjBtBW+XXz
	66hdlbOvUq/TKAMLgdLQsNinZ6ZljDgJ3Fzz1oKn23d2623HuWoNM4yQ5MCuzHSjfK9sc8zDoRM0B
	G06Wz1XCElrs1UP/dbIZPf7lbkZkwHGYzNdPwfItPgF9uBd5yTImJvw7V7pPBaZB8QjuyV6U6TviO
	NuQZLiVXbqGZrXXcSj1QlLK8l374fMEd3SNreIaXQl6LTPXbN8iZxVlLquTtoB1qT/H1dyfalusSj
	zATiUHJNo/+Od59tuoeU4fhZuHPwnfqO2Ui0NK60gi+XhuIKxluDl2o4RBo5ManGs+mU90fR1Zs6b
	DC9Chw5w==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1ufFk2-0004xy-Pj; Fri, 25 Jul 2025 12:33:30 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1ufFjm-005Jb7-90; Fri, 25 Jul 2025 12:33:14 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 25 Jul 2025 12:33:04 +0200
Subject: [PATCH net] kcm: Fix splice support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-kcm-splice-v1-1-9a725ad2ee71@rbox.co>
X-B4-Tracking: v=1; b=H4sIAGBdg2gC/x3MQQqAIBBA0avErBPUqLCrRAuzqYbKxIkIwrsnL
 d/i/xcYIyFDV7wQ8Sam02eosgC3Wr+goCkbtNS1bJQRmzsEh50cCqncWBlbG9OOkIMQcabnn/X
 g8YIhpQ9btysJYQAAAA==
X-Change-ID: 20250619-kcm-splice-01cb39a5997b
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>, Tom Herbert <tom@herbertland.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Flags passed in for splice() syscall should not end up in
skb_recv_datagram(). As SPLICE_F_NONBLOCK == MSG_PEEK, kernel gets
confused: skb isn't unlinked from a receive queue, while strp_msg::offset
and strp_msg::full_len are updated.

Unbreak the logic a bit more by mapping both O_NONBLOCK and
SPLICE_F_NONBLOCK to MSG_DONTWAIT. This way we align with man splice(2) in
regard to errno EAGAIN:

   SPLICE_F_NONBLOCK was specified in flags or one of the file descriptors
   had been marked as nonblocking (O_NONBLOCK), and the operation would
   block.

Fixes: 5121197ecc5d ("kcm: close race conditions on sk_receive_queue")
Fixes: 91687355b927 ("kcm: Splice support")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/kcm/kcmsock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 24aec295a51cf737912f1aefe81556bd9f23331e..c05047dad62d7e201c950ab98af6dc7f0d48276c 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -19,6 +19,7 @@
 #include <linux/rculist.h>
 #include <linux/skbuff.h>
 #include <linux/socket.h>
+#include <linux/splice.h>
 #include <linux/uaccess.h>
 #include <linux/workqueue.h>
 #include <linux/syscalls.h>
@@ -1030,6 +1031,11 @@ static ssize_t kcm_splice_read(struct socket *sock, loff_t *ppos,
 	ssize_t copied;
 	struct sk_buff *skb;
 
+	if (sock->file->f_flags & O_NONBLOCK || flags & SPLICE_F_NONBLOCK)
+		flags = MSG_DONTWAIT;
+	else
+		flags = 0;
+
 	/* Only support splice for SOCKSEQPACKET */
 
 	skb = skb_recv_datagram(sk, flags, &err);

---
base-commit: c8f13134349b4385ae739f1efe403d5d3949ef92
change-id: 20250619-kcm-splice-01cb39a5997b

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


