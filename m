Return-Path: <netdev+bounces-149559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CF69E638F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF1C1886018
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAC17DE2D;
	Fri,  6 Dec 2024 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9tUFfbg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5617B418;
	Fri,  6 Dec 2024 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449517; cv=none; b=e7XiPKvKlKEG0YJN0zMyVwxf3p7yAZ7Jubd7M8PdsgPGH3JuWANEwPGg01j+nRYbeWaAe5kYbXPTH76TIfekBHXOBLXr/8ES26QQBwUDIfFfFIV9uVBnlSb/Pi0g0atL0ClTNE+qTRz/HdQhdquxj/NObYWTrDaQS4fwA4mMMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449517; c=relaxed/simple;
	bh=h0caQLlQqzGhCPb9mURayuOKsn7HOgiOET5d65osvOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbXOt1wBys/Hn9fpkQXSxK4zflPUPerPYULPNukpD/AhdaT2dCS7gjrPE3LTOym8qRZIU18t5GjiQNfxXHbhf166wwEjxtysRB4KYe523cwjo5Ez0RhS7/RD3bCXXepRU4QjOvozC+3XTtf1Ic/0cmV95nlh5qBRy2Ergsscb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9tUFfbg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee88b57ac0so1284156a91.0;
        Thu, 05 Dec 2024 17:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733449515; x=1734054315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7OGBrM+Ds5/EU59L+lS8dg3ydHTx6BnOQHdjJwv4g8=;
        b=h9tUFfbgzcuxi+5f464ztwix4OAFFqDRtHyE+JXo3T2VkXbneYGfah3tO9OTy38eRl
         THzMVxbFHltH9fofP4ZmVHizalTJDMjvO6N3AAA6ejk2oS0qpk8H+lzGb3Yib08ibVNP
         4clZXz7+jafsUG5c7x4JDFTiNFcPD5MOmlSLwf1dm/jfcwwCIsql05mpO4N024ZIiGBR
         HWVHD+5coKw16SRXe2MaueBCfwNEgule55cSXDi5q7hSZygB2SQxX//yPArq/PsUA4Jk
         9LrdE1VHMKIqdDIZ1jUs5PnlEsQ0LkdkHZlh0ORmaut+wmeqzENM1KFhQCTWG7vY1mBy
         syWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733449515; x=1734054315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7OGBrM+Ds5/EU59L+lS8dg3ydHTx6BnOQHdjJwv4g8=;
        b=hzrALXKJPdpyfKNM2bEi6I1IdnnPffIVfge8vR2CXLoDMEIT+piriKPvpHnlTSF514
         yMfJyMkvkNtUerU1EvImmbpJCOaqe8aebM2Ihq4PoyRnO05aI63ko6dP9my2SJZSVH5T
         TpkwdJApz2mdYAXSLmrSShOqpqYR55DOA/xf/hEmf1Mu7CqZXvYT92bnXnxJws5fw+1p
         9K2soIyhxkQ4JfLkx1wOBiLEL1BRis8Bd0a9vPbf4O8aamQr3Say4OetxnucEBSL0r/k
         zR0ExnWJFDjyYcTloe6bjTG5ZgguYcB143iJEsnvcEOoEtr+gZadBa0MLQrlGrmsDjOx
         5O5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLcW66cGpH6fQhr9ak2R6HU+sz8aR7/T55PEvfZJToOn5e8RCmt0p8586lwtZ+k+gOvDFFOLPFEZzxU7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF++DvJLNi8VN774a7wLq0YLyruodlnn/MLZE9C+ACnH/iZ3dY
	y8iSp67WxUc3wk1g+8B+aMlDvsXQiA+9WUSv9TIiDcaUnYPErEmZ
X-Gm-Gg: ASbGncvuXLpxtm2X6C8+SmUwsLTxcaNOJ0wLsUzwP6Qkary35tslWqMw5hOp4Gw4wxZ
	4HP8oLsPu4FcXNdMrk7p2nhL++6PzpjzskLgbyj4RYsRzotKdtpKTT7jJVfaPXfLjzka2glYD/0
	GfXP+me9vPnJ/qyQIxLv4Bm05/JpMmOkWTKnhunEpSkVZc3YgaGI6aX8j2yY8jyoPv8I1pkQ7gc
	Q+Hg1oZTlYjtrhn6d5gM+redem7DPoeehNVtAhd1bGnmm4=
X-Google-Smtp-Source: AGHT+IHFjL05H9QqEdxBhvGferOk0PgAeiYGY9/70kKdEA1TFewoP80NXEZbHvZ4XqWoW1SHDKN0wQ==
X-Received: by 2002:a17:90b:3f44:b0:2e2:c2b0:d03e with SMTP id 98e67ed59e1d1-2ef68d99261mr2300618a91.5.1733449514616;
        Thu, 05 Dec 2024 17:45:14 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708becesm3962772a91.52.2024.12.05.17.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:45:14 -0800 (PST)
Date: Fri, 6 Dec 2024 09:45:02 +0800
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 xfr@outlook.com, Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unaligned DMA unmap for
 non-paged SKB data
Message-ID: <20241206094502.000062e8@gmail.com>
In-Reply-To: <Z1HYKh9eCwkYGlrA@shell.armlinux.org.uk>
References: <20241205091830.3719609-1-0x1207@gmail.com>
	<Z1HYKh9eCwkYGlrA@shell.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Russell,

On Thu, 5 Dec 2024 16:43:22 +0000, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> I'm slightly disappointed to have my patch turned into a commit under
> someone else's authorship before I've had a chance to do that myself.
> Next time I won't send a patch out until I've done that.
> 
I am really sorry for this, I should have requested your permission first.

> 
> Please use rmk+kernel@armlinux.org.uk there.
> 
So another iteration is required here.
Would you mind me send the v2 of this fix?
I will not send v2 without your permission.

Thanks.

