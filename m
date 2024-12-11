Return-Path: <netdev+bounces-151219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1209ED89A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A091673C0
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5B11F2C2B;
	Wed, 11 Dec 2024 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AvaPRk6X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53D1F237C
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952773; cv=none; b=a7tKqw/E/wJlt3cs5cM293cOdgLVVNeIp5TRPD3R0qmQU+1a4sSWIDj2rFl4ADhjRedmIl8xnYmYqyQSp7gR+p+p2gjX7DuHdNlyMk+lXTIsmdl6wKrT5aZIUHFWQkq4ugM/wO8VURNe2LmYt+X3O+M39LzUhLKmjDyJVoz6z0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952773; c=relaxed/simple;
	bh=GchxL43RZVWbeeTak50ypiKEh4su8ul45OjPZ601Tf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CT/McypMfXQ9QKGtJ4X/lQ/M2nXVFXmjy0M/6182IY4v67cFQAwYBGhe50sAhClvJEjKXBcreQJI2+VemDMAGhaVBcr8ja7dbceFh8aqVh7znYak/VRhSREijeFrKKXKTeC+CPgW1Ae1xOdLrPkef+YN+T8JGxTyhBzBgJmSd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AvaPRk6X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-432d86a3085so47893675e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952770; x=1734557570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFk85mO/CYRQjFZfRXq+/JqMZn31zCiBs+VMv6XbtEo=;
        b=AvaPRk6XCPvY14z0tFqVl2Q8/8ys9l2FfLSVgrDnCZhOd8XDK0enTxJs1xPDI9mFDJ
         E8OiVVsCEkmMlzsovST01W24OJ/iOSRZJmu8jOc9FlLb9cTJWSvHeQm4BCSyOPuCakcj
         pfQi3rcufISWwlZzgQGfQW3s9MnfThLvppJ/rzELLF9LuIkSOufGdF+lVUCwwgRnkM5U
         AkKFJNFdYfFytuq10zaXkfxFmH50DOq9sgtX5w9UwLRRrynT6do3w8Gc+VLrQPsdbAXK
         hi4JclW5u/a+Dewyae02LZoHEA2uIFt6ZyvL5wdJm/lrgUk4NcvXDGBmrcH2D7zZMato
         g6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952770; x=1734557570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFk85mO/CYRQjFZfRXq+/JqMZn31zCiBs+VMv6XbtEo=;
        b=c54F/F/1MXYZGK6P9HC5l7i4mwgBaxIsoknqzOqyEEfp63ClahtG3xu1n4LnR1TaH7
         dPBkGsLXLVrsAfisWxpDS1fT4OH+EAGOPAVlCc8ujHmzwqLs2b3enI4070zOAPumP/Rj
         lO+eoVLHrT2rdXAJpcD1D4m3H2O2lfL3Jpa2OgG93ASLe75bYHV527jgwnmVxuK+gR0l
         v4Cp1SGyrwRaPj182oH0VRtNMN/2cGMRDo/bKBLXVBolhrsOPci9NxnrQEiX5gGTDXRc
         /2uZq0et9rFmDEceOyFd+WwIh763YKZsJbvUD043WPcg82ZaA1ByFd79hK3flFpF4Q8j
         Fk4w==
X-Gm-Message-State: AOJu0Yz74WIgEd2GZ7empnZHMZ3N0Uo1oCvn4DUUk8otXcRO1thm7svT
	IodR+MNbcoLApHD0Kwi7DDjM5kOWK3brbrYLOsdiXRTTarPUva3OMHv4Wj/OO0Rae2d50LtUx/X
	s
X-Gm-Gg: ASbGncu0gSkY4PmFulvCvp8fIpA4CinEij8kv6E23/0O6D9wSZbhcv3N+uLdpUdnHTp
	XSVYuPxDxtDAA+9hkrx9jd0y7Ks78/w/1qAa39j1DRiny+sjzLm4ONZ7KeKz3UxONR6T1OaSbaS
	GCOcc51zmXkArO8unOF/oa4DtGXQS2F52afQO2IjM4eKemeHglToXc2ZOSD9ub9796WzTwFfC3+
	Kr6OxnOhCiNdza87XUjMQI/oCJ3n0UwgafPKj6xkCtHPCsri9Sns54RCEECwAeXgg==
X-Google-Smtp-Source: AGHT+IHOLwkY5JO6rLcoMM3bjyhpEEBshYhAf3iFv+DgDiFwDrq4wvIyZMAmOhpA3SShXhXMaP5Eog==
X-Received: by 2002:a05:6000:2b03:b0:385:e3b8:f345 with SMTP id ffacd0b85a97d-3864ce5dc32mr2355693f8f.30.1733952770248;
        Wed, 11 Dec 2024 13:32:50 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:32:49 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:08 +0100
Subject: [PATCH net-next v15 04/22] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-4-314e2cad0618@openvpn.net>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=GchxL43RZVWbeeTak50ypiKEh4su8ul45OjPZ601Tf0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUkj9iqYHMbkR8+3Qdt/A5EC+YC2cnfPHXmO
 Q8LGxxdk3+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJAAKCRALcOU6oDjV
 h8GzB/9+2y4h6VU2/h4mPAUS8HeoyZlmz1QBdbrD7cmh9GFr4rRXGoOYLmby2MDA92uYIw+mNgp
 blzCY1mvt9eSfBZwsM2TNqN8yoHM21vLYS73KeoTBruJdOVPyg30OmQroW1OfEtFbAp2dMlkkpX
 T1q/JQ6gbj+RPNzUmjI4TzuPtVw0tkL//gRcnemqm9t3uxG0P9J9+YfyG+Xp3azTP8Z4X0bvSYE
 d+wZHwikKLuq6JglVahxwiLG5is+x4EE2ObC/RLfnt9fYa5AoAo3E1bhIgwT8CrgpkvG1FMfcfu
 RRWZCtg441kaFJ5EXnmUrp6L+2dwq4zcaOn70um20uvSTKkG
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 60954c5b2b9254db1d24d01ac383935765c7ce5b..274d6166741ef2d6275a252d0c042bc66f8f41f7 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,15 @@
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.2


