Return-Path: <netdev+bounces-197731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E753AAD9B2F
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1239F1BC25DB
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115D22578C;
	Sat, 14 Jun 2025 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR9XpLhR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DA21C16D;
	Sat, 14 Jun 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888026; cv=none; b=NrayW5o16CkBo3BEMr1jRCEbHA/OL13BMbIK73n3JLN/Z9szsKX5lFmPprimC332Zk+b7fo8SfyPayVZMcoGqz0Cnr4rGzPNb/C90x0jMEu3JG84FIsfkWGB2lAwqVTw+pOSwaqrdHbAYCi8pq2gh4/ERRPcEeW6akPDpTJsRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888026; c=relaxed/simple;
	bh=AOUAt4WsK9h2jFqEUiEg0QCtGpg0pvfAZSiQna9cFtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOFWx9CAnZa3UKDAfxYdSpdw0aiQGWYhGo6dmdIXiXFs/HjA75aEY+Wbdb0TcBTgVLO7lgGTt3aVHqQxs4ypZqPpmPy/Cor7oK/0UlBUz2GKDrnXbwuIeCWQg+qK2iy63h3sqZgiQyx6Dqq/tKbAntiG9ZFoy8swqSqe6tsdi5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR9XpLhR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453398e90e9so9767535e9.1;
        Sat, 14 Jun 2025 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888023; x=1750492823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kAjKQ5iGEvQ2t0m3gX/Df24pB5yfsoEgo3X+blIXQ0=;
        b=HR9XpLhR8qKzgq0NYg2ibY4kAA18bP8HbZ74L83Mgh46Hgn4EYt1v9VgLrvY7QCWxC
         gxF+M8GQL76B1/ijsPVPA25NvJjG7tHhDKs7ZzcR0mm9x1hKGXykCphUSDq83tbCg1jU
         9hLbHfRYKyd64EAfge0fXRZ+UyFXTHwCMMka9f24UPkHtbx3YtSPtiCZFSB8i/mCIlDM
         3HvO42AxE8yzb4d2aL4ltYlnCrGWqa/oxuu7E2/k9k1O7eCV8F5gLlL8TaUrbIbyFbIE
         QhJrb1uRLKDIG0T8WPjqi6RnWdnIT1z+Br1tbRu4Bor3jlRs32vAP+2BzrzHfeCToGBR
         CnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888023; x=1750492823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kAjKQ5iGEvQ2t0m3gX/Df24pB5yfsoEgo3X+blIXQ0=;
        b=LiEVYvVR9Tx7AZ+cyspVJoG+gG8im+Xt4jgckM7Lu8540aomzi0mokqgPzd9Gp4mBm
         SzLWIoRJLugHWV1Nv/i8HEH9mPLM9dfZhyGnZA310t4n16qz3sOp/tZkaxaMmjuM7k1D
         CysxZ/S/9J0ADG2UNqyFssaaWGBNRk3Sy5diUCpUETCiSyqxgjev/5z2UC26vVTbmO2z
         OP4E5wFSV9P4kujtcAyLKxLAjBSBfebDYD+lTDJ0GcjcixG/g85Xr8nnSliDWjagxpHG
         cdRdpnw3IPFRnvlPjgtmkOY/MVx1eJsm4c3jNywc6fhGkG7kLGpdMLPyp5/Fvtx4uOH7
         zf1A==
X-Forwarded-Encrypted: i=1; AJvYcCU4BUrSIbqf5QRVSJPBTVqP3wqOeJWb36v/I14Q7lLG0eJmZz0YrxfaNeZ6wr2OgEBExrlbZbDw6TU5eHo=@vger.kernel.org, AJvYcCWwvHEvWok9nTS/3MVCFVk/7cr9hLwYEwXhTKfJm9ANVfAcZ5s2173w+4EbPpxgyXdig1koNPmu@vger.kernel.org
X-Gm-Message-State: AOJu0YzsN857NI6hFepLmwqDikKr0/QMv4tHblSJGbMHQ7G2dIeOarsd
	kfZ+Q81KRZNwnY5W3wXzPd0v1Rtvp8p7i4SgSVrZG4CMJMiBEPnDxR+T
X-Gm-Gg: ASbGncuI/91N+LYey8i+JKThDwlMw0Wlbc1YtV47jvsvbPnGWnrws9rUIj2KS5QJRrr
	OBYjnrO41TK/pDhzCGsK+lLC/wfLIWPZ2cwEsJC6sb7TYJ2wXv3qHNrSVo1TMVHEWvikf+9wyhr
	HztAAxUuLI3+aKkhQyW6RoLfcsPLoh0QKQeTyWK7JjZ/Fnm+R3oZeL59G5M190+IyZ8qwtBuHTM
	DUkD4m20sZFMxl/0t9ALhOpu070ssERuDXIz8OpjAk0Rk/gFdNSKXKXOCPAuymFZCbQSvHoG09U
	Uddc6KE9bBzmduJD+8QBjZarf6seD/U/vxScfUTdxakAH8vRgZDd2tqpLcDW4VwpNwyRD/nrRQl
	ZDt2JGlv2AcKsoLa7/tD8VZVWJGcOeS3UE3b0+gFGBgkUvh6XYkZUW+2Mh7XMqJ4=
X-Google-Smtp-Source: AGHT+IHEx0ejGPrN8nGm9O3D/4kVrUb3sg+y5AFldZN0UpMM9SqJxd8uNJMx6yHnGuhpXL6gpaSilQ==
X-Received: by 2002:a05:600c:8012:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-4533cae684fmr24974075e9.11.1749888022608;
        Sat, 14 Jun 2025 01:00:22 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:22 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v4 13/14] net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
Date: Sat, 14 Jun 2025 09:59:59 +0200
Message-Id: <20250614080000.1884236-14-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CPU port should be B53_CPU_PORT instead of B53_CPU_PORT_25 for
B53_PVLAN_PORT_MASK register.

Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

 v4: no changes

 v3: no changes

 v2: no changes

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 6aaa81af5367..29f207a69b9c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -543,6 +543,10 @@ void b53_imp_vlan_setup(struct dsa_switch *ds, int cpu_port)
 	unsigned int i;
 	u16 pvlan;
 
+	/* BCM5325 CPU port is at 8 */
+	if ((is5325(dev) || is5365(dev)) && cpu_port == B53_CPU_PORT_25)
+		cpu_port = B53_CPU_PORT;
+
 	/* Enable the IMP port to be in the same VLAN as the other ports
 	 * on a per-port basis such that we only have Port i and IMP in
 	 * the same VLAN.
-- 
2.39.5


