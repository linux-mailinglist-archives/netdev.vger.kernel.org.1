Return-Path: <netdev+bounces-157531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C55A0A98A
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062CB3A5A3F
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA24C1B4255;
	Sun, 12 Jan 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE5daTun"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35D1B218B
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688507; cv=none; b=BJWQcpO0Pl4LKvNjtIx2H4J1BbfCNr9btCvwZQ9iHPct9z5uCPChpqsXF8WEM/FxQPfrFtNJVvAh6CPhfwvStzmTwXwVm0dqXSx3JVgFoqXtpVf87wEBL0DItxE1glm9JCuATLaLAr2XQSDCupVUa0SIK6rNc+z8AylA9DfWrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688507; c=relaxed/simple;
	bh=YCB34JLlQkpPUu3q4HB+ePRyc7u3+yMm46le00milnw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YtQRPE2rSnTYwuDQDf3NlkNgOv2RXFUUojGyP1Jh7sRkDxj7xNp68pBIxa9P5q2VYIRN+L+eikKhTos2cj5qX8SaOjtr1GSq5fuqG+Ien/9SztugOKpZwfuq8u/54MsxwFFG/6Hz9KxpObBvIC1yUPW0M4NH2bh2848gIUq6vSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE5daTun; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385d7f19f20so1792805f8f.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736688504; x=1737293304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B/FpL7CmJTe1W7DtWMGgO7HVASN54rPsnRzFSSP0ZVU=;
        b=YE5daTunx64LwY6XaKDyTFwJWJlgW1IBaJJMqc/ETmygvNgViPaVSGdp1l8zBnFeuW
         tRkT49wu+CZ47PI1cEQHC/aaXNb3QrsTdw45T6i3sUqjo1uX4m2ajky7AdBJtf0nURn7
         mI69fzE/TzY7wXReoaLfMUt7LB6Ux2ZVGxv7Bv+fDnE3MgHHotkD8vUDjsJfxNMUZ8Z7
         ORyt1MJfYptnC82BsCxZpKBkzfd0dvYqR/p8dHOFeMOLlVXS5A/sE04eRf0Kb6O3SjMz
         qPC+M9ZhtyXdQZ6j/+AHYRMHI/lZdRezs2lfL2QO+eSHJpaIDe/jxNqR/A20zw3QW4m9
         GJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688504; x=1737293304;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/FpL7CmJTe1W7DtWMGgO7HVASN54rPsnRzFSSP0ZVU=;
        b=G+nert2HJAwgE4ra3Dr2bfI6ev/OMyckOlRWlu9MS3RK04whQGqwW3zz//nF/75vb0
         lZlc2dhQZPVcruDhEhlS8soNwe9bS8Uv7SVoDgl49s/U3v9rvZW7+P9T2DPIeBvT9XG4
         JEWRmyzHmh0AqE79wfNVi1b+Uvx6ohGzVs3OT2knhVIrI16VhsKv8g54/dYvse2TzgYJ
         vUfWZLu5233kbQ/pnG3aTY3T/L280Yenn8Y2EDsp7w2VXrIiXeTxKX7h9PjbiqVcIFpn
         QLMI82F5eitK+shukKGUd07TN8ZoXViYYR1uQ/YLzFzZEX+e1NiPAPEQBw2u4MWO4nHl
         swAg==
X-Gm-Message-State: AOJu0Yzd7hBtvq3xqos9sskAyWLoWjikzWTtQn5WcNCsux4eGo7wYVOv
	nnVDZCjdKOpV89xssMGS6QdOVxaH4pY5omcMCc9i9LhYKPD9mRhW
X-Gm-Gg: ASbGncsS9F+kJjIokI0ItqZX4dOVBe2iIoMe1HMfUry8Zs5W5voBBojAPkwhgEIZ9xu
	SOywJwcP8LmsZKNcnwdXU2JDBMuDePA7UGc2Bc5TdMzlPsSba2Duzv038D/vRejIyLPyCfBrtyM
	J7mbSD+Z54CTTLr9PoGdD96r8r4bApSz19xF5mAXgDC7L8j0ogpj1wtCcXkMdjH6BbnKgY/kO+3
	KgKp4yJQRn3ItHeQf7qp2/M6LkOla1XhwX/gx7524x9LeLIpcGXJH1fKpEHwi53OnO0adAhuXyx
	bhhlWhqArlsHXTJpHN1s/Jx9+HfK1ZcSwJg1yQ9LRoh+0lrkeV5MT7krG149mp+aVr6qFwLqyCz
	ucoRdNeHpw5chC9wOZc2ft5BtkC5gdUucZgdZby18LTzlEpuB
X-Google-Smtp-Source: AGHT+IEAOjWp6a57Y3TBXRpKuiVuNK7D6bIkDg18izUMOHGNV7Jrbzq/AmtXn7PRaQuN8ZlAc8TuKQ==
X-Received: by 2002:a05:6000:1f88:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-38a872f6915mr12903982f8f.9.1736688504508;
        Sun, 12 Jan 2025 05:28:24 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0d5:ab00:44ab:526d:76d3:604a? (dynamic-2a02-3100-b0d5-ab00-44ab-526d-76d3-604a.310.pool.telefonica.de. [2a02:3100:b0d5:ab00:44ab:526d:76d3:604a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e4c3428sm9441688f8f.87.2025.01.12.05.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 05:28:23 -0800 (PST)
Message-ID: <e3165b27-b627-41dd-be8f-51ab848010eb@gmail.com>
Date: Sun, 12 Jan 2025 14:28:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 03/10] ethtool: allow ethtool op set_eee to set an
 NL extack message
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Disabled EEE modes (e.g. because not supported by the MAC) are silently
filtered out by phylib's set_eee implementation. For being able to
present a hint to the user, expose extack as part of struct ethtool_keee.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/ethtool.h | 1 +
 net/ethtool/eee.c       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f711bfd75..8ee047747 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -270,6 +270,7 @@ struct ethtool_keee {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertised);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertised);
+	struct netlink_ext_ack *extack;
 	u32	tx_lpi_timer;
 	bool	tx_lpi_enabled;
 	bool	eee_active;
diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index bf398973e..6546d7290 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -129,7 +129,7 @@ ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct net_device *dev = req_info->dev;
 	struct nlattr **tb = info->attrs;
-	struct ethtool_keee eee = {};
+	struct ethtool_keee eee = { .extack = info->extack };
 	bool mod = false;
 	int ret;
 
-- 
2.47.1



