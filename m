Return-Path: <netdev+bounces-299976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ogvCOXjOMWpvqQUAu9opvQ
	(envelope-from <netdev+bounces-299976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:30:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 457DF695929
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:30:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HNGO6CoV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299976-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299976-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5508C3178D53
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A913A8723;
	Tue, 16 Jun 2026 22:26:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A634A3ACA7A
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:26:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648817; cv=none; b=HA/KrQIKbCS57xcnNU2qAtKg0spx8+X0qGcW+//8gzVV79bs9NbxZLnGui1U1ZRsFlUkZ4QTZ56/3mWXR7EhKu/kZnYTfAM71J9K2Vs9ioLNMQg20U+8XFS9EGmTZWx7+b4HcKflNxnlV4HAU8txsYPkakOSNT9S99zsw2pzI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648817; c=relaxed/simple;
	bh=lagiunzXSq9oC2yFzwByQw8wxuRhAtHQcjGd/oG0Ld0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LvIS2HGMNyivwMZEZ+NnsybM0T3stXuS2Hdbu6zjQm1obqagFyk2P00oT4TLwqx0fsKyUC9MPeaAHU+kDXCMaYPZaakjGEoSLxt94opoeHufafUzk1v2D8HAY83kVnx6KkR8awZtAkP+KANZ4dWRnVUuWp10F7J560j4dgioYqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNGO6CoV; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c132ac5ec2so50981335ad.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781648816; x=1782253616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Yll/Wvi91nYOEpP83UIdJkAu2UP4DX4txS/t/t0Jo=;
        b=HNGO6CoVvU+jpqeojl4yXlU6oILeWdTWJOTnQeAiWLFfpE/0lm4sMIiEb/UPgeQhz7
         xvAyzgDD8VO49AyhpumkoKUGQjs4xnhy/UDoStbEo9lbrzujhClk53lKaprjv1BldOky
         aeriE+VFInLcOBUOb+mAW8HHk3mw9e0MD3Mje9fnX/CBZGOaWUW0eT/HbmtquwY1F4L9
         7pQRpIV8l7ikNn4pLPSupU/Ww5RO0Tp2eaAJZu1E5nVYQjvsquSMcL1zmIzWMaUN+40K
         By6E5RuK4uPFFWJm/XY14uGBoqPWvT0WfXPNPcKyPHVtEQuVXumXOAfKXwpyU5/mhWt5
         85Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781648816; x=1782253616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4Yll/Wvi91nYOEpP83UIdJkAu2UP4DX4txS/t/t0Jo=;
        b=bc+r1jueG8/hwjxXAB/oFN9CsRsz7pgNbn4YxJGeLfq9cHGKaSWTyqqy25Vob9wYxC
         I5Wtkp8+T81SuEZiEOmOYdLJGK32sa0YjWb1Bz2+PNOcUsL9UN9i2p7ZO3Ki3fx73P01
         9CGTQVaBT/qqj8XV922Oh9/LRg8Y+xKbjytpQDVN5gaY+GqpFrRhCMdSWlfFdmulHieB
         S4nRrAg4ed1ASDR2y5dMTYg9LWKfd8uyEDd3dww7C6ZdBtDAfNm+EjQlZmn7KVAybbD7
         NzRjQndmAcmGe1dK97QfWrScZHl2uZKsVf33/oRgR+ekyQmM65tnVNgj78Gmf3hN0WSV
         351A==
X-Forwarded-Encrypted: i=1; AFNElJ/vi+RU+PB+XG/wR0dMsbaUqH/kCB2YAL2XgVEoRM9d8tCC1ucK0i/43OpMvnqfHEXLwqdcbAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCKkCyCcmOiRz0Mkzn96GWgipzg+rUeTcfKcXXl8JQxNICJru
	0d7LCDijH+KJj5mtE4ArNd8cQUJW+0bJbvwsdw/GcA1k7YU5wTisOZlu
X-Gm-Gg: Acq92OHDDLqrBEwz8vtaxlvScaKawjhNQDgqrCLJy9soUSdkdpw1CpMJqdqC0Nt8+Qa
	ixOdIwWlUfifrhk+qRtanIAH0UnWQHw+9TxoaRaKnAkpF7SqwI40BuoFMH5w5zfFuFQCAcv5q5e
	JrncKwFMMb/KjxfJLd8u0HTgCTVNL/zPY5PeFuEg49JOuNk+dD80W6VvFfZ9ikV0dJzbKRrd48p
	KFmaFFHG/scv6ZPj/cg+DCNmKThq2LVY0+sUUs44ZVo3oS2005ZIDzBxhUBN59nQNPVLlUsrh+w
	dqgcZu40kI5Xxws7Q7b4tacaD5AiT5qT6MjdsveEkQ3g9274+o3Is16RjUk7wzzm7k3VOjl7r8p
	Lj6Ydud0/pmpck2avqiDuoDflaesm8wiBXDykde4hozKk+WPcDLKq6MPM8ney6JTCRvsQTPel3M
	B6Om8a4JaQ7pKfaoaRmYg8BBDcuczTVlAI2PPBtq0V5sRuZlEKZdSRdxAcHmyHywWs1X5dPMMHW
	q8p
X-Received: by 2002:a17:902:f606:b0:2c0:b932:8680 with SMTP id d9443c01a7336-2c6bc0b76camr10361585ad.10.1781648815957;
        Tue, 16 Jun 2026 15:26:55 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([203.192.239.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a758a3c6sm22532005ad.52.2026.06.16.15.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:26:55 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>,
	syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com
Subject: [PATCH] netdevsim: Fix deadlock in del_device_store() and nsim_bus_exit()
Date: Tue, 16 Jun 2026 22:26:44 +0000
Message-Id: <20260616222644.41344-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,linuxfoundation.org,gmail.com,syzkaller.appspot.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299976-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skhan@linuxfoundation.org,m:mokshpanicker.7@gmail.com,m:syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com,m:andrew@lunn.ch,m:mokshpanicker7@gmail.com,m:syzbot@syzkaller.appspot.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mokshpanicker7@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mokshpanicker7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1cf303af03cf30b1275a];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 457DF695929

del_device_store() and nsim_bus_exit() both hold nsim_bus_dev_list_lock
while calling nsim_bus_dev_del(), which calls device_unregister() which
internally acquires the device lock. If another thread already holds
the device lock and tries to acquire nsim_bus_dev_list_lock, a deadlock
occurs:

  INFO: task hung in nsim_bus_dev_del

Fix this by releasing nsim_bus_dev_list_lock before calling
nsim_bus_dev_del() in both locations, after the devices have already
been removed from the list with list_del().

Reported-by: syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com
Closes: https://syzkaller.appspot.com/bug?extid=1cf303af03cf30b1275a
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/net/netdevsim/bus.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 41483e371..0f02ff8ad 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -241,11 +241,12 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
 		if (nsim_bus_dev->dev.id != id)
 			continue;
 		list_del(&nsim_bus_dev->list);
-		nsim_bus_dev_del(nsim_bus_dev);
 		err = 0;
 		break;
 	}
 	mutex_unlock(&nsim_bus_dev_list_lock);
+	if (!err)
+		nsim_bus_dev_del(nsim_bus_dev);
 	return !err ? count : err;
 }
 static BUS_ATTR_WO(del_device);
@@ -527,11 +528,11 @@ void nsim_bus_exit(void)
 		complete(&nsim_bus_devs_released);
 
 	mutex_lock(&nsim_bus_dev_list_lock);
-	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list) {
+	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list)
 		list_del(&nsim_bus_dev->list);
-		nsim_bus_dev_del(nsim_bus_dev);
-	}
 	mutex_unlock(&nsim_bus_dev_list_lock);
+	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list)
+		nsim_bus_dev_del(nsim_bus_dev);
 
 	wait_for_completion(&nsim_bus_devs_released);
 
-- 
2.34.1


