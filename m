Return-Path: <netdev+bounces-208487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AFBB0BC56
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8600B16A70A
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 06:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78721CC43;
	Mon, 21 Jul 2025 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK4edTtL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892AE56A;
	Mon, 21 Jul 2025 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078100; cv=none; b=GadFXCRbDrIxk2h7ETAS8WgrqS0RAiCT6O18fOmRuBmUn+gE7xRoGS069vQgVBMn+XfTLYXTuZhd9V/I1aaO8tUmy5h1DUTnETcFFLmszei3A3yQHKYqDl+SMMFHYYipZBfP7vsN+ZfMTZ21ewknIKxlEEeGst51A0soosN3TDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078100; c=relaxed/simple;
	bh=tQyDCeNk+esbjv+IqTj3Z13IoLiJcKtnHpQTCICA4I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnEVO04cflloX2wfZLm5oOzo5J+MD5oZAJpgBorXuUk8g9ukOsZdDGQyG7wKWcgNMUmbZ21PARz4lrlFB6ybgwujSBDF38a2mYFVFuARtADIDuroLC8ZmYynUi3WRIzX7OOFHVNCnanNkr7p+G4IidIYLnUK261fH9r6otxCyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK4edTtL; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b34c068faf8so4046243a12.2;
        Sun, 20 Jul 2025 23:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753078097; x=1753682897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnhDRdeQAm7rNxq/uyqQOkjkXuYO17vsdGBSb9Iuq6A=;
        b=TK4edTtL9dveihCNw583J/esDgEHW8xUCdBpIzVq1thasGaevDxX9pnSNyBeeOGCRx
         XZ+8nGYzFLC0Gl6PZTwvZJW9v775OqD19btPIryzxvrDJk2xMalpmYzJ682jD+xywid/
         dK1JqQVMFKVqiKxBL478FJSO9Fwnwyujmzi9TPCkPg153o7H2fOkHtQHIgNG5s13k2tI
         Q+BMX7N/mPvTK3FiUcNH0Lhld9DlZa0o430lJKVaSUHGLQd/P/14m2ccbjJsbLVDU79x
         EljvVA1PGrdsNWdgOiXCwTjUqFQ4T7ukVZHIM4mwmwNyqAqOTEfgHej3tshNEMcXsn/r
         UNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753078097; x=1753682897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnhDRdeQAm7rNxq/uyqQOkjkXuYO17vsdGBSb9Iuq6A=;
        b=qbgFoxwKg9dEGZIR80jdxjzVt9X2xaYOZULykcbttF7y/hGEmCfF1msXNqkyoxxo9M
         nC6T4Ghvni1SuP8B2FwK1MlT07PSYGh6DtV5snzkae2Z8mUJO9V+Pi77FsUu4M5GZNPU
         j/nsuLne8fmoAWVYVKhExxvr1OqmaZ5Lxltn+WG1mUzRQPfej/w4chD8jQFrG9zGhAUE
         RR13cDi+sz/It7W4mrQxGGjw8Sb/0gqs559ihH7ohUIKGKvtQKoFzV7aQDNEUWprhAsN
         h2a5G8Xenn0EGJXVH6ZkveeDWXanuKzK4CZIeUGedEn2wPMO7eVc2rTa/0Mi4r7qheHY
         HOcA==
X-Forwarded-Encrypted: i=1; AJvYcCUDNvOXrjTXLIeNqFxzmH277s/ZBmV1GzMwgJYPutp81GBQgigwkjoywTYlOZjBg68fjEJKsFT1fa7dmBw=@vger.kernel.org, AJvYcCVWuLaKDqmzYQNptXB2lKo8v/xGS1eVlInwe6SQGbB5ordiwjZ8vXQ36I+ic2iRLJn1gLM62z6r@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw7YprJN7tNBtP3bJZ6mjIYdi5xJGkQ7tZl8tlKwYXp8ttRhuy
	248u2Dyb4BIrWWlzzkTEinaIuCETzbMsFfECdAm/2MRSnvnQAAzG/2Em
X-Gm-Gg: ASbGncsf9qKah9XiDaO35CsT+6tf7c+cZGMdPyxpNocqk3vrk2BgaWlxd/DsVVvDUKQ
	VA+oQvT8wU+EjELJ/KYyD8q1cg9pC6u9WBnPzpem6mCUU4fBzCy1PVGMZcbdJY2ZrLqFOYSrUR2
	iVqov8lCl3sSR7pt1FuWwLNxKUaL0UkSOExhQzxFGNXzjvWbBVooZZDKBUIB6N5zfsrA3YKdYBw
	LYYeRrG35iQ5rnlwJlVRejYBX/4l2DUTgubozXDC6p3qOwwDopGJt6T8IXpbR96j7oXbiGj+gog
	/vCLp4gdZ0fSFScPn6sqCxiNVyh1Opsh0Y7HGtDPSz1qm1T4wkTrmX1BKQE0Y2MIyEEXh20NSmI
	uoHKpXk8xdXqzPB1/Aaeacpr9gXlAzlBw/im2MAnqGCSPltqiQDLBaf4xCi01GoFiZOy+
X-Google-Smtp-Source: AGHT+IG4LFsKdSAxUyGYcdBLHWPqsS44Ihlke7hwUG+8EO2HLncOyCOUNSDC6c+xStUUL7OxvhjbFw==
X-Received: by 2002:a05:6a20:9389:b0:234:e900:4fb7 with SMTP id adf61e73a8af0-2390dc2f767mr22581011637.24.1753078097143;
        Sun, 20 Jul 2025 23:08:17 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-98-199-117.alshamil.net.ae. [86.98.199.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc6c16esm5076008b3a.149.2025.07.20.23.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 23:08:16 -0700 (PDT)
From: Abid Ali <dev.nuvorolabs@gmail.com>
To: Abid Ali <dev.nuvorolabs@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Fix premature resume by a PHY driver
Date: Mon, 21 Jul 2025 06:07:57 +0000
Message-ID: <20250721060802.9030-1-dev.nuvorolabs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <47495a5b-a3e5-44da-993d-5a7d3c19bd5c@suswa.mountain>
References: <47495a5b-a3e5-44da-993d-5a7d3c19bd5c@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dan,

On Sun, Jul 20, 2025 at 21:09:19 +0300, Dan Carpenter wrote:
> smatch warnings:
> drivers/net/phy/phy_device.c:1852 __phy_resume() error: we previously assumed 'phydrv->resume' could be null (see line 1849)
>
> vim +1852 drivers/net/phy/phy_device.c
>
> 9421d84b1b3e16 Abid Ali              2025-07-18 @1849  	if (!phydrv || !phydrv->resume && phydev->suspended)
>                                                                        ^^^^^^^^^^^^^^^
> This checks for if the resume pointer is NULL, but if the resume is
> NULL but suspend is also NULL.  I'm surprised that the compiler allows
> us to write that comparison without adding parenthesis.  I thought that
> it would complain about && having higher precedence.
>
> 8a8f8281e7e7a8 Heiner Kallweit       2020-03-26 @1852  	ret = phydrv->resume(phydev);
>                                                               ^^^^^^^^^^^^^^
> Then this will crash.

yea, there is an obvious error here and have pointed it in the thread.
I have not gone forward with the V2 for now as we there are other concerns
thats not easy to address.
LINK: https://lore.kernel.org/netdev/aHu6kzOpaoDFR8BM@shell.armlinux.org.uk/

For now the idea is to deal with issue pointed in the commit in the driver`s
resume callback itself.

