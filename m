Return-Path: <netdev+bounces-213496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF41B255C2
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A3F5A3650
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70492F39CC;
	Wed, 13 Aug 2025 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaLptxi7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378182F39C4
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121395; cv=none; b=XuIpjjPUDVtrykyW7EXQADSuiZ2uIL4U85Hy9BcBO/L+ie+oGk5AUqTFwgYUSKFYPAuRQm1BHchMtxuNw59evvq1GzzXTTN3pnc5WfL1SYixgNBDmoD0a7Sk+Hfj6y6oEMxFEjXUxAZpTz8hOs+stHSSYUa/XHN6dOe9UNSRjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121395; c=relaxed/simple;
	bh=HRVb8o861BhUJWPxpCds5KqxgnYEec1b6Lqe4ScIpf4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qrKiaqxiVa78jDynkR8cUnWub7J7b1aKqRFhlYOczL8fN2Lmro/DZ6GEg9LSfHl4tvwjBD/Desuz4mKOBfOrE9t9AAl8HGpLm7OrYUb1OgpixeGI9jmxcx4U/O44GKFfZI6eCNo4SFDU8a4Iq5vmSZ0z7WUmdZ0DWN3+l47m1rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IaLptxi7; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce5253a57so250063e87.2
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 14:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755121391; x=1755726191; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ncSs6CZ8ffcOA4wBuUAF7szRma807m8HT+EI69Pgvng=;
        b=IaLptxi7MHZxxHyCkZLv2q4wzbKpKXgJB/MnAonOfFtUg+zLHQtGtslL4HHqwHO1W5
         7p87TBeY8e13p+OaN9DzJcxqdmAdD+8RJQCM6+oFG3UjmSWui3DxpxVzQhbTHWAhXqxr
         LwUmPh16/sFKglzAz44MzzZUPMva8hMEW5fgwUv23NAB7bOryrN1fX+1mY7bYehF0IRG
         n2G59WMj88lg4JJwm12hTtOQkl1s2iQQgGamgYSys8pgQD5ks8t/M0cQ3z+C4ZZ1+7Xf
         WMof9AZun4wYYAYSBW0xAzHD8liqrEplMGDmwcTfQhWB4aPn9tuYhwXzLaXOARTz0b28
         Pnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121391; x=1755726191;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncSs6CZ8ffcOA4wBuUAF7szRma807m8HT+EI69Pgvng=;
        b=a8j/TYB8hNjfvy0s/k+1FebsgOQDsaWvKCRUu3yvmivgM7EiHkDYmknDD8d1qNQ1xJ
         XcafhJMpCpphrW516Cmq9OsTO0dIMNgCKFPUKNfVhIsYbmuwoSOTSYaXPxRN54ScdpEx
         6HKPs/lZ6KDrJOwkqnLffz4pdEMYssBo8vSxyQieGY+trL62VO78IZ+ORTmd7BKeCIfk
         YwGotRx1GaRwY44un6XrQlg1DIvPkfp94I1OAJ+f1iv/CvXi6lpx+ht3uex/dCtX1v99
         jn+pJWiu2Wf+BWPO7ORYKR6t1XYybWeOquFoGAOTePZNTsSZpUL/rfBSXPD9e1SZRqgM
         I8ZQ==
X-Gm-Message-State: AOJu0YzPOx0iXaMUTrsNH+7/JgCdpMtgk+1cK8S7wbX4aK49CkQiHOLQ
	tFKhnUMsluqKTpIh8U5copXJ3cGMyVRAklIV6TeDz9e9/ct8/XUE5Tw0+MwgR42hjuE=
X-Gm-Gg: ASbGncsdlsG1TuZLxisgkFaj83bmjUzv7criiowkCGe6vQKUj30adhga+9LDRPkTag0
	b8InjCBidBIRDdTmhp2a/aGOeuYffgJy8V8VweBffUAdzwaC9uffi6wmrfz+vaH0GjgbrsOTswX
	5QYWJsGirC6XVVBe8pi+MLm/az0PCtnmiwihkPmDCkYAGvHUYAevIQDuq1or8rLeaSFzqlJzKD/
	d354OJEFjtwdVlwIohSCJIh35z6jL4jQZj6PT6vkdKsnb0mULw2uwTTCZBpjOKwJhSk0CkPPRkC
	SBRp/+NKtQDkAIj/wh+F4eAnPoX+MVyhBrHsHbDe9wGj8ALssawIXpXChEu4bfG/GteiJF/snGI
	ENA4xL4EK1T/RzmuWOkfeTAK1wxCvKz0jQK8S9ZG6wWg=
X-Google-Smtp-Source: AGHT+IHBKsIll2sp+LcSthISZLpMBWuI1Jzr0EsyjOqcl3HOA+d8OE6EtVH7tGVhr/ET8LsvAk9iNQ==
X-Received: by 2002:a05:6512:3190:b0:55c:e5fc:221a with SMTP id 2adb3069b0e04-55ce5fc22c6mr107248e87.39.1755121391213;
        Wed, 13 Aug 2025 14:43:11 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b95a105d4sm4732918e87.160.2025.08.13.14.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:43:10 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next 0/4] net: dsa: Move ks8995 "phy" driver to DSA
Date: Wed, 13 Aug 2025 23:43:02 +0200
Message-Id: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOYGnWgC/x3MTQqAIBBA4avErBuwH0O7SrSwmmoILBwJIbp70
 vJbvPeAUGAS6IsHAt0sfPqMqixg3p3fCHnJhlrVWpmqwUOMtRrjiYs4nLSZreq0da2B3FyBVk7
 /bwBPET2lCOP7fiUaDGNpAAAA
X-Change-ID: 20250813-ks8995-to-dsa-b58c90659a48
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

After we concluded that the KS8995 is a DSA switch, see
commit a0f29a07b654a50ebc9b070ef6dcb3219c4de867
it is time to move the driver to it's right place under
DSA.

Developing full support for the custom tagging, but we
can make sure the driver does the job it did as a "phy",
act as a switch with individually represented ports.

This patch series achieves that first step so the
current device tree bindings produces working set-ups
and paves the way for custom tagging.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (4):
      net: dsa: Move KS8995 to the DSA subsystem
      net: dsa: ks8995: Add proper RESET delay
      net: dsa: ks8995: Delete sysfs register access
      net: dsa: ks8995: Add basic switch set-up

 drivers/net/dsa/Kconfig                        |   8 +
 drivers/net/dsa/Makefile                       |   1 +
 drivers/net/{phy/spi_ks8995.c => dsa/ks8995.c} | 453 ++++++++++++++++++++++---
 drivers/net/phy/Kconfig                        |   4 -
 drivers/net/phy/Makefile                       |   1 -
 5 files changed, 411 insertions(+), 56 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250813-ks8995-to-dsa-b58c90659a48

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


