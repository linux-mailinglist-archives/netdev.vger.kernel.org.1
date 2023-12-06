Return-Path: <netdev+bounces-54539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB5F8076AD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5061F21138
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF0B6A003;
	Wed,  6 Dec 2023 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhaYWZnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9849D40;
	Wed,  6 Dec 2023 09:35:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1b68ae40f0so106754766b.0;
        Wed, 06 Dec 2023 09:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701884146; x=1702488946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EC1WbkFRMsdQ89+qHvQLwas+YHcOCsKWIhN5BFKA96U=;
        b=RhaYWZnX8sOR8h22kBnXdtWbOft+EFENGLG9qbbjhHg4ymUVvw/bUIv2Ug1qfxRGzy
         z0JQI8+eB60L0howrLEmAxP2wxD2zkwMr66F+7MXjH34PiWOE6ogZS8NRtwUvonGinQn
         BRSGLZf39BZTKijJZ5kTJw6YvqmF+42G9TAos37rLX7batNkDzAf86gqmYRJdFPylfjH
         8f9dJYWAddwzEH39Lx+siJlUsIANuiGFbRg63YvWl4iJ2BJvDkKteFpk68ciXxY7FSF9
         0q7Ha6ePVza0SLu68suDqJzKOtuzuWJfOap47dwanezBFLUvwaGSl0qTGX+fNyQ3TKbr
         xcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701884146; x=1702488946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC1WbkFRMsdQ89+qHvQLwas+YHcOCsKWIhN5BFKA96U=;
        b=HdUXIguMEoxAPgrMduYqy4mWdGvbKgqiK/vrfM5jtHK9tPABCl02NL34l9FXnmAwdy
         gfXkF6j74n3+VXt9UYVS0Wal0J9dbjCqYHkayBYfCWvx+m/hIPZlr2iyEQCi35puScwl
         1kFP1i7rfhxOTqXBSKw9kV3wG6D5HKsRZx+YMiOKszg/6IPDFKnidrMxpNP0TNEOajFH
         75tg/aah7AYCdOIayn68N2v9JFmE4tt6f4jVvRsgtBO0H1+tNF84Hln4ni2M96g2Wqf6
         lCS1y1vgOtXwDOlD9tGcF5jtj1bB3oX1yXdQr3FGEwYedcF+ipz6sONRFKQDPuTZuBbm
         R2Cg==
X-Gm-Message-State: AOJu0Yz4iJIafYLVQYOXYKS9Z0iipQTe+lAmeI/GHDw48OTFO75gQoN3
	vgervg8G4YtrrDx5jFwctuA=
X-Google-Smtp-Source: AGHT+IGO9sy5uIvQAC3Jsj07vEO0n505zT2A58UYp9VCUw87HqhnGeJ3bQhrKRYGtOPuCMW2BXtktA==
X-Received: by 2002:a17:906:2512:b0:a18:e27a:6f05 with SMTP id i18-20020a170906251200b00a18e27a6f05mr891523ejb.22.1701884146253;
        Wed, 06 Dec 2023 09:35:46 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id md10-20020a170906ae8a00b00a19084099a4sm213464ejb.16.2023.12.06.09.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:35:46 -0800 (PST)
Date: Wed, 6 Dec 2023 19:35:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Madhuri.Sripada@microchip.com
Cc: sean@geanix.com, Woojung.Huh@microchip.com,
	UNGLinuxDriver@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Arun.Ramadoss@microchip.com, ceggers@arri.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: dsa: microchip: provide a list of valid
 protocols for xmit handler
Message-ID: <20231206173543.ag7xb4vhcjknyiyv@skbuf>
References: <20231206071655.1626479-1-sean@geanix.com>
 <DM6PR11MB4124D98726836442169C2C55E184A@DM6PR11MB4124.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4124D98726836442169C2C55E184A@DM6PR11MB4124.namprd11.prod.outlook.com>

On Wed, Dec 06, 2023 at 05:22:55PM +0000, Madhuri.Sripada@microchip.com wrote:
> NULL check is missing here.

Don't just leave it there, also explain why.

