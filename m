Return-Path: <netdev+bounces-178687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE1A78403
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B278167601
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 21:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C2120E703;
	Tue,  1 Apr 2025 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv74/0Rv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D26214202
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543003; cv=none; b=N/5UGOwMSwCB2BHk37bEqK7IeKeaSslfLNXhHRiyUEbPtepa+KY8p2pyKczBYPdx4yEhN3FnU6WVXy2lbmQNRiIIsAYWZ9xVQLHSDEsV8bZYHOZYpAm6wwPzh3j2lHEmE7meqHupLLX0YzK/Sw6xw43KZkwSg4m8kOZkCrQdiEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543003; c=relaxed/simple;
	bh=7LpPEtPuD+QiUDH931h4xMMgMRbi8IZI7UGlj5LmLEg=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=DUWSvHbB93/ZEOENrJMz7EGO/WLv13qfUmDQjrtOjgwl2MxxGXTw3QAzCCJ2B17Fg1Rx/TAujAArxwbxtgVA8mKQGBm2/oo7Ry9x0SpQqGbbaczG6vfH7P0OMEdw204sOJ2U60ASIft+r/hj6IjfsejUWflxDio4lCKvZmEnmUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv74/0Rv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22423adf751so112853045ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743543001; x=1744147801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=0VlIrCgN6pRungjnyFFbifkZ4lvEr96sycWjiYg+irs=;
        b=Gv74/0RvlP7DzMRtk/Mb2FX+2xJI8o/a2j+s9mMI668Ao1etYjKK71FKOq0qLA3nw/
         9sQezdlBYO23zivcm2eZIsHzqoRAm4PU2U5Aokfq7Ra+dNJLOo6LIBUXC30ghHwkdSZG
         2SdXUa4adZEo8y3NX8HO6yoIbjg7mD/M0TsEi+8M0YdAManaRove76CJSoaBvd8wTFgg
         BLw03wTGRO+kU/atwzJRmk1MwDUuKgkCZqVNO6rU1H1pG+toN/dfNmxH3L2NOVyc/Xag
         tq1l+765B/gqhA5w39AJk9sDqN4HLm2WTjZKsX55aYSonsZLRoqWHfLHYMyxHKyOfYZf
         9S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743543001; x=1744147801;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VlIrCgN6pRungjnyFFbifkZ4lvEr96sycWjiYg+irs=;
        b=f0yRwAvnU5YnQF5J5JXXy2BgJxU9VW4u7TqCNuVB9DPflGaSiL/7q9qSPUANSAtUl0
         OKdLZjMtnnEIDLYv6aVqrYMSUPKjlgrAL8Gn1Qxg/Zvewlw9iuerCVLQAWUPn4XKwrTI
         i0zIbwIoAn+2PFmOhGqnZqdJ6Ul6fiVbB2QgTM7QfoKr/sJYqvnUhfA8VoqRkPj6takD
         4h7fx12cHJz2ibBpFNMd6QImMWL6VYKeYSnNQd3RplXKE3hEhR502FTJKDjli9HnsJEu
         SEB7Elb8ltjzpt1jUKi6038ncuVUO2OXqpSJ02NDDfrqOPDUsXTu/W8C0yZCPAieWFbG
         hNew==
X-Gm-Message-State: AOJu0YyfjCmK7pQui8mX92XEoBKaC8u0PNLttmfG2t7fwI8zcicKXF+G
	XQcCUuj5ZksLOWiSfMwCy4Qv5d1ZabLz2/5SvfitWFasKLZ1JhfH
X-Gm-Gg: ASbGncv1vHu0l2Girqut933MuB8aEgdAfFYAEugv7oSFd39BHM0A8qUiFD3N58IjsGJ
	Q4EBRNOeFZmQOX805InPcCnYU/1AVBeYz9C51jxqnt8aW/GZeV/TGcpzn1s8wAQVIn1xOJchSbi
	xQ9fJdrTXdSZBJVPM9zkOEcFQiFAvdrq+rhnB6NgelcfT6k1MoOwtrnxZJS9ARPD1KY/ESyxQbI
	Z8dXwwFkwzAyUiVwmrggTNvu+VmViw0ElFeLeZPeTMDwBvblb8KfDaHB2R6Yib0mr61A2pzIt1Z
	dVwVPkXFG7A0BZFH4U1KHlsESNoCRxELbivQxMDQTi6pYDP8TIQS8HYSOueLCMjZMQCsVfR9Te4
	KOdY=
X-Google-Smtp-Source: AGHT+IE0pb5wpc/ATFEWuz5RV7cFzEo7jiZ8CiFMucO9hXqINUU5yaSHZEeBSx9KT2ulT3V2TN81Xg==
X-Received: by 2002:a17:902:cecc:b0:215:89a0:416f with SMTP id d9443c01a7336-2295bea82b9mr66653065ad.30.1743543001227;
        Tue, 01 Apr 2025 14:30:01 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eedcedesm94274745ad.67.2025.04.01.14.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 14:30:00 -0700 (PDT)
Subject: [net PATCH 0/2] Fixes for net/phy/phylink.c
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com
Date: Tue, 01 Apr 2025 14:29:59 -0700
Message-ID: 
 <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series consists of two minor fixes for phylink.

The first cleans up the handling of fixed-link for cases where the driver
may not be using a twisted pair connection. In such a case we essentially
leave it up to the driver to validate the supported connection types itself
likely via the pcs_validate function.

The second addresses an issue where the SFP refused to change speeds when
requested via the ksettings_set call due to the fact that the
config.advertising field wasn't updated when not using autonegotiation.

---

Alexander Duyck (2):
      net: phylink: Cleanup handling of recent changes to phy_lookup_setting
      net: phylink: Set advertising based on phy_lookup_setting in ksettings_set


 drivers/net/phy/phylink.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--


