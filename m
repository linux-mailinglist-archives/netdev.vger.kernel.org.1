Return-Path: <netdev+bounces-59693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4172C81BC99
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF00C284CE9
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6D5823D;
	Thu, 21 Dec 2023 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU64dr7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740455822F
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so1882510a12.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 09:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703178521; x=1703783321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaNqsD3vfpNYv/clJGViwl5o4r7/LFlJLKF05UODaCw=;
        b=DU64dr7QyaVYcAxLkywB3VasFjLmqRumlC7lDjiOCqXReKbB7Qn+s3dCH4dfcH2Ic3
         DzD1iyfpJDNUEHD9dEMLPhGzU1vWSKMMvzoj1FDWz2l0/lCe5deYFRZFtT930Q37KT3r
         ZvMdnwVloPLncyZ/jU0tKUahuxg4HM6rbZkEwVcR+4qxzDp6rzhFllHG1NLk1dPCiPGy
         oHAr9RkcBwm1RVn7/9uqGF47cxCM/YPhbINzC3K04jZh4pmw0zk4rNiFGfHa1WcMvgpc
         L9+N42Htp34c9lq0jIp51suhoNGYU+A7E+c+bS0MRapll6JPvpaJhZHthatzkk+aZeeS
         948Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178521; x=1703783321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaNqsD3vfpNYv/clJGViwl5o4r7/LFlJLKF05UODaCw=;
        b=f8laz3ubiRRIQ/7g3T697pvUYl2vrFe68MY0UHNQ1djcUzD9psIcsS2lx/kwLpcKfH
         90n2PjqKBA0zE4BDVtASPnyIxUX/+bcIBBFFAvgreDvSDbIZL7qcFWZ0ISPh2Q71qF0r
         FOg8jmJbQUE3E2k4N6ah6N6xv7eNn0gKGYsbBf60V8djd1oNzgKpD7r0latT5mdZdUPR
         JUGT681gHwCHHudEEYHAwQWMj9JESuhT4zuZBiP6tZAC7Zbgbh98FfD9gTaLIgNQC54K
         enzaWy7YzbIFXQq1kourgW2E9xPeqJh1Ud6EteDaA9A3cEdqQVQHS3ONytHFwEv2271w
         IMHg==
X-Gm-Message-State: AOJu0YzLgN9KZgElzNg8BNtNZgwOydElvdUYt6wNzAeHhVr5CAnDmu56
	eLNtPnXGg5KgoO4t/EAThB8=
X-Google-Smtp-Source: AGHT+IFxBZ8n479zmrxSri2JJkpZxMCFqOzfW+k7d1TblUBtpLQClW7zXnEmLIVgFOhcwqJmcDjB1A==
X-Received: by 2002:a05:6402:1608:b0:553:59fc:b9ea with SMTP id f8-20020a056402160800b0055359fcb9eamr969383edv.20.1703178520641;
        Thu, 21 Dec 2023 09:08:40 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id e14-20020a50fb8e000000b005530492d900sm1401909edq.58.2023.12.21.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:08:39 -0800 (PST)
Date: Thu, 21 Dec 2023 19:08:37 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v2 2/7] net: dsa: realtek: convert variants into
 real drivers
Message-ID: <20231221170837.mn4utavzesq3ahz7@skbuf>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-3-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220042632.26825-3-luizluca@gmail.com>

On Wed, Dec 20, 2023 at 01:24:25AM -0300, Luiz Angelo Daros de Luca wrote:
> +static int rtl8365mb_init(void)
> +{
> +	int ret;
> +
> +	ret = realtek_mdio_driver_register(&rtl8365mb_mdio_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_driver_register(&rtl8365mb_smi_driver);

I guess this was supposed to be a call to realtek_smi_driver_register().

> +	if (ret) {
> +		realtek_mdio_driver_unregister(&rtl8365mb_mdio_driver);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +module_init(rtl8365mb_init);
> +
> +static void __exit rtl8365mb_exit(void)
> +{
> +	platform_driver_unregister(&rtl8365mb_smi_driver);

And this to realtek_smi_driver_unregister().

> +	realtek_mdio_driver_unregister(&rtl8365mb_mdio_driver);
> +}
> +module_exit(rtl8365mb_exit);

