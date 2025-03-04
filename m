Return-Path: <netdev+bounces-171438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E7EA4CFFF
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27891895F18
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED0130A54;
	Tue,  4 Mar 2025 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fHmWgz86"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE17083A
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048475; cv=none; b=AhyfzMQO16GvAcQrfHLAeJAAH2GBl6EGhwN1/zv2Zd/cVFcgSTzgcNW2pwZ8i61TXEKdEm5gwIl4SOJOsr2Z39FAagc/8E+j/QagBFpq61nbrz74OQENrir15atFt6iF9z/fUTSRwUlVEmp5oof3v4QhILJ7F4EUmBlCgRiBhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048475; c=relaxed/simple;
	bh=/xvou7dFKioksUHeuOvCiwiW+/ZP6NzsNB7blkKp/EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYQcDLU+JOf4gtry/jMGxPX89cWgxgMWCyRgriXhuysJhGRLkH2pR1m49hhvPfSrHVg6Yu1CFTMqcte+dpHs/b6lGv3Ohys+KpiEVQi5a7oJSyaShBhHL0JcBejysvHPFHmJXtBPvmR5AJogWgCF7iy//eSEYMM0POJLWZEGAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fHmWgz86; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390ddf037ffso2682401f8f.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 16:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048471; x=1741653271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9I2Z6bR8zx1eteSpHnDKlkOmZth6MLuc4W0LAKMNv8=;
        b=fHmWgz86WKdrACF8U+n4fOo286DFZ5kvnI5F4bQSURyNPk+c8oNf4OYHMOExGCXnzR
         ypmp6zuV4L/FxY4ne/yT6Oc89jDvDuSjLlSBrK6pAwyAJRWklbm/9bL47njZka2qLxFA
         XTJKvCDynygQejmCd5o0BmZC/z/gHjgtwc4taJqmSZKfnV8q4rF+pnZf/745fHwehPzF
         684Hz1BH+7tAfjHzupzDGYNVglHh8Oc7CCDryvEqVI8qe64v7ggFO+53b2WLKckjQVm1
         n5xyEqBvY/h/r/OHFjRDIRIHtOH/KKwgwxiirOCY4ii558N7dOf3izEJtWVQ+TQknsbp
         DyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048471; x=1741653271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9I2Z6bR8zx1eteSpHnDKlkOmZth6MLuc4W0LAKMNv8=;
        b=GpZ2G/F5SObDDdkCxlvcqdYqqZZbvt7iW1G+r04jW9eEFzUfSUKOVmASt9kY/HKzWG
         N9gzcjSVnn0+cYwLA2QQuD1B0t8hJHltj9ZOQVV66aPM+laMe3eccjuuJTngSbX2BxRS
         i5kkQWuaL1ATCzHukXwEksexhKCJN9LOwNJqi/MOHb5i4NbYvxKYBHpf0L3b5WhwYHXQ
         cSyhsUaxRxDmBlKW8yZ+ViNXdXX/TCcLlI4X3PbkCAcVQaEYWdSqZFTeVXFq2gBDoWNb
         9bRxTa7vJerjtjCQgEiX36w0qUWpQZuddHN05NV0jfl4t84kCifEgfYD2Wkldlvk3P37
         Ra+w==
X-Gm-Message-State: AOJu0YzrNq+a4u0FJtBDBDHRz46y0lgBAL2zqXPgYM+eKtj55Xdjjuuu
	y9bQAbkFesUghIQme7coBqw9dYa8zAMWUJHT1mLFrxCOzdZAUlgesLIVW3YjHso=
X-Gm-Gg: ASbGncvQXJ0dFyCFUaVG5hClL4SMw2Yb8ZiqyjzboEEmgrTR74g8wszaZnmRlN90DyU
	ujlDSSCaglNpCBcdx2mjvhQ4mNeFSOMh15s9OAP53Bp2vZki3kNGhWboupH8t4tYeCWnoGwCtTB
	QscEFIk5sWCUXEn0rP8xDTarIfzAk/4pABx6D03PAuGQoRct1PyHAaXqeUxNkOfzweD+3kL75Ym
	1QKnnTcr+jfHRlXW91JKTSZ+U7OvIhKH/YxLNSOfWZx8TQnmcwXVaIKqbf8xo57JFG1y7mJ41AM
	eH8KjcB30xxMaauFbmerGeH8/DhXhdBJIMwcBNN3lQ==
X-Google-Smtp-Source: AGHT+IEHKKAGAd1BjILOXEzGWz++BEzbTO6UvfRsSajZRH+vqZG7TH7Oj0Jq8rQNbGDjEUn1i/p1Zg==
X-Received: by 2002:a05:6000:144d:b0:391:8a3:d964 with SMTP id ffacd0b85a97d-39108a3dcf4mr5634205f8f.41.1741048471577;
        Mon, 03 Mar 2025 16:34:31 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:31 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:34 +0100
Subject: [PATCH v21 04/24] ovpn: keep carrier always on for MP interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-4-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
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
 h=from:subject:message-id; bh=/xvou7dFKioksUHeuOvCiwiW+/ZP6NzsNB7blkKp/EA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqOiqtup4/iW4MUmgJD/JzGESLgHkMMvlnBe
 lZiJJs0QPCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjgAKCRALcOU6oDjV
 h9gDB/4saE7fWQx/F1lE8cYzb/KDXp1q0seba4+yMg6PT0W+V1ZYlx0HqgT06ZRO75IVNsRuALt
 StrqVCU92RA+XYs3L3CxDoK3EC2qzPWrI0JOe/Xp+guzys7+lO1PtAQxpJ/J0zP4IblX/+p6Tnx
 lKf9gai+bBO3+gUj3m+Adhs4j2tLyssocbxFoJcQap98f9szyztLIw1xgACdSp2kD15I3cyVGhi
 0g82Au5aAcVpc5ive9gdWndTmdZ2XZ1Mw/hAYErjupAVsBuAT4FfXXBeOH4NfihTKOEb1ET0Dc0
 kmfa9++9FN46ekTuaen2mqPqMq+uWt0WFv+RWCC5ZGayfazV
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
index e71183e6f42cd801861caaec9eb0f6828b64cda9..c5e75108b8da5eabde25426c6d6668fb14491986 100644
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
2.45.3


