Return-Path: <netdev+bounces-265975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EUxG/zur2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:14:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E9B24934B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE1ED3002933
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EDB43E48E;
	Tue, 10 Mar 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyRyE4DB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38836EA91
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137550; cv=none; b=tlr3OXR88YvVdLD1zjd5IX9tCSsk1q9idUVFXtGgnTXmfkXLz+pSpwvZiGJGGP1ob1N8QyT9kDgWbLdG6eeS02QpwQm4YQIUCrJdCGE4KcH8YHfZKGXMToI9QAtfB1J3QufftFfsVkwMjydK+dlyxD9gFRp02wEkPxPTf1gSJ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137550; c=relaxed/simple;
	bh=+ZscisKOK1mPiCGyT2nhNb261IBC8yX5NowOJvaI8yQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y5sBOWv0BTdcSUN9e4DKqDkv21q71anHgz1kEIfB7al/5YHPx3v+PENksIbo/1odo/lTpPigzSb0bHGrM6g4t+oWZCzUsX3VkSTpuQj9U/O/WVlA3sfy+0yd5/vqtBp1GubXLwgX3KY1nZxmxoSjGUTMqAaXhTIeJDE0q/t47tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyRyE4DB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899a9f445cbso154696216d6.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773137548; x=1773742348; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PLI+cHwBlYtbOyoA7bEHaqg/JUs5bEnOTp632T99sY=;
        b=IyRyE4DBdCEr4nGqvAR0/PfxRt5vZ5Vb9ogiyk4K2vpoTRze0FEhgeF5JmRPfQ7E1r
         81cbg7Cf6cJCuCJEior98IqyRBoWAH5EkbJOZut5sZgjAhUSMHaIumaOD0Svs03+nuXP
         u0FsA+fC4g+G2DUgi5Rl9n3OalYsMcp2PShFMJ6Gm2YevpiGpbCej67VqbVUlm9KL+wf
         H9G7pAcBd8hQS/qE7PwvcgiYfee8I+O3YkjykyyLxEeklvPJg+lKOyLzKPcq5mkVpufy
         mtVdnoBz75P8KqM2vDpvBcVB1RN9FJlhh8ZOiV09m10OOLh6h628SYgg33mO/xuUVQ45
         32SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773137548; x=1773742348;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PLI+cHwBlYtbOyoA7bEHaqg/JUs5bEnOTp632T99sY=;
        b=MNW0FVj33LPlR9vNcgyonfo0bhJExXar9wUxh7XmNMyrsNXPgujRTy59elu76Zbksn
         O6eRSJSCuYqXT50IEUKnct7Zm9wgeap69gXwp3MnxFiEQol8Pg8LlPDsG+haWhlSlcXC
         ZjsB+m/b4eQ02QTUftBwZ/ITffsqzhjgW2oMYYNI/+rAi/MtY6WWvrZiJcSUXICO41/E
         p5ilIBVP0eN+BC4ZIRdFMLFLYVq16B6Te+9PlOuz4QRyXUzueRXX2XDdOeIILDjiWobu
         FCJ610uPgpQgKe/s9VigyOZThmF8dCK9G6e+eKkSiH+U2ywO1lvujD/2obZ4hqVAKq9Y
         ik5A==
X-Gm-Message-State: AOJu0YzibGSShyv7e7D3BkTr2QOwiWNSEfCEnrkF9rHTxq+pHm6OlbdG
	SejjjGGW3CklvaB47reJxcQREC0hj/tIIBQ0+Xb5Xk5Pk2GcthQUtVRG
X-Gm-Gg: ATEYQzz50a5FiGEdtrKxMk3T5uK3as9qn+Uic0e91tlX/guEth/ksA8bB29B7oLqujy
	gNXjgu/zMnZ0DcZEfFnVCWuBQi7BARcG0f0y4h6ldS2fMz1UPGxnVBKV3nlMf79RtroSVB6fGgi
	4etRqpGJ4seAQPmpj+pQIUPbWnuKLV3gAFcoqLKDK8QzkqwyNu4wZmSXcy/907yOExiVAI/xUUJ
	+iiLhH2L9LJ4LcOaZ8c8TCeszeK83mow+pewfZf5qS99iOIYGi15VNWRce5VUqfK7khATN1NFZD
	BMn4Y9oSUe+Yj6JH94syZKOidEZ2Hm8OV9BakniAx7mY69dsOilUQuHb0KBjrH+/BlKrFdT/7rS
	cV/j6ZIPaDX3uRNOj7lhnlKwIxqsdQi+DaaxquBBbgxXP7tIBQ1roaE6gRW7ESaVV+TXQfMvus1
	Bzih0U5RIJWYwiqeO/G0S7BBtJUmvmzQQD
X-Received: by 2002:a05:6214:2604:b0:89a:a01:1c38 with SMTP id 6a1803df08f44-89a30c1638bmr206563906d6.59.1773137547640;
        Tue, 10 Mar 2026 03:12:27 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c4a0c6sm18867736d6.52.2026.03.10.03.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:12:27 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next 0/3] net: macb: Clean up several member settings
 of macb_config instances
Date: Tue, 10 Mar 2026 18:12:06 +0800
Message-Id: <20260310-macb-cleanup-v1-0-928c1a91a7dc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbur2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNL3dzE5CTd5JzUxLzSAt00c3PjVAtLkzSjNFMloJaCotS0zAqwcdF
 KeaklunmpFSVKsbW1AIz/5iZoAAAA
X-Change-ID: 20260309-macb-cleanup-f773e894f2f5
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 34E9B24934B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265975-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tuxon.dev:email,lunn.ch:email]
X-Rspamd-Action: no action

Hi,

While debugging an issue in the macb driver, I noticed that many macb_config
instances have very similar member settings. This makes it difficult to
identify the actual differences between these instances. This patch series
aims to clean up some of these settings and clarify the specific configurations
of each macb_config instance. No functional changes are introduced.

---
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>

---
Kevin Hao (3):
      net: macb: Clean up the .clk_init setting in the macb_config instances
      net: macb: Clean up the .init settings in macb_config instances
      net: macb: Clean up the .usrio settings in macb_config instances

 drivers/net/ethernet/cadence/macb_main.c | 92 ++++++++++++--------------------
 1 file changed, 34 insertions(+), 58 deletions(-)
---
base-commit: 343f51842f4ed7143872f3aa116a214a5619a4b9
change-id: 20260309-macb-cleanup-f773e894f2f5

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


