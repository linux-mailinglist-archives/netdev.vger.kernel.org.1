Return-Path: <netdev+bounces-264575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCneLC8IqmmVJwEAu9opvQ
	(envelope-from <netdev+bounces-264575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 23:48:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60295219118
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 23:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69B4F3068F37
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 22:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F2436402B;
	Thu,  5 Mar 2026 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPi209Tc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32926F291
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750824; cv=none; b=p7TlAdc4P/xETBPC9N8FjRttPGkpkQujBLMOFCCudGL1yn17mJV4hLbA/Eo66qxTpYoT/AI22S7VevPcYegqnAAqBDs1x16jRPMmO/1D4oL5u9u5Mr1vhtDf2adtnj9ePBr3dD6EUIQrPnhlztMWzUxBWHbOQDeapK9c6HGszOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750824; c=relaxed/simple;
	bh=qI5IyyLazhnEDUUp1W6vPefSjM3QVEkOOottRETXjQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZGGrrYSmc33TKJdTmDnwAmtHVfqwLrFrmcXX/9pTrUb5Tzu8wf5pt/ne0NmQ/5le9sFGemfGwhlfYHPWmpovUgenVslCcKJdOuCQ39fPYutu/L4nY4gIW6grTisJK/INfde+gBSsQUk+lHtfqBDhnDepr3iPKXem4nN3sa/Io6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPi209Tc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82990763921so938152b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 14:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772750822; x=1773355622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tCkUnAaAXYX96UmQVMbg2YXfD+nZUqei6NPAItM5zFo=;
        b=JPi209TcQSfi1P/OKYF2P9pK7VHYyrOap1uqIxcyPoXsxhrEJsHCYP8z4THZHBstrr
         JYCnbGUm79axEZbBA5fC9ZWM3vAPCUDOIIvUElb3Xyyi08n9/URPZd+BVjSts2Ltq8ry
         JsX9U+lpij0Afneho/dxQg0zqGEq60s5FcD97o3BNlb3vKIeHKMTCyyiQSw12nQTphNp
         mmBCwE9BSQpb9Fbe6K/6BOhxT6T+y8s2rOUpJE/bNvlrfp8LcimmiheHgwWzKQvXUGjh
         pCldwOGjLgmvKY9c7OhAPe/wm5tN0RRJnOgxwzhqTjegsdoxJ2JHwWy9dT+8nhknQ8Jp
         vMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772750822; x=1773355622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCkUnAaAXYX96UmQVMbg2YXfD+nZUqei6NPAItM5zFo=;
        b=YFR33yJXzlwyAylzzRLhuYVGAYZzciyiEYOG17KHSei8DCQASO7fYYA/+dS4N45n7a
         wVKyQwvOH2GekoGV/V0Mh9FAEB3j63FGCV0vYp0BWag79UIRomrrc+nauyIE1oELqQA6
         PHU7p4A+6Va0LJHzB+ZfoPWqCUADh1l2XN7mgDXuMYPH8f4JQlimtRt7iHL+qCrLTyqw
         lVfy1d2iBfZI8dDkT8oESXxpLJypE7H6vxW+eekAJhRy4CMqTaG1JN1EEIw36Vy+vQpp
         iRXSgQB5p1I5hHrZzDDj1Lfrgf+VmDW03zb+AInkovBk0xTbAfRoWycI6wl5KZA/cuuN
         HfbQ==
X-Gm-Message-State: AOJu0Yxn9AO2oUWgYVmBaerPAcOrjN96HWA8P7N1UzlD+zd4w5tBPlRF
	86XqsoFnwmbLUS1bJ+Fwii8JrIMd7EvodMULN4d41qY/pZYDGVtvIKF0OInXpK9apks=
X-Gm-Gg: ATEYQzzghuE9ooFrOzvv7nwqH/m0USgTRjkTHqD51+De9yIEc2bMTAdyJ9mfR0uq+YD
	yEnnHWh/OfcF4n8MZV2c1uSl7BPc2+S/x3E833Kfn393oqBYNWif9kpf6No7nxNq00o9kw1NPpO
	gGbFZht5u93eHGy3HFikb4ipEt4k8VkRvepke1v7YSUeZOheNq/E0SiSjMt6TcPbc72n15ARvVb
	M3U9a4QdbmCDfu4ZGCBX+w9ACldLvbcFNMRKxBbHddWLRwUP4syZhZjyRz26o0L5DZPFgteHWfQ
	y7cijv+xmKB05D+b4rjXypPTkLJWrTaxwEcCvQQ1fvYHAsognxNWtqCISQkBLmYlE65aR1/5KTa
	50Hfb8zkgnBA4ZFmyxabp2hjgHM5pTgdUOla6iHdMjo8Mxomb6qZwP9j3s6/CccV0eObu3LQUsy
	6oRWXE4rvwIy2k8KIAOPVZNq63wCqc4dhwdRFqshIk7vqr2IU/H6Lh6Q==
X-Received: by 2002:a05:6a00:2889:b0:829:8e63:fca0 with SMTP id d2e1a72fcca58-8299ab51f5fmr1312231b3a.35.1772750822561;
        Thu, 05 Mar 2026 14:47:02 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4dc6dsm22698105b3a.6.2026.03.05.14.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:47:01 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: mvneta: fix NVMEM mac address
Date: Thu,  5 Mar 2026 14:46:43 -0800
Message-ID: <20260305224643.14524-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60295219118
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264575-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

If nvmem loads after the ethernet driver, mac address assignments will
not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
case so we need to handle that to avoid eth_hw_addr_random.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d627858d2802..2ed3397818f6 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5620,6 +5620,8 @@ static int mvneta_probe(struct platform_device *pdev)
 	}
 
 	err = of_get_ethdev_address(dn, dev);
+	if (err == -EPROBE_DEFER)
+		goto err_free_ports;
 	if (!err) {
 		mac_from = "device tree";
 	} else {
-- 
2.53.0


