Return-Path: <netdev+bounces-267684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J1NFDQYtWkBwgAAu9opvQ
	(envelope-from <netdev+bounces-267684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:11:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3DD28C126
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCE3A30254D2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B36322B8C;
	Sat, 14 Mar 2026 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i45sKXp5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A0314D35
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475890; cv=none; b=YHzTgdt7KrJLT3O6DxEDsw63pZZGo0ql6CtgyXRDi23iyaDXOXCvZwYmpv/rYmkpQY/JfxzxDRZsy3iQm8C+PGMNnmgaLhaR0WxKPx86mBZSPEHSY/ZEgqvEJk+LXWtrW+jRxwMo0WcxjcUIw9HgcE/SpOIjr4GFGJiENkBCKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475890; c=relaxed/simple;
	bh=TmwxCr9IB9n2Y8Syw5S0VZE8T7ZEFTqna6cKBSYS2mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulPS+1FXVQaQupvxjXhgJIoVYVY5w7e5mpKKNRf/9nK6skv9dlZvlRM5csRTBp/7Cqi/wIcvnHtJkcPCPkp3ZJ0omZb6AJOklwCpcU8T7ZvVKuJUBVzU+tV9FwwKU1HFl2HxOom0e0DH8HEzImPksTbgs31hkWyyjE7OfFkPQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i45sKXp5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8296dabef74so2845689b3a.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 01:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773475888; x=1774080688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=moWcmdhPCy40ce28NQlBUwpF1AcLuFP20ERgqSCK6nA=;
        b=i45sKXp5ouJL+sgkZKGf32DLf1kpAjlS4ypn+BML6F4poUqD75I/ANiH7yaOogG8Ci
         Vq7mIPApOjzIPnbck4XG6n/Y9V9ksberz27ch8OtlA4AxIpOFRGkMV7C+3rhKSZ9CTWv
         qPBybkhgPvdQPAKmdkB8YbikrqBxn8ildWk+ZrgBQaajQo7Gbpopn7Sv+MUj67Y9Wf7A
         hPYVR+Dxq2KPhtWw8uDDdLj1SEFbvy094U4Vt/F9lcbuLHKnrQ7dv41tj3RwBsGr7hJP
         INDecXiKRC80njaH5BMYd4fD2qPlUZlV7PnNdzI+UWOwckSRLjIWRUMe9RWocMiDUttj
         sCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773475888; x=1774080688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moWcmdhPCy40ce28NQlBUwpF1AcLuFP20ERgqSCK6nA=;
        b=X2mPYSfg1q6gdF/azAe8hI3GtVcyOy8zlBQu6LklqYXMWHwK6oYzqtSJH5KQpDx+wf
         u4zosIGySW19aP7Dz2K1WJP+pGXCkSDUbkl8TJds8pqg6/ZgI/cmfvVy5Z8O90GSRtuV
         aLMCyeuUzOn5RYmST/8NiGjY5P78xrrZbrB12Tx25tTzg7dYkIK9fQf+8Wgz60b+8j28
         kdBkUKTGoay/kCBwhMSmJbKANmSAyxldinJupdEUrctJGOhD5GBPrw8qt402rp1nC5UX
         CBaeNOxBqa78l634cWI7JmWKQZS7OswC0ctqnfqnWJGA7erRekynHa4J4KASxBYMRk+J
         duyA==
X-Forwarded-Encrypted: i=1; AJvYcCU1QD7jnrSbXKNNTQJtlBFQgQK8L8cyvnDWINs9QiZ/EJJ92O33+cFgmvOme66y+FogkGUQEP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoCaWu8RnpofaD83kADjJ7CRvnxzV04wFecx98Mx36aOFMXCDm
	xsNHA58nNpMkh7cNcz0sqWIk2Mi2VpAPoSLD4WnrjYP6jrqByFDCj6eSUrrU+BXd
X-Gm-Gg: ATEYQzx9DaSgdJ6iudRAg/OcEb1i041tNs1lnj4q39w4j3l26S2xNjGTrR0HUxzLvQJ
	WyG4IJ8jUrPfqn7BdvTXL5dKeN+uup1G6g6NzKVau3pFlISQAa6yjLhE5PG45CsySD5h0vaq8wz
	P14P2pXvOzUtPFjzDjXDVmSIJs8QK1AzYGRq0u4OstjroqhNPf96+GbUENp5clnZTgrbfc2+nTb
	a5QyLo99ZIviW1/HQZqppWKOruFam+K6kSSFLr92Jcbbtj8kWhLiTtcCwFvOUdhM9PzuCnQIaUT
	ijk8ec1eD141Pxqji1/WA2O8jqWoYAdIFM1UUBn7biwR91Lu+WScOTo5GZUmIkfyEaV+KR8UeQI
	Kol3/A1oqc5kO3fi+AqJ9cq+wPdZlgPTlsQrGxBCfAqJtSPdxcww10jdBeJM1H3a77NMUeWm7Fe
	7VZADeHmWTeBn2KDEZEjI4aWmt
X-Received: by 2002:a05:6a00:2e21:b0:829:6f82:5953 with SMTP id d2e1a72fcca58-82a196d3440mr5539194b3a.5.1773475888359;
        Sat, 14 Mar 2026 01:11:28 -0700 (PDT)
Received: from ubuntu.. ([152.58.152.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0727e581sm7427942b3a.27.2026.03.14.01.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 01:11:27 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH] net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in error paths
Date: Sat, 14 Mar 2026 08:11:12 +0000
Message-ID: <20260314081112.177669-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267684-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[broadcom.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohdabd6602@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED3DD28C126
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Smatch reports:
drivers/net/dsa/bcm_sf2.c:997 bcm_sf2_sw_resume() warn:
'priv->clk' from clk_prepare_enable() not released on lines: 983,990.

The clock enabled by clk_prepare_enable() in bcm_sf2_sw_resume()
is not released if bcm_sf2_sw_rst() or bcm_sf2_cfp_resume() fails.

Add the missing clk_disable_unprepare() calls in the error paths
to properly release the clock resource.

Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
---
 drivers/net/dsa/bcm_sf2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 960685596093..de3efa3ce9a7 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -980,15 +980,19 @@ static int bcm_sf2_sw_resume(struct dsa_switch *ds)
 	ret = bcm_sf2_sw_rst(priv);
 	if (ret) {
 		pr_err("%s: failed to software reset switch\n", __func__);
+		if (!priv->wol_ports_mask)
+			clk_disable_unprepare(priv->clk);
 		return ret;
 	}
 
 	bcm_sf2_crossbar_setup(priv);
 
 	ret = bcm_sf2_cfp_resume(ds);
-	if (ret)
+	if (ret) {
+		if (!priv->wol_ports_mask)
+			clk_disable_unprepare(priv->clk);
 		return ret;
-
+	}
 	if (priv->hw_params.num_gphy == 1)
 		bcm_sf2_gphy_enable_set(ds, true);
 
-- 
2.43.0


