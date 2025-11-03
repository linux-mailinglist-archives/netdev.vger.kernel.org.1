Return-Path: <netdev+bounces-235195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A30C2D62C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66E6423AF9
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B93320CCD;
	Mon,  3 Nov 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gviGh97J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706C320A11
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189233; cv=none; b=u+AjHsDC2fhEWYusi33eZNDUgL75LQI13O61nynz/dXbNzyBHsGwl/YePHcnjNMpE/SzPl32lmutcfy8kZ/DQ5GcjZsEirMjs8YaO9BE8raKomI6eUpOcoN9ep41jGA2nKUKdky1bhRYWQaEP3I+sKv9eBQYyu11GAvNWbFRnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189233; c=relaxed/simple;
	bh=0mQ3NEqov0z/wPNi9quFcHLyV2R8AgizXW15L6mLqaw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFzROWOfkXj6aYcSh22FWN1pdgKnqe0PKVGCIITaDpxRHY1DwtSAGKl2L+6vb4rI8L9mimMyqM46StqLyJ+lltrM0s9Mjd7cUN6reIBjm4Cw3S2F66FRWBQ3brqWTaXI8SY5qS/bYnBRN46oQjBKrAfzMZ9w8TzYn+xD2Qhlez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gviGh97J; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4639213b3a.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189230; x=1762794030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=saHY2QfKNk6sNJknCmvl8rVYUcZrsUjAxaE7Tqsmjnc=;
        b=gviGh97JlA+2AcEtUE4wpDZPEqcyTF1e/vQMQaKMyIiXezsIUII3jxEBB/hPgcyJ/t
         3SHDmsBBycPH6iRl1JgV0/yDuM/UnpdaA1M2679I+7idTVRm82CFZebhGajjqutJEpX9
         cpVVuRC9xEOwINn1bjjn45kLSLhYWcrsHbhzC8JJsWJmyXc8UaCwIXafgCZ9xHtT4tch
         tcHqL3m2HVbmthQZdeyK/27SdwNTT/cs6K3L/bBf23hENAPJ+YxSpc9bezF5BYrCS626
         dDSR+NUVqhYCC588ODzFPLK5b19Ys8QnF299damM8uxoq6N+iaC9leuJYWB1XfAWy9zh
         CFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189230; x=1762794030;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=saHY2QfKNk6sNJknCmvl8rVYUcZrsUjAxaE7Tqsmjnc=;
        b=M+ry6r4CJJqa9uoHQgSBiDgGsyqsPViW6YUs00OYcEU2dW7OsMRsvpDsAl9jD/Q8Ez
         Vb7Fqy6ekolaqvrh/DV11bk+km4xJ1kAWYqSG0XMiIL+2u0PxdbwDsRIE4QOqlwteGy/
         2j0Gh+s6h6iW2TSMjAfFLTJJzsQo3DURc5mWUQE0JPSdZk8uWDTM2XFB7ALeTVLIwBrv
         d8QbqMtaNY3I2uD4tNy0vSVYWV2ZQocBJPPjXBVyvEzBt6te59LuoVzoYeChpaSFYDpq
         2FfVt0jxtEn1gZc9tPlknAW9C8AplrBuRtOEs+Av6NqePRrET0/4DT+ja6Rzp3/xgheu
         OhLw==
X-Gm-Message-State: AOJu0YxieiTqy6VswDgi7E22ZT36JPKQT1wxmD9QEksAnJhSwg1pebcW
	w1SSTKi3MlBLkZNrv38u0I0yxj8FjcDk8MIwIEO7lybWjVAJe12yLxzrTBjAQA==
X-Gm-Gg: ASbGnct64t3LlRV4QawiZEPQb5IXrB0QTBiF2DZPutSTAz0pJ9p6nF9uw8W1hKZjeAa
	hYcESmBN9tjw/3W9gnSLeLbkt+AVtDH4kN7DcKHBbQR7NxhiR+1osr+/89YPzcsBm/dzAJlKM43
	VBiQOe1RQzqGSxZgz7bAkqtUBI7VqqSYOLTPUBiGXIacbVJt7DwQAD/eAt2LCLOptuMafaH0ZQK
	MrsoClqFpjjM9yIE+foNdSsz8Sjpv9Yk9Qo663fJdBIp1m4l7zn9C+u0TtzFLF31gVQzw33Pvj0
	/yRIOjavhlxGqdCDs3+c/Ms7jN6n6zdl1pDg4C9Apwk+68UNS0HoKAZ5XM3PK5E7VoH12Ii3qrw
	FJa+/lQ3Y8JpYNx0/s19N6AFQr0nW489xbljhXN1W5msbvbNkMjQ9dwYfKNCLpF5vkVsbmfk/CT
	ShU6tCCsRjCtiSg8uarJHpuFz4TLs/Xw04D9Of4/dr4Jr9I+CUeH87MIe8HcNLlKV7p3HZnmRjT
	fSagJkbEQ==
X-Google-Smtp-Source: AGHT+IENkLJBctFRwkHZ5LL5DcySqCKmV6ekjvXP1NqdoYD5ruZ1BQ1yoC9ny8PhbY9Ovcg3zC4KpA==
X-Received: by 2002:a05:6a00:4614:b0:7a2:7f45:5898 with SMTP id d2e1a72fcca58-7acbf0ba05bmr125831b3a.3.1762189228738;
        Mon, 03 Nov 2025 09:00:28 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa (mobile-166-176-187-76.mycingular.net. [166.176.187.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ac4e98a77csm1534425b3a.56.2025.11.03.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:00:28 -0800 (PST)
Subject: [net-next PATCH v2 04/11] net: phy: Add identifier for fbnic PMA and
 use it to skip initial reset
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 09:00:24 -0800
Message-ID: 
 <176218922469.2759873.11916903841868552104.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic driver is planning to make use of the XPCS driver to enable
support for PCS and better integration with phylink. To do this though we
will need to enable several workarounds since the PMA/PMD interface for
fbnic is likely to be unique since it is a mix of two different vendor
products with a unique wrapper around the IP.

As such I have generated a PHY identifier based on IEEE 802.3-2022
22.2.4.3.1 using the OUI belonging to Meta Platforms and used with our
NICs. Using this we will provide it as the PHY ID via the SW based MDIO
interface so that the fbnic device can be identified and necessary
workarounds enabled in the XPCS driver.

As an initial workaround this change adds an exception so that soft_reset
is not set when the driver is initially bound to the PCS.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/pcs/pcs-xpcs.c   |    3 ++-
 include/linux/pcs/pcs-xpcs.h |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index fde9d9299756..a65a7474e490 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1554,7 +1554,8 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 
 	xpcs_get_interfaces(xpcs, xpcs->pcs.supported_interfaces);
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID ||
+	    xpcs->info.pma == MP_FBNIC_XPCS_PMA_100G_ID)
 		xpcs->pcs.poll = false;
 	else
 		xpcs->need_reset = true;
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 4cf6bd611e5a..36073f7b6bb4 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -39,6 +39,8 @@ enum dw_xpcs_pma_id {
 	DW_XPCS_PMA_GEN5_10G_ID,
 	DW_XPCS_PMA_GEN5_12G_ID,
 	WX_TXGBE_XPCS_PMA_10G_ID = 0xfc806000,
+	/* Meta Platforms OUI 88:25:08, model 0, revision 0 */
+	MP_FBNIC_XPCS_PMA_100G_ID = 0x46904000,
 };
 
 struct dw_xpcs_info {



