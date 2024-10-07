Return-Path: <netdev+bounces-132851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E0B993827
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13964284969
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5E1DE4E0;
	Mon,  7 Oct 2024 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRXGJn3k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863481727
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332589; cv=none; b=Gy3mK5zUAOcAW/BXn4LjczYulP1eH/8eCsXWABBUKtUjnqRKDbqjqvmqlELgtZdyuk9M6RQsGso9G0h3+gATuEprx6youCelFJltFEmF/zjbQnGw83KWd+3RVf4VNDOPDpoZnzMd9XsGtL6+Ov+sMYnbM527Wwm3zNuN96kcTUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332589; c=relaxed/simple;
	bh=bZdegfPPygMUlyu69fkPKUpNP8FlPIV+616goIGgIio=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QSvE9vruLUKF6KcH/z7xNS3i8FV82Vfqo3M6z886FPUQfLTHMRCZik5sfDTJUSHMyedpbtTdZXZXzij+tybmcCw9E1TCKYnAe+WxNFjeCTi3tfQ0f9I7E3Z6jVKQEOUhLsZIanp2/U70N+OchlNjin/HCIUxiSuJdWiqA5Yb3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRXGJn3k; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fad8337aa4so54083841fa.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728332586; x=1728937386; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yORtwAn8ACjnH5BZZQlxg1bNL3mPxzXo+5f1J1mSxQ=;
        b=KRXGJn3kxg3r0JBk1vT4NhlZVVFkJcyqTmwd2t7Y3Z0bcf1czOJbN1z7yf4Xb2VikS
         BawxY0orTWtVR/awycdFKa+CeZ/mRllRgdV+bhi6jr6vAYByIo7550hGgD7TJAfK8CbW
         Y6GZ6GGT4n1Gvgrzn5OtJLXamytO3UrLV2hIc04QfasG2+rTQM79Nov2AN1+7eTA92WU
         czG5u4XKgg3xNr4x2AoTXwtobQkSGzPzxwnLNY5ooEExm9yVJno9GcyXQuLTdHVuPUcI
         Bh53lqy7T3Cg5RTL3SoSoUQFrMTBPofDJAPj8ltnSR4G/ZwUfC92L1QajAM6NKS8P2I2
         yBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332586; x=1728937386;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yORtwAn8ACjnH5BZZQlxg1bNL3mPxzXo+5f1J1mSxQ=;
        b=K4L3jPxEZPJMK/nA+uomCZhdBWSmG/UgTRPzTFYAuLo97vfJWubwKn8tUKY8BQaC5A
         weT1gLFptWR/TNRyRhkxCYBeuscXbBDl6xvbEvD+Ry3V8P5tQS2kAeTFYKpUFBC4yQP/
         hgdZQfeu6TfQtF7+qdKSDuIiVRoC93OjdGevq4MHYu0DMq8MrlXqZruyKRNhwlQjtN1y
         A6B7VJq3QzFun3Gayn2dynMjIazgQ2HZxV3m2o+ELRx6F2ykcKXZTMmmAy6EhTsT9bW6
         754REEDJHcGNBoKMvFzMADTSZAD+F7BRVk75Lprb+GKIJ213IEjWUU/0jqktXQrCG8P6
         A2nQ==
X-Gm-Message-State: AOJu0Yw5Zw+1iDnBnShoORZnSU26hPR+Ku2ZJae89fsvD/8aclX1aAVv
	BtkEFiGxhuVfaSmw53uyZ8hcH1ROazZxtFwxWPHStzjOH3s45E+cfDcGag==
X-Google-Smtp-Source: AGHT+IE397it/JPkFAB/wFQWj0H8WndyEbn/H3hePsKZndi7faU/sP4C63AjgrswN7SzZ30MerLCsg==
X-Received: by 2002:a2e:bc28:0:b0:2fa:c387:745b with SMTP id 38308e7fff4ca-2faf3c64c28mr57673131fa.31.1728332585677;
        Mon, 07 Oct 2024 13:23:05 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a12d:4f00:a884:c611:9e1:3345? (dynamic-2a02-3100-a12d-4f00-a884-c611-09e1-3345.310.pool.telefonica.de. [2a02:3100:a12d:4f00:a884:c611:9e1:3345])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05c0dc1sm3561989a12.52.2024.10.07.13.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 13:23:04 -0700 (PDT)
Message-ID: <37b44c85-7090-48c8-a307-624244964405@gmail.com>
Date: Mon, 7 Oct 2024 22:23:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: Use improved RTL8125 hw stats
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The new hw stat fields partially duplicate existing fields, but with a
larger field size now. Use these new fields to reduce the risk of
overflows.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6a9259d85..bd26b7b50 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1873,6 +1873,14 @@ static void rtl8169_get_ethtool_stats(struct net_device *dev,
 	data[10] = le32_to_cpu(counters->rx_multicast);
 	data[11] = le16_to_cpu(counters->tx_aborted);
 	data[12] = le16_to_cpu(counters->tx_underrun);
+
+	if (rtl_is_8125(tp)) {
+		data[4] = le32_to_cpu(counters->rx_mac_missed);
+		data[5] = le32_to_cpu(counters->align_errors32);
+		data[10] = le64_to_cpu(counters->rx_multicast64);
+		data[11] = le32_to_cpu(counters->tx_aborted32);
+		data[12] = le32_to_cpu(counters->tx_underrun32);
+	}
 }
 
 static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)
-- 
2.46.2


