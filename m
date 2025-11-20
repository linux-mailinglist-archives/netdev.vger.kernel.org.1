Return-Path: <netdev+bounces-240587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA82DC76968
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8547B4E28C6
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 23:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E096C2DC34F;
	Thu, 20 Nov 2025 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAb4ILH9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAD258EFC
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763680658; cv=none; b=WQVjSbsnE+IvoCyCSXz9fDOz+2mR5R2xGR1I1edG21j2BGoLTeqRtAo7doZkSWFcPcsmuHLL/hKiHVnwEoVngpzkwfDsq0ymSW/blOSmaNyk4kcsNGE2oxQkcCbHLjLTdQvuTYPkUXEieiAQcPPWSeoMmaJACsdz42l3c3L/13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763680658; c=relaxed/simple;
	bh=33btBazeCCx6oRL2zowEEBmDuoYz/oAedIhTvNF+Igc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4ZwAQqKe04JJCTknLU3r9RNKjrLU8m8e08RSVdOjJBsSCqn9xfb2usAPDmeIaMZ4Qi7Y+qFHKPcFCG+3EUZbF3GUJR9wNnd5JsHi/PnFMid06NO0rTmeYEMLn7x65E9DE7yaWIDHGnjJg7Cnk+7ctt7KrEEGhT2/XV0eCQb8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAb4ILH9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so12293595e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 15:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763680655; x=1764285455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtqPla6uIDCHOIDysafj/hVFYpShG3R2Dkwsi1K1e5w=;
        b=kAb4ILH9WZIrA0HohIbRKpH1yLH0KuEkicqKVTj7Kv/FAEY9WFlkQcbMDxNLRQsDpJ
         G/CmOUKt+965UoocF7xCvzFXCp+l4aj8HIO7KKuP2bZHasXohjnkcM1kn6sTw7r2tw2J
         BZex+t+N/VZ04fjDZAXXLfL0INPxNFh+uSISbjEywIEO6J36OaSucLFOtchWkZiQsRJO
         g4FnGMGGftKzLDbzP8B2D3Z0gQnjMWgHn6vX97nwkqt+Acs0QYwZhE45x3PoPjV3cpux
         FnWT/Tk8wF6J/JEazOQ1Ys6FmdXilq+PXNzW9wTJfo/w7Eoanw379//Ra9T+5rkhjl0m
         WLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763680655; x=1764285455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtqPla6uIDCHOIDysafj/hVFYpShG3R2Dkwsi1K1e5w=;
        b=YgSgHlCHHdUKFp4SgDbVM5J91ktEsa94o8O6Ofo7Wu38Mnc2qB29WFwHo0G3K19iCz
         /vAt0CKw/ZtFprcbomAP7MAURXZt6Rzt6xO+ohyqt+/uqmNZ96+X1IDUL1FH1t8URPVH
         tAVSeS9XLgDxUHo07bBU+XQNoGzSFVNCMxY/jSUIQoz5rQ2EJjYUBox0A88F+iVRypae
         gyPThMVMwdnxiLyyuae8olbNBK0VaYa1XKJK2Q5hk4HqcVvsbhN4EmgfNXEH+IqGhTJo
         5GwPXS3raEo2TPxuatXInjhyq0KgZxRyHr2MipaNwapsy+5jaZnXQGFdv1f65DP7XdMq
         2nkA==
X-Forwarded-Encrypted: i=1; AJvYcCUgOAhJe/DF3M015aCui1OTCV/v7T7Rx2gjxijEed6GsXJEhrfuv/Q0B6xM82pLN4G1ZXq/isA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygvliP01Ke8VrR7VJBM27akQgFhjJML+v5X/GGOggZOgLpHlGC
	74DlEk+zXUkThtMGsjucYglf7uBwEUEg9RnxuUh4xzO7f8tt5/VUDZnv
X-Gm-Gg: ASbGncvlRwAZ57LFpN7cqCwFk/23dmYXwGSGsg2VtvR6ydKXrhX9nnxNOXDGMNWbHX1
	8ES/fDRqkyUI+OjvUurP2RewMCUQX8iDc/ip9kbavfcemo8nBSWGXE7k+YwCr0TRr5dEDe74lHR
	pbJJqKy1+8EgvsFMLK8IxhbboEeqIm14NN0DJcCAtBmW9BOp4wHZFi+kYRuw4/hMb6lwNFfJQrl
	ESAfYMoLoPy3gFah+TrHHmOt3mS/xYvtvUFFRe+ytz2fZgqVTzvupIJSCfAQG16RXffgEnWBkLy
	+PBYI6AlPu4B4sju4lZr68vNasjLT/WopfkZ4/UUlAxiWzfkKk/QXL11VgrvJRhke/hkodS8RwU
	8stKuCIMKzrScGlgOpR2bsQ2xBXxODZC/VThQEcYUj3aug2qnifRtKZUds5B6qDjFMJaOEQGut0
	YpLpzU4+88Rskio+piwnuvkVEVHjylI4FECrMhQOxQGRFaBvojJdM2zK6+biOTZXTKMHHXWofCq
	CGTjqrQWiFKtXOcpqU8BjnxeYFYRS6forgwCN4nUuddbU1heXsw/Q==
X-Google-Smtp-Source: AGHT+IEwJHHQj2UIIxWkRH2QWIfRMW5HiZmVPji97KG1U1u7KnRePSUjiJ/npH4Yk8b3fulxOxbuFA==
X-Received: by 2002:a05:600c:4f4a:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-477c01be32cmr4594385e9.16.1763680655232;
        Thu, 20 Nov 2025 15:17:35 -0800 (PST)
Received: from ?IPV6:2003:ea:8f3a:7100:6cbf:5f75:6c2d:3ca3? (p200300ea8f3a71006cbf5f756c2d3ca3.dip0.t-ipconnect.de. [2003:ea:8f3a:7100:6cbf:5f75:6c2d:3ca3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9e19875sm70906365e9.16.2025.11.20.15.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 15:17:34 -0800 (PST)
Message-ID: <22b15123-b134-467c-835c-c9e0f1e19e29@gmail.com>
Date: Fri, 21 Nov 2025 00:17:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
To: Fabio Baltieri <fabio.baltieri@gmail.com>,
 Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251117191657.4106-1-fabio.baltieri@gmail.com>
 <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch> <aRxTk9wuRiH-9X6l@google.com>
 <89298d49-d85f-4dfd-954c-f8ca9b47f386@lunn.ch>
 <ff55848b-5543-4a8d-b8c2-88837db16c29@gmail.com>
 <aRzVApYF_8loj8Uo@google.com>
 <CAN9vWDK4LggAGZ-to41yHq4xoduMQdKpj-B6qTpoXiy2fnB=5Q@mail.gmail.com>
 <aRzsxg_MEnGgu2lB@google.com>
 <CAN9vWDKEDFmDiTuPB6ZQF02NYy0QiW2Oo7v4Zcu6tSiMH5Kj9Q@mail.gmail.com>
 <aR2baZuFBuA7Mx_x@google.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aR2baZuFBuA7Mx_x@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/2025 11:26 AM, Fabio Baltieri wrote:
> On Wed, Nov 19, 2025 at 08:00:01AM +0100, Michael Zimmermann wrote:
>> I've also done some testing with the out-of-tree driver:
>> - (my normal setup) a DAC between the rt8127 and a 10G switch works just fine.
>> - RJ45 10G modules on both sides works fine, but HwFiberModeVer stays
>> at 1 even after reloading the driver.
>> - RJ45 1G modules on both sides works after "ethtool -s enp1s0 speed
>> 1000 duplex full autoneg on", but you have to do that while connected
>> via 10G because that driver is buggy and returns EINVAL otherwise.
>> HwFiberModeVer was 1 as well after reloading the driver.
> 
> You are right, did some more extensive testing and it seems like
> switching speed is somewhat unreliable.
> 
> I've also bumped into
> https://lore.kernel.org/netdev/cc1c8d30-fda0-4d3d-ad61-3ff932ef0222@gmail.com/
> and sure enough this is affected too, it also does not survive suspend
> without the wol flag, but more importantly I've found that the serdes
> has to be reconfigured on resume, so I need to send a v2 moving some
> code around.
> 
Could you please test whether the following fixes the chip hang on suspend / shutdown?

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index de304d1eb..97dbe8f89 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1517,11 +1517,20 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 
 static void rtl_set_d3_pll_down(struct rtl8169_private *tp, bool enable)
 {
-	if (tp->mac_version >= RTL_GIGA_MAC_VER_25 &&
-	    tp->mac_version != RTL_GIGA_MAC_VER_28 &&
-	    tp->mac_version != RTL_GIGA_MAC_VER_31 &&
-	    tp->mac_version != RTL_GIGA_MAC_VER_38)
-		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, !enable);
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_24:
+	case RTL_GIGA_MAC_VER_28:
+	case RTL_GIGA_MAC_VER_31:
+	case RTL_GIGA_MAC_VER_38:
+		break;
+	case RTL_GIGA_MAC_VER_80:
+		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, true);
+		break;
+	default:
+		r8169_mod_reg8_cond(tp, PMCH, D3HOT_NO_PLL_DOWN, true);
+		r8169_mod_reg8_cond(tp, PMCH, D3COLD_NO_PLL_DOWN, !enable);
+		break;
+	}
 }
 
 static void rtl_reset_packet_filter(struct rtl8169_private *tp)
-- 
2.52.0


