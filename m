Return-Path: <netdev+bounces-179899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3395CA7EDEE
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CB33B3EAD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B920D222592;
	Mon,  7 Apr 2025 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RXzXb6QN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125922172C
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055234; cv=none; b=g3uqc20a4XeU2CUswFPGtqwq39gwk2gmw/6HLlZxDQJSPJwdGQ1JK2yn8QLfkfptE/nGCW4qiDN4vNidMFazKgJ4dxQ3IgkXmdHb+eAf9voHaeps6yLgMNQ+ngtKGq3WxQ3bSfB27sGT313d/bD4OoZzMmgZ45ySb+YvJcYie6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055234; c=relaxed/simple;
	bh=HYQVkKLDFS6ZhRYZCyfXaaD2XhQID0AqorjlTUWAk7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U65zePbGI9xZMyWBb8v484rwVFOQtSAONGVqhwqPzfZ+hRJcyOhe2C+dqZNYCTBbeg0DI30uaefa0M0aNqX2x34enlnrs+mjmYBnLNVvczwjLaQnPFalWcRLCevUIsSHSLJjdQEDLSVMJo58CX4o2dcCQ/fXWaiK8BuXsLPEzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RXzXb6QN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43690d4605dso32397325e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055230; x=1744660030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOQgBVRGZZnoJaMDdwTp3tH6v0mrDf2JLRZw4IaOnFM=;
        b=RXzXb6QN9EQsV6NaVQC5M969gcs2EkufdBE8eoXnNANX9s3e+V306M0qhORswPxZd5
         UXKel926PWlEa+jh5KAVnZTAOOZh2YbJWD88k3iexmfu0LMY76FTw+FW2SseHgHd3p9k
         zpHdoz0hdmGEmVK5F/O2WHwMOk3vBXJ0pB0tR9BLLtVM/epTIOvYY8rxBYnkcYfJb9LE
         zkbw6u/hY1F3RTSo6+8xxJ6AIzERGU9b/o64yiDjxxlfRfEMz0bMex5HEerUxz+PWfme
         2zwMifCVEgfDY/qiH0s94mOwy6JCuZl6PTSPpIFTJxcP3U7zouYPoGutKSM+H5OF5gfU
         GYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055230; x=1744660030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOQgBVRGZZnoJaMDdwTp3tH6v0mrDf2JLRZw4IaOnFM=;
        b=SQtnHBc0u4w6q15qDKQxq2rSAlWv6gA531pIYiCd+o3oypXk0U0e9P6v99BJNKbMOW
         JW9iCIq/6t+r+7x9USitEZEBT8fogVd3RYi6SOG4fcXvV/ZX6yiBUtxsSJCmhDworwjc
         sjwl/hHT6re3VeAOcPQut1gItnZwOn2i1R61ooERItQfF33ZOMlo5S5MqHBQZdyJQ/7c
         2sSQWhO2sFYbgm/FxG8VTdCFji8NjTS367dNuhFZ1TOuIBzFINVjfBvELAotJ1SUk79I
         kd5DRygLJuwOU3EgZkESTcWvNPEy/gvu1ydbB3aA/9/TZ4wMIJ3F9/Vj5ICBokZy5cRl
         5L4w==
X-Gm-Message-State: AOJu0YwIXqkMxctjMcotALK2M96DOJFRE29luA/nbMtEvHfuh2Iu2REm
	mNPMojiBAoPY9G5kSz8Mjn4+/DvSW8x4sgLwwJ2uPf62m57HY6KW7ISFil1d798zu86ZhIequoy
	ubGu75CKySjP3CtBQrlWmDhesoP1wswBVbqI75jtHm2KHsFM=
X-Gm-Gg: ASbGncu1/nNsYoFl+9gNlCCXiDt/m2X7NrEdIVvKDXey1FBSvksLZKQNTuZ5guCbqjl
	nPiPdrX40L5qP3pVcOvtt+KaDr4CJPgZxYMDDpR+wvufs+JV6gMnpjiPQjx1UGR0gp9yil7nrQ2
	lcprgZO40agj+DDV4k9gDsjR/s6eKXJ6XdSvYZW602jy1Hb4qyYs6+O+NZi9WejDRiVhVTxf2l6
	ej8fnctAKkqQ0WGVwwMrbVs62nfYg5a9VoXXD9iAAptXSe66erTtRBXFCxjvRC6xfxOYcYuylUW
	9NVISs7TyxIMVSUNEWBeK0LsXlXQ5VbFc0pAppt++Q==
X-Google-Smtp-Source: AGHT+IH7K/Tlr0afB/YVJjvYVZD1E9BMMpbFJRVzYZ2AJ0Otgp/R+8NHmsxmYmrUdlTrNBZMsz48Uw==
X-Received: by 2002:a05:600c:224c:b0:43c:f61e:6ea8 with SMTP id 5b1f17b1804b1-43ed382b5d7mr81964505e9.2.1744055229934;
        Mon, 07 Apr 2025 12:47:09 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:08 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:12 +0200
Subject: [PATCH net-next v25 04/23] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-4-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=HYQVkKLDFS6ZhRYZCyfXaaD2XhQID0AqorjlTUWAk7Y=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu0FvOEKMZVtzfbyq5bW8/fm9vO3C7TcKS0b
 MiFlermb0yJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtAAKCRALcOU6oDjV
 h38pCACCFPtQsZaKwjmUaTeZvKo8tiuE4keb8L9Jphoa3KooqeyiNozOGm5FOB/sfTNtObtuptM
 vC/vNKx5wZ38c7M7BX5BN131buo2nCPrnz8HyOKR5bSITkbRALDGNwMBIMbPr1N4pFLMmAWeeEF
 ElzPaVC/t+vKgDXmfLkcvV5hrfABLYjxRvuTFvXs3s9WsDnjrhPY4ixSyOL0Mk7uCfZkuSx5JRi
 42xHfgJkL+JDzOrUo0TMan4C4rPJE3OCId7umQXNbwN+HOBsYoLgFdYXtjjKKxeZVSwwvMAfaWQ
 wEcAZ9FYr821XXeZWMhVwUYV5qJO8NcFn9GBpW7Atr6/T44/
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index b19f1406d87d5a1ed45b00133d642b1ad9f4f6f7..15802dfd26fcbcad42c387d42f665b8b47604e8a 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -21,7 +21,22 @@
 #include "io.h"
 #include "proto.h"
 
+static int ovpn_net_open(struct net_device *dev)
+{
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
+	return 0;
+}
+
 static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_open		= ovpn_net_open,
 	.ndo_start_xmit		= ovpn_net_xmit,
 };
 

-- 
2.49.0


