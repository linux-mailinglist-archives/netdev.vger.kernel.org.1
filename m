Return-Path: <netdev+bounces-129779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4843986058
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F271C265D1
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD9D1A2636;
	Wed, 25 Sep 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPhxRrZ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952E1A2642
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268666; cv=none; b=PXtaAPhYDBtgdxl1PLyvYNsnBLn8exX1v7ZYCoSll6RAzzCqBQDmrlQGcc0CkFWGUETqRG2FGJn4c0t8Aifo/+KKdABalQLyS8HC7HHiJ+dluioHQkvq2Hh1yEWELlnmygYaPEjiBiBbwBiJjerr/F+sV7KBsYD35CQLrCM0k84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268666; c=relaxed/simple;
	bh=Pn4SAkviSEkIOFcV3k/+L7CD0kLTE8APdbr/TYPFQWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fll4RtdsjZYM/UsNVnHTwO7ga2uDwYKtAxGVnFqaEH8rIiArmAqiVIHfEqsyE/0RwcErbQHvGmTyOsCpdSnI5iE817hSEhaveJqP2jDbBE29TqVbZehkk/MuHdlm0ugTppisRRx3cq/ruY53DaRteC/BuUBkVl7mBfwbi0j6kVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPhxRrZ4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a90deec0f8bso71585266b.1
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727268663; x=1727873463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJRe0aE/XPSgOSaWUXWFi7Rt4+XrkIZvwePNRoQDYDg=;
        b=HPhxRrZ4vjyvYGptl3mA8RUrwiVLBviRsWzytgIjVbY57jGpTO4G6qw4k3VPtDCY2q
         dCIEn5H3LT6JdIwHuk3KQRor1+cw+WxquqU2Ii7sVsRGyO6KxqcQVsegIBQNhm8SsdyC
         OAz9h48OGBBb/+6058DbnuhJbcGliv8FRLHZPQqjaqWXHSGI3h0c/b/B/0ryYq6mmft+
         WBwkbiW0w60ThYSHKHZNJ1Ul+x5TYKhKUfJT0q7SWJr9GQydsxAxJnrGrfCZADqWWnI0
         ll9QUTGqLgPB1zG6jfmGEz9odNEMzVbu0QirnuuhU3NE8kZlTBwmW8AvnTu8sllLK6Ec
         2AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268663; x=1727873463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJRe0aE/XPSgOSaWUXWFi7Rt4+XrkIZvwePNRoQDYDg=;
        b=o2YUWjM4lBuqL/4BnUjxb3xrwMW/wMJf0OMjVoeFrnOc/4L4W9/RgMLyeH19Vup5RS
         IV16BlWfTRyEyZrBUbNoMXPId4x1xvyhdDE6rzRDxenT/TOXz1P7ecDOnyOlC1i5icRB
         Cds03PEhEa4SFuMqpTxUWGeAcNu4CHqA/FsQtLmj4HBUVnJVFjhbX8DiP47lx5aqKM5t
         vrTzPuRDmIvky7RHvo4DWHJQe6aHIGHoUF7r4ol2QmFc2zTb0r6jHrvbxRfiPO0UGNLZ
         yerD1LDy03PEFM8/8+tyilfu7EwiYe50vHutOA5T3yvcoX3AxeovVvQiLh/ZgK+aFTiy
         CWZA==
X-Forwarded-Encrypted: i=1; AJvYcCUsDg3BNCtFPF2J4K6ALK4Vz5FkXolFCyGLdAHtnftwzbM0OiXIN6gFTl1my3ltp7nRWGo6KMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaOGjeiGObYEtc6ifymmNh2yfTpst3QDLWn0gp+Fhltwc/eyk3
	GEhI9A4xuNX7p/l92ZKIImy4ulL1m2+ShP0HTTXd5i4wzfFoRVHk
X-Google-Smtp-Source: AGHT+IG0DC/OqgrT7+Qyi3AtTwFkAKGfrsdCwjfCP+YZms3bu/zLabQ5ns5kQkU5a25DHmLym9v+eQ==
X-Received: by 2002:a17:906:4789:b0:a80:a193:a509 with SMTP id a640c23a62f3a-a93a031e18fmr108887266b.2.1727268662598;
        Wed, 25 Sep 2024 05:51:02 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cb095sm203381666b.112.2024.09.25.05.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:51:01 -0700 (PDT)
Date: Wed, 25 Sep 2024 15:50:58 +0300
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
Subject: Re: [PATCH RFC net-next 04/10] net: pcs: xpcs: add
 xpcs_destroy_pcs() and xpcs_create_pcs_mdiodev()
Message-ID: <20240925125058.zsid3cbwnrqxr56i@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjcp-005Nrx-5r@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ssjcp-005Nrx-5r@rmk-PC.armlinux.org.uk>

On Mon, Sep 23, 2024 at 03:01:15PM +0100, Russell King (Oracle) wrote:
> Provide xpcs create/destroy functions that return and take a phylink_pcs
> pointer instead of an xpcs pointer. This will be used by drivers that
> have been converted to use phylink_pcs pointers internally, rather than
> dw_xpcs pointers.
> 
> As xpcs_create_mdiodev() no longer makes use of its interface argument,
> pass PHY_INTERFACE_MODE_NA into xpcs_create_mdiodev() until it is
> removed later in the series.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

