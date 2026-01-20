Return-Path: <netdev+bounces-251615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOhKJH38b2mUUgAAu9opvQ
	(envelope-from <netdev+bounces-251615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:06:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CACD4CBC5
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 277608EEB92
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5D13B8D62;
	Tue, 20 Jan 2026 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvVSL7PX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825AE3921D0
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941553; cv=none; b=NBoSkj7Bt+NQUGp0A7Pcxmz/yidOtpn7KcoH4K2i2l5vtAUQUgM1oLOqbj4ZKtnZziQRDMRMuT6HGVxI2ZhLVPMhE7Vub+DEkOCrLDCXXOfB7Zmvq/Sa/mFoMGPSB2FI5nqkX30drExXgVQwZQcDIne+6APLPblMnta8myn9j9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941553; c=relaxed/simple;
	bh=5CiX2WUsbI2m7w6tFZKJqvkgdJH3bNVYQSdr5b3zvHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alEufP6V3c51uZjTmY/u+o5ikJpVX2AtyO5vH5zV/9oBWfkcIFC5x7s+mA0uy9MWshhrDIBNeEomppt3p8yxpqD15kvIpYQcVGHPBLIyiq5ty6oyK7cwcWK2U24T5ADOzjNXUfY+7+tEW4lILiUsvXkk+gTu0Dh6IXQCNF2Hv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvVSL7PX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso54954465e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768941549; x=1769546349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6EvQ/5He659QnltZ2hQ5JWhAbcs5AVgWTzcueB+MkM=;
        b=KvVSL7PXwlGYq3BSOoSbyOCwLsRzTsiiyp/8KQHSS6n4dgxpUtQ0sZOjBAe3cfVN7Z
         N95rWZHAsg2NR9LBN0hQQ/i+Evu5QMBN8AeJRA0zgKEphOWLdj4OK3BzYTZLJGhJZYkz
         U3oqVz7UzGAPOhaHC81YJRPwSKNGzjka7RIjtypCEth6zZWddbN5Ti4EdfOpvCLmANUU
         /5wpmeVYxlIyk4Z+Cd04hguyAXFi6NW3G7ThvWaiKfcK5At8s8aaGFTGuOFS3vMpN8Ux
         6QVYB/H/Y7HTSW6YRy51HilwEBzSlUJajGqa+RvUrNRhb4gYwbh51jcXLkfsbDmRO/ss
         DniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941549; x=1769546349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u6EvQ/5He659QnltZ2hQ5JWhAbcs5AVgWTzcueB+MkM=;
        b=MnY+0j+8keqgU7pxvO28RIgNBV0aeAbiVhCqJVgw2+2c26aF/hLg5/XOpG6TssDbPd
         NVd7uC91Q/CmUSqJldXzShXeEulRp69DIZ+8LJ1cwgYwdHc1dGJxyAABHTxWmB+aW7Jf
         7B98Wm4A59Ng7tALUaMojSbBY/xZltx2ROl0T3w++suOPixw1TOOEd2qFPGpRkxX2vB2
         Q5P2ePBuqHBjIv8yvR+ebzH3XSqP1LLgBy8+y1yxVFclHr6T+aOpuINdQyHmtPwGfkZo
         34NT8vAO9DTxrzx1MKSIsVIqnc7WEYLlkP+EAs2rY2eEMkiCDoivm4/A77UEvP9TLKiC
         +SLg==
X-Gm-Message-State: AOJu0YxOH/jrNMqLH1CgaBEWVGisPb/xDKaayco2D7Kt7UZqXTsH8DAk
	JMWPzuaFoMDLCUWTtN9uP8oEgit2ptdxqdJTI6+HkMYpxozdscXOAj1j
X-Gm-Gg: AY/fxX4Zge8tOS/34dGhn4WQ1FYGzRjxOSMxOgfCHd0fEQHOIOqpMj1Ggxx0RHoSTqr
	yOCVhvKFd6PqatzbKjC4Y5CbkeUnH7MXYfUlus9cSGOzH0HiK7HU3Lap5GCF+hRBCBhYi9uk/gF
	+F7C/TDP8XCVY2NC9tFtt9mU9mBJOxES9VFtdQ64c3rKYvXiOF8bAf+4KCnVH0jky+G/L2edeNB
	zUt8p/n76c26VKOCZxh5dKFQJAIUG+JBECemtOS+BqLyACN7FRg/Ubh1Y4C7b/hhvetW+vvuhBE
	FMnHW8gd8pbP9InT/wl6ZALrtD3hdYsmzFdPIeYb/JzgDXaF2F6zipH76FSZPB18QPyGEl31TAF
	1XUN7gXlK0IY6dDH0/FlmgrOLJ2AqitLW/E/FeiN+EoO8lQfUjidM9vPd/UHxldlpfvCcr74FX/
	QJXM5MXauaOd1OMkROES9FuSxffHM=
X-Received: by 2002:a05:600c:4e0f:b0:47e:e779:36e with SMTP id 5b1f17b1804b1-4801eb0375amr194243815e9.19.1768941549092;
        Tue, 20 Jan 2026 12:39:09 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:378b:c660:2f9c:b651])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042c3a7c1sm850425e9.13.2026.01.20.12.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:39:08 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com,
	francesco.dolcini@toradex.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH net-next v3 1/3] net: phy: add a new phy_device flag to keep preamble before sfd
Date: Tue, 20 Jan 2026 21:30:02 +0100
Message-ID: <20260120203905.23805-2-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120203905.23805-1-eichest@gmail.com>
References: <20260120203905.23805-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251615-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,pengutronix.de,armlinux.org.uk,st-md-mailman.stormreply.com,bootlin.com,toradex.com];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eichest@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,toradex.com:email]
X-Rspamd-Queue-Id: 3CACD4CBC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add a new flag, PHY_F_KEEP_PREAMBLE_BEFORE_SFD, to indicate that the PHY
shall not remove the preamble before the SFD if it supports it. MACs
that do not support receiving frames without a preamble can set this
flag.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 include/linux/phy.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index fbbe028cc4b7b..a978173c0e2a1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -802,8 +802,9 @@ struct phy_device {
 };
 
 /* Generic phy_device::dev_flags */
-#define PHY_F_NO_IRQ		0x80000000
-#define PHY_F_RXC_ALWAYS_ON	0x40000000
+#define PHY_F_NO_IRQ			0x80000000
+#define PHY_F_RXC_ALWAYS_ON		0x40000000
+#define PHY_F_KEEP_PREAMBLE_BEFORE_SFD	0x20000000
 
 #define to_phy_device(__dev)	container_of_const(to_mdio_device(__dev), struct phy_device, mdio)
 
-- 
2.51.0


