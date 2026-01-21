Return-Path: <netdev+bounces-251955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB+FCPn/cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:34:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B0259F3A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB8887A22F5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CCD48A2AC;
	Wed, 21 Jan 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvbxeT/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBA4266AF
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008526; cv=none; b=ZBHjM6nm/a4O/fe4QJdc9ClzupNyuRvxRLfQqXsVoK+J/QviV3kwqAJbJVjSNYLbr4lZKf0uz+5pEbsS1MdlV9IYz4zCQ6U0FZJ0GZdYROlY4CpR+UF3M/cDdubpJlZCJxMjsnDVPy1cCl3dEGzepGbgPr9GdcPsj1dsYRvi6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008526; c=relaxed/simple;
	bh=DsU3Zu30epjjwrwimapEIoedCiWhEKafmSQR+5ASO6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWc1otn+rpzxlVchXPsFOst08HWcRKBKkNYig2I1YlrQllErNAetfE3AP+a7tpYy76uKozbw2Bd1704uQqQYIqGn8DgUI1N8Wte82CJxpQtdwlbKrLqofhICo/vl50TE/uUksBdLb038tiYl96Epx9wG0fsrpMHsku7z05wBzWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvbxeT/b; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so3632872f8f.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769008523; x=1769613323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38lhwVKczTZBTBM6Di7O4EQSmvRNLjNMNn1R3UxIv1I=;
        b=DvbxeT/bhx1PGTk3sCbWB1yu3ktmyOXipRxQ9P23Cinxr5LRHH3nkymC34BZaLiaTf
         jiEF1m7njgT8/3/sQdDjsoUgQzd111IdlOwr+f85MqUSyUCHwL87qepmzOhN+pKf1tWE
         Zcs1a6Fp6NiMZYiov5A6ndd+3msqT8ISId0UghJ2Uzr4A/JYsOUcD7i9lZg+/LVClayi
         QLvLRs5eFsyR+HL1JIbShAox+MJhFotv5ecKzWpQS7Y2YQ5PyqWwa7Q+XCYhBBLRLlWO
         yy4O5pZ7iD08Q7yXiNGhTMcokBab/qACD3x4NLZW34SQH4o69tG4i/PIPXPZZmYAd2vW
         c4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769008523; x=1769613323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38lhwVKczTZBTBM6Di7O4EQSmvRNLjNMNn1R3UxIv1I=;
        b=J7N6qQ7+EZHlOdUofhZhEkI2X6EP6n8r5pi1cH9dNacehyMuGH7KPhXMdsHH+MhhlI
         ZVXtMW0bE22PkQ4Vd/GuA+Iqn29NsLmAXTUZp/BsO6RMDS4kbZg/IWkp+hzKJCBG4d0g
         B+bn4DO8DRgNKCJlVP1eY7kgNl2ZViOYq26Tpl7fgE7ZwaCoZlWZEnsRS9596zJ+AKrB
         dTtyzU12Imb6/quw8aR+90G27hOu+nSJ6qVJ9sp3IkHN97PnYroDNOvkiq3kmGgGKGRY
         OlTziojN9XbuWUBt/7IiO17ysvWLqtZPRwwACahwQSC8X3NWNrCJ1LAoNGVoW48+Lwdx
         4RdQ==
X-Gm-Message-State: AOJu0YxKABN5m+ur8inRNk+PjrXnlpqdrtjhSzdw4TGB1kTc+FmfQBPE
	uDXDqKmjZOXi46H1WSK6xJm9OS58eWPF9IY8AflbAVSlQtBCYx5bTrXm
X-Gm-Gg: AZuq6aL8Bgq0lBzyVsVaqB69TuBeM3bJpvtqQ86XsfCd3yYDLS2d2zPPMKyvM61wL8V
	TJ1M1j00/aJwo1cVLtW4/aqRsHZ1/NSUXmGj6K7fVCcVxjlxXj116i/IMvELZeOGB/IPFngwsDo
	jdiHPsw1cWDhd8eDLEU4KJr1KiRsbPTGP6dr6x57GRsSre5RTT/ehELFxEDfOo6trjrumIAA9Cr
	lktTpnekbWP8enNxfrUGwq+PWMo7wEy6QHEoMjxA2/5tngeX2chsIDHn7Iyen9CEi1/iJ/0Typn
	VhGjZeab2MulgP4toFmqscS1M9tpa9uaDWARPpItadc+7nu+FdkY9g0SWseQIFMamO2TlKz0q6o
	ZhoIQJruoIl8m8dFBQGdR6poTffRu18vvWBp5UHkgrNI/MrdnPdbWXIN3VOGVL//2/9baWVJQAx
	Y9GXvPldEsABI=
X-Received: by 2002:a05:6000:2481:b0:430:f463:b6bb with SMTP id ffacd0b85a97d-4358ff4465cmr8389850f8f.16.1769008522696;
        Wed, 21 Jan 2026 07:15:22 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435924ae6f1sm10534349f8f.33.2026.01.21.07.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:15:22 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v2 3/4] dt-bindings: net: realtek,rtl82xx: add a property to set MDI polarity
Date: Wed, 21 Jan 2026 16:15:05 +0100
Message-ID: <20260121151506.813783-3-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121151506.813783-1-dam.dejean@gmail.com>
References: <20260121151506.813783-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-251955-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B8B0259F3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MDI pair polarity is usually configured by the bootloader.  However, on
some designs the configuration is left untouched during boot and needs
to be set by the driver.

Add the property 'realtek,mdi-cfg-polarity' to configure the polarity of
each pair. Bit 0 to 3 configure the polarity or pairs A to D, if set to
1 the polarity is reversed for this pair.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index c4ced671ecb8..17088c147358 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -61,6 +61,13 @@ properties:
     description:
       Force normal (0) or reverse (1) order of MDI pairs.
 
+  realtek,mdi-cfg-polarity:
+    description:
+      A bitmap to describe pair polarity swap. Bit 0 to swap polarity of pair A,
+      bit 1 to swap polarity of pair B, bit 2 to swap polarity of pair C and bit
+      3 to swap polarity of pair D.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 unevaluatedProperties: false
 
 allOf:
-- 
2.47.3


