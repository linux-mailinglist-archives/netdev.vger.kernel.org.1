Return-Path: <netdev+bounces-128624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A4F97AA1B
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE5E28A01A
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5A23BBF6;
	Tue, 17 Sep 2024 01:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="L/avxN61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318FAD4B
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535289; cv=none; b=XZ4qEHwhbCuZL0BEWWha3cmaizPz+98ITk7ngfSP1UGoYE+LYaJfUzsSennmudrwYsd9VrIGlNKrOrQiZxdvpLvQcOgfBn73nk0Vblc4dPMdWGAbWEnIFoMQUrQqwDv7tGo20bUKz2TMlHrCdy0XYKV5XLmEPlRcFxkvk+V9N9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535289; c=relaxed/simple;
	bh=Ip+gEUjkTTciL2viWWjPpWlYUWyegyyDe0GMsWqyqhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk/vcBcJJtLNDFeSOgdZSdq1hEZFqSdEK/Y4L5O2mLXkDYTxGpg2vztDRaQhYipERzi5PzQkgQizRGFhOTeHyJU/lRFr75Q9oU+PV149mtwFQQG4bLHtcDFqFOTFDzxfLXuBWS20sDm2Z6k+La6UnE1ZV5s55DXUPRIoBbZ3mLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=L/avxN61; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so31543185e9.2
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535286; x=1727140086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFB8m03u/JZ3laaimq0KAAd37IommfjQNAb2BUK0jWM=;
        b=L/avxN61tMEtoBAfLM+/3UkK47MG/6bUkdO+1slQghfV01218/0ZhbCR+URYdOw0vW
         F3+WurotxL2Br/fK9F/z4Iz7fNQ/ePe8y2Zmsa4+oy4uz2advsYrQkHRnYalhWXQnYwY
         hYopq5qZ4gT9la9nFZIoYfL5jMkXw9AzpWAG10XGdclgjAslM/uikhVYrsq9nVFmkFnv
         6D84j5hjNDGIN3PCQMnzIWk6M6kVMWuZKp2AGol39/C64z40RQ1mON5CzkzJglWjYxGu
         miI+T12ay4tfXDImDYF3t5FizMHUa0hi2IQo1U8NXtiQ7V5bFskuAGwv1TXjB6EsZyHG
         9H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535286; x=1727140086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFB8m03u/JZ3laaimq0KAAd37IommfjQNAb2BUK0jWM=;
        b=WHUOOW4lPtUWSF4jBZLE0VEfPsaJW8Q+yaqO0YrS2HaIhNVhHsNEJ2q01vAKL/zu1b
         FgPusv2i/SYbOTe8iBpbZzpUp+QUyLVj7DBeCr9PY4obRMijW1X3ka2rVRdPWkeuHJ+P
         L5zAz61e8LAz09SIUbpsxl97bQ0kkeD6Umtme5ePYG7ECm5fjPA4gPBsU6m54JyVH7h8
         yd7UR15qHe1dDJnCc5TgOUQ1Ib1wZjkIZzK5gvz76G3Xu18VBCGThgSEcoDyj2WicgxF
         t7rF59NzTY3dCMFDvbD1rs6Z21p9TfchEiXwDG800yfdb6d9DFY9d1aLyp555UbYbw6W
         3b0w==
X-Gm-Message-State: AOJu0YyrURdwBaePaSDGOWI/ObebUCbH5wJD2fCVJVxLq6KGMpoU38lW
	6QdUkjh4t03UoKY/zLrw7B/aUYOc9+ji/vaKs+R3b/jXfySu4P1iSizD0xcgEIYKXfyoUT/WRbh
	6
X-Google-Smtp-Source: AGHT+IGMdqsPDj8mEJa8j2cJoFK+hRzKxFpM66kykdY8iqoh84mLCj/0BVxIudeCuDFbEBjTOohU9Q==
X-Received: by 2002:a5d:4dc6:0:b0:374:af59:427d with SMTP id ffacd0b85a97d-378d625a26dmr6916287f8f.49.1726535286080;
        Mon, 16 Sep 2024 18:08:06 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:05 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 07/25] ovpn: keep carrier always on
Date: Tue, 17 Sep 2024 03:07:16 +0200
Message-ID: <20240917010734.1905-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240917010734.1905-1-antonio@openvpn.net>
References: <20240917010734.1905-1-antonio@openvpn.net>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index caf34f03b6f8..1f965d6ace77 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -46,6 +46,13 @@ static void ovpn_struct_free(struct net_device *net)
 
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


