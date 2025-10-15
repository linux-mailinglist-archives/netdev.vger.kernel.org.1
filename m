Return-Path: <netdev+bounces-229762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EC9BE0985
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 696B2357939
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51A30BF52;
	Wed, 15 Oct 2025 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKK/Yz0d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A761FF1B4
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559150; cv=none; b=TUEu+vmQq+yLFUR3waPtpXHabAZLPxxIvD61JtnEjhx22/MIsJ763d/Greyjlrq9vyeE0hi9h8KIcoV9NLCh/XuNtqPPvCYbtLobW7OJCMzZ1v/9d2/mzfTi2ruDTw7/J3aEh4s+NVzRqeIQxZF6R3oluxd4IcpxuyIS75SNFME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559150; c=relaxed/simple;
	bh=KrD7WgmEU/xFgzZNqUgsxH/OuqJMpNeh/ss6QXrh12c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cYkt7OFJ6WSPhrbJHWwzkZt59oOeQ59/3EUK+fsilDUy8rCrw/ozboLizHEFRAphGMtQWt3ncUNcq4V+Fho0hhZQTGaGbMBNzZjd/34FXF5WFkhOHPbjgGmh0eI2PhOoUrwiSUiYrd2N+15GULB68QwINL1hMhen14iUjYQaI+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKK/Yz0d; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so4202662f8f.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760559146; x=1761163946; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e2QCYWlixtO9OBBuLGoE+d3tJkgil0mN7GBVq3DxjH0=;
        b=LKK/Yz0deQmcWxDs27KdW9eS4UV4dG2YWUuyOG9HUyXP2HJfKftSSB/+in1mFc6U0j
         CQM377XKawOsnmUM7WTDCCcQqeevQZhgO7ofbps+GIhtjv6mVXkHCL1Q9csjSNJAUIoP
         3JuR8R4OIT9eQOHU2sOHK2RJzED0DlwrHBOxmjwTlwvTNBcP13nnDj9G+00U70bBziiK
         1Qkyy0ANBOptU1rksxaChp+KydA/ZqETtND0nKcrSS8AIdj7YY+0a2bFs2bCbdy/bF11
         Pzu2AFgAWrXk8E1u6F2uOt1sO5nKggdLkJ4B4r10CiL7fEJVojjFsLCPV6GuNjUPq3Y2
         LeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559146; x=1761163946;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2QCYWlixtO9OBBuLGoE+d3tJkgil0mN7GBVq3DxjH0=;
        b=Z7jscHdz6UNhOdxbFnMEVwXS3fFxf21a68c68qPHfYQOSShrAZQ5gHqwZ0ydCJGVC7
         JNCcUSnhe7IWMQUkcLG0fYvd1nhb+Ah/cXfVrYvwW/ClNWxs7vTHlFB+FqjXlMLo1lAb
         7jgm0W9nhRGqfQbz8T0TpjtXwMXT4wUmJh3oKM9rwzIDUMyKT/4UyDy1+eARxJNgm5s+
         xbh5O9umtXOhXSl/nYNyTTn6d1n91BA19mutSM2oyiWXafoI0zkXlCswRy1kICydhot2
         HLtqsXE4EPRRWalAkfjArMKh9lbc/am5KOTac7M49WY2x89AmSjRtzqksE2tPqgYokn8
         Fqgg==
X-Gm-Message-State: AOJu0Yxv5fC8A0aLj3qk5Q47nkrVMvT8WqYemaNDf2YCrAMtzJC/ANs3
	dw4gmvufWVofg63+8Jrx7DFvQiL3ap/cj31Wt+u6f7jkEBziqu0r6BbU
X-Gm-Gg: ASbGncurRqhdAm3yN4v0ky8iU3ihrRYPcji25xDQGXhoU/Bwc8Bjsqs8Ej/+hr82W3B
	KfDZ+fr+aSa66x9b76peCn+Sc2xLaM/ODCB45MEuP5+SwrGgc/3V71+GjoSsvVt0JGNvFVRmgjR
	VjRCup0K3Xl2xy99dusYFvPnJwXiJsltqXXbPwmO2JvmE1nWLke5/xRlgKfVaRo9/iBtazVdkL4
	5ATBy+WPhu1HdeDHVH5Yuc9eME0CbuKBlKjLlnV13vwxOqGq52yp9dVNXS73hxdyzQwg8IpF3Mg
	HFV4fudfbW8uhoeOmfP52rTNsqSJ28JbDMrqQn+iwSZOZOO43SBixIvpBN3xGLDoBJabPGJBSw4
	S489zX9X4dwx/0/B3pjnAc0BSbFScdatY3BdTg1dAhm9QeP734e9i5GnwWV2lEyeT5pbVjdx0vz
	I9Mkd7BGh33YhSRO+JmEl9LauUbOFWkSL/5LI8e9M82nJJRNlnvx4ZMMYGfwSSDqSlcbGTZfiW6
	7RQe2+6
X-Google-Smtp-Source: AGHT+IH2Gx4Qa4FxRvdGvHlGS3cWbXKXnrT7iE/+JXZnQCmpg+Wn6YCJYhh5mfq9X+Geg8giSK9MtA==
X-Received: by 2002:a05:6000:25c6:b0:3fa:5925:4b11 with SMTP id ffacd0b85a97d-4266e8dd4a0mr19619571f8f.42.1760559145917;
        Wed, 15 Oct 2025 13:12:25 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f14:5700:adae:e71e:23d2:b024? (p200300ea8f145700adaee71e23d2b024.dip0.t-ipconnect.de. [2003:ea:8f14:5700:adae:e71e:23d2:b024])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm321850405e9.10.2025.10.15.13.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 13:12:25 -0700 (PDT)
Message-ID: <418fbd41-6ec5-4c86-9bc3-e68d3333913f@gmail.com>
Date: Wed, 15 Oct 2025 22:12:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: reconfigure rx unconditionally before chip
 reset when resuming
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There's a good chance that more chip versions suffer from the same
hw issue. So let's reconfigure rx unconditionally before the chip reset
when resuming. This shouldn't have any side effect on unaffected chip
versions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d18734fe1..2a4d9b548 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4995,9 +4995,7 @@ static int rtl8169_resume(struct device *device)
 		clk_prepare_enable(tp->clk);
 
 	/* Some chip versions may truncate packets without this initialization */
-	if (tp->mac_version == RTL_GIGA_MAC_VER_37 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_46)
-		rtl_init_rxcfg(tp);
+	rtl_init_rxcfg(tp);
 
 	return rtl8169_runtime_resume(device);
 }
-- 
2.51.0


