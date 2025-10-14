Return-Path: <netdev+bounces-229127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2FEBD861C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8201923538
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34552C11F0;
	Tue, 14 Oct 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ZteFWdAP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oy3I6DHJ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC702E7645
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433489; cv=none; b=fG5Mjg4bbrZ+yDD4unnEiDVM352EzKkIXbH57HTj9hI729+oNujCdnIFl+6QmJhLRV/vh+uhvTqrpATm3eKpabR74/o+aYzFHgjV/zesn08I31XNAZKP6RkV5Z7+Xj89XhjMDodSDw0yC3e8va6RDWoDtorDlJUyfm3YW/BFjt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433489; c=relaxed/simple;
	bh=8D4RoZCr4wlcBwqBZn16kGjaodCHQ6xRRg4KKB1zdvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUiA+u/XHa7qBoqjS9yRoZw5M08BfjdFrnEuCWcbW8iIFDEdKBs82fabXmF1hn3zEE4lM6GxDd3IFVO70mU4G45AN7LxqOwT+WyNTCG+Oy7exHq6KM1i3ZEvoZOSDPDQIv1Sh1opOYOPIwWdYN1YtSGjFkUvVOy9sHM6vsgZ41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ZteFWdAP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oy3I6DHJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EE7614001E3;
	Tue, 14 Oct 2025 05:18:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 14 Oct 2025 05:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760433487; x=
	1760519887; bh=4F7xa9f3AaLOmQRfxDLPsvqB9Vg2GcTH6ZwYBS6Hj5M=; b=Z
	teFWdAP7xnuwhz1hOIrmBWZ26wdkeDfx2QhobKeLMybKkkdHkGy/y/JsB4hpaI47
	n+QSqtLMPSWuUyvkYXrkJlFHM4qA6T+F2DNYwYM/gUNEZxAantHQrm0csMCYY/FS
	oaJOzK3z2rDrWl8x312cdhvXtNqiyQpWXrotmypFoYYObd0DiDX4esYnlzUn8bEK
	c5gYsSkHtbq/eFWZXU0ZxWpnguujsuUNV93NvZOo0PbTpbpTj7cCLyVtvIPuGXnd
	JKyy5Zpe9NxXZNq9WxXj+u2ocZVHBTmyVZJ44id21FMq7w8iOsRVPbDMw8TcF20x
	tU6eKAJdkQtGc1irtNllQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760433487; x=1760519887; bh=4
	F7xa9f3AaLOmQRfxDLPsvqB9Vg2GcTH6ZwYBS6Hj5M=; b=oy3I6DHJo4kOmnJxu
	MUyc8FXY0Y5dkAujVLkw5F0P2/GJlJpphJuNmggrEjXf2D2HdKgf5/lrqcH6NC1Q
	h+t9p/5TCF3k4as96P3UWSRBNyo8fcpiU965WKTNv4wTpJop5LQqDhpyq9oFxbug
	ld+sYabo031EZ1cLSri5o+vKUBXBjKDgz4BEv9QaDY10xk2QSNroJumJhjwQS7nA
	qyKGD7YxHSoL/mHFw0TNCJnk2DPYO5lj6w9UzDqC3OOj0Zm10nY3ArF2+ftoElp3
	k0sX1bitQxOeN2Lv5uiW6sVHidikZ1Q668/L+QeI66Z6q2bDEPjD6NpG6yi8/WX5
	x2G/w==
X-ME-Sender: <xms:TxXuaO6ynFqAdtkJIef0shSB80U4WjRjmX6EoOJZdUSnKVObtlLIBA>
    <xme:TxXuaOzpDtDDFPj2qRMjtARCn7wXVYQPOWcXsUKZYh4yZhsxJcBshfiFYg84HsPPh
    CMaBKFKGfDsg2gcXbRdeTBpoxKzdzUiuekKO1wBCpoSAsEkJ1w9IQ>
X-ME-Received: <xmr:TxXuaFw0Ju3AaXQ6UIIy0s6jIfswsBJu-NvMV2m2DMuJEVuYUGBNUx6uNeSr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeegueekgfelieeuheeiteeige
    dutdfhleehfffguddvueelueetveejgfffudduveenucffohhmrghinhepthgtphgpshgv
    nhgumhhsghgplhhotghkvggurdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhn
    rghilhdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhohhhnrdhfrghs
    thgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:TxXuaGwdwN5PBKsb3ImHsbUibpLKX05yvU__RrdJroEST_kr350ACA>
    <xmx:TxXuaPZL4W5HnOo6W5F81CW-5B9SzjyrUUKkZsFzxqeZ9dzOQN1rrg>
    <xmx:TxXuaHW18P7ePrrbGlpXFNMA9OMTnNuuprWpubSqZsr179YwOS5goA>
    <xmx:TxXuaNiomePhUT3-_yDmwT8H0CEWBoujzGULJ4WnE9m15qiyu8HnqA>
    <xmx:TxXuaCJ5jzmS5xCy3r4XpDQwRtS4jo5dTJQo8L8-oNKr1fTWCV2GPULD>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:18:06 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	kuba@kernel.org,
	jannh@google.com,
	john.fastabend@gmail.com
Subject: [PATCH net 5/7] tls: don't rely on tx_work during send()
Date: Tue, 14 Oct 2025 11:17:00 +0200
Message-ID: <8396631478f70454b44afb98352237d33f48d34d.1760432043.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760432043.git.sd@queasysnail.net>
References: <cover.1760432043.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With async crypto, we rely on tx_work to actually transmit records
once encryption completes. But while send() is running, both the
tx_lock and socket lock are held, so tx_work_handler cannot process
the queue of encrypted records, and simply reschedules itself. During
a large send(), this could last a long time, and use a lot of memory.

Transmit any pending encrypted records before restarting the main
loop of tls_sw_sendmsg_locked.

Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
Paolo suggests that we could also add memory accounting to
sk_msg_alloc, and reclaim that memory just before pushing the data to
tcp_sendmsg_locked.

 net/tls/tls_sw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e3d852091e7a..d17135369980 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1152,6 +1152,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				} else if (ret != -EAGAIN)
 					goto send_end;
 			}
+
+			/* Transmit if any encryptions have completed */
+			if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
+				cancel_delayed_work(&ctx->tx_work.work);
+				tls_tx_records(sk, msg->msg_flags);
+			}
+
 			continue;
 rollback_iter:
 			copied -= try_to_copy;
@@ -1207,6 +1214,12 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 					goto send_end;
 				}
 			}
+
+			/* Transmit if any encryptions have completed */
+			if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
+				cancel_delayed_work(&ctx->tx_work.work);
+				tls_tx_records(sk, msg->msg_flags);
+			}
 		}
 
 		continue;
-- 
2.51.0


