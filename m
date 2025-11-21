Return-Path: <netdev+bounces-240850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E29C7B2A1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CB1A34CB98
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82513502B1;
	Fri, 21 Nov 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnwyUmXg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59C28F948
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747912; cv=none; b=qFYqGhKde9oSrQv/vgAyLlvjoMarh47yhTx6NxLjhAOAT23zNJtqC1fUPz2x5+RRNLkNrAwEx3alK4jyV7eQVUG0F4I5zMovRleljqgztCbQ8ESlzYO1hP7wrPA0g0GO13ZQOSnSCQ4/z4R/Mue1BAVQj/JahSo+dRecmlSQ0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747912; c=relaxed/simple;
	bh=FKrMNSANrBkQ22Pod7R1j+jhP6J9vZ9e8+oS5B44M1o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=XS6vtN3eUpyND7m10KbqlhRPM+9SBBJI0zbZa/hpn+L4kk4ov+Zt6/PGLZ2XLMHTIU74hddMm6gkmNGLZCSeqTMNoCrv9D/fS/RAPl20MTHrYggelpu72bAM/tACwTSipE8skppB7DYJ1d0bQJrc1xzMF7qUvqv8bLBKFBGiX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnwyUmXg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso10696095e9.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763747909; x=1764352709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giPYyGhz2pEDYJA5pglbKzcooyNSi+qkZ3uFDmTohXs=;
        b=LnwyUmXgg0j6rTHVwVVGdKo+xHkuJt6n4cjdRmF0ozBwpUW53ZZK9gE+mKBplu/kwh
         Q6ftcN9LP/mryihi0jM1o2MuQTlwAchZceTb6FBm7DAvOKdZaeFzEgPxhbaamwaFtqGK
         sH6Qg3DbTqmc47fYGY13zmN4IKwzOTJD4IoX0jWk7kpfkV9T05vWNWRtEJ87GXF8cgK9
         aNLwBeRtbFgCtCokycWFDgfyQPDdXrDCG/M+3zDANt55eYXdkGgdja7y56G/kiC2qHAW
         V1mTgW33S3m+QDJvTJCxLSN0NRkN60HhND5HyZkVQ0vvgcUc1qa3mNqNW2vQ2X7mDEz+
         c7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747909; x=1764352709;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giPYyGhz2pEDYJA5pglbKzcooyNSi+qkZ3uFDmTohXs=;
        b=LjoGXpAIy9F+B7PyCguk235gU5tbGrb0RvWnCAdsTu9miWHj8GUiXNc6wsTx45T2Hy
         ea75Q0ZOEv5r2m/yFFJDAefnJFcPfeGfwC/kKsBt2ujkf6X9u5OLaJi1kQyz1Tn1q5fm
         8N0NfEIYmOwHCbkJkmdeiIb9xc/c7N97+t5Qv0GD/7Z92bKixYYm0W7IRhW8AnF9FKZL
         1Nsrv5QnBp5XapJ9uaNULLW47IFPvcTiUOBizF0uyLjSnbiHmBhIlNmrXrVXiqtkSgzp
         XkAYGr16DQm1mxrAdR9OBSFHg9Ncqfi5FaeFTMvjFwu6GupMvo8auPeJPFuqRJH3yZ4c
         aZJA==
X-Gm-Message-State: AOJu0Yy09Y2fy7iiPdZ/6TQnHrX5/aBfOclyIN0m4nIWX3wCGlvdCtaQ
	CchG8BZzvOdOjNmehT/5ypDHxHa9GxPQyEa6mlstmAHhoEfkKXiuoU8h
X-Gm-Gg: ASbGncsBzlbHL1Hf98bedtxQTtj89dPfmPvmNkZ5hpbPBicyaKOs5IOimSYKssua0Nr
	pyqrcHPBz0nQMMWHFU+m4F6fseV9CxrYHgNnVX1IuJcv2h2T3Bkn+W/Xexwj69OrIrtmUSm/Q3b
	NbJpN3fD4Mwsn6e3e17EqVb5GCyINqRlHtu9Nl2vGMHU6c3NCvT8zPU1tb7jbluP6fA+HgqHxlY
	exQ1Ui5URgCs5Tfpz7eS/DJPL7jk3dQrLXQYAAtZgPHXm6G7yoqMf7jPAUmni/jQMtXcxMC0fjH
	rKo6r/90MX9mClAv3yTbXQ3BoqJZ/TYdVERpL5FL8qy9esnTKg7U+dKUSKuXRnMsNHqr9KeDf6J
	twosKS4TMqOgkPP8xBEjxFfO8Pdu/L7ELvkvvmSJVoeenvNOacOSEWb8XMbgLohDHVlIUjuAjMn
	NA8dIM/GaLGEwdknBcq2oJb7VXx6IlmmM7GaO+3AFlzCIyq9ftcuwAotlBbZFmBooeUDBcV1bNq
	Ds58KL29+m0ZJ5EzOLyF+BZw7I49t8fJD1jKMISKZupWGATFetsaw==
X-Google-Smtp-Source: AGHT+IH0BC3z7BBAEAbg2l7HkvO2baHgKR73AdrSagox/M4GiX+G3msfovUwd46nPq0PtH5IztZzuw==
X-Received: by 2002:a05:600c:1d0e:b0:477:bb0:751b with SMTP id 5b1f17b1804b1-477c01c4d79mr32118515e9.27.1763747909278;
        Fri, 21 Nov 2025 09:58:29 -0800 (PST)
Received: from ?IPV6:2003:ea:8f20:6900:adc4:1eb8:ca42:9808? (p200300ea8f206900adc41eb8ca429808.dip0.t-ipconnect.de. [2003:ea:8f20:6900:adc4:1eb8:ca42:9808])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1f365fsm53677505e9.8.2025.11.21.09.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 09:58:28 -0800 (PST)
Message-ID: <c8f46dfa-00b2-4802-9009-d732005e685b@gmail.com>
Date: Fri, 21 Nov 2025 18:58:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] r8169: fix RTL8127 hang on suspend/shutdown
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There have been reports that RTL8127 hangs on suspend and shutdown,
partially disappearing from lspci until power-cycling.
According to Realtek disabling PLL's when switching to D3 should be
avoided on that chip version. Fix this by aligning disabling PLL's
with the vendor drivers, what in addition results in PLL's not being
disabled when switching to D3hot on other chip versions.

Fixes: f24f7b2f3af9 ("r8169: add support for RTL8127A")
Tested-by: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

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


