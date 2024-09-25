Return-Path: <netdev+bounces-129775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48FC98607C
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C145B2DAFC
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1717557E;
	Wed, 25 Sep 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl3aQnM2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397319ABA3
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268251; cv=none; b=ix17hSsvAQ2okF274bq1FrHlVS/TgVRdw6LR98wDC55VEjVQ67Komm8wlz+ty60I8S7T9TFwdghqgiuj9AHjy4sMV+Y8MhI0THdQMvDvYXMJ2iRJCrP4noT1CO5H3Ii+wxBa9tkz+YOqta3YgNmW92xW3ZsNpEMvcAJNiQsbIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268251; c=relaxed/simple;
	bh=wrcDLKG8/ZlfO5zneBPAoRuT4T9QZDkBA0YyDLzfG/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9diGr6J76GbiNmBBKc/fsLWd9jPg+gSZpb8Vv9duwgLx3OE0v+8T6p0F3LKmj81cSGmKwGKZjvGXgM7smMhcjIcDXlLhR209PgDlIims2fgtNKojw7zfwuRE7UuveWdeA4LminMXoalc1oj0dmEzKORl3E6vDMkbtfLLCtE6k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hl3aQnM2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37a43ea8285so342792f8f.3
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727268248; x=1727873048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Eo83E3rr21/cKLc/zAZGOD/iRD2paKfELWeccpaaQQ=;
        b=hl3aQnM2ZDnrEmT2aJAHO5Uob9MiF+rDdjzpYfiUo+L28LGXcZc0JbPHNzQNt49wgc
         WTmVLTJPH6gx6dogk7MPY3OnIUwd7kNlOQsWEWdJJZdSUFWq8xUGmSLk+suSg+RRVx6m
         J+GDPdhxpB0S4W1+UXyacW1g6ZVCnEAwBbZJq2pqi2mOXPxXcdbL76JhOdJfPZ0VN48I
         Y/+0r2LO4mhoo8gJ4QpoxwbLp4RX0mEbdLFZFwn1BFYprGQBuqji0tRkiUIdebmP/lus
         Dj/iZEOk21cKXYHqi1Nh8kA7eYmDO3pZGRieEyzimRUNV03FzA4p1hiZERnvgNJboHU6
         tPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268248; x=1727873048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Eo83E3rr21/cKLc/zAZGOD/iRD2paKfELWeccpaaQQ=;
        b=X7GQVDliIW/VEmL1V3zM1InTtSgbnxFG2fRgoWJETRVGXqfP3NXRF+/j9oQSjDT7t1
         6p42q3g4+QMcaMrbmdz4zI6We4wCR2lFoAVAA/5Wv2ilxfOEt/bV5TAzHIDVwi5j7Wqi
         7WXt8aurmvTgHiO6O3OOxHGHu8AYxha4NfYYamt1LnfSA/0v0F6myNo8a97LMClN+KZL
         yZ4o3+1LvsvzqjIAP4VU9lIrniRNUQKB/U3l0vUjC5reA1bKeMxh+dwyd2p2OMst+aOA
         1v0VJsKm4KeeyfVxaF8O1fhOUrUXtfNlP+SQrqJqXxAZtadALqR2L7tWNlrp8ACeBd8H
         9I7g==
X-Forwarded-Encrypted: i=1; AJvYcCU/rKrHxXbJNb/pXrNY1ja3OpviGBVmuMTodmXlWCPRiBJROIJofKwzCNrpz94C5zsfjzurucw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd4f3VdZmpQ6VWpe6Q1XwLUwsxbuzCwMBHlo0peCqs5NoE8y1f
	tyr+4USDMK8udGaY0x+4Bh4/v3pSdo8yqQT0NFcnpCJUT35JOWQQ
X-Google-Smtp-Source: AGHT+IFfS7vhUVhrpQ9ElZSkjpzVE5QUA1yIAFxCnd7J6P95GWbU9JMpyPawsb2SPEgug7UuG0NqYw==
X-Received: by 2002:a5d:5f85:0:b0:374:c8d9:9094 with SMTP id ffacd0b85a97d-37cc246852fmr1068284f8f.5.1727268248129;
        Wed, 25 Sep 2024 05:44:08 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4d74f9sm1856930a12.80.2024.09.25.05.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:44:07 -0700 (PDT)
Date: Wed, 25 Sep 2024 15:44:04 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <20240925124404.djjy7e4jhovhbwgt@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjcZ-005Nrf-QL@rmk-PC.armlinux.org.uk>
 <E1ssjcZ-005Nrf-QL@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ssjcZ-005Nrf-QL@rmk-PC.armlinux.org.uk>
 <E1ssjcZ-005Nrf-QL@rmk-PC.armlinux.org.uk>

On Mon, Sep 23, 2024 at 03:00:59PM +0100, Russell King (Oracle) wrote:
> Move the PCS reset to .pcs_pre_config() rather than at creation time,
> which means we call the reset function with the interface that we're
> actually going to be using to talk to the downstream device.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # sja1105

