Return-Path: <netdev+bounces-251029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A624D3A317
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 153DB303441D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C53557F1;
	Mon, 19 Jan 2026 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MqgkSDpR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566A43557E7
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814977; cv=none; b=LGJe2VSAM2Q593rltTyyvwXTWMwAcdovrF2mXBWDJgS9koavjdglJB9yHysQoxhJ0USlf35W5+H3Yp4lIZnQz1kO9p6glJ2vUqE4uwPbLcw4+dF65ngya8h+U+euRP4vFbjUmq1nOsHsUY5E529fdK7Kl6RnTc8J7bWT8qolEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814977; c=relaxed/simple;
	bh=hEuFfiVAIzcj3M75mKqycaVCpNxANYHyfkOL6P6Enrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2lbLvDLYz4vBulj5FYY1lR0CTtdA8aUluMxbUCYInGae6lqA0zYblkisN/oOBpRZEK3UJtBBHqS882BESojCwTpWCCxvJN0uzEAF8oq4IX00lxQO4nFhRDL/L/mSB+dwIFEmz1pRTYR4B8fEKgfQYZF+MUQhZqi9Gh3fguDvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MqgkSDpR; arc=none smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2ae5283dae8so255018eec.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814975; x=1769419775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w50P3TMsI17A7OyOfUkdCQ9JI+NWMHZi/Bip0DiUgH0=;
        b=ahzgLiw0h+u/JbQLUOFH4MzSIa11p2GxND4Z9djD08+gUr7RMP+hnc5rGAH3DL4H5g
         T6A4FmEwF46yId/xWf6m0gwZsnY5sDEpXG0/n50Qj1Zfe3IOvRaGMuRP6gXXFg+a8Vom
         s1loT7qmjZfc8kqpOejnnr7QlNQnC80TgZTkRkC/dKRZBS6ghHtZ6a3EP+fJr45cPGBI
         /ERWgUmek2qMjAyqfHoMG0wF+PiAMIs1oPT7W3zIbCSNGVoIZSAfJ2tEzuknyEoWTCio
         A18XaH6u9e4slbLRRA3fLh5w0RQ+pMZIbsL5CctTQD+bMiLcBvj08OPKYyf/YTgIh9QH
         mvQA==
X-Forwarded-Encrypted: i=1; AJvYcCXkWVveFEzsUDmkTaycKduzV8OGKXmznL6ppKYoNdm0g+07CRCfFZSOZjtZbu08EIED30kB4Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFgXb4XoE8PSEGxnYfFNtLFzrjXFYSazAWtBUgWE5APRWyrd2
	wthcPZKhqqChK89o3A3xXBanOpXjltcramOMjjnTFR06fg2Ue3Gh30gN/cPHai9tLono9Ox6XTc
	+zcT0dRRunUmZ6R1Cp7YJm8s/SwTZ99aeZ0CiE3gm+gj31OxwGozvda4igTVbXR6W/AS3+Ip+1G
	PKVZ2Bf4n8d0RjIZGO6g+GWNhpsQisqxQ/XATR5aKQhMUIuFgRwGtTRLe8GQ45/YxH7sYODFHlo
	htQRHOI0SfuAcExhRDCh1m6rGHvOY0=
X-Gm-Gg: AY/fxX6BgjwrvXNuTTgj5Vt52L0FirMI6AONZIQEw/u2hNK1eRHRQgRtUSTpmi8+SR3
	GhnfEz1WCKDsJq4OYd2fRP0iSOjiXfo0hfaomS3wtRrfcaHjKu+m6k1LIgXBwcpSVPGiSD1dcn/
	/V7KwLIHdp5cwXyJDwOjaIr34xeWDb7SXRUyC4dKImQc4MfRGpb8ctAkc8V/2SCUjffrDGlB6Jw
	zyGrsgrDFrWr7XH1BnQzXCFphQxoPwPzSLzpe5yz9RWFVDShVAoXz67H9s26Wcj+k+OGGJSYKSM
	KzeDZOv4O25pUr/DjIXMbIPxsRVxH5mf8uwr10OlXAnYe5MeNk6JgN8MuGmMpevcqmOo7J3ENeO
	u9/RgImZ8j2MA8Edwu5Z3ctCxL/uh1KKXpefsrRU77Q2zK/DduZLv6L+XrhV6lN4XAWbNQLJCRI
	gI+8eImqgDdvVk097prQpoW8z8CAQP3FFGOm4SRWfvL8X4EcYYRLvSz5jHVKtgAu4/
X-Received: by 2002:a05:7300:6c27:b0:2ab:ca55:89bd with SMTP id 5a478bee46e88-2b6b40ec8d1mr5071157eec.4.1768814975246;
        Mon, 19 Jan 2026 01:29:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b6b3522644sm1234437eec.4.2026.01.19.01.29.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a49b46380so9934556d6.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814974; x=1769419774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w50P3TMsI17A7OyOfUkdCQ9JI+NWMHZi/Bip0DiUgH0=;
        b=MqgkSDpR1raz4ko12KVPeIM+rVaCKGlXxZVfUanpl9acIJ+N0B5vqMG7ZxDlu13rql
         0wHxTMCJ0CSnhVx8W8rTw5qIaktBV/5PQlDCHMmKxgJ21h0P7e839r31VtYxEHYv+PwZ
         PhvzMer4Ph72bo0BzVPNTaQDgz7b11aljDMCo=
X-Forwarded-Encrypted: i=1; AJvYcCU8FeKGHl2J2qdXcGqgEkymmdr6BmdeOQ/AKN9gq4+498anIqBk+sSu/KfqPwq/jE1CoNxj2Bc=@vger.kernel.org
X-Received: by 2002:a05:6214:3307:b0:87d:ad10:215b with SMTP id 6a1803df08f44-8942dbed48dmr128842856d6.1.1768814973830;
        Mon, 19 Jan 2026 01:29:33 -0800 (PST)
X-Received: by 2002:a05:6214:3307:b0:87d:ad10:215b with SMTP id 6a1803df08f44-8942dbed48dmr128842706d6.1.1768814973490;
        Mon, 19 Jan 2026 01:29:33 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:32 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: j.vosburgh@gmail.com,
	vfalico@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	borisp@nvidia.com,
	aviadye@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	carlos.soto@broadcom.com,
	simon.horman@corigine.com,
	luca.czesla@mail.schwarzv,
	felix.huettner@mail.schwarz,
	ilyal@mellanox.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Tariq Toukan <tariqt@nvidia.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 2/5] net/bonding: Take IP hash logic into a helper
Date: Mon, 19 Jan 2026 09:25:59 +0000
Message-ID: <20260119092602.1414468-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Tariq Toukan <tariqt@nvidia.com>

[ Upstream commit 5b99854540e35c2c6a226bcdb4bafbae1bccad5a ]

Hash logic on L3 will be used in a downstream patch for one more use
case.
Take it to a function for a better code reuse.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 drivers/net/bonding/bond_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 08bc930afc4c..b4b2e6a7fdd4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3678,6 +3678,16 @@ static bool bond_flow_dissect(struct bonding *bond, struct sk_buff *skb,
 	return true;
 }
 
+static u32 bond_ip_hash(u32 hash, struct flow_keys *flow)
+{
+	hash ^= (__force u32)flow_get_u32_dst(flow) ^
+		(__force u32)flow_get_u32_src(flow);
+	hash ^= (hash >> 16);
+	hash ^= (hash >> 8);
+	/* discard lowest hash bit to deal with the common even ports pattern */
+	return hash >> 1;
+}
+
 /**
  * bond_xmit_hash - generate a hash value based on the xmit policy
  * @bond: bonding device
@@ -3708,12 +3718,8 @@ u32 bond_xmit_hash(struct bonding *bond, struct sk_buff *skb)
 		else
 			memcpy(&hash, &flow.ports.ports, sizeof(hash));
 	}
-	hash ^= (__force u32)flow_get_u32_dst(&flow) ^
-		(__force u32)flow_get_u32_src(&flow);
-	hash ^= (hash >> 16);
-	hash ^= (hash >> 8);
 
-	return hash >> 1;
+	return bond_ip_hash(hash, &flow);
 }
 
 /*-------------------------- Device entry points ----------------------------*/
-- 
2.43.7


