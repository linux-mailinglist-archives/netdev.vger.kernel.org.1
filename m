Return-Path: <netdev+bounces-274463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO4rBM1GzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:37:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EBA387C96
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5755A3002B66
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725013C8715;
	Thu,  2 Apr 2026 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dv0Z1hy2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB7C3921CE
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126123; cv=none; b=pNIqXPuEK7ZgyfYv3bXWO3kN328oUF7a/enqggycrXjhA3yjhcE3fYphcoFdqlZTx+k/+LHy68FrQkcf5XnoDNxQbLAEzy4zkYm3xbD6JxJ1mMMbekVAKLln347swCA7ItwxWeKJKoeL2qSGoWo76E6v9n/TJMefyixJl0DjR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126123; c=relaxed/simple;
	bh=FQsFBMXFr9zfTGcchLu1aFoI2dk9QTFQtknsHXSnb1c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qzT0ozHUGkV0PmHF0z43owULOQpqPtsGG7FFhNGm/ZdUIWSumd45Bj/TtZ0Hpexp7p0gu9YZpLDDFn2QVcONr1/Lc/c+ZBesGUHBMAIHzQvBkv4sdJg46vOcfex+S5SX1EJFZrdDvbj6ecwwpleOpD7weQCGA1R1x+ylwV3YyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dv0Z1hy2; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b4b81c632so19553101cf.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775126121; x=1775730921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hTrYYWCDoops0RbC4qMtHcZwLDXHuLQzYz/4z22FWIM=;
        b=Dv0Z1hy2QtXROjDoMF/KWGifiFgpRGg0Nstp6g2fjSTGVRwhHJKQY2wQIcBR6VUmoe
         8Dx44eqYx4cSyjNQD5qWeNu58gYnHEBxMZifPYreVJ4fNdm/601mzSgrbeBVoow45PZf
         5kPnBLqib04LJyFatGRc8REbdTpDqvwWUte/JFvVOIvt+pdMmTXhXc0dV9TSpOkTCTKy
         l8DJ5TioSG5bfRac7rHV5vZB3MzuZIBkL7TePv4KUhveCuhXFA9u4q1UoBAra+2nMn1S
         FgIwD/3ORs16JkUbdTKhPfwYS01wzK2CQnYgANO5yh/2bIkRSHC8nmjqFDuUqWzhtNSl
         DMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775126121; x=1775730921;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hTrYYWCDoops0RbC4qMtHcZwLDXHuLQzYz/4z22FWIM=;
        b=UuVOZPVnOFAO0cSXsjEE1JGqKBz5kdyl1PooreWUuU0qvLTT0o1F3esu1dAp7fB0+z
         Uul3/na8Y5v7z/KD9sByFjnT2fRfEKB2dlJcxE0CEBOumvYPbLWdxWd8gbiqsNPtVeKw
         lYqTqADvncplsvWCb0q+ah06G/K1ghXEhY1Va23LSeI19BwkylsCuti8JXrQlcmdtWOZ
         3cdANIwQRO92MJ6uxBTRGqXWLTgKjSbJxAwOs4OZ6jW3Iim+eC/ThiM5G0GkQxxYTSAm
         qKx1KkgJkgFFHL0XxhiMLWf01uEMvWpYRvjXtVIJYeJ42lz7WWBHGd8/IvOsp4lXZdl5
         Dnxg==
X-Forwarded-Encrypted: i=1; AJvYcCU563jvNcMFfBPcvnkUScJh8XhbQoLCW7VjXsKWNmjouTGfUDaXpMuFsC7mu3oI3IyYpRVnCjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXUS+NdwzjPNyh17BWxbosYzl6nhFucq0CAg2Ea04NIMpd2rSl
	QJPLPUiDLIPMCJOg56fnOahNQExGUiLGK25hNOQvvnGUkTLYSlTwVu/YTaLPiWrM1pvKi3kI5MC
	FI7ExarUUJYj1Dw==
X-Received: from qtpb6.prod.google.com ([2002:ac8:6786:0:b0:50b:b6a0:30f8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f14:0:b0:509:764:2efa with SMTP id d75a77b69052e-50d3bd4d777mr95913911cf.59.1775126120823;
 Thu, 02 Apr 2026 03:35:20 -0700 (PDT)
Date: Thu,  2 Apr 2026 10:35:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260402103519.1201565-1-edumazet@google.com>
Subject: [PATCH v2 net] net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com, 
	Martin Schiller <ms@dev.tdt.de>, linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com,dev.tdt.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274463-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,d8c285748fa7292580a9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tdt.de:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 03EBA387C96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

lapbeth_data_transmit() expects the underlying device type
to be ARPHRD_ETHER.

Returning NOTIFY_BAD from lapbeth_device_event() makes sure
bonding driver can not break this expectation.

Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_ETHER")
Reported-by: syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69cd22a1.050a0220.70c3a.0002.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Martin Schiller <ms@dev.tdt.de>
Cc: linux-x25@vger.kernel.org
---
v2: cache lapbeth_get_x25_dev() result in @lapbeth.
    make sure @lapbeth is set before returning NOTIFY_BAD.

 drivers/net/wan/lapbether.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index f357a7ac70ac4756967730fa61c07258b4b3ac00..9861c99ea56c4efb03f22375b60f68665443e04d 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -446,33 +446,36 @@ static void lapbeth_free_device(struct lapbethdev *lapbeth)
 static int lapbeth_device_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
-	struct lapbethdev *lapbeth;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct lapbethdev *lapbeth;
 
 	if (dev_net(dev) != &init_net)
 		return NOTIFY_DONE;
 
-	if (!dev_is_ethdev(dev) && !lapbeth_get_x25_dev(dev))
+	lapbeth = lapbeth_get_x25_dev(dev);
+	if (!dev_is_ethdev(dev) && !lapbeth)
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_UP:
 		/* New ethernet device -> new LAPB interface	 */
-		if (!lapbeth_get_x25_dev(dev))
+		if (!lapbeth)
 			lapbeth_new_device(dev);
 		break;
 	case NETDEV_GOING_DOWN:
 		/* ethernet device closes -> close LAPB interface */
-		lapbeth = lapbeth_get_x25_dev(dev);
 		if (lapbeth)
 			dev_close(lapbeth->axdev);
 		break;
 	case NETDEV_UNREGISTER:
 		/* ethernet device disappears -> remove LAPB interface */
-		lapbeth = lapbeth_get_x25_dev(dev);
 		if (lapbeth)
 			lapbeth_free_device(lapbeth);
 		break;
+	case NETDEV_PRE_TYPE_CHANGE:
+		/* Our underlying device type must not change. */
+		if (lapbeth)
+			return NOTIFY_BAD;
 	}
 
 	return NOTIFY_DONE;
-- 
2.53.0.1185.g05d4b7b318-goog


