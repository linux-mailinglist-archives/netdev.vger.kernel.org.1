Return-Path: <netdev+bounces-248570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB5D0BBB3
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB9A030158CE
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366FE36922D;
	Fri,  9 Jan 2026 17:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B9366DBA
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980540; cv=none; b=uKv4FOD6yQye4lD3KdrxdZsP/+1yhH9rrbUvl+nq0w8wufxUtvYXwft0dc019hgRWFLjflu9Ooqx0pzIemRprKM13EQ5KLlrBThaR3zFQLZEg3JNIwqy4b4OBglHzPDRnuyUFppOC1AuXMV/bHXmlRV8xwGoIwD5yLXk5kTbNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980540; c=relaxed/simple;
	bh=tU535M0GY9FyQ8mWK2BHQ8gb8VNQ7ucJhAwMu0Rw6ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AFnyCrZaCv8B5LF7P9uDszKPhFK+OYvxzlN5N3JYtJvR5ycthrXhEI2KjNBWDr2I7o8rAEDhirG7hs/2LJ0EsZrHCLpMkvYbUB8uCnavjcpnL7bGLuuHFMic7/UWcaLcsqZByql/ahRotHUTKqkdusc0QxIcfWSo0X4iUmHLN0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3e7f68df436so2338264fac.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 09:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767980536; x=1768585336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9xTp4jaek5ypFmz7UFVBs3jQhPSOjK2UhBmvUfaPLF8=;
        b=D/qGkt0FyoSFPez3lhO3epyAH3GikR9CuCVFcG9q6Mv/hYkzf7C1eJfwgTnf9NGg1F
         /HEMDQwb311GzxieBWfkTuVeCJwMwll83qTYfLkSqTIhuvHHG9WX+C8EsWNqheLAww94
         XypFCeGl5hImmY2K6QWaNzwHQ0yckdMXNGsddwK6wsxNzkHr10faP9ww+lgchSbzwEXY
         vD9/1jY0OKzX3FwgVbiJ3pFSoGoJW8Qz4at0DKK3RGT0xQaDFs1/pc/pvwpsSxhGc15z
         hYPlb+HAz3xbhg9LHdGOtuv4MNSN0s1dokHHDZJs/LwYf8RTHWyVDh3PgdPgzvRiBig6
         q+xw==
X-Gm-Message-State: AOJu0YxKHbWUpBh/4hedPDoyRG4BHgFoelgDL157d3IFLOCNozogedjN
	42C5PBr0eJkJ+vEYUmErc/BEazgEOC+jbNobqRdeVZStUHX6nRo3joWp
X-Gm-Gg: AY/fxX4GIApMd9Re7SXCC4SYdXDsdex8upZCu+SwfgTXtDH2gNKlxQwletDN7qcIJEm
	QWLvmF0EjRxoIEl1+gvG0nqS8DnhZwE7AZs756IJCydJVQjtNPqRlD46NK+FYpu8HTXozAsD1oY
	625zgxyqu0am/bNg320H9ITzMNHHzBnSQUTKxlCRR++V2ThSAgvNxJ6Wizp0UXrwNNhHfcyLJLZ
	V0tCjflhU3VwY4KZxsRP1UkXZaK2/HeC6Ws6tstOoXLo6KT3Yaa0NHaQCpyAjjEtK+FCPUnMtQz
	PTLPob2G6j1fuPY6VnapJ4jRzNeaqPuhqtSd6kuyWJxzzl8ZxcWyCrFnV7zImNfOvqoCXj9xOzL
	YAtQirMIxe+N6KzTjf/uC5SZwvYAFcWVY0UWokhXlmRvLAHEWpn6ONM2WFU/2MbvDPrnATNrWNy
	PO7g==
X-Google-Smtp-Source: AGHT+IGDKwjKAy0vTmDz204fXsFfJKa18HGkRPg0kSvzRcw96dIsJGdkpkkiOqWgwnUnG9Lax1dfcQ==
X-Received: by 2002:a05:6870:320f:b0:3e0:aec2:8b50 with SMTP id 586e51a60fabf-3ffbf09f3bcmr5979858fac.22.1767980535772;
        Fri, 09 Jan 2026 09:42:15 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa5072427sm7148925fac.12.2026.01.09.09.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:42:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Jan 2026 09:40:56 -0800
Subject: [PATCH net-next 5/8] net: niu: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-grxring_big_v1-v1-5-a0f77f732006@debian.org>
References: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
In-Reply-To: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Cai Huoqing <cai.huoqing@linux.dev>, Christian Benvenuti <benve@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>, 
 Dimitris Michailidis <dmichail@fungible.com>, 
 Manish Chopra <manishc@marvell.com>, Jian Shen <shenjian15@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=leitao@debian.org;
 h=from:subject:message-id; bh=tU535M0GY9FyQ8mWK2BHQ8gb8VNQ7ucJhAwMu0Rw6ug=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpYT3x6ByFQI+KerXkQEDXHmJlJsbQO8qB7VerD
 mFdreLb+s+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWE98QAKCRA1o5Of/Hh3
 bfZpD/99c8Y+E+uIRhOpRXr2PokQdk2b4g0wBkVzbO+xahgxT07IBsWP+xDiW1XdJWaaYkvEsqX
 nViIhqLFiXjz2KzbaGNGZpjy2DicumiFAIqBuKcNqnHTvzS8zvTH4DDzfn2MbJC0Q3iox7VxvQk
 soXjD/MS5mbPlYR8wmNTsZFVEEr8b4QXBhrT6oh1i+Tm+2oFt0AZblggevvgTD1tbnRKucjP8Sb
 Pk5ntnUxjYwMR7xjasnFQl6LSXe92QwIscaX4liZaGQtLses55eV8ZNOE0zwtQSDjf5ogORq+Ep
 z22FQxxKzoPeXAf5neJUFXFsidftk/2JQHZRM4Yrf+hfkmYG1HkwYyKk9gJPikxWZT0o2tQ1tF4
 mf/Ic2IAMKXUpeEY3BvOBpoYPjP2lX4bZ7wKbTmqzS1HTC/297RlBDwNdPktcj2026zJGPwNkAi
 ZLeZQMGEjzOAtO90533hzvplw3eJNvnLHQjp5t0KAXCCcusu92SoPqOSARBkOML/4hClicRVtN2
 UwfAZpJ4/FoXRN3BWPcph4SbAnDkflYjUrH8acxkQypXWeuI70wEf9WYgXaU6Bjkd0tOv7Xyi0J
 bAoQ43+VRmzLMzGroxjdOK72FRghKqc88Gd1YfpXZfx2etZofYva4HueNYvUPrqsH4v2Zm3bkhg
 ExoG1F+7EJQk3Jg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/sun/niu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 893216b0e08d..f035e3bbbef8 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -7302,6 +7302,13 @@ static int niu_get_ethtool_tcam_all(struct niu *np,
 	return ret;
 }
 
+static u32 niu_get_rx_ring_count(struct net_device *dev)
+{
+	struct niu *np = netdev_priv(dev);
+
+	return np->num_rx_rings;
+}
+
 static int niu_get_nfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 		       u32 *rule_locs)
 {
@@ -7309,9 +7316,6 @@ static int niu_get_nfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int ret = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = np->num_rx_rings;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = tcam_get_valid_entry_cnt(np);
 		break;
@@ -7928,6 +7932,7 @@ static const struct ethtool_ops niu_ethtool_ops = {
 	.set_phys_id		= niu_set_phys_id,
 	.get_rxnfc		= niu_get_nfc,
 	.set_rxnfc		= niu_set_nfc,
+	.get_rx_ring_count	= niu_get_rx_ring_count,
 	.get_rxfh_fields	= niu_get_rxfh_fields,
 	.set_rxfh_fields	= niu_set_rxfh_fields,
 	.get_link_ksettings	= niu_get_link_ksettings,

-- 
2.47.3


