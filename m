Return-Path: <netdev+bounces-129787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8DE9860DA
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FA128703D
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C21318D643;
	Wed, 25 Sep 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngc4nAX+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0D18D640
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271505; cv=none; b=iXvRDMW5iZRRWI1cCMq5cJ5npM5VLr/DN8+yiDr0IGuWGuT9tCZ8Ml5Xf5ohQaKlBjwGdIlGVZolVF6/Kwe9BdcGRCFnigsaTamqODR6tPwE41MdwqljnRa5r2kxwFT8ci/SBwdIEZQ/RrqE+c5IVDusQSRQQkFdpE8r8BdTdDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271505; c=relaxed/simple;
	bh=PdxFPH7xrjhCUYC8R+CuUDoD0V2HYHcOm5HNCp3BtHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVNxnXSH99LJDuhrNeaM9Bpq9bf7FLvMGTV71h7Y0gcu6QShS7/sx85WDJnuK14PPWnQkMV6j9F2L/XMFaUD5Xm1dWLRpOZ0vZfRPrkKrDqE9j+8qZsTqOjmOe+6yBbON5p7dtOYcRzVY9WSjyT2VR1k1aa22dxSAdD75IPI6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngc4nAX+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a7dddd2bdso70465866b.2
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727271501; x=1727876301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jumFeyHQNb3jbXPMZm46Zc7E2u4fD+56kCRyCgQWUes=;
        b=Ngc4nAX+ziAHRa5rkKbyeLlz0Z3CSoS0kYmsQkovu5fhgr7uAag3q6KrANuj/TOdzr
         e8S/x9tzuHFnwVsodqcuzja2iCIjoFm3yGPuOP/55Y/G0fcDqXhXt+o8+XDxb9kwCee+
         zIei8omrsyfAE5JTiCQvDRMcwTxHe2okrbw91Qb15QaoY5rcacOh2egwVMbI+CRHPVbU
         PJ31cLHNLNM96CiqxiWMpis/OyAIPqF6fhRV7ZF1Ncojw4fnV8/LOPQZCDygMl3wEFIW
         yF3CVTopBixCmTbmrWn0UbN78aPgaAb5CmTS9nJWafLaeCT7d35wJUmBiMpVqX+Offwy
         Kdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727271501; x=1727876301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jumFeyHQNb3jbXPMZm46Zc7E2u4fD+56kCRyCgQWUes=;
        b=wqBQJnLA/YTh75CFysiIsuRbnpNnxFE9RnUXDqf8NZ/KBB6ht/BDBjoQEGgRwysete
         FbxuoPVXN9/pAcGLYpPRoOkmuyiVwOP1vldGHrvDTn0oEz9LkbsL5/2w669XWLrCz5M7
         cGYdU+W5tsvUJadVopJVtczlnag9ri4MDQ4HGZmMdlWlwwFOuHXj4BxiqM3rtWQ85pYE
         8/FzxuhD6hpGul28L4pMvHQTGp0HG7SFuPNV+aBLTD82kjTnZJEsUS1SOe6ThNe4t6mj
         2kclPczLliypzJnHEekx/4TynYuyWO0KKoKP/bD6U85lwYhtzF6vtsntcR7ZV+7jEyQC
         D1LA==
X-Forwarded-Encrypted: i=1; AJvYcCWh47ecN0gSjvZtvEqaC78TcHEOnE7LH8+ftDFe90jZ4ZfYYD4On4ZQ2zqA90Sts5BvTnVxx5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZdTljtN1wva1LABwMKfmzD6R9FdsDVWCneBE0FZNevvnrnGX
	t89TbBV7cudR0Ong7C8YwlZuAw1OCyAdV/ljPVNt2ZACGOXKoT9P
X-Google-Smtp-Source: AGHT+IF2htZh7Ei+1/UW/R1vgBmmoGpgMYctzse87AfZCt6nbk9UJZlxDZj2P/2mpqAHyr7RQZAblg==
X-Received: by 2002:a17:906:da8d:b0:a8d:2623:cd49 with SMTP id a640c23a62f3a-a93a061db9amr134422066b.11.1727271501207;
        Wed, 25 Sep 2024 06:38:21 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f78a1sm206539766b.161.2024.09.25.06.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:38:20 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:38:17 +0300
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
Subject: Re: [PATCH RFC net-next 10/10] net: pcs: xpcs: make xpcs_do_config()
 and xpcs_link_up() internal
Message-ID: <20240925133817.csb6o5yxo5i47vza@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjdJ-005NsX-S8@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ssjdJ-005NsX-S8@rmk-PC.armlinux.org.uk>

On Mon, Sep 23, 2024 at 03:01:45PM +0100, Russell King (Oracle) wrote:
> As nothing outside pcs-xpcs.c calls neither xpcs_do_config() nor
> xpcs_link_up(), remove their exports and prototypes.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

