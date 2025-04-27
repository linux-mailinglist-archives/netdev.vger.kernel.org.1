Return-Path: <netdev+bounces-186321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D059A9E483
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 21:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA4C3BC16F
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 19:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C39A1D5159;
	Sun, 27 Apr 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnrzW3iS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C4F8460
	for <netdev@vger.kernel.org>; Sun, 27 Apr 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745783993; cv=none; b=Gl0uSpQQBPBWPV5RpZeuZ+rvEkYDTc5KD39VEkycVOfBVfLv1tw/cyvDTIQF/5r4ao21pBkTooXjelhQttFTiZSmw4OLhzc31YScZNlYAJKkhA8hO9ODUz50fGb4CSgw8ppC5DsPZkzywUdFeSDjQdN86SkPZEYyyTVq8QRIcfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745783993; c=relaxed/simple;
	bh=tJtt58nTqiDH2+LkcryvsfzqgufNw/1FcphVvaS5mfk=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Inbdjjnxd1wdfbGFyZgooiYgFgoPaLWr3KcL48A+lXS8moo017v+bSO2vwNBU0OKsTZbeYNoGG9KPCwEysSorI92YRwoUv4i+HooJq9J3ZPacbo0fzJXgLSp+0xFtnnn5oL0Nn4krfpGydChQxaUYPvrFbKw1N4wFt7jGIB1OiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnrzW3iS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736c277331eso4771206b3a.1
        for <netdev@vger.kernel.org>; Sun, 27 Apr 2025 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745783991; x=1746388791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=VI3JLnYqAXVNLw0whXyr7bWIBnikb0sD1fsUtUNFM2g=;
        b=fnrzW3iStsL5khNHfXCMtPQa3WCECAU6AktvxpZ1WtTPTnCVXL87Goo3ssaNz7Wd2V
         ZNDnkE+oXhX3SL+WTuIBspK57Q6kjoGsTnfTS+bME1qwAWJyvQZ099qBFFPu4gEPUyyo
         6Ml6zRrq9yk8VUteI6toNyyf4muRAEFtxJmwgyjd0pMi57r76LWKXcn1icTeFKtYB6oX
         FrpRnjzPyqeqlHvge4XIHgrG0O9jHBPM6xm57fwIwtI7SKMVKrDDaILNH06CC7M1LzRJ
         EpZdu2csLWypmsQ916GqCIysIEf/0jT5uXeVLJmWUg5o7IFg7/4lLjfo6Cp8THGqKczE
         WWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745783991; x=1746388791;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VI3JLnYqAXVNLw0whXyr7bWIBnikb0sD1fsUtUNFM2g=;
        b=nCeS1j9R7GaCx4YmRmfmCr7bxCa2z5SOdsle6uXoe49/2ur9ft9DbTFaYm6fvQcZTy
         Ok86SWgQLPE9B+f7v5t2ZAepmMqWpd9odYgPmBPEggf1QYk1FS+QvX0Cv8QtuXcsKkZW
         H+qvwrSuHcJfQt+XgIUsFGW9REBp2bPn8LOkLk5g5gVjxL8aGG1Q6YwhBf1zm1rh53ic
         scEVL3++01NZTSvLkTIk/HLphXC5dmNY3uCGrjY1fFPiDiO4vOwirmkD31Z4AthEkVPo
         YD6fIoXF878/h1a0FbJXaAxL39jI8jQgoVXxUXVAMKFFRsNIG9XWC5vMj6UKUKEFoM/p
         /wRg==
X-Gm-Message-State: AOJu0YwWwUY8bZLYLTWm4ep7SZV3jKk0DVd00/I6HXIQUO0D1abY596N
	WFMjHMQbV1PvTx0z8jK/NAp0Cta+fFHPMg+XK6zdXht463HhO4geYDnbog==
X-Gm-Gg: ASbGncuOzIGi8vFQLEk49wnQOM0Vrr0krOcaOCfKDSUPeLgpWlo5ZggR2ENqKeh7CNh
	etGpu0bd5El/6wy55Ug9ZdVIOTt8b0rJ4KUC0esL6xx7BvN4Nm0MGnPaIy5XaIN39zBRo29ZsHk
	iX6bMv0YIlzuaHUngI7Pljlk1LeTyoQ6qqJQPiC9lpjo2dS3JGX5ZWeynhxtS/kzQWOLBQt8zbt
	6ylWUo32g/B1lnorl/ktOo+Sfbc9ysaEsIh4lNKLSWpJ+2X0r3+4u7kG6o+eeKbDuhwJve4SAj3
	tmbIPgvvqEYCcErgKrKY1oTkL11W4N3TjvNlzmCTEdVA97ekpcnq0yAQkR/RljJ9LecOWkyGl8U
	p2Sd/
X-Google-Smtp-Source: AGHT+IHfcB7EMSF4FlkEquOzIu84FQmE27jNwPbzBo1UfmfLPDse+52tmaASBDsQWYZ++g+VCsH/gg==
X-Received: by 2002:a05:6a20:c68e:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-2045b4583camr12682465637.11.1745783990667;
        Sun, 27 Apr 2025 12:59:50 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.39.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25965823sm6534336b3a.78.2025.04.27.12.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 12:59:50 -0700 (PDT)
Subject: [net-next PATCH] net: phylink: Drop unused defines for
 SUPPORTED/ADVERTISED_INTERFACES
From: Alexander Duyck <alexander.duyck@gmail.com>
To: linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org
Date: Sun, 27 Apr 2025 12:59:49 -0700
Message-ID: 
 <174578398922.1580647.9720643128205980455.stgit@ahduyck-xeon-server.home.arpa>
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

The defines for SUPPORTED_INTERFACES and ADVERTISED_INTERFACES both appear
to be unused. I couldn't find anything that actually references them in the
original diff that added them and it seems like they have persisted despite
using deprecated defines that aren't supposed to be used as per the
ethtool.h header that defines the bits they are composed of.

Since they are unused, and not supposed to be used anymore I am just
dropping the lines of code since they seem to just be occupying space.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1bdd5d8bb5b0..0faa3d97e06b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -24,13 +24,6 @@
 #include "sfp.h"
 #include "swphy.h"
 
-#define SUPPORTED_INTERFACES \
-	(SUPPORTED_TP | SUPPORTED_MII | SUPPORTED_FIBRE | \
-	 SUPPORTED_BNC | SUPPORTED_AUI | SUPPORTED_Backplane)
-#define ADVERTISED_INTERFACES \
-	(ADVERTISED_TP | ADVERTISED_MII | ADVERTISED_FIBRE | \
-	 ADVERTISED_BNC | ADVERTISED_AUI | ADVERTISED_Backplane)
-
 enum {
 	PHYLINK_DISABLE_STOPPED,
 	PHYLINK_DISABLE_LINK,



