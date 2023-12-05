Return-Path: <netdev+bounces-54027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFD3805A8E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC02A1F216CD
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5F60BBB;
	Tue,  5 Dec 2023 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5VS9852"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F2D41
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:55:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bf37fd2bbso3562386e87.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701795344; x=1702400144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ikDA3R/+q358DUcNH1/anjWIWcQOxqbfd+f2yKZKvf0=;
        b=M5VS9852HUZpW35mrTGs6Ox1SifPOInidtYMVq+diYpmkNAqyUj0WBHlNeRBXyzJmA
         IjHytk890mj2EnNnWiKpZfjAo7kb3HbB5v90fM/kot1VQAa/vf2EqvHkIvJxdUnNFNi8
         FyCgK1tLhRkOwdBw69Idd4xGt351ddwCY/77TWtPcSU/uSGyBYNSSduRt3677UNvIA0w
         kqkNogW7Fh+NsP90qGb/z66m518RnAMSce1PPZ9KMK6klzgsmcYV7qN/PtNf6uzP4+VV
         je0lwcv1dD2hCikF7iyCwy4XtYUTuC7hGUSMbwngxQwRsmaDpZhjObiQmxxrsEEGsbP+
         DW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795344; x=1702400144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikDA3R/+q358DUcNH1/anjWIWcQOxqbfd+f2yKZKvf0=;
        b=WtbIV+wY6xHBFgTEt4EZCT5rMHR7p56TA798ZjO95fab5fzoga4blpTDglRldI2qSJ
         4cYpviKmnxW672E0CwaNJCz1+6zT+jqTszQznO9JkoCDjJsdef0QizcuLra/H5uot+Zq
         fk/L5BSN4VeKS9UlMU85AKKztqrXI+X5620VK5Xvg2hGyS7EBSsUBrz9PAdTMgGggMUg
         oX0AvXdJX38ha+W/s3ApWXckGYnJXPOA4/YLR38FF8dp7CKtZJs9B/ek6MdJt40BDT27
         6Ar535TfjcsrZHPlrhblKDnkC9dU1VS53GICpxmzcWZrpdVSODRoJi+XEsEzWORLAzCH
         dPOw==
X-Gm-Message-State: AOJu0YwcMNQVXn+ovaHDq5Ys+3ybixXnjuaBP6Ber4hpEcLPT9Yjg/n8
	6/mmR6SX6tWlMzOW057tf7U=
X-Google-Smtp-Source: AGHT+IHAYR4ULR8frF0+mQ/X1sBmRSM3SJN8dLo2US1KR9hVtk6SYekySlI499NMYqQ0aWJ1LuQvBg==
X-Received: by 2002:a19:700d:0:b0:50b:f776:1d63 with SMTP id h13-20020a19700d000000b0050bf7761d63mr1855394lfc.44.1701795343500;
        Tue, 05 Dec 2023 08:55:43 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id b17-20020a05640202d100b0054cb316499dsm1310502edx.10.2023.12.05.08.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:55:42 -0800 (PST)
Date: Tue, 5 Dec 2023 18:55:40 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Danzberger <dd@embedd.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
Message-ID: <20231205165540.jnmzuh4pb5xayode@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
 <20231204174330.rjwxenuuxcimbzce@skbuf>
 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>

On Tue, Dec 05, 2023 at 09:00:39AM +0100, Daniel Danzberger wrote:
> > Is this all that's necessary for instantiating the ksz driver through
> > ds->dev->platform_data? I suppose not, so can you post it all, please?
> Yes, that NULL pointer was the only issue I encountered.

I was just thinking, the KSZ9477 has internal PHYs on ports 0-4, and an
internal MDIO bus registered in ksz_mdio_register(). The bus registration
won't work without OF, since it returns early when not finding
of_get_child_by_name(dev->dev->of_node, "mdio").

Don't you need the internal PHY ports to work?

