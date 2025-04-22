Return-Path: <netdev+bounces-184917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B27A97B19
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67201748AA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7827621517E;
	Tue, 22 Apr 2025 23:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XCBZvtjF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578121ABC3
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365023; cv=none; b=sKlXSKZEbZAwazqr4rwnwJyWan2FB5zGKHMgXB0VeaQrOuTQ2i3yDNwgGv6KssR26AVFC1RkUjn/FQB4m5jytgSzcXzHAI2vw3WeU2rjyOZW3VDEYh44UU7uRzub5LZP9O+JPIXbnSj1o0JtetWlUusG6tZpsKa4z49ZPwD4MOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365023; c=relaxed/simple;
	bh=+DBCN5bOsxIpHuaxju6ARkxFGZn9aq1H7CONUMUuyY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d00AazJuQ5/dxg0WrLcirtdmtu9FTIOUq9+VOb4xrM9AeEIq48T015lJ9gD4idsboAeqvcIVLMxI0lgn8lcDL7WuaLW/7NWxM2U1V4MTATjGzWGTIpZ1fnitXhgdRtPvHX6cW+pgE0ddtdBDxJJX8pVnjTUfWVKGkaOGYLLQOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XCBZvtjF; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3fefbbc7dd4so3021596b6e.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745365019; x=1745969819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/ShG8RPtrgSysLJ68laHr0SdiKr5pSdLkIQgs+Vmbs=;
        b=XCBZvtjF0Lxf+M93cyAQv8vPucTGx/XqqwJgsB3a31L/t0GcmiGh3uRm0lB4cToDod
         8Cn5dSyQm0TIWY2+NhWWn5cmf7y/0jw1MKlze3vFdnXKvTyY2MBI/GeG1vEBt45YHWbw
         FyzbtCB3Bq+KGLch2yhJx7/xsmwiYOHLI0Uhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365019; x=1745969819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/ShG8RPtrgSysLJ68laHr0SdiKr5pSdLkIQgs+Vmbs=;
        b=SXOucOatXuv3Wf24+7jrshlJxJHOFsrpMwyBDg7DOVzifZ1P9HwoTrulqfeVfoD16l
         p9DSnwghUIpvXYHysNm7E0/Rj4wTKLmxoTcLwkpLFcj4GwSQasja89p65xicd0mCQpTC
         lCu5ifZxe1UvWiygjFH0Jx1+Y+No7BLf7XsglAqrqr+Vr0z5dvCxB2DiwWsDlVAQR0HP
         6I50YR3mpq4xanHgGnddqlpVVgfPZpRo6MaXnNwNNxY2BclN2tp2JrC00aozrfVqgGjO
         tApac/rPdtiOIHvCkgOegzWYhti2O0RfyK5flzmyA/GH68tiY0awL6UG5VOeXKldsuC1
         HMiw==
X-Forwarded-Encrypted: i=1; AJvYcCXwvHi9WhnWxvxTsIH3hRq31DZpG5QBdRARtYvR8JBSruhs8bbOhi+dJnbnGeyWv8fwLosc5JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80BygwEloeK3GEA8P9JC0hHtX+iD6QoAqrrJXsITk9C2fkVp4
	EYI9/qEkw/pKL8YdynZvzXiU2TGpY9wVTfXM5cFKXwcbC8KI5jmoheWa7Y9e9Q==
X-Gm-Gg: ASbGncsuJQR5+W7HFibzbXfSZTEmnazZgD9Sr5N5Dup9i++AOZM68sxPG7ij6bLSj1i
	Doq5tM/rIHk+/HVWpsoBRLuGio/Y7g5x9AH15IwIFVrrP6HeHJ00JbVjqfa0wqAlMiMZSdbCotW
	7Zk1OXYxTEqxSHv4eamwRG0RelhpKsxZ+uooEz2qqSDKqlntYJ2nzcT8zI/fzTfIsuWVSQpjB/3
	XaO7pvvVu1sPAMWcvL/ojLBMtL1IiM6wi4Fj4HKob6TTwUTnmBEa16KxwhlUaPySfdr0XTUju/g
	TojjDUBf78OrkejiCRP2sBG772dIzYrvAMF8Kw8BN3ymvrxj3HdYfMZvmTzayt92NHsUC+wvZCb
	kEiErxV/mvdYLeNgUbg==
X-Google-Smtp-Source: AGHT+IHMxMjXYyQTA67mlD+Ryv+o9jeuL5P+UtnyhxSObJZpWwmHwAYwRKnnv8RA7uOXtpmiwxvl5g==
X-Received: by 2002:a05:6808:6a93:b0:401:e9e:9da7 with SMTP id 5614622812f47-401c0c3144amr10464789b6e.25.1745365019362;
        Tue, 22 Apr 2025 16:36:59 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeaf403sm2333582b6e.7.2025.04.22.16.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:36:59 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Cc: rafal@milecki.pl,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	opendmb@gmail.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 6/8] dt-bindings: net: brcm,unimac-mdio: Add asp-v3.0
Date: Tue, 22 Apr 2025 16:36:43 -0700
Message-Id: <20250422233645.1931036-7-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422233645.1931036-1-justin.chen@broadcom.com>
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The asp-v3.0 Ethernet controller uses a brcm unimac like its
predecessor.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
        - Split removal of asp-v2.0 into a separate commit

 Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml b/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
index 7eb6d5839f0b..43516dd357b8 100644
--- a/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
@@ -24,6 +24,7 @@ properties:
       - brcm,genet-mdio-v5
       - brcm,asp-v2.1-mdio
       - brcm,asp-v2.2-mdio
+      - brcm,asp-v3.0-mdio
       - brcm,unimac-mdio
       - brcm,bcm6846-mdio
 
-- 
2.34.1


