Return-Path: <netdev+bounces-114964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00211944CFC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3122A1C22953
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167071A4F12;
	Thu,  1 Aug 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="wpw4JzMD"
X-Original-To: netdev@vger.kernel.org
Received: from forward204b.mail.yandex.net (forward204b.mail.yandex.net [178.154.239.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F141A4F07
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518149; cv=none; b=e20bGpyD5vUeKYZqnNfVt3RbZNRsOwZDlrv9J5t5EEoNNsmOyN/81VLFOaF2h2d5Oeu9ATbnSZqselE9A3mM90GraxfZV9a787jYxCZjLQ57mS3sVLj0cz4ydxdjl/eL1CljfKBa4CHNo3niGdgG1l4/ZTx7Iwfr0Z57/jvMEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518149; c=relaxed/simple;
	bh=jInI+s31H3/r2Hs1MBedgn+hhit41r4WOMqlxC9b/nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUPy+uBovfgy/CAvzJaq2vwzUb7CFNhItoIW+NLQiPazUjD3xNUhmFeGQBd8FS3gQamse6ybpWcQqKdszHK1vePvpES0eut+QrJUgDCvOWxFyKsZUThg9UgicE1bKbbjq1wAO5M8K9EDxyCs9oNKQigU+dEbq03cBciP+dmbr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=wpw4JzMD; arc=none smtp.client-ip=178.154.239.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward204b.mail.yandex.net (Yandex) with ESMTPS id 0221167769
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 16:09:15 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:3b2:0:640:ff71:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 64B4460BA4;
	Thu,  1 Aug 2024 16:09:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 49XVvx4h5mI0-7kfw8ghU;
	Thu, 01 Aug 2024 16:09:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1722517745; bh=Erl7nRFuugq5apBZgvurtc7uTu2D7wcJ95SgsVFsVbw=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=wpw4JzMD0IaI65k8fohlHaC3MT+sT2Ao2MZ0Dpj7BptVsCmMqdWwX9fCTtAMaxdSO
	 WVCsT41WYdvFO+xmIzs9d3Vsfz7jtiX3B0Lke/b3Gd9+M2nRo3hgYe7KLd4zG3Awgz
	 KG7jfkYynBmb4KU+RDr4TepVkocsYgHWyziODRjM=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Tom Herbert <tom@herbertland.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
Subject: [PATCH] net: kcm: use previously opened message only once
Date: Thu,  1 Aug 2024 16:08:33 +0300
Message-ID: <20240801130833.680962-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When syzkaller reproducer injects 'alloc_skb()' failure at line
817, 'kcm_sendmsg()' may return with partial message saved at
'kcm->seq_skb'. Next call of this function will try to build the
next message starting from the saved one, but should do it only
once. Otherwise a complete mess in skb management causes an
undefined behavior of any kind, including UAFs reported by KASAN.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Reported-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/kcm/kcmsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 2f191e50d4fc..fa5ce5c88045 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -766,6 +766,8 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	if (kcm->seq_skb) {
 		/* Previously opened message */
 		head = kcm->seq_skb;
+		/* ...should be used only once */
+		kcm->seq_skb = NULL;
 		skb = kcm_tx_msg(head)->last_skb;
 		goto start;
 	}
-- 
2.45.2


