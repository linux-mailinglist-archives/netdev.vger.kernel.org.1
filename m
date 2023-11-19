Return-Path: <netdev+bounces-49049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6697F0833
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 18:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB06280C47
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06DFDDB0;
	Sun, 19 Nov 2023 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCi+O8RQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B75992;
	Sun, 19 Nov 2023 09:55:57 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c87adce180so9666321fa.0;
        Sun, 19 Nov 2023 09:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700416556; x=1701021356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VraNzXX1s89jJsaeErTb642CPhxkjKjIEcqW2csEjNA=;
        b=VCi+O8RQBeYEjwSfBZHJTsaRKaXJe7BDY5e8osh85Tln2i8IJMhDoEUDNE+otq8eo+
         oFnE3X4uG8eM8F1w6LQ9kCQePEINK4KDWZ2gdK2zEj0+jS6XCRadRNdGxUuvo/jKpKwK
         +fM/lEkKu+yrEcGVj58+sTf3Ro6o7bJr9FICz6VtLF5Rbjx2YLiApzpa8OtZ+2xtKhYM
         +MERoVaVA1XM5Cru+AJspQmBHFFXkjFyAyfVlnBnlhuKi4bAY5IrJO7i6OQ7omqsCRlC
         ASNjD9OrzTvP6jHkAOQYrGWLPDB781HhaEtZbgGO4FsNhFCzea4jSGa7jr0+BanuqyGV
         md5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700416556; x=1701021356;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VraNzXX1s89jJsaeErTb642CPhxkjKjIEcqW2csEjNA=;
        b=r7FrfvXZBplJ3tgqySQQjnOVx/wZmPpeeUwpxNZBMLZ2qjH7h4xqTNrR60lsRKChKd
         qtg2RKJAlKhaFGn+G2Cvj5N27r1IoENAI97eXGIdlS81oDtBL0PTEG3KzK8zJ5mNO0/U
         AXMj6pxn0jI7CyNT2o0PkQCKiGr4y8mNx40abXMiKg5l131a4sCCtce3RGYZjmmFeUra
         QCeGPJkK1DiE3WpZH82oh2u6lj6lrYEaQAldHt4UW69QKMRoT4r2zqB9Qxf2W0k3/xWM
         /85DcJ04DVl4/ej9dfZ8nO8sX8by0lDvvExGP93+qYXy5hrsbI+haoWxMn7vL9Nm4DVs
         bGCQ==
X-Gm-Message-State: AOJu0YxmEDVvQWHXjKBHDADKbNTa2GDXEK498zWKH6A3V8QJElBJ0qOb
	56aO0P8X7RJhrK2WL5wj3O4=
X-Google-Smtp-Source: AGHT+IGgu10IQwTu+zTi/MTqlt+k+z8Jiv+tSG/OcaxjZ2N246urtxC/simwmc0ucnLnbfKMaWvmkQ==
X-Received: by 2002:a05:651c:124f:b0:2c8:7132:d398 with SMTP id h15-20020a05651c124f00b002c87132d398mr3106547ljh.17.1700416555007;
        Sun, 19 Nov 2023 09:55:55 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d4c92000000b00331424a1266sm8599729wrs.84.2023.11.19.09.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 09:55:54 -0800 (PST)
Message-ID: <655a4c2a.5d0a0220.ead80.bb5d@mx.google.com>
X-Google-Original-Message-ID: <ZVpMI1qAEGzklvVQ@Ansuel-xps.>
Date: Sun, 19 Nov 2023 18:55:47 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [net PATCH] net: phy: correctly check soft_reset ret ONLY if
 defined for PHY
References: <20231119151258.20201-1-ansuelsmth@gmail.com>
 <5d35be32-58bb-465d-91d9-ca3e8029373e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d35be32-58bb-465d-91d9-ca3e8029373e@lunn.ch>

On Sun, Nov 19, 2023 at 05:24:00PM +0100, Andrew Lunn wrote:
> On Sun, Nov 19, 2023 at 04:12:58PM +0100, Christian Marangi wrote:
> > soft_reset call for phy_init_hw had multiple revision across the years
> > and the implementation goes back to 2014. Originally was a simple call
> > to write the generic PHY reset BIT, it was then moved to a dedicated
> > function. It was then added the option for PHY driver to define their
> > own special way to reset the PHY. Till this change, checking for ret was
> > correct as it was always filled by either the generic reset or the
> > custom implementation. This changed tho with commit 6e2d85ec0559 ("net:
> > phy: Stop with excessive soft reset"), as the generic reset call to PHY
> > was dropped but the ret check was never made entirely optional and
> > dependent whether soft_reset was defined for the PHY driver or not.
> > 
> > Luckly nothing was ever added before the soft_reset call so the ret
> > check (in the case where a PHY didn't had soft_reset defined) although
> > wrong, never caused problems as ret was init 0 at the start of
> > phy_init_hw.
> > 
> > To prevent any kind of problem and to make the function cleaner and more
> > robust, correctly move the ret check if the soft_reset section making it
> > optional and needed only with the function defined.
> 
> I think this should target net-next, not net. It does not appear to be
> an problem which actually affects somebody using stable kernels.
> 
> The change itself looks O.K.
>

Ok to resubmit or should I wait 24h? (asking as it's a very simple
change)

Also is the stable Cc ok?
(that was the main reason I added the net tag to this)

-- 
	Ansuel

