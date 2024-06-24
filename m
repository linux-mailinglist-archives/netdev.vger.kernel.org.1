Return-Path: <netdev+bounces-106077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAE59148AF
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9CF4B26435
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F61F13B7BC;
	Mon, 24 Jun 2024 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Vgf44K7n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62C13B59B
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228596; cv=none; b=jXCmEzfB4N3U0w/4jrQCC+zAy5VE094InBC3cUtkqrMTHn/rr7a1PsngnAuk51KX1oBmLcHsGdw7+MRq0fbHt9alRe8p/vSSa8SGCkPgRU1k1FXA0f20eTqj/bRag1StKHdYzll7+NkFnGzZLvZpK+nWQBIDMDM4sY8zeJAgcCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228596; c=relaxed/simple;
	bh=hVNGcW4+EE4t7g9/WDNUt292tXLE01iqI+ySm/i3fS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT3pHzJf93zzb8/Z00pc+TVWSupZRioYxf8ASQvsQceF3uyg87uKEPe/olQCLBkHq8JztFuRLVXvFERTmi7RbUMtS8BWUGoJROWUVdCUxqRp+q2qfrNgykUzVFCSXGifr/vVVQ0wGZ0AA8jnr+vKncabG73DP3kMKOJ+UKl+e+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Vgf44K7n; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3627ef1fc07so3132999f8f.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228592; x=1719833392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjYfRpz7d/pnzQIIVZvDS+ZUuV4pfFWfqrT+udRi1Ik=;
        b=Vgf44K7n7GvniDNQDUBBPN3iFEQWb7kjlLLwSd5/T0vY+5DVqafjxaqMEwuGjzeiun
         yAjl5cdXL3sFHm4ALEx4wvEruTXYAnXRFbWrArKCf+7uDfdeOpGi+HZ1rNLo8u7pZLvf
         bccyV/7zWwE729xuyPt6jPIGBck6eYO0bGK+ogiAs9VKUqtCJy7adF/ijZmgkXRqOJGj
         /cuRIiVW+pnDX7rljZYEWUXjc9BhthANv7Jfx/bPIEo5dOtIcXaNPlqVKlrGlseA5hHR
         GTdjtt7prmTnIqal3m/AWKrCgkj34VLBDvjjsORrNck7txBGNu8FRLA+f6ySccFWdVuz
         sE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228592; x=1719833392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjYfRpz7d/pnzQIIVZvDS+ZUuV4pfFWfqrT+udRi1Ik=;
        b=Dbhccb+tiE/sXRIH6jzTtQUY2y1JOHyb1gKXw8gdj3urkAxr8mqKwe3werB35cMo9Z
         Hb/koyhx30HqP2aRN0Y4bVh+aatyNcP9BPLALxeAgZYTOshNM8JK5UmaceGevJ9/2zxH
         JeD80TIjpjXo2LHZ3dbHeNaoeluuDU1I8zb9zkIzDbaYCO7FHcFhOGAUhqBP+6nj8jAF
         sfBrMwWE+JdQSj+55kLdARfrNfXH+8uWaAeKoWsh4ieNanqB6JVmYftNrMPG89l5yULy
         HMxlcnuqOXT3kL1Kj/HADmu3tYq5S6RgrL9TseLkLFMpsACSX3K29qJLyoJjGZBjXAPd
         9eRw==
X-Gm-Message-State: AOJu0YzRmUI72tS8aOCXTuaIEet9mU2xJdOcGmNiHivd280pulL+332J
	2Xd/svZN7+jQKZnMrMtVgYsXRleszAqctFWY7GM5gkPkAZSiyVe5o0nF1+ewumIaycGykWcBqKS
	S
X-Google-Smtp-Source: AGHT+IEYFpjNzJqZz1X52HW55PDAihBVs5WcgiJGKGMSIFQauATfpGgyV7xod+y+YwXC5ArJlC3VsQ==
X-Received: by 2002:a5d:4706:0:b0:361:2b2e:f6dd with SMTP id ffacd0b85a97d-366e94d81a9mr2558663f8f.11.1719228592352;
        Mon, 24 Jun 2024 04:29:52 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:29:51 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 07/25] ovpn: keep carrier always on
Date: Mon, 24 Jun 2024 13:31:04 +0200
Message-ID: <20240624113122.12732-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ovpn interface will keep carrier always on and let the user
decide when an interface should be considered disconnected.

This way, even if an ovpn interface is not connected to any peer,
it can still retain all IPs and routes and thus prevent any data
leak.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 7e3e9963d2fc..d0abe8b91a86 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -50,6 +50,13 @@ static void ovpn_struct_free(struct net_device *net)
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	/* ovpn keeps the carrier always on to avoid losing IP or route
+	 * configuration upon disconnection. This way it can prevent leaks
+	 * of traffic outside of the VPN tunnel.
+	 * The user may override this behaviour by tearing down the interface
+	 * manually.
+	 */
+	netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }
-- 
2.44.2


