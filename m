Return-Path: <netdev+bounces-176235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FCAA696D0
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2753788329C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BF41E991B;
	Wed, 19 Mar 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHa3+kr1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E11BD9D3
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406389; cv=none; b=TkCnbLhzNnNIoVJa69/fNP7Hy5sZo39ZmRZ6Q7O3OTZhqIg1qR4aZ2g0qClfHOSbdp5AxdfRAu61jPElqeLHChoxEl/9GqMm6//LXYoB9+296TaG1dBBe5OJCiiVesygMq/ycM58WApLbPp6rHKd0FgpICERMFhhyK8tf99OyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406389; c=relaxed/simple;
	bh=U2+oos0WbcMSd/lEPs4pFVJqUIiEnR5xvYQIBZ/Gy/I=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=GRKqSSogHfYONn2ddTkGk/cKI1U4gbbnxEwM5laxfdO3bKBf6H1+BfJWED3QxERGiywfxVHI2S/ZVJZ2G2ojhXbc880SsLLgpYropEXo2hB9mSxHKagUWR7ec9RXAowvcrTzgFMlS3eCkxpruw/PG96+x8w9ehoJ5dmGWtVIi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHa3+kr1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2235189adaeso22368815ad.0
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742406387; x=1743011187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=5abAT6qXhbNJ2jf/Y6Z31P6KOCLsa/UUsoK7eeFtimE=;
        b=eHa3+kr15PRdxtY0w57+Tv+mAA2xlMdZXSno46a873HkZ7hcZ9LtcTstXejnYih82Z
         S3T8E58t1z/2Os+kyGatrA6+7gp6tnBQi2WKXOr34pKkgTvBaRpeyn3uvdcZDUoRFapJ
         6olcI6wu4K9f6qgx5autQFDVf9AtPFqJU7IZSmub9pz0ZQSonRBeDlPJTgn9wLNOlXzh
         hY3G6MK9a2mru2z83wPEWlcpks5DAqk/RKLeQQy8SmjD6dIx6S1zE/fo3Hudv2iaG/7f
         1iKHQC77Lx5Kta3rNl+7VhICKTeG3uVYjvPJDDjrJf5AQtLCPazHyFzFx4qiCFm7xGGS
         OpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742406387; x=1743011187;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5abAT6qXhbNJ2jf/Y6Z31P6KOCLsa/UUsoK7eeFtimE=;
        b=H8gwonPSy+H/MZkc+goeyJrq7lkuQkyDpFCmH2WiNHR8xtUkTnPk7hc3TTszGUQaGU
         P2so3610ZcF3NASh3jQWN5XxMpUawAk7SAAbKB5BR7NPyED51XWskObe785HCfFkXqKq
         OWPojRQr/rPOYSW7bCt/bnU50okITfeiMk0SZBJ1lMqWjC5fDhjhxamfaE3sxSIQc9+e
         FAnr2m7gEKYWj7dFEk2jROmriC9poY6h1FarzZqZ9g3NF0X6zXYhVomg+v/YOVRvaoyV
         X/1FoD2rCn5vfeguRQhnRePV9jQwEgBtKLT73cwjf0wFLgO8pHvQkotXTTW9trwkKyhy
         B9Kg==
X-Gm-Message-State: AOJu0YyfVbs4SIyxoln14AEQe0u4+7fFjqUTT2cLqVKpr+0h/TGmL4m2
	VyKYLTMmOa9jNEJmbohLtvpDbTuHRQKnWWJAMDAsTvn2J2zOIz35
X-Gm-Gg: ASbGncuSqDmdCaNSWEzov7oiH1/VOWYBbdOViAC9GrCdi6tG4fYZ1G+dsf47QPyo+fh
	nVlSRCzwChTJR/81jQMykzbkSNX5kROVkXb2JIjqDNs4rvnkD8RW947fW/vbb/gbIIg5bWO0wJx
	qgWl8/54AINHjRq94d8ntNcxdgy1OGC4DfcKyY1CHTwDta009jdXfq8M3aRLdb0e8jw51xmlGOQ
	ilp8tmOs2UKsVzMTHrlQg6IaCFBH4guGll7lXrvhfK8tKqnUjh7yuPztuUJOGdSXBkdB+/HGHr5
	fUSnlsMPAkoi9SUd4nUMLowutfRAg8CxEtQMpfeVRK+d6NDos6wc133ZGU8HbT4CwpeuHH3ehg=
	=
X-Google-Smtp-Source: AGHT+IGDd2fFG+OLbMBEwLR0YL4Y5cS5UUFGvmQelKjrderx22akqhY/ET1wwpGsqRc9c79iLUsawg==
X-Received: by 2002:a17:902:a70e:b0:21f:2e:4e4e with SMTP id d9443c01a7336-2265e6916c4mr4876865ad.5.1742406386800;
        Wed, 19 Mar 2025 10:46:26 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a7447sm117111525ad.74.2025.03.19.10.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:46:26 -0700 (PDT)
Subject: [net-next PATCH] net: phylink: Remove unused function pointer from
 phylink structure
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 19 Mar 2025 10:46:25 -0700
Message-ID: 
 <174240634772.1745174.5690351737682751849.stgit@ahduyck-xeon-server.home.arpa>
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

From what I can tell the get_fixed_state pointer in the phylink structure
hasn't been used since commit <5c05c1dbb177> ("net: phylink, dsa: eliminate
phylink_fixed_state_cb()") . Since I can't find any users for it we might
as well just drop the pointer.

Fixes: 5c05c1dbb177 ("net: phylink, dsa: eliminate phylink_fixed_state_cb()")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phylink.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0f70a7f3dfcc..16a1f31f0091 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -72,8 +72,6 @@ struct phylink {
 	struct gpio_desc *link_gpio;
 	unsigned int link_irq;
 	struct timer_list link_poll;
-	void (*get_fixed_state)(struct net_device *dev,
-				struct phylink_link_state *s);
 
 	struct mutex state_mutex;
 	struct phylink_link_state phy_state;



