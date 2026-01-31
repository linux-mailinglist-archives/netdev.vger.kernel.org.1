Return-Path: <netdev+bounces-255476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MS5EMM+fmk6WgIAu9opvQ
	(envelope-from <netdev+bounces-255476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:41:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2066C3607
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71FE8300C9BD
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDBE3596FF;
	Sat, 31 Jan 2026 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5ftHZMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AB334370
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881039; cv=none; b=krluDk6C4/QS9JZqdzEXwYFCUd25+ma0tVdkJ+4RFNj3iN+beQN4HpWEXG7f+EoAtoWPIMNMOBo9l/9XJ3IQbeOiTSIAYY91Qa7j/qhidvovZk+tAbS43YmFcDfOZMLzxULPrpy+HeeHF1G8vHCALE1fu6XcneUj1by49VroTs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881039; c=relaxed/simple;
	bh=LGVXFi6WMPOCw7rPxLXCeNTYxFBo2z+M/yATfmLE4f8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AKP3t3J7Sw1ZMC/SiaJBLfDl5H0QJHgChik9jUuI4e85THI9VLEi55/NaM4qD98g5zusdzBodExAIEaFVhVWZ5FnXEqeZrZ2QrMUsXh7XJA25horH/YpmVx/SiDO23IqK55URK0+/Bs985whjNRWgUEjXCkK3oKAz7D/94CU3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5ftHZMZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806f80cac9so17570615e9.1
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769881037; x=1770485837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYMe//J1dmrcFYyrvQhkAMkMjiF2hvrG5H57SCgTjoE=;
        b=h5ftHZMZmksxbHfx3oFxy6IOZBSbn9L129LM7N32EnDdp5CkpT8K8enjF8U24uDNQ3
         K+j8n1gvHDZ81iSKzv06+JkNNDj6QBji7Oya8htcw2IvqzEQepkVqvOUUM4KOn5UooXE
         Ugd4Z79QxsqrMWaR83a+JyymtRjL1yCRD8YtXnJ8g2XFGoXE4y/Z4rt5E6/RfvxkHNZn
         9+ZVh5KdEmluMXZAGZWNesYUhCYtKgyeFmeoNR6yu26GtsFjpu1Je5PLhFo5yFxnCZoF
         s5UKcnOcEQpQApOKF/TDjPw7MpY1DVhTRCd4gyEUMgTGtl73irNsheIVTd3r/ttEzeSC
         qlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769881037; x=1770485837;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYMe//J1dmrcFYyrvQhkAMkMjiF2hvrG5H57SCgTjoE=;
        b=Tnh/+ZDq/gr7/EaZacAiUd+zOy1ozvfGdL5bcdWGeB9XEeayHuMiLn23DthKZ3MawI
         Hs1sYpYxPFptQv9p54y/FuvwLqclqCWrbax7FqKNikU8tC0Q25tr1jPQhH2MFlDxAxx+
         MG0LYK42rzvAIzQVq2s7K4i7n0xnV4cOYfpf9G6M4BIQzvhbVTSigufhD/p1TtNQAUcP
         uMEC7JPYyB45PQviM8r9SNX998cEgPGQ5wshgeDlBKYb4o5nXAiVlYpuiwWiVlHk5gr6
         VRmjkwU0OPsipGSu4fnSOW+1J7woB11teMmagnB8nJEDr3syqHgdGM7PhSUOncAU/o65
         uVLg==
X-Gm-Message-State: AOJu0Yx7CzaDQv+xJ74Jwc5/oB4u5j1PI6SwLjQ/D/pwHWDZSgnVk5vk
	C1sdanmkAmHJL+XTKbBudswzwiYH9hCPJVeNF4JoRTSorV4lgnbG5ep8
X-Gm-Gg: AZuq6aJxRRo1S5zyHYhwFwhhZB+GadNqYhIl1jcdOmUNPOvNVJoRrj9c9X38upXDBHp
	+jTx4SPx7A7VrBEoS41zmhm2JSYY/CjHVQ0VcUkH3AEKIPl0aKyoZba1cxW9tLrcDCePiAdyPxK
	fFEbBbWTUwILeiviOcD26fWYITQN27xWKue4mPuBCepU7MWiAuHVCOUGrMd5BSYwHqPEaYk/+5m
	riSmds08b2hh2nYGsMIuN8ALhkkIm4yfUBk91KAEb++FKCmg9+pg3MM5n/VzNTMs8RiozNS8hWO
	JN6iTJNAIlwJs0XT8IBasxRhBLhqBeg7h8d/EGQdmqas4S8P4ukpfoshbEeFPAkTPtYDfpL3aI+
	AuytfWSfeGuSEZ85AE84J8wuWYycS/vwwJNEXoM/WHFz5FZkQ5a9q81sZHjt5NgxDoz6WFDQRuG
	UTPFf2xx0qfqkc5JzVJ0Pf8jwDn46dNby+OZC9yIohJAflrPvuTqSZREGQcQMJHBeM8uqqaRRzI
	SaGs6ATmNbE24rfU4NxZtZK8/f6dtkeReYnBmSppDGbc8W9
X-Received: by 2002:a05:600c:4fc7:b0:480:68ed:1e73 with SMTP id 5b1f17b1804b1-482db4f39fcmr78310125e9.36.1769881036638;
        Sat, 31 Jan 2026 09:37:16 -0800 (PST)
Received: from ?IPV6:2003:ea:8f06:cc00:41be:d7:a063:4025? (p200300ea8f06cc0041be00d7a0634025.dip0.t-ipconnect.de. [2003:ea:8f06:cc00:41be:d7:a063:4025])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e490esm30372103f8f.9.2026.01.31.09.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 09:37:16 -0800 (PST)
Message-ID: <61bc14fa-eed3-43b6-ae40-b98063e81578@gmail.com>
Date: Sat, 31 Jan 2026 18:37:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/3] net: ethernet: adi: make name member of struct
 adin1110_cfg a pointer
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Simon Horman <horms@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d9543e7d-23e1-4dba-a6b3-35dcd6a35dec@gmail.com>
Content-Language: en-US
In-Reply-To: <d9543e7d-23e1-4dba-a6b3-35dcd6a35dec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255476-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,armlinux.org.uk,redhat.com,google.com,kernel.org,davemloft.net,analog.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2066C3607
X-Rspamd-Action: no action

Primary reason for this change is to remove the misuse of MDIO_NAME_SIZE
here, so that this constant can be removed in a follow-up patch.
Use case here is simply a chip name w/o any relationship to a MDIO
device. Also there's no need to reserve a longer char array, so make
the name a pointer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/adi/adin1110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 30f9d271e59..01b1bbcce48 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -123,7 +123,7 @@ enum adin1110_chips_id {
 
 struct adin1110_cfg {
 	enum adin1110_chips_id	id;
-	char			name[MDIO_NAME_SIZE];
+	const char		*name;
 	u32			phy_ids[PHY_MAX_ADDR];
 	u32			ports_nr;
 	u32			phy_id_val;
-- 
2.52.0



