Return-Path: <netdev+bounces-203781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F5AF72CA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3F77A1D1F
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E732E62BE;
	Thu,  3 Jul 2025 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UFCUI8M4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566672E54C6
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543163; cv=none; b=E2EXqrD6i5Xh8oKSd9QX2NSCBPDW15AheexCN0X0e4tevfyOzszJVmG40LCHhqZk+dYYyPTNFbAoxsa7cyHAS7K6/zLaW1TeuLT5eNZBHiBoAfH77ZwfgxdaoIwsTGtZl2q7HxSEz+uoVH81H5wPlblOlVzTYxPwtAwGzhy0DJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543163; c=relaxed/simple;
	bh=a8zTMySE1h/78M/VhrdoqH5/54hihYiyowo7NEwB01Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVnFZ05mPn6ESo/Pk6cNFtJEIO9EK9VZAofMWLD2xpbB19lC9mQSm0OuPUSOBIPYvXfwj04rpm8eOpUIkbH4GMZrXPFkYk3AV+ixu96c4HLnu4cPvhTnc9tskJZF1Zp7DjVrK5026i+IzA18klnlpyLeVXMo49roQ97ogCZ8jtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UFCUI8M4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-454aaade1fbso9053635e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 04:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1751543159; x=1752147959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjSo51JI2lr/aKAlTJVMCKSHhVGiQ7Yt0BxxyNJbxMo=;
        b=UFCUI8M4lUC/WtAMu8evArTh7+usR3ar1DyRpcICWwAUf8UTdLq0PEBmVzZDk9CZTk
         vqt8uIsa1r9MbmsTD7bf1jtMCO75n2B8Q2Mt87texigvwGPTT/SkJnePwTXqnAPcyOjy
         y79/gIs4rxPMjEk1JatDLcifKaTEKEK4IhGrfARlIbHPrGITxAQiB0uPvgwX8OyGpKg7
         nCCn/4MIHgpT7rUIKGO6Qr8zZ0AoSKMFeTyZ3gPzNWqV7Tq5lguzzvDrxU/+I3Vh/XCU
         NN6jLgcUn7stW4TH9Una8FT/8AXUbPH0v9bGMPhkhVXwvnNAL6rK0XlmW9Xe6/xONCIG
         NuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751543159; x=1752147959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjSo51JI2lr/aKAlTJVMCKSHhVGiQ7Yt0BxxyNJbxMo=;
        b=LfrSFIV9fF+IciLiPyfUV1/OpiIu+HfA0UE7k18buq92KpCm4vVJL/uy//PaLSWGSi
         Ux9S7PtCNWvrYtsKHoB1Ayp3ewlFY4hKXdPcM0Q/k+J8cfI8yLmNYUfDy0BW8+GpCWlS
         aYSwPUifaoO9umY7iS5elEYYCzoJdwFVKivDi4HEL80wXWuKwZ/XcA9yTcyVCYL9wWKO
         yVOHSmamwW0FEuK78UfplCSl1AWH3xRqFs5NLvyno//Ch47AggDIP/58V0edehn5POFA
         yzkmVb7MXR6IlNW6SW7lZW1INrw8j3z4wxFF197qACcI/V/vUfls6i8ekKEcUS14EDLZ
         wx/g==
X-Gm-Message-State: AOJu0YwGvOEV8g7VxPO1wMiX0foXYyWvWJLR3QvSaYM5NfihZKcCJrs2
	q/f4rwWIB1JZ9UXqMPFHKYlaap6FjGHKHrcBResN23vQfH7PY735xgSQIFupXEMUlQ4NR7Eim06
	ceRgaMGpoVNFF9ASfgGzs8XMwhHwsW2PMhYU3IufNLyaEBJTY1fcdZaJ3HDySV0/b
X-Gm-Gg: ASbGncvlIXSQ8MfncMO3BjywpZcQwPmPJMI7cI5nCrCK38N4UgTE0TznwbYdJqi6g2n
	Xm8wLQ/O4/5WAmFw9fsIL8Ws61J5QDw0uJP5A80Y69MxaoN8ASvy9nJN41cngo2WNZtRNO3bjCu
	f7AO5I59NlmIVY5qmNKAZuSh0OGNm7k+bGO/REA90Y3Ijk0dQZ1NYQ0xmiOAO0z7YIcw57k0iB3
	IuKlv7RL+5ELG6lTa62azmt3xIQk8itKomcmPgq/HfY9t05s49hwKce4aLjplQ8n6jRG59rLQsd
	l526L8v2/hcsYDdOdDvWlKiTwFVva+K6kIIBJIQK+MkTF+0x4ux15HtgukQ9W5OhRoyKHjia7+V
	CwvqvVkUU
X-Google-Smtp-Source: AGHT+IFKgq0KhkHwjzn8EibxekRSW3VrMB8Zzttwyzhfpg3mCp6W2NQkurukjDd2VBDAxi9T/icbsQ==
X-Received: by 2002:a05:600c:8b22:b0:453:1e14:6387 with SMTP id 5b1f17b1804b1-454a4e1c2d0mr46486165e9.32.1751543159214;
        Thu, 03 Jul 2025 04:45:59 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:aeb1:428:2d89:85bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9be5bbfsm24174145e9.34.2025.07.03.04.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:45:58 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>
Subject: [PATCH net 2/3] ovpn: explicitly reject netlink attr PEER_LOCAL_PORT in CMD_PEER_NEW/SET
Date: Thu,  3 Jul 2025 13:45:11 +0200
Message-ID: <20250703114513.18071-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703114513.18071-1-antonio@openvpn.net>
References: <20250703114513.18071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OVPN_A_PEER_LOCAL_PORT is designed to be a read-only attribute
that ovpn sends back to userspace to show the local port being used
to talk to that specific peer.

However, we forgot to reject it when parsing CMD_PEER_NEW/SET messages.
This is not a critical issue because the incoming value is just
ignored, but it may fool userspace which expects some change in
behaviour.

Explicitly error out and send back a message if OVPN_A_PEER_LOCAL_PORT
is specified in a CMD_PEER_NEW/SET message.

Reported-by: Ralf Lici <ralf@mandelbit.com>
Closes: https://github.com/OpenVPN/ovpn-net-next/issues/19
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index a4ec53def46e..17d23d01c6d8 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -224,6 +224,17 @@ static int ovpn_nl_peer_precheck(struct ovpn_priv *ovpn,
 		return -EINVAL;
 	}
 
+	/* the local port cannot be set by userspace because the socket
+	 * being passed is already bound to one.
+	 * OVPN_A_PEER_LOCAL_PORT is for sending peer status only (check
+	 * ovpn_nl_send_peer())
+	 */
+	if (attrs[OVPN_A_PEER_LOCAL_PORT]) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "cannot specify local port (socket is bound already)");
+		return -EINVAL;
+	}
+
 	/* check that local and remote address families are the same even
 	 * after parsing v4mapped IPv6 addresses.
 	 * (if addresses are not provided, family will be AF_UNSPEC and
-- 
2.49.0


