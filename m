Return-Path: <netdev+bounces-250889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58765D3973C
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B67630062C0
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA49E33A71D;
	Sun, 18 Jan 2026 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaCQ26GS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420123321B3
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768747692; cv=none; b=QEXaEs0ZBNl+g1h2PUhIJYHG4qlWdEqsHtI4Gg6nofmbcuUugUtevZry2eAgGGPUFOrOJQaPwJ2yEeibmKUKwJm1IceuMDgaAM2StuWAfkhn0CuYbGhdWkISu7yM5hVvrqb2grEoe7qvjfsLN2e2HN8dSEXQKWqkyjcK7HUUh6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768747692; c=relaxed/simple;
	bh=OPLhgS70WXTefJGjXohzpw1kQv8W5ourc0aIIIHgcSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8hMiI8/VKVlvYk/rQwFrwMyS2zsF21WjReh+Uj/zHN3Q0gcGty8uqzFXsPQ/rkSWPiqsxhUN6nJY+/pxV9hDRi7ynQVBUtvhqJM2bFb6Lza2mgeHSg5JfrxEwFKjqTCkzAoDs0VPBFG/3DJPx8+oTLF01FPRvAE+GkXu6yjoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaCQ26GS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b871cfb49e6so580386166b.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768747690; x=1769352490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwhHWcSuKh5FBKzHk5nDn2X2ZmAMO+jm5eGTbzgp59k=;
        b=WaCQ26GSjJFOqNGxhGka5HgIyg1ojQ0hC7mZZLOpGO+S8yHQH/aTHXAO1kdQxfiU+u
         3maoe5eEqgI+cXuR9zvsI1BJ0uaoqAcaaYXS1VGZJ3xIs+7t50AJOPrf1/sQ10m0TTaE
         QG51prfeDM6GLVS9hqojb5auy92wliqUsiaxxQuxaTUuJYrhRzPhtK2FYFbX3g0uoV1R
         qTI3yWWaVmOPaXIqkCRVN9We16yBZrbaH9BHO5mfKPP+kMOPyMy1wAZR1lLISmPPBiz4
         Wlvjz2jJKJcgWplUfeo/e9jcdiX1J+qp/oXO9TkGfH1XJU08Q64geJBleR/QvTU9epGu
         XvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768747690; x=1769352490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwhHWcSuKh5FBKzHk5nDn2X2ZmAMO+jm5eGTbzgp59k=;
        b=arfnR12PCfZWAZbBmTzIykY2vlaZdvCpOXKRNxbwzA6eBbjgnnNxFV0ut5+bboGx/z
         l+BMSnOvf57/TfvSOVfaRlw8YezhlWxZJoYEpd4n1MNZfUC8XWEGMysmA+5FMi8OTVBI
         ov2kOFUoWv1PtagPB4yqCRahL+ttAcWGQzLdtjWqsEEHPYKJzjS1L77jRaKxLJQ4Dade
         HaQ3ah+b/zlBqnh1MOI0JJ+VsMgkE+RseKucKR3ApJN0f3Uud4+c+/14IPxmkrwHPb6M
         n+W43ve1+wxRe2Z4lFp2/4fyrItgzcqpHhC90keI04ta6VkBC9OQpiVFDIUQn/IKx3Z3
         xtJw==
X-Forwarded-Encrypted: i=1; AJvYcCWSigLhdajDaDeC7hJ7DnC3zMNNF/x5wu+VuMJNTDCOrZWkRVRPZ6CqPFRYnxWVY1p81hCnWro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwvI+dtD2A4pkJatN0bREK+xxOiDf+LiMxDOYNTkTVJKs+M61Z
	oL+mZ0nG833VZZq0mSlL7WXEHWm8agqGw8fo0ZjvbKH3iYrtKKAwrsJv
X-Gm-Gg: AY/fxX6M7PkQRU3GYuF++OPYlD2Uus0VccKFVZN2FRkS24uWBYMfl+qtmhfS+4qRtvI
	8TsrEd+Tky3LwW8e4WnAX2cpahYKFw+Sd89Z8zigpizC7LjaaE11LSWXVQZrB75pE+NodyEiBmM
	h5O8d+/5se06vtblvwrCR3oXvDwfd/twa9e6Sc1tO6nXWmKk/IGK1hRgXNXsQu1kqHRJ6KrKSC5
	uqksfQAHhGzhdUFQuxwWD3bb/b8ogWQUb2hhiwa0UjffpRSMgGS77bT3Qm/vTI+nTpQbSfMki3D
	SxzHC5gh9izjgWEayurDPKeSbVHHb0mB7GHoE/saio6RyQn1bNkbnvZXzwJE9QOHWjYAAySsjpI
	fSW9ekGatnJNE+pOglxKOf6Oc3rtu0Xj4vctrWLbU+pkHWYH8hdD6uSfcCgcC7z5KYTRPu6/WOz
	UY+8s0QceAT2WuQ8OP21XX1ldkGg==
X-Received: by 2002:a17:907:3da8:b0:b83:8fc:c659 with SMTP id a640c23a62f3a-b87968d154dmr641819466b.3.1768747689514;
        Sun, 18 Jan 2026 06:48:09 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:5d1e:7d5b:bff1:e1f7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a31322sm853009766b.63.2026.01.18.06.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 06:48:08 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] net: caif: fix memory leak in ldisc_receive
Date: Sun, 18 Jan 2026 15:47:54 +0100
Message-ID: <20260118144800.18747-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL pointer checks for ser and ser->dev in ldisc_receive() to
prevent memory leaks when the function is called during device close
or in race conditions where tty->disc_data or ser->dev may be NULL.

The memory leak occurred because netdev_alloc_skb() would allocate an
skb, but if ser or ser->dev was NULL, the function would return early
without freeing the allocated skb. Additionally, ser->dev was accessed
before checking if it was NULL, which could cause a NULL pointer
dereference.

Reported-by: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com
Closes:
https://syzkaller.appspot.com/bug?extid=f9d847b2b84164fa69f3
Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
CC: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/net/caif/caif_serial.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index c398ac42eae9..0ec9670bd35c 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -152,12 +152,16 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
 	int ret;
 
 	ser = tty->disc_data;
+	if (!ser)
+		return;
 
 	/*
 	 * NOTE: flags may contain information about break or overrun.
 	 * This is not yet handled.
 	 */
 
+	if (!ser->dev)
+		return;
 
 	/*
 	 * Workaround for garbage at start of transmission,
@@ -170,8 +174,6 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
 		return;
 	}
 
-	BUG_ON(ser->dev == NULL);
-
 	/* Get a suitable caif packet and copy in data. */
 	skb = netdev_alloc_skb(ser->dev, count+1);
 	if (skb == NULL)
-- 
2.43.0


