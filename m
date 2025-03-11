Return-Path: <netdev+bounces-173841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478B8A5C003
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4143A80B3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6882571B4;
	Tue, 11 Mar 2025 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bkWyEfZk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01D256C6A
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694590; cv=none; b=C4072cCBRWHY2s6Lm7M52CAdWKr2eOk96jRRSrGRxzY2+FttfNNeJBkBTa2yJXms7bZgfNAB8QYCQrQv3x8dK6eEde+UU/crpn4S9iFEoYmnUTNHF92V/JLHvQLqSh6NFNjHRIPdwMEBLvfTvMhdko5coXfmcBPKvaWzloCYUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694590; c=relaxed/simple;
	bh=nC6lwDPb3zbItVdYhexRf+7PoutRMPw8aLJAIMgqJRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fX/3TDLGKum2HLh8sEXHiijA4qQQrydgp+sBIY4aTfplldIEN+oaA66MYeuy/tUqc9nnKdQ5NrgRLZFikVlAmvs5gIVI5CNP2zeROWrerHNMtBA/0GEqF/kRiIoDoXKxdT8C/zGV1vD1t9Cmd8svyq3YygXLnuTjaxILf3i6i7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bkWyEfZk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso3372865e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694586; x=1742299386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1eyDA70luy030ManbvwItVlUHe7jfQdxQkjt6FQ5RE=;
        b=bkWyEfZkOoiQ50NPvJZZV7Vn1lsHJV727+G3UfyPuNDd943mYhfZgKU/dg2CMQB6zd
         hUpfq4NXOdcLYnWQ7ofaSYGBUi1KvLaGxkqmqfXw8Pd/5P/3PheFrVCTaIcyXRDCwh8P
         sNeY3A1ihLr3hYPsH10AtgYtaVXveibMmFnjQbmsBRmnntXfjAC2vDEzjZFAvoSkMg+l
         nvlHvR4ClP7KX5ia+xanyTKFfN1YUlahRlNNGpsQZOJdu5xzTACNbRphoOYeG3CohcjS
         goHhoD6i25imXz6vOr8wREW2pcxgPZZxngknUsmvdf/cJxBeF3rz8HaMIkZR7MEKoWww
         Jm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694586; x=1742299386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1eyDA70luy030ManbvwItVlUHe7jfQdxQkjt6FQ5RE=;
        b=r/W/cTjtwWeMCLAR9EyXgRvze5ohz3X/YElq/MEXQxTyMczsDwl3lJzcNfJ84mzeky
         7RXbH0IZtU611nDn1P7iucXLhyTKXUaQ3nl7Jha5N3ZrZvLUwi6HznULJVjZ/86nhrBZ
         39QMSGXIJ1r42qULQD8PDEl3wJw4Iig0E5B1Souq2YwhhTwy9CCFpb5WDogR3T5PSwMk
         2l3ROkLR/JZ9JXWqgJGQBTx9DsQNiaGfwIIa4HKOdNQYRkF96bJ44QqTVj4C5qtT3ToI
         dS6mW+pbZGi7E0lqrK/zHuz8BhtWJIqLSe9+ssjQYUqVale7oloIeqAtLVVUzHcyb0YL
         LHKQ==
X-Gm-Message-State: AOJu0Yw4SCuAl/50DEfCDw6uwVDyqk2UpePxmHFlZOfkZ0SW3AktJJ5x
	VBJoN7WXAmSER5lcHIWBCMHFl9sFul4hJ5458zZs/3Qq9yMES37ZTz9sCn77uFQ=
X-Gm-Gg: ASbGncu2O7Qdgv+7cQXQ5+7qMKJKuNoKHtOBAg0tuoYLVNcGS283qen4iii7DtfDQro
	/0EWTPxgDb/qgOHqAyUKVc6cbWe583mIMlQaKJumsSrLWLzlzzGfokrSnRaSdeBVgDzYBKBIdbv
	Wfzmdt8YclWWiJBoO3CzgJIsNEU+mz6h9FcH3bETAOiZgZhruhnNtTEDRIuY1gTsjTAmddWafKT
	5uGH4uomIdabW9hixO9+gJl1MUJkU9o/wdC5aP5qxCi+bvHukd5YiBrgxG66rq6OsLGT8FSfpyR
	EnwZQzTEhFsJzGhGt0PCTTCPeq8muQZfUM1yvszORQ==
X-Google-Smtp-Source: AGHT+IF5Oo7ynV4zn15KpEF5SclpF0q1nhddvqL39d6+0oc4qsE5O4EOq80dEkoLXRYlbh12HUukaA==
X-Received: by 2002:a05:600c:46c9:b0:43d:4e9:27f3 with SMTP id 5b1f17b1804b1-43d04e929a7mr18641155e9.9.1741694585585;
        Tue, 11 Mar 2025 05:03:05 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:05 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:05 +0100
Subject: [PATCH net-next v22 04/23] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-4-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
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
 h=from:subject:message-id; bh=nC6lwDPb3zbItVdYhexRf+7PoutRMPw8aLJAIMgqJRQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0CZwjPCNQ3jPkMYrshxLF11tMJIC8IFKY8uqo
 8c4v1Ee4XmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9AmcAAKCRALcOU6oDjV
 h5eIB/9+ocw/boPzPAVjRI4bTypw4HVhVXUvlyFkjE2M0rfcW98avYxJ2aU2tuCcjS2CTBY5G9w
 fFhMy9eIhx/362GyVRc3QZtfCE6WxrVd6ulpmRWWiq84X1XhOn9+GqqC4/HbuVwGESisCLHII5Y
 mAQhjFAG1LTxQLceMmhqBPNiom5VH9zuaJS1vT70lAfKX1ORpf50cMDCBonMf7/oNAv8kaw93vW
 qDFoNI6ptXGPX8/33wwOeJsFxE0DnYAIn8Rvy1P8uUEAEwokb9iLmJZ52hShExhfq/e2Al4htWd
 Zc3yqxO889Y73xGOMsoe4ROindoYfZk+Kg2r56swrE2i88Cf
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
2.48.1


