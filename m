Return-Path: <netdev+bounces-153536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA9E9F8923
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 01:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F5016CB42
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 00:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49352594AE;
	Fri, 20 Dec 2024 00:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQPjyPfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628882594A4
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734656235; cv=none; b=UCpYyp56c8+/Ly0OUnlMW0dyMFlscTePlV54w2GlvGNocAr1ZTgMZr6iO45WAE758Y1JXVdrYN+WILmu+M9QxjES8+jc0W8t0IWKzvDwTyURO8GrD6PsSIT4kchARt6EBcUnwV/XCoZ/aZquG50ZziCp2QW4d1wC1NH4x+dJWq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734656235; c=relaxed/simple;
	bh=+oLW6qi22ALTxG9PLhYdXkWWc5OPUPt5Q+0d46IcqB4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rOUXYQlfAD3vS4yoUdBTzttSYz2shmBcaaIQeAaU2YRazymc3TxNRbpUFyrqrRfOCcJ28KqEaTVqKoXAWnWpAOX96lHypT/r3LbrLt7nBIGIi6Diz0gSPzYoVw3A2hF/mzANVFrV+tkFVOo8XNLjDPzHCPgas527dkzFOsrVR90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQPjyPfy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f44353649aso1048923a91.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734656234; x=1735261034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVIU4S8Tx5aVpXfHqtcRwGb3W5YVFzbRy9IUOrLnBk8=;
        b=XQPjyPfyant2dQX/Xo4QpdbquiB2FHoffJvtO3ZXXBWV1aLoHoB8Hax/9QqxfZu/F8
         hai8DY+FfKPw94eB3PwyQz/+pOjM0niK8QNZtLXINRE5nhdZy/ectlvFdFeA7CKYWyPe
         0DYaWxF+EmLxcb3UlxvaAwxcvv7MdGby7fGoOZVE1Sw/SusT3GjQCSylUx5YmxddZCCd
         3XaynHjlPRNbL8OlFCd+ZSjd93GSE8gTp3SqX/jTk7p6uMDQlhvKuwITddSinSSDIDc2
         XtmfTOu6M09rT3LffP5kfCEt9g1yrqP2c3hiR+rxSRL+PFliypsFPpqKPvRPzqCJ7pi6
         iZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734656234; x=1735261034;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WVIU4S8Tx5aVpXfHqtcRwGb3W5YVFzbRy9IUOrLnBk8=;
        b=b/oIqzwwNQksNgC3gh7ETLVkUXL+Vh2HC/lOkwUdv3GD8CepxRzsbI5oO1E1x+Eqqs
         Cjw0nCeH7f7g2es2p007ttSAAXvCr3i67XspC57gaZ/MTVk/llkKqt50Gt1mF5kiGWiJ
         1pTN8UCactfbutOcPmrH00N/oXiAGo1F5rDn6Qz75T3ELXeY1mkmGidMNiBHV0WyzBjW
         /wWfTpVmZm8wwCi12W7hwRT/Zuf6Rvbt8kWjj10AOyYsYye5cuWmxtdDE+EGnZ/g8Lgz
         Y4/wT2Ma4i1rwhPW0Aa5w5SOC5I+ibHbbclU4z92MAW5gcV6LWangDQGjtd9DJtklhKJ
         LuSw==
X-Forwarded-Encrypted: i=1; AJvYcCXHhbKSGxml3/HVqJypKwcR7oseU7DUGBW6Bq9xQk9aWdXIief2K/ccC3klYsa+MVxnDIj8Drw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNUF+QlfqlN7u2GuogLYL1sgUmh1JpQTD5aZInPDbWGaJbtgxh
	OB3E+voWaMCgRyHGO44/J/H3JzJYPVFvWT+dZN3FL3IK8rGfA3G7
X-Gm-Gg: ASbGncvdC2TIZN/21LtKpb1wB5etfaqUMAsjfPYDlm+XN7eLlmHB6QGrVq30qrDTO0/
	lgoKSYGohjwKyI0Ph/CPLWJ5JFNOJjSZ5pZTAIgSyZ1PiK9dL0YL10JDDmfg2nJnmbjXL83c6Ql
	v4d5fnDMSP9ao/FtCBoye9rLL84/DwSjCAS4T2FUlrp5jtZYMk4NM7dTRbiy5Nr7oMIec2gP8YQ
	X2WJI3LWiPpjvA8S5K0OUxtGwzdMxAQIoNe2qfBRojsGh7cwE1iRazrXqVAChEnFeHB4/uKNK/8
	VoS32Wto5BLdIE8p+A==
X-Google-Smtp-Source: AGHT+IHwuaoHZLwcoGFikzV1A2ffWhH9fd3gpSGU2jys0738zniBHj9kj1gkHc/Tb052S08Yhjf4lQ==
X-Received: by 2002:a17:90b:54cb:b0:2ee:ba84:5cac with SMTP id 98e67ed59e1d1-2f452dfd2eamr1652020a91.7.1734656233680;
        Thu, 19 Dec 2024 16:57:13 -0800 (PST)
Received: from localhost (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478aaa74sm2056049a91.45.2024.12.19.16.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 16:57:13 -0800 (PST)
Date: Fri, 20 Dec 2024 09:57:12 +0900 (JST)
Message-Id: <20241220.095712.813534337789962014.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net, devnull+hfdevel.gmx.net@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, fujita.tomonori@gmail.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/7] net: tn40xx: prepare tn40xx driver to
 find phy of the TN9510 card
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20241217-tn9510-v3a-v3-6-4d5ef6f686e0@gmx.net>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
	<20241217-tn9510-v3a-v3-6-4d5ef6f686e0@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 22:07:37 +0100
Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org> wrote:

> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> Prepare the tn40xx driver to load for Tehuti TN9510 cards, which require
> bit 3 in the register TN40_REG_MDIO_CMD_STAT to be set. The function of bit
> 3 is unclear, but may have something to do with the length of the preamble
> in the MDIO communication. If bit 3 is not set, the PHY will not be found
> when performing a scan for PHYs. Use the available tn40_mdio_set_speed
> function which includes setting bit 3. Just move the function to before the
> devm_mdio_register function, which scans the mdio bus for PHYs.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> ---
>  drivers/net/ethernet/tehuti/tn40_mdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I confirmed that this also works for TN9310 card with QT2025 PHY.

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

