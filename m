Return-Path: <netdev+bounces-302385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FS+cDwnsQGr4jQkAu9opvQ
	(envelope-from <netdev+bounces-302385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 11:40:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C91086D37EE
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 11:40:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YQBPGFKF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302385-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302385-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 074A030065E2
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849A733B6C4;
	Sun, 28 Jun 2026 09:40:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01166288C3D
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 09:40:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782639618; cv=none; b=DqyvaZgvlDOssvcwewXyAPwITMWdiUQ0XxAMFn+SJkKSIWoAfDsPg/X38sTY61/r42MqJiL4qurCcco+R9bNJVjM1q2ewIMJRhht4TLxrKxDWl9ytYztAunmmcHp+r+PPmWmAQoaq/CjGOE+ILS47wQ3wtumh5BryrxZQ/bPqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782639618; c=relaxed/simple;
	bh=zEhabAI2O90UsNhJN+aYbI0vGc1cPHAPDwVCmpZpHDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5oduXd8P92YiHyZNkaehZoBNTHlfAIRWiGJ7tz4zhaPEqW+wGuM6+MhU6DFO3eqglK2Rmo994G20BVN88LcM+m8DoZpPRp8rkmZSE5NHRkahBr5gjKlTwv7+YPlFo4TC20+JnDsNVp2MFKZOUcPMFSCMJeT2kv56QtmC75DV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQBPGFKF; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-492719b2d81so4865445e9.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782639615; x=1783244415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XP+qkIHt1FgWGwOQvENORT6XdMJYDsJDs2bi6NZ8b2Q=;
        b=YQBPGFKFKf0qAUaAICB1Y6tZnoIitRbxLxtjFM5FWLe1/EVQgRUByzreO8VevU3SQz
         0mm2ewFJlLlFeCI4CqG9Q0Ys8uB5YrRaJc1PHVJjcXImp/5J3ZgLsASGf0YDW63zTdZa
         A1n3YmENCRblZu2leWHQsNBd8LVyI/SeJ+Xbl3Kc2DMzl+jOQehbBp8gAacBpki18Y/G
         rS1ru/sXf5LtRPCHNsGhDNUBJip+ddIeGy+SFc03JjykOu+aCLfcwtIvVlcZ3C+7UkmT
         pBQAV0Fd0jjff+9zPnK8oagPUSj0zn19mBpwiRXa+k3fGdVUGym1QP6aGh2TfyQFBvUV
         n7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782639615; x=1783244415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP+qkIHt1FgWGwOQvENORT6XdMJYDsJDs2bi6NZ8b2Q=;
        b=miGVaI5GFUiOmRqyyhcOb47hvDfEeV65FRCyRqILQjK2svyFNj5QVRSS/3Oe2YbDTI
         M1KyQwcU1El50OJbwbOrSoVC4uHKaZfHtWLS6d/kRynBSDDw2FDzLzfZH9mLcMm981z6
         JOQHvlw1gjjHZhg7JE/n448X027utO/YVkAolRu9zL6R70v/QZL4JuN+B05a6mboVHCv
         G/gQNJk+LrKy8NGWWKKVF9F9V4/cPB7Egb2GGpg4+g8y6llyp+T3Cmd/gvy0fOSZY+x1
         pyaEVMkNBWOokE7uRjjGWW5OFiy7E+J2o+mhXnJW8FBX3uOzMaSIKf6UJSQQB+YWgTUC
         ggCg==
X-Forwarded-Encrypted: i=1; AFNElJ+DkUBh4+WoL1SM1HmBy5QtsjiUwjMtdpVRHFrEvtc8GC8jNXASsjkmQ6j4CwdWIXB0k0ZRxPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2WIMlTUTN+GuBE0MrlELidbJWyFJ4jhVfmSxzQVDJHCM9IhA
	saPBJ8IR6HTR1SAyi9KgXdQxS8tPCk1Xh6p+IjhbLCZAhb8VgbcNUVv6
X-Gm-Gg: AfdE7cm7lr3bayX2hENjJE5+DKtuTmGhiA7yZegPdgaOqUx/bwWcl6i+99kbl7cYbPT
	n+/VJobvFYXdRURbxuCEXRiokGNtXw/z1C6KyIKchlfJ76UVMUq5V3RxLvHLPrSJGk+zSPHKJtG
	L/wiOopZBp5O1ReX4Yha8AGTRvDBMfZIHouaR9I1W52sjrmAd/KyPo4tDtRGBeS2frj3Gk+MTzr
	VPQ7mMnQq6LVuhwBS1292PLjww0t7ZnfEyEQ5O71xhYEbl4ZLKM/nY+LkFASr+zIH5yDERukAuj
	6f7LpF0jsyweXM6MrlCwwHPzIC9nDPy7k2YDy6ctZHI3UpeFh9jxv0YsYrgmEFHtg+Sr15sqPEu
	4P9apYeJMiiyvTOTFqfcUvbKvLubjgde9Cnyq6kmjZnD79dvMtJ2atwWjjOvO533htUaTZ13Lqp
	whwzr+fNre6nuPJ6sFnLAOTotn7w==
X-Received: by 2002:a05:600c:82cd:b0:492:48c8:c705 with SMTP id 5b1f17b1804b1-4926fc2fa58mr69551225e9.1.1782639615378;
        Sun, 28 Jun 2026 02:40:15 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47290ed4377sm5958924f8f.37.2026.06.28.02.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:40:14 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] net: usb: rtl8150: handle link status read failures
Date: Sun, 28 Jun 2026 11:39:29 +0200
Message-ID: <20260628093929.44214-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302385-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:petkan@nucleusys.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C91086D37EE

set_carrier() ignores the result of the USB control transfer and tests
the stack variable supplied as its receive buffer. If the device rejects
or aborts the request, that variable remains uninitialized and the driver
chooses an arbitrary carrier state.

Report carrier down when the link status cannot be read.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/net/usb/rtl8150.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index c880c95c41a5..5606490aaea0 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -732,7 +732,11 @@ static void set_carrier(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	short tmp;
 
-	get_registers(dev, CSCR, 2, &tmp);
+	if (get_registers(dev, CSCR, 2, &tmp)) {
+		netif_carrier_off(netdev);
+		return;
+	}
+
 	if (tmp & CSCR_LINK_STATUS)
 		netif_carrier_on(netdev);
 	else
-- 
2.54.0


