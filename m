Return-Path: <netdev+bounces-304827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T5IlGr8bS2oRMAEAu9opvQ
	(envelope-from <netdev+bounces-304827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 05:06:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72670C446
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 05:06:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=N9KJmBnr;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304827-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304827-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C09F30086CF
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 03:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0325F3ACA6F;
	Mon,  6 Jul 2026 03:06:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE1435B645
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 03:06:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783307196; cv=none; b=T8W+df3tIG82mQCbeo/9ydsC4uQiL0mDLY28u/1AvdgLwEnt5RWn2IR8j6J8waSy5S9CN25vXAEnhrMtbrZ5Z9yY9QVshw+nalo6nPVt0rWW82RmfOv+535bqXldV9RzJPOtdR78I8RjDaJJ9sLyaAsVS8VKk9H25MFNM+yWlg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783307196; c=relaxed/simple;
	bh=XOfCdFUKFIo7HMCTJ7WSzTMTIpbQEXqIsg/t6NcO5Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGk2KdqBdN8Y+JFa2i+HK7CwRJn7aH/5w+AIE2EEHcvcaGj0hvIrLJ40kJxsX7rXpEdfjvmrFBMMurxKgkvY/6tnykMGpJTva1l8HBh4C2vV6GN0gbscl7Zh7ji2nqNPHsBR4rjWrEHbfMauO0Dsu+hcyCIDYcRchQ+RroEphn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9KJmBnr; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38511175ad3so647133a91.2
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 20:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783307195; x=1783911995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZgDyLyNz2cPWa9DlLdj8DZ7TG8u0RQDUWdSZBVgwfo=;
        b=N9KJmBnrkOchfyBIJHDL4otrhfrzoz1347qnNNbQJbo2ympIkrOLI4dtalw8U3dumi
         sRbaN3sPYkVojDYZZOMGXTXlrO0LFX3bQpzgZRuV+UpqtyfOS07kwenhfGMgdtE4GIcf
         lVlV7Yd6UzxYilTTYe+TMcc55uR2XwiI9hOSBKNmF8HlED1NTpjLC9JCdricgR5BF0No
         H+vmBkzAdoRYUk23sGuvAHEVtMjBItV88m+Ckdz4x+Vgppm1CjqzZ+PHVu7wOvBT+idv
         ufcCfkVmmFiVqWM7Qf0jnDw6QQo94rSCsWq/CfMlQng24ETcZ45LDqAkUiqJkhfDhtWZ
         WP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783307195; x=1783911995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZgDyLyNz2cPWa9DlLdj8DZ7TG8u0RQDUWdSZBVgwfo=;
        b=oln7wCpoFoAdoyh94P8FUcp6iqor3N4bxnHY2Y+uWvgM1Cz/5RC3KlCvoKTowQTWAr
         XEpuoQr/A5SYB67ulH0/6d0IVDILMqz9XlAisKMb390Yhh10OYF+RkDWDEfcT4r37CK8
         +T6OXyGL56Wt5RszCcAMd+uhlzh7oMWa7go1/Fy2ag57TJpx0ATQrYFSJhpbjxqdFRRK
         WbsLgysKL0H0hUlYP/LrLMsltcxxQ2nqtd/DNpmU3a/4PLRX952Hd0YLBr445+SM0QL5
         El02B0vgTvDoR4wYKjvuGTlz0sAyKM/Z3NlXfLIsmMmX0D/gsuAIfjtyiCMl/NN5f1WJ
         x83w==
X-Gm-Message-State: AOJu0YwBfIVFsaHOHJRME8HSYj1+15w54JcFWzrtBXZjAI5znRcBQY4n
	uTRwfhwQ51yqWP90zNjmFUTFGapnowcj7ZGbjUvO7w9BZ+HjgzccfRhAVZGkig==
X-Gm-Gg: AfdE7cnGVzXfy6TMNNkklSq6wiiQe+RO4AwNcWmE6JLmHNPhAPKPu7i7gZY2OCD9iVD
	AsFhNDRf+mqvjLxu4J4N5NSgcL/sEVoTB8ZW/AiZIu9J0OUEsX7VaIxkgmQXXwy68HeeDY7qXNN
	i0pKygAxQUpp90NL8yXFzjUggGO/U2yuFdK+jGZt6jG5ghvgVZ1e0p2p7mgnHOtND83jbdBd1wR
	h3QbV8yek2tWmvh4JrFqLvr5a2mmKnarbY+lWT5hFIYwSE3yXgBiPO1S4GWRV2HQHy3Z7cuzC+N
	kPxFy3nCBvckDdNCCBGYfwEUHCT0/HDDS3zWoKvmrw8jP+XiHP1cVewM5ZGplXKnGK9cD7uXmoG
	5WsnKRgrn/DpDM/H81r4Y87fxLPfBYUJ9j3uja6JXO/dDv87Dl2wJ2PYnvsjJQShDm50Nc+x7Zb
	uyP7XlHy3GhJcTMW0WA8OZcUHWbqC3O578wlhRF8t5iFFBuVING/4z2toKiNsO5TQgs5tImMWG3
	EUYZa9/TQ==
X-Received: by 2002:a17:90b:48c6:b0:37f:9ce3:ca93 with SMTP id 98e67ed59e1d1-3829f8e55d2mr8819064a91.28.1783307194975;
        Sun, 05 Jul 2026 20:06:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127ae1333sm4056699a91.4.2026.07.05.20.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 20:06:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dpaa_eth: convert to napi_gro_receive
Date: Sun,  5 Jul 2026 20:06:32 -0700
Message-ID: <20260706030632.1826810-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:madalin.bucur@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304827-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA72670C446

Replace netif_receive_skb() with napi_gro_receive() to improve receive
performance for this driver. It has rx checksum support so routing speed
shouldn't suffer.

Tested on a WatchGuard Firebox M300.

iperf3 bidir speed test:

[ ID][Role]   Interval         Transfer      Bitrate        Retr
[  5][TX-C]   0.00-60.01  sec  5.35 GBytes   766 Mbits/sec  184    sender
[  5][TX-C]   0.00-60.02  sec  5.35 GBytes   766 Mbits/sec         receiver
[  7][RX-C]   0.00-60.01  sec  5.50 GBytes   787 Mbits/sec  124    sender
[  7][RX-C]   0.00-60.02  sec  5.49 GBytes   786 Mbits/sec         receiver

After:

[ ID][Role]   Interval         Transfer      Bitrate        Retr
[  5][TX-C]   0.00-60.01  sec  6.49 GBytes   929 Mbits/sec    0    sender
[  5][TX-C]   0.00-60.02  sec  6.49 GBytes   928 Mbits/sec         receiver
[  7][RX-C]   0.00-60.01  sec  6.55 GBytes   938 Mbits/sec    0    sender
[  7][RX-C]   0.00-60.02  sec  6.55 GBytes   937 Mbits/sec         receiver

Assisted-by: Opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index ad2d8256eb8d..83191f636ec7 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2824,10 +2824,7 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 
 	skb_len = skb->len;
 
-	if (unlikely(netif_receive_skb(skb) == NET_RX_DROP)) {
-		percpu_stats->rx_dropped++;
-		return qman_cb_dqrr_consume;
-	}
+	napi_gro_receive(&np->napi, skb);
 
 	percpu_stats->rx_packets++;
 	percpu_stats->rx_bytes += skb_len;
-- 
2.55.0


